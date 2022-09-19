Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A484A5BD2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiISRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiISRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:00:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB333A3D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id 13so156672ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=HLkgjmfUQZXrBufYXmW5V+FjpCBTnrnJRl8bPfgjGi0=;
        b=iCp4PRqRut8ldEn6iFDY5780nxcwQxypuEqbmfTvfX+LeaUV0TBlilns6GCWIlnwrq
         CiunYZfYC1IndkJR3gnSQ4FcJF4TiUnJYlWWbk6h+p035qcTxa1oHPK+O+pAuXcCXMw1
         LMpjCRzZR/vSqVIB7Ng/g+wzpRJhyDQ1tAyyRG6ag7jXkiGaWcAQBDPrZHK6tIPuir3i
         FJelQbDn/dhuzkO0e0r6jNWMX2zLGGvK8DS59YGysg/RVD7XXX6JNM7WRoaEE5ppbj+r
         FD+ecJG4zoLcLkbU/ZVidIhIdeppq99UGS7J0oDwTXyZQkt5err89RZjpn5BCdJ5atTZ
         F5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HLkgjmfUQZXrBufYXmW5V+FjpCBTnrnJRl8bPfgjGi0=;
        b=u84P0iPBOUtucnxhlMulYGq5GpEqWMyPS7GasMnfCUhQo4B+Dmsxc21ncdEJ2pgHWn
         fVmYJeUkoPEQ/UwyZwHFr7obvgZzRYUT/e58NmD4Pm0mxMPc4z7u9wSvbil8p2Kx2Yr4
         SXh/Ll/ICwmb/ENhaCEz4nx+tbZlR1yjV4L5Sw5xBDWCALQFxsDxSGG82bK58IHyBKMW
         eYSGri699j1/RwG0lJT/e7PiuRs2BJo4cqrqndcyUYmL9+rVIPVdyjrfQAsUkO7Y5pii
         kRWsUB4IURkx73mFMBmsmhs1NtXZid2xJRvk87cqhxRDtuHcvnq/lS5seWCk90TTbUDV
         0SSQ==
X-Gm-Message-State: ACrzQf2cvgXfuT68iKCwpooxiH522JYXv/m9wfrvnSiKpquQUo6cwj1b
        w/PeFLa6MyDbOHcEI3yTPI1VzQ==
X-Google-Smtp-Source: AMsMyM68qjQqULpZ/BI4lE6+kDmd0BZAyqrmHiJF5y5T8zzA2DF8Y6DbzBptf6WxEg9nnyn2opsPwQ==
X-Received: by 2002:a17:907:7b93:b0:770:1d4f:4de9 with SMTP id ne19-20020a1709077b9300b007701d4f4de9mr13596890ejc.201.1663606799750;
        Mon, 19 Sep 2022 09:59:59 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6340-f287-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f287:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id cf16-20020a0564020b9000b0044fc3c0930csm20424246edb.16.2022.09.19.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:59:59 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 19 Sep 2022 18:56:06 +0200
Subject: [PATCH v1 08/17] drm/mediatek: hdmi: add cec flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v1-8-4844816c9808@baylibre.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
In-Reply-To: <20220919-v1-0-4844816c9808@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to indicate support for cec.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index bfcca6f8b839..86653ebaacfd 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -154,35 +154,38 @@ int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
 		return ret;
 	}
 
-	/* The CEC module handles HDMI hotplug detection */
-	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
-	if (!cec_np) {
-		dev_err(dev, "Failed to find CEC node\n");
-		return -EINVAL;
-	}
+	if (hdmi->conf->has_cec) {
+		/* The CEC module handles HDMI hotplug detection */
+		cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
+		if (!cec_np) {
+			dev_err(dev, "Failed to find CEC node\n");
+			return -EINVAL;
+		}
 
-	cec_pdev = of_find_device_by_node(cec_np);
-	if (!cec_pdev) {
-		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n", cec_np);
+		cec_pdev = of_find_device_by_node(cec_np);
+		if (!cec_pdev) {
+			dev_err(hdmi->dev, "Waiting for CEC device %pOF\n", cec_np);
+			of_node_put(cec_np);
+			return -EPROBE_DEFER;
+		}
 		of_node_put(cec_np);
-		return -EPROBE_DEFER;
-	}
-	of_node_put(cec_np);
-	hdmi->cec_dev = &cec_pdev->dev;
-	/*
-	 * The mediatek,syscon-hdmi property contains a phandle link to the
-	 * MMSYS_CONFIG device and the register offset of the HDMI_SYS_CFG
-	 * registers it contains.
-	 */
-	regmap = syscon_regmap_lookup_by_phandle(np, "mediatek,syscon-hdmi");
-	ret = of_property_read_u32_index(np, "mediatek,syscon-hdmi", 1, &hdmi->sys_offset);
-	if (IS_ERR(regmap))
-		ret = PTR_ERR(regmap);
-	if (ret) {
-		dev_err(dev, "Failed to get system configuration registers: %d\n", ret);
-		goto put_device;
+		hdmi->cec_dev = &cec_pdev->dev;
+		/*
+		 * The mediatek,syscon-hdmi property contains a phandle link to the
+		 * MMSYS_CONFIG device and the register offset of the HDMI_SYS_CFG
+		 * registers it contains.
+		 */
+		regmap = syscon_regmap_lookup_by_phandle(np, "mediatek,syscon-hdmi");
+		ret = of_property_read_u32_index(np, "mediatek,syscon-hdmi", 1, &hdmi->sys_offset);
+		if (IS_ERR(regmap))
+			ret = PTR_ERR(regmap);
+		if (ret) {
+			dev_err(dev,
+				"Failed to get system configuration registers: %d\n", ret);
+			goto put_device;
+		}
+		hdmi->sys_regmap = regmap;
 	}
-	hdmi->sys_regmap = regmap;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -230,7 +233,8 @@ int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
 
 	return 0;
 put_device:
-	put_device(hdmi->cec_dev);
+	if (hdmi->conf->has_cec)
+		put_device(hdmi->cec_dev);
 	return ret;
 }
 
@@ -320,6 +324,7 @@ int mtk_drm_hdmi_remove(struct platform_device *pdev)
 
 static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
 	.tz_disabled = true,
+	.has_cec = true,
 	.bridge_funcs = &mtk_mt8183_hdmi_bridge_funcs,
 	.mtk_hdmi_output_init = mtk_hdmi_output_init_mt8183,
 	.mtk_hdmi_clk_disable = mtk_hdmi_clk_disable_audio_mt8183,
@@ -332,6 +337,7 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
 static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 = {
 	.max_mode_clock = 148500,
 	.cea_modes_only = true,
+	.has_cec = true,
 	.bridge_funcs = &mtk_mt8183_hdmi_bridge_funcs,
 	.mtk_hdmi_output_init = mtk_hdmi_output_init_mt8183,
 	.mtk_hdmi_clk_disable = mtk_hdmi_clk_disable_audio_mt8183,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
index 7452bea91f9e..921bde150e11 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
@@ -31,6 +31,7 @@
 struct mtk_hdmi_conf {
 	bool tz_disabled;
 	bool cea_modes_only;
+	bool has_cec;
 	unsigned long max_mode_clock;
 	const struct drm_bridge_funcs *bridge_funcs;
 	void (*mtk_hdmi_output_init)(struct mtk_hdmi *hdmi);

-- 
b4 0.10.0-dev
