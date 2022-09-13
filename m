Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A027E5B6EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiIMOCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiIMOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:02:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06551BE98;
        Tue, 13 Sep 2022 07:02:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0ADB46602016;
        Tue, 13 Sep 2022 15:02:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663077727;
        bh=fiGIiNykQrjpzh1k5qa71sltsz5JgetWMFsEzWdQqUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIP/l+02X2HOzkBv4sasLj1bbI5kuH2esQsBfcnTt7BM2GYmaIgiwnV7h1Zi7i7+c
         2NSq3boPtXFBxSxyxiKZQOYc/fprhlVw3qSZ2+1L0fnctMFEmYkSGP+YOwm6/ciLQB
         E/33CLOzJ4mY7BgZS7Cx2KwwZD4ZIXd8H6J5zFz2a+x3zHi61M+j4WKbt50VQioLbN
         U2A9gLs50gbNA2CoyPG5sTw6zIUO+CmJ9pRsBsXAXTv4T/zZ0By8D8I93moxQf4VbY
         uCbL+XM+JPqBxLfCW5PPtdbEZnA61WNHdmGVtjZYIzszz0CdtwzBS/rtQT+S8lPEWf
         Wrr9vIks6FAPA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        jason-jh.lin@mediatek.com, rex-bc.chen@mediatek.com,
        moudy.ho@mediatek.com, allen-kh.cheng@mediatek.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] soc: mediatek: mutex: Add support for MT6795 Helio X10 display mutex
Date:   Tue, 13 Sep 2022 16:01:21 +0200
Message-Id: <20220913140121.403637-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
References: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6795 has the same mutex mod/sof register layout as MT2712 and MT8173,
but supports only four SOF, as it has two DSI and one DPI.
Support is added by reusing most of the MT8173 data, with the addition
of a mt6795-specific SOF array (and devicetree compatible, of course).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index e82421386335..eb021e347753 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -433,6 +433,13 @@ static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
 };
 
+static const unsigned int mt6795_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
+	[MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
+	[MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
+};
+
 static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
@@ -487,6 +494,13 @@ static const struct mtk_mutex_data mt2712_mutex_driver_data = {
 	.mutex_sof_reg = MT2701_MUTEX0_SOF0,
 };
 
+static const struct mtk_mutex_data mt6795_mutex_driver_data = {
+	.mutex_mod = mt8173_mutex_mod,
+	.mutex_sof = mt6795_mutex_sof,
+	.mutex_mod_reg = MT2701_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_MUTEX0_SOF0,
+};
+
 static const struct mtk_mutex_data mt8167_mutex_driver_data = {
 	.mutex_mod = mt8167_mutex_mod,
 	.mutex_sof = mt8167_mutex_sof,
@@ -865,6 +879,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	  .data = &mt2701_mutex_driver_data},
 	{ .compatible = "mediatek,mt2712-disp-mutex",
 	  .data = &mt2712_mutex_driver_data},
+	{ .compatible = "mediatek,mt6795-disp-mutex",
+	  .data = &mt6795_mutex_driver_data},
 	{ .compatible = "mediatek,mt8167-disp-mutex",
 	  .data = &mt8167_mutex_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-mutex",
-- 
2.37.2

