Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29592703DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbjEOTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245044AbjEOTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:32:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C65A8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:32:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso62266095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684179156; x=1686771156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMVbs9NK56mDlrRWLRnqErXBKtSiemN+W66NFlThQDE=;
        b=P9bxXw3djQUnMK5xW1pLdlUA8Ij+PtYZWG4sHvQI2BNygUMvJN2plCHkznD2xjDJOB
         mKGeQ92r6fCtQFfyMGsXxHZEpOw7B9m8Iht6Ery6cxDC+TtZ8fnurONh3BED6/KqXbK2
         GfTf2WbiuRPfQVUBZK+e1znftLIpqqanF3pH8OsNscOxA1IccX9DUQ5MWelKVSuPM43c
         TeFyJaXrc9k5Gq43+HHkE42UAtAhbx2rs7m/W0lNNz3PyQfs6qF5CtEHIK5VemCeWlsp
         yQs0DwO12DcMnzMBGIQ9D4GyBIOUTKluP16E6IrrN8F09HJk4VMEgh82/LxbymDPd79q
         dKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684179156; x=1686771156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMVbs9NK56mDlrRWLRnqErXBKtSiemN+W66NFlThQDE=;
        b=JDx6WHrwg5kwF1sNzT8RFSU2YCnlffo6uOmnS9pJ2ud5IS0oa1MrbtI8xImO6OOZzZ
         kRR++mLwAjMFk1Arp0xGWN/NcyiquiHfEWspopRQM4sMmmhKFbyhVPqkJ4ZDWAwVXAzi
         7XTgNFmUddBGzuyyubgEBUud1v02IA/6CRUm/qstFCTe7lRzeALqnZ95JvLqZlU6hObq
         oV5dA0cHZMcgwN1BePMcESVcIth36BshOV3nFxBmtNLVihb9z/gYfr2DkxZyrLtHbTyz
         C/Rwtfb3mQWRcNC89KnCSLJWppbeInnw71aF5YSO9IL6GNpnSPtdOW/LPKXMb5Iskj4p
         jFLg==
X-Gm-Message-State: AC+VfDwsbnmfl0IjrnbMlzGwT5YEkrvyQW4g7Ge5ZzKgEdKJibUJdoL8
        XOnxT+eEDxZM7mkrG3sWcVNlDDBSU9Jn1w==
X-Google-Smtp-Source: ACHHUZ4UsCdj61BRCDmXcIh843nDA3Pl62oXnQgyZVpTOsOw5ivHuPdJEc6oYGemw3Iz8KxWxMge7g==
X-Received: by 2002:a7b:c357:0:b0:3ee:19b4:a2e6 with SMTP id l23-20020a7bc357000000b003ee19b4a2e6mr21990651wmj.19.1684179155596;
        Mon, 15 May 2023 12:32:35 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e12-20020adffd0c000000b003062ad45243sm124315wrr.14.2023.05.15.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:32:34 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to vma_merge()
Date:   Mon, 15 May 2023 20:32:32 +0100
Message-Id: <20230515193232.67552-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userfaultfd_[un]register() functions will knowingly pass an invalid
address range to vma_merge(), then rely on it failing to merge to indicate
that the VMA should be split into a valid one.

This is not something that should be relied upon, as vma_merge() implicitly
assumes in cases 5-8 that curr->vm_start == addr. This is now enforced
since commit b0729ae0ae67 ("mm/mmap/vma_merge: explicitly assign res, vma,
extend invariants") with an explicit VM_WARN_ON() check.

Since commit 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
this check is performed unconditionally, which caused this assert to arise
in tests performed by Mark [1].

This patch fixes the issue by performing the split operations before
attempting to merge VMAs in both instances. The problematic operation is
splitting the start of the VMA since we were clamping to the end of the VMA
in any case, however it is useful to group both of the split operations
together to avoid egregious goto's and to abstract the code between the
functions.

As well as fixing the repro described in [1] this also continues to pass
uffd unit tests.

[1]:https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com

Reported-by: Mark Rutland <mark.rutland@arm.com>
Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/userfaultfd.c | 108 ++++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..ef5d667ea804 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1319,6 +1319,32 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return 0;
 }
 
+static int clamp_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end, bool *can_merge)
+{
+	int ret;
+	bool merge = true;
+
+	/* The range must always be clamped to the start of a VMA. */
+	if (vma->vm_start < start) {
+		ret = split_vma(vmi, vma, start, 1);
+		if (ret)
+			return ret;
+
+		merge = false;
+	}
+
+	/* It must also be clamped to the end of a VMA. */
+	if (vma->vm_end > end) {
+		ret = split_vma(vmi, vma, end, 0);
+		if (ret)
+			return ret;
+	}
+
+	*can_merge = merge;
+	return 0;
+}
+
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -1330,7 +1356,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	unsigned long vm_flags, new_flags;
 	bool found;
 	bool basic_ioctls;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	struct vma_iterator vmi;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
@@ -1462,6 +1488,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		bool can_merge;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1477,32 +1505,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		    (vma->vm_flags & vm_flags) == vm_flags)
 			goto skip;
 
-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
+		ret = clamp_range(&vmi, vma, start, end, &can_merge);
+		if (ret)
+			break;
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
-				 vma_policy(vma),
-				 ((struct vm_userfaultfd_ctx){ ctx }),
-				 anon_vma_name(vma));
-		if (prev) {
+		if (can_merge) {
+			prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end, new_flags,
+					 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+					 vma_policy(vma),
+					 ((struct vm_userfaultfd_ctx){ ctx }),
+					 anon_vma_name(vma));
+
 			/* vma_merge() invalidated the mas */
-			vma = prev;
-			goto next;
-		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+			if (prev)
+				vma = prev;
 		}
-	next:
 		/*
 		 * In the vma_merge() successful mprotect-like case 8:
 		 * the next vma was merged into the current one and
@@ -1560,7 +1578,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct uffdio_range uffdio_unregister;
 	unsigned long new_flags;
 	bool found;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
 
@@ -1627,6 +1645,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	prev = vma_prev(&vmi);
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		bool can_merge;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1640,9 +1660,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
+		ret = clamp_range(&vmi, vma, start, end, &can_merge);
+		if (ret)
+			break;
 
 		if (userfaultfd_missing(vma)) {
 			/*
@@ -1652,35 +1672,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			 * UFFDIO_WAKE explicitly.
 			 */
 			struct userfaultfd_wake_range range;
-			range.start = start;
-			range.len = vma_end - start;
+			range.start = vma->vm_start;
+			range.len = vma->vm_end - vma->vm_start;
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
 		/* Reset ptes for the whole vma range if wr-protected */
 		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, start, vma_end - start, false);
+			uffd_wp_range(vma, vma->vm_start,
+				      vma->vm_end - vma->vm_start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev) {
-			vma = prev;
-			goto next;
-		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+		if (can_merge) {
+			prev = vma_merge(&vmi, mm, prev, vma->vm_start,
+					 vma->vm_end, new_flags, vma->anon_vma,
+					 vma->vm_file, vma->vm_pgoff,
+					 vma_policy(vma),
+					 NULL_VM_UFFD_CTX, anon_vma_name(vma));
+			/* vma_merge() invalidated the mas */
+			if (prev)
+				vma = prev;
 		}
-	next:
 		/*
 		 * In the vma_merge() successful mprotect-like case 8:
 		 * the next vma was merged into the current one and
-- 
2.40.1

