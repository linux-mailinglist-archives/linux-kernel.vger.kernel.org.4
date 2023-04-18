Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3849E6E6E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjDRV2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjDRV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D031CAD3D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2D863964
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5146EC433EF;
        Tue, 18 Apr 2023 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853281;
        bh=WeuYulFAOo3QWy7DY6IxPDrEghLxpSGlZTD112qJl50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSNHEHguFD6YyAWfQ1wYp/ylJAjG5fiTRuh7fOWDkzNzkgh+Q3fh5sLhjuQLjvCTH
         Re3o6PhjPw1ZMz9QD99L8IcERE5fmgEt4d3mEH/yuSU2XzkgMdcj6bUYo6127sa98e
         YfWiPt4fGvcxYvxqyMwTuuoH4XAhnjc0iQnIoAGvIfYtgwT97yAiM+hB2Fa5NaABk4
         c8Rz69VKES3JUape+FBypFBHjWURpa8Bx30tL1FCoFMmKvhhG3uM1SdXbLyhkUdtck
         oLB1TUFK0fWzWv7V/fgP8IS5c7EOEt18JEzcaKoIUp2WOrJDA+a0xmQu8uvmeA+Dlq
         OWvmcRvRCmAXw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 6/8] objtool: Remove superfluous global_noreturns entries
Date:   Tue, 18 Apr 2023 14:27:52 -0700
Message-Id: <2725d7f2ccc2361c6903de9ebaa2b5bb304f7ac2.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
References: <cover.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lbug_with_loc() no longer exists, and resume_play_dead() is static
(objtool only checks globals and weaks).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1cace399d32a..2047a6d5339b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -217,7 +217,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
-		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
 		"mpt_halt_firmware",
@@ -225,7 +224,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
-		"resume_play_dead",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
-- 
2.39.2

