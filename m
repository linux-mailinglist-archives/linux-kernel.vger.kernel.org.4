Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA96DFCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDLR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C0A3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8746112F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C01C433D2;
        Wed, 12 Apr 2023 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320583;
        bh=u/d+SjuZhierU9Gg0DcduPo+2fpMD4JwgALDlLtr1jg=;
        h=From:To:Cc:Subject:Date:From;
        b=b01YoJguEXeYSdygNYJT0O/VR7LIXY5NqTbef7/oMbXS8v3gXe3di/Jalb6C+/pHx
         SeeFI7wv7+qyykzvZzQwvJn7arChJ4kmo22R4wufDr6tu49fsoVGJ7bGpVxV8Tb95p
         m5JdQpZlUlhN9Nd8NWXScaIASCMk9ezlSfmoYinclupZnkKJJjn03Vi1rUPsqIX3T7
         4S+rEFS2liUvycoHjUAsFhQKpmVcj2sPO6AeXcnTekseZS9pUdIowOM1obuCTrQuBn
         qbN9QERkdtvpHdCuR77O0KuMjWLCUf8/+s7DCdsaCmgDmtBdIOtlbylXsmjlTUba+z
         DAC78763LaPAA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] objtool: Add stackleak instrumentation to uaccess safe list
Date:   Wed, 12 Apr 2023 10:29:35 -0700
Message-Id: <42e9b487ef89e9b237fd5220ad1c7cf1a2ad7eb8.1681320562.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a function has a large stack frame, the stackleak plugin adds a call
to stackleak_track_stack() after the prologue.

This function may be called in uaccess-enabled code.  Add it to the
uaccess safe list.

Fixes the following warning:

  vmlinux.o: warning: objtool: kasan_report+0x12: call to stackleak_track_stack() with UACCESS enabled

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1afe65..34bd6a11bddd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1278,6 +1278,8 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_type_mismatch_v1",
 	"__ubsan_handle_shift_out_of_bounds",
 	"__ubsan_handle_load_invalid_value",
+	/* STACKLEAK */
+	"stackleak_track_stack",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
-- 
2.39.2

