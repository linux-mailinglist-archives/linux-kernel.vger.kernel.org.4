Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD976184FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiKCQlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiKCQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:34 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779EF2099A;
        Thu,  3 Nov 2022 09:37:37 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 26D3120018;
        Thu,  3 Nov 2022 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6s4c74SxXJbBSOMmWDVfiGEdOBtE4A7u6CQQkHhb+Y=;
        b=pM2/tBPY6eFkXDH6mAF1yACM/xVJelMCsD5skiNrr3wzKfnHYVZChydwGGckp3uoYY5r8r
        jiETah85UHx19PDzfgUCm+rz2uWqElcyzX47WwADtW118w+eR2p2iuK0XVkfAAtfZIDyYT
        mwtEVHQ7/xyTZcGc/C/rPgfVPusrjXaPrTPUCV4V+QJTNJCYqnDrpzSynMnU9ScSvvalEE
        0xG9X10eI+GcuQsn6w1gRdgHKRisC2tsXpMsDC214XvMlKEbSQI8ullmZQY3fukSKY1zV1
        +cKVjo/50ZRQU/g3wuwIow51fG07Ewa0hNQ8e+5bKQcxapyi4rb/Nn6oKmD8Qw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v8 5/6] media: sun6i-csi: Detect the availability of the ISP
Date:   Thu,  3 Nov 2022 17:37:16 +0100
Message-Id: <20221103163717.246217-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163717.246217-1-paul.kocialkowski@bootlin.com>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com>
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

Add a helper to detect whether the ISP is available and connected
and store the indication in the driver-specific device structure.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 00521f966cee..046fc9d018eb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -24,6 +24,36 @@
 #include "sun6i_csi_capture.h"
 #include "sun6i_csi_reg.h"
 
+/* ISP */
+
+static int sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
+{
+	struct device *dev = csi_dev->dev;
+	struct fwnode_handle *handle;
+
+	/*
+	 * ISP is not available if not connected via fwnode graph.
+	 * This will also check that the remote parent node is available.
+	 */
+	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
+						 SUN6I_CSI_PORT_ISP, 0,
+						 FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!handle)
+		return 0;
+
+	fwnode_handle_put(handle);
+
+	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP)) {
+		dev_warn(dev,
+			 "ISP link is detected but not enabled in kernel config!");
+		return 0;
+	}
+
+	csi_dev->isp_available = true;
+
+	return 0;
+}
+
 /* Media */
 
 static const struct media_device_ops sun6i_csi_media_ops = {
@@ -290,6 +320,10 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		return ret;
 
+	ret = sun6i_csi_isp_detect(csi_dev);
+	if (ret)
+		goto error_resources;
+
 	ret = sun6i_csi_v4l2_setup(csi_dev);
 	if (ret)
 		goto error_resources;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index e611bdd6e9b2..8e232cd91ebe 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -21,6 +21,7 @@
 enum sun6i_csi_port {
 	SUN6I_CSI_PORT_PARALLEL		= 0,
 	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
+	SUN6I_CSI_PORT_ISP		= 2,
 };
 
 struct sun6i_csi_buffer {
@@ -44,6 +45,8 @@ struct sun6i_csi_device {
 	struct clk			*clock_mod;
 	struct clk			*clock_ram;
 	struct reset_control		*reset;
+
+	bool				isp_available;
 };
 
 struct sun6i_csi_variant {
-- 
2.38.1

