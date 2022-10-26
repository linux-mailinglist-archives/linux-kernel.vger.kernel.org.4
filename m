Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD060DE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiJZKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiJZKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:04:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862C15A3E;
        Wed, 26 Oct 2022 03:04:44 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4My4BZ3219z67KQL;
        Wed, 26 Oct 2022 18:03:18 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 12:04:42 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:04:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
Date:   Wed, 26 Oct 2022 18:35:13 +0800
Message-ID: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function blk_mq_alloc_request_hctx() is missing zeroing/init of rq->bio,
biotail, __sector, and __data_len members, which blk_mq_alloc_request()
has, so duplicate what we do in blk_mq_alloc_request().

Fixes: 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx")
Signed-off-by: John Garry <john.garry@huawei.com>
---
Difference to v1:
- init rq members in blk_mq_alloc_request_hctx(), rather than
  blk_mq_rq_ctx_init() (Ming Lei)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 497c413bce80..a1b6afe43913 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -611,6 +611,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.nr_tags	= 1,
 	};
 	u64 alloc_time_ns = 0;
+	struct request *rq;
 	unsigned int cpu;
 	unsigned int tag;
 	int ret;
@@ -660,8 +661,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	return blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
+	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
 					alloc_time_ns);
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
+	return rq;
 
 out_queue_exit:
 	blk_queue_exit(q);
-- 
2.25.1

