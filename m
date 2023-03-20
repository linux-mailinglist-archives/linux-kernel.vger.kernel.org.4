Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115F6C1C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjCTQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjCTQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3E35242;
        Mon, 20 Mar 2023 09:41:07 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k7Csc63oNaUrUCRjkydySx1BB4b/9hMNseImrAKDvjs=;
        b=MADAdHv2kjvW3kPVJo6RsiG9fMaA14JcLDI4aPcQXUL9wLHjOVmNs7ZhVkwj41rfkbnE0g
        ShMmIBd47rQ2KeqRpIzshZO2IxNdmZsV0B/zZ+Tc1b9NrN6IoDkCsLjrQbdiOegrzUp40V
        UBYX/dhdKpSgIochwSDfRvNNrrD1Zks4pOMAfhPRq6c8YBA25H6Y99pyhWBGISEaVK+B3K
        fT4vk21V+vLPplTygkdo+yamrAZSg4JxOZfr9BQPjSSpj/1ROLQPGtw8uSOZ9adyMF2jIV
        4qwHrYcdxR3i1JI0JpFXwp+svTq7KmXPzs2gURxStaJDLjw19qOaPyT1z3PrKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k7Csc63oNaUrUCRjkydySx1BB4b/9hMNseImrAKDvjs=;
        b=WA/bh7sqhxkP2Ayu17U6mZJt9/VR0ANWmms9LCgNqarMrzXapLHQreNG3L2LqLei/SNW6x
        hvzrTIYPMKBKpVCA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Update ptep/pmdp_set_wrprotect() for
 _PAGE_SAVED_DIRTY
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036724.5837.5697853056919150153.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     c169f96ab134479018710af1e2291022eff5af99
Gitweb:        https://git.kernel.org/tip/c169f96ab134479018710af1e2291022eff5af99
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:10 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:09 -07:00

x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY

When shadow stack is in use, Write=0,Dirty=1 PTE are preserved for
shadow stack. Copy-on-write PTEs then have Write=0,SavedDirty=1.

When a PTE goes from Write=1,Dirty=1 to Write=0,SavedDirty=1, it could
become a transient shadow stack PTE in two cases:

1. Some processors can start a write but end up seeing a Write=0 PTE by
   the time they get to the Dirty bit, creating a transient shadow stack
   PTE. However, this will not occur on processors supporting shadow
   stack, and a TLB flush is not necessary.

2. When _PAGE_DIRTY is replaced with _PAGE_SAVED_DIRTY non-atomically, a
   transient shadow stack PTE can be created as a result. Thus, prevent
   that with cmpxchg.

In the case of pmdp_set_wrprotect(), for nopmd configs the ->pmd operated
on does not exist and the logic would need to be different. Although the
extra functionality will normally be optimized out when user shadow
stacks are not configured, also exclude it in the preprocessor stage so
that it will still compile. User shadow stack is not supported there by
Linux anyway. Leave the cpu_feature_enabled() check so that the
functionality also gets disabled based on runtime detection of the
feature.

Similarly, compile it out in ptep_set_wrprotect() due to a clang warning
on i386. Like above, the code path should get optimized out on i386
since shadow stack is not supported on 32 bit kernels, but this makes
the compiler happy.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue. Jann Horn provided the cmpxchg solution.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-16-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7360783..349fcab 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1192,6 +1192,23 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK)) {
+		pte_t old_pte, new_pte;
+
+		old_pte = READ_ONCE(*ptep);
+		do {
+			new_pte = pte_wrprotect(old_pte);
+		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
+
+		return;
+	}
+#endif
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
@@ -1244,6 +1261,24 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK)) {
+		pmd_t old_pmd, new_pmd;
+
+		old_pmd = READ_ONCE(*pmdp);
+		do {
+			new_pmd = pmd_wrprotect(old_pmd);
+		} while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));
+
+		return;
+	}
+#endif
+
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
