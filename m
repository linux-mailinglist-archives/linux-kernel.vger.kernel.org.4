Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F7717A57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjEaIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjEaIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:40:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BBE189;
        Wed, 31 May 2023 01:39:49 -0700 (PDT)
X-UUID: a861c878ff8e11edb20a276fd37b9834-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sV0HmmZUiWC6Xd0DtqakbNIl0Npt80+JI0PP8g3KMFo=;
        b=iCaUoCRyUVHWXUhOxlQM4PBnPKoZyUrb21NDECmyzdmBa8mzcTRwn2csd1WCFuM5Qq5rnZMXkjb1Jx+ZeDvWODkmjNdf4rczpdIs0U06nmw2cdDHrDa6e2simJj0c6rfQhLXf5PsEYWGGOPvhNm2dMQePo1FjtbAt/tn8wXYbDw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b2327885-da84-4d86-9f27-f942b856cc41,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.25,REQID:b2327885-da84-4d86-9f27-f942b856cc41,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:d5b0ae3,CLOUDID:e0abec3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230531163930DY68GEE0,BulkQuantity:0,Recheck:0,SF:17|19|48|29|28,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a861c878ff8e11edb20a276fd37b9834-20230531
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1974225482; Wed, 31 May 2023 16:39:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 16:39:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 16:39:28 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <axboe@kernel.dk>
CC:     <kbusch@kernel.org>, <liusong@linux.alibaba.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        <powen.kao@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v2] blk-mq: check on cpu id when there is only one ctx mapping
Date:   Wed, 31 May 2023 16:38:29 +0800
Message-ID: <20230531083828.8009-2-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230531083828.8009-1-ed.tsai@mediatek.com>
References: <20230531083828.8009-1-ed.tsai@mediatek.com>
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

commit f168420 ("blk-mq: don't redirect completion for hctx withs only
one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx, there
will be no remote request.

But for ufs, the submission and completion queues could be asymmetric.
(e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
ctx won't complete request on the submission cpu. In this situation,
this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
check on cpu id when there is only one ctx mapping.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
Change-Id: I4f95d7538532f72dcb20dacfdd639c97951c2729
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

