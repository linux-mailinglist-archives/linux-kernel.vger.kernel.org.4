Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC87626416
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKKV70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiKKV6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A989FDE9E;
        Fri, 11 Nov 2022 13:58:36 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pDeeVsMEi2ryM4iGk+ZXEHaTUbFi9DYpaP1tHe5U8Z0=;
        b=AK1XW33mCEWFc+AZm3azT5idFEkikX1rvVjRcbG1ihpNi048D48U1YQ78vWxGuWXbE8P27
        BhcGcS0Myh6DgVIraSvISh1qKBcYX3JrpJtUdrh+FWm60kOlDUdD55TyLG06CN/6Pr2f5i
        ZpN6cTM/e+4ujsdp7weQ4j+vy/uhDOHEb3hzVoBUN8rHzPkxJ29S9iMQJ5u4qc9xaw1Ank
        KTU09xcyJYlYmq8/KM72+j0mCdkFdtBrv5OrfN4NJ/hl9XBk1YEUWhYJeslqxVYWX7XswY
        NXIyPhqRQ9GRkr/6rUobHp7E7vpYnOhDu6qZT/pSs+iresd1WnE2F9ZTRit7Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pDeeVsMEi2ryM4iGk+ZXEHaTUbFi9DYpaP1tHe5U8Z0=;
        b=rUJfJ24+R7INuNxJ4vvAtMOBbJ6a+Utk5h3/iqSGN1+KuLfIzx/7jxey/WHW3ypIjR0uvA
        PFrwfgEyn7cPyBAw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86: CPUID and CR3/CR4 flags for Linear Address Masking
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820391410.4906.16419547072918874228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     aa387b1b1e666cacffc0b7ac7e0949a68013b2d9
Gitweb:        https://git.kernel.org/tip/aa387b1b1e666cacffc0b7ac7e0949a68013b2d9
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:26 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:28:06 -08:00

x86: CPUID and CR3/CR4 flags for Linear Address Masking

Enumerate Linear Address Masking and provide defines for CR3 and CR4
flags.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20221109165140.9137-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/processor-flags.h      | 2 ++
 arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2..265805e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index a7f3d91..d8cccad 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -28,6 +28,8 @@
  * On systems with SME, one bit (in a variable position!) is stolen to indicate
  * that the top-level paging structure is encrypted.
  *
+ * On systemms with LAM, bits 61 and 62 are used to indicate LAM mode.
+ *
  * All of the remaining bits indicate the physical address of the top-level
  * paging structure.
  *
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index c47cc7f..d898432 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -82,6 +82,10 @@
 #define X86_CR3_PCID_BITS	12
 #define X86_CR3_PCID_MASK	(_AC((1UL << X86_CR3_PCID_BITS) - 1, UL))
 
+#define X86_CR3_LAM_U57_BIT	61 /* Activate LAM for userspace, 62:57 bits masked */
+#define X86_CR3_LAM_U57		_BITULL(X86_CR3_LAM_U57_BIT)
+#define X86_CR3_LAM_U48_BIT	62 /* Activate LAM for userspace, 62:48 bits masked */
+#define X86_CR3_LAM_U48		_BITULL(X86_CR3_LAM_U48_BIT)
 #define X86_CR3_PCID_NOFLUSH_BIT 63 /* Preserve old PCID */
 #define X86_CR3_PCID_NOFLUSH    _BITULL(X86_CR3_PCID_NOFLUSH_BIT)
 
@@ -132,6 +136,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
+#define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
