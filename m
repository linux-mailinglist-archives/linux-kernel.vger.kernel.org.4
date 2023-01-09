Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76E166321E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbjAIU72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjAIU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671498F2A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c1456d608cso104298577b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eLzL6RHeFdZbRB5oFC0iJ795TBzqFT5ovI/MwJrKVk=;
        b=J47RXHly65L6DdSqhS16NmYDveuNz+mvTNG4sGvbQhUoWkeX6DBvsEbauZWeZvA/FL
         6iJWwlnZTOJwBfCXcZD78WFVJCG7QdSQyabstEWgAbqGHA3DDp9ZOq1VOAfH1PKWr803
         hD+hbwJSt9HgzHQXXidFA8sLeLstkKuaZuBnozg86r7c8tgk1iKjkQ1PqFU36BM8+uUF
         XrYI9BSRx6s/UM8T/tSpiSH9gONtyaFYLkfVKHbhv2aDCwIEnthDk+4faf5N9RzawpoY
         Qe27f6FOB5GsQ/NQQedhE4ZJmkp3i9Bbttmr9VE8Pj62jtmxe5G6ZqBn6CUeB13gsJFT
         GliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eLzL6RHeFdZbRB5oFC0iJ795TBzqFT5ovI/MwJrKVk=;
        b=eiA5DvksMQP1HiV5Tuk9RAoRbP7/IeNAr8iJFy5I+ZwnrrhVBDhX9Bnhbs3J1G/M50
         E536UZEynQ8b7wfV4XnaYiA7sqJTwSQSKGVBZLG65PD0/VQJLYsrrFb0wQWoGI0q4WXU
         Wz25AEH+NWPcSktmsEMiboDYCpTheR8OUUm2oIiX8Q6u2j6aioxxg7fu3OP08a9k0flU
         f34x3wLS6pxMi8We05Fm4Tk682UcbXG3qQuGEvZOZeVZsbv47cwx8MNPc/n2Hj+bXMgc
         LdQxPUz2aRrLWBg9c38bW6Kx+w6tA8S5CP49AYnTX12bh2Kk2pQobWjYbv/8vdjRxlH9
         PP3g==
X-Gm-Message-State: AFqh2kruaOSFBoz855EZnR0WlKo5WVOWQxnSV0W2SR92a9ypHjJghEEy
        DZuiK2SwbgjdgUVw2uub90UQzMDuX4w=
X-Google-Smtp-Source: AMrXdXvrHv3ZAwS3fQ/OCRP/gup9EskfAqpVKQwrbofhFp/7IXGRuSpH+yzdGI9HlCLagGnSix+y0aiJr6A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a5b:305:0:b0:707:473f:b763 with SMTP id
 j5-20020a5b0305000000b00707473fb763mr7071095ybp.158.1673297724036; Mon, 09
 Jan 2023 12:55:24 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:36 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-42-surenb@google.com>
Subject: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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

rw_semaphore is a sizable structure of 40 bytes and consumes
considerable space for each vm_area_struct. However vma_lock has
two important specifics which can be used to replace rw_semaphore
with a simpler structure:
1. Readers never wait. They try to take the vma_lock and fall back to
mmap_lock if that fails.
2. Only one writer at a time will ever try to write-lock a vma_lock
because writers first take mmap_lock in write mode.
Because of these requirements, full rw_semaphore functionality is not
needed and we can replace rw_semaphore with an atomic variable.
When a reader takes read lock, it increments the atomic unless the
value is negative. If that fails read-locking is aborted and mmap_lock
is used instead.
When writer takes write lock, it resets atomic value to -1 if the
current value is 0 (no readers). Since all writers take mmap_lock in
write mode first, there can be only one writer at a time. If there
are readers, writer will place itself into a wait queue using new
mm_struct.vma_writer_wait waitqueue head. The last reader to release
the vma_lock will signal the writer to wake up.
vm_lock_seq is also moved into vma_lock and along with atomic_t they
are nicely packed and consume 8 bytes, bringing the overhead from
vma_lock from 44 to 16 bytes:

    slabinfo before the changes:
     <name>            ... <objsize> <objperslab> <pagesperslab> : ...
    vm_area_struct    ...    152   53    2 : ...

    slabinfo with vma_lock:
     <name>            ... <objsize> <objperslab> <pagesperslab> : ...
    rw_semaphore      ...      8  512    1 : ...
    vm_area_struct    ...    160   51    2 : ...

Assuming 40000 vm_area_structs, memory consumption would be:
baseline: 6040kB
vma_lock (vm_area_structs+vma_lock): 6280kB+316kB=6596kB
Total increase: 556kB

atomic_t might overflow if there are many competing readers, therefore
vma_read_trylock() implements an overflow check and if that occurs it
restors the previous value and exits with a failure to lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 37 +++++++++++++++++++++++++------------
 include/linux/mm_types.h | 10 ++++++++--
 kernel/fork.c            |  6 +++---
 mm/init-mm.c             |  2 ++
 4 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d40bf8a5e19e..294dd44b2198 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -627,12 +627,16 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
 	mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
-	if (vma->vm_lock_seq == mm_lock_seq)
+	if (vma->vm_lock->lock_seq == mm_lock_seq)
 		return;
 
-	down_write(&vma->vm_lock->lock);
-	vma->vm_lock_seq = mm_lock_seq;
-	up_write(&vma->vm_lock->lock);
+	if (atomic_cmpxchg(&vma->vm_lock->count, 0, -1))
+		wait_event(vma->vm_mm->vma_writer_wait,
+			   atomic_cmpxchg(&vma->vm_lock->count, 0, -1) == 0);
+	vma->vm_lock->lock_seq = mm_lock_seq;
+	/* Write barrier to ensure lock_seq change is visible before count */
+	smp_wmb();
+	atomic_set(&vma->vm_lock->count, 0);
 }
 
 /*
@@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
 static inline bool vma_read_trylock(struct vm_area_struct *vma)
 {
 	/* Check before locking. A race might cause false locked result. */
-	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
+	if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
 		return false;
 
+	/* If atomic_t overflows, restore and fail to lock. */
+	if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
+		if (atomic_dec_and_test(&vma->vm_lock->count))
+			wake_up(&vma->vm_mm->vma_writer_wait);
+		return false;
+	}
+
 	/*
 	 * Overflow might produce false locked result.
 	 * False unlocked result is impossible because we modify and check
 	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
 	 */
-	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock->lock);
+	if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
+		if (atomic_dec_and_test(&vma->vm_lock->count))
+			wake_up(&vma->vm_mm->vma_writer_wait);
 		return false;
 	}
 	return true;
@@ -664,7 +676,8 @@ static inline bool vma_read_trylock(struct vm_area_struct *vma)
 
 static inline void vma_read_unlock(struct vm_area_struct *vma)
 {
-	up_read(&vma->vm_lock->lock);
+	if (atomic_dec_and_test(&vma->vm_lock->count))
+		wake_up(&vma->vm_mm->vma_writer_wait);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -674,13 +687,13 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
+	VM_BUG_ON_VMA(vma->vm_lock->lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
 }
 
 static inline void vma_assert_no_reader(struct vm_area_struct *vma)
 {
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock) &&
-		      vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
+	VM_BUG_ON_VMA(atomic_read(&vma->vm_lock->count) > 0 &&
+		      vma->vm_lock->lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
 		      vma);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index faa61b400f9b..a6050c38ca2e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -527,7 +527,13 @@ struct anon_vma_name {
 };
 
 struct vma_lock {
-	struct rw_semaphore lock;
+	/*
+	 * count > 0 ==> read-locked with 'count' number of readers
+	 * count < 0 ==> write-locked
+	 * count = 0 ==> unlocked
+	 */
+	atomic_t count;
+	int lock_seq;
 };
 
 /*
@@ -566,7 +572,6 @@ struct vm_area_struct {
 	unsigned long vm_flags;
 
 #ifdef CONFIG_PER_VMA_LOCK
-	int vm_lock_seq;
 	struct vma_lock *vm_lock;
 #endif
 
@@ -706,6 +711,7 @@ struct mm_struct {
 					  * by mmlist_lock
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
+		struct wait_queue_head vma_writer_wait;
 		int mm_lock_seq;
 		struct {
 			struct list_head head;
diff --git a/kernel/fork.c b/kernel/fork.c
index 95db6a521cf1..b221ad182d98 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -461,9 +461,8 @@ static bool vma_init_lock(struct vm_area_struct *vma)
 	vma->vm_lock = kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
 	if (!vma->vm_lock)
 		return false;
-
-	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	atomic_set(&vma->vm_lock->count, 0);
+	vma->vm_lock->lock_seq = -1;
 
 	return true;
 }
@@ -1229,6 +1228,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
 #ifdef CONFIG_PER_VMA_LOCK
+	init_waitqueue_head(&mm->vma_writer_wait);
 	WRITE_ONCE(mm->mm_lock_seq, 0);
 	INIT_LIST_HEAD(&mm->vma_free_list.head);
 	spin_lock_init(&mm->vma_free_list.lock);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b53d23c2d7a3..0088e31e5f7e 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -38,6 +38,8 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
+	.vma_writer_wait =
+		__WAIT_QUEUE_HEAD_INITIALIZER(init_mm.vma_writer_wait),
 	.mm_lock_seq	= 0,
 	.vma_free_list.head = LIST_HEAD_INIT(init_mm.vma_free_list.head),
 	.vma_free_list.lock =  __SPIN_LOCK_UNLOCKED(init_mm.vma_free_list.lock),
-- 
2.39.0

