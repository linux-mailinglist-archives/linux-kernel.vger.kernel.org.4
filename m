Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2F6ADF35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCGMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCGMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:54:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FF7C3EB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:54:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 587EE1FE17;
        Tue,  7 Mar 2023 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678193646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEEJsz5Y768xUJTZNnwAVmHB0wJgO+in0ShoOU4pSwI=;
        b=BANYSDRqqt476XlRqvf3FDx0EiZbCNC26CEkMJNdE/Co36Cw3vWv7m3GyGeZTz/6pnNDG2
        oIgrizrrOLKxcOVFAA93i6bN776ylu/6HNEQ+5teyFr+FrWGFGyMP5xebMXHyPEL7GGbml
        hyJU2U4d3v+VhQIC0Of2FB0so9nUVtM=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id F14892C142;
        Tue,  7 Mar 2023 12:54:05 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/5] workqueue: Warn when a new worker could not be created
Date:   Tue,  7 Mar 2023 13:53:32 +0100
Message-Id: <20230307125335.28805-3-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230307125335.28805-1-pmladek@suse.com>
References: <20230307125335.28805-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue watchdog reports a lockup when there was not any progress
in the worker pool for a long time. The progress means that a pending
work item starts being proceed.

The progress is guaranteed by using idle workers or creating new workers
for pending work items.

There are several reasons why a new worker could not be created:

   + there is not enough memory

   + there is no free pool ID (IDR API)

   + the system reached PID limit

   + the process creating the new worker was interrupted

   + the last idle worker (manager) has not been scheduled for a long
     time. It was not able to even start creating the kthread.

None of these failures is reported at the moment. The only clue is that
show_one_worker_pool() prints that there is a manager. It is the last
idle worker that is responsible for creating a new one. But it is not
clear if create_worker() is failing and why.

Make the debugging easier by printing errors in create_worker().

The error code is important, especially from kthread_create_on_node().
It helps to distinguish the various reasons. For example, reaching
memory limit (-ENOMEM), other system limits (-EAGAIN), or process
interrupted (-EINTR).

Use pr_once() to avoid repeating the same error every CREATE_COOLDOWN
for each stuck worker pool.

Ratelimited printk() might be better. It would help to know if the problem
remains. It would be more clear if the create_worker() errors and workqueue
stalls are related. Also old messages might get lost when the internal log
buffer is full. The problem is that printk() might touch the watchdog.
For example, see touch_nmi_watchdog() in serial8250_console_write().
It would require synchronization of the begin and length of the ratelimit
interval with the workqueue watchdog. Otherwise, the error messages
might break the watchdog. This does not look worth the complexity.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2be9b0ecf22c..36ad9a4d65e4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1938,12 +1938,17 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		pr_err_once("workqueue: Failed to allocate a worker ID: %pe\n",
+			    ERR_PTR(id));
 		return NULL;
+	}
 
 	worker = alloc_worker(pool->node);
-	if (!worker)
+	if (!worker) {
+		pr_err_once("workqueue: Failed to allocate a worker\n");
 		goto fail;
+	}
 
 	worker->id = id;
 
@@ -1955,8 +1960,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
 					      "kworker/%s", id_buf);
-	if (IS_ERR(worker->task))
+	if (IS_ERR(worker->task)) {
+		pr_err_once("workqueue: Failed to create a worker thread: %pe",
+			    worker->task);
 		goto fail;
+	}
 
 	set_user_nice(worker->task, pool->attrs->nice);
 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
-- 
2.35.3

