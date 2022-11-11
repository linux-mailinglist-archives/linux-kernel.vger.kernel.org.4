Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36213626408
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiKKV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiKKV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC35EBC8D;
        Fri, 11 Nov 2022 13:58:27 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HjE+8mx4izjAs2tELbbO6u2mkyVcdWGuw37jXdnNdRw=;
        b=NWOGPx8isvGHXYI4s86i0cqzZISddiETNf9OdYwM/x73kiHRe0DUPK7gJbggmpxc8QKR6s
        TyzNp64nSnoNwfH03qb7Kb3kyo+Sn6PYavmBNPwxrZCHRAPV0LyREBE98Wi8N6wkPFCsI4
        5JeTnY5Vfi+55A4G9SYGD9KrxHuSMvmdPLR+LsCKmJYrlNH69G4mUaH6yi2qb+9xOJxn5F
        wQ1XthWwjxZ6JWpCbYfWhMjjJHPclM1DFAxRM3YU8J6kmhdXrFIUfnEPrfWf8aMc3fGsQq
        MtlCbY0fQatfB5k1bU/8C1EOo2vUi/MVIm8V9o+ux7YhD+DE10QMDF2zMOaZLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HjE+8mx4izjAs2tELbbO6u2mkyVcdWGuw37jXdnNdRw=;
        b=zWu6MSEFZoSRcZCukHH5F7FfGRw/mOIC7iTBGJd9iqCEQlEZrqWQDVjO8SxEwXZwAiDczu
        XFvHjyIDD21Pg9Dg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820390523.4906.11328016242925887203.tip-bot2@tip-bot2>
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

Commit-ID:     e79114b17b8149237071cf353edf379c597829e9
Gitweb:        https://git.kernel.org/tip/e79114b17b8149237071cf353edf379c597829e9
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:34 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:29:55 -08:00

iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()

Kernel has few users of pasid_valid() and all but one checks if the
process has PASID allocated. The helper takes ioasid_t as the input.

Replace the helper with mm_valid_pasid() that takes mm_struct as the
argument. The only call that checks PASID that is not tied to mm_struct
is open-codded now.

This is preparatory patch. It helps avoid ifdeffery: no need to
dereference mm->pasid in generic code to check if the process has PASID.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221109165140.9137-11-kirill.shutemov%40linux.intel.com
---
 arch/x86/kernel/traps.c       |  6 +++---
 drivers/iommu/iommu-sva-lib.c |  4 ++--
 include/linux/ioasid.h        |  9 ---------
 include/linux/sched/mm.h      |  8 +++++++-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a..3bdc37a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -664,15 +664,15 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
 		return false;
 
-	pasid = current->mm->pasid;
-
 	/*
 	 * If the mm has not been allocated a
 	 * PASID, the #GP can not be fixed up.
 	 */
-	if (!pasid_valid(pasid))
+	if (!mm_valid_pasid(current->mm))
 		return false;
 
+	pasid = current->mm->pasid;
+
 	/*
 	 * Did this thread already have its PASID activated?
 	 * If so, the #GP must be from something else.
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 1065061..27be6b8 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -33,14 +33,14 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
-	if (pasid_valid(mm->pasid)) {
+	if (mm_valid_pasid(mm)) {
 		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
 		goto out;
 	}
 
 	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
+	if (pasid == INVALID_IOASID)
 		ret = -ENOMEM;
 	else
 		mm_pasid_set(mm, pasid);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index af1c9d6..836ae09 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid != INVALID_IOASID;
-}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -74,10 +70,5 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return false;
-}
-
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a24361..b69fe7e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -457,6 +457,11 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 	mm->pasid = INVALID_IOASID;
 }
 
+static inline bool mm_valid_pasid(struct mm_struct *mm)
+{
+	return mm->pasid != INVALID_IOASID;
+}
+
 /* Associate a PASID with an mm_struct: */
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
 {
@@ -465,13 +470,14 @@ static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
 
 static inline void mm_pasid_drop(struct mm_struct *mm)
 {
-	if (pasid_valid(mm->pasid)) {
+	if (mm_valid_pasid(mm)) {
 		ioasid_free(mm->pasid);
 		mm->pasid = INVALID_IOASID;
 	}
 }
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
