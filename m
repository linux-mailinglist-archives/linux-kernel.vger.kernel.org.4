Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CC641DD1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLDQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLDQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:14:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493812D17
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 08:14:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so9306531pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGtwndgI8UEqPOO0PnTJqltJ8cF0ZzIkZVGVoqx5g7U=;
        b=S0Ssw7m4ARRRMu6nW+Kva05PXKWvf3Acb9LK+/1Lzo0yS1urLj4vk42azWsOYQ9Mk/
         vvgKvSKyOcbYvAexkvypjjQmxY++qgHnSFy3MvAWiH11SO7bGxPjPcUcIb+rp3mK6Jzj
         C1tzmjY+3x8CS19H+EX5X7k9ob7kvqxiAT1nRj7OTDvHraIRpoMmC9X2Hq6hFydwsqTR
         DH2LoqxHSAPr2ANb1nWI2JJyLA/V5QOSZdfdiMNs07UruRG1cGgztWOcxfIkOY8k5kmz
         qQqlMJ4ioaaOQ3JF/LU8C3DtpdRIsiXTw/cwDrfrRglzMiCaXwhFHbEfIa0q861c/8XF
         Bj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGtwndgI8UEqPOO0PnTJqltJ8cF0ZzIkZVGVoqx5g7U=;
        b=wkGQxEx5ynDgjrr5dab5NarQ5wqtzuqHfCZaQQsBLnAsBLwHQPf9kOMd7arurGc/3b
         shCyUG7TD82VvkZ5KqAJgTNEXca5Y2Bv8I9LqroLD+2aFETs/zkPO3yGZL822oGyWDv/
         UFlTqBo1i26C8ZwAkhzWUNth9l3XvrCfFi71y9CtdJs5ctCmzwGNIY2IeW0Q39rfrakS
         VfycNyWE8/NnTnQjRS52I7GCEo09yCojSFB1ov4j3KzsiQZyt+l7vcYDEQbZ4n8zvK46
         J0PsWBrXraqjQUDV+zIYy6RAPCruqiZi9qhBSSbjriYQiEZeIwI4QHvEA5qa5MO1KlZI
         ttcQ==
X-Gm-Message-State: ANoB5plnhbyvM/NGjUUBfCBmSUaiUn5BrqEFH+DWzi9HY/ydLnr2u2Ro
        l9Tgmfl/GTjUpoea9wHxjefpQA==
X-Google-Smtp-Source: AA0mqf6DgK4LnvIuxU4aE0M808KiJy5SK/exM7V/gZ3r5yAsh/0gzfLzHvsgZX1lH+4WUu9xA/vCbg==
X-Received: by 2002:a17:902:ef44:b0:189:6793:644f with SMTP id e4-20020a170902ef4400b001896793644fmr44945148plx.38.1670170466768;
        Sun, 04 Dec 2022 08:14:26 -0800 (PST)
Received: from Tower.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b0016cf3f124e1sm9000323plh.234.2022.12.04.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 08:14:26 -0800 (PST)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH 0/3] mm: replace atomic_t with percpu_ref in mempolicy.
Date:   Mon,  5 Dec 2022 00:14:29 +0800
Message-Id: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

All vma manipulation is somewhat protected by a down_read on
mmap_lock, so vma mempolicy is clear to obtain a reference.
But there is no locking in process context and have a mix
of reference counting and per-task requirements which is rather
subtle and easy to get wrong.

we would have get_vma_policy() always returning a reference
counted policy, except for static policy. For better performance,
we replace atomic_t ref with percpu_ref in mempolicy, which is
usually the performance bottleneck in hot path.

This series adjust the reference of mempolicy in process context,
which will be protected by RCU in read hot path. Besides,
task->mempolicy is also protected by task_lock(). Percpu_ref
is a good way to reduce cache line bouncing.

The mpol_get/put() can just increment or decrement the local
counter. Mpol_kill() must be called to initiate the destruction
of mempolicy. A mempolicy will be freed when the mpol_kill()
is called and the reference count decrese to zero.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/mempolicy.h      | 65 +++++++++++++++++++------------
 include/uapi/linux/mempolicy.h |  2 +-
 mm/mempolicy.c                 | 71 ++++++++++++++++++++++------------
 3 files changed, 89 insertions(+), 49 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..9178b008eadf 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -28,12 +28,16 @@ struct mm_struct;
  * of the current process.
  *
  * Locking policy for interleave:
- * In process context there is no locking because only the process accesses
- * its own state. All vma manipulation is somewhat protected by a down_read on
+ * percpu_ref is used to reduce cache line bouncing.
+ * In process context we should obtain a reference via mpol_get()
+ * protected by RCU.
+ * All vma manipulation is somewhat protected by a down_read on
  * mmap_lock.
  *
  * Freeing policy:
- * Mempolicy objects are reference counted.  A mempolicy will be freed when
+ * Mempolicy objects are reference counted. The mpol_get/put can just increment
+ * or decrement the local counter. Mpol_kill() must be called to initiate the
+ * destruction of mempolicy. A mempolicy will be freed when mpol_kill()/
  * mpol_put() decrements the reference count to zero.
  *
  * Duplicating policy objects:
@@ -42,43 +46,36 @@ struct mm_struct;
  * to 1, representing the caller of mpol_dup().
  */
 struct mempolicy {
-	atomic_t refcnt;
-	unsigned short mode; 	/* See MPOL_* above */
+	struct percpu_ref refcnt;	/* reduce cache line bouncing */
+	unsigned short mode;	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
+	int home_node;          /* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 	nodemask_t nodes;	/* interleave/bind/perfer */
-	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
+		struct rcu_head rcu;	/* used for freeing in an RCU-safe manner */
 	} w;
 };
 
 /*
- * Support for managing mempolicy data objects (clone, copy, destroy)
- * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
+ * Mempolicy pol need explicit unref after use, except for
+ * static policies(default_policy, preferred_node_policy).
  */
-
-extern void __mpol_put(struct mempolicy *pol);
-static inline void mpol_put(struct mempolicy *pol)
+static inline int mpol_needs_cond_ref(struct mempolicy *pol)
 {
-	if (pol)
-		__mpol_put(pol);
+	return (pol && !(pol->flags & MPOL_F_STATIC));
 }
 
 /*
- * Does mempolicy pol need explicit unref after use?
- * Currently only needed for shared policies.
+ * Put a mpol reference obtained via mpol_get().
  */
-static inline int mpol_needs_cond_ref(struct mempolicy *pol)
-{
-	return (pol && (pol->flags & MPOL_F_SHARED));
-}
 
-static inline void mpol_cond_put(struct mempolicy *pol)
+static inline void mpol_put(struct mempolicy *pol)
 {
 	if (mpol_needs_cond_ref(pol))
-		__mpol_put(pol);
+		percpu_ref_put(&pol->refcnt);
 }
 
 extern struct mempolicy *__mpol_dup(struct mempolicy *pol);
@@ -91,12 +88,28 @@ static inline struct mempolicy *mpol_dup(struct mempolicy *pol)
 
 #define vma_policy(vma) ((vma)->vm_policy)
 
+/* Obtain a reference on the specified mpol */
 static inline void mpol_get(struct mempolicy *pol)
 {
 	if (pol)
-		atomic_inc(&pol->refcnt);
+		percpu_ref_get(&pol->refcnt);
+}
+
+static inline bool mpol_tryget(struct mempolicy *pol)
+{
+	return pol && percpu_ref_tryget(&pol->refcnt);
 }
 
+/*
+ * This function initiates destruction of mempolicy.
+ */
+static inline void mpol_kill(struct mempolicy *pol)
+{
+        if (pol)
+                percpu_ref_kill(&pol->refcnt);
+}
+
+
 extern bool __mpol_equal(struct mempolicy *a, struct mempolicy *b);
 static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
@@ -197,11 +210,15 @@ static inline void mpol_put(struct mempolicy *p)
 {
 }
 
-static inline void mpol_cond_put(struct mempolicy *pol)
+static inline void mpol_get(struct mempolicy *pol)
 {
 }
 
-static inline void mpol_get(struct mempolicy *pol)
+static inline bool mpol_tryget(struct mempolicy *pol)
+{
+}
+
+static inline void mpol_kill(struct mempolicy *pol)
 {
 }
 
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 046d0ccba4cd..940e1a88a4da 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -60,7 +60,7 @@ enum {
  * "mode flags".  These flags are allocated from bit 0 up, as they
  * are never OR'ed into the mode in mempolicy API arguments.
  */
-#define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
+#define MPOL_F_STATIC	(1 << 0) /* identify static policies(e.g default_policy) */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..ee3e2ed5ef07 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -124,8 +124,8 @@ enum zone_type policy_zone = 0;
  * run-time system-wide default policy => local allocation
  */
 static struct mempolicy default_policy = {
-	.refcnt = ATOMIC_INIT(1), /* never free it */
 	.mode = MPOL_LOCAL,
+	.flags = MPOL_F_STATIC,
 };
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
@@ -158,9 +158,32 @@ int numa_map_to_online_node(int node)
 }
 EXPORT_SYMBOL_GPL(numa_map_to_online_node);
 
+/* Obtain a reference on the specified task mempolicy */
+static mempolicy *get_task_mpol(struct task_struct *p)
+{
+	struct mempolicy *pol;
+
+	rcu_read_lock();
+	pol = rcu_dereference(p->mempolicy);
+
+	if (!pol || mpol_tryget(pol))
+		pol = NULL;
+	rcu_read_unlock();
+
+	return pol;
+}
+
+static void mpol_release(struct percpu_ref *ref)
+{
+	struct mempolicy *mpol = container_of(ref, struct mempolicy, refcnt);
+
+	percpu_ref_exit(ref);
+	kfree_rcu(mpol, w.rcu);
+}
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
-	struct mempolicy *pol = p->mempolicy;
+	struct mempolicy *pol = get_task_mpol(p);
 	int node;
 
 	if (pol)
@@ -296,7 +319,12 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
 	if (!policy)
 		return ERR_PTR(-ENOMEM);
-	atomic_set(&policy->refcnt, 1);
+
+	if (percpu_ref_init(&policy->refcnt, mpol_release, 0,
+			GFP_KERNEL)) {
+		kmem_cache_free(policy_cache, policy);
+		return ERR_PTR(-ENOMEM);
+	}
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
@@ -304,14 +332,6 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	return policy;
 }
 
-/* Slow path of a mpol destructor. */
-void __mpol_put(struct mempolicy *p)
-{
-	if (!atomic_dec_and_test(&p->refcnt))
-		return;
-	kmem_cache_free(policy_cache, p);
-}
-
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
 }
@@ -1759,14 +1779,8 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		} else if (vma->vm_policy) {
 			pol = vma->vm_policy;
 
-			/*
-			 * shmem_alloc_page() passes MPOL_F_SHARED policy with
-			 * a pseudo vma whose vma->vm_ops=NULL. Take a reference
-			 * count on these policies which will be dropped by
-			 * mpol_cond_put() later
-			 */
-			if (mpol_needs_cond_ref(pol))
-				mpol_get(pol);
+			/* vma policy is protected by mmap_lock. */
+			mpol_get(pol);
 		}
 	}
 
@@ -2423,7 +2437,13 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
 		nodemask_t mems = cpuset_mems_allowed(current);
 		mpol_rebind_policy(new, &mems);
 	}
-	atomic_set(&new->refcnt, 1);
+
+	if (percpu_ref_init(&new->refcnt, mpol_release, 0,
+			GFP_KERNEL)) {
+		kmem_cache_free(policy_cache, new);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return new;
 }
 
@@ -2687,7 +2707,6 @@ static struct sp_node *sp_alloc(unsigned long start, unsigned long end,
 		kmem_cache_free(sn_cache, n);
 		return NULL;
 	}
-	newpol->flags |= MPOL_F_SHARED;
 	sp_node_init(n, start, end, newpol);
 
 	return n;
@@ -2720,7 +2739,10 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
 					goto alloc_new;
 
 				*mpol_new = *n->policy;
-				atomic_set(&mpol_new->refcnt, 1);
+				ret = percpu_ref_init(&mpol_new->refcnt,
+						mpol_release, 0, GFP_KERNEL);
+				if (ret)
+					goto err_out;
 				sp_node_init(n_new, end, n->end, mpol_new);
 				n->end = start;
 				sp_insert(sp, n_new);
@@ -2756,7 +2778,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
 	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
 	if (!mpol_new)
 		goto err_out;
-	atomic_set(&mpol_new->refcnt, 1);
+
 	goto restart;
 }
 
@@ -2917,7 +2939,8 @@ void __init numa_policy_init(void)
 		preferred_node_policy[nid] = (struct mempolicy) {
 			.refcnt = ATOMIC_INIT(1),
 			.mode = MPOL_PREFERRED,
-			.flags = MPOL_F_MOF | MPOL_F_MORON,
+			.flags = MPOL_F_MOF | MPOL_F_MORON
+				| MPOL_F_STATIC,
 			.nodes = nodemask_of_node(nid),
 		};
 	}
-- 
2.25.1

