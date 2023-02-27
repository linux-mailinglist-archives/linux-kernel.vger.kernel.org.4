Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2056A484D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjB0RjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjB0Rif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:35 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4EC55B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5376fa4106eso153593007b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWTCVIi1iYe9BSyPLwARD6DqoqWW7R5amHwkRUYAz6E=;
        b=VvMTeoUx5wjaqp/SSzBUAaS+m27RVNRJG9xutBinKMu13MVGWXfijU0pH0JIlVsRC1
         1Qknjm7glaZd1lyCyg2w4XYR8Ujs0gzzwHLsVcLBT5JFXNg2+dcUo8mzjU56oHRaJiRQ
         Altiy52UpcBlGHU2tonuXHP1Zm9pZ7kEpRw7jPUHYcNU+RFCFPTwsB2NLxILr5m4FxUQ
         wXg6Va2RO6AqeAKOrEiDyanAl+KkHyrgZ3Z09+ORgyuXVSSi/uNsL4P3Dex0so3Z5yvz
         p07UqCIp1qtZGFtqF1JFTZwh/gE+2skLmmiHZO8ONAXTewlE9Wn0WJhWMtveGR25I/cT
         TS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWTCVIi1iYe9BSyPLwARD6DqoqWW7R5amHwkRUYAz6E=;
        b=lktnUqcnI4g2PzYEfr9EG5KzJfuhx0IMMxEjyqeu/cwF3r91KCOwLoN82yxLEaypOh
         11z7l2vy52Umgt1i6ZuLZy/msQ6JglCjH3xbC4dZsHpLBkJpJsTbSIqfWvRdA8kb3tBi
         JMQ4toC+bxMEVGdlwVzSLYCO5CfkqgekN0420z6ByIRd2IjIPfOkle85vZnXJVEONB/1
         HNL98IQhT9zQ49Fxblr+GXHZP7KzA4XuQmYARrDGquB+VCTsk7eW/U4JC8ZNxsKTbr50
         ID4ZUpBXv4TgWrX6Uy13QGYAmAE/aEyAZyyl20tDdpb7OrSGyOTzhvr/ClDP5qM0HZDP
         utLw==
X-Gm-Message-State: AO0yUKXeq1jjFrVG0rESJIPFKbrsXhkYlXlEG7VVcmAesviXMdhZB/18
        whBiQcpuBs71jmdvaDBq32utbpqKdMM=
X-Google-Smtp-Source: AK7set/c7Ur53LQtByhAksTFTJWraikr5DWovedZqPtoMuJRVU+wfT7Y+cDjXpRHOc4B8/glLU8UK1K2Jrk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a5b:ecb:0:b0:a03:da3f:3e68 with SMTP id
 a11-20020a5b0ecb000000b00a03da3f3e68mr9397156ybs.12.1677519475458; Mon, 27
 Feb 2023 09:37:55 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:32 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-34-surenb@google.com>
Subject: [PATCH v4 33/33] mm: separate vma->lock from vm_area_struct
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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

vma->lock being part of the vm_area_struct causes performance regression
during page faults because during contention its count and owner fields
are constantly updated and having other parts of vm_area_struct used
during page fault handling next to them causes constant cache line
bouncing. Fix that by moving the lock outside of the vm_area_struct.
All attempts to keep vma->lock inside vm_area_struct in a separate
cache line still produce performance regression especially on NUMA
machines. Smallest regression was achieved when lock is placed in the
fourth cache line but that bloats vm_area_struct to 256 bytes.
Considering performance and memory impact, separate lock looks like
the best option. It increases memory footprint of each VMA but that
can be optimized later if the new size causes issues.
Note that after this change vma_init() does not allocate or
initialize vma->lock anymore. A number of drivers allocate a pseudo
VMA on the stack but they never use the VMA's lock, therefore it does
not need to be allocated. The future drivers which might need the VMA
lock should use vm_area_alloc()/vm_area_free() to allocate the VMA.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 23 ++++++-------
 include/linux/mm_types.h |  6 +++-
 kernel/fork.c            | 73 ++++++++++++++++++++++++++++++++--------
 3 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5e142bfe7a58..3d4bb18dfcb7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -627,12 +627,6 @@ struct vm_operations_struct {
 };
 
 #ifdef CONFIG_PER_VMA_LOCK
-static inline void vma_init_lock(struct vm_area_struct *vma)
-{
-	init_rwsem(&vma->lock);
-	vma->vm_lock_seq = -1;
-}
-
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
@@ -644,17 +638,17 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->lock) == 0))
+	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
 		return false;
 
 	/*
 	 * Overflow might produce false locked result.
 	 * False unlocked result is impossible because we modify and check
-	 * vma->vm_lock_seq under vma->lock protection and mm->mm_lock_seq
+	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
 	 */
 	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->lock);
+		up_read(&vma->vm_lock->lock);
 		return false;
 	}
 	return true;
@@ -663,7 +657,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	rcu_read_lock(); /* keeps vma alive till the end of up_read */
-	up_read(&vma->lock);
+	up_read(&vma->vm_lock->lock);
 	rcu_read_unlock();
 }
 
@@ -681,9 +675,9 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (vma->vm_lock_seq == mm_lock_seq)
 		return;
 
-	down_write(&vma->lock);
+	down_write(&vma->vm_lock->lock);
 	vma->vm_lock_seq = mm_lock_seq;
-	up_write(&vma->lock);
+	up_write(&vma->vm_lock->lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -720,6 +714,10 @@ static inline void vma_mark_detached(struct vm_area_struct *vma,
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
+/*
+ * WARNING: vma_init does not initialize vma->vm_lock.
+ * Use vm_area_alloc()/vm_area_free() if vma needs locking.
+ */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -729,7 +727,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
-	vma_init_lock(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6768533a6b7c..89bbf7d8a312 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -471,6 +471,10 @@ struct anon_vma_name {
 	char name[];
 };
 
+struct vma_lock {
+	struct rw_semaphore lock;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -510,7 +514,7 @@ struct vm_area_struct {
 
 #ifdef CONFIG_PER_VMA_LOCK
 	int vm_lock_seq;
-	struct rw_semaphore lock;
+	struct vma_lock *vm_lock;
 
 	/* Flag to indicate areas detached from the mm->mm_mt tree */
 	bool detached;
diff --git a/kernel/fork.c b/kernel/fork.c
index ad37f1d0c5ab..75792157f51a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -451,13 +451,49 @@ static struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
+#ifdef CONFIG_PER_VMA_LOCK
+
+/* SLAB cache for vm_area_struct.lock */
+static struct kmem_cache *vma_lock_cachep;
+
+static bool vma_lock_alloc(struct vm_area_struct *vma)
+{
+	vma->vm_lock = kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
+	if (!vma->vm_lock)
+		return false;
+
+	init_rwsem(&vma->vm_lock->lock);
+	vma->vm_lock_seq = -1;
+
+	return true;
+}
+
+static inline void vma_lock_free(struct vm_area_struct *vma)
+{
+	kmem_cache_free(vma_lock_cachep, vma->vm_lock);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline bool vma_lock_alloc(struct vm_area_struct *vma) { return true; }
+static inline void vma_lock_free(struct vm_area_struct *vma) {}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 
 	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (vma)
-		vma_init(vma, mm);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+	if (!vma_lock_alloc(vma)) {
+		kmem_cache_free(vm_area_cachep, vma);
+		return NULL;
+	}
+
 	return vma;
 }
 
@@ -465,24 +501,30 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 {
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 
-	if (new) {
-		ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
-		ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-		/*
-		 * orig->shared.rb may be modified concurrently, but the clone
-		 * will be reinitialized.
-		 */
-		data_race(memcpy(new, orig, sizeof(*new)));
-		INIT_LIST_HEAD(&new->anon_vma_chain);
-		vma_init_lock(new);
-		dup_anon_vma_name(orig, new);
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	/*
+	 * orig->shared.rb may be modified concurrently, but the clone
+	 * will be reinitialized.
+	 */
+	data_race(memcpy(new, orig, sizeof(*new)));
+	if (!vma_lock_alloc(new)) {
+		kmem_cache_free(vm_area_cachep, new);
+		return NULL;
 	}
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+	dup_anon_vma_name(orig, new);
+
 	return new;
 }
 
 void __vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
+	vma_lock_free(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
@@ -493,7 +535,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 						  vm_rcu);
 
 	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock), vma);
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
 	__vm_area_free(vma);
 }
 #endif
@@ -3160,6 +3202,9 @@ void __init proc_caches_init(void)
 			NULL);
 
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
+#ifdef CONFIG_PER_VMA_LOCK
+	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
+#endif
 	mmap_init();
 	nsproxy_cache_init();
 }
-- 
2.39.2.722.g9855ee24e9-goog

