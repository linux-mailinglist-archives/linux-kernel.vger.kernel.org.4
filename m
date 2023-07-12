Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C874FDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGLDcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGLDcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:32:16 -0400
Received: from out0-207.mail.aliyun.com (out0-207.mail.aliyun.com [140.205.0.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053381BF5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:32:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TrdHx8q_1689132719;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TrdHx8q_1689132719)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 11:32:00 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "=?UTF-8?B?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFIDMyLUJJVCBBTkQgNjQtQklU?=" 
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 7/7] x86/sme: Build the code in mem_encrypt_identity.c as PIE
Date:   Wed, 12 Jul 2023 11:30:11 +0800
Message-Id: <80367ca39ed736b6fc839c5de99a006f54182c45.1689130310.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to head64.c, all the code in mem_encrypt_identity.c runs in
identity address. However, it uses inline assembly to use RIP-relative
reference for some globals. Therefore, build the code as PIE to force
the compiler to generate RIP-relative reference, allowing for all inline
assembly to be removed.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
The changes have not been tested on AMD SME.

 arch/x86/mm/Makefile               |  3 +++
 arch/x86/mm/mem_encrypt_identity.c | 31 +++++-------------------------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..f5d7b22c5f1b 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -32,6 +32,9 @@ obj-y				+= pat/
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
+CFLAGS_mem_encrypt_identity.o 	+= -fPIE -include $(srctree)/include/linux/hidden.h
+
+CFLAGS_REMOVE_mem_encrypt_identity.o += -mcmodel=kernel

 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 72aeb0f3dec6..2f292ab4e6a9 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -343,13 +343,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif

-	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
+	workarea_start = (unsigned long)(void *)sme_workarea;

 	/*
 	 * Calculate required number of workarea bytes needed:
@@ -505,7 +499,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)

 void __head sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
+	const char *cmdline_ptr;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	bool active_by_default;
@@ -578,21 +572,6 @@ void __head sme_enable(struct boot_params *bp)
 		goto out;
 	}

-	/*
-	 * Fixups have not been applied to phys_base yet and we're running
-	 * identity mapped, so we must obtain the address to the SME command
-	 * line argument data using rip-relative addressing.
-	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
 		active_by_default = true;
 	else
@@ -601,12 +580,12 @@ void __head sme_enable(struct boot_params *bp)
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));

-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
+	if (cmdline_find_option(cmdline_ptr, sme_cmdline_arg, buffer, sizeof(buffer)) < 0)
 		return;

-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
+	if (!strncmp(buffer, sme_cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
+	else if (!strncmp(buffer, sme_cmdline_off, sizeof(buffer)))
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
--
2.31.1

