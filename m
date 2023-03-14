Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F76B9235
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjCNLzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCNLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:55:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082348A3AE;
        Tue, 14 Mar 2023 04:55:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtP8m105671;
        Tue, 14 Mar 2023 06:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678794925;
        bh=IFJsUQk232s7e8N9uoqezRx3OBmYY8+n+kXrVuwBMoI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iL8UVw+V8s4vUm8sj2/h7wrug3M7mhZRcR1T5acfpLO9/ylMq4AjTuq4+4VH2kEdk
         +d4b2kOa92/XWqIU+RSZ9Cs+tGyKasqlvP97igKH2A5r6lQhUvE7+MJIqru6j7PBNh
         GxKp/ysJzsrvMD/DE2/Cr29aQQOy7ruRNbbwwfpQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBtPp1112494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:55:25 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:55:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:55:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtNok111799;
        Tue, 14 Mar 2023 06:55:24 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v7 03/13] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
Date:   Tue, 14 Mar 2023 17:25:06 +0530
Message-ID: <20230314115516.667-4-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314115516.667-1-vaishnav.a@ti.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The format is needed to calculate the link speed for the external DPHY
configuration. It is not right to query the format from the source
subdev. Add get_fmt and set_fmt pad operations so that the format can be
configured and correct bpp be selected.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v7:
- Add Laurent's R-by.

Changes in v6:
- Move the lock around the dereference for framefmt in
  csi2rx_{get,set}_fmt() instead of when we get the pointer.
- Do not return an error when an unsupported format is set. Instead
  adjust the code to the first format in the list.
- Not adding Laurent's R-by since I am making changes in
  csi2rx_set_fmt() that he didn't explicitly recommend.

Changes in v5:
- Use YUV 1X16 formats instead of 2X8.
- New in v5.

 drivers/media/platform/cadence/cdns-csi2rx.c | 131 +++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 2547903f2e8e..ae3ebdb3890d 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -54,6 +54,11 @@ enum csi2rx_pads {
 	CSI2RX_PAD_MAX,
 };
 
+struct csi2rx_fmt {
+	u32				code;
+	u8				bpp;
+};
+
 struct csi2rx_priv {
 	struct device			*dev;
 	unsigned int			count;
@@ -79,12 +84,43 @@ struct csi2rx_priv {
 	struct v4l2_subdev		subdev;
 	struct v4l2_async_notifier	notifier;
 	struct media_pad		pads[CSI2RX_PAD_MAX];
+	struct v4l2_mbus_framefmt	fmt;
 
 	/* Remote source */
 	struct v4l2_subdev		*source_subdev;
 	int				source_pad;
 };
 
+static const struct csi2rx_fmt formats[] = {
+	{
+		.code	= MEDIA_BUS_FMT_YUYV8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_UYVY8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_YVYU8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.bpp	= 16,
+	},
+};
+
+static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++)
+		if (formats[i].code == code)
+			return &formats[i];
+
+	return NULL;
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -236,12 +272,103 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	return ret;
 }
 
+static struct v4l2_mbus_framefmt *
+csi2rx_get_pad_format(struct csi2rx_priv *csi2rx,
+		      struct v4l2_subdev_state *state,
+		      unsigned int pad, u32 which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_format(&csi2rx->subdev, state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &csi2rx->fmt;
+	default:
+		return NULL;
+	}
+}
+
+static int csi2rx_get_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *format)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct v4l2_mbus_framefmt *framefmt;
+
+	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
+					 format->which);
+	if (!framefmt)
+		return -EINVAL;
+
+	mutex_lock(&csi2rx->lock);
+	format->format = *framefmt;
+	mutex_unlock(&csi2rx->lock);
+
+	return 0;
+}
+
+static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *format)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct v4l2_mbus_framefmt *framefmt;
+
+	/* No transcoding, source and sink formats must match. */
+	if (format->pad != CSI2RX_PAD_SINK)
+		return csi2rx_get_fmt(subdev, state, format);
+
+	if (!csi2rx_get_fmt_by_code(format->format.code))
+		format->format.code = formats[0].code;
+
+	format->format.field = V4L2_FIELD_NONE;
+
+	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
+					 format->which);
+	if (!framefmt)
+		return -EINVAL;
+
+	mutex_lock(&csi2rx->lock);
+	*framefmt = format->format;
+	mutex_unlock(&csi2rx->lock);
+
+	return 0;
+}
+
+static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
+			   struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_format format = {
+		.which = state ? V4L2_SUBDEV_FORMAT_TRY
+			: V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = CSI2RX_PAD_SINK,
+		.format = {
+			.width = 640,
+			.height = 480,
+			.code = MEDIA_BUS_FMT_UYVY8_1X16,
+			.field = V4L2_FIELD_NONE,
+			.colorspace = V4L2_COLORSPACE_SRGB,
+			.ycbcr_enc = V4L2_YCBCR_ENC_601,
+			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+			.xfer_func = V4L2_XFER_FUNC_SRGB,
+		},
+	};
+
+	return csi2rx_set_fmt(subdev, state, &format);
+}
+
+static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
+	.get_fmt	= csi2rx_get_fmt,
+	.set_fmt	= csi2rx_set_fmt,
+	.init_cfg	= csi2rx_init_cfg,
+};
+
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
 	.s_stream	= csi2rx_s_stream,
 };
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.video		= &csi2rx_video_ops,
+	.pad		= &csi2rx_pad_ops,
 };
 
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
@@ -457,6 +584,10 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup;
 
+	ret = csi2rx_init_cfg(&csi2rx->subdev, NULL);
+	if (ret)
+		goto err_cleanup;
+
 	ret = v4l2_async_register_subdev(&csi2rx->subdev);
 	if (ret < 0)
 		goto err_cleanup;
-- 
2.17.1

