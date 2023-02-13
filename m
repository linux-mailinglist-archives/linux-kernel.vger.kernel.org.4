Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9806944B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjBMLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjBMLip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:38:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B3EE073
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p26so31019019ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op30N8VplB3ypI088BE1DuG6HdC3ZVERGlwL+v56hF8=;
        b=vB8WykBafuRzRtDuguyc/Bo7sbY5f8z+gZOza7CCBeeEj6YTIzlIkJq/9c4EOPLl7C
         50Ee1gHpVfORgKOsSDYfzA9WuJGCvSwAAoDVcifSXr8s+InCZw2mDiGTae7uUdOWm8mt
         BcwlQKCl4oQx9mHeAK/roUU2AtelFtJ1kXJcs17xzwpymr7zFiHP+KN0M75x2IlqAk/M
         ssRZdEBzWecwlqDwlqi+JTyG4CffD+U03W843WrTFJ1mrTO8AjS7o4FZY5RPo6GoX4rL
         jhy7au2YWjp5Xi3WlVC+hNIc9AsFm6lEABGBUScDZhtW/akwnOb9YHELHjQh64vW83It
         uo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op30N8VplB3ypI088BE1DuG6HdC3ZVERGlwL+v56hF8=;
        b=cArMI2JeX1MLD1OKwXT/d5v5YkzNz6V9BTu7dExEp1+nBDMkEWXkWQjlAR0fEYq4Di
         JvAxF5ioPNC+rUykf6yDPUFmKEKCAgrLOfbEsEjvCisLSi0qErEL8h+/QpoETlsp9284
         f2QDtuw4FZOp8wK7IQom6rbAbEpOokZsXGZ4EJmMd9eRAZoFraX5Lsu4Cjcb09T4Yz1Z
         ePNdlP2uSMJvcAWimmAmqCrsB5xsmCQxxKWZo20sKH/TNandQMt4l/0I6wHzbd1HV0GY
         aZzEJ7HaSmaFtsD66nUI16PCVEQf1lCVaiQOu5S6SJRenXuniz1tTb7/xlS5zib77Tlh
         8GTQ==
X-Gm-Message-State: AO0yUKU80pkI84vLNXCTWpKA2fCosRWFqAwE4xhadx7btsG1HgIPpKlg
        J+4+MfCPF8OWlB07G+cffsWgig==
X-Google-Smtp-Source: AK7set+hnByAR87YpkSk8ZEV835WPhK7lmMocjr5dOOtPVxa4wOhPW/jWxc2FJLO53e5q5T3zl73pA==
X-Received: by 2002:a17:907:72cb:b0:8af:5750:917 with SMTP id du11-20020a17090772cb00b008af57500917mr12827958ejc.35.1676288322760;
        Mon, 13 Feb 2023 03:38:42 -0800 (PST)
Received: from [127.0.0.1] (2a02-8440-d206-ae05-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:d206:ae05:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906061400b0088ba2de323csm6638792ejb.181.2023.02.13.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:38:42 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 13 Feb 2023 12:33:33 +0100
Subject: [PATCH v7 2/3] phy: phy-mtk-hdmi: Add generic phy configure
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220919-v7-2-b5b58c5ccc07@baylibre.com>
References: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
In-Reply-To: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com, Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.13-dev
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

