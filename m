Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235AC5F6B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiJFQEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJFQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:03:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38009B2745
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665072227; x=1696608227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaC8ceQnideTemOSR0AnD9gGv296yv6KtEQKYgHeIg4=;
  b=jxKw+8UVS/xHiX5TS3LjHyJCmJTJs9BXkzfcPSg0mOfbZazHa1KbiOT1
   hCrFLfpv3R+8jlxSGN11DE5wM+AYbSti8w555KqJp7IZ1PckRNuUArTz6
   w0F9JSk98HwVkqPE5ch0MJJ8cj6aRPbtEu4uiJy95dm6ENsVamTahiSPA
   AfJwjjsXUJE2VRg+gHjTajBVOpn6DzaF93CbvertipTVbCw2Ac0pWVtH4
   BqYis5aZBtze0i2mx2MGpm5EQWtqC63ogvJaAcosqSNwww4mpBXzBNcwI
   kqYLbyMWIGFSrqt4xrcrRmofaqNCHvAyy+0ySq05pHCKLtrySdie5Br86
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="304480712"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304480712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="687486230"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687486230"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2022 09:02:36 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH 4/6] x86/gsseg: move local_irq_save/restore() into asm_load_gs_index()
Date:   Thu,  6 Oct 2022 08:40:39 -0700
Message-Id: <20221006154041.13001-5-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006154041.13001-1-xin3.li@intel.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The need to disable/enable interrupts around asm_load_gs_index() is a
consequence of the implementation. Prepare for using the LKGS
instruction, which is locally atomic and therefore doesn't need
interrupts disabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/entry_64.S            | 26 +++++++++++++++++++++-----
 arch/x86/include/asm/special_insns.h |  4 ----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e0c48998d2fb..cc6ba6672418 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -778,19 +778,35 @@ SYM_CODE_END(common_interrupt_return)
 _ASM_NOKPROBE(common_interrupt_return)
 
 /*
- * Reload gs selector with exception handling
+ * Reload gs selector with exception handling. This is used only on
+ * native, so using swapgs, pushf, popf, cli, sti, ... directly is fine.
+ *
  *  di:  new selector
+ * rax:  scratch register
  *
  * Is in entry.text as it shouldn't be instrumented.
+ *
+ * Note: popf is slow, so use pushf to read IF and then execute cli/sti
+ * if necessary.
  */
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
+	pushf
+	pop	%rax
+	andl	$X86_EFLAGS_IF, %eax	/* Interrupts enabled? */
+	jz	1f
+	cli
+1:
 	swapgs
 .Lgs_change:
 	ANNOTATE_NOENDBR // error_entry
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
 	swapgs
+	testl	%eax, %eax
+	jz	3f
+	sti
+3:
 	FRAME_END
 	RET
 
@@ -799,12 +815,12 @@ SYM_FUNC_START(asm_load_gs_index)
 	swapgs					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
-	movl $__USER_DS, %eax
-	movl %eax, %gs
+	movl $__USER_DS, %edi
+	movl %edi, %gs
 .endm
 	ALTERNATIVE "", "ZAP_GS", X86_BUG_NULL_SEG
-	xorl	%eax, %eax
-	movl	%eax, %gs
+	xorl	%edi, %edi
+	movl	%edi, %gs
 	jmp	2b
 
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index a71d0e8d4684..6de00dec6564 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -124,11 +124,7 @@ extern asmlinkage void asm_load_gs_index(u16 selector);
 
 static inline void native_load_gs_index(unsigned int selector)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	asm_load_gs_index(selector);
-	local_irq_restore(flags);
 }
 
 static inline unsigned long __read_cr4(void)
-- 
2.34.1

