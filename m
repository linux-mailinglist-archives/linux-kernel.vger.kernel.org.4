Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3986C6D39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCWQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCWQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:18:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221727D43;
        Thu, 23 Mar 2023 09:18:33 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:18:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679588312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=J7HfOv4nohJ8yEKD7u+zI1jmEYsLBtE90jZ4cY+f0kU=;
        b=d9nP8oUh2EGPPSGxuNz+gKh7DykB/H6wIvVY2Gh5XyZjFTYHdMB7sA1Aa0jwBaaVTytcb7
        bzTs4hYVhNuPR+dPmUxWk4h4Y87xVQLRcnTg9DH6lEcJvhH4N+bMsFutht0K5y5HAlnUmz
        /gtzoeF752aw1t557zymOMPyFEcEtv1Vhzuz1wEImnveogEkb1yIjHYnoZ/JewoYYNLZbk
        35jMxZkX9eZH8AZ034RZepBlSZhCjPXfdU+fYGYiIkQwXKX7d+FqALEmpLnlRXishX0hB8
        uhy1CiUM7cevVYWaBSqllFcdrL1qX2A8OymzcMrLFcAyJiRACIVfKmLmQ0i04Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679588312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=J7HfOv4nohJ8yEKD7u+zI1jmEYsLBtE90jZ4cY+f0kU=;
        b=Lp8ojpwJQx+FPnLc6Ueru8ooKVl7koqKY2tCxQPFnorgg7PNfKQ89o15TFHjtsXd0/Ht0P
        ZbioBM2QXvvAxQBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] zram: Replace bit spinlocks with spinlock_t for PREEMPT_RT.
Message-ID: <20230323161830.jFbWCosd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
lock on PREEMPT_RT and it can not be acquired in this context. In this locked
section, zs_free() acquires a zs_pool::lock, and there is access to
zram::wb_limit_lock.

Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
the lock has been acquired/ dropped.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/YqIbMuHCPiQk+Ac2@linutronix.de
---

I'm simply forwarding Mike's patch here. The other alternative is to let
the driver depend on !PREEMPT_RT. I can't tell likely it is that this
driver is used. Mike most likely stumbled upon it while running LTP.

 drivers/block/zram/zram_drv.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |    3 +++
 2 files changed, 39 insertions(+)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,6 +57,40 @@ static void zram_free_page(struct zram *
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 				u32 index, int offset, struct bio *bio);
 
+#ifdef CONFIG_PREEMPT_RT
+static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
+{
+	size_t index;
+
+	for (index = 0; index < num_pages; index++)
+		spin_lock_init(&zram->table[index].lock);
+}
+
+static int zram_slot_trylock(struct zram *zram, u32 index)
+{
+	int ret;
+
+	ret = spin_trylock(&zram->table[index].lock);
+	if (ret)
+		__set_bit(ZRAM_LOCK, &zram->table[index].flags);
+	return ret;
+}
+
+static void zram_slot_lock(struct zram *zram, u32 index)
+{
+	spin_lock(&zram->table[index].lock);
+	__set_bit(ZRAM_LOCK, &zram->table[index].flags);
+}
+
+static void zram_slot_unlock(struct zram *zram, u32 index)
+{
+	__clear_bit(ZRAM_LOCK, &zram->table[index].flags);
+	spin_unlock(&zram->table[index].lock);
+}
+
+#else
+
+static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages) { }
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -72,6 +106,7 @@ static void zram_slot_unlock(struct zram
 {
 	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
 }
+#endif
 
 static inline bool init_done(struct zram *zram)
 {
@@ -1311,6 +1346,7 @@ static bool zram_meta_alloc(struct zram
 
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
+	zram_meta_init_table_locks(zram, num_pages);
 	return true;
 }
 
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -69,6 +69,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long flags;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t lock;
+#endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif
