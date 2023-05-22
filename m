Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7C70B78F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjEVIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjEVIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:24:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79382B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:24:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso4159055e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684743856; x=1687335856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5P55SeVZi8i0w++ACS66BUPKb/klhNtkg+RLR5cpX8k=;
        b=liQ5OOFc1KNu/9WLga5ETHW9Gc2ze3aZV9Fy1QKL0qLhSXtmQ1QZhILOo+9hG9VvH3
         +HFxbgphbR2Ngr1nE0C6WlxJcRb8PoDx72vWW2fs7XsQfacxn1T32OKKVTnGfE5yEJrB
         IlIs2iBFppPq1Ucp/6rac1yi5GqGNB4CpjWjilToUd3T1drgmBDSKTTfJPjnC5qn25ul
         RaUJJSjIrNitD4w46OlGPby1QxOXjsnWmRKkYe+l3+wr35gv7yowdyVGq28HOV5acKXS
         B/F+dy/A1XHwBLUtTWfRUo0FRSEIrjsetcuHS40VnYtRJI6P0iK+M0BiIvzmejC9qA/B
         xHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684743856; x=1687335856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5P55SeVZi8i0w++ACS66BUPKb/klhNtkg+RLR5cpX8k=;
        b=UmviMpUlGP5wjbvmPN+lwxDFu+c2Cana1D9DBRpAdhasn8M8UgE6Ghel6fB6zHydUy
         kROW6kw8xEonznfiH/JZeKV+yB+pqB/SM8bMlInohh3XVTbxiPD7z+yvvnL9bjo2zvoC
         HnfLSGlirn9c443JCq3flwTTymNaLzc2y8zwdsJjAgs7sNHdBlQB2UsL7sN62OqvO0Tu
         kkW1XC8BBHe+6fj1GGtOVCJhtF16iopVxfr/594BV9T3rIZka1+l1Bpd3jCKoZfe+xm6
         yphx6ctbAPyzR5I4yMTLRhV9ibcYDdEBDwRa4ez2mDh6Pi6hqK/DLDGC3exGOdEKU5Z3
         yJ4g==
X-Gm-Message-State: AC+VfDw6S0zHrH90Y+4aHX0I0HxxyvpSVuesFoGjhEV3LL4CkzdjFzR4
        Q1BFBN6jBCTNaUTROepNp40=
X-Google-Smtp-Source: ACHHUZ6xkVk5ZDc1iRaohsXE7LCPcSRoYMlsLeU+/KiEiMsvQLJkj1AqEW8V2Ha6BnEMOK7XxGuM6Q==
X-Received: by 2002:adf:f542:0:b0:309:4368:a8a0 with SMTP id j2-20020adff542000000b003094368a8a0mr6133123wrp.68.1684743855512;
        Mon, 22 May 2023 01:24:15 -0700 (PDT)
Received: from lucifer.home (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.googlemail.com with ESMTPSA id j3-20020a5d4483000000b003062b57ffd1sm6900600wrq.50.2023.05.22.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 01:24:14 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/mmap: refactor mlock_future_check()
Date:   Mon, 22 May 2023 09:24:12 +0100
Message-Id: <20230522082412.56685-1-lstoakes@gmail.com>
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

In all but one instance, mlock_future_check() is treated as a boolean
function despite returning an error code. In one instance, this error code
is ignored and replaced with -ENOMEM.

This is confusing, and the inversion of true -> failure, false -> success
is not warranted. Convert the function to a bool, lightly refactor and
return true if the check passes, false if not.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/internal.h  |  4 ++--
 mm/mmap.c      | 33 +++++++++++++++++----------------
 mm/mremap.c    |  2 +-
 mm/secretmem.c |  2 +-
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bb6542279599..66dd214b302a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -576,8 +576,8 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
 				   bool write, int *locked);
-extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
-			      unsigned long len);
+extern bool mlock_future_check(struct mm_struct *mm, unsigned long flags,
+			       unsigned long bytes);
 /*
  * mlock_vma_folio() and munlock_vma_folio():
  * should be called with vma's mmap_lock held for read or write,
diff --git a/mm/mmap.c b/mm/mmap.c
index 877696464c09..10f2d5d689da 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -182,7 +182,8 @@ static int check_brk_limits(unsigned long addr, unsigned long len)
 	if (IS_ERR_VALUE(mapped_addr))
 		return mapped_addr;
 
-	return mlock_future_check(current->mm, current->mm->def_flags, len);
+	return mlock_future_check(current->mm, current->mm->def_flags, len)
+		? 0 : -EAGAIN;
 }
 static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 		unsigned long addr, unsigned long request, unsigned long flags);
@@ -1148,21 +1149,21 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-int mlock_future_check(struct mm_struct *mm, unsigned long flags,
-		       unsigned long len)
+bool mlock_future_check(struct mm_struct *mm, unsigned long flags,
+			unsigned long bytes)
 {
-	unsigned long locked, lock_limit;
+	unsigned long locked_pages, limit_pages;
 
-	/*  mlock MCL_FUTURE? */
-	if (flags & VM_LOCKED) {
-		locked = len >> PAGE_SHIFT;
-		locked += mm->locked_vm;
-		lock_limit = rlimit(RLIMIT_MEMLOCK);
-		lock_limit >>= PAGE_SHIFT;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
-			return -EAGAIN;
-	}
-	return 0;
+	if (!(flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+		return true;
+
+	locked_pages = bytes >> PAGE_SHIFT;
+	locked_pages += mm->locked_vm;
+
+	limit_pages = rlimit(RLIMIT_MEMLOCK);
+	limit_pages >>= PAGE_SHIFT;
+
+	return locked_pages <= limit_pages;
 }
 
 static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
@@ -1274,7 +1275,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!can_do_mlock())
 			return -EPERM;
 
-	if (mlock_future_check(mm, vm_flags, len))
+	if (!mlock_future_check(mm, vm_flags, len))
 		return -EAGAIN;
 
 	if (file) {
@@ -1926,7 +1927,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* mlock limit tests */
-	if (mlock_future_check(mm, vma->vm_flags, grow << PAGE_SHIFT))
+	if (!mlock_future_check(mm, vma->vm_flags, grow << PAGE_SHIFT))
 		return -ENOMEM;
 
 	/* Check to ensure the stack will not grow into a hugetlb-only region */
diff --git a/mm/mremap.c b/mm/mremap.c
index b11ce6c92099..bcfcb8df5875 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -775,7 +775,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return ERR_PTR(-EFAULT);
 
-	if (mlock_future_check(mm, vma->vm_flags, new_len - old_len))
+	if (!mlock_future_check(mm, vma->vm_flags, new_len - old_len))
 		return ERR_PTR(-EAGAIN);
 
 	if (!may_expand_vm(mm, vma->vm_flags,
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 974b32ba8b9d..58d2af12df4f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -125,7 +125,7 @@ static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
 		return -EAGAIN;
 
 	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
-- 
2.40.1

