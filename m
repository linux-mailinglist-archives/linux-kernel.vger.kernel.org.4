Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540CD6631ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjAIUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjAIUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD727A3A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4bdeb1bbeafso103864127b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=79bvrukKvLAS13wwuEGJsW+4aNck296i4OOdN8AZrSw=;
        b=TUshLIkna8lEowgf738l64K6OhURrpjePFxYxdKUuWhyUGH2D62dGB+OGRki5oXp4C
         xTYuRmR7XzQ7I/28ieatH6mJigev2F3K0HIzC6hflnBGI34WrRdJkJZ4AZfQFOQ8gGav
         9UNpZpO2F0owMoX4KYmO5GlLvBicz0eIhvCyoFVAlBVkJOLooeK67cBYtsiWvskUp6uE
         tE8t31WtIP9ueuHL/u/lXs1s/RC2HGn9FvMQfHmx5Itoy4F3Nj/5Ls77RI1e7g50JCXC
         9+/P6cV1602qOnEnSC6h6SSpk6hPN1ukv5Ai24vZZWfGTttvD7F17H6z929cULqI8Sm7
         oWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79bvrukKvLAS13wwuEGJsW+4aNck296i4OOdN8AZrSw=;
        b=ViMIKSjAFbjxHX3WXrkShqsK1hxUvVMtmuk0WB4Omn2JTReFvDPa+wgLMOYqmMbWh9
         WvNHBE9C/+g2/FiyPbFMZNZM5MgyhzKREMpsfDfYePQx9kgs4o1HT3dlF096SFD9r8wW
         7eEJb1PNctwdf0Jz3vMzG8z1pVEZ/LfVs3sDPirKw++rtI4Jf5Q87Nqf2WSFVWD9Noep
         te6TJJTQNfXmCvDAIJqFutsOddz4pZz3S9OuoW/ZAg7djP2UAdZha87wwmPKMjLBFEoT
         5suf8PmLXbz/nWYpoDsW1tljEU/JtPOasD2CiQF6nqzNQ4GQkAw3BCXIlcW28/iV4oXk
         IPTg==
X-Gm-Message-State: AFqh2kpSLqvCAdtju+A26IxdxNlYkY7a6pOlt7g6F7H3qLfYUge0epWz
        FlRcm1u3cvtmfWxIVmb257ytH1m1RHw=
X-Google-Smtp-Source: AMrXdXukETqaSxCpG7iZuCRz7oEpYHbdWSzbf1+vDAfX24FIika8R4beORIYrEIIAWwV84R+bp3+gXy0ol4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a0d:c481:0:b0:4ad:7104:1f66 with SMTP id
 g123-20020a0dc481000000b004ad71041f66mr3418570ywd.53.1673297651084; Mon, 09
 Jan 2023 12:54:11 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:07 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-13-surenb@google.com>
Subject: [PATCH 12/41] mm: add per-VMA lock and helper functions to control it
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

Introduce a per-VMA rw_semaphore to be used during page fault handling
instead of mmap_lock. Because there are cases when multiple VMAs need
to be exclusively locked during VMA tree modifications, instead of the
usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
exclusively and setting vma->lock_seq to the current mm->lock_seq. When
mmap_write_lock holder is done with all modifications and drops mmap_lock,
it will increment mm->lock_seq, effectively unlocking all VMAs marked as
locked.
VMA lock is placed on the cache line boundary so that its 'count' field
falls into the first cache line while the rest of the fields fall into
the second cache line. This lets the 'count' field to be cached with
other frequently accessed fields and used quickly in uncontended case
while 'owner' and other fields used in the contended case will not
invalidate the first cache line while waiting on the lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h        | 80 +++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h  |  8 ++++
 include/linux/mmap_lock.h | 13 +++++++
 kernel/fork.c             |  4 ++
 mm/init-mm.c              |  3 ++
 5 files changed, 108 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3f196e4d66d..ec2c4c227d51 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -612,6 +612,85 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_init_lock(struct vm_area_struct *vma)
+{
+	init_rwsem(&vma->lock);
+	vma->vm_lock_seq = -1;
+}
+
+static inline void vma_write_lock(struct vm_area_struct *vma)
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
+/*
+ * Try to read-lock a vma. The function is allowed to occasionally yield false
+ * locked result to avoid performance overhead, in which case we fall back to
+ * using mmap_lock. The function should never yield false unlocked result.
+ */
+static inline bool vma_read_trylock(struct vm_area_struct *vma)
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
+static inline void vma_read_unlock(struct vm_area_struct *vma)
+{
+	up_read(&vma->lock);
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
+static inline void vma_write_lock(struct vm_area_struct *vma) {}
+static inline bool vma_read_trylock(struct vm_area_struct *vma)
+		{ return false; }
+static inline void vma_read_unlock(struct vm_area_struct *vma) {}
+static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -620,6 +699,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_init_lock(vma);
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d5cdec1314fe..5f7c5ca89931 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -555,6 +555,11 @@ struct vm_area_struct {
 	pgprot_t vm_page_prot;
 	unsigned long vm_flags;		/* Flags, see mm.h. */
 
+#ifdef CONFIG_PER_VMA_LOCK
+	int vm_lock_seq;
+	struct rw_semaphore lock;
+#endif
+
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
@@ -680,6 +685,9 @@ struct mm_struct {
 					  * init_mm.mmlist, and are protected
 					  * by mmlist_lock
 					  */
+#ifdef CONFIG_PER_VMA_LOCK
+		int mm_lock_seq;
+#endif
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index e49ba91bb1f0..40facd4c398b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -72,6 +72,17 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_write_unlock_mm(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+	/* No races during update due to exclusive mmap_lock being held */
+	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+}
+#else
+static inline void vma_write_unlock_mm(struct mm_struct *mm) {}
+#endif
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -114,12 +125,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
+	vma_write_unlock_mm(mm);
 	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	vma_write_unlock_mm(mm);
 	downgrade_write(&mm->mmap_lock);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 5986817f393c..c026d75108b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_init_lock(new);
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -1145,6 +1146,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
+#ifdef CONFIG_PER_VMA_LOCK
+	WRITE_ONCE(mm->mm_lock_seq, 0);
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
2.39.0

