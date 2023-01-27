Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E267EA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjA0QQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjA0QQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:16:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F09D7D6CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:16:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so3862995wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op30N8VplB3ypI088BE1DuG6HdC3ZVERGlwL+v56hF8=;
        b=SZmfIny3U/S8qG+e/WnJPW4Ssp//fHLsfmZRnuGKIjQTiMoUmWHXcxyZjYy1KVA7QS
         oaCB2QrEooTl9JsCGk5BX2yDzWNkkiEWfQKklWElFXvT5LuTZ8bl6PA8gvRxnJiuFQCQ
         ys/gWBK0HZXF0WohL0y6qH1/kbm86bd0lvIE5rIwCVnNwBXpou+1efVA4qJxT0PBMkNz
         uUqCAIDiXkYYJoRn+34edZorjJOJ8YWGQ7jt1oNyZ1865LL63dXK3s4fGMeaRKCwlFFL
         WzgoOyT8vV2UQ4rOZYkBaUxxGTudg8Ca3ay0+6v2g4tpfg5b0E8kHpd1HDjOaU0sE3o9
         uxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op30N8VplB3ypI088BE1DuG6HdC3ZVERGlwL+v56hF8=;
        b=7/asQ7qpTn2c2ZE9unPoeYTxi6PnDLfaykDtvA7n0g5kk3SWlJaPtnXpVfSazjUfx9
         MMtap5j926257pwQkqfIsh+3Tl+OgFIBBINa/ab3gFGaC1JGCnXZvlSKRkU/MdfBx2kg
         ljkysSzYZTpW1gqmIUIpfltmpkrBREwNPyK0auJxfC7Lc4GILZ5FXRYxuFhqzXjCJNQV
         ux5OXmvu81kH8qylSZQNDJQen7L6r/nWTXw42ZSFiejEnttfZ8SPTqmkYvFLslL/1GNi
         z2jZrdcQ+nspEJEnFyUigs5HHUxSBLjkkCM3utC6+0p9UwWqAHJISrrcCSlna1a/4Nzm
         5Jaw==
X-Gm-Message-State: AFqh2krRzLqQvfpdYUC0uB+5Dc4C02d1cdFJSAyKROWf13PfkbufA8dc
        J8AWljMnZCYgW3spByTJZjnKtQ==
X-Google-Smtp-Source: AMrXdXuordLziVYmuuVYBeA7Bkt5b1HbFTqNvAAo/MRucQWcpaadudaJmH5tq/D7Ta4P+ZjFAaTv7A==
X-Received: by 2002:a05:600c:21c4:b0:3da:fcf1:d4cc with SMTP id x4-20020a05600c21c400b003dafcf1d4ccmr40404327wmj.30.1674836178781;
        Fri, 27 Jan 2023 08:16:18 -0800 (PST)
Received: from [127.0.0.1] ([2a01:cb19:85c2:1100:7fe1:513:212f:568e])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c439300b003cfd4e6400csm4744566wmn.19.2023.01.27.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:16:18 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 27 Jan 2023 17:11:35 +0100
Subject: [PATCH v6 2/3] phy: phy-mtk-hdmi: Add generic phy configure callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v6-2-2f641c422cb6@baylibre.com>
References: <20220919-v6-0-2f641c422cb6@baylibre.com>
In-Reply-To: <20220919-v6-0-2f641c422cb6@baylibre.com>
To:     David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stuart.lee@mediatek.com,
        Guillaume Ranquet <granquet@baylibre.com>,
        mac.shen@mediatek.com, kernel test robot <lkp@intel.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
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
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
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
2.39.0
