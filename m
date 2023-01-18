Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B570667147E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjARGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjARGbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:31:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F32540BD4;
        Tue, 17 Jan 2023 22:21:27 -0800 (PST)
X-UUID: 533ae28496f811ed945fc101203acc17-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=73BY3Vgbw3t6Q3sPe77rJeiSjxD1qMfAnvy9gFdOjsY=;
        b=ClTuv/67iyuxVqUGKl6AMYFiUx2wc+vnmSnpIZRv2TLiaf84rzk6WEu8xGPmQSRsw18UJ+sf8lgAUUIfVsWTrXLHyZY2AaqqflsWZyNpipL3MggFZBI7DWGz7Y1AheQxnzjpSiemn4iVjuwIYlv1lLT57KROh7i1y3sjfWgMHU4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:1eba8fb2-4d0f-4893-aaa4-deb28695839a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:1eba8fb2-4d0f-4893-aaa4-deb28695839a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:fbd3958c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2301181421229LQD9Z6J,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: 533ae28496f811ed945fc101203acc17-20230118
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 259250046; Wed, 18 Jan 2023 14:21:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 14:21:20 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 14:21:19 +0800
From:   Guodong Liu <Guodong.Liu@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <Guodong.Liu@mediatek.com>
Subject: [PATCH] pinctrl: mediatek: Fix the drive register definition of some Pins
Date:   Wed, 18 Jan 2023 14:21:16 +0800
Message-ID: <20230118062116.26315-1-Guodong.Liu@mediatek.com>
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

The drive adjustment register definition of gpio13 and gpio81 is wrong:
"the start address for the range" of gpio18 is corrected to 0x000,
"the start bit for the first register within the range" of gpio81 is
corrected to 24.

Fixes: 6cf5e9ef362a ("pinctrl: add pinctrl driver on mt8195")
Signed-off-by: Guodong Liu <Guodong.Liu@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8195.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8195.c b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
index 563693d3d4c2..c21ca33b2d59 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8195.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
@@ -659,7 +659,7 @@ static const struct mtk_pin_field_calc mt8195_pin_drv_range[] = {
 	PIN_FIELD_BASE(10, 10, 4, 0x010, 0x10, 9, 3),
 	PIN_FIELD_BASE(11, 11, 4, 0x000, 0x10, 24, 3),
 	PIN_FIELD_BASE(12, 12, 4, 0x010, 0x10, 12, 3),
-	PIN_FIELD_BASE(13, 13, 4, 0x010, 0x10, 27, 3),
+	PIN_FIELD_BASE(13, 13, 4, 0x000, 0x10, 27, 3),
 	PIN_FIELD_BASE(14, 14, 4, 0x010, 0x10, 15, 3),
 	PIN_FIELD_BASE(15, 15, 4, 0x010, 0x10, 0, 3),
 	PIN_FIELD_BASE(16, 16, 4, 0x010, 0x10, 18, 3),
@@ -708,7 +708,7 @@ static const struct mtk_pin_field_calc mt8195_pin_drv_range[] = {
 	PIN_FIELD_BASE(78, 78, 3, 0x000, 0x10, 15, 3),
 	PIN_FIELD_BASE(79, 79, 3, 0x000, 0x10, 18, 3),
 	PIN_FIELD_BASE(80, 80, 3, 0x000, 0x10, 21, 3),
-	PIN_FIELD_BASE(81, 81, 3, 0x000, 0x10, 28, 3),
+	PIN_FIELD_BASE(81, 81, 3, 0x000, 0x10, 24, 3),
 	PIN_FIELD_BASE(82, 82, 3, 0x000, 0x10, 27, 3),
 	PIN_FIELD_BASE(83, 83, 3, 0x010, 0x10, 0, 3),
 	PIN_FIELD_BASE(84, 84, 3, 0x010, 0x10, 3, 3),
-- 
2.25.1

