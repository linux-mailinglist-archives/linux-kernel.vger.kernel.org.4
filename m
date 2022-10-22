Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0A608E1B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJVPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJVPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:36:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33927173;
        Sat, 22 Oct 2022 08:36:52 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MvljN1C7qz67Q9H;
        Sat, 22 Oct 2022 23:33:28 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:36:49 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 16:36:47 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <hch@lst.de>, John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Properly init bios from blk_mq_alloc_request_hctx()
Date:   Sun, 23 Oct 2022 00:07:26 +0800
Message-ID: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
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
has.

Move init'ing of those members to common blk_mq_rq_ctx_init().

Fixes: 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx")
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..260adeb2e455 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -402,6 +402,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		}
 	}
 
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
+
 	return rq;
 }
 
@@ -591,9 +595,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 		if (!rq)
 			goto out_queue_exit;
 	}
-	rq->__data_len = 0;
-	rq->__sector = (sector_t) -1;
-	rq->bio = rq->biotail = NULL;
 	return rq;
 out_queue_exit:
 	blk_queue_exit(q);
-- 
2.35.3

