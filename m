Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA76FBDCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjEIDzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjEIDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E44C3D;
        Mon,  8 May 2023 20:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E3262425;
        Tue,  9 May 2023 03:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89686C4339B;
        Tue,  9 May 2023 03:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604501;
        bh=tU2A4wj5lvfjaL193dHua5J4mUq9RDcdrukuxdAY/Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xk15pnZUEaVRIpSe484Hb6KRvXX3F/qOjEVzlqreCx9cvP6/vGWBMo1outp67KjnA
         G2fLL7YSt6hfLObxY5az4VpXDZikZPlvs2kTtaw7TVDMzRc4xYj1/Tp+jmRdrZmHW2
         SHn4ldHKpUPkjLeikJLAPqZODJHWcN5oH+KpKN2ehyjs7aGCdUEPZ2/Bk5iwoJaMJ8
         PutTNehmhUWsRinwlipY4qRQTsb7bF5g6+jLSKJfKGAle6LSKESCmrDeFoa048mYTR
         MBgYa9FXnHtN0sW1sw0BBhEauH/QFt1U0v4LYEul5P5EtWCVTDmIv8O4m7zwxe7z80
         EJQxROQKJ2wTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.3 3/7] lkdtm/stackleak: Fix noinstr violation
Date:   Mon,  8 May 2023 23:54:26 -0400
Message-Id: <20230509035455.59524-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509035455.59524-1-sashal@kernel.org>
References: <20230509035455.59524-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit f571da059f86fd9d432aea32c9c7e5aaa53245d8 ]

Fixes the following warning:

  vmlinux.o: warning: objtool: check_stackleak_irqoff+0x2b6: call to _printk() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/ee5209f53aa0a62aea58be18f2b78b17606779a6.1681320026.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/lkdtm/stackleak.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 025b133297a6b..f1d0221609138 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -43,12 +43,14 @@ static void noinstr check_stackleak_irqoff(void)
 	 * STACK_END_MAGIC, and in either casee something is seriously wrong.
 	 */
 	if (current_sp < task_stack_low || current_sp >= task_stack_high) {
+		instrumentation_begin();
 		pr_err("FAIL: current_stack_pointer (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
 		       current_sp, task_stack_low, task_stack_high - 1);
 		test_failed = true;
 		goto out;
 	}
 	if (lowest_sp < task_stack_low || lowest_sp >= task_stack_high) {
+		instrumentation_begin();
 		pr_err("FAIL: current->lowest_stack (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
 		       lowest_sp, task_stack_low, task_stack_high - 1);
 		test_failed = true;
@@ -86,11 +88,14 @@ static void noinstr check_stackleak_irqoff(void)
 		if (*(unsigned long *)poison_low == STACKLEAK_POISON)
 			continue;
 
+		instrumentation_begin();
 		pr_err("FAIL: non-poison value %lu bytes below poison boundary: 0x%lx\n",
 		       poison_high - poison_low, *(unsigned long *)poison_low);
 		test_failed = true;
+		goto out;
 	}
 
+	instrumentation_begin();
 	pr_info("stackleak stack usage:\n"
 		"  high offset: %lu bytes\n"
 		"  current:     %lu bytes\n"
@@ -113,6 +118,7 @@ static void noinstr check_stackleak_irqoff(void)
 	} else {
 		pr_info("OK: the rest of the thread stack is properly erased\n");
 	}
+	instrumentation_end();
 }
 
 static void lkdtm_STACKLEAK_ERASING(void)
-- 
2.39.2

