Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA38F73398C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbjFPTTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346005AbjFPTRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3573F35A7;
        Fri, 16 Jun 2023 12:17:05 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BYKFeatUBoOPBvwxlIsSnk4Tb5+E9gS0xg4pcEolCM8=;
        b=s3zyMKQs5qadjoAxqNan5FqTshvHBULaLv1BvKrLCYWiEYSiD1wvLdl8lRvYVuI0I/TE9d
        o6CwInak3jw3rAcA0LCznFqR3q4TfLTY+RoWcbZXIon1AnPvocrWYeuYO8QPNH5H/nI+6L
        1Sab8SVKOHo3hJfi367hrKDBEtVruAFCLNmDXmChjOp2ErrcKBWo9LzUGBc+KWqyISWBZy
        6/8V6dKUHW4eiS8mumt11CbejYty19PfYroSLBuhJ9LsI4/MjRRDIYMBLP7xnzHV2YmtjC
        XdfhM9IqUc3Vn97Jx0vE6pI3aXGuEHZJ8wWfzhEO7pjCaCwJ68tM1HMlaHf/yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BYKFeatUBoOPBvwxlIsSnk4Tb5+E9gS0xg4pcEolCM8=;
        b=lzJpGUNQyzbZ6/cHLFrXn2+pzq3vHq7wgh8sduZt7KxquLNy6a0Nmh7gU5j01NgNuiDUzD
        Z5hWBBtyMHrLW3Cw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Update ptep/pmdp_set_wrprotect() for
 _PAGE_SAVED_DIRTY
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302336.404.16379064029653101571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     75c1d1854306f4c978105bafe3ec1e030548cec5
Gitweb:        https://git.kernel.org/tip/75c1d1854306f4c978105bafe3ec1e030548cec5
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:37 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

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
   transient shadow stack PTE can be created as a result.

Prevent the second case when doing a write protection and Dirty->SavedDirty
shift at the same time with a CMPXCHG loop. The first case

Note, in the PAE case CMPXCHG will need to operate on 8 byte, but
try_cmpxchg() will not use CMPXCHG8B, so it cannot operate on a full PAE
PTE. However the exiting logic is not operating on a full 8 byte region
either, and relies on the fact that the Write bit is in the first 4
bytes when doing the clear_bit(). Since both the Dirty, SavedDirty and
Write bits are in the first 4 bytes, casting to a long will be similar to
the existing behavior which also casts to a long.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue. Jann Horn provided the CMPXCHG solution.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-12-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a1883d8..13fdad2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1189,7 +1189,17 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
-	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	pte_t old_pte, new_pte;
+
+	old_pte = READ_ONCE(*ptep);
+	do {
+		new_pte = pte_wrprotect(old_pte);
+	} while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(long *)&new_pte));
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
@@ -1241,7 +1251,17 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
-	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	pmd_t old_pmd, new_pmd;
+
+	old_pmd = READ_ONCE(*pmdp);
+	do {
+		new_pmd = pmd_wrprotect(old_pmd);
+	} while (!try_cmpxchg((long *)pmdp, (long *)&old_pmd, *(long *)&new_pmd));
 }
 
 #ifndef pmdp_establish
