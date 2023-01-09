Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C23663215
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbjAIU7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjAIU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:22 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE288E9BB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:23 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4597b0ff5e9so105296977b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsiQb/dE9yymRpEr0UBz2Qq4KLrRHehGb+mEU6hVzX0=;
        b=sWtobSCBvoHV5TPkE/zYtWszgUW3jVRDiVjTt3sAcjFBaXlqjfdYiQ6AHG86rnNt0b
         mg+e+VoU+a89JO+rslq34FfyzRkAoGg7DuVDlMH1H1ePQ32MuB2+77t0gAtkJ+y+wX6p
         B/589/jsqLZApvm6BoQPTAcfoFYkEfWsjxaKMUYIa10AIrZvQul2s59ukdBVjUu/Ibrp
         egNG28U4wT5FZXec8pRJXGar6bKM6QyHpkRg0GkDbw6/Hl7olgQ7YiTkujC6hmd+0b7u
         2fP91n1+O4wNRIiFMGmQ1g/TPPehatod7VMoh0dY0z9ogD+TX+MKDQ5sfW6QhS4fa9cZ
         O/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsiQb/dE9yymRpEr0UBz2Qq4KLrRHehGb+mEU6hVzX0=;
        b=mE5jrXaVUYv/0RnvlEGxu2MomIHk2di19OwyAYbkCv2q0MczPgfCPNP6Ihj6SLWyCO
         7NrDWmRSxUrqqFOhThCqapEUhbhAYMUVdSmKX3K+yWouothbdHCPOq7ZLtMPEE7Sblfh
         h988FW5a9SYKbG7EeY1tGqjuDY53YxR8ogVmnX0lxgSP+4Dtgv1nCx/oHheXt9o05QP7
         5SR/Kv3DihFexE4Wz/Lp/ZXir2NBvGmUb9351Eicpiv+CWvn52tCBNzKxNIkdno81gk0
         hIpfupqpSpeMWfrIScxCBWf+e5cqJJqcjH11V00/Y7s74y2bDH3vKGao4sejejhgMsAF
         WIiA==
X-Gm-Message-State: AFqh2krNHOcLxaqn+b6kUfa33I1p/EKysLMj8Eg6e7cZ3mlJnTaqriY0
        hsA4cpEiIqfA/FdkwbFi9sZAHFn9UPY=
X-Google-Smtp-Source: AMrXdXvB4GUb8flK/fogRdz9aeHP/yrxt0+V7dhaMMs1drQdYkqQuuAWfxuEu+0du5vQqeydWK6w8e3+WKU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:abc6:0:b0:755:29c5:63e with SMTP id
 v64-20020a25abc6000000b0075529c5063emr6840356ybi.142.1673297721512; Mon, 09
 Jan 2023 12:55:21 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:35 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-41-surenb@google.com>
Subject: [PATCH 40/41] mm: separate vma->lock from vm_area_struct
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
will be addressed in the next patch.
Note that after this change vma_init() does not allocate or
initialize vma->lock anymore. A number of drivers allocate a pseudo
VMA on the stack but they never use the VMA's lock, therefore it does
not need to be allocated. The future drivers which might need the VMA
lock should use vm_area_alloc()/vm_area_free() to allocate it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 25 ++++++------
 include/linux/mm_types.h |  6 ++-
 kernel/fork.c            | 82 ++++++++++++++++++++++++++++------------
 3 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 50c7a6dd9c7a..d40bf8a5e19e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -615,11 +615,6 @@ struct vm_operations_struct {
 };
 
 #ifdef CONFIG_PER_VMA_LOCK
-static inline void vma_init_lock(struct vm_area_struct *vma)
-{
-	init_rwsem(&vma->lock);
-	vma->vm_lock_seq = -1;
-}
 
 static inline void vma_write_lock(struct vm_area_struct *vma)
 {
@@ -635,9 +630,9 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
 	if (vma->vm_lock_seq == mm_lock_seq)
 		return;
 
-	down_write(&vma->lock);
+	down_write(&vma->vm_lock->lock);
 	vma->vm_lock_seq = mm_lock_seq;
-	up_write(&vma->lock);
+	up_write(&vma->vm_lock->lock);
 }
 
 /*
@@ -651,17 +646,17 @@ static inline bool vma_read_trylock(struct vm_area_struct *vma)
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
@@ -669,7 +664,7 @@ static inline bool vma_read_trylock(struct vm_area_struct *vma)
 
 static inline void vma_read_unlock(struct vm_area_struct *vma)
 {
-	up_read(&vma->lock);
+	up_read(&vma->vm_lock->lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -684,7 +679,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_no_reader(struct vm_area_struct *vma)
 {
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock) &&
 		      vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
 		      vma);
 }
@@ -694,7 +689,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 #else /* CONFIG_PER_VMA_LOCK */
 
-static inline void vma_init_lock(struct vm_area_struct *vma) {}
 static inline void vma_write_lock(struct vm_area_struct *vma) {}
 static inline bool vma_read_trylock(struct vm_area_struct *vma)
 		{ return false; }
@@ -704,6 +698,10 @@ static inline void vma_assert_no_reader(struct vm_area_struct *vma) {}
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
+/*
+ * WARNING: vma_init does not initialize vma->vm_lock.
+ * Use vm_area_alloc()/vm_area_free() if vma needs locking.
+ */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -712,7 +710,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_init_lock(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c0e6c8e4700b..faa61b400f9b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -526,6 +526,10 @@ struct anon_vma_name {
 	char name[];
 };
 
+struct vma_lock {
+	struct rw_semaphore lock;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -563,7 +567,7 @@ struct vm_area_struct {
 
 #ifdef CONFIG_PER_VMA_LOCK
 	int vm_lock_seq;
-	struct rw_semaphore lock;
+	struct vma_lock *vm_lock;
 #endif
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 97f2b751f88d..95db6a521cf1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -451,40 +451,28 @@ static struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
-struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
+#ifdef CONFIG_PER_VMA_LOCK
 
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (vma)
-		vma_init(vma, mm);
-	return vma;
-}
+/* SLAB cache for vm_area_struct.lock */
+static struct kmem_cache *vma_lock_cachep;
 
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+static bool vma_init_lock(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma->vm_lock = kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
+	if (!vma->vm_lock)
+		return false;
 
-	if (new) {
-		ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
-		ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-		/*
-		 * orig->shared.rb may be modified concurrently, but the clone
-		 * will be reinitialized.
-		 */
-		*new = data_race(*orig);
-		INIT_LIST_HEAD(&new->anon_vma_chain);
-		vma_init_lock(new);
-		dup_anon_vma_name(orig, new);
-	}
-	return new;
+	init_rwsem(&vma->vm_lock->lock);
+	vma->vm_lock_seq = -1;
+
+	return true;
 }
 
-#ifdef CONFIG_PER_VMA_LOCK
 static inline void __vm_area_free(struct vm_area_struct *vma)
 {
 	/* The vma should either have no lock holders or be write-locked. */
 	vma_assert_no_reader(vma);
+	kmem_cache_free(vma_lock_cachep, vma->vm_lock);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
@@ -540,6 +528,7 @@ void vm_area_free(struct vm_area_struct *vma)
 
 #else /* CONFIG_PER_VMA_LOCK */
 
+static bool vma_init_lock(struct vm_area_struct *vma) { return true; }
 void drain_free_vmas(struct mm_struct *mm) {}
 
 void vm_area_free(struct vm_area_struct *vma)
@@ -550,6 +539,48 @@ void vm_area_free(struct vm_area_struct *vma)
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+	if (!vma_init_lock(vma)) {
+		kmem_cache_free(vm_area_cachep, vma);
+		return NULL;
+	}
+
+	return vma;
+}
+
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new;
+
+	new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	/*
+	 * orig->shared.rb may be modified concurrently, but the clone
+	 * will be reinitialized.
+	 */
+	*new = data_race(*orig);
+	if (!vma_init_lock(new)) {
+		kmem_cache_free(vm_area_cachep, new);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+	dup_anon_vma_name(orig, new);
+
+	return new;
+}
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -3138,6 +3169,9 @@ void __init proc_caches_init(void)
 			NULL);
 
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
+#ifdef CONFIG_PER_VMA_LOCK
+	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
+#endif
 	mmap_init();
 	nsproxy_cache_init();
 }
-- 
2.39.0

