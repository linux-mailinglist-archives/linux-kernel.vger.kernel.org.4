Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23575E5D71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIVI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIVI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:28:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0305AB04B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:28:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQRkoi7_1663835274;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQRkoi7_1663835274)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 16:28:45 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, liusong@linux.alibaba.com,
        sagi@grimberg.me
Subject: [RFC PATCH v2] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
Date:   Thu, 22 Sep 2022 16:27:54 +0800
Message-Id: <1663835274-3703-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20220922062010.GA27946@lst.de>
References: <20220922062010.GA27946@lst.de>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

High-performance NVMe devices usually support a larger number of hw queue,
which ensures a 1:1 mapping of hctx and ctx. In this case there will be no
remote request, so we don't need to care about it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d..7f9be13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1093,10 +1093,11 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For a polled request, always complete locally, it's pointless
-	 * to redirect the completion.
+	 * If the request's hctx has only one ctx mapping,
+	 * or is a polled request, both always complete locally,
+	 * it's pointless to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_POLLED)
+	if (rq->mq_hctx->nr_ctx == 1 || rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-- 
1.8.3.1

