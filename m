Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337272F0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbjFNA0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbjFNA0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:26:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C01980;
        Tue, 13 Jun 2023 17:26:31 -0700 (PDT)
X-UUID: 1a3fe1580a4a11ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2uy7+tbw1Y+OXG3TkTMsX7CtXTp/7125jL2NZJ+Idfc=;
        b=gQ9sGR3+KlNe79dhoLjaUuRNiFG75wC79fmSpvmB043BC5IRIT7QxjT/7gx/G9aKhpS/B/jOid5Lfzy4X3/C2bD9vPYkcCXzPSLAundwUw+ntfmP23K5n9HUUlM28VgsAz1q2tQ8eIf769FeOZZvdqzg3M0cfCdpUXwmnS/DfgY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:18cfa8ad-5e09-4811-be40-661661b4fd81,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:9b57f96e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1a3fe1580a4a11ee9cb5633481061a41-20230614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2114748177; Wed, 14 Jun 2023 08:26:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 08:26:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 08:26:22 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <axboe@kernel.dk>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <kbusch@kernel.org>,
        <amergnat@baylibre.com>, <liusong@linux.alibaba.com>,
        <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <Chun-Hung.Wu@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v3] blk-mq: check on cpu id when there is only one ctx mapping
Date:   Wed, 14 Jun 2023 08:25:29 +0800
Message-ID: <20230614002529.6636-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f168420c62e7 ("blk-mq: don't redirect completion for hctx withs
only one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx,
there will be no remote request.

But for ufs, the submission and completion queues could be asymmetric.
(e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
ctx won't complete request on the submission cpu. In this situation,
this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
check on cpu id when there is only one ctx mapping.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Suggested-by: Keith Busch <kbusch@kernel.org>

---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 41f7e2b500bd..ecc30ebe9483 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1176,7 +1176,8 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	 * or a polled request, always complete locally,
 	 * it's pointless to redirect the completion.
 	 */
-	if (rq->mq_hctx->nr_ctx == 1 ||
+	if ((rq->mq_hctx->nr_ctx == 1 &&
+	     rq->mq_ctx->cpu == raw_smp_processor_id()) ||
 		rq->cmd_flags & REQ_POLLED)
 		return false;
 
-- 
2.18.0

