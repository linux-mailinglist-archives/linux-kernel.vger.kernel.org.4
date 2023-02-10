Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6F69285C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjBJUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjBJUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:33:46 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125643A0A2;
        Fri, 10 Feb 2023 12:33:44 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5F249D038E;
        Fri, 10 Feb 2023 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676061222; bh=9GrgYva7rweU1rSKGS/0mx/cp2gBOrU3oT+ui7vYdFI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=OGsIumJoz+T537lrL5Dp0yJdkTmRjv6e4oT5Bmyu+tH4xg2V88wsTwQN7pDcWF7Tt
         1JksEvz6qyu+H8ZZfDhaCIYrgw79XRy5P1xz+06X5f1r9FqgJ1aCigQ5WCYsvUNv1+
         HpEECLVHpkPbxcXOokegDvX8VQtgTtGMxgGFv/II=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 10 Feb 2023 21:33:18 +0100
Subject: [PATCH 2/2] media: i2c: ov5670: Support single-lane operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230210-ov5670-single-lane-v1-2-71835d39c1ce@z3ntu.xyz>
References: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
In-Reply-To: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8626; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=9GrgYva7rweU1rSKGS/0mx/cp2gBOrU3oT+ui7vYdFI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj5qokc+R9VFqU7aGHkRUBVSl1aMgCUJATRHudu
 JXAGMoTu7aJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+aqJAAKCRBy2EO4nU3X
 VvjREACc0rHAM5yuY6mLXM6MTVIpq+64IqdgRsEvTRj4HpGV3rY/1HvT0XXQRGnzh9tRwRqhcsI
 ergbQ9JSvmByNDc9OpPbgjLngGxI7XjI0pSv7ALK+p2/ojkuwPkgKAzPFj25vFTn5rtkKXiuU+k
 vBpVXvaGbdOhOxVrE/msCsTgun0avERbXIMqhYkdfS57W/8oq/7u7Mg5SB+zSGNavFKyPeUAnIU
 CcQf/YDxwoNTSm5xs4a2VfKCwITdvVL91wXcEwn+DvnYGe/pK6sZ8aQysKeG0bmZEhzc4rIVKys
 wKKho+sMjuGXqFUbVm2E7n/bbzLbkVyds9zYLhM8ahfVqo/5Uh/fbexKDUCfev9RyjXmDghkjWz
 8KX19AHlT5pLASN2pJKhAj+U6wOX0AwC8W14fjY73nPABJudm5uRMX4hi93hxEhJ0aY8+wpkYaB
 tPjacfk/IZfe599kSR780wcYPIsl8SESPVA7iMYE/8HMxa+s8qdZHy5mvx8CBWpTksuCo8gsRiQ
 xMNLw61Z5YRBCyaIAiZgM9KwKvdzrz8GWlelNPMQg8x9NAfgn6YnU9tTqS8P3jJkNIOoq+qbTe1
 y7Lea9fJiBEfj24IgR+v+inXerAvntU5Lw6DVrnDa6tdfjCcmB8aCoJFq8h4MViraH288EOXYWv
 3UDzRf5hnXExLPQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver always configures the sensor for dual-lane MIPI
output, but it also supports single-lane output. Add support for that by
checking the data-lanes fwnode property how many lanes are used and
configure the necessary registers based on that.

To achieve this we move setting register 0x3018 out of the general reg
sequence so we set it to the correct value. The pixel_rate value also
needs to be adjusted.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov5670.c | 85 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
index 189920571df2..4ca082455c46 100644
--- a/drivers/media/i2c/ov5670.c
+++ b/drivers/media/i2c/ov5670.c
@@ -29,6 +29,12 @@
 #define OV5670_REG_SOFTWARE_RST		0x0103
 #define OV5670_SOFTWARE_RST		0x01
 
+#define OV5670_MIPI_SC_CTRL0_REG		0x3018
+#define OV5670_MIPI_SC_CTRL0_LANES(v)		((((v) - 1) << 5) & \
+						 GENMASK(7, 5))
+#define OV5670_MIPI_SC_CTRL0_MIPI_EN		BIT(4)
+#define OV5670_MIPI_SC_CTRL0_RESERVED		BIT(1)
+
 /* vertical-timings from sensor */
 #define OV5670_REG_VTS			0x380e
 #define OV5670_VTS_30FPS		0x0808 /* default for 30 fps */
@@ -92,7 +98,6 @@ struct ov5670_reg_list {
 };
 
 struct ov5670_link_freq_config {
-	u32 pixel_rate;
 	const struct ov5670_reg_list reg_list;
 };
 
@@ -163,7 +168,6 @@ static const struct ov5670_reg mode_2592x1944_regs[] = {
 	{0x3005, 0xf0},
 	{0x3007, 0x00},
 	{0x3015, 0x0f},
-	{0x3018, 0x32},
 	{0x301a, 0xf0},
 	{0x301b, 0xf0},
 	{0x301c, 0xf0},
@@ -429,7 +433,6 @@ static const struct ov5670_reg mode_1296x972_regs[] = {
 	{0x3005, 0xf0},
 	{0x3007, 0x00},
 	{0x3015, 0x0f},
-	{0x3018, 0x32},
 	{0x301a, 0xf0},
 	{0x301b, 0xf0},
 	{0x301c, 0xf0},
@@ -695,7 +698,6 @@ static const struct ov5670_reg mode_648x486_regs[] = {
 	{0x3005, 0xf0},
 	{0x3007, 0x00},
 	{0x3015, 0x0f},
-	{0x3018, 0x32},
 	{0x301a, 0xf0},
 	{0x301b, 0xf0},
 	{0x301c, 0xf0},
@@ -961,7 +963,6 @@ static const struct ov5670_reg mode_2560x1440_regs[] = {
 	{0x3005, 0xf0},
 	{0x3007, 0x00},
 	{0x3015, 0x0f},
-	{0x3018, 0x32},
 	{0x301a, 0xf0},
 	{0x301b, 0xf0},
 	{0x301c, 0xf0},
@@ -1226,7 +1227,6 @@ static const struct ov5670_reg mode_1280x720_regs[] = {
 	{0x3005, 0xf0},
 	{0x3007, 0x00},
 	{0x3015, 0x0f},
-	{0x3018, 0x32},
 	{0x301a, 0xf0},
 	{0x301b, 0xf0},
 	{0x301c, 0xf0},
@@ -1492,7 +1492,6 @@ static const struct ov5670_reg mode_640x360_regs[] = {
 	{0x3005, 0xf0},
 	{0x3007, 0x00},
 	{0x3015, 0x0f},
-	{0x3018, 0x32},
 	{0x301a, 0xf0},
 	{0x301b, 0xf0},
 	{0x301c, 0xf0},
@@ -1762,8 +1761,6 @@ static const char * const ov5670_test_pattern_menu[] = {
 #define OV5670_LINK_FREQ_422MHZ_INDEX	0
 static const struct ov5670_link_freq_config link_freq_configs[] = {
 	{
-		/* pixel_rate = link_freq * 2 * nr_of_lanes / bits_per_sample */
-		.pixel_rate = (OV5670_LINK_FREQ_422MHZ * 2 * 2) / 10,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mipi_data_rate_840mbps),
 			.regs = mipi_data_rate_840mbps,
@@ -1859,6 +1856,7 @@ static const struct ov5670_mode supported_modes[] = {
 struct ov5670 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
+	struct v4l2_fwnode_endpoint endpoint;
 
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* V4L2 Controls */
@@ -2101,9 +2099,13 @@ static const struct v4l2_ctrl_ops ov5670_ctrl_ops = {
 /* Initialize control handlers */
 static int ov5670_init_controls(struct ov5670 *ov5670)
 {
+	struct v4l2_mbus_config_mipi_csi2 *bus_mipi_csi2 =
+		&ov5670->endpoint.bus.mipi_csi2;
 	struct i2c_client *client = v4l2_get_subdevdata(&ov5670->sd);
 	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
+	unsigned int lanes_count;
+	s64 mipi_pixel_rate;
 	s64 vblank_max;
 	s64 vblank_def;
 	s64 vblank_min;
@@ -2124,12 +2126,15 @@ static int ov5670_init_controls(struct ov5670 *ov5670)
 		ov5670->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/* By default, V4L2_CID_PIXEL_RATE is read only */
+	lanes_count = bus_mipi_csi2->num_data_lanes;
+	mipi_pixel_rate = OV5670_LINK_FREQ_422MHZ * 2 * lanes_count / 10;
+
 	ov5670->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &ov5670_ctrl_ops,
 					       V4L2_CID_PIXEL_RATE,
-					       link_freq_configs[0].pixel_rate,
-					       link_freq_configs[0].pixel_rate,
+					       mipi_pixel_rate,
+					       mipi_pixel_rate,
 					       1,
-					       link_freq_configs[0].pixel_rate);
+					       mipi_pixel_rate);
 
 	vblank_max = OV5670_VTS_MAX - ov5670->cur_mode->height;
 	vblank_def = ov5670->cur_mode->vts_def - ov5670->cur_mode->height;
@@ -2288,8 +2293,13 @@ static int ov5670_set_pad_format(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_format *fmt)
 {
 	struct ov5670 *ov5670 = to_ov5670(sd);
+	struct v4l2_mbus_config_mipi_csi2 *bus_mipi_csi2 =
+		&ov5670->endpoint.bus.mipi_csi2;
 	const struct ov5670_mode *mode;
+	unsigned int lanes_count;
+	s64 mipi_pixel_rate;
 	s32 vblank_def;
+	s64 link_freq;
 	s32 h_blank;
 
 	mutex_lock(&ov5670->mutex);
@@ -2306,9 +2316,14 @@ static int ov5670_set_pad_format(struct v4l2_subdev *sd,
 	} else {
 		ov5670->cur_mode = mode;
 		__v4l2_ctrl_s_ctrl(ov5670->link_freq, mode->link_freq_index);
+
+		lanes_count = bus_mipi_csi2->num_data_lanes;
+		link_freq = link_freq_menu_items[mode->link_freq_index];
+		/* pixel_rate = link_freq * 2 * nr_of_lanes / bits_per_sample */
+		mipi_pixel_rate = link_freq * 2 * lanes_count / 10;
 		__v4l2_ctrl_s_ctrl_int64(
 			ov5670->pixel_rate,
-			link_freq_configs[mode->link_freq_index].pixel_rate);
+			mipi_pixel_rate);
 		/* Update limits and set FPS to default */
 		vblank_def = ov5670->cur_mode->vts_def -
 			     ov5670->cur_mode->height;
@@ -2361,6 +2376,19 @@ static int ov5670_identify_module(struct ov5670 *ov5670)
 	return 0;
 }
 
+static int ov5670_mipi_configure(struct ov5670 *ov5670)
+{
+	struct v4l2_mbus_config_mipi_csi2 *bus_mipi_csi2 =
+		&ov5670->endpoint.bus.mipi_csi2;
+	unsigned int lanes_count = bus_mipi_csi2->num_data_lanes;
+
+	return ov5670_write_reg(ov5670, OV5670_MIPI_SC_CTRL0_REG,
+				OV5670_REG_VALUE_08BIT,
+				OV5670_MIPI_SC_CTRL0_LANES(lanes_count) |
+				OV5670_MIPI_SC_CTRL0_MIPI_EN |
+				OV5670_MIPI_SC_CTRL0_RESERVED);
+}
+
 /* Prepare streaming by writing default values and customized values */
 static int ov5670_start_streaming(struct ov5670 *ov5670)
 {
@@ -2399,6 +2427,12 @@ static int ov5670_start_streaming(struct ov5670 *ov5670)
 		return ret;
 	}
 
+	ret = ov5670_mipi_configure(ov5670);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to configure MIPI\n", __func__);
+		return ret;
+	}
+
 	ret = __v4l2_ctrl_handler_setup(ov5670->sd.ctrl_handler);
 	if (ret)
 		return ret;
@@ -2647,6 +2681,7 @@ static int ov5670_gpio_probe(struct ov5670 *ov5670)
 
 static int ov5670_probe(struct i2c_client *client)
 {
+	struct fwnode_handle *handle;
 	struct ov5670 *ov5670;
 	u32 input_clk = 0;
 	bool full_power;
@@ -2683,11 +2718,26 @@ static int ov5670_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(&client->dev, ret, "GPIO probe failed\n");
 
+	/* Graph Endpoint */
+	handle = fwnode_graph_get_next_endpoint(dev_fwnode(&client->dev), NULL);
+	if (!handle)
+		return dev_err_probe(&client->dev, -ENXIO, "Endpoint for node get failed\n");
+
+	ov5670->endpoint.bus_type = V4L2_MBUS_CSI2_DPHY;
+	ov5670->endpoint.bus.mipi_csi2.num_data_lanes = 2;
+
+	ret = v4l2_fwnode_endpoint_alloc_parse(handle, &ov5670->endpoint);
+	fwnode_handle_put(handle);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Endpoint parse failed\n");
+
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
 		ret = ov5670_runtime_resume(&client->dev);
-		if (ret)
-			return dev_err_probe(&client->dev, ret, "Power up failed\n");
+		if (ret) {
+			dev_err_probe(&client->dev, ret, "Power up failed\n");
+			goto error_endpoint;
+		}
 
 		/* Check module identity */
 		ret = ov5670_identify_module(ov5670);
@@ -2754,6 +2804,9 @@ static int ov5670_probe(struct i2c_client *client)
 	if (full_power)
 		ov5670_runtime_suspend(&client->dev);
 
+error_endpoint:
+	v4l2_fwnode_endpoint_free(&ov5670->endpoint);
+
 	return ret;
 }
 
@@ -2769,6 +2822,8 @@ static void ov5670_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	ov5670_runtime_suspend(&client->dev);
+
+	v4l2_fwnode_endpoint_free(&ov5670->endpoint);
 }
 
 static const struct dev_pm_ops ov5670_pm_ops = {

-- 
2.39.1

