Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC36209EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiKHHQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiKHHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:15:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D732040
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:15:56 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 130so270780pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCxhSDrzUBBxTZOZiKeoOa/m+/P/IwBOdjgbDkYdvjk=;
        b=k7/16SHcRs70GqAawy//+XYKGDqzJ/V1pWkokhGoabaH3zOEyBYGRybRFQK5YnsD5d
         5p04aJjIj4qcJFxh14WVcn444yq2sTKX5v9R11sp/RW8jAAzu4136gEyE8tOpuKZPA0C
         GcZkzPdTgLT/TPvKvU5hXfbgh7LQMt5cq1ydldVIhnKB4flx+b6FquJeenFxN0T5iKX4
         bzUALDE1k81VQYEaoQdMJg4SvIYROVbpgxMdAKIqHKr6QO5PibKU+Ap+/yLspnfQir4e
         We0zVfsBa5v22vF0TLkfBcxdi2zYlMfbR5j2gFgRHQuk7ausjEfYscMjeVhJfAcGeyJH
         qXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCxhSDrzUBBxTZOZiKeoOa/m+/P/IwBOdjgbDkYdvjk=;
        b=Zrt7TOmBL/7zeNUMAAlLl9BF2fQjg9Oc1MepNAI2Sc63/6Go4IWeB4jtQPha7sa2BI
         85drHGeYzKuBxss7r3Mx1b8CbfZOaqWlEUlkPn1BMWME/4+yHS85W95FrGJvkLcjOhtp
         0EEzlFPy/H/PQrsrUTMuypqWxX9Qk+q0lIYa31ZunaTJ2h7K9fL1gKWQOyzr753j6XjO
         ztQpdi0t5fqN+haKiDPzg1rD5EEjjTgmpET1KApNe8INjGwl6SHT9eVpYpUbzc94ipD4
         exOSz0u3Bz4qnPniX9tTim7+r+82Ca6Yp99a0TGEhRqtqy3CVZ3A4mQ+Zd5tW8c/02qW
         3STg==
X-Gm-Message-State: ACrzQf0Dwy2hd92N5ZFKknj/M0wc+qrDsiB/Qz+0S0gjUmaln+DKHNuQ
        k+sYnfAYUyx3qWGAQ7V0oiUBJQ==
X-Google-Smtp-Source: AMsMyM6KfV5psFRflwMr62ZiuhKftOachMjjFrg7uxWvXdL5/O8KYr7WeuwaPdekicSKibZdV8m/8Q==
X-Received: by 2002:a65:6d1a:0:b0:3fb:2109:7b87 with SMTP id bf26-20020a656d1a000000b003fb21097b87mr31293425pgb.127.1667891755965;
        Mon, 07 Nov 2022 23:15:55 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b0017f592a7eccsm6123918plg.298.2022.11.07.23.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 23:15:55 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v6 3/4] kprobes: kretprobe scalability improvement with objpool
Date:   Tue,  8 Nov 2022 15:14:42 +0800
Message-Id: <20221108071443.258794-4-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108071443.258794-1-wuqiang.matt@bytedance.com>
References: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
 <20221108071443.258794-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kretprobe is using freelist to manage return-instances, but freelist,
as LIFO queue based on singly linked list, scales badly and reduces
the overall throughput of kretprobed routines, especially for high
contention scenarios.

Here's a typical throughput test of sys_flock (counts in 10 seconds,
measured with perf stat -a -I 10000 -e syscalls:sys_enter_flock):

OS: Debian 10 X86_64, Linux 6.1rc2
HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s

      1X       2X       4X       6X       8X      12X      16X
34762430 36546920 17949900 13101899 12569595 12646601 14729195
     24X      32X      48X      64X      72X      96X     128X
19263546 10102064  8985418 11936495 11493980  7127789  9330985

This patch introduces objpool to kretprobe and rethook, with orginal
freelist replaced and brings near-linear scalability to kretprobed
routines. Tests of kretprobe throughput show the biggest ratio as
333.9x of the original freelist. Here's the comparison:

                  1X         2X         4X         8X        16X
freelist:   34762430   36546920   17949900   12569595   14729195
objpool:    35627544   72182095  144068494  287564688  576903916
                 32X        48X        64X        96X       128X
freelist:   10102064    8985418   11936495    7127789    9330985
objpool:  1158876372 1737828164 2324371724 2380310472 2463182819

Tests on 96-core ARM64 system output similarly, but with the biggest
ratio up to 642.2x:

OS: Debian 10 AARCH64, Linux 6.1rc2
HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s

                  1X         2X         4X         8X        16X
freelist:   17498299   10887037   10224710    8499132    6421751
objpool:    18715726   35549845   71615884  144258971  283707220
                 24X        32X        48X        64X        96X
freelist:    5339868    4819116    3593919    3121575    2687167
objpool:   419830913  571609748  877456139 1143316315 1725668029

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/kprobes.h |  9 ++--
 include/linux/rethook.h | 15 +++----
 kernel/kprobes.c        | 95 +++++++++++++++++++----------------------
 kernel/trace/fprobe.c   | 17 ++------
 kernel/trace/rethook.c  | 80 +++++++++++++++++-----------------
 5 files changed, 95 insertions(+), 121 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index a0b92be98984..f13f01e600c2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -27,7 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
 #include <linux/refcount.h>
-#include <linux/freelist.h>
+#include <linux/objpool.h>
 #include <linux/rethook.h>
 #include <asm/kprobes.h>
 
@@ -141,6 +141,7 @@ static inline bool kprobe_ftrace(struct kprobe *p)
  */
 struct kretprobe_holder {
 	struct kretprobe	*rp;
+	struct objpool_head	oh;
 	refcount_t		ref;
 };
 
@@ -154,7 +155,6 @@ struct kretprobe {
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 	struct rethook *rh;
 #else
-	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
 #endif
 };
@@ -165,10 +165,7 @@ struct kretprobe_instance {
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 	struct rethook_node node;
 #else
-	union {
-		struct freelist_node freelist;
-		struct rcu_head rcu;
-	};
+	struct rcu_head rcu;
 	struct llist_node llist;
 	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index c8ac1e5afcd1..278ec65e71fe 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -6,7 +6,7 @@
 #define _LINUX_RETHOOK_H
 
 #include <linux/compiler.h>
-#include <linux/freelist.h>
+#include <linux/objpool.h>
 #include <linux/kallsyms.h>
 #include <linux/llist.h>
 #include <linux/rcupdate.h>
@@ -30,14 +30,14 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, struct pt_regs
 struct rethook {
 	void			*data;
 	rethook_handler_t	handler;
-	struct freelist_head	pool;
+	struct objpool_head	pool;
 	refcount_t		ref;
 	struct rcu_head		rcu;
 };
 
 /**
  * struct rethook_node - The rethook shadow-stack entry node.
- * @freelist: The freelist, linked to struct rethook::pool.
+ * @nod: The objpool node, linked to struct rethook::pool.
  * @rcu: The rcu_head for deferred freeing.
  * @llist: The llist, linked to a struct task_struct::rethooks.
  * @rethook: The pointer to the struct rethook.
@@ -48,19 +48,15 @@ struct rethook {
  * on each entry of the shadow stack.
  */
 struct rethook_node {
-	union {
-		struct freelist_node freelist;
-		struct rcu_head      rcu;
-	};
+	struct rcu_head		rcu;
 	struct llist_node	llist;
 	struct rethook		*rethook;
 	unsigned long		ret_addr;
 	unsigned long		frame;
 };
 
-struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler, gfp_t gfp, int size, int max);
 void rethook_free(struct rethook *rh);
-void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
 void rethook_recycle(struct rethook_node *node);
 void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
@@ -97,4 +93,3 @@ void rethook_flush_task(struct task_struct *tk);
 #endif
 
 #endif
-
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cd9f5a66a690..a8b202f87e2d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1865,10 +1865,12 @@ static struct notifier_block kprobe_exceptions_nb = {
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+	struct kretprobe_holder *rph = ri->rph;
 
-	if (refcount_dec_and_test(&ri->rph->ref))
-		kfree(ri->rph);
-	kfree(ri);
+	if (refcount_dec_and_test(&rph->ref)) {
+		objpool_fini(&rph->oh);
+		kfree(rph);
+	}
 }
 NOKPROBE_SYMBOL(free_rp_inst_rcu);
 
@@ -1877,7 +1879,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 	struct kretprobe *rp = get_kretprobe(ri);
 
 	if (likely(rp))
-		freelist_add(&ri->freelist, &rp->freelist);
+		objpool_push(ri, &rp->rph->oh);
 	else
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
@@ -1914,23 +1916,19 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 
 static inline void free_rp_inst(struct kretprobe *rp)
 {
-	struct kretprobe_instance *ri;
-	struct freelist_node *node;
-	int count = 0;
-
-	node = rp->freelist.head;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, freelist);
-		node = node->next;
-
-		kfree(ri);
-		count++;
-	}
+	struct kretprobe_holder *rph = rp->rph;
+	void *nod;
 
-	if (refcount_sub_and_test(count, &rp->rph->ref)) {
-		kfree(rp->rph);
-		rp->rph = NULL;
-	}
+	rp->rph = NULL;
+	do {
+		nod = objpool_pop(&rph->oh);
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&rph->ref)) {
+			objpool_fini(&rph->oh);
+			kfree(rph);
+			break;
+		}
+	} while (nod);
 }
 
 /* This assumes the 'tsk' is the current task or the is not running. */
@@ -2072,19 +2070,17 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
+	struct kretprobe_holder *rph = rp->rph;
 	struct kretprobe_instance *ri;
-	struct freelist_node *fn;
 
-	fn = freelist_try_get(&rp->freelist);
-	if (!fn) {
+	ri = objpool_pop(&rph->oh);
+	if (!ri) {
 		rp->nmissed++;
 		return 0;
 	}
 
-	ri = container_of(fn, struct kretprobe_instance, freelist);
-
 	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-		freelist_add(&ri->freelist, &rp->freelist);
+		objpool_push(ri, &rph->oh);
 		return 0;
 	}
 
@@ -2174,10 +2170,19 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
 	return 0;
 }
 
+#ifndef CONFIG_KRETPROBE_ON_RETHOOK
+static int kretprobe_init_inst(void *context, void *nod)
+{
+	struct kretprobe_instance *ri = nod;
+
+	ri->rph = context;
+	return 0;
+}
+#endif
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret;
-	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
 
@@ -2215,20 +2220,12 @@ int register_kretprobe(struct kretprobe *rp)
 #endif
 	}
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
-	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler);
+	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler, GFP_KERNEL,
+				sizeof(struct kretprobe_instance) + rp->data_size,
+				rp->maxactive);
 	if (!rp->rh)
 		return -ENOMEM;
 
-	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
-			       rp->data_size, GFP_KERNEL);
-		if (inst == NULL) {
-			rethook_free(rp->rh);
-			rp->rh = NULL;
-			return -ENOMEM;
-		}
-		rethook_add_node(rp->rh, &inst->node);
-	}
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
@@ -2237,25 +2234,19 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->rh = NULL;
 	}
 #else	/* !CONFIG_KRETPROBE_ON_RETHOOK */
-	rp->freelist.head = NULL;
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	if (!rp->rph)
 		return -ENOMEM;
 
-	rp->rph->rp = rp;
-	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
-			       rp->data_size, GFP_KERNEL);
-		if (inst == NULL) {
-			refcount_set(&rp->rph->ref, i);
-			free_rp_inst(rp);
-			return -ENOMEM;
-		}
-		inst->rph = rp->rph;
-		freelist_add(&inst->freelist, &rp->freelist);
+	if (objpool_init(&rp->rph->oh, rp->maxactive, rp->maxactive,
+			  rp->data_size + sizeof(struct kretprobe_instance),
+			  GFP_KERNEL, rp->rph, kretprobe_init_inst, NULL)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
+		return -ENOMEM;
 	}
-	refcount_set(&rp->rph->ref, i);
-
+	refcount_set(&rp->rph->ref, rp->maxactive + 1);
+	rp->rph->rp = rp;
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index e8143e368074..9a002bfbd216 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -125,7 +125,7 @@ static void fprobe_init(struct fprobe *fp)
 
 static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
-	int i, size;
+	int size;
 
 	if (num < 0)
 		return -EINVAL;
@@ -140,20 +140,11 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 	if (size < 0)
 		return -E2BIG;
 
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, GFP_KERNEL,
+				sizeof(struct fprobe_rethook_node), size);
 	if (!fp->rethook)
 		return -ENOMEM;
-	for (i = 0; i < size; i++) {
-		struct fprobe_rethook_node *node;
-
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node) {
-			rethook_free(fp->rethook);
-			fp->rethook = NULL;
-			return -ENOMEM;
-		}
-		rethook_add_node(fp->rethook, &node->node);
-	}
+
 	return 0;
 }
 
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index c69d82273ce7..01df98db2fbe 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -36,21 +36,17 @@ void rethook_flush_task(struct task_struct *tk)
 static void rethook_free_rcu(struct rcu_head *head)
 {
 	struct rethook *rh = container_of(head, struct rethook, rcu);
-	struct rethook_node *rhn;
-	struct freelist_node *node;
-	int count = 1;
+	struct rethook_node *nod;
 
-	node = rh->pool.head;
-	while (node) {
-		rhn = container_of(node, struct rethook_node, freelist);
-		node = node->next;
-		kfree(rhn);
-		count++;
-	}
-
-	/* The rh->ref is the number of pooled node + 1 */
-	if (refcount_sub_and_test(count, &rh->ref))
-		kfree(rh);
+	do {
+		nod = objpool_pop(&rh->pool);
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&rh->ref)) {
+			objpool_fini(&rh->pool);
+			kfree(rh);
+			break;
+		}
+	} while (nod);
 }
 
 /**
@@ -70,16 +66,28 @@ void rethook_free(struct rethook *rh)
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
 
+static int rethook_init_node(void *context, void *nod)
+{
+	struct rethook_node *node = nod;
+
+	node->rethook = context;
+	return 0;
+}
+
 /**
  * rethook_alloc() - Allocate struct rethook.
  * @data: a data to pass the @handler when hooking the return.
  * @handler: the return hook callback function.
+ * @gfp: default gfp for objpool allocation
+ * @size: rethook node size
+ * @max: number of rethook nodes to be preallocated
  *
  * Allocate and initialize a new rethook with @data and @handler.
  * Return NULL if memory allocation fails or @handler is NULL.
  * Note that @handler == NULL means this rethook is going to be freed.
  */
-struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler, gfp_t gfp,
+			      int size, int max)
 {
 	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
 
@@ -88,34 +96,26 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
 
 	rh->data = data;
 	rh->handler = handler;
-	rh->pool.head = NULL;
-	refcount_set(&rh->ref, 1);
 
+	/* initialize the objpool for rethook nodes */
+	if (objpool_init(&rh->pool, max, max, size, gfp, rh, rethook_init_node,
+			NULL)) {
+		kfree(rh);
+		return NULL;
+	}
+	refcount_set(&rh->ref, max + 1);
 	return rh;
 }
 
-/**
- * rethook_add_node() - Add a new node to the rethook.
- * @rh: the struct rethook.
- * @node: the struct rethook_node to be added.
- *
- * Add @node to @rh. User must allocate @node (as a part of user's
- * data structure.) The @node fields are initialized in this function.
- */
-void rethook_add_node(struct rethook *rh, struct rethook_node *node)
-{
-	node->rethook = rh;
-	freelist_add(&node->freelist, &rh->pool);
-	refcount_inc(&rh->ref);
-}
-
 static void free_rethook_node_rcu(struct rcu_head *head)
 {
 	struct rethook_node *node = container_of(head, struct rethook_node, rcu);
+	struct rethook *rh = node->rethook;
 
-	if (refcount_dec_and_test(&node->rethook->ref))
-		kfree(node->rethook);
-	kfree(node);
+	if (refcount_dec_and_test(&rh->ref)) {
+		objpool_fini(&rh->pool);
+		kfree(rh);
+	}
 }
 
 /**
@@ -130,7 +130,7 @@ void rethook_recycle(struct rethook_node *node)
 	lockdep_assert_preemption_disabled();
 
 	if (likely(READ_ONCE(node->rethook->handler)))
-		freelist_add(&node->freelist, &node->rethook->pool);
+		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
 }
@@ -146,7 +146,7 @@ NOKPROBE_SYMBOL(rethook_recycle);
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
 	rethook_handler_t handler = READ_ONCE(rh->handler);
-	struct freelist_node *fn;
+	struct rethook_node *nod;
 
 	lockdep_assert_preemption_disabled();
 
@@ -163,11 +163,11 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	if (unlikely(!rcu_is_watching()))
 		return NULL;
 
-	fn = freelist_try_get(&rh->pool);
-	if (!fn)
+	nod = (struct rethook_node *)objpool_pop(&rh->pool);
+	if (!nod)
 		return NULL;
 
-	return container_of(fn, struct rethook_node, freelist);
+	return nod;
 }
 NOKPROBE_SYMBOL(rethook_try_get);
 
-- 
2.34.1

