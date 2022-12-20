Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C24652030
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiLTMIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLTMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:08:06 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE7015FEE;
        Tue, 20 Dec 2022 04:08:05 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m15so6198174ilq.2;
        Tue, 20 Dec 2022 04:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOh/tBjrs1ulp5PJnN7tW7CDvPP1BVgU6PhNYGEiuIo=;
        b=IpPTKb0q/yyAqhs9UVpDUC0mMjdHchLkY7+24Dkm/tgcu3Kg5PHBpgATcoM9gS5VlB
         KRyciTIb2NPBfTwqAMJStizm4zXAPdmkyav6eH6Wh2UnEZhFSQlYKneSM6CzWRYIOmqZ
         vJVl2McQWr50jVGUMw2vkOd/Pyhxdh6PiBkGCzmDYUJFSp6aE0/EkN4TXhn+qeR/yJWM
         6cWLUbctXD1ZSuQ6rEm3UlLDbeTEpM2gZRXjPYhtqwH6mESVhlN57g0yd9DSWVJznKEM
         9CARjZsDNn9UR4uzDqmMRny5t3zbitMmUlLU1gMXvG6wSG9w505w7i5wxw7CMVLPtj77
         kLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOh/tBjrs1ulp5PJnN7tW7CDvPP1BVgU6PhNYGEiuIo=;
        b=YyA9ZmvHhr2pE255pkB2A0/eKSxwrJDfYpCwAaMyf0DTMzXYos7RYO5WZ0UkG3Vv4v
         uUnTEsOPZpmIWm4kvSkDQbSvAc+ser2q+lval/pWDD7NnJbRpkYTq+5pOK1kLJ4Ns/Fo
         UQMlxkKkdE1wXj6qNgaWxPuK/8AG5Hz02bQIodInzSs4enIYXPtr5KATMDsfBM39R8Jt
         LNNk+qsxDnORkL9OpbMpP14+3LoFUAknycqwpziz+JwiezuJeUexjZpGD19Ipx7n6xcz
         cMCe4in6uSb54BfkIlkpjhOcn+YCO6P8ZA8IIZXGHYYOZkcWZjXgOk+MO6mM+eGIICdW
         LWmw==
X-Gm-Message-State: AFqh2kqgNWaDM1L85COi0aLaAXn401PxlgYdgPK8plScAHiC+IV6773b
        O17IJcy/+iMrmCW0oMnOdmqBMsQzg4o=
X-Google-Smtp-Source: AMrXdXsfkm701yAspb9Z3pIDAJtKeswq3VAehoWLNfEQ5e+9H2TyiuhTeMQArkaYG1MT7rTX/WYx0A==
X-Received: by 2002:a05:6e02:128a:b0:308:2a8d:f7da with SMTP id y10-20020a056e02128a00b003082a8df7damr8231197ilq.11.1671538084288;
        Tue, 20 Dec 2022 04:08:04 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:3e4c:2ca1:8128:e7be])
        by smtp.gmail.com with ESMTPSA id z90-20020a0293e3000000b00389d81b2f67sm4586300jah.160.2022.12.20.04.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:08:03 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] media: i2c: imx219: Support four-lane operation
Date:   Tue, 20 Dec 2022 06:07:54 -0600
Message-Id: <20221220120754.2040428-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220120754.2040428-1-aford173@gmail.com>
References: <20221220120754.2040428-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx219 camera is capable of either two-lane or four-lane
operation.  When operating in four-lane, both the pixel rate and
link frequency change. Regardless of the mode, however, both
frequencies remain fixed.

Helper functions are needed to read and set pixel and link frequencies
which also reduces the number of fixed registers in the table of modes.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  Restore check for nr_of_link_frequencies and update commit message
V3:  Keep the helper function doing the link and lane parsing to
     keep th probe function small.
     
V2:  Replace if-else statements with ternary operator
     Fix 4-lane Link Rate.
     Fix checking the link rate so only the link rate for
     the given number of lanes is permitted.

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 7f44d62047b6..b5fa4986470a 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -42,10 +42,16 @@
 /* External clock frequency is 24.0M */
 #define IMX219_XCLK_FREQ		24000000
 
-/* Pixel rate is fixed at 182.4M for all the modes */
+/* Pixel rate is fixed for all the modes */
 #define IMX219_PIXEL_RATE		182400000
+#define IMX219_PIXEL_RATE_4LANE		280800000
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
+#define IMX219_DEFAULT_LINK_FREQ_4LANE	363000000
+
+#define IMX219_REG_CSI_LANE_MODE	0x0114
+#define IMX219_CSI_2_LANE_MODE		0x01
+#define IMX219_CSI_4_LANE_MODE		0x03
 
 /* V_TIMING internal */
 #define IMX219_REG_VTS			0x0160
@@ -299,6 +305,10 @@ static const s64 imx219_link_freq_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ,
 };
 
+static const s64 imx219_link_freq_4lane_menu[] = {
+	IMX219_DEFAULT_LINK_FREQ_4LANE,
+};
+
 static const char * const imx219_test_pattern_menu[] = {
 	"Disabled",
 	"Color Bars",
@@ -474,6 +484,9 @@ struct imx219 {
 
 	/* Streaming on/off */
 	bool streaming;
+
+	/* Two or Four lanes */
+	u8 lanes;
 };
 
 static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
@@ -936,6 +949,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
+static int imx219_configure_lanes(struct imx219 *imx219)
+{
+	return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
+				IMX219_REG_VALUE_08BIT, (imx219->lanes == 2) ?
+				IMX219_CSI_2_LANE_MODE : IMX219_CSI_4_LANE_MODE);
+};
+
 static int imx219_start_streaming(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
@@ -953,6 +973,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		goto err_rpm_put;
 	}
 
+	/* Configure two or four Lane mode */
+	ret = imx219_configure_lanes(imx219);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
+		goto err_rpm_put;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
@@ -1184,6 +1211,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
 	.open = imx219_open,
 };
 
+static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
+{
+	return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
+}
+
 /* Initialize control handlers */
 static int imx219_init_controls(struct imx219 *imx219)
 {
@@ -1205,15 +1237,16 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* By default, PIXEL_RATE is read only */
 	imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					       V4L2_CID_PIXEL_RATE,
-					       IMX219_PIXEL_RATE,
-					       IMX219_PIXEL_RATE, 1,
-					       IMX219_PIXEL_RATE);
+					       imx219_get_pixel_rate(imx219),
+					       imx219_get_pixel_rate(imx219), 1,
+					       imx219_get_pixel_rate(imx219));
 
 	imx219->link_freq =
 		v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
 				       V4L2_CID_LINK_FREQ,
 				       ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
-				       imx219_link_freq_menu);
+				       (imx219->lanes == 2) ? imx219_link_freq_menu :
+				       imx219_link_freq_4lane_menu);
 	if (imx219->link_freq)
 		imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
@@ -1308,7 +1341,7 @@ static void imx219_free_controls(struct imx219 *imx219)
 	mutex_destroy(&imx219->mutex);
 }
 
-static int imx219_check_hwcfg(struct device *dev)
+static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 {
 	struct fwnode_handle *endpoint;
 	struct v4l2_fwnode_endpoint ep_cfg = {
@@ -1328,10 +1361,12 @@ static int imx219_check_hwcfg(struct device *dev)
 	}
 
 	/* Check the number of MIPI CSI2 data lanes */
-	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
-		dev_err(dev, "only 2 data lanes are currently supported\n");
+	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2 &&
+	    ep_cfg.bus.mipi_csi2.num_data_lanes != 4) {
+		dev_err(dev, "only 2 or 4 data lanes are currently supported\n");
 		goto error_out;
 	}
+	imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
 
 	/* Check the link frequency set in device tree */
 	if (!ep_cfg.nr_of_link_frequencies) {
@@ -1340,7 +1375,8 @@ static int imx219_check_hwcfg(struct device *dev)
 	}
 
 	if (ep_cfg.nr_of_link_frequencies != 1 ||
-	    ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
+	   (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
+	    IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE))) {
 		dev_err(dev, "Link frequency not supported: %lld\n",
 			ep_cfg.link_frequencies[0]);
 		goto error_out;
@@ -1368,7 +1404,7 @@ static int imx219_probe(struct i2c_client *client)
 	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
 
 	/* Check the hardware configuration in device tree */
-	if (imx219_check_hwcfg(dev))
+	if (imx219_check_hwcfg(dev, imx219))
 		return -EINVAL;
 
 	/* Get system clock (xclk) */
-- 
2.34.1

