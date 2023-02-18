Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D769B9AE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBRLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBRLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:17:59 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430361E1C0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x8so217019pfn.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUC5VpRQ+Ac+lj9Yg4rT6e7fy64d+1PZ95QiUW9T0f0=;
        b=L6RS2NfSIeSXxStr65xeKi50qynabbVHyn1UXxRcFOQufPLZtK08i1OiLJEp9hJQ7K
         rUKjpKY0g3r8yXPkvsop7ktcGvX2zSGJcNmdq9qMQfKgrmyyEm3AEfdHnRXlsJ/p2H0S
         EVUvsiSqyjhofHzgHpHBcKINd4JPvlks4JsmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUC5VpRQ+Ac+lj9Yg4rT6e7fy64d+1PZ95QiUW9T0f0=;
        b=TBRDZzdE3xucvcgjcXlE0FqP+oet3mGI/qGInYMLu/s1pK+IRihC/wz+7dwTfeMPSF
         vBki/QnQoQv99nd7bMnZrPjAUh6cR1MGoL6dA7gkZQe9L2H23EVIB3KIRCyn3zyrvKtx
         4RzOrwEi4DwR7OPDln06jWi8wWIed7QiOuSbMHz7lrL4s01pnJ18JczIbAl86LYM2B/U
         uZkWS4Ao8z788njcGvMJjHJPTpPYB0c/cYHDnlh/QUYXZY7omyfWPzmqzQs/gQOLprLv
         Wj2gcfs5KX3x43HqM6oa8oG8SD5yZ/bDr03dPkCRgjXlcx3bMA0xCuayTd+kwtL4CRyh
         d8TQ==
X-Gm-Message-State: AO0yUKWdGscVNmp6zi5Xd3mCJHYbPyC/ii51E6PVBSzyrrWOejg3/Fzj
        7dvgVEEQfxf2YbhhODcgb/Y7jg==
X-Google-Smtp-Source: AK7set/DVZJFasYpEc2/i7C4jXudZU0Ni1NtI2PEwLI8N4heb0cpLrlwrxj4855uNK5y7WV7aIRFHw==
X-Received: by 2002:a62:5f86:0:b0:5a9:cb37:cfb7 with SMTP id t128-20020a625f86000000b005a9cb37cfb7mr5172705pfb.25.1676719060719;
        Sat, 18 Feb 2023 03:17:40 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:88dd:be84:8f65:fec2])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b005a8686b72fcsm4457829pfi.75.2023.02.18.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 03:17:40 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 3/5] drm/mediatek: Remove .get_edid callback
Date:   Sat, 18 Feb 2023 19:17:10 +0800
Message-Id: <20230218111712.2380225-4-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230218111712.2380225-1-treapking@chromium.org>
References: <20230218111712.2380225-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original implementation peaking into the remote nodes to get the
ddc bus fwnode, which is not a good practice. Remove the callback from
this driver and rely on drm_connector helpers to read EDID.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v3:
- New in v3

 drivers/gpu/drm/mediatek/mtk_hdmi.c | 53 +++++++----------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 0a8e0a13f516..44952e539059 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -159,7 +159,6 @@ struct mtk_hdmi {
 	const struct mtk_hdmi_conf *conf;
 	struct phy *phy;
 	struct device *cec_dev;
-	struct i2c_adapter *ddc_adpt;
 	struct clk *clk[MTK_HDMI_CLK_COUNT];
 	struct drm_display_mode mode;
 	bool dvi_mode;
@@ -1265,21 +1264,6 @@ static enum drm_connector_status mtk_hdmi_bridge_detect(struct drm_bridge *bridg
 	return mtk_hdmi_detect(hdmi);
 }
 
-static struct edid *mtk_hdmi_bridge_get_edid(struct drm_bridge *bridge,
-					     struct drm_connector *connector)
-{
-	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
-	struct edid *edid;
-
-	if (!hdmi->ddc_adpt)
-		return NULL;
-	edid = drm_get_edid(connector, hdmi->ddc_adpt);
-	if (!edid)
-		return NULL;
-	hdmi->dvi_mode = !drm_detect_monitor_audio(edid);
-	return edid;
-}
-
 static int mtk_hdmi_bridge_attach(struct drm_bridge *bridge,
 				  enum drm_bridge_attach_flags flags)
 {
@@ -1390,10 +1374,19 @@ static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 {
 	struct drm_atomic_state *state = old_state->base.state;
 	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
+	struct edid *edid;
 
 	/* Retrieve the connector through the atomic state. */
-	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state,
-								   bridge->encoder);
+	if (!hdmi->curr_conn)
+		hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(
+			state, bridge->encoder);
+
+	if (hdmi->curr_conn->edid_blob_ptr) {
+		edid = (struct edid *)hdmi->curr_conn->edid_blob_ptr->data;
+		hdmi->dvi_mode = !drm_detect_monitor_audio(edid);
+	} else {
+		dev_err(hdmi->dev, "No edid in drm_connector object\n");
+	}
 
 	mtk_hdmi_output_set_display_mode(hdmi, &hdmi->mode);
 	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PLL]);
@@ -1417,7 +1410,6 @@ static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
 	.atomic_pre_enable = mtk_hdmi_bridge_atomic_pre_enable,
 	.atomic_enable = mtk_hdmi_bridge_atomic_enable,
 	.detect = mtk_hdmi_bridge_detect,
-	.get_edid = mtk_hdmi_bridge_get_edid,
 };
 
 static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
@@ -1425,7 +1417,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *cec_np, *remote, *i2c_np;
+	struct device_node *cec_np, *remote;
 	struct platform_device *cec_pdev;
 	struct regmap *regmap;
 	struct resource *mem;
@@ -1497,24 +1489,6 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 		}
 	}
 
-	i2c_np = of_parse_phandle(remote, "ddc-i2c-bus", 0);
-	if (!i2c_np) {
-		dev_err(dev, "Failed to find ddc-i2c-bus node in %pOF\n",
-			remote);
-		of_node_put(remote);
-		ret = -EINVAL;
-		goto put_device;
-	}
-	of_node_put(remote);
-
-	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
-	of_node_put(i2c_np);
-	if (!hdmi->ddc_adpt) {
-		dev_err(dev, "Failed to get ddc i2c adapter by node\n");
-		ret = -EINVAL;
-		goto put_device;
-	}
-
 	return 0;
 put_device:
 	put_device(hdmi->cec_dev);
@@ -1728,8 +1702,7 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
 	hdmi->bridge.of_node = pdev->dev.of_node;
-	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
-			 | DRM_BRIDGE_OP_HPD;
+	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	drm_bridge_add(&hdmi->bridge);
 
-- 
2.39.2.637.g21b0678d19-goog

