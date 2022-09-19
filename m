Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384A15BD2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiISRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiISRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:00:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B78371AC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so156979ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=g8hZh96h7kcVe0FwyV/2fd9otBYm0/NItAoi3rrV5Yw=;
        b=xLxEGxkLE9ts8PrWjFZFQCdOiglt2QkS+aUCn873bVHln5LsU0bvqAVn5LFP05/Yyr
         Q3qRpEst57E9SGRzI8qpwLl2n81lnV7mXZ8ciDQ4f+3wWKaYsFb2M2yp0JVu14Rkzx4t
         imIkYqSNoVVEaxFbAdujyag9f5p4E4p5mOkIQP3u5LxjGS3mUDhFyoxzELq+k/uubc9L
         MZrTbOobCprscw8nBrp+kaWxRcV20dNkKLyny7J28BijqGfXNFdD0jNIoHenj01MLEvJ
         CyJJL8ZP5n7MOZGHu2N9lqRQedIinPzfrVndKqNhcJdYpXLaOzgQFoR/WoFNLT2htXpU
         HC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g8hZh96h7kcVe0FwyV/2fd9otBYm0/NItAoi3rrV5Yw=;
        b=A5n2be5WVvo7/UT8/6wSd4Wrr73OlnwJa3T/3aa6AZS1KjbPtUjmsKkM2RUVX/7Dnh
         ee8ti5hPCAHKdeTPZNiXDxjVsGH8yQ2AZ6Uvg6/W1OCEJ/WBkV2JPur6UNVjNSF70MXk
         CQTPy0d9di6oLbX0w/rYt6PxUAMUPw0XKE0bGJhPTc5rJhxYZRpVUpcLxXNrpLa5kUy0
         KIeS87JrI/VbuTdkQQJawsEaj5vsenCOKJcydmzrBvRV+JAXo8AU+tiU5w7d8GAVA9pw
         SNcOR69fkhf9i1RXalLm3wBGMrPJmEwYS6D0fj1TFKzsFteOCJP9dopt11IUBwY+L6Nv
         QQIA==
X-Gm-Message-State: ACrzQf1doOwr1YiUTQj8P9axCparyI1uMhmIxH04HMKrR23HUoQs9sOv
        qc4+4O4+j9CJaotAWvSMTSljEQ==
X-Google-Smtp-Source: AMsMyM4DJI7JfhQLtMN2LYTOhc8B3W1+i58GmxhTOF/MVrCsnqMqyiepx3Iq5rhTvArkC9ga2QF9Xg==
X-Received: by 2002:a17:907:1ded:b0:76f:af8f:942e with SMTP id og45-20020a1709071ded00b0076faf8f942emr13451537ejc.120.1663606802567;
        Mon, 19 Sep 2022 10:00:02 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6340-f287-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f287:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id cf16-20020a0564020b9000b0044fc3c0930csm20424246edb.16.2022.09.19.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:00:01 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 19 Sep 2022 18:56:07 +0200
Subject: [PATCH v1 09/17] drm/mediatek: hdmi: add connector flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v1-9-4844816c9808@baylibre.com>
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

Add a flag to indicate support for an external connector

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 86653ebaacfd..30407603d693 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -199,20 +199,22 @@ int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
 		goto put_device;
 	}
 
-	remote = of_graph_get_remote_node(np, 1, 0);
-	if (!remote) {
-		ret = -EINVAL;
-		goto put_device;
-	}
-
-	if (!of_device_is_compatible(remote, "hdmi-connector")) {
-		hdmi->next_bridge = of_drm_find_bridge(remote);
-		if (!hdmi->next_bridge) {
-			dev_err(dev, "Waiting for external bridge\n");
-			of_node_put(remote);
-			ret = -EPROBE_DEFER;
+	if (hdmi->conf->has_connector) {
+		remote = of_graph_get_remote_node(np, 1, 0);
+		if (!remote) {
+			ret = -EINVAL;
 			goto put_device;
 		}
+
+		if (!of_device_is_compatible(remote, "hdmi-connector")) {
+			hdmi->next_bridge = of_drm_find_bridge(remote);
+			if (!hdmi->next_bridge) {
+				dev_err(dev, "Waiting for external bridge\n");
+				of_node_put(remote);
+				ret = -EPROBE_DEFER;
+				goto put_device;
+			}
+		}
 	}
 
 	i2c_np = of_parse_phandle(remote, "ddc-i2c-bus", 0);
@@ -325,6 +327,7 @@ int mtk_drm_hdmi_remove(struct platform_device *pdev)
 static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
 	.tz_disabled = true,
 	.has_cec = true,
+	.has_connector = true,
 	.bridge_funcs = &mtk_mt8183_hdmi_bridge_funcs,
 	.mtk_hdmi_output_init = mtk_hdmi_output_init_mt8183,
 	.mtk_hdmi_clk_disable = mtk_hdmi_clk_disable_audio_mt8183,
@@ -338,6 +341,7 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 = {
 	.max_mode_clock = 148500,
 	.cea_modes_only = true,
 	.has_cec = true,
+	.has_connector = true,
 	.bridge_funcs = &mtk_mt8183_hdmi_bridge_funcs,
 	.mtk_hdmi_output_init = mtk_hdmi_output_init_mt8183,
 	.mtk_hdmi_clk_disable = mtk_hdmi_clk_disable_audio_mt8183,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
index 921bde150e11..62a14435be69 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
@@ -32,6 +32,7 @@ struct mtk_hdmi_conf {
 	bool tz_disabled;
 	bool cea_modes_only;
 	bool has_cec;
+	bool has_connector;
 	unsigned long max_mode_clock;
 	const struct drm_bridge_funcs *bridge_funcs;
 	void (*mtk_hdmi_output_init)(struct mtk_hdmi *hdmi);

-- 
b4 0.10.0-dev
