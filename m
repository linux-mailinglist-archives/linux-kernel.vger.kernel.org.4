Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B363C601645
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJQS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJQS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:28:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8474CE6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:28:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1okUqZ-0003ke-2z; Mon, 17 Oct 2022 20:28:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1okUqV-0027zM-Pr; Mon, 17 Oct 2022 20:28:15 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1okUqU-008Jaa-JN; Mon, 17 Oct 2022 20:28:14 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Archit Taneja <architt@codeaurora.org>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: adv7511: use dev_err_probe in probe function
Date:   Mon, 17 Oct 2022 20:28:09 +0200
Message-Id: <20221017182810.1981638-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adv7511 probe may need to be attempted multiple times before no
-EPROBE_DEFER is returned. Currently, every such probe results in
an error message:

[    4.534229] adv7511 1-003d: failed to find dsi host
[    4.580288] adv7511 1-003d: failed to find dsi host

This is misleading, as there is no error and probe deferral is normal
behavior. Fix this by using dev_err_probe that will suppress
-EPROBE_DEFER errors. While at it, we touch all dev_err in the probe
path. This makes the code more concise and included the error code
everywhere to aid user in debugging.

Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  6 ++----
 drivers/gpu/drm/bridge/adv7511/adv7533.c     | 18 ++++++------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 1c37779b434a..4148b6d6f151 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1229,10 +1229,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		return ret;
 
 	ret = adv7511_init_regulators(adv7511);
-	if (ret) {
-		dev_err(dev, "failed to init regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init regulators\n");
 
 	/*
 	 * The power down GPIO is optional. If present, toggle it from active to
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index ef6270806d1d..b32b796c25fb 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -148,16 +148,12 @@ int adv7533_attach_dsi(struct adv7511 *adv)
 						 };
 
 	host = of_find_mipi_dsi_host_by_node(adv->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
-	if (IS_ERR(dsi)) {
-		dev_err(dev, "failed to create dsi device\n");
-		return PTR_ERR(dsi);
-	}
+	if (IS_ERR(dsi))
+		return dev_err_probe(dev, PTR_ERR(dsi), "failed to create dsi device\n");
 
 	adv->dsi = dsi;
 
@@ -167,10 +163,8 @@ int adv7533_attach_dsi(struct adv7511 *adv)
 			  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to attach dsi to host\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to attach dsi to host\n");
 
 	return 0;
 }
-- 
2.30.2

