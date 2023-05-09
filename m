Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76B6FBC7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjEIB2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIB2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:28:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC31DB0;
        Mon,  8 May 2023 18:28:15 -0700 (PDT)
X-UUID: c0e57fd0ee0811edb20a276fd37b9834-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=F5Pj2TK8/Z8QaDkpd7ueT1SLGrmZrcavDg9rwqfVaD0=;
        b=b6IJUOLjCs7M6DI7iILfKSABxcsQVKXdGiGl3Mys2b1d1o1b40mb1mDD7w5fhwu73d2EcYoQigUQawaXxRQMVJf9yLGikqdAxmwWe7dxOb5rFYUWtGxiXPjfnyOIeKYw9xH0cq1Yl7qD2qGrqp1AaDNuYxnoPON+3ksvQZ2aZKY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:75014003-84fe-44cb-a790-496a64a1718d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:697ab71,CLOUDID:af592531-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c0e57fd0ee0811edb20a276fd37b9834-20230509
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 544316469; Tue, 09 May 2023 09:28:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 09:28:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 09:28:06 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <naomi.chu@mediatek.com>, <wsd_upstream@mediatek.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v1] block: make the fair sharing of tag configurable
Date:   Tue, 9 May 2023 09:27:58 +0800
Message-ID: <20230509012758.27094-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tags allocation is limited by the fair sharing algorithm. It hurts
the performance for UFS devices, because the queue depth of general I/O
is reduced by half once the UFS send a control command.

Add a new queue flag QUEUE_FLAG_FAIR_TAG_SHARING to make the fair tag
sharing configurable.

See also https://lore.kernel.org/all/20230103195337.158625-1-bvanassche@acm.org

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 block/blk-mq-debugfs.c    | 1 +
 block/blk-mq-tag.c        | 1 +
 block/blk-mq.c            | 3 ++-
 drivers/ufs/core/ufshcd.c | 3 +++
 include/linux/blkdev.h    | 6 +++++-
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d23a8554ec4a..f03b8bfe63be 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -103,6 +103,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(NOWAIT),
+	QUEUE_FLAG_NAME(FAIR_TAG_SHARING),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d6af9d431dc6..b8b36823f5f5 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -97,6 +97,7 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
 	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
+			blk_queue_fair_tag_sharing(data->q) &&
 			!hctx_may_queue(data->hctx, bt))
 		return BLK_MQ_NO_TAG;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..41f7e2b500bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1746,7 +1746,8 @@ static bool __blk_mq_alloc_driver_tag(struct request *rq)
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
 	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
+		if (blk_queue_fair_tag_sharing(rq->q) &&
+		    !hctx_may_queue(rq->mq_hctx, bt))
 			return false;
 	}
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 17d7bb875fee..e96a50265285 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5149,6 +5149,9 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
 		blk_queue_update_dma_alignment(q, 4096 - 1);
+
+	blk_queue_flag_clear(QUEUE_FLAG_FAIR_TAG_SHARING, q);
+
 	/*
 	 * Block runtime-pm until all consumers are added.
 	 * Refer ufshcd_setup_links().
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b441e633f4dd..7fcb2356860d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,10 +561,12 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
+#define QUEUE_FLAG_FAIR_TAG_SHARING	32 /* fair allocation of shared tags */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
-				 (1UL << QUEUE_FLAG_NOWAIT))
+				 (1UL << QUEUE_FLAG_NOWAIT) |		\
+				 (1UL << QUEUE_FLAG_FAIR_TAG_SHARING))
 
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
@@ -602,6 +604,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 #define blk_queue_skip_tagset_quiesce(q) \
 	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
+#define blk_queue_fair_tag_sharing(q) \
+	test_bit(QUEUE_FLAG_FAIR_TAG_SHARING, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.18.0

