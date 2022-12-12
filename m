Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40F649EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiLLMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiLLMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:33:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C0810FF1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so15529717pje.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9KK76o4dD9Ujc2kSY8YS/TMhCbH0ifcsw1v6jMsH9w=;
        b=vDM5JZ9PWjxJSsFbX4zeNgVeJwoPx/YuH2ZWSgzqb0v5U/o6xLIvct0ERI5Efkbeit
         V6YEEOgr2pZFIhHaUlZLbjkhYqPaKMJZiKnXCLPecrVAL7g15fkX97PQtisdwyRMpUFS
         sWNar3cR+bphwYVpunKT6grWOAwBt026A1OLvMKcDVkqASUEWZRM5w1tlUUBdSPTBVq2
         eyQmu5wPMIDdkwvkLrHd9UZ/H95SfjbwyJeS4q38XJgcv3zsDWFn5dnnHb0kEWK4v28Q
         SQeNHZSJd61Qz03RtzGU46SBNl6LGHB25x7Dip98DivwnQ/s0QcimY39Zr9PhWPs/wIf
         ZcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9KK76o4dD9Ujc2kSY8YS/TMhCbH0ifcsw1v6jMsH9w=;
        b=SAqE+0yOt1W3c+yU5RVIZEJ8F7tSUnVR2Ao0oWLIz4REPoNcsOOc0TH0kDMCvNLDf6
         zDQ3Rp5GkdMig25ShjqeU3ckYW8xTYd/8AZGnOmgaU587Fh2LIZ46S8BjQYfOInOSKZB
         KEe4ZCkh6ORUZnwTeuTVGCU8N8NirnYBQCpzM7BkUSD2y64rBiVqE7AQt9BwAH3HbE5a
         sCikegDldvUR+qB9gbwXcFXbU5F8ehN6KCiAt/AVMcNOLTlsrQ/nTiP2qIQL/Z5uypMk
         RCT7S1BVZynnUchlGFfcG0/6a/SUX3LerH9CwzoxsbKcr5Xl4+4mvVBZztCNSWFX4Ymi
         2EnQ==
X-Gm-Message-State: ANoB5pl5MtvkPoXmXIhBrvIXZ/P21ygS4cvfWf5AUT2Gsh+1XHLnDGzA
        ak5rYQvQj97SDfG3kmw9C2kznQ==
X-Google-Smtp-Source: AA0mqf5plU2nTbnQpmt+zQLAjr/AmyrdZij0LjaIcIO9cK6LA32P2RJ0M6iBdWF4mA8B19ierGAdIw==
X-Received: by 2002:a17:902:ce06:b0:188:bc62:276f with SMTP id k6-20020a170902ce0600b00188bc62276fmr18388161plg.3.1670848371913;
        Mon, 12 Dec 2022 04:32:51 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001869ba04c83sm6219987plb.245.2022.12.12.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:32:51 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v7 3/5] kprobes: kretprobe scalability improvement with objpool
Date:   Mon, 12 Dec 2022 20:31:51 +0800
Message-Id: <20221212123153.190888-4-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
References: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
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
 include/linux/kprobes.h |   9 ++--
 include/linux/rethook.h |  14 ++----
 kernel/kprobes.c        | 101 +++++++++++++++++++---------------------
 kernel/trace/fprobe.c   |  37 ++++++---------
 kernel/trace/rethook.c  |  99 ++++++++++++++++++++-------------------
 5 files changed, 118 insertions(+), 142 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index a0b92be98984..122b1f21f3a9 100644
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
+	struct objpool_head	pool;
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
index c8ac1e5afcd1..f97283c622b7 100644
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
@@ -30,14 +30,13 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, struct pt_regs
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
  * @rcu: The rcu_head for deferred freeing.
  * @llist: The llist, linked to a struct task_struct::rethooks.
  * @rethook: The pointer to the struct rethook.
@@ -48,19 +47,15 @@ struct rethook {
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
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler, int size, int num);
 void rethook_free(struct rethook *rh);
-void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
 void rethook_recycle(struct rethook_node *node);
 void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
@@ -97,4 +92,3 @@ void rethook_flush_task(struct task_struct *tk);
 #endif
 
 #endif
-
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3050631e528d..5f35997b61f7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1868,13 +1868,28 @@ static struct notifier_block kprobe_exceptions_nb = {
 #ifdef CONFIG_KRETPROBES
 
 #if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
+
+/* callbacks for objpool of kretprobe instances */
+static int kretprobe_init_inst(void *nod, void *context)
+{
+	struct kretprobe_instance *ri = nod;
+
+	ri->rph = context;
+	return 0;
+}
+static int kretprobe_fini_pool(struct objpool_head *head, void *context)
+{
+	kfree(context);
+	return 0;
+}
+
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+	struct kretprobe_holder *rph = ri->rph;
 
-	if (refcount_dec_and_test(&ri->rph->ref))
-		kfree(ri->rph);
-	kfree(ri);
+	if (refcount_dec_and_test(&rph->ref))
+		objpool_fini(&rph->pool);
 }
 NOKPROBE_SYMBOL(free_rp_inst_rcu);
 
@@ -1883,7 +1898,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 	struct kretprobe *rp = get_kretprobe(ri);
 
 	if (likely(rp))
-		freelist_add(&ri->freelist, &rp->freelist);
+		objpool_push(ri, &rp->rph->pool);
 	else
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
@@ -1920,23 +1935,18 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 
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
+		nod = objpool_pop(&rph->pool);
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&rph->ref)) {
+			objpool_fini(&rph->pool);
+			break;
+		}
+	} while (nod);
 }
 
 /* This assumes the 'tsk' is the current task or the is not running. */
@@ -2078,19 +2088,17 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
+	struct kretprobe_holder *rph = rp->rph;
 	struct kretprobe_instance *ri;
-	struct freelist_node *fn;
 
-	fn = freelist_try_get(&rp->freelist);
-	if (!fn) {
+	ri = objpool_pop(&rph->pool);
+	if (!ri) {
 		rp->nmissed++;
 		return 0;
 	}
 
-	ri = container_of(fn, struct kretprobe_instance, freelist);
-
 	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-		freelist_add(&ri->freelist, &rp->freelist);
+		objpool_push(ri, &rph->pool);
 		return 0;
 	}
 
@@ -2183,7 +2191,6 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret;
-	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
 
@@ -2221,20 +2228,12 @@ int register_kretprobe(struct kretprobe *rp)
 #endif
 	}
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
-	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler);
-	if (!rp->rh)
-		return -ENOMEM;
+	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler,
+				sizeof(struct kretprobe_instance) +
+				rp->data_size, rp->maxactive);
+	if (IS_ERR(rp->rh))
+		return PTR_ERR(rp->rh);
 
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
@@ -2243,25 +2242,19 @@ int register_kretprobe(struct kretprobe *rp)
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
+	if (objpool_init(&rp->rph->pool, rp->maxactive, rp->data_size +
+			sizeof(struct kretprobe_instance), GFP_KERNEL,
+			rp->rph, kretprobe_init_inst, kretprobe_fini_pool)) {
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
index e8143e368074..9b685d6921d1 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -125,41 +125,32 @@ static void fprobe_init(struct fprobe *fp)
 
 static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
-	int i, size;
-
-	if (num < 0)
-		return -EINVAL;
+	int max;
 
 	if (!fp->exit_handler) {
 		fp->rethook = NULL;
 		return 0;
 	}
 
-	/* Initialize rethook if needed */
-	size = num * num_possible_cpus() * 2;
-	if (size < 0)
+	if (num <= 0)
+		return -EINVAL;
+	max = num * num_possible_cpus() * 2;
+	/* Fail if max overflows */
+	if (max <= 0)
 		return -E2BIG;
 
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
-	if (!fp->rethook)
-		return -ENOMEM;
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
+	/* Initialize rethook */
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
+				sizeof(struct fprobe_rethook_node), max);
+	if (IS_ERR(fp->rethook))
+		return PTR_ERR(fp->rethook);
+
 	return 0;
 }
 
 static void fprobe_fail_cleanup(struct fprobe *fp)
 {
-	if (fp->rethook) {
+	if (!IS_ERR_OR_NULL(fp->rethook)) {
 		/* Don't need to cleanup rethook->handler because this is not used. */
 		rethook_free(fp->rethook);
 		fp->rethook = NULL;
@@ -313,7 +304,7 @@ int unregister_fprobe(struct fprobe *fp)
 	 * current running handlers are finished, call unregister_ftrace_function()
 	 * after this.
 	 */
-	if (fp->rethook)
+	if (!IS_ERR_OR_NULL(fp->rethook))
 		rethook_free(fp->rethook);
 
 	ret = unregister_ftrace_function(&fp->ops);
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 32c3dfdb4d6a..6e1014e4f2f7 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -36,21 +36,16 @@ void rethook_flush_task(struct task_struct *tk)
 static void rethook_free_rcu(struct rcu_head *head)
 {
 	struct rethook *rh = container_of(head, struct rethook, rcu);
-	struct rethook_node *rhn;
-	struct freelist_node *node;
-	int count = 1;
-
-	node = rh->pool.head;
-	while (node) {
-		rhn = container_of(node, struct rethook_node, freelist);
-		node = node->next;
-		kfree(rhn);
-		count++;
-	}
+	struct rethook_node *nod;
 
-	/* The rh->ref is the number of pooled node + 1 */
-	if (refcount_sub_and_test(count, &rh->ref))
-		kfree(rh);
+	do {
+		nod = objpool_pop(&rh->pool);
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&rh->ref)) {
+			objpool_fini(&rh->pool);
+			break;
+		}
+	} while (nod);
 }
 
 /**
@@ -70,54 +65,65 @@ void rethook_free(struct rethook *rh)
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
 
+static int rethook_init_node(void *nod, void *context)
+{
+	struct rethook_node *node = nod;
+
+	node->rethook = context;
+	return 0;
+}
+
+static int rethook_fini_pool(struct objpool_head *head, void *context)
+{
+	kfree(context);
+	return 0;
+}
+
 /**
  * rethook_alloc() - Allocate struct rethook.
  * @data: a data to pass the @handler when hooking the return.
- * @handler: the return hook callback function.
+ * @handler: the return hook callback function, must NOT be NULL
+ * @gfp: default gfp for objpool allocation
+ * @size: node size: rethook node and additional data
+ * @num: number of rethook nodes to be preallocated
  *
  * Allocate and initialize a new rethook with @data and @handler.
- * Return NULL if memory allocation fails or @handler is NULL.
+ * Return pointer of new rethook, or error codes for failures.
+ *
  * Note that @handler == NULL means this rethook is going to be freed.
  */
-struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
+			      int size, int num)
 {
-	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
+	struct rethook *rh;
 
-	if (!rh || !handler) {
-		kfree(rh);
-		return NULL;
-	}
+	if (!handler || num <= 0 || size < sizeof(struct rethook_node))
+		return ERR_PTR(-EINVAL);
+
+	rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
+	if (!rh)
+		return ERR_PTR(-ENOMEM);
 
 	rh->data = data;
 	rh->handler = handler;
-	rh->pool.head = NULL;
-	refcount_set(&rh->ref, 1);
 
+	/* initialize the objpool for rethook nodes */
+	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
+			 rethook_init_node, rethook_fini_pool)) {
+		kfree(rh);
+		return ERR_PTR(-ENOMEM);
+	}
+	refcount_set(&rh->ref, num + 1);
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
+	if (refcount_dec_and_test(&rh->ref))
+		objpool_fini(&rh->pool);
 }
 
 /**
@@ -132,7 +138,7 @@ void rethook_recycle(struct rethook_node *node)
 	lockdep_assert_preemption_disabled();
 
 	if (likely(READ_ONCE(node->rethook->handler)))
-		freelist_add(&node->freelist, &node->rethook->pool);
+		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
 }
@@ -148,7 +154,6 @@ NOKPROBE_SYMBOL(rethook_recycle);
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
 	rethook_handler_t handler = READ_ONCE(rh->handler);
-	struct freelist_node *fn;
 
 	lockdep_assert_preemption_disabled();
 
@@ -165,11 +170,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	if (unlikely(!rcu_is_watching()))
 		return NULL;
 
-	fn = freelist_try_get(&rh->pool);
-	if (!fn)
-		return NULL;
-
-	return container_of(fn, struct rethook_node, freelist);
+	return (struct rethook_node *)objpool_pop(&rh->pool);
 }
 NOKPROBE_SYMBOL(rethook_try_get);
 
-- 
2.34.1

