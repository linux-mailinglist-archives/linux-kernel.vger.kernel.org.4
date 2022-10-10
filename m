Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DF75FA41B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJJTYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJJTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:23:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381461125
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665429832; x=1696965832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaC8ceQnideTemOSR0AnD9gGv296yv6KtEQKYgHeIg4=;
  b=HdZxdCa72mJ9+89bCrCRus/m7l1iMNJtH8Zin1ZkXStPWY7xN1WVsKjA
   x7djjMaJJfyxW8lJs0DwJsYjx/7koELcSQMMp+eTMZko44lPhPskdIx4N
   IKMj1h3C3EL2kwkMfha/+ZwM9+o2Wp+5b+Mk8aptS43e3RwpRtJLWcMRo
   pQe3YjxN2mvN5ae3qNF15CT0u8eB8nNq7rU2U0LStPBYrNEH0KseiZckH
   MfsMIcvjfQaQX0BQWvZcNhHTKLSBh4ALt4SxCrX7m9iS9t/Qy8J21/YI9
   y1Pal/Vju3P8LgMvgU1gPZJ3Bmzz4Hkb9eNAAYaA+CESX6FuYTuTF+a5o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284044536"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284044536"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694762693"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694762693"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:23:50 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 4/6] x86/gsseg: move local_irq_save/restore() into asm_load_gs_index()
Date:   Mon, 10 Oct 2022 12:01:57 -0700
Message-Id: <20221010190159.11920-5-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010190159.11920-1-xin3.li@intel.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

