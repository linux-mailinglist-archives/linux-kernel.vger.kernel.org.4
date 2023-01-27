Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470CD67E928
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjA0PNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjA0PN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:13:26 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAC284B44;
        Fri, 27 Jan 2023 07:13:10 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.206]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MbS8j-1oo0Ko1wqH-00bs7h; Fri, 27 Jan 2023 16:12:52 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Date:   Fri, 27 Jan 2023 16:12:44 +0100
Message-Id: <20230127151245.46732-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LnLuZcGr6caawagCtkpnB1i5EvvBvoA99joMC/8n7db4UpRqxDF
 /kTDm0JlL0aQVopzNSCMzELW62EdafVtbmph0Uhtw8JM8dNzbgC/1J0/sf9U/52AeifLsXj
 ueX+Ixo6DRjLMt2KYHFLJzpdWmInHAK9fwZAj2ZpE46B6cg5PrGutCd258pQKHvWMIwW12t
 APWbUkutTiPTkrRjsH01A==
UI-OutboundReport: notjunk:1;M01:P0:ySWAG/RI/kA=;Gohj3tVTcUbQQTJ5pdivTjMNnAF
 820xv5X0DUFjZ9RZp3oxSB3Kam7h9o0U0Ne5W39XYnM+NYVcxnQXgZbduPTyeBu9vxbRNl82K
 MqmaUWOzVzcu9a8+jOVe0nMdW0aUROIjYkrouZBpe1gso0aIabALjhxvilDju9TNp1NS9dSJa
 ZD/Iw2omEZFPViKRMFlhvRsCb3r4Tm1+ziXOPk7Dj1rhyznOOXCRh+LBOm8lAHoHkVLuWMJCr
 1gCzH4bFoXicfniLL+qKCSjUmI1akROH3vV3pVKW63H/mbaTRjfzibfuJ0v4XGEZQMpRfq/zM
 q1YRkaU4v9ws3ZwZzEJT75sqjLaaPCgZpPQacZgtrWXplm6sxHLM+9k5/2zTLltJ5sTspLbRu
 LVhHHqY3Gde5SgloanuHRecwiNmJKQCqcPGTahGzNwXobCeO8N3hYArCKVvTdcWu1m/xi+7Zl
 tQS2Z+7gNmmFdy9/UR/3iQWfKXTXoj5mEUbDZJ1xEW2sr7Z5pjQdYJAQoe4PjCTT1xnTV6s4E
 5NCX7LqhABiy9ELdn1OVpa8TMmiq5dqo0/EwerX9rHQvQmygdQGZn4XcMl8/176/qAp+VfYoq
 I0S/YlEgDu2aYzzA+fN0WF4j9y+cfE9Fdmv1ox5bLwcSd/SFd7VZ8Z9fF0FkxBOn+jRk4jKqo
 uyW99pkAUirc90WM1Tf3PqKRTf3J2K9mkrMmL3hhBjRSu+YfkZRDNRAiCB4RwgU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aishwarya Kothari <aishwarya.kothari@toradex.com>

Implement the introduced get_mbus_config operation to report the
number of used data lanes on the MIPI CSI-2 interface.

Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/media/i2c/ov5640.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index e0f908af581b..42d43f0d1e1c 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3733,6 +3733,19 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
+				   unsigned int pad,
+				   struct v4l2_mbus_config *cfg)
+{
+	struct ov5640_dev *sensor = to_ov5640_dev(sd);
+
+	cfg->type = V4L2_MBUS_CSI2_DPHY;
+	cfg->bus.mipi_csi2.num_data_lanes = sensor->ep.bus.mipi_csi2.num_data_lanes;
+	cfg->bus.mipi_csi2.flags = 0;
+
+	return 0;
+}
+
 static const struct v4l2_subdev_core_ops ov5640_core_ops = {
 	.log_status = v4l2_ctrl_subdev_log_status,
 	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
@@ -3753,6 +3766,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
 	.get_selection = ov5640_get_selection,
 	.enum_frame_size = ov5640_enum_frame_size,
 	.enum_frame_interval = ov5640_enum_frame_interval,
+	.get_mbus_config = ov5640_get_mbus_config,
 };
 
 static const struct v4l2_subdev_ops ov5640_subdev_ops = {
-- 
2.36.1

