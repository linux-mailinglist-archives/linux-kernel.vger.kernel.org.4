Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE66981BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBORRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjBORRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:17:39 -0500
X-Greylist: delayed 89012 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 09:17:32 PST
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6CF2DE4C;
        Wed, 15 Feb 2023 09:17:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4008ABFAEB;
        Wed, 15 Feb 2023 18:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676481448; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=tOQ4GCJqQIcdutDt62TtDCuCrq+2rPI1vsV+AOkH/r8=;
        b=DphvDi3j8QPey/TUZO9u7AlpSHBaHmKDiQxYftklbw9BLqxiGyluP3FY9rW2lNKHLyMI/Q
        B1GQpG4K2jXr1+gCme2TKjDXiAE7xRXaS8dVGaRMQ7vkIVyZJtdblYceCuPA7O4kfE6VN/
        WMGvvuKEKq9eWE5iEPkpizJwoAnYSoQCK1c6ZdR2Tb4fQRjfc2u6MKZa4nPQP6VL3W8jZE
        5KJ6WxM+SsJwGIieBsLb1mh3tTbFmqbMrlodH80A2W6nkjQ5xprId8SBX5V5QZF+HIVLLa
        o7s/tgILz5lPqUMJ+ZlrB3c7bXctSUTU0AsTuvys0H8j2aeVFF/8Hj6JyBELIA==
From:   Frieder Schrempf <frieder@fris.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2] media: imx: imx7-media-csi: Fix error handling in imx7_csi_async_register()
Date:   Wed, 15 Feb 2023 18:16:38 +0100
Message-Id: <20230215171642.2122786-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The CSI requires a connected source subdev to operate. If
fwnode_graph_get_endpoint_by_id() fails and returns NULL, there is no
point in going on. Print an error message and abort instead.

Also we don't need to check for an existing asd. Any failure of
v4l2_async_nf_add_fwnode_remote() should abort the probe.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* Improve commit message
* Use dev_err_probe
---
 drivers/media/platform/nxp/imx7-media-csi.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 886374d3a6ff..76ce6ff2c60a 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -2191,19 +2191,18 @@ static int imx7_csi_async_register(struct imx7_csi *csi)
 
 	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi->dev), 0, 0,
 					     FWNODE_GRAPH_ENDPOINT_NEXT);
-	if (ep) {
-		asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
-						      struct v4l2_async_subdev);
+	if (!ep)
+		return dev_err_probe(csi->dev, -ENOTCONN,
+				     "Failed to get remote endpoint\n");
 
-		fwnode_handle_put(ep);
+	asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
+					      struct v4l2_async_subdev);
 
-		if (IS_ERR(asd)) {
-			ret = PTR_ERR(asd);
-			/* OK if asd already exists */
-			if (ret != -EEXIST)
-				return ret;
-		}
-	}
+	fwnode_handle_put(ep);
+
+	if (IS_ERR(asd))
+		return dev_err_probe(csi->dev, PTR_ERR(asd),
+				     "Failed to add remote subdev to notifier\n");
 
 	csi->notifier.ops = &imx7_csi_notify_ops;
 
-- 
2.39.1

