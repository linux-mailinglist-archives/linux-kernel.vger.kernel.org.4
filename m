Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA063C970
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiK2UfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiK2UfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610951B7AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669754068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nsMFyIcOKMdH8kGov88EPCbLbTICW8XLJaolwn8fdZQ=;
        b=h3jdQmoRcQB+9YHnPj48Z6TkRY9sOAKvGh4CJTxxDyn4FDHZABRaxJk4sazDP9+CkDLsdn
        4fvRPwMaZ26JMxa/RiOfjdgk+6WMdqJSqYBbys0IzdZXgDRIHebKdPjJxl+TedQic3taFZ
        Fhq82G12/pc/lXWvi/90eiShJR4CNmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-SZGhVrRyO_-myQQoKno4yA-1; Tue, 29 Nov 2022 15:34:25 -0500
X-MC-Unique: SZGhVrRyO_-myQQoKno4yA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60622802314;
        Tue, 29 Nov 2022 20:34:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 696AE140EBF5;
        Tue, 29 Nov 2022 20:34:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Waiman Long <longman@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH-block v2] bdi, blk-cgroup: Fix potential UAF of blkcg
Date:   Tue, 29 Nov 2022 15:34:00 -0500
Message-Id: <20221129203400.1456100-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
writeback has finished") delayed call to blkcg_destroy_blkgs() to
cgwb_release_workfn(). However, it is done after a css_put() of blkcg
which may be the final put that causes the blkcg to be freed as RCU
read lock isn't held.

By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
failure, the following stack trace was produced in a test system on
bootup.

[   34.254240] RIP: 0010:blkcg_destroy_blkgs+0x16a/0x1a0
      :
[   34.339943] Call Trace:
[   34.342395]  <TASK>
[   34.344510]  blkcg_unpin_online+0x38/0x60
[   34.348523]  cgwb_release_workfn+0x6a/0x200
[   34.352708]  process_one_work+0x1e5/0x3b0
[   34.356742]  ? rescuer_thread+0x390/0x390
[   34.360758]  worker_thread+0x50/0x3a0
[   34.364425]  ? rescuer_thread+0x390/0x390
[   34.368447]  kthread+0xd9/0x100
[   34.371592]  ? kthread_complete_and_exit+0x20/0x20
[   34.376386]  ret_from_fork+0x22/0x30
[   34.379982]  </TASK>

This confirms that a potential UAF situation can happen.

Fix that by delaying the css_put() until after the blkcg_unpin_online()
call. Also use css_tryget() in blkcg_destroy_blkgs() and issue a warning
if css_tryget() fails with no RCU read lock held.

The reproducing system can no longer produce a warning with this patch.
All the runnable block/0* tests including block/027 were run successfully
without failure.

Fixes: 59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
Suggested-by: Michal Koutný <mkoutny@suse.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 10 +++++++++-
 mm/backing-dev.c   |  8 ++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 57941d2a8ba3..904372bb96f1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1088,7 +1088,15 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 
 	might_sleep();
 
-	css_get(&blkcg->css);
+	/*
+	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
+	 * references gone and rcu_read_lock not held.
+	 */
+	if (!css_tryget(&blkcg->css)) {
+		WARN_ON_ONCE(!rcu_read_lock_held());
+		return;
+	}
+
 	spin_lock_irq(&blkcg->lock);
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c30419a5e119..36f75b072325 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -390,11 +390,15 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
-	css_put(wb->blkcg_css);
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
-	/* triggers blkg destruction if no online users left */
+	/*
+	 * Triggers blkg destruction if no online users left
+	 * The final blkcg css_put() has to be done after blkcg_unpin_online()
+	 * to avoid use-after-free.
+	 */
 	blkcg_unpin_online(wb->blkcg_css);
+	css_put(wb->blkcg_css);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
-- 
2.31.1

