Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6895B3943
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiIINl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIINkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813B9C52B;
        Fri,  9 Sep 2022 06:40:34 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 405B21C0002;
        Fri,  9 Sep 2022 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662730833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZerUL4Gdisb2y9R2p//xDrZ6J/om1/Cqv1NWlhDE1r0=;
        b=SStNj42S1NJs6+iKh8x8tOPS+CgWTGDLxl2w3+iLzSnti4UpfHViowxfZ2C+dP8FbPuJId
        xRgWYeAjZ3QD89dNItbMtMg9VhwlTTLyrzdfXoM2F6QZgDCadtZXK83Po/iLeu1D4fmZ9O
        MfyKHZYA9A71qvgx/5EIIEvWMFhEKn+migqRzSFljVMTx8bPtPfSn8chwEpBenx9Aizfs0
        axkMmCz/sZiojdgqxEXA4wBCKQa4hljMGWRuEOJ/uShcKrhbZQx5VoUBs09qvljoE6Nvmg
        sw2yAK9sS73dec9J4sZ6bhROFGA/JE6eWww1+1kvr+catp8vgnePO0hw2G6ZHA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 3/4] media: sun6i-mipi-csi2: Register async subdev with no sensor attached
Date:   Fri,  9 Sep 2022 15:39:53 +0200
Message-Id: <20220909133954.97010-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
References: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the device to probe and register its async subdev without
a sensor attached.

The rationale is that the parent driver might otherwise wait for the
subdev to be registered when it should be available (from the fwnode
graph endpoint perspective). This is generally not problematic when
the MIPI CSI-2 bridge is the only device attached to the parent, but
in the case of a CSI controller that can feed from both MIPI CSI-2
and parallel, it would prevent using the parallel sensor due to the
parent waiting for the MIPI CSI-2 subdev to register.

Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 controller")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c     | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index 340380a5f66f..484ac5f054d5 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -498,6 +498,7 @@ static int sun6i_mipi_csi2_bridge_setup(struct sun6i_mipi_csi2_device *csi2_dev)
 	struct v4l2_async_notifier *notifier = &bridge->notifier;
 	struct media_pad *pads = bridge->pads;
 	struct device *dev = csi2_dev->dev;
+	bool notifier_registered = false;
 	int ret;
 
 	mutex_init(&bridge->lock);
@@ -535,12 +536,17 @@ static int sun6i_mipi_csi2_bridge_setup(struct sun6i_mipi_csi2_device *csi2_dev)
 	notifier->ops = &sun6i_mipi_csi2_notifier_ops;
 
 	ret = sun6i_mipi_csi2_bridge_source_setup(csi2_dev);
-	if (ret)
+	if (ret && ret != -ENODEV)
 		goto error_v4l2_notifier_cleanup;
 
-	ret = v4l2_async_subdev_nf_register(subdev, notifier);
-	if (ret < 0)
-		goto error_v4l2_notifier_cleanup;
+	/* Only register the notifier when a sensor is connected. */
+	if (ret != -ENODEV) {
+		ret = v4l2_async_subdev_nf_register(subdev, notifier);
+		if (ret < 0)
+			goto error_v4l2_notifier_cleanup;
+
+		notifier_registered = true;
+	}
 
 	/* V4L2 Subdev */
 
@@ -551,7 +557,8 @@ static int sun6i_mipi_csi2_bridge_setup(struct sun6i_mipi_csi2_device *csi2_dev)
 	return 0;
 
 error_v4l2_notifier_unregister:
-	v4l2_async_nf_unregister(notifier);
+	if (notifier_registered)
+		v4l2_async_nf_unregister(notifier);
 
 error_v4l2_notifier_cleanup:
 	v4l2_async_nf_cleanup(notifier);
-- 
2.37.3

