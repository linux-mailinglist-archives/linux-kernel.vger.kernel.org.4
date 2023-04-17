Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A26E3D98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDQCwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQCwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:52:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB51BEC;
        Sun, 16 Apr 2023 19:52:14 -0700 (PDT)
X-UUID: d82498c4dcca11eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Qh6zarOh98fchldCyV0UeHoUwNPvYTXdIyeS2Lngrzk=;
        b=UtcNocLj7P0nX2j9hdE/DYEPWNQ8/8tEV1SFpz4jjL/eIdOrJBEPsFgthi8es8jgzJqhNawSXnRtuK4AJOcTR4r7fb2liQfwO/lunHCbHEStlrgB6I0yFg6NFGmE3rVeCn+7oUaNSzzboBKD2SX/5+cMdXHpa1cVlB8Aatqs5UM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bec4139b-2146-4690-957f-ccf43ba04f37,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-META: VersionHash:120426c,CLOUDID:d76386a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d82498c4dcca11eda9a90f0bb45854f4-20230417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 418582238; Mon, 17 Apr 2023 10:52:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 10:52:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 10:52:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: [PATCH v3 3/7] usb: mtu3: fix kernel panic at qmu transfer done irq handler
Date:   Mon, 17 Apr 2023 10:51:59 +0800
Message-ID: <20230417025203.18097-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417025203.18097-1-chunfeng.yun@mediatek.com>
References: <20230417025203.18097-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle qmu transfer irq, it will unlock @mtu->lock before give back
request, if another thread handle disconnect event at the same time, and
try to disable ep, it may lock @mtu->lock and free qmu ring, then qmu
irq hanlder may get a NULL gpd, avoid the KE by checking gpd's value before
handling it.

e.g.
qmu done irq on cpu0                 thread running on cpu1

qmu_done_tx()
  handle gpd [0]
    mtu3_requ_complete()        mtu3_gadget_ep_disable()
      unlock @mtu->lock
        give back request         lock @mtu->lock
                                    mtu3_ep_disable()
                                      mtu3_gpd_ring_free()
                                   unlock @mtu->lock
      lock @mtu->lock
    get next gpd [1]

[1]: goto [0] to handle next gpd, and next gpd may be NULL.

Fixes: 48e0d3735aa5 ("usb: mtu3: supports new QMU format")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add Fixes tag suggested by AngeloGioacchino
v2: fix typo suggested by AngeloGioacchino
---
 drivers/usb/mtu3/mtu3_qmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 6be4977a5db5..3d77408e3133 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -210,6 +210,7 @@ static struct qmu_gpd *advance_enq_gpd(struct mtu3_gpd_ring *ring)
 	return ring->enqueue;
 }
 
+/* @dequeue may be NULL if ring is unallocated or freed */
 static struct qmu_gpd *advance_deq_gpd(struct mtu3_gpd_ring *ring)
 {
 	if (ring->dequeue < ring->end)
@@ -522,7 +523,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
+	while (gpd && gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
@@ -561,7 +562,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
+	while (gpd && gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
-- 
2.18.0

