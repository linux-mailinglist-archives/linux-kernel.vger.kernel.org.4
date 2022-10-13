Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA05FE334
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJMUYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJMUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:23:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C4159D56
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665692611; x=1697228611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaC8ceQnideTemOSR0AnD9gGv296yv6KtEQKYgHeIg4=;
  b=JXX3Y2FFoP7rZrS57moacsUWRCz3WxJ7dE23q0R56fqYpT9jGyGh+udN
   wKz60Q3om83n0nhW1FGu1qG5PyIDiq5r1B8yH17zb9WCoKMZdwEugDKQp
   9swTWY7eDf3u8tHNzTGNbWVqLHLrMkKJ3xbhuxaXyu/WhjeFw1sS1WAVm
   +NY+eoPI2Z8QhSyAWDj0mSyXpyMB2TGUN5EI8ysjlPkLqzMTqHw9Ww66O
   ulDbfyQc12nUhf0/N0vBilzzretaj+eFFGd3zHb0Bc9PXgikH7qS4ndML
   i5kaYoTJiNgbzGmvGzYhGOWMlsMgNShiY12U9tefnNouA4EuADT7j8etR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302808968"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302808968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690271049"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690271049"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2022 13:23:27 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v3 4/6] x86/gsseg: move local_irq_save/restore() into asm_load_gs_index()
Date:   Thu, 13 Oct 2022 13:01:32 -0700
Message-Id: <20221013200134.1487-5-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013200134.1487-1-xin3.li@intel.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

