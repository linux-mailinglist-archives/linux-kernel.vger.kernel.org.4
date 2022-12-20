Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05935652696
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLTStb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiLTSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:48:57 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C216C1AD85
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:48:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671562122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/dnH9RYPPLTjIw2WCUFM/32RZYGdnaOT5UpnmSHjE2I=;
        b=rCkLvIPOdnRkbm0tFZupJXUJI8sv+NBbuWllfWz8+rNqUpkljcDxqur1kaMOev6cPnazSk
        fDT+xPF21vfQy/j2+NPOhG/0Yr3VG387Ua09ZRVvhcUsQPFSwkhkd7hH7ZNKucP+0lcbm3
        Xa4MbUYLMxe7awX+pT6KdT0gmZvRGgE=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Luther <Sven.Luther@windriver.com>
Subject: [PATCH RFC] ipc/mqueue: introduce msg cache
Date:   Tue, 20 Dec 2022 10:48:13 -0800
Message-Id: <20221220184813.1908318-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther reported a regression in the posix message queues
performance caused by switching to the per-object tracking of
slab objects introduced by patch series ending with the
commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
allocations").

To mitigate the regression cache allocated mqueue messages on a small
percpu cache instead of releasing and re-allocating them every time.

This change brings the performance measured by a benchmark kindly
provided by Sven [1] almost back to the original (or even better)
numbers. Measurements results are also provided by Sven.

+------------+---------------------------------+--------------------------------+
| kernel     | mqueue_rcv (ns)     variation   | mqueue_send (ns)   variation   |
| version    | min avg  max      min      avg  | min avg max       min     avg  |
+------------+--------------------------+---------------------------------------+
| 4.18.45    | 351 382 17533    base     base  | 383 410 13178     base    base |
| 5.8-good   | 380 392  7156   -7,63%  -2,55%  | 376 384  6225    1,86%   6,77% |
| 5.8-bad    | 524 530  5310  -33,02% -27,92%  | 512 519  8775  -25,20% -21,00% |
| 5.10       | 520 533  4078  -32,20% -28,33%  | 518 534  8108  -26,06% -23,22% |
| 5.15       | 431 444  8440  -18,56% -13,96%  | 425 437  6170   -9,88%  -6,18% |
| 6.0.3      | 474 614  3881  -25,95% -37,79%  | 482 693   931  -20,54% -40,84% |
| 6.1-rc8    | 496 509  8804  -29,23% -24,95%  | 493 512  5748  -22,31% -19,92% |
| 6.1-rc8+p  | 392 397  5479  -10,46%  -3,78%  | 364 369 10776    5,22%  11,11% |
+------------+---------------------------------+--------------------------------+

The last line reflects the result with this patch ("6.1-rc8+p").

[1]: https://lore.kernel.org/linux-mm/Y46lqCToUa%2FBgt%2Fc@P9FQF9L96D/T/

Reported-by: Sven Luther <Sven.Luther@windriver.com>
Tested-by: Sven Luther <Sven.Luther@windriver.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  12 +++++
 ipc/mqueue.c               |  20 ++++++--
 ipc/msg.c                  |  12 ++---
 ipc/msgutil.c              | 101 +++++++++++++++++++++++++++++++++----
 ipc/util.h                 |   8 ++-
 mm/memcontrol.c            |  62 +++++++++++++++++++++++
 6 files changed, 194 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1644a24009c..8b7f00d562a2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1734,8 +1734,10 @@ bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
+struct obj_cgroup *obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
+struct obj_cgroup *get_obj_cgroup_from_slab_obj(void *p);
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
@@ -1813,11 +1815,21 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
+static inline struct obj_cgroup *obj_cgroup_from_current(void)
+{
+	return NULL;
+}
+
 static inline struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 {
 	return NULL;
 }
 
+static inline struct obj_cgroup *get_obj_cgroup_from_slab_obj(void *p)
+{
+	return NULL;
+}
+
 static inline bool memcg_kmem_enabled(void)
 {
 	return false;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 467a194b8a2e..75bf83a8a36f 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -131,6 +131,11 @@ struct ext_wait_queue {		/* queue of sleeping tasks */
 	int state;		/* one of STATE_* values */
 };
 
+struct pcpu_msg_cache;
+struct msg_cache {
+	struct pcpu_msg_cache __percpu *pcpu_cache;
+};
+
 struct mqueue_inode_info {
 	spinlock_t lock;
 	struct inode vfs_inode;
@@ -152,6 +157,8 @@ struct mqueue_inode_info {
 	/* for tasks waiting for free space and messages, respectively */
 	struct ext_wait_queue e_wait_q[2];
 
+	struct msg_cache msg_cache;
+
 	unsigned long qsize; /* size of queue in memory (sum of all msgs) */
 };
 
@@ -368,6 +375,9 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 		mq_bytes = info->attr.mq_maxmsg * info->attr.mq_msgsize;
 		if (mq_bytes + mq_treesize < mq_bytes)
 			goto out_inode;
+		ret = init_msg_cache(&info->msg_cache);
+		if (ret)
+			goto out_inode;
 		mq_bytes += mq_treesize;
 		info->ucounts = get_ucounts(current_ucounts());
 		if (info->ucounts) {
@@ -531,9 +541,11 @@ static void mqueue_evict_inode(struct inode *inode)
 
 	list_for_each_entry_safe(msg, nmsg, &tmp_msg, m_list) {
 		list_del(&msg->m_list);
-		free_msg(msg);
+		free_msg(msg, NULL);
 	}
 
+	free_msg_cache(&info->msg_cache);
+
 	if (info->ucounts) {
 		unsigned long mq_bytes, mq_treesize;
 
@@ -1108,7 +1120,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 
 	/* First try to allocate memory, before doing anything with
 	 * existing queues. */
-	msg_ptr = load_msg(u_msg_ptr, msg_len);
+	msg_ptr = load_msg(u_msg_ptr, msg_len, &info->msg_cache);
 	if (IS_ERR(msg_ptr)) {
 		ret = PTR_ERR(msg_ptr);
 		goto out_fput;
@@ -1170,7 +1182,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 	wake_up_q(&wake_q);
 out_free:
 	if (ret)
-		free_msg(msg_ptr);
+		free_msg(msg_ptr, &info->msg_cache);
 out_fput:
 	fdput(f);
 out:
@@ -1273,7 +1285,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 			store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
 			ret = -EFAULT;
 		}
-		free_msg(msg_ptr);
+		free_msg(msg_ptr, &info->msg_cache);
 	}
 out_fput:
 	fdput(f);
diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb36d7..fcc09f848490 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -287,7 +287,7 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 
 	list_for_each_entry_safe(msg, t, &msq->q_messages, m_list) {
 		percpu_counter_sub_local(&ns->percpu_msg_hdrs, 1);
-		free_msg(msg);
+		free_msg(msg, NULL);
 	}
 	percpu_counter_sub_local(&ns->percpu_msg_bytes, msq->q_cbytes);
 	ipc_update_pid(&msq->q_lspid, NULL);
@@ -861,7 +861,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	if (mtype < 1)
 		return -EINVAL;
 
-	msg = load_msg(mtext, msgsz);
+	msg = load_msg(mtext, msgsz, NULL);
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
@@ -954,7 +954,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 out_unlock1:
 	rcu_read_unlock();
 	if (msg != NULL)
-		free_msg(msg);
+		free_msg(msg, NULL);
 	return err;
 }
 
@@ -1049,7 +1049,7 @@ static inline struct msg_msg *prepare_copy(void __user *buf, size_t bufsz)
 	/*
 	 * Create dummy message to copy real message to.
 	 */
-	copy = load_msg(buf, bufsz);
+	copy = load_msg(buf, bufsz, NULL);
 	if (!IS_ERR(copy))
 		copy->m_ts = bufsz;
 	return copy;
@@ -1058,7 +1058,7 @@ static inline struct msg_msg *prepare_copy(void __user *buf, size_t bufsz)
 static inline void free_copy(struct msg_msg *copy)
 {
 	if (copy)
-		free_msg(copy);
+		free_msg(copy, NULL);
 }
 #else
 static inline struct msg_msg *prepare_copy(void __user *buf, size_t bufsz)
@@ -1256,7 +1256,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 	}
 
 	bufsz = msg_handler(buf, msg, bufsz);
-	free_msg(msg);
+	free_msg(msg, NULL);
 
 	return bufsz;
 }
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..8667708fc00a 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -15,6 +15,7 @@
 #include <linux/proc_ns.h>
 #include <linux/uaccess.h>
 #include <linux/sched.h>
+#include <linux/memcontrol.h>
 
 #include "util.h"
 
@@ -39,16 +40,76 @@ struct msg_msgseg {
 	/* the next part of the message follows immediately */
 };
 
+struct pcpu_msg_cache {
+	struct msg_msg *msg;
+	struct obj_cgroup *objcg;
+	size_t len;
+};
+
+struct msg_cache {
+	struct pcpu_msg_cache __percpu *pcpu_cache;
+};
+
 #define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
 #define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
+int init_msg_cache(struct msg_cache *cache)
+{
+	cache->pcpu_cache = alloc_percpu(struct pcpu_msg_cache);
+	if (!cache->pcpu_cache)
+		return -ENOMEM;
+
+	return 0;
+}
 
-static struct msg_msg *alloc_msg(size_t len)
+void free_msg_cache(struct msg_cache *cache)
+{
+	int cpu;
+
+	if (!cache->pcpu_cache)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct pcpu_msg_cache *pc = per_cpu_ptr(cache->pcpu_cache, cpu);
+
+		if (pc->msg) {
+			if (pc->objcg)
+				obj_cgroup_put(pc->objcg);
+			free_msg(pc->msg, NULL);
+		}
+	}
+
+	free_percpu(cache->pcpu_cache);
+}
+
+static struct msg_msg *alloc_msg(size_t len, struct msg_cache *cache)
 {
 	struct msg_msg *msg;
 	struct msg_msgseg **pseg;
 	size_t alen;
 
+	if (cache) {
+		struct pcpu_msg_cache *pc;
+
+		msg = NULL;
+		pc = get_cpu_ptr(cache->pcpu_cache);
+		if (pc->msg && pc->len == len) {
+			struct obj_cgroup *objcg;
+
+			rcu_read_lock();
+			objcg = obj_cgroup_from_current();
+			if (objcg == pc->objcg) {
+				msg = pc->msg;
+				pc->msg = NULL;
+				obj_cgroup_put(pc->objcg);
+			}
+			rcu_read_unlock();
+		}
+		put_cpu_ptr(cache->pcpu_cache);
+		if (msg)
+			return msg;
+	}
+
 	alen = min(len, DATALEN_MSG);
 	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
 	if (msg == NULL)
@@ -77,18 +138,19 @@ static struct msg_msg *alloc_msg(size_t len)
 	return msg;
 
 out_err:
-	free_msg(msg);
+	free_msg(msg, NULL);
 	return NULL;
 }
 
-struct msg_msg *load_msg(const void __user *src, size_t len)
+struct msg_msg *load_msg(const void __user *src, size_t len,
+			 struct msg_cache *cache)
 {
 	struct msg_msg *msg;
 	struct msg_msgseg *seg;
 	int err = -EFAULT;
 	size_t alen;
 
-	msg = alloc_msg(len);
+	msg = alloc_msg(len, cache);
 	if (msg == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -104,14 +166,16 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
 			goto out_err;
 	}
 
-	err = security_msg_msg_alloc(msg);
-	if (err)
-		goto out_err;
+	if (!msg->security) {
+		err = security_msg_msg_alloc(msg);
+		if (err)
+			goto out_err;
+	}
 
 	return msg;
 
 out_err:
-	free_msg(msg);
+	free_msg(msg, NULL);
 	return ERR_PTR(err);
 }
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -166,10 +230,29 @@ int store_msg(void __user *dest, struct msg_msg *msg, size_t len)
 	return 0;
 }
 
-void free_msg(struct msg_msg *msg)
+void free_msg(struct msg_msg *msg, struct msg_cache *cache)
 {
 	struct msg_msgseg *seg;
 
+	if (cache) {
+		struct pcpu_msg_cache *pc;
+		bool cached = false;
+
+		pc = get_cpu_ptr(cache->pcpu_cache);
+		if (!pc->msg) {
+			pc->objcg = get_obj_cgroup_from_slab_obj(msg);
+			pc->len = msg->m_ts;
+			pc->msg = msg;
+
+			if (pc->objcg)
+				cached = true;
+		}
+		put_cpu_ptr(cache->pcpu_cache);
+
+		if (cached)
+			return;
+	}
+
 	security_msg_msg_free(msg);
 
 	seg = msg->next;
diff --git a/ipc/util.h b/ipc/util.h
index b2906e366539..a2da266386aa 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -196,8 +196,12 @@ static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
 int ipc_parse_version(int *cmd);
 #endif
 
-extern void free_msg(struct msg_msg *msg);
-extern struct msg_msg *load_msg(const void __user *src, size_t len);
+struct msg_cache;
+extern int init_msg_cache(struct msg_cache *cache);
+extern void free_msg_cache(struct msg_cache *cache);
+extern void free_msg(struct msg_msg *msg, struct msg_cache *cache);
+extern struct msg_msg *load_msg(const void __user *src, size_t len,
+				struct msg_cache *cache);
 extern struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst);
 extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a1a35c12635e..28528b4da0fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3004,6 +3004,28 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 	return objcg;
 }
 
+__always_inline struct obj_cgroup *obj_cgroup_from_current(void)
+{
+	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg;
+
+	if (memcg_kmem_bypass())
+		return NULL;
+
+	if (unlikely(active_memcg()))
+		memcg = active_memcg();
+	else
+		memcg = mem_cgroup_from_task(current);
+
+	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (likely(objcg))
+			return objcg;
+	}
+
+	return NULL;
+}
+
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct obj_cgroup *objcg = NULL;
@@ -3046,6 +3068,46 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	return objcg;
 }
 
+/*
+ * A passed kernel object must be a slab object or a generic kernel page.
+ * Not suitable for objects, allocated using vmalloc().
+ */
+struct obj_cgroup *get_obj_cgroup_from_slab_obj(void *p)
+{
+	struct obj_cgroup *objcg = NULL;
+	struct folio *folio;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	folio = virt_to_folio(p);
+	/*
+	 * Slab object can be either a true slab object, which are accounted
+	 * individually with objcg pointers stored in a separate objcg array,
+	 * or it can a generic folio with MEMCG_DATA_KMEM flag set.
+	 */
+	if (folio_test_slab(folio)) {
+		struct obj_cgroup **objcgs;
+		struct slab *slab;
+		unsigned int off;
+
+		slab = folio_slab(folio);
+		objcgs = slab_objcgs(slab);
+		if (!objcgs)
+			return NULL;
+
+		off = obj_to_index(slab->slab_cache, slab, p);
+		objcg = objcgs[off];
+	} else {
+		objcg = __folio_objcg(folio);
+	}
+
+	if (objcg)
+		obj_cgroup_get(objcg);
+
+	return objcg;
+}
+
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
 	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
-- 
2.39.0

