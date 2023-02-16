Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61A698BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBPFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBPFUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:20:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB643469
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k9-20020a25bec9000000b00944353b6a81so864551ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bIj4YrLTVPG3QwseSVPiqG0bxdZfORy7sIu/6u8O1k=;
        b=kcrkMPk51QPn4U+Qy9PCMBVvz0+hngRjWyUVg3mDY5eCPo5kdNdGQXXAF5nSKjvtxI
         ovQfwzu/2jGBzDo4t58Z0TFwD6xaqMMee+NhMptwfny7jSZBnt/+oKNA3aeQgGljd8sS
         akXety944Mg3EUnDXa5SJO4Zw7aGeTPZtwigMyHbadec4ytdul9kOPOFJ5Xa+9QmQgoM
         XeWGGTE6ollJyfe3sBlUvV2EFNH4AWaioDHTISUd5H/KMkPUAsjYGzb18bayjRFOkrs2
         88EaIEp+Df0ZGeekcwiDAUNprBAPetgMpUou+tgl+Oy9Z03QrXgN/piqimqVkufqqcTw
         xlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bIj4YrLTVPG3QwseSVPiqG0bxdZfORy7sIu/6u8O1k=;
        b=DQhhhcQxTqFfKwjtkbtZ+npx3UhLA0Tn0hgwW5AgAjcXAzMwobubUJr919IreKbDwE
         9AIQddKGd7MLyWfWru1d+xkQblxK2nvp+gdOelQoxm0oD3CaR1rqSti9JJB0Fy1S+AB/
         T8pel0u3zVv1HkUWtNLcW+pzpPyt2lRTpEIUDKAhvIRVuKda5FnSoC09mxRXLa/1oDJV
         w+p7+E1XAxwVz+Oic5JHmoRIwDuH7eNR1DtMmiLyP0PMxa6qSDUs9cKhwLI/bT4Yr/b2
         lci9JcY8154OeRbDe+fPwN537do8c2dKCGcAg3wcUMu2uPTn4L/P6Xw4/dOuVw1/DZ8m
         Es/A==
X-Gm-Message-State: AO0yUKU3i4TBtYYC0OvXrl4HbxsBDSYjCsTkBBhNR0isRxQcYrz0OHMP
        P4KNVfwRfIbuU8f9e596BLNciVDl94Y=
X-Google-Smtp-Source: AK7set8myT7mAaWBlS7bx8SxyKn+Tp8Tz7m7loe5CFurrliPBtK4ZSRcKwf3y/QxM2DkFEVl7Wxm2+r0UC8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a0d:ea05:0:b0:52e:fbcd:e1b4 with SMTP id
 t5-20020a0dea05000000b0052efbcde1b4mr590898ywe.0.1676524759267; Wed, 15 Feb
 2023 21:19:19 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:50 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-36-surenb@google.com>
Subject: [PATCH v3 35/35] mm: separate vma->lock from vm_area_struct
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
index cedef02dfd2b..96b18ef3bfa3 100644
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
index 212e7f923a69..30d4f867ae56 100644
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
index d0999de82f94..a152804faa14 100644
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
@@ -3089,6 +3131,9 @@ void __init proc_caches_init(void)
 			NULL);
 
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
+#ifdef CONFIG_PER_VMA_LOCK
+	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
+#endif
 	mmap_init();
 	nsproxy_cache_init();
 }
-- 
2.39.1

