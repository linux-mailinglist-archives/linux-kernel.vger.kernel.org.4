Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADC6331CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKVBEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiKVBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:04:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7C11A12;
        Mon, 21 Nov 2022 17:04:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F7F6151F;
        Tue, 22 Nov 2022 01:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3228FC43154;
        Tue, 22 Nov 2022 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079063;
        bh=JDkX7Fc0DOy+yBhbkuqH9S9Ejfgbk7JA8huLd1R6z8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERo9qt7uO7GVBBnrX8o2yXKM/JykcLBdKAbt/RQK4nUKXF1KXqh6rH97v9r5k9ZXA
         WumeDeAgQ6u2DwTKhLbgEUQi9W/b1FOGQkAEq75C51k0vVc6/BAUAIEWz/HBMK4vI5
         l0puY9/6h3ocIVuzk2IqMT5KJCe+V61HRQok8UROZEnccnPyNxpaauTlmY/L4CEmXY
         9hfAa7Osg5YjfWoq7Y0ORylTq6OuP+ZtK1SsgJyIGpu/HQWPMGq/ce3G253xKj4Ctz
         NVDwNSK7+OAzWB7T5QrsS8ecsRwC2aSLbLC1ByBPcM7Uiq7FBYS8zMeUuF27bmV1bV
         iYx8FNDVQU4bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8954E5C155D; Mon, 21 Nov 2022 17:04:22 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 rcu 13/16] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Mon, 21 Nov 2022 17:04:18 -0800
Message-Id: <20221122010421.3799681-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
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

From: Uladzislau Rezki <urezki@gmail.com>

Earlier commits in this series allow battery-powered systems to build
their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
This Kconfig option causes call_rcu() to delay its callbacks in order
to batch them.  This means that a given RCU grace period covers more
callbacks, thus reducing the number of grace periods, in turn reducing
the amount of energy consumed, which increases battery lifetime which
can be a very good thing.  This is not a subtle effect: In some important
use cases, the battery lifetime is increased by more than 10%.

This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.

Delaying callbacks is normally not a problem because most callbacks do
nothing but free memory.  If the system is short on memory, a shrinker
will kick all currently queued lazy callbacks out of their laziness,
thus freeing their memory in short order.  Similarly, the rcu_barrier()
function, which blocks until all currently queued callbacks are invoked,
will also kick lazy callbacks, thus enabling rcu_barrier() to complete
in a timely manner.

However, there are some cases where laziness is not a good option.
For example, synchronize_rcu() invokes call_rcu(), and blocks until
the newly queued callback is invoked.  It would not be a good for
synchronize_rcu() to block for ten seconds, even on an idle system.
Therefore, synchronize_rcu() invokes call_rcu_flush() instead of
call_rcu().  The arrival of a non-lazy call_rcu_flush() callback on a
given CPU kicks any lazy callbacks that might be already queued on that
CPU.  After all, if there is going to be a grace period, all callbacks
might as well get full benefit from it.

Yes, this could be done the other way around by creating a
call_rcu_lazy(), but earlier experience with this approach and
feedback at the 2022 Linux Plumbers Conference shifted the approach
to call_rcu() being lazy with call_rcu_flush() for the few places
where laziness is inappropriate.

And another call_rcu() instance that cannot be lazy is the one
in queue_rcu_work(), given that callers to queue_rcu_work() are
not necessarily OK with long delays.

Therefore, make queue_rcu_work() use call_rcu_flush() in order to revert
to the old behavior.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1b..b4b0e828b529e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		rwork->wq = wq;
-		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
 		return true;
 	}
 
-- 
2.31.1.189.g2e36527f23

