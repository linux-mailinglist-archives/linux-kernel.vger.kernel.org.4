Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAD6F14B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjD1J4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbjD1Jz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:56 -0400
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2866181;
        Fri, 28 Apr 2023 02:55:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.STFoGYl_1682675602;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGYl_1682675602)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:23 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH RFC 29/43] x86/PVH: Adapt PVH booting for PIE support
Date:   Fri, 28 Apr 2023 17:51:09 +0800
Message-Id: <ea6994d2ab49a50cb5a8911c24562cd6d223c2b6.1682673543.git.houwenlong.hwl@antgroup.com>
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

If PIE is enabled, all symbol references would be RIP-relative. However,
PVH booting runs in low address space, which could cause wrong x86_init
callbacks assignment. Since init_top_pgt has building high kernel
address mapping, let PVH booting runs in high address space to make all
things right.

PVH booting assumes that no relocation happened. Since the kernel
compile address is still in top 2G, so it is allowed to use R_X86_64_32S
for symbol references in pvh_start_xen().

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/platform/pvh/head.S | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 5842fe0e4f96..09518d4de042 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -94,6 +94,13 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* 64-bit entry point. */
 	.code64
 1:
+#ifdef CONFIG_X86_PIE
+	movabs  $2f, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%rax
+2:
+	ANNOTATE_NOENDBR // above
+#endif
 	/* Set base address in stack canary descriptor. */
 	mov $MSR_GS_BASE,%ecx
 #if defined(CONFIG_STACKPROTECTOR_FIXED)
@@ -149,9 +156,15 @@ SYM_CODE_END(pvh_start_xen)
 	.section ".init.data","aw"
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
+	/*
+	 * Use an ASM_PTR (quad on x64) for _pa(gdt_start) because PIE requires
+	 * a pointer size storage value before applying the relocation. On
+	 * 32-bit _ASM_PTR will be a long which is aligned the space needed for
+	 * relocation.
+	 */
 	.word gdt_end - gdt_start
-	.long _pa(gdt_start)
-	.word 0
+	_ASM_PTR _pa(gdt_start)
+	.balign 8
 SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
 	.quad 0x0000000000000000            /* NULL descriptor */
-- 
2.31.1

