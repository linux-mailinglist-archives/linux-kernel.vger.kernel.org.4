Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004885B5DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiILQLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD7BF4C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662999110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eRONoSpfg6OqWWA5cH64+HEW7SQgK+9R0fHs9Js5AEY=;
        b=AteJri0NhlFmY7ry8Afi4dM0/KzUFQZmuvdSCtmVJo16t+Qhn3wBf7RCCd7uH4Yl2M9ICY
        L8lsvkIaNJsGLGOhihnoA8Yeq8FKkZ0jkpn24TifixioLPhAPU60G+IzGBe5O64wTkPlx0
        TZqYUvJBbDhgRQWs7kG5mvPdjJG/+iI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-ci8qM0OYOPOwPuhamL1q9g-1; Mon, 12 Sep 2022 12:11:45 -0400
X-MC-Unique: ci8qM0OYOPOwPuhamL1q9g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4DB8811E90;
        Mon, 12 Sep 2022 16:11:43 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1607492B04;
        Mon, 12 Sep 2022 16:11:41 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     vbabka@suse.cz
Cc:     linux-mm@kvack.org, rientjes@google.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de
Subject: [PATCH V2] mm: slub: fix flush_cpu_slab()/__free_slab() invocations in task context.
Date:   Mon, 12 Sep 2022 18:11:40 +0200
Message-Id: <20220912161140.34281-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
__free_slab() invocations out of IRQ context") moved all flush_cpu_slab()
invocations to the global workqueue to avoid a problem related
with deactivate_slab()/__free_slab() being called from an IRQ context
on PREEMPT_RT kernels.

When the flush_all_cpu_locked() function is called from a task context
it may happen that a workqueue with WQ_MEM_RECLAIM bit set ends up
flushing the global workqueue, this will cause a dependency issue.

 workqueue: WQ_MEM_RECLAIM nvme-delete-wq:nvme_delete_ctrl_work [nvme_core]
   is flushing !WQ_MEM_RECLAIM events:flush_cpu_slab
 WARNING: CPU: 37 PID: 410 at kernel/workqueue.c:2637
   check_flush_dependency+0x10a/0x120
 Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
 RIP: 0010:check_flush_dependency+0x10a/0x120[  453.262125] Call Trace:
 __flush_work.isra.0+0xbf/0x220
 ? __queue_work+0x1dc/0x420
 flush_all_cpus_locked+0xfb/0x120
 __kmem_cache_shutdown+0x2b/0x320
 kmem_cache_destroy+0x49/0x100
 bioset_exit+0x143/0x190
 blk_release_queue+0xb9/0x100
 kobject_cleanup+0x37/0x130
 nvme_fc_ctrl_free+0xc6/0x150 [nvme_fc]
 nvme_free_ctrl+0x1ac/0x2b0 [nvme_core]

Fix this bug by creating a workqueue for the flush operation with
the WQ_MEM_RECLAIM bit set.

v2: Create a workqueue with WQ_MEM_RECLAIM
    instead of trying to revert the changes.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 mm/slub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..cdb8011884d0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -310,6 +310,11 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
  */
 static nodemask_t slab_nodes;
 
+/*
+ * Workqueue used for flush_cpu_slab().
+ */
+static struct workqueue_struct *flushwq;
+
 /********************************************************************
  * 			Core slab cache functions
  *******************************************************************/
@@ -2730,7 +2735,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 		INIT_WORK(&sfw->work, flush_cpu_slab);
 		sfw->skip = false;
 		sfw->s = s;
-		schedule_work_on(cpu, &sfw->work);
+		queue_work_on(cpu, flushwq, &sfw->work);
 	}
 
 	for_each_online_cpu(cpu) {
@@ -4858,6 +4863,8 @@ void __init kmem_cache_init(void)
 
 void __init kmem_cache_init_late(void)
 {
+	flushwq = create_workqueue("slub_flushwq");
+	BUG_ON(!flushwq);
 }
 
 struct kmem_cache *
-- 
2.31.1

