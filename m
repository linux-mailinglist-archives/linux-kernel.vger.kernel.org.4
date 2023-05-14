Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9D701EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjENR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjENR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:27:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E619B2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:27:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307c040797bso3197186f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684085255; x=1686677255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUF48M/gKd1iv/2X/7XjPdwpczkBf5R4Jm0U4/h4Sxg=;
        b=GCG2lzdBfPYkNSmWKn7eWpRh09Mf6rxqbCPxdzx5D9hYB7d5ZScC6OnPRHsMyM3foV
         LPrzeoR65Fcdv1xH3KjIPOOrxAktbQZMmHEmN+UX2Lu9avbXXnHehn9t3UCR6bd8uMw0
         4oIr+H8DAOS0o9r6Wnbx5dB7F9LBYgnKDFBmnfgP6UtttdtVpwZJ35d2nwKhMP6zAJuD
         KaEY+lF8LK7px+niWvhmtQbNID5IEVT8egODaO9ZOxEKdBKkv3GQVfVtSI/XksfO3iDm
         J5bCfXdoxN6U22Xo4X4aEvOXwH13ky32GZIGrgjgG0v9WWSjGqPVmPAfF7130IpzTyhK
         UY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684085255; x=1686677255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUF48M/gKd1iv/2X/7XjPdwpczkBf5R4Jm0U4/h4Sxg=;
        b=BHHIuAq7SdUwXm8OwEXaEbPb20Op6gxXdmdCc2BOHF8n7LpyE0E4nDAEaYhCxcM+as
         jD7ORXYyAt0mgLiliUCvDQzzSiJPBW4WqbpZrlDaQgQGPv/jDoVjRCS0CxbdY57othVz
         8gScnlyFn46PrBXFtpI1JzjqCq5lfcwOIoMjPmnpP19rttiEn7knIB1ZcyeP+kHG9wiF
         fiUSbuQIRp4Fv3K+9dHGGb2/f6IwhQ+V4qmYUJY1lt57ivyakuBToYtOInw9DxFVjcsA
         amk1sIDYQH8KgLJ9esXe7GweCjCeJpHciCqfMpkwPssDPtC+zblioT3k8CUeQNKm7//J
         TFxg==
X-Gm-Message-State: AC+VfDwK4pV2vcLnhCswQ02j/HbzCHtTqPbKLpNeRN8/LGpU3kerRjA6
        x9B/8cZPulNBx0f10buOCW0=
X-Google-Smtp-Source: ACHHUZ7cEvZO1PaTOCiVtVDIInd+jEL6foY7nJ0y26zuxv4a/EjIZpfrIjyS8FPrtoYx4hkk5isM+Q==
X-Received: by 2002:a05:6000:18cd:b0:306:2841:7abb with SMTP id w13-20020a05600018cd00b0030628417abbmr19510223wrq.20.1684085254814;
        Sun, 14 May 2023 10:27:34 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id q10-20020adfcd8a000000b00307c8d6b4a0sm11203667wrj.26.2023.05.14.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 10:27:33 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH for 6.4-rcX] mm: userfaultfd: avoid passing an invalid range to vma_merge()
Date:   Sun, 14 May 2023 18:27:31 +0100
Message-Id: <20230514172731.134188-1-lstoakes@gmail.com>
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
 fs/userfaultfd.c | 111 +++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..4453e7040157 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1319,6 +1319,35 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return 0;
 }

+static int split_range(struct vma_iterator *vmi,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       bool *can_merge)
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
@@ -1330,7 +1359,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	unsigned long vm_flags, new_flags;
 	bool found;
 	bool basic_ioctls;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	struct vma_iterator vmi;

 	user_uffdio_register = (struct uffdio_register __user *) arg;
@@ -1462,6 +1491,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,

 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		bool can_merge;
+
 		cond_resched();

 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1477,32 +1508,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		    (vma->vm_flags & vm_flags) == vm_flags)
 			goto skip;

-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
+		ret = split_range(&vmi, vma, start, end, &can_merge);
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
@@ -1560,7 +1581,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct uffdio_range uffdio_unregister;
 	unsigned long new_flags;
 	bool found;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;

@@ -1627,6 +1648,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	prev = vma_prev(&vmi);
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		bool can_merge;
+
 		cond_resched();

 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1640,9 +1663,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,

 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));

-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
+		ret = split_range(&vmi, vma, start, end, &can_merge);
+		if (ret)
+			break;

 		if (userfaultfd_missing(vma)) {
 			/*
@@ -1652,35 +1675,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
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
