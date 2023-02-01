Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E71C686759
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjBANq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjBANqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:46:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF24E51D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:46:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD34921F56;
        Wed,  1 Feb 2023 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675259182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=py+tvQipfQQRabm0wdOtI/hT7JGIt8NZ4cmBAkLrVg0=;
        b=HqU8BgJGF9wALOyBHgIjcRXji7U9OPkCYAngIf/YrVfjNcAm1dYEsXNKKMbzkBZvmQgdb4
        n/sm8lfbzneBzhuOGDM1pzPm2s17BNQkapi4s9tCJzG7ZrIG+KaJbe99BtpR77qIG4yLFI
        Dw+ukJd0JkdJuvvR6MtVJXu7RP2fGmA=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 898B02C141;
        Wed,  1 Feb 2023 13:46:22 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 1/5] workqueue: Fix hung time report of worker pools
Date:   Wed,  1 Feb 2023 14:45:39 +0100
Message-Id: <20230201134543.13687-2-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230201134543.13687-1-pmladek@suse.com>
References: <20230201134543.13687-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue watchdog prints a warning when there is no progress in
a worker pool. Where the progress means that the pool started processing
a pending work item.

Note that it is perfectly fine to process work items much longer.
The progress should be guaranteed by waking up or creating idle
workers.

show_one_worker_pool() prints state of non-idle worker pool. It shows
a delay since the last pool->watchdog_ts.

The timestamp is updated when a first pending work is queued in
__queue_work(). Also it is updated when a work is dequeued for
processing in worker_thread() and rescuer_thread().

The delay is misleading when there is no pending work item. In this
case it shows how long the last work item is being proceed. Show
zero instead. There is no stall if there is no pending work.

Fixes: 82607adcf9cdf40fb7b ("workqueue: implement lockup detector")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07895deca271..5419d12e56ae 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4848,10 +4848,16 @@ static void show_one_worker_pool(struct worker_pool *pool)
 	struct worker *worker;
 	bool first = true;
 	unsigned long flags;
+	unsigned long hung = 0;
 
 	raw_spin_lock_irqsave(&pool->lock, flags);
 	if (pool->nr_workers == pool->nr_idle)
 		goto next_pool;
+
+	/* How long the first pending work is waiting for a worker. */
+	if (!list_empty(&pool->worklist))
+		hung = jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000;
+
 	/*
 	 * Defer printing to avoid deadlocks in console drivers that
 	 * queue work while holding locks also taken in their write
@@ -4860,9 +4866,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 	printk_deferred_enter();
 	pr_info("pool %d:", pool->id);
 	pr_cont_pool_info(pool);
-	pr_cont(" hung=%us workers=%d",
-		jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-		pool->nr_workers);
+	pr_cont(" hung=%lus workers=%d", hung, pool->nr_workers);
 	if (pool->manager)
 		pr_cont(" manager: %d",
 			task_pid_nr(pool->manager->task));
-- 
2.35.3

