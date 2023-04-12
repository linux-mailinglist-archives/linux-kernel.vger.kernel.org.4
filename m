Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF76DFCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDLRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjDLRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CC82729
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9718637C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D88BC433AC;
        Wed, 12 Apr 2023 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320255;
        bh=PX0fLdA8IAgbJJ5QVSIRQQaQAaqC5FcGk2sQ9w9igC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLf47uQlDla37yzgOud/SwN71Lt30pJA4qAFFnzDAKXVX0/sUQWPIokzGctf7H+Nr
         HLxKShf6gkXywWFkR/i+LRfOe7kBTA6N04AajQUkt75OBc06A6K2qI6Nk3bP4mVdt/
         aqtrJstMoGUvx9VoFw6l8mbtfnK52TydAaBs8x8Lf1uhwBIoGR9ZLDJCkbk+4QYivf
         N93ofL4lqufBXhrjjH6VDbQWEX1ZS3HPbVIEhtHBj+CD1qPEb7wz+Ty1i0kwyM39Hc
         8wLHf9DbVMCSLTKrnO3SVZVWrHw4YmOxmTomZzQzTYvZP1c35ojwGEA6G3CxDLm5ng
         QltscOTPrno3A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, frederic@kernel.org,
        paulmck@kernel.org, keescook@chromium.org
Subject: [PATCH 3/3] lkdtm/stackleak: Fix noinstr violation
Date:   Wed, 12 Apr 2023 10:24:08 -0700
Message-Id: <ee5209f53aa0a62aea58be18f2b78b17606779a6.1681320026.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681320026.git.jpoimboe@kernel.org>
References: <cover.1681320026.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning:

  vmlinux.o: warning: objtool: check_stackleak_irqoff+0x2b6: call to _printk() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/misc/lkdtm/stackleak.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 025b133297a6..f1d022160913 100644
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

