Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8E63AC87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiK1P1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiK1P1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:27:04 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75624947;
        Mon, 28 Nov 2022 07:25:24 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 6C134100016;
        Mon, 28 Nov 2022 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669649123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP8NU7I43xDY/ZPEn0/gmn7Nbc0npEub8Nu+wM5IK7w=;
        b=hYIrZn61Zm0+zP0YbUM2rRBF5L0sS4xUTIJ9knElrY5WL/+IVCVOdg9btrq2Ob/BLmJ+Ef
        4TK8eBwREDfCNcJ9Le24os7b9E6yw+ye7wmjx2LrCP0I4GcAoVJQAkBrGS2P2M7jszw8YD
        X5j9s0dmDq3hkCBOTROKqaY8XN+RPZhKb9Wy4hH7ouk3je3jcP1BA/RpbTsa450DeZBKRE
        TkeJVM93/s5lMk8BwS9oMM0dNy28J+aIMIIWPczyoM5NYnM4KNgwJ11L5IV88tanQEUpmb
        l+ev8stvAcIn+rELl1d3+6tblqgl1X3BEbWp+kjS79Z5XeznyaYJyEzGJpME5A==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 14/21] staging: media: tegra-video: move MIPI calibration calls from VI to CSI
Date:   Mon, 28 Nov 2022 16:23:29 +0100
Message-Id: <20221128152336.133953-15-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

---

No changes in v2
---
 drivers/staging/media/tegra-video/csi.c | 44 ++++++++++++++++++++
 drivers/staging/media/tegra-video/vi.c  | 54 ++-----------------------
 2 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
index 426e653bd55d..3a614f568a31 100644
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
index 8b6cf50e1eae..2dd3c6c944a2 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -187,49 +187,15 @@ tegra_channel_get_remote_source_subdev(struct tegra_vi_channel *chan)
 
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
@@ -237,18 +203,6 @@ static int tegra_channel_disable_stream(struct tegra_vi_channel *chan)
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

