Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B065705DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjEQDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEQDTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:19:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA652114
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:19:04 -0700 (PDT)
X-UUID: 919b685cf46111ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bM0YNT+U36eWDYdIyW/GiESRO4pu/ZY5wFHIj9jl/Fk=;
        b=hbz45D82wcIIboPtdDa8xigSp7oNXmrpSTyL3u3UEJvTIcGycJ4oL4NIS0gT684vPCgFWHGR9IMxiu3X/W1kyuHIpBsr837zwxf+raUwJa5HSeTupZ0LeOKWxPatiXeLoMiZhBRRbOE+ZzJcK8dRHNAUTvBzEfZ+r7USypM55Sk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:2e7e0b34-cfa3-4e33-9886-90062db96ff5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:c2b50e6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 919b685cf46111ed9cb5633481061a41-20230517
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <xiaoming.ding@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 170742362; Wed, 17 May 2023 11:19:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 11:18:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 11:18:59 +0800
From:   Xiaoming Ding <xiaoming.ding@mediatek.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <fei.xu@mediatek.com>, <srv_heupstream@mediatek.com>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>
Subject: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date:   Wed, 17 May 2023 11:18:56 +0800
Message-ID: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLL_LONGTERM will avoid share memory alloc from CMA region,
which may be used in secure playback case.
if part of CMA region taken by share memory for long term usage,
CMA will failed to get whole buffer back.

Signed-off-by: Xiaoming Ding <xiaoming.ding@mediatek.com>
---
 drivers/tee/tee_shm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 673cf0359494..ddd3947e2229 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -223,6 +223,7 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
 	size_t num_pages;
 	void *ret;
 	int rc;
+	u32 page_flag = FOLL_WRITE;
 
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
@@ -255,9 +256,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
 		ret = ERR_PTR(-ENOMEM);
 		goto err_free_shm;
 	}
-
+#if IS_ENABLED(CONFIG_CMA)
+	page_flag |= FOLL_LONGTERM;
+#endif
 	if (flags & TEE_SHM_USER_MAPPED)
-		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
+		rc = pin_user_pages_fast(start, num_pages, page_flag,
 					 shm->pages);
 	else
 		rc = shm_get_kernel_pages(start, num_pages, shm->pages);
-- 
2.18.0

