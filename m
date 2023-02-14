Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D32696A24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBNQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBNQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:45:46 -0500
X-Greylist: delayed 656 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 08:45:11 PST
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194D6618C;
        Tue, 14 Feb 2023 08:45:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA599BFAED;
        Tue, 14 Feb 2023 17:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676392435; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=uXvqQLB2ducDVDKLFpQL7JrjrtTEw9AsgFdryWzrcek=;
        b=fk5VondZuRrLk6uEQYDteXpBIZRUVf8yg10Bhg5oq/n59tqyhVLNJUjcZqGt72Gtx49m0L
        KNsJrwQr5G1eufZKq2nXjOI3zyhrSSQwyJi0MvAkaHngHShmrtsyAnwNWoWHcADCBZFue6
        whuQGLkBi0rcVp1jymSkQGjQG6/onhtkP+fwiaX3gUdOxkMPk44ItQIbmkhSJeXUxZL32t
        uFPypeSR3ALdiR1wWM4C42qUnZ3lE7eC4TgOSSfq/UMzs78yQ/qOpvJjAouqo83jUwK+C5
        g2EtAlYlkWc586L6f13jDRuE1UaAe0CBK8owFi3hIq67gijs1MqsiJb/UrHA5g==
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
Subject: [PATCH] media: imx: imx7-media-csi: Fix error handling in imx7_csi_async_register()
Date:   Tue, 14 Feb 2023 17:31:56 +0100
Message-Id: <20230214163200.1448837-1-frieder@fris.de>
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

If fwnode_graph_get_endpoint_by_id() fails and returns NULL, there is
no point in going on. Print an error message a abort instead.

Also we don't need to check for an existing asd. Any failure of
v4l2_async_nf_add_fwnode_remote() should abort the probe.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/media/platform/nxp/imx7-media-csi.c | 22 +++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 886374d3a6ff..a7db310624e2 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -2191,18 +2191,20 @@ static int imx7_csi_async_register(struct imx7_csi *csi)
 
 	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi->dev), 0, 0,
 					     FWNODE_GRAPH_ENDPOINT_NEXT);
-	if (ep) {
-		asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
-						      struct v4l2_async_subdev);
+	if (!ep) {
+		dev_err(csi->dev, "Failed to get remote endpoint\n");
+		return -ENOTCONN;
+	}
 
-		fwnode_handle_put(ep);
+	asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
+					      struct v4l2_async_subdev);
 
-		if (IS_ERR(asd)) {
-			ret = PTR_ERR(asd);
-			/* OK if asd already exists */
-			if (ret != -EEXIST)
-				return ret;
-		}
+	fwnode_handle_put(ep);
+
+	if (IS_ERR(asd)) {
+		ret = PTR_ERR(asd);
+		dev_err(csi->dev, "Failed to add remote subdev to notifier: %d\n", ret);
+		return ret;
 	}
 
 	csi->notifier.ops = &imx7_csi_notify_ops;
-- 
2.39.1

