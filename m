Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9A7153C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjE3Clf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE3Cld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:41:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E6A8;
        Mon, 29 May 2023 19:41:31 -0700 (PDT)
X-UUID: 7982e574fe9311ed9cb5633481061a41-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qQkRn78F4m8QN2PjOiwEOoJXrUMDRX+JHKVaHWxbwlQ=;
        b=JV8vPxj8ra8ZUq7c+io7j7bi+5MP8Fbtov19lVhQrfAPLHcH/01DU/o6SkKplWFuhmfClgmKxJUGGjNvyMH9vrQ+FRhZsJNPBwyljG4Y0DqFWMzqBmXLL7rGQj97e3vyunE2Mim9LE7LJWeITZ/BymuRaxYf17MK13Fli2xqyVo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ef7388d8-ace4-42b4-9f53-c243b9157b27,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9cd4646d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 7982e574fe9311ed9cb5633481061a41-20230530
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 697670874; Tue, 30 May 2023 10:41:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 10:41:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 10:41:25 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: [PATCH v1 1/1] nvme: complete directly for hctx with only one ctx mapping
Date:   Tue, 30 May 2023 10:41:19 +0800
Message-ID: <20230530024120.17196-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Tsai <ed.tsai@mediatek.com>

Refer to
commit f168420c62e7
("blk-mq: don't redirect completion for hctx withs only one ctx mapping")
When nvme applies a 1:1 mapping of hctx and ctx, there will be no remote
request.

But for ufs, the submission and completion queue could be asymmetric.
(e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
ctx won't complete request on the submission cpu. In this situation,
put this condition in block layer could violate the
QUEUE_FLAG_SAME_FORCE, as a result, move this back to nvme.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 block/blk-mq.c           | 8 +++-----
 drivers/nvme/host/nvme.h | 4 ++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1749f5890606..b60c78f5ad46 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1181,12 +1181,10 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For request which hctx has only one ctx mapping,
-	 * or a polled request, always complete locally,
-	 * it's pointless to redirect the completion.
+	 * For a polled request, always complete locally, it's pointless
+	 * to redirect the completion.
 	 */
-	if (rq->mq_hctx->nr_ctx == 1 ||
-		rq->cmd_flags & REQ_POLLED)
+	if (rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7cf8e44d135e..acc9b1ce071d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -702,6 +702,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 	nvme_should_fail(req);
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return true;
+	if (likely(req->mq_hctx->nr_ctx == 1)) {
+		WRITE_ONCE(req->state, MQ_RQ_COMPLETE);
+		return false;
+	}
 	return blk_mq_complete_request_remote(req);
 }
 
-- 
2.18.0

