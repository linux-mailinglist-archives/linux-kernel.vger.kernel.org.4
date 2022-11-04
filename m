Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDD619FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiKDSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7E4AF10
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667586061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjL1+H6RuB7jMr/6XEfK1aTzhYLFDKOwXB8sr3ps4w8=;
        b=FkhyJCk9MmFPZ9aeNg1YYiZZEyPz3ep4pXK2C35+knlTp8ZyEKh0xZYP/69CmHpT+CuUgB
        gE2yeJPPMGs5o9MBibyX8KpSyxx3Zi4BvWxQShwstSs6IFa4uw/Z/hB68KL5OpklO1uPDs
        BJQLhBMxta6AVQjX2cRakP55qERX1GU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-mcELFn2KNKet6HaMbpKa7g-1; Fri, 04 Nov 2022 14:20:58 -0400
X-MC-Unique: mcELFn2KNKet6HaMbpKa7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17FED185A78F;
        Fri,  4 Nov 2022 18:20:58 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD9CC15BA5;
        Fri,  4 Nov 2022 18:20:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 3/3] blk-cgroup: Flush stats at blkgs destruction path
Date:   Fri,  4 Nov 2022 14:20:50 -0400
Message-Id: <20221104182050.342908-4-longman@redhat.com>
In-Reply-To: <20221104182050.342908-1-longman@redhat.com>
References: <20221104182050.342908-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Michal, the blkg_iostat_set's in the lockless list
hold reference to blkg's to protect against their removal. Those
blkg's hold reference to blkcg. When a cgroup is being destroyed,
cgroup_rstat_flush() is only called at css_release_work_fn() which is
called when the blkcg reference count reaches 0. This circular dependency
will prevent blkcg from being freed until some other events cause
cgroup_rstat_flush() to be called to flush out the pending blkcg stats.

To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
function to flush stats for a given css and cpu and call it at the blkgs
destruction path, blkcg_destroy_blkgs(), whenever there are still some
pending stats to be flushed. This will ensure that blkcg reference
count can reach 0 ASAP.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c     | 15 ++++++++++++++-
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3e03c0d13253..fa0a366e3476 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1084,10 +1084,12 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  */
 static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
+	int cpu;
+
 	might_sleep();
 
+	css_get(&blkcg->css);
 	spin_lock_irq(&blkcg->lock);
-
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
 						struct blkcg_gq, blkcg_node);
@@ -1110,6 +1112,17 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 	}
 
 	spin_unlock_irq(&blkcg->lock);
+
+	/*
+	 * Flush all the non-empty percpu lockless lists.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+
+		if (!llist_empty(lhead))
+			cgroup_rstat_css_flush(&blkcg->css, cpu);
+	}
+	css_put(&blkcg->css);
 }
 
 /**
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 528bd44b59e2..4a61cc5d1952 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -766,6 +766,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
+void cgroup_rstat_css_flush(struct cgroup_subsys_state *css, int cpu);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 793ecff29038..28033190fb29 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -281,6 +281,26 @@ void cgroup_rstat_flush_release(void)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+/**
+ * cgroup_rstat_css_flush - flush stats for the given css and cpu
+ * @css: target css to be flush
+ * @cpu: the cpu that holds the stats to be flush
+ *
+ * A lightweight rstat flush operation for a given css and cpu.
+ * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
+ * isn't used.
+ */
+void cgroup_rstat_css_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+
+	raw_spin_lock_irq(cpu_lock);
+	rcu_read_lock();
+	css->ss->css_rstat_flush(css, cpu);
+	rcu_read_unlock();
+	raw_spin_unlock_irq(cpu_lock);
+}
+
 int cgroup_rstat_init(struct cgroup *cgrp)
 {
 	int cpu;
-- 
2.31.1

