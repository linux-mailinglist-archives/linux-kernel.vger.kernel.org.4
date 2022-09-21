Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC2B5BF4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIUDfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIUDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:34:20 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D62A243
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:32:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQM4M10_1663731123;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQM4M10_1663731123)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 11:32:37 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, liusong@linux.alibaba.com,
        sagi@grimberg.me
Subject: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
Date:   Wed, 21 Sep 2022 11:32:03 +0800
Message-Id: <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
References: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

High-performance NVMe devices usually support a large hw queue, which
ensures a 1:1 mapping of hctx and ctx. In this case there will be no
remote request, so we don't need to care about it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d..9626ea1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1093,10 +1093,12 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For a polled request, always complete locally, it's pointless
-	 * to redirect the completion.
+	 * For request which hctx has only one ctx mapping,
+	 * or a polled request, always complete locally,
+	 * it's pointless to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_POLLED)
+	if (rq->mq_hctx->nr_ctx == 1 ||
+		rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-- 
1.8.3.1

