Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B3A6AA142
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCCVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCCVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:32:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC0524A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:32:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf635080so37592817b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677879173;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmOP83j+qtaf8M311W2iUSVUxIR3it92PwPrq4SuPzE=;
        b=neKbXVwvVyiwGdDqGBFVR+D+ZgM9SB/+x9wzrpOatRgxUgwP7G/Yl6iuJsRPSwm5bU
         /+9M8q8RWLDO+LbxI0j12TtdY8g4OAJXJ6gQzikVKLUVE/Y7OKRjmpIs3ISjlrBJYGV+
         /vGOjFB5eqOMkXeV3NiEXMYxC5F/95V3vAi9KvS8mxB8vmBgYkisyMboeXAIPmyLBAGx
         YEQhmNyeZNGHx5KnjzSXn53LeXq1RBMwXlMCbez1411tkPWdemtbwqpDtWquJCtABY6J
         coXHvGgEHAmd8Z6JiZQPM2AfYUB1ISi1QugxzLun3PtOdGPRLYFrtjcJO08PMK/ZTOCm
         kt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677879173;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmOP83j+qtaf8M311W2iUSVUxIR3it92PwPrq4SuPzE=;
        b=P/iJDb/OOGqrUOuFpfBF5LAdO2fx1eP31RnafJG0Z6xIfeQca3m2kyoLZnT2+4tSb8
         +RFoK/DNjp4ncccIvk9DpF0r00XTiHjYeRH8+ZBM9tdxXmc7tpvhRAlh4wiGRRJFcYm2
         8ZFsM9li0UjtaqPKpeDEgLmJtsrTHhvs9Y5jtPakw6kNJfsPjK4K2t5NitFX1RcUK7uv
         HYrGjs/XwM2JgHJAT3o/Rw6jZo5oRUgtGnnEm3WxD8ytVYsbPop4eJOufz9zcbleCLDl
         RXelzB7nbb/gad731xTG1J6fA9ZbIJm5mcNjC6EZOXfWWQzkbK7c7nwgdE94Z21wczjd
         D2og==
X-Gm-Message-State: AO0yUKVfJjrevL8dNOO9LcF4PTrY20bKUqFGvanBJs0ZpTWRJgJd4R8I
        cranF6zizffhyCfDW6eWhC3prQ7Ifew=
X-Google-Smtp-Source: AK7set9YpB2FgcduQdC26ixMlYv7+zFt+CX85UCwfdU0JzjGgCscQfrdeAvf1dX8YFsFnqfJXYsTwYBAIGQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:bb9b:efd1:ff2f:8319])
 (user=surenb job=sendgmr) by 2002:a81:a783:0:b0:533:9b80:a30e with SMTP id
 e125-20020a81a783000000b005339b80a30emr1783224ywh.10.1677879173520; Fri, 03
 Mar 2023 13:32:53 -0800 (PST)
Date:   Fri,  3 Mar 2023 13:32:50 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303213250.3555716-1-surenb@google.com>
Subject: [PATCH 1/1] mm/khugepaged: fix vm_lock/i_mmap_rwsem inversion in retract_page_tables
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, rppt@kernel.org,
        jannh@google.com, shakeelb@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, posk@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>,
        syzbot+8955a9646d1a48b8be92@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal syscaller on linux-next reported a lock inversion cause by
vm_lock being taken after i_mmap_rwsem:

======================================================
WARNING: possible circular locking dependency detected
6.2.0-next-20230301-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor115/5084 is trying to acquire lock:
ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write include/linux/mm.h:678 [inline]
ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1826 [inline]
ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: collapse_file+0x4fa5/0x5980 mm/khugepaged.c:2204

but task is already holding lock:
ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:468 [inline]
ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1745 [inline]
ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: collapse_file+0x3da6/0x5980 mm/khugepaged.c:2204

retract_page_tables takes i_mmap_rwsem before exclusive mmap_lock, which
is inverse to normal order. Deadlock is avoided by try-locking mmap_lock
and skipping on failure to obtain it. Locking the VMA should use the same
locking pattern to avoid this lock inversion.

Fixes: 44a83f2083bd ("mm/khugepaged: write-lock VMA while collapsing a huge page")
Reported-by: syzbot+8955a9646d1a48b8be92@syzkaller.appspotmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 39 ++++++++++++++++++++++++++++-----------
 mm/khugepaged.c    |  5 ++++-
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1b9be34a24fb..5f16263d176d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -676,18 +676,23 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 	rcu_read_unlock();
 }
 
-static inline void vma_start_write(struct vm_area_struct *vma)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 {
-	int mm_lock_seq;
-
 	mmap_assert_write_locked(vma->vm_mm);
 
 	/*
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
-	if (vma->vm_lock_seq == mm_lock_seq)
+	*mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
+	return (vma->vm_lock_seq == *mm_lock_seq);
+}
+
+static inline void vma_start_write(struct vm_area_struct *vma)
+{
+	int mm_lock_seq;
+
+	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
 	down_write(&vma->vm_lock->lock);
@@ -695,14 +700,26 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	up_write(&vma->vm_lock->lock);
 }
 
+static inline bool vma_try_start_write(struct vm_area_struct *vma)
+{
+	int mm_lock_seq;
+
+	if (__is_vma_write_locked(vma, &mm_lock_seq))
+		return true;
+
+	if (!down_write_trylock(&vma->vm_lock->lock))
+		return false;
+
+	vma->vm_lock_seq = mm_lock_seq;
+	up_write(&vma->vm_lock->lock);
+	return true;
+}
+
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	mmap_assert_write_locked(vma->vm_mm);
-	/*
-	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
-	 * mm->mm_lock_seq can't be concurrently modified.
-	 */
-	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
+	int mm_lock_seq;
+
+	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
 
 static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c64e01f03f27..408fed42c9f5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1795,6 +1795,10 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 		result = SCAN_PTE_MAPPED_HUGEPAGE;
 		if ((cc->is_khugepaged || is_target) &&
 		    mmap_write_trylock(mm)) {
+			/* trylock for the same lock inversion as above */
+			if (!vma_try_start_write(vma))
+				goto unlock_next;
+
 			/*
 			 * Re-check whether we have an ->anon_vma, because
 			 * collapse_and_free_pmd() requires that either no
@@ -1823,7 +1827,6 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 				result = SCAN_PTE_UFFD_WP;
 				goto unlock_next;
 			}
-			vma_start_write(vma);
 			collapse_and_free_pmd(mm, vma, addr, pmd);
 			if (!cc->is_khugepaged && is_target)
 				result = set_huge_pmd(vma, addr, pmd, hpage);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

