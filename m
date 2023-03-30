Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8E6D0567
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjC3MzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3My7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:54:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780FF44B8;
        Thu, 30 Mar 2023 05:54:58 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PnNbH4DGMz17QBR;
        Thu, 30 Mar 2023 20:51:39 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 20:54:56 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        <haowenchao2@huawei.com>
Subject: [PATCH] blk-mq: rename blk_complete_request to blk_end_request
Date:   Thu, 30 Mar 2023 20:54:02 +0800
Message-ID: <20230330125402.764676-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name blk_complete_request makes people wonder whether it is a variant
of blk_mq_complete_request, but there is actually no relationship between
them. So rename blk_complete_request to blk_end_request to make it more
appropriate.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf1a39adf9a5..0aa9fd9aacb6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -824,7 +824,7 @@ static void blk_print_req_error(struct request *req, blk_status_t status)
  * Fully end IO on a request. Does not support partial completions, or
  * errors.
  */
-static void blk_complete_request(struct request *req)
+static void blk_end_request(struct request *req)
 {
 	const bool is_flush = (req->rq_flags & RQF_FLUSH_SEQ) != 0;
 	int total_bytes = blk_rq_bytes(req);
@@ -1089,7 +1089,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		prefetch(rq->bio);
 		prefetch(rq->rq_next);
 
-		blk_complete_request(rq);
+		blk_end_request(rq);
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
 
-- 
2.35.3

