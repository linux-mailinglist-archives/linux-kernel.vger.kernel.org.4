Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910AC6325A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiKUOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiKUOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:23:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36613EBA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:23:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z4so5504519wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X1Ix6DYXkJKvOpCSL0+NcLZ4Uv+Ocb7clfjl/SWGQ0=;
        b=s71oMRkklsqZnyDb1zK5ceAUQtV8Td4tfuhmrW723HFjndQp4ccUQjRuPU3zrCoDCM
         2FFYLqlWjAwsMI3H1wi+nlgzfEs2JMhzpZdyyfSGFxRd/9x77YaAc0rJ4wLatZR3cECi
         Zai/ujmpKvZkV+KVrqlrcz9nuEevuNPep2mfAt92eysFprjZ5kvxAm1/ABmCe9NWc6l8
         3LksNERiu28C54gtUeqmc7zfk+lwJKWcpNwOIRqbgtgJEHrEM0e0CzsKHVReEFKkZ38S
         9VO2LPiy8kZUmUJi2hmVLGSA6XK1LanqxuLG77jUXVcQJQklinb8IAb86Q3CcDKl8yYn
         vSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X1Ix6DYXkJKvOpCSL0+NcLZ4Uv+Ocb7clfjl/SWGQ0=;
        b=sVfMjGuhfd9QD/PVwCqM35ReRWohooH1VNzKllZCIye07hf0vUD+QfmqOTNQRs5VMv
         bsjsl0UV+hQ7XZvTAZ8iV46RB/IsngRL78V1vKM8uAj/cwJBpR0x5knR5zwQlZsXM7PI
         UjTEXJlxXsUYe5OGcIt9HWv5IKfb3/ywN++307eDclipAea4mPswwXzNkrfGBLyN7WUL
         vwYpiV8XCy57eqLytihqBiFasRt1JEdyoW3BtPXRH5Pum6HZQjKogtO8POdT7VsVIi9H
         51Xap0tpaSi2zStb9YiiSzXuTPRWW6z0jSUGXPrloBXQIUym6OqpUSckC3yCkpr078eW
         VWJA==
X-Gm-Message-State: ANoB5pl5twx9nzAJDepyuXWg4R7u8KvBUV15m+CitjjIjhdex2xH+pbT
        vwtk97EEBV/ix9wztiMQsENCSQ==
X-Google-Smtp-Source: AA0mqf7RIb1eFAjcM1IXnwT5b4P0Fd7112f1MpVA2+FDNojC2Brs0StDqsRvjN+qEhrL3UsK+BfV4g==
X-Received: by 2002:adf:f38d:0:b0:241:cb5d:113e with SMTP id m13-20020adff38d000000b00241cb5d113emr6039179wro.353.1669040594871;
        Mon, 21 Nov 2022 06:23:14 -0800 (PST)
Received: from [127.0.0.1] (2a02-8440-6441-244f-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6441:244f:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b003b4fe03c881sm20206468wmq.48.2022.11.21.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:23:14 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 21 Nov 2022 15:19:12 +0100
Subject: [PATCH v4 2/3] phy: phy-mtk-hdmi: Add generic phy configure callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v4-2-bdc21e1307e9@baylibre.com>
References: <20220919-v4-0-bdc21e1307e9@baylibre.com>
In-Reply-To: <20220919-v4-0-bdc21e1307e9@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Guillaume Ranquet <granquet@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stuart.lee@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some phys, such as mt8195, needs to have a configure callback defined.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi.c | 12 ++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index b16d437d6721..32f713301768 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -8,10 +8,12 @@
 
 static int mtk_hdmi_phy_power_on(struct phy *phy);
 static int mtk_hdmi_phy_power_off(struct phy *phy);
+static int mtk_hdmi_phy_configure(struct phy *phy, union phy_configure_opts *opts);
 
 static const struct phy_ops mtk_hdmi_phy_dev_ops = {
 	.power_on = mtk_hdmi_phy_power_on,
 	.power_off = mtk_hdmi_phy_power_off,
+	.configure = mtk_hdmi_phy_configure,
 	.owner = THIS_MODULE,
 };
 
@@ -43,6 +45,16 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int mtk_hdmi_phy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(phy);
+
+	if (hdmi_phy->conf->hdmi_phy_configure)
+		return hdmi_phy->conf->hdmi_phy_configure(phy, opts);
+
+	return 0;
+}
+
 static const struct phy_ops *
 mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
 {
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
index c7fa65cff989..f5aac9d352d8 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
@@ -24,6 +24,7 @@ struct mtk_hdmi_phy_conf {
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
+	int (*hdmi_phy_configure)(struct phy *phy, union phy_configure_opts *opts);
 };
 
 struct mtk_hdmi_phy {

-- 
2.38.1
