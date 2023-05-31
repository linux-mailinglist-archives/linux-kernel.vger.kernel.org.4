Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF9717A50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjEaIjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjEaIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:39:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFE122;
        Wed, 31 May 2023 01:39:02 -0700 (PDT)
X-UUID: 94cf3336ff8e11ed9cb5633481061a41-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0nv3Rl9Ah0Yurqkil5EC4EA2Z4hlg1w19JmuTm7+APQ=;
        b=mtnsGzE7RinVue+XL2iMRZmrc+bigQKb/3ebA8d+pwbfbCGRagViSmJFStkCGqlPFmsLLj/DKvo8GcR//KFG33M28wuXenoySUKbzsFt9+saHi8/4yaqA17H55qutIJsXjRfIA4MlKlaU44aTScpjEGrHwXeS1NpxE5yRYjU5Rk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:4553f587-a283-4f76-84c8-c87aef2abf4b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.25,REQID:4553f587-a283-4f76-84c8-c87aef2abf4b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:d5b0ae3,CLOUDID:92a7ec3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230531163859FAK7U5FV,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 94cf3336ff8e11ed9cb5633481061a41-20230531
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1126539607; Wed, 31 May 2023 16:38:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 16:38:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 16:38:55 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <axboe@kernel.dk>
CC:     <kbusch@kernel.org>, <liusong@linux.alibaba.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        <powen.kao@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>
Subject: blk-mq: check on cpu id when there is only one ctx mapping
Date:   Wed, 31 May 2023 16:38:28 +0800
Message-ID: <20230531083828.8009-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f168420 ("blk-mq: don't redirect completion for hctx withs only
one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx, there
will be no remote request.

But for ufs, the submission and completion queues could be asymmetric.
(e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
ctx won't complete request on the submission cpu. In this situation,
this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
check on cpu id when there is only one ctx mapping.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
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

