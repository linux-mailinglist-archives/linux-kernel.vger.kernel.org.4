Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC6663218
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjAIU7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjAIU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83417A38A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4755eb8a57bso104764437b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4uicoifY7gC/4yqte16SYBfutCg5tFbw97tUXlS1Bs=;
        b=R+wIE/Pt4KhRz8VFgR0zMOS2JkvFmXy26q+OSQ9LjCyq0QISjHNPW3JBEjDsyfPMZn
         JHIhnIofZ7qGF96jAqweLgH0bhrxbWlUBYN16b0h3IUNriVtZxEflnZ/KJaCsGgJuROJ
         7NtSec9kWHRW8dxlpNmOxFIq510sDiRPIwm32r6PlWpXwb1OQmeULeUN7CB+D4fk8aTq
         1FAeEWt3FnKxXn+FEK6NZ2a1Nn+94uGmt6MDM7k61uLqgDX1MFlIF8o4Zu3p/TF9jRMz
         yr+WOD/8oTTja8WHghFFUJvljuYoTFD7DGiXYFX6wrr/dkh/UC1lDtuKJ2cCE65save6
         YCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4uicoifY7gC/4yqte16SYBfutCg5tFbw97tUXlS1Bs=;
        b=LBLwJVsp97v3SBem+s5WWlqEwK8msJw9MtgnoPVGCmCxaDpANpsVVdMNCMW20/F/tk
         OORzCnhb4Zp0iHxBh7nNxU3OK6P8421/jJj6KPYDZjzNzk96JoCX8g+NK6xuQPH6udT9
         w4zBzzeWHVnAk9mOD5dnLpd/ZhU/cwnATUiORtNMBiF84539/i1bqCttg3WhMRgTT2PT
         u8QJ9P/MNTPnLohSc6sEGUxGZlI2yYki9pzsaXN2nThKMgfX1C+HWwi1Eevt6BKiIrFV
         kqjYsZ+9w5HpwIinCe0N4VzrDgSAnPHR3yGuLutIsE10CKyTvy+GZljB17GJtnerrDlO
         +LNQ==
X-Gm-Message-State: AFqh2kqD7iHKVaFzBNPwbTBlIhUHymSESY6ZdyceXQ4NnE8a7IUVjH18
        QBHHE0mjcdPsS37koeBjNKz/+wYYYZE=
X-Google-Smtp-Source: AMrXdXufHU+YEXa/HPbI4vLLyfNw163JJwFMEsJciRnPr1X88dc4ccEYYlMB1fPlEQ5O4fkaQPa8neGtLug=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:9246:0:b0:6f2:2d54:dcdf with SMTP id
 e6-20020a259246000000b006f22d54dcdfmr6080399ybo.144.1673297718997; Mon, 09
 Jan 2023 12:55:18 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:34 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-40-surenb@google.com>
Subject: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
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

call_rcu() can take a long time when callback offloading is enabled.
Its use in the vm_area_free can cause regressions in the exit path when
multiple VMAs are being freed. To minimize that impact, place VMAs into
a list and free them in groups using one call_rcu() call per group.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h | 19 +++++++++--
 kernel/fork.c            | 68 +++++++++++++++++++++++++++++++++++-----
 mm/init-mm.c             |  3 ++
 mm/mmap.c                |  1 +
 5 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3158f33e268c..50c7a6dd9c7a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -250,6 +250,7 @@ void setup_initial_init_mm(void *start_code, void *end_code,
 struct vm_area_struct *vm_area_alloc(struct mm_struct *);
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
 void vm_area_free(struct vm_area_struct *);
+void drain_free_vmas(struct mm_struct *mm);
 
 #ifndef CONFIG_MMU
 extern struct rb_root nommu_region_tree;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fce9113d979c..c0e6c8e4700b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -592,8 +592,18 @@ struct vm_area_struct {
 	/* Information about our backing store: */
 	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
 					   units */
-	struct file * vm_file;		/* File we map to (can be NULL). */
-	void * vm_private_data;		/* was vm_pte (shared mem) */
+	union {
+		struct {
+			/* File we map to (can be NULL). */
+			struct file *vm_file;
+
+			/* was vm_pte (shared mem) */
+			void *vm_private_data;
+		};
+#ifdef CONFIG_PER_VMA_LOCK
+		struct list_head vm_free_list;
+#endif
+	};
 
 #ifdef CONFIG_ANON_VMA_NAME
 	/*
@@ -693,6 +703,11 @@ struct mm_struct {
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
 		int mm_lock_seq;
+		struct {
+			struct list_head head;
+			spinlock_t lock;
+			int size;
+		} vma_free_list;
 #endif
 
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 6d9f14e55ecf..97f2b751f88d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -481,26 +481,75 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
-static void __vm_area_free(struct rcu_head *head)
+static inline void __vm_area_free(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
-						  vm_rcu);
 	/* The vma should either have no lock holders or be write-locked. */
 	vma_assert_no_reader(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
-#endif
+
+static void vma_free_rcu_callback(struct rcu_head *head)
+{
+	struct vm_area_struct *first_vma;
+	struct vm_area_struct *vma, *vma2;
+
+	first_vma = container_of(head, struct vm_area_struct, vm_rcu);
+	list_for_each_entry_safe(vma, vma2, &first_vma->vm_free_list, vm_free_list)
+		__vm_area_free(vma);
+	__vm_area_free(first_vma);
+}
+
+void drain_free_vmas(struct mm_struct *mm)
+{
+	struct vm_area_struct *first_vma;
+	LIST_HEAD(to_destroy);
+
+	spin_lock(&mm->vma_free_list.lock);
+	list_splice_init(&mm->vma_free_list.head, &to_destroy);
+	mm->vma_free_list.size = 0;
+	spin_unlock(&mm->vma_free_list.lock);
+
+	if (list_empty(&to_destroy))
+		return;
+
+	first_vma = list_first_entry(&to_destroy, struct vm_area_struct, vm_free_list);
+	/* Remove the head which is allocated on the stack */
+	list_del(&to_destroy);
+
+	call_rcu(&first_vma->vm_rcu, vma_free_rcu_callback);
+}
+
+#define VM_AREA_FREE_LIST_MAX	32
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	bool drain;
+
+	free_anon_vma_name(vma);
+
+	spin_lock(&mm->vma_free_list.lock);
+	list_add(&vma->vm_free_list, &mm->vma_free_list.head);
+	mm->vma_free_list.size++;
+	drain = mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
+	spin_unlock(&mm->vma_free_list.lock);
+
+	if (drain)
+		drain_free_vmas(mm);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+void drain_free_vmas(struct mm_struct *mm) {}
 
 void vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
-#ifdef CONFIG_PER_VMA_LOCK
-	call_rcu(&vma->vm_rcu, __vm_area_free);
-#else
 	kmem_cache_free(vm_area_cachep, vma);
-#endif
 }
 
+#endif /* CONFIG_PER_VMA_LOCK */
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -1150,6 +1199,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	INIT_LIST_HEAD(&mm->mmlist);
 #ifdef CONFIG_PER_VMA_LOCK
 	WRITE_ONCE(mm->mm_lock_seq, 0);
+	INIT_LIST_HEAD(&mm->vma_free_list.head);
+	spin_lock_init(&mm->vma_free_list.lock);
+	mm->vma_free_list.size = 0;
 #endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 33269314e060..b53d23c2d7a3 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -39,6 +39,9 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
 	.mm_lock_seq	= 0,
+	.vma_free_list.head = LIST_HEAD_INIT(init_mm.vma_free_list.head),
+	.vma_free_list.lock =  __SPIN_LOCK_UNLOCKED(init_mm.vma_free_list.lock),
+	.vma_free_list.size = 0,
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
diff --git a/mm/mmap.c b/mm/mmap.c
index 332af383f7cd..a0d5d3af1d95 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3159,6 +3159,7 @@ void exit_mmap(struct mm_struct *mm)
 	trace_exit_mmap(mm);
 	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
+	drain_free_vmas(mm);
 	vm_unacct_memory(nr_accounted);
 }
 
-- 
2.39.0

