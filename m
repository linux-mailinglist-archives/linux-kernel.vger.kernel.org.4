Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCA5FF123
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJNPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJNPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:20:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD334727
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:20:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so8058129wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZMIvZlN2RweJkUN5B//uFf7tgMLArGLgtt1G8UfvMA=;
        b=vyYoDAHlbaol64KHta05nB/feVbxAif5WWgpsifdznUOiy0di03Ab/Co8SnivrMsJs
         TwcHLdlOhXHiuwhAm5ola2rnegGShmaT4jbbjQ93+WA3p1XCn5a9Ruyj+sz68Tfe+iRH
         MooqlXsU+aozyTmQ3Z4B6Ufgu/0EhNKBypN88exKPsOTRLTzqMjEiZ+I64/zDYzS2ZFv
         glMduOTKNrBE1uMiSknPb47QKvQ1Fslp3lVWBD5eaY7Xh9sEgdiMpgnqf+1LMMxWDfXx
         DjkIHq6i/wFHokwDziPOcQ1XKYJtfqe1Q56wbHlY9yLMkutYHgzh5J0cgVlrC5zcqe/j
         DqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZMIvZlN2RweJkUN5B//uFf7tgMLArGLgtt1G8UfvMA=;
        b=kULiNKzT8V3GFXtFjIq6erT6qM1n3Ds9Gynhia7Ry9NDajIg+B2py/A9qfbS7L89gl
         JKSGKnjDhFShhljT0HUvzhkFYS1alKSamP8tF/Bb8WiXMTozFwCWLZkkqvtg6m8KVqhC
         sdlQAv8C1mBVHQCL4aumXsWemGt4oomW2iz1/bq6ymOH2r8VlvAiQSx3ayiWYr1Vs1BJ
         b89h03oSQ/SZnZdec+GXCGroHw2FPPqMCIR0Nfw7wBfm6unhymW9xUtbzufz7hUzKhxd
         8nHSyLmntMDxBGZp2Yo5ALz7h3aCVMEFmdTbLJrY9TZDKi3SIRk87MIfzqL1cjoxhAjf
         grNQ==
X-Gm-Message-State: ACrzQf2iQhUb/S0AeZMgvCrKMYv/HpZVS6B9lrBEcnmqWdgy3fA84UMK
        B9EM//J82ud8o6tAla6hYDxIAQ==
X-Google-Smtp-Source: AMsMyM6fsEM7Zok+4dA1E8vJbMNpo8X1aKWBTLgOrRBTYmZAFS6rLY4/4rxttdckY90lLewdsLeanQ==
X-Received: by 2002:adf:b646:0:b0:221:76eb:b3ba with SMTP id i6-20020adfb646000000b0022176ebb3bamr3687815wre.237.1665760818451;
        Fri, 14 Oct 2022 08:20:18 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6241-7429-3074-96af-9642-0004.rev.sfr.net. [2a02:8440:6241:7429:3074:96af:9642:4])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003c6bd91caa5sm2818223wmp.17.2022.10.14.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:20:18 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 14 Oct 2022 17:16:02 +0200
Subject: [PATCH v2 09/12] phy: phy-mtk-hdmi: Add generic phy configure callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v2-9-8419dcf4f09d@baylibre.com>
References: <20220919-v2-0-8419dcf4f09d@baylibre.com>
In-Reply-To: <20220919-v2-0-8419dcf4f09d@baylibre.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jitao shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Guillaume Ranquet <granquet@baylibre.com>, stuart.lee@mediatek.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mac.shen@mediatek.com, linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
b4 0.11.0-dev
