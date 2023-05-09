Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F96FBF9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjEIGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjEIGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:52:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DFE46BD;
        Mon,  8 May 2023 23:52:47 -0700 (PDT)
X-UUID: 16d77c72ee3611edb20a276fd37b9834-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=isE35XwWSwwU5lYxAFLdG30zZHWjXouQ3B166g/4UAM=;
        b=pRlj8wvK8486ldjfva9ROsSBY6SjACN3ItY5w6SnHsHU4LiHawvTZDx3TeRCcr1EqhS/Ns3pMEh7FTnayzDe8RsRNvsbIlXP1O2bNJaHP9FYYIDuTq5rnC67Rm/IOKexO2kcE5I7DoT/CGNOXGr8KaBz1eD3rh4UCx234jT17eI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:78547b09-7645-4f23-a686-3617ed737633,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:697ab71,CLOUDID:5c153dc0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 16d77c72ee3611edb20a276fd37b9834-20230509
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 208723594; Tue, 09 May 2023 14:52:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 14:52:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 14:52:39 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <naomi.chu@mediatek.com>, <wsd_upstream@mediatek.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH 1/2] block: make the fair sharing of tag configurable
Date:   Tue, 9 May 2023 14:52:29 +0800
Message-ID: <20230509065230.32552-2-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230509065230.32552-1-ed.tsai@mediatek.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new queue flag QUEUE_FLAG_FAIR_TAG_SHARING to make the fair tag
sharing configurable.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 block/blk-mq-debugfs.c | 1 +
 block/blk-mq-tag.c     | 1 +
 block/blk-mq.c         | 3 ++-
 include/linux/blkdev.h | 6 +++++-
 4 files changed, 9 insertions(+), 2 deletions(-)

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
index f6dad0886a2f..f903107759f7 100644
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

