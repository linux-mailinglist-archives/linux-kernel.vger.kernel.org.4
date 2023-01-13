Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B635966A126
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjAMRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAMRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543B848C1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673631659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XeXOBiBQec1eYZ+PYC3J6nXlnuLgGSoZaVRzf4a0Yn8=;
        b=AVgbcME/4Ri1Eh635IyIg1ORNbTfzm/SNIsFdAi28aZXY1M5iUlMiGYTpyVzbJOQmXWRoI
        bXZggAtvWv7+vjav5sQOzSKONvXgdOSD/2ptHPztEtlxvQ3Iazqt471sR1XItl8ILOV1sR
        qIwp2KtRGpXQzUknlVDchinu5pv0yy0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-fa4jNFgDOyyH-awXOH9YEg-1; Fri, 13 Jan 2023 12:40:56 -0500
X-MC-Unique: fa4jNFgDOyyH-awXOH9YEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FD2A281723D;
        Fri, 13 Jan 2023 17:40:55 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71BE64085720;
        Fri, 13 Jan 2023 17:40:54 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Fold rebind_worker() within rebind_workers()
Date:   Fri, 13 Jan 2023 17:40:40 +0000
Message-Id: <20230113174040.1344293-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

!CONFIG_SMP builds complain about rebind_worker() being unused. Its only
user, rebind_workers() is indeed only defined for CONFIG_SMP, so just fold
the two lines back up there.

Link: http://lore.kernel.org/r/20230113143102.2e94d74f@canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d44c33b5b24e..dce29154cd07a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1986,12 +1986,6 @@ static void unbind_worker(struct worker *worker)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 }
 
-static void rebind_worker(struct worker *worker, struct worker_pool *pool)
-{
-	kthread_set_per_cpu(worker->task, pool->cpu);
-	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
-}
-
 static void wake_dying_workers(struct list_head *cull_list)
 {
 	struct worker *worker, *tmp;
@@ -5149,8 +5143,11 @@ static void rebind_workers(struct worker_pool *pool)
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool)
-		rebind_worker(worker, pool);
+	for_each_pool_worker(worker, pool) {
+		kthread_set_per_cpu(worker->task, pool->cpu);
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
+						  pool->attrs->cpumask) < 0);
+	}
 
 	raw_spin_lock_irq(&pool->lock);
 
-- 
2.31.1

