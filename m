Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3066273A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbjAINfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbjAINe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722861EC65
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673271217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6dex5ykj17DwH3w2pApB0qEylWCN/cbwH7uv0L+wI0=;
        b=Y3u1cFb5PF8ei9IE9Em3imoYQO2smeqeMPeFW09ejPK17BBzTPoTzqSXLpBnarnW0su77k
        TqkavTYSrbd1+eGQdGH6iXJ9qIcc/lIC810GI7F42HRdwAwGPbcCxyXZay0LaEBPUR9NYK
        vyl7NVHCiaoNnoJpXrI2OgMOZXhk6qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-857qZRkRNAmGTjAEOm8Osw-1; Mon, 09 Jan 2023 08:33:32 -0500
X-MC-Unique: 857qZRkRNAmGTjAEOm8Osw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95152196EF88;
        Mon,  9 Jan 2023 13:33:31 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 252CF492C1B;
        Mon,  9 Jan 2023 13:33:30 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v7 2/4] workqueue: Factorize unbind/rebind_workers() logic
Date:   Mon,  9 Jan 2023 13:33:14 +0000
Message-Id: <20230109133316.4026472-3-vschneid@redhat.com>
In-Reply-To: <20230109133316.4026472-1-vschneid@redhat.com>
References: <20230109133316.4026472-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Later patches will reuse this code, move it into reusable functions.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76ea87b0251ce..5e6897f0ef105 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1972,6 +1972,23 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return NULL;
 }
 
+static void unbind_worker(struct worker *worker)
+{
+	lockdep_assert_held(&wq_pool_attach_mutex);
+
+	kthread_set_per_cpu(worker->task, -1);
+	if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+	else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+}
+
+static void rebind_worker(struct worker *worker, struct worker_pool *pool)
+{
+	kthread_set_per_cpu(worker->task, pool->cpu);
+	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+}
+
 /**
  * destroy_worker - destroy a workqueue worker
  * @worker: worker to be destroyed
@@ -5008,13 +5025,8 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool) {
-			kthread_set_per_cpu(worker->task, -1);
-			if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
-				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
-			else
-				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
-		}
+		for_each_pool_worker(worker, pool)
+			unbind_worker(worker);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5039,11 +5051,8 @@ static void rebind_workers(struct worker_pool *pool)
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool) {
-		kthread_set_per_cpu(worker->task, pool->cpu);
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
-	}
+	for_each_pool_worker(worker, pool)
+		rebind_worker(worker, pool);
 
 	raw_spin_lock_irq(&pool->lock);
 
-- 
2.31.1

