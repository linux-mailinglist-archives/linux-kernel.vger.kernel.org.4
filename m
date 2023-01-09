Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF788662AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjAIQJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbjAIQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D474395C4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673280476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Pk/oihiI/SzS/0mENljkppeJxqVYKP4Lj+1OwwOXDlM=;
        b=U9NkvJARkKD9xixpI7qHD0K0Oa4UvAQlpiZyxxmfyv24K3RmSnCD1WENAb+FZLBLaOCqdq
        J0DjP4Jh6v6TnmFBwjcOeb1lYA/eoRKAVpB12lqRQowHig5hV5KNByq7lRRIFp9Flbf0D7
        L0+B8vUI9stFatdoxaxFMirtDeFO2Jk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-1TOXYOM4PoWy61CaqtGpoQ-1; Mon, 09 Jan 2023 11:07:52 -0500
X-MC-Unique: 1TOXYOM4PoWy61CaqtGpoQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4388D3C02B70;
        Mon,  9 Jan 2023 16:07:52 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4274492C14;
        Mon,  9 Jan 2023 16:07:51 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id DC002400E718F; Mon,  9 Jan 2023 11:09:09 -0300 (-03)
Date:   Mon, 9 Jan 2023 11:09:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <Y7wgBT0TZcgzY3F1@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


umount causes invalidate_bh_lrus which calls an IPI on each
CPU that has non empty per-CPU cache:

       	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);

This interrupts CPUs which might be executing code sensitive
to interferences.

To avoid the IPI, free the per-CPU caches remotely via RCU.
Two bh_lrus structures for each CPU are allocated: one is being
used (assigned to per-CPU bh_lru pointer), and the other is
being freed (or idle).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v2: fix sparse warnings (kernel test robot)

diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dd..db2843fed669 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1203,7 +1203,21 @@ struct bh_lru {
 	struct buffer_head *bhs[BH_LRU_SIZE];
 };
 
-static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
+
+/*
+ * Allocate two bh_lrus structures for each CPU. bh_lru points to the
+ * one that is currently in use, and the update path does
+ * (consider cpu->bh_lru = bh_lrus[0]).
+ *
+ * cpu->bh_lrup = bh_lrus[1]
+ * synchronize_rcu()
+ * free bh's in bh_lrus[0]
+ */
+static unsigned int bh_lru_idx;
+static DEFINE_PER_CPU(struct bh_lru, bh_lrus[2]) = {{{ NULL }}, {{NULL}}};
+static DEFINE_PER_CPU(struct bh_lru __rcu *, bh_lrup);
+
+static DEFINE_MUTEX(bh_lru_invalidate_mutex);
 
 #ifdef CONFIG_SMP
 #define bh_lru_lock()	local_irq_disable()
@@ -1245,16 +1259,19 @@ static void bh_lru_install(struct buffer_head *bh)
 		return;
 	}
 
-	b = this_cpu_ptr(&bh_lrus);
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		swap(evictee, b->bhs[i]);
 		if (evictee == bh) {
+			rcu_read_unlock();
 			bh_lru_unlock();
 			return;
 		}
 	}
 
 	get_bh(bh);
+	rcu_read_unlock();
 	bh_lru_unlock();
 	brelse(evictee);
 }
@@ -1266,28 +1283,32 @@ static struct buffer_head *
 lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 {
 	struct buffer_head *ret = NULL;
+	struct bh_lru *lru;
 	unsigned int i;
 
 	check_irqs_on();
 	bh_lru_lock();
+	rcu_read_lock();
+
+	lru = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
+		struct buffer_head *bh = lru->bhs[i];
 
 		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
 		    bh->b_size == size) {
 			if (i) {
 				while (i) {
-					__this_cpu_write(bh_lrus.bhs[i],
-						__this_cpu_read(bh_lrus.bhs[i - 1]));
+					lru->bhs[i] = lru->bhs[i - 1];
 					i--;
 				}
-				__this_cpu_write(bh_lrus.bhs[0], bh);
+				lru->bhs[0] = bh;
 			}
 			get_bh(bh);
 			ret = bh;
 			break;
 		}
 	}
+	rcu_read_unlock();
 	bh_lru_unlock();
 	return ret;
 }
@@ -1381,35 +1402,56 @@ static void __invalidate_bh_lrus(struct bh_lru *b)
 		b->bhs[i] = NULL;
 	}
 }
-/*
- * invalidate_bh_lrus() is called rarely - but not only at unmount.
- * This doesn't race because it runs in each cpu either in irq
- * or with preempt disabled.
- */
-static void invalidate_bh_lru(void *arg)
-{
-	struct bh_lru *b = &get_cpu_var(bh_lrus);
-
-	__invalidate_bh_lrus(b);
-	put_cpu_var(bh_lrus);
-}
 
 bool has_bh_in_lru(int cpu, void *dummy)
 {
-	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
+	struct bh_lru *b;
 	int i;
-	
+
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, cpu));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-		if (b->bhs[i])
+		if (b->bhs[i]) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
 
+	rcu_read_unlock();
 	return false;
 }
 
+/*
+ * invalidate_bh_lrus() is called rarely - but not only at unmount.
+ */
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
+	int cpu, oidx, nidx;
+
+	mutex_lock(&bh_lru_invalidate_mutex);
+	oidx = bh_lru_idx;
+	bh_lru_idx++;
+	if (bh_lru_idx >= 2)
+		bh_lru_idx = 0;
+
+	nidx = bh_lru_idx;
+	/* Assign the per-CPU bh_lru pointer */
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		rcu_assign_pointer(per_cpu(bh_lrup, cpu), per_cpu_ptr(&bh_lrus[nidx], cpu));
+	cpus_read_unlock();
+	synchronize_rcu_expedited();
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct bh_lru *b = per_cpu_ptr(&bh_lrus[oidx], cpu);
+
+		bh_lru_lock();
+		__invalidate_bh_lrus(b);
+		bh_lru_unlock();
+	}
+	cpus_read_unlock();
+	mutex_unlock(&bh_lru_invalidate_mutex);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
@@ -1422,8 +1464,10 @@ void invalidate_bh_lrus_cpu(void)
 	struct bh_lru *b;
 
 	bh_lru_lock();
-	b = this_cpu_ptr(&bh_lrus);
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
 	__invalidate_bh_lrus(b);
+	rcu_read_unlock();
 	bh_lru_unlock();
 }
 
@@ -2923,12 +2967,15 @@ EXPORT_SYMBOL(free_buffer_head);
 static int buffer_exit_cpu_dead(unsigned int cpu)
 {
 	int i;
-	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
+	struct bh_lru *b;
 
+	rcu_read_lock();
+	b = rcu_dereference(per_cpu(bh_lrup, cpu));
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		brelse(b->bhs[i]);
 		b->bhs[i] = NULL;
 	}
+	rcu_read_unlock();
 	this_cpu_add(bh_accounting.nr, per_cpu(bh_accounting, cpu).nr);
 	per_cpu(bh_accounting, cpu).nr = 0;
 	return 0;
@@ -3021,7 +3068,7 @@ EXPORT_SYMBOL(__bh_read_batch);
 void __init buffer_init(void)
 {
 	unsigned long nrpages;
-	int ret;
+	int ret, cpu;
 
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
@@ -3029,6 +3076,11 @@ void __init buffer_init(void)
 				SLAB_MEM_SPREAD),
 				NULL);
 
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		rcu_assign_pointer(per_cpu(bh_lrup, cpu), per_cpu_ptr(&bh_lrus[0], cpu));
+	cpus_read_unlock();
+
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */

