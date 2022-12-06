Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5392643EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiLFIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiLFIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:41:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E204A2739
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:41:13 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRDPy2x08zQj6p;
        Tue,  6 Dec 2022 16:40:22 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 16:41:10 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <richard@nod.at>, <ext-adrian.hunter@nokia.com>,
        <Artem.Bityutskiy@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH-next] block: fix null-deref in percpu_ref_put
Date:   Tue, 6 Dec 2022 17:02:08 +0800
Message-ID: <20221206090208.845185-1-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A problem was find in stable 5.10 and the root cause of it like below.

In the use of q_usage_counter of request_queue, blk_cleanup_queue using
"wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
to wait q_usage_counter becoming zero. however, if the q_usage_counter
becoming zero quickly, and percpu_ref_exit will execute and ref->data
will be freed, maybe another process will cause a null-defef problem
like below:

	CPU0                             CPU1
blk_mq_destroy_queue
 blk_freeze_queue
  blk_mq_freeze_queue_wait
				scsi_end_request
				 percpu_ref_get
				 ...
				 percpu_ref_put
				  atomic_long_sub_and_test
 blk_put_queue
  kobject_put
   kref_put
    blk_release_queue
     percpu_ref_exit
      ref->data -> NULL
   				   ref->data->release(ref) -> null-deref

As suggested by Ming Lei, fix it by getting the release method before
the referebce count is minus 0.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 include/linux/percpu-refcount.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..11e717c95acb 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -331,8 +331,11 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
-		ref->data->release(ref);
+	else {
+		percpu_ref_func_t *release = ref->data->release;
+		if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+			release(ref);
+	}
 
 	rcu_read_unlock();
 }
-- 
2.31.1

