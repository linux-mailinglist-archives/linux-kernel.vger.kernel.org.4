Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCD6DAE0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbjDGNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjDGNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:41:51 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB5C162;
        Fri,  7 Apr 2023 06:40:30 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 6DA761BF20C;
        Fri,  7 Apr 2023 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680874827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmzw2dVpF8tV+JLetAkvRrrQ0vYFZoq1gNJSvFqclr4=;
        b=RYqyjRD49OGUrYIMBF42OnSzUlVlBV/KyaygB4IZoV14jhpFPLJCtkZuYuY+r0hIf+dszT
        B7J/FV0ITgd+nAe/SQt39hDNW4QkjRR38QV5IH+G4rXuB8elhjR4sdqJNKP/gF88g9NtQ5
        aXJMMoB70WZpVbFnC640u4ahzP+7qNcSkH0UfHvo+DQCel7ocaB6OvA+JSGb+06mVYjT9t
        xfBGn79n+0FNDxAnwRmUHy/yOgBPyNgVWl8u6a2xEaUVJKHmayBAlF++ha2oXMqjZY/tmK
        1vowXLeGITslRUgig6f2lDSMboQteKauoh4kwgFTc5Cp7rBBF9jtak2G0bZNbQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 14/20] staging: media: tegra-video: move MIPI calibration calls from VI to CSI
Date:   Fri,  7 Apr 2023 15:38:46 +0200
Message-Id: <20230407133852.2850145-15-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
References: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI module does not handle all the MIPI lane calibration procedure,
leaving a small part of it to the VI module. In doing this,
tegra_channel_enable_stream() (vi.c) manipulates the private data of the
upstream subdev casting it to struct 'tegra_csi_channel', which will be
wrong after introducing a VIP (parallel video input) channel.

This prevents adding support for the VIP module.  It also breaks the
logical isolation between modules.

Since the lane calibration requirement does not exist in the parallel input
module, moving the calibration function to a per-module op is not
optimal. Instead move the calibration procedure in the CSI module, together
with the rest of the calibration procedures. After this change,
tegra_channel_enable_stream() just calls v4l2_subdev_call() to ask for a
stream start/stop to the CSI module, which in turn knows all the
CSI-specific details to implement it.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/csi.c | 44 ++++++++++++++++++++
 drivers/staging/media/tegra-video/vi.c  | 54 ++-----------------------
 2 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
index 9a03d5ccdf3c..b93fc879ef3a 100644
--- a/drivers/staging/media/tegra-video/csi.c
+++ b/drivers/staging/media/tegra-video/csi.c
@@ -328,12 +328,42 @@ static int tegra_csi_enable_stream(struct v4l2_subdev *subdev)
 	}
 
 	csi_chan->pg_mode = chan->pg_mode;
+
+	/*
+	 * Tegra CSI receiver can detect the first LP to HS transition.
+	 * So, start the CSI stream-on prior to sensor stream-on and
+	 * vice-versa for stream-off.
+	 */
 	ret = csi->ops->csi_start_streaming(csi_chan);
 	if (ret < 0)
 		goto finish_calibration;
 
+	if (csi_chan->mipi) {
+		struct v4l2_subdev *src_subdev;
+		/*
+		 * TRM has incorrectly documented to wait for done status from
+		 * calibration logic after CSI interface power on.
+		 * As per the design, calibration results are latched and applied
+		 * to the pads only when the link is in LP11 state which will happen
+		 * during the sensor stream-on.
+		 * CSI subdev stream-on triggers start of MIPI pads calibration.
+		 * Wait for calibration to finish here after sensor subdev stream-on.
+		 */
+		src_subdev = tegra_channel_get_remote_source_subdev(chan);
+		ret = v4l2_subdev_call(src_subdev, video, s_stream, true);
+		err = tegra_mipi_finish_calibration(csi_chan->mipi);
+
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			goto disable_csi_stream;
+
+		if (err < 0)
+			dev_warn(csi->dev, "MIPI calibration failed: %d\n", err);
+	}
+
 	return 0;
 
+disable_csi_stream:
+	csi->ops->csi_stop_streaming(csi_chan);
 finish_calibration:
 	if (csi_chan->mipi)
 		tegra_mipi_finish_calibration(csi_chan->mipi);
@@ -352,10 +382,24 @@ static int tegra_csi_enable_stream(struct v4l2_subdev *subdev)
 
 static int tegra_csi_disable_stream(struct v4l2_subdev *subdev)
 {
+	struct tegra_vi_channel *chan = v4l2_get_subdev_hostdata(subdev);
 	struct tegra_csi_channel *csi_chan = to_csi_chan(subdev);
 	struct tegra_csi *csi = csi_chan->csi;
 	int err;
 
+	/*
+	 * Stream-off subdevices in reverse order to stream-on.
+	 * Remote source subdev in TPG mode is same as CSI subdev.
+	 */
+	if (csi_chan->mipi) {
+		struct v4l2_subdev *src_subdev;
+
+		src_subdev = tegra_channel_get_remote_source_subdev(chan);
+		err = v4l2_subdev_call(src_subdev, video, s_stream, false);
+		if (err < 0 && err != -ENOIOCTLCMD)
+			dev_err_probe(csi->dev, err, "source subdev stream off failed\n");
+	}
+
 	csi->ops->csi_stop_streaming(csi_chan);
 
 	if (csi_chan->mipi) {
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index b88532d8d2c9..c76c2a404889 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -197,49 +197,15 @@ tegra_channel_get_remote_source_subdev(struct tegra_vi_channel *chan)
 
 static int tegra_channel_enable_stream(struct tegra_vi_channel *chan)
 {
-	struct v4l2_subdev *csi_subdev, *src_subdev;
-	struct tegra_csi_channel *csi_chan;
-	int ret, err;
+	struct v4l2_subdev *subdev;
+	int ret;
 
-	/*
-	 * Tegra CSI receiver can detect the first LP to HS transition.
-	 * So, start the CSI stream-on prior to sensor stream-on and
-	 * vice-versa for stream-off.
-	 */
-	csi_subdev = tegra_channel_get_remote_csi_subdev(chan);
-	ret = v4l2_subdev_call(csi_subdev, video, s_stream, true);
+	subdev = tegra_channel_get_remote_csi_subdev(chan);
+	ret = v4l2_subdev_call(subdev, video, s_stream, true);
 	if (ret < 0 && ret != -ENOIOCTLCMD)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_VIDEO_TEGRA_TPG))
-		return 0;
-
-	csi_chan = v4l2_get_subdevdata(csi_subdev);
-	/*
-	 * TRM has incorrectly documented to wait for done status from
-	 * calibration logic after CSI interface power on.
-	 * As per the design, calibration results are latched and applied
-	 * to the pads only when the link is in LP11 state which will happen
-	 * during the sensor stream-on.
-	 * CSI subdev stream-on triggers start of MIPI pads calibration.
-	 * Wait for calibration to finish here after sensor subdev stream-on.
-	 */
-	src_subdev = tegra_channel_get_remote_source_subdev(chan);
-	ret = v4l2_subdev_call(src_subdev, video, s_stream, true);
-	err = tegra_mipi_finish_calibration(csi_chan->mipi);
-
-	if (ret < 0 && ret != -ENOIOCTLCMD)
-		goto err_disable_csi_stream;
-
-	if (err < 0)
-		dev_warn(csi_chan->csi->dev,
-			 "MIPI calibration failed: %d\n", err);
-
 	return 0;
-
-err_disable_csi_stream:
-	v4l2_subdev_call(csi_subdev, video, s_stream, false);
-	return ret;
 }
 
 static int tegra_channel_disable_stream(struct tegra_vi_channel *chan)
@@ -247,18 +213,6 @@ static int tegra_channel_disable_stream(struct tegra_vi_channel *chan)
 	struct v4l2_subdev *subdev;
 	int ret;
 
-	/*
-	 * Stream-off subdevices in reverse order to stream-on.
-	 * Remote source subdev in TPG mode is same as CSI subdev.
-	 */
-	subdev = tegra_channel_get_remote_source_subdev(chan);
-	ret = v4l2_subdev_call(subdev, video, s_stream, false);
-	if (ret < 0 && ret != -ENOIOCTLCMD)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_VIDEO_TEGRA_TPG))
-		return 0;
-
 	subdev = tegra_channel_get_remote_csi_subdev(chan);
 	ret = v4l2_subdev_call(subdev, video, s_stream, false);
 	if (ret < 0 && ret != -ENOIOCTLCMD)
-- 
2.34.1

