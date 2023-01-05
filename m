Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D37865E1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAEAto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAEAsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:48:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953BE485A8;
        Wed,  4 Jan 2023 16:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 101DCB81995;
        Thu,  5 Jan 2023 00:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F25C433A7;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=03Bt6VZE0iiaB506LPl1maokF6QUwrOMExAqox+g+f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrNXjIVy5QhqfQiF0bt0AqKTqhmBtA7navIdYm2RygiwsKm+TO7t6BIj+Tzlko6ZL
         rJ2gCyYs6D875tITyopmCPm+TXTz0n8tDltfvbZHVChoO9oN9Dat8GPaL1CUwRZT+m
         M7gN3OmtKJAPj554FVlXbWefViAiKHhfJYl5bzW2Ji3EsCV9Sk2UbMtjbRtvyGa6uS
         2d+KOVbW9hKJFWS5O/XWZ7Fu6dH8ZNfw8NEBSnAKnS8Z7wwbMHqBSM4hC4kLdnmyXl
         K7vTbCIFGmMsThIGlk2xkQqfJdm74VVGyDUYXdgAyQKbXtpJaSZ3u9tnGkb2guB5KN
         i8KAJ2k6kftgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E302D5C1ADF; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/7] refscale: Add tests using SLAB_TYPESAFE_BY_RCU
Date:   Wed,  4 Jan 2023 16:44:54 -0800
Message-Id: <20230105004501.1771332-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds three read-side-only tests of three use cases featuring
SLAB_TYPESAFE_BY_RCU: One using per-object reference counting, one using
per-object locking, and one using per-object sequence locking.

[ paulmck: Apply feedback from kernel test robot. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 236 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 7f12168627a1f..abeeeadb83b59 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -76,6 +76,8 @@ torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
 // Wait until there are multiple CPUs before starting test.
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
+// Number of typesafe_lookup structures, that is, the degree of concurrency.
+torture_param(long, lookup_instances, 0, "Number of typesafe_lookup structures.");
 // Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000, "Number of loops per experiment.");
 // Number of readers, with -1 defaulting to about 75% of the CPUs.
@@ -526,6 +528,239 @@ static struct ref_scale_ops clock_ops = {
 	.name		= "clock"
 };
 
+////////////////////////////////////////////////////////////////////////
+//
+// Methods leveraging SLAB_TYPESAFE_BY_RCU.
+//
+
+// Item to look up in a typesafe manner.  Array of pointers to these.
+struct refscale_typesafe {
+	atomic_t rts_refctr;  // Used by all flavors
+	spinlock_t rts_lock;
+	seqlock_t rts_seqlock;
+	unsigned int a;
+	unsigned int b;
+};
+
+static struct kmem_cache *typesafe_kmem_cachep;
+static struct refscale_typesafe **rtsarray;
+static long rtsarray_size;
+static DEFINE_TORTURE_RANDOM_PERCPU(refscale_rand);
+static bool (*rts_acquire)(struct refscale_typesafe *rtsp, unsigned int *start);
+static bool (*rts_release)(struct refscale_typesafe *rtsp, unsigned int start);
+
+// Conditionally acquire an explicit in-structure reference count.
+static bool typesafe_ref_acquire(struct refscale_typesafe *rtsp, unsigned int *start)
+{
+	return atomic_inc_not_zero(&rtsp->rts_refctr);
+}
+
+// Unconditionally release an explicit in-structure reference count.
+static bool typesafe_ref_release(struct refscale_typesafe *rtsp, unsigned int start)
+{
+	if (!atomic_dec_return(&rtsp->rts_refctr)) {
+		WRITE_ONCE(rtsp->a, rtsp->a + 1);
+		kmem_cache_free(typesafe_kmem_cachep, rtsp);
+	}
+	return true;
+}
+
+// Unconditionally acquire an explicit in-structure spinlock.
+static bool typesafe_lock_acquire(struct refscale_typesafe *rtsp, unsigned int *start)
+{
+	spin_lock(&rtsp->rts_lock);
+	return true;
+}
+
+// Unconditionally release an explicit in-structure spinlock.
+static bool typesafe_lock_release(struct refscale_typesafe *rtsp, unsigned int start)
+{
+	spin_unlock(&rtsp->rts_lock);
+	return true;
+}
+
+// Unconditionally acquire an explicit in-structure sequence lock.
+static bool typesafe_seqlock_acquire(struct refscale_typesafe *rtsp, unsigned int *start)
+{
+	*start = read_seqbegin(&rtsp->rts_seqlock);
+	return true;
+}
+
+// Conditionally release an explicit in-structure sequence lock.  Return
+// true if this release was successful, that is, if no retry is required.
+static bool typesafe_seqlock_release(struct refscale_typesafe *rtsp, unsigned int start)
+{
+	return !read_seqretry(&rtsp->rts_seqlock, start);
+}
+
+// Do a read-side critical section with the specified delay in
+// microseconds and nanoseconds inserted so as to increase probability
+// of failure.
+static void typesafe_delay_section(const int nloops, const int udl, const int ndl)
+{
+	unsigned int a;
+	unsigned int b;
+	int i;
+	long idx;
+	struct refscale_typesafe *rtsp;
+	unsigned int start;
+
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		idx = torture_random(this_cpu_ptr(&refscale_rand)) % rtsarray_size;
+		preempt_enable();
+retry:
+		rcu_read_lock();
+		rtsp = rcu_dereference(rtsarray[idx]);
+		a = READ_ONCE(rtsp->a);
+		if (!rts_acquire(rtsp, &start)) {
+			rcu_read_unlock();
+			goto retry;
+		}
+		if (a != READ_ONCE(rtsp->a)) {
+			(void)rts_release(rtsp, start);
+			rcu_read_unlock();
+			goto retry;
+		}
+		un_delay(udl, ndl);
+		// Remember, seqlock read-side release can fail.
+		if (!rts_release(rtsp, start)) {
+			rcu_read_unlock();
+			goto retry;
+		}
+		b = READ_ONCE(rtsp->a);
+		WARN_ONCE(a != b, "Re-read of ->a changed from %u to %u.\n", a, b);
+		b = rtsp->b;
+		rcu_read_unlock();
+		WARN_ON_ONCE(a * a != b);
+	}
+}
+
+// Because the acquisition and release methods are expensive, there
+// is no point in optimizing away the un_delay() function's two checks.
+// Thus simply define typesafe_read_section() as a simple wrapper around
+// typesafe_delay_section().
+static void typesafe_read_section(const int nloops)
+{
+	typesafe_delay_section(nloops, 0, 0);
+}
+
+// Allocate and initialize one refscale_typesafe structure.
+static struct refscale_typesafe *typesafe_alloc_one(void)
+{
+	struct refscale_typesafe *rtsp;
+
+	rtsp = kmem_cache_alloc(typesafe_kmem_cachep, GFP_KERNEL);
+	if (!rtsp)
+		return NULL;
+	atomic_set(&rtsp->rts_refctr, 1);
+	WRITE_ONCE(rtsp->a, rtsp->a + 1);
+	WRITE_ONCE(rtsp->b, rtsp->a * rtsp->a);
+	return rtsp;
+}
+
+// Slab-allocator constructor for refscale_typesafe structures created
+// out of a new slab of system memory.
+static void refscale_typesafe_ctor(void *rtsp_in)
+{
+	struct refscale_typesafe *rtsp = rtsp_in;
+
+	spin_lock_init(&rtsp->rts_lock);
+	seqlock_init(&rtsp->rts_seqlock);
+	preempt_disable();
+	rtsp->a = torture_random(this_cpu_ptr(&refscale_rand));
+	preempt_enable();
+}
+
+static struct ref_scale_ops typesafe_ref_ops;
+static struct ref_scale_ops typesafe_lock_ops;
+static struct ref_scale_ops typesafe_seqlock_ops;
+
+// Initialize for a typesafe test.
+static bool typesafe_init(void)
+{
+	long idx;
+	long si = lookup_instances;
+
+	typesafe_kmem_cachep = kmem_cache_create("refscale_typesafe",
+						 sizeof(struct refscale_typesafe), sizeof(void *),
+						 SLAB_TYPESAFE_BY_RCU, refscale_typesafe_ctor);
+	if (!typesafe_kmem_cachep)
+		return false;
+	if (si < 0)
+		si = -si * nr_cpu_ids;
+	else if (si == 0)
+		si = nr_cpu_ids;
+	rtsarray_size = si;
+	rtsarray = kcalloc(si, sizeof(*rtsarray), GFP_KERNEL);
+	if (!rtsarray)
+		return false;
+	for (idx = 0; idx < rtsarray_size; idx++) {
+		rtsarray[idx] = typesafe_alloc_one();
+		if (!rtsarray[idx])
+			return false;
+	}
+	if (cur_ops == &typesafe_ref_ops) {
+		rts_acquire = typesafe_ref_acquire;
+		rts_release = typesafe_ref_release;
+	} else if (cur_ops == &typesafe_lock_ops) {
+		rts_acquire = typesafe_lock_acquire;
+		rts_release = typesafe_lock_release;
+	} else if (cur_ops == &typesafe_seqlock_ops) {
+		rts_acquire = typesafe_seqlock_acquire;
+		rts_release = typesafe_seqlock_release;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+	return true;
+}
+
+// Clean up after a typesafe test.
+static void typesafe_cleanup(void)
+{
+	long idx;
+
+	if (rtsarray) {
+		for (idx = 0; idx < rtsarray_size; idx++)
+			kmem_cache_free(typesafe_kmem_cachep, rtsarray[idx]);
+		kfree(rtsarray);
+		rtsarray = NULL;
+		rtsarray_size = 0;
+	}
+	if (typesafe_kmem_cachep) {
+		kmem_cache_destroy(typesafe_kmem_cachep);
+		typesafe_kmem_cachep = NULL;
+	}
+	rts_acquire = NULL;
+	rts_release = NULL;
+}
+
+// The typesafe_init() function distinguishes these structures by address.
+static struct ref_scale_ops typesafe_ref_ops = {
+	.init		= typesafe_init,
+	.cleanup	= typesafe_cleanup,
+	.readsection	= typesafe_read_section,
+	.delaysection	= typesafe_delay_section,
+	.name		= "typesafe_ref"
+};
+
+static struct ref_scale_ops typesafe_lock_ops = {
+	.init		= typesafe_init,
+	.cleanup	= typesafe_cleanup,
+	.readsection	= typesafe_read_section,
+	.delaysection	= typesafe_delay_section,
+	.name		= "typesafe_lock"
+};
+
+static struct ref_scale_ops typesafe_seqlock_ops = {
+	.init		= typesafe_init,
+	.cleanup	= typesafe_cleanup,
+	.readsection	= typesafe_read_section,
+	.delaysection	= typesafe_delay_section,
+	.name		= "typesafe_seqlock"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -815,6 +1050,7 @@ ref_scale_init(void)
 	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
 		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops,
+		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.31.1.189.g2e36527f23

