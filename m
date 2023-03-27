Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE766CA9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjC0QBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjC0QBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60707659E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E42F46136A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE07C433A7;
        Mon, 27 Mar 2023 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932856;
        bh=u69Tg1vdhRZztJGiueD2tMeEsNcJF/AVA/Gcuwho7Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9sFA8/7euAUx/U00p8kXj+DzpvXxXElLAYtrLNsyf+VP/iQWZsdLAt8Qwu0XaJNH
         TxHgm5nbvc8dBKA2gh2kcYT7mlqCHwLCKedOZe9VuPZMEr6jqHTKtaNSQtyUTKZMFW
         +UAHxmvcdxn+WoTt5gbwCHWCRQvZCLBcfnloCe26Km1AgLIGuJLwnmAlm4y9Uo6vH2
         WW1C8nAHkmp7NmFuDpTDyk/Q0PLWnU3d3LaTHqDRh3VHM7AMYj0bjf7LR2Zn8JUP/1
         n563m3/LNTN0axjJBXYCHiGCF5EM44y9o6oIl1UB6bLeuJV1DQWXm0wdnrvx8A9snu
         CJg6hplRTKZfg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/5] objtool: Add per-function rate limiting for unreachable warnings
Date:   Mon, 27 Mar 2023 09:00:47 -0700
Message-Id: <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679932620.git.jpoimboe@kernel.org>
References: <cover.1679932620.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unreachable instruction warnings are rate limited to once per object
file.  That no longer makes sense for vmlinux validation, which might
have other unreachable instructions lurking in other places.  Change it
to once per function.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 4 ++++
 tools/objtool/include/objtool/elf.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 73dd091c0075..67a684225702 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4557,6 +4557,10 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		if (insn->visited || ignore_unreachable_insn(file, insn))
 			continue;
 
+		if (insn->sym->warned)
+			continue;
+		insn->sym->warned = 1;
+
 		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
 		return 1;
 	}
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index ad0024da262b..a668173a5869 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 warned	     : 1;
 	struct list_head pv_target;
 	struct list_head reloc_list;
 };
-- 
2.39.2

