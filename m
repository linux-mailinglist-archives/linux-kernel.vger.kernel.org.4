Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C956A4833
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjB0Rhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjB0Rh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D124C8D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pb4-20020a17090b3c0400b00237873bd59bso1903024pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/GJoky+VbSuk6dzXc8JP5Q5/FC6q697TPLIvz4vCWo=;
        b=NrffhdAmMk53hmq587bWVqAcVwUoFMyrGdI1dcdSP5rFWcjv1b2dxTOEh/45qUYAPi
         h/0PdE/bzVHMe1/toIQLnI1PA1/EP/QcNn95krcTC4R7+IMiZJdtCRCtMs9jcf3/2ANu
         i0kT+E3X8ZM+V+p/+ReYSUc0stVg3Z855SoJ4cBQAEK0+2hyKtIS1nwe4GOth2yQHLfU
         w8Fk0BJXAVVwtUoVe1w9Qpj9BUCfZjuVzX1iYFGwYp+nbDSsHPi+lTKw+kw0AGwaK95T
         wMmibkxVEN+68L0K6akco8ImKzGRBceFctt146aukjldpyDGZk2PpWKH7Fdr+teexTnY
         XHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/GJoky+VbSuk6dzXc8JP5Q5/FC6q697TPLIvz4vCWo=;
        b=FZgkv9M06A5N+ND4afJa3HnHo/kwU/qmb2eYNLor4KmmvUOcv98faVTgOFZMrec+pa
         82wCj/+o1l5euOHghBDrF08iMG3QDwHXRaF6C4SBUzY6GfMP3nvi4DOsDcSehSsqN4Xt
         Y3Er5DPq9CO6gF67G6amF5rc9DbpxtzXHSEcGRcYF6gXYKETCla1k9o3ijXeKUumYJDS
         g/kbCOeDEf6z1LWhaDk1bgE86XxDSk/6IeAm9B+ON/H8CRnW8eMZUfAnfgl9fH9ku7Mt
         Y6HAN8jDyUYQBAS+FAJp8VQ0fHw6HMHokHGzR20OtALcjBULoVpMGkvfpRkn65jHE19P
         yDMg==
X-Gm-Message-State: AO0yUKW7x++oNwJ+lOCJhoUSR8qv7ZvrBeaP/5HNEoS8MvdwhpF+plNt
        OCU+tvSlucp/CsDOkwJP20tuhx/xz5c=
X-Google-Smtp-Source: AK7set/svLuIVJzjBHat6rB8sP8zcMP/ZnW0bz7V1s9w04rE5j+sFd4oXDqXKYJ9s+zwLVwyfpWMezpHbsk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a17:90a:1081:b0:237:3b68:e50c with SMTP id
 c1-20020a17090a108100b002373b68e50cmr30137pja.1.1677519425412; Mon, 27 Feb
 2023 09:37:05 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:11 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-13-surenb@google.com>
Subject: [PATCH v4 12/33] mm: add per-VMA lock and helper functions to control it
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

Introduce per-VMA locking. The lock implementation relies on a
per-vma and per-mm sequence counters to note exclusive locking:
  - read lock - (implemented by vma_start_read) requires the vma
    (vm_lock_seq) and mm (mm_lock_seq) sequence counters to differ.
    If they match then there must be a vma exclusive lock held somewhere.
  - read unlock - (implemented by vma_end_read) is a trivial vma->lock
    unlock.
  - write lock - (vma_start_write) requires the mmap_lock to be held
    exclusively and the current mm counter is assigned to the vma counter.
    This will allow multiple vmas to be locked under a single mmap_lock
    write lock (e.g. during vma merging). The vma counter is modified
    under exclusive vma lock.
  - write unlock - (vma_end_write_all) is a batch release of all vma
    locks held. It doesn't pair with a specific vma_start_write! It is
    done before exclusive mmap_lock is released by incrementing mm
    sequence counter (mm_lock_seq).
  - write downgrade - if the mmap_lock is downgraded to the read lock, all
    vma write locks are released as well (effectivelly same as write
    unlock).

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h        | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h  |  8 ++++
 include/linux/mmap_lock.h | 13 +++++++
 kernel/fork.c             |  4 ++
 mm/init-mm.c              |  3 ++
 5 files changed, 110 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..bbad5d4fa81b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -623,6 +623,87 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_init_lock(struct vm_area_struct *vma)
+{
+	init_rwsem(&vma->lock);
+	vma->vm_lock_seq = -1;
+}
+
+/*
+ * Try to read-lock a vma. The function is allowed to occasionally yield false
+ * locked result to avoid performance overhead, in which case we fall back to
+ * using mmap_lock. The function should never yield false unlocked result.
+ */
+static inline bool vma_start_read(struct vm_area_struct *vma)
+{
+	/* Check before locking. A race might cause false locked result. */
+	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
+		return false;
+
+	if (unlikely(down_read_trylock(&vma->lock) == 0))
+		return false;
+
+	/*
+	 * Overflow might produce false locked result.
+	 * False unlocked result is impossible because we modify and check
+	 * vma->vm_lock_seq under vma->lock protection and mm->mm_lock_seq
+	 * modification invalidates all existing locks.
+	 */
+	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
+		up_read(&vma->lock);
+		return false;
+	}
+	return true;
+}
+
+static inline void vma_end_read(struct vm_area_struct *vma)
+{
+	rcu_read_lock(); /* keeps vma alive till the end of up_read */
+	up_read(&vma->lock);
+	rcu_read_unlock();
+}
+
+static inline void vma_start_write(struct vm_area_struct *vma)
+{
+	int mm_lock_seq;
+
+	mmap_assert_write_locked(vma->vm_mm);
+
+	/*
+	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
+	 * mm->mm_lock_seq can't be concurrently modified.
+	 */
+	mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
+	if (vma->vm_lock_seq == mm_lock_seq)
+		return;
+
+	down_write(&vma->lock);
+	vma->vm_lock_seq = mm_lock_seq;
+	up_write(&vma->lock);
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	/*
+	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
+	 * mm->mm_lock_seq can't be concurrently modified.
+	 */
+	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline void vma_init_lock(struct vm_area_struct *vma) {}
+static inline bool vma_start_read(struct vm_area_struct *vma)
+		{ return false; }
+static inline void vma_end_read(struct vm_area_struct *vma) {}
+static inline void vma_start_write(struct vm_area_struct *vma) {}
+static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -631,6 +712,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_init_lock(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64a6b3f6b74f..a4e7493bacd7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -508,6 +508,11 @@ struct vm_area_struct {
 		vm_flags_t __private __vm_flags;
 	};
 
+#ifdef CONFIG_PER_VMA_LOCK
+	int vm_lock_seq;
+	struct rw_semaphore lock;
+#endif
+
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
@@ -644,6 +649,9 @@ struct mm_struct {
 					  * init_mm.mmlist, and are protected
 					  * by mmlist_lock
 					  */
+#ifdef CONFIG_PER_VMA_LOCK
+		int mm_lock_seq;
+#endif
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index e49ba91bb1f0..aab8f1b28d26 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -72,6 +72,17 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_end_write_all(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+	/* No races during update due to exclusive mmap_lock being held */
+	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+}
+#else
+static inline void vma_end_write_all(struct mm_struct *mm) {}
+#endif
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -114,12 +125,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
+	vma_end_write_all(mm);
 	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	vma_end_write_all(mm);
 	downgrade_write(&mm->mmap_lock);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index a63b739aeca9..e1dd79c7738c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		data_race(memcpy(new, orig, sizeof(*new)));
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_init_lock(new);
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -1216,6 +1217,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
+#ifdef CONFIG_PER_VMA_LOCK
+	mm->mm_lock_seq = 0;
+#endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index c9327abb771c..33269314e060 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -37,6 +37,9 @@ struct mm_struct init_mm = {
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
+#ifdef CONFIG_PER_VMA_LOCK
+	.mm_lock_seq	= 0,
+#endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
-- 
2.39.2.722.g9855ee24e9-goog

