Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B7643B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiLFCPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiLFCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:15:16 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2311D0FD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:15:12 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:15:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670292910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3g+90RvlwUB9ZlXAss9NsspXI02DqqGD0/yx03JWUmE=;
        b=PAxFhp8rf/GPlK9H28H7nejs1R7o5VHMTtVp3+7gAP4CvZlM6zGhGkY3v7eJdywvoqPi4P
        fhsrnbPBiYizeXRuI7irNmXlDRLuZ8OOj8KG6Mq2z88gClKMbxPMR4Lk4dEIOQFrL3p7EW
        kFv2HhiRbu47Z/1GEbxJMst7VJ1nriA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "Luther, Sven" <Sven.Luther@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Bonn, Jonas" <Jonas.Bonn@windriver.com>
Subject: Re: [Regression] mqueue performance degradation after "The new
 cgroup slab memory controller" patchset.
Message-ID: <Y46lqCToUa/Bgt/c@P9FQF9L96D>
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:55:48PM +0000, Luther, Sven wrote:
> #regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792
> 
> We are making heavy use of mqueues, and noticed a degradation of performance between 4.18 & 5.10 linux kernels.
> 
> After a gross per-version tracing, we did kernel bisection between 5.8 and 5.9
> and traced the issue to a 10 patches (of which 9 where skipped as they didn't boot) between:
> 
> 
> commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)
> Author: Roman Gushchin <guro@fb.com>
> Date:   Thu Aug 6 23:21:27 2020 -0700
> 
>     mm: memcg/slab: use a single set of kmem_caches for all allocations
> 
> and:
> 
> commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8ed7a04279ae277f0f024430246ea5eec)
> Author: Roman Gushchin <guro@fb.com>
> Date:   Thu Aug 6 23:20:52 2020 -0700
> 
>     mm: memcg/slab: allocate obj_cgroups for non-root slab pages
> 
> All of them are part of the "The new cgroup slab memory controller" patchset:
> 
>   https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/
> 
> from Roman Gushchin, which moves the accounting for page level to the object level.
> 
> Measurements where done using the a test programmtest, which measures mix/average/max time mqueue_send/mqueue_rcv,
> and average for getppid, both measured over 100 000 runs. Results are shown in the following table
> 
> +----------+--------------------------+-------------------------+----------------+
> | kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getppid     |
> | version  | min avg  max   variation | min avg max   variation | (ns) variation |
> +----------+--------------------------+-------------------------+----------------+
> | 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149      base  |
> | 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -11,83%  |
> | 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -11,83%  |
> | 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -10,78%  |
> | 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -12,87%  |
> | 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -12,87%  |
> +----------+--------------------------+-------------------------+-----------------
>

Hi Sven!

To prove a concept of local msg caching, I'm mastered a patch (attached below).
In my test setup it seems to resolve most of the regression. Would you mind to
give it a try? (It's only tested on my local vm, don't treat it as a production
code). If it will fix the regression, I can invest more time into it and post
it in an umpstreamble form.

Here are my results (5 runs each):

Original (current mm tree, 6.1+):
RX: 1122/1202/114001 1197/1267/26517 1109/1173/29613 1091/1165/54434 1091/1160/26302
TX: 1176/1255/38168  1252/1360/27683 1165/1226/41454 1145/1222/90040 1146/1214/26595

No accounting:
RX: 984/1053/31268    1024/1091/39105 1018/1077/61515  999/1065/30423  1008/1060/115284
TX: 1020/1097/137690  1065/1143/31448 1055/1130/133278 1032/1106/52372 1043/1099/25705

Patched:
RX: 1033/1165/38579 1030/1108/43703 1022/1114/25653 1008/1110/38462 1089/1136/29120
TX: 1047/1184/25373 1048/1116/25425 1034/1122/61275 1022/1121/24636 1105/1155/46600

Thanks!

--

From 7742e074c25eb51d8e606585f0f8b06228d907f5 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Mon, 5 Dec 2022 18:13:15 -0800
Subject: [PATCH] ipc/mqueue: introduce msg cache

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 ipc/mqueue.c  | 20 ++++++++++---
 ipc/msg.c     | 12 ++++----
 ipc/msgutil.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++----
 ipc/util.h    |  8 ++++--
 4 files changed, 101 insertions(+), 18 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 467a194b8a2e..5c6fec8e9701 100644
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
+		free_msg(msg, &info->msg_cache);
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
index d0a0e877cadd..8fe64bb3f48d 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -39,16 +39,65 @@ struct msg_msgseg {
 	/* the next part of the message follows immediately */
 };
 
+struct pcpu_msg_cache {
+	struct msg_msg *msg;
+	struct task_struct *curr;
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
 
-static struct msg_msg *alloc_msg(size_t len)
+	return 0;
+}
+
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
+		if (pc->msg)
+			free_msg(pc->msg, NULL);
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
+		if (pc->msg && pc->curr == get_current() && pc->len == len) {
+			msg = pc->msg;
+			pc->msg = NULL;
+		}
+		put_cpu_ptr(cache->pcpu_cache);
+		if (msg)
+			return msg;
+	}
+
 	alen = min(len, DATALEN_MSG);
 	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
 	if (msg == NULL)
@@ -77,18 +126,19 @@ static struct msg_msg *alloc_msg(size_t len)
 	return msg;
 
 out_err:
-	free_msg(msg);
+	free_msg(msg, cache);
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
 
@@ -111,7 +161,7 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
 	return msg;
 
 out_err:
-	free_msg(msg);
+	free_msg(msg, cache);
 	return ERR_PTR(err);
 }
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -166,10 +216,27 @@ int store_msg(void __user *dest, struct msg_msg *msg, size_t len)
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
+			pc->curr = get_current();
+			pc->len = msg->m_ts;
+			pc->msg = msg;
+			cached = true;
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
 
-- 
2.38.1

