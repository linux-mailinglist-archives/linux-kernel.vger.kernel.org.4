Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF30F6F1490
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjD1Jwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbjD1Jwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:52:35 -0400
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BA10E7;
        Fri, 28 Apr 2023 02:52:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.STCEPMn_1682675524;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPMn_1682675524)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:05 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH RFC 09/43] x86/power/64: Adapt assembly for PIE support
Date:   Fri, 28 Apr 2023 17:50:49 +0800
Message-Id: <b93623c94be2633a90b3abfc6a7ea6c1703f7a9a.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@chromium.org>

From: Thomas Garnier <thgarnie@chromium.org>

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 0a0539e1cc81..1d96a119d29d 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -39,7 +39,7 @@ SYM_FUNC_START(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
@@ -70,7 +70,7 @@ SYM_FUNC_START(restore_registers)
 SYM_FUNC_END(restore_registers)
 
 SYM_FUNC_START(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
-- 
2.31.1

