Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABC67EE91
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjA0Tnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjA0TnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA28A546
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5028c723d28so65352297b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXZYVjn5Y9alAXdawo6LSRZijnPMVBvcI/Ib+FHEz28=;
        b=dBDLlmFtxDGaSIxnsKi7TuOlfLmJDoa6COq6/jSvBgh64Qerq1YmsLWwhnAAxCyVf/
         g582eX0Eo4U8zmrxOFGYnkJmijlE67J9D9xBXGrS1NtU3RqxGXmBh2f947WBs0NX/Zll
         emlcCuJwSkFMTmaE18K/oCpx+uIqpIqH/tqes3ZD00h73pebtBtpRPZksR0g19LqKl4v
         xmDEdLHNhpj3CDXqX8SiQjapJ6l/dJ1IUEAjdkc/2LeqJcIWhkIf+A2Qxlo3WsGI6Yzg
         srHRwUq16G0bEIrEimCIRBcTpWLvsmh9iUkFM5cCzPZIfcbsD+d957wvwGuV97WpJ3D1
         vEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXZYVjn5Y9alAXdawo6LSRZijnPMVBvcI/Ib+FHEz28=;
        b=7PpcU/ReNrz6WTtym2Iw1X+0pHQ+uRBRf+Nd6Ux1HflBbRMN57dOQQV12HewNqvXoN
         /0u9bFKLdTzClf925X8Pt2VUtAYYmAvXHJzgv8qhYjF+xnYCcf6url8VIMYY10WVCDg7
         0xXhzMTf4Oe6yQaekydKGxjuOzbCooXY8+hVJ1MkW27T0WMQEhhghgv18ewGQznGPqVg
         xR1aR7rXMdQLcsBkGeyiu6E+YZqbQm4OXZ/SfehObJdZRZDZRWW6y9dYPyCP09D7Uj1i
         QSuDlzw8UPtiXtEx9H9lcF08ZCkjSA0+H5ZxLU345OALWAgemRuTgzZ1raLczzCjPaWg
         LjCA==
X-Gm-Message-State: AFqh2ko0jj7YuEELWcBExjwKBZ9J37jhyD9GGiOP8QqQ8VBiVRZlYATy
        Tf+ENdTMbEDRSuEeAH9u8/lMn/FkgzY=
X-Google-Smtp-Source: AMrXdXuJ9Lmn9omVCHOpi5PBakoG2f5tpLAKUWWlsexTwKMDDrEOz6rknp2w/KZIAkkkuCmWH0rkraaKink=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a05:6902:10cb:b0:7b8:16c:e66d with SMTP id
 w11-20020a05690210cb00b007b8016ce66dmr5496306ybu.85.1674848500886; Fri, 27
 Jan 2023 11:41:40 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:48 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-12-surenb@google.com>
Subject: [PATCH v2 11/33] mm: add per-VMA lock and helper functions to control it
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
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
index dd295c020e85..fee08e8fdce7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -617,6 +617,87 @@ struct vm_operations_struct {
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
@@ -625,6 +706,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_init_lock(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 62e413f84011..88619c6a29a3 100644
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
@@ -633,6 +638,9 @@ struct mm_struct {
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
index 314d51eb91da..9141427a98b2 100644
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
@@ -1147,6 +1148,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
2.39.1

