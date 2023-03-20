Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B735B6C1CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjCTQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjCTQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8E1630B;
        Mon, 20 Mar 2023 09:41:55 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xGipKE+chYK8KeU0SCLx+62PG4srK5cXRSyRvcj12Mw=;
        b=Kimqu0HmPy23CqNNiFwgxkHuHAFZo641Sz7cfjv0y8w2OfrkjceZIty9igB0n02mjIOS3R
        bak4U+5NtTfJCZX4uvk6TNcEGC04BD92usMuyLCEwbRz9thwQ0D4jD5V7ohR5oNbAlkRzO
        vK7WzHUZ/liLoR+WQ1l+Hb7WmM2kGh2BBlEwGuzKS2PDsUHWGA+CvJCKPL8Au9SDU87N9Z
        1PqvfdUn6mRpXDdvb1ajEmLiPwuYvpTmJtNvtfbIK6Fa5c/PpVZBeGT9RxCXyzEVfF+PCC
        h10AaqMSKPTzpXBlx1burXgQWfmeFzk4Zh7Wbr9C0q62JxFrCop97GJMJ9lS7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xGipKE+chYK8KeU0SCLx+62PG4srK5cXRSyRvcj12Mw=;
        b=gbSCVNZuIV/aQSQruKJCZOwfwitoUyBGbd3s+C2A+kxBQqNL9777AVxAsptMlfyFwz5Z/p
        RzeFWaJzMNIs7HCg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Teach pte_mkwrite() about stack memory
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036578.5837.829340269312083950.tip-bot2@tip-bot2>
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

Commit-ID:     a1d44091f03ed23e7e137eaeea3424996c7d72eb
Gitweb:        https://git.kernel.org/tip/a1d44091f03ed23e7e137eaeea3424996c7d72eb
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:15 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:10 -07:00

x86/mm: Teach pte_mkwrite() about stack memory

If a VMA has the VM_SHADOW_STACK flag, it is shadow stack memory. So
when it is made writable with pte_mkwrite(), it should create shadow
stack memory, not conventionally writable memory. Now that all the places
where shadow stack memory might be created pass a VMA into pte_mkwrite(),
it can know when it should do this.

So make pte_mkwrite() create shadow stack memory when the VMA has the
VM_SHADOW_STACK flag. Do the same thing for pmd_mkwrite().

This requires referencing VM_SHADOW_STACK in these functions, which are
currently defined in pgtable.h, however mm.h (where VM_SHADOW_STACK is
located) can't be pulled in without causing problems for files that
reference pgtable.h. So also move pte/pmd_mkwrite() into pgtable.c, where
they can safely reference VM_SHADOW_STACK.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Deepak Gupta <debug@rivosinc.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-21-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h | 20 ++------------------
 arch/x86/mm/pgtable.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 05dfdbd..d81e7ec 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -456,15 +456,7 @@ static inline pte_t pte_mkwrite_kernel(pte_t pte)
 
 struct vm_area_struct;
 
-static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
-{
-	pte = pte_mkwrite_kernel(pte);
-
-	if (pte_dirty(pte))
-		pte = pte_clear_saveddirty(pte);
-
-	return pte;
-}
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
@@ -601,15 +593,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_ACCESSED);
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
-{
-	pmd = pmd_set_flags(pmd, _PAGE_RW);
-
-	if (pmd_dirty(pmd))
-		pmd = pmd_clear_saveddirty(pmd);
-
-	return pmd;
-}
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499e..98856bc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -880,3 +880,29 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	pte = pte_mkwrite_kernel(pte);
+
+	if (pte_dirty(pte))
+		pte = pte_clear_saveddirty(pte);
+
+	return pte;
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	pmd = pmd_set_flags(pmd, _PAGE_RW);
+
+	if (pmd_dirty(pmd))
+		pmd = pmd_clear_saveddirty(pmd);
+
+	return pmd;
+}
