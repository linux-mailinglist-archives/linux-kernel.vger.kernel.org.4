Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B066507F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLSHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiLSHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:00:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE1C6E;
        Sun, 18 Dec 2022 23:00:50 -0800 (PST)
X-UUID: c5f9fcf1178c4b258e2e7ef65893e511-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BROO9oR3Wy6uXyXdf6VAMOjT4WTHQrLO8YJEyXD5pf0=;
        b=s8omwKzTGbwrTQIrRO8nvuguexXc2HqgFnpsHWE438TXr0fmU1QFjLcixggC3zWlLQqAgUawG+UwruAmRWj499j64gpDrRkgTZmwsgNMgzpbzaG/t904LoHG7Pamp103Tu4ADYC3T9XWj6VYP8OzuFJmTw49UgnzTVSriij59Bg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:7eef0291-34b7-477d-8601-0d00fe1fd3b4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:f27a2252-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c5f9fcf1178c4b258e2e7ef65893e511-20221219
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1754787933; Mon, 19 Dec 2022 15:00:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 15:00:42 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Dec 2022 15:00:41 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] media: mediatek: vcodec: Using pm_runtime_put instead of pm_runtime_put_sync
Date:   Mon, 19 Dec 2022 15:00:40 +0800
Message-ID: <20221219070040.2434-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_put will set RPM_ASYNC flag then queue an idle-notification
request again, won't return error immediately until current request is
scheduled. But pm_runtime_put_sync run the ->runtime_idle() callback
directly, will return error immediately.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 4305e4eb9900..341b406f5272 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -72,9 +72,9 @@ static void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 {
 	int ret;
 
-	ret = pm_runtime_put_sync(pm->dev);
+	ret = pm_runtime_put(pm->dev);
 	if (ret)
-		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
+		mtk_v4l2_err("pm_runtime_put fail %d", ret);
 }
 
 static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
-- 
2.25.1

