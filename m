Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BB6AB663
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCFGhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:37:13 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F3D515;
        Sun,  5 Mar 2023 22:37:12 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.231]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MDiGW-1pnxup1YiM-00HA0v; Mon, 06 Mar 2023 07:36:58 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Date:   Mon,  6 Mar 2023 07:36:49 +0100
Message-Id: <20230306063649.7387-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U5q3Uzpu7O0mLu2MHa+N3aU6TzuolB/G+0u48wmiI71QRmt2rVf
 FczmGewXuqOKGed/nKo1KZ0J6qv5fd+KkgfrzwUo91Vgh9Kf5PHIc9LsN+w2aXa7O2rffBz
 JgrVqoqiicTp5h93slLp1cWuS4WklL4Cyk3s+S3jJG4EauW8phOjVQGT3Oqj8nXiunH+yX8
 rjWvYEsfMixgdU0ulIbgg==
UI-OutboundReport: notjunk:1;M01:P0:HAgWnUUvlSQ=;rNGwRX+DE7mdzFWkYDWnNzmB04t
 DMCyQorcQaqeXoHS+pUB0eU8cCI443lUMQe8PXHqFCyigfH2gAXnXkwJgQjkkkoD8fp0IZpKl
 7bYd7WIox/bTR2j1VQBqkWmslysUTQEVjptJZzs6zwC33QcI4T9zP45dp8p+A5/vwl2ljRaTM
 1LEW8Cf8nutrikxEhwkjRYG1jpTUJMY8y2/c4qHYprDEKbi/VBPB7USLZYtnwE4CvJxwvVGUc
 kfewNPIaQCOlUj6oCEsqHpSm1XhxM2tmWp/I7Mbc+vp4237j9r35GtLnirCiozm6/IA0GNj91
 ZbuBuUhsFPCuExSerxjA0yjPXM3xAPC65RVopEoX6Ck07lv8IITBlGeyvEjGQnNJmhSpxOqIJ
 Atz66QBuKNs4jwVi/23PUKY4ox0CPqmVq8dsooOBnFatozwTVEKM7lM/HB5IFq6z8FmjJpmif
 vEq/BTlpavkAm8T1U4vV2tV+dumB7JCGipxZmtlSeqqIntLKw+8SQnPTxrEO3VgfflC3yho/k
 /+VXIsoysjkySoevlWL0Rndds2jSCjZVAZBMmcEWNFI4AjsFh1tdeoEMSTh9hcrZG7ITR0+DH
 V9J++LJKsa3TvAfbQH0PDshm6VnXMXn1LbcUZS2JsDFkJu7Yv0rsbEhno0TayQ6ok1iO02W+X
 3Oo/FabfSTXxx6zROhIrPdmXiBAhNYFGjvupZRzH5Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aishwarya Kothari <aishwarya.kothari@toradex.com>

Implement the introduced get_mbus_config operation to report the
config of the MIPI CSI-2, BT.656 and Parallel interface.

Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Take care of MIPI CSI-2, BT.656 and Parallel interface as
  pointed out by Jacopo. Thanks!

 drivers/media/i2c/ov5640.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 1536649b9e90..43373416fcba 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3774,6 +3774,24 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
+				   unsigned int pad,
+				   struct v4l2_mbus_config *cfg)
+{
+	struct ov5640_dev *sensor = to_ov5640_dev(sd);
+
+	cfg->type = sensor->ep.bus_type;
+	if (ov5640_is_csi2(sensor)) {
+		cfg->bus.mipi_csi2.num_data_lanes =
+			sensor->ep.bus.mipi_csi2.num_data_lanes;
+		cfg->bus.mipi_csi2.flags = sensor->ep.bus.mipi_csi2.flags;
+	} else {
+		cfg->bus.parallel.flags = sensor->ep.bus.parallel.flags;
+	}
+
+	return 0;
+}
+
 static const struct v4l2_subdev_core_ops ov5640_core_ops = {
 	.log_status = v4l2_ctrl_subdev_log_status,
 	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
@@ -3794,6 +3812,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
 	.get_selection = ov5640_get_selection,
 	.enum_frame_size = ov5640_enum_frame_size,
 	.enum_frame_interval = ov5640_enum_frame_interval,
+	.get_mbus_config = ov5640_get_mbus_config,
 };
 
 static const struct v4l2_subdev_ops ov5640_subdev_ops = {
-- 
2.36.1

