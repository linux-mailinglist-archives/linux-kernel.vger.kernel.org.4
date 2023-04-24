Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D219A6EC7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDXIa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDXIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:30:25 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FA189;
        Mon, 24 Apr 2023 01:30:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 1BA80E126D;
        Mon, 24 Apr 2023 01:30:23 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OQNp4Wng5lcs; Mon, 24 Apr 2023 01:30:17 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1682325017; bh=1YtoU58GRKmxuR/4dCxeVqokfEQvi2oTrrPDApVPVK8=;
        h=From:To:Cc:Subject:Date:From;
        b=qsuNnUxj1lIV/NgI+l9t/C5vCtbOg0DuXGrWO79JQKrafrPgcnxgX6/uTv4xmxsFB
         skmytIbNH8zSgoLtzgnjbnlmKXV/SEce86VbdsLhWhPRBUBLRayAsdAHvjh1dWw22I
         KwqNzf+JSU7VakbV3Obu2V3bEAZsGmoGaw+LMYdRO+jJj4jByBgb0pxAY9WioPxIc2
         FULkxhExbxMttJkGa5nYhCjPSxTXcUWO624T1Gv3l3eX0cI4+jzNiXisVyl9juQ8tI
         1LphlousT6CLE3c1V1fRPFTdWDQqoYxMgsMaO7NH4kCso+6ABzYee1zJUPst9FW4j5
         4nAIugF4Bz3Tg==
To:     mchehab@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        slongerbeam@gmail.com, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com, hverkuil-cisco@xs4all.nl,
        rmfrfs@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] media: imx: Unstage the imx8mq-mipi-csi2 driver
Date:   Mon, 24 Apr 2023 10:29:45 +0200
Message-Id: <20230424082945.2580298-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mq-mipi-csi2 mipi receiver driver is used and maintained. There
is no reason to keep it in staging. The accompanying CSI bridge driver that
uses it is in drivers/media/platform/nxp as well.

One TODO is to get rid of csi_state's "state" and "lock" variables. Especially
make sure suspend/resume is working without them. That can very well be worked
on from the new location.

Add a MAINTAINERS section for the imx8mq-mipi-csi2 mipi receiver driver.
It shares the CSI Bridge driver with the one from imx7 and imx8mm so the
sections overlap a bit.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 MAINTAINERS                                         | 13 +++++++++++++
 drivers/media/platform/nxp/Kconfig                  | 11 +++++++++++
 drivers/media/platform/nxp/Makefile                 |  1 +
 .../imx => media/platform/nxp}/imx8mq-mipi-csi2.c   |  0
 drivers/staging/media/imx/Kconfig                   | 12 +-----------
 drivers/staging/media/imx/Makefile                  |  2 --
 6 files changed, 26 insertions(+), 13 deletions(-)
 rename drivers/{staging/media/imx => media/platform/nxp}/imx8mq-mipi-csi2.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f50945bb7d1b..fcd48408fc1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12919,6 +12919,19 @@ F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
 F:	drivers/media/platform/nxp/imx-mipi-csis.c
 F:	drivers/media/platform/nxp/imx7-media-csi.c
 
+MEDIA DRIVERS FOR FREESCALE IMX8MQ
+M:	Martin Kepplinger <martin.kepplinger@puri.sm>
+R:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+R:	Purism Kernel Team <kernel@puri.sm>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/admin-guide/media/imx7.rst
+F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
+F:	drivers/media/platform/nxp/imx7-media-csi.c
+F:	drivers/media/platform/nxp/imx8mq-mipi-csi.c
+
 MEDIA DRIVERS FOR HELENE
 M:	Abylay Ospan <aospan@netup.ru>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
index a0ca6b297fb8..efa985ec8a5f 100644
--- a/drivers/media/platform/nxp/Kconfig
+++ b/drivers/media/platform/nxp/Kconfig
@@ -28,6 +28,17 @@ config VIDEO_IMX_MIPI_CSIS
 	  Video4Linux2 sub-device driver for the MIPI CSI-2 CSIS receiver
 	  v3.3/v3.6.3 found on some i.MX7 and i.MX8 SoCs.
 
+config VIDEO_IMX8MQ_MIPI_CSI2
+	tristate "NXP i.MX8MQ MIPI CSI-2 receiver"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  Video4Linux2 driver for the MIPI CSI-2 receiver found on the i.MX8MQ
+	  SoC. The i.MX8MQ CSI Bridge is the same as on i.MX7.
+
 source "drivers/media/platform/nxp/imx8-isi/Kconfig"
 
 # mem2mem drivers
diff --git a/drivers/media/platform/nxp/Makefile b/drivers/media/platform/nxp/Makefile
index b8e672b75fed..4d90eb713652 100644
--- a/drivers/media/platform/nxp/Makefile
+++ b/drivers/media/platform/nxp/Makefile
@@ -5,6 +5,7 @@ obj-y += imx-jpeg/
 obj-y += imx8-isi/
 
 obj-$(CONFIG_VIDEO_IMX7_CSI) += imx7-media-csi.o
+obj-$(CONFIG_VIDEO_IMX8MQ_MIPI_CSI2) += imx8mq-mipi-csi2.o
 obj-$(CONFIG_VIDEO_IMX_MIPI_CSIS) += imx-mipi-csis.o
 obj-$(CONFIG_VIDEO_IMX_PXP) += imx-pxp.o
 obj-$(CONFIG_VIDEO_MX2_EMMAPRP) += mx2_emmaprp.o
diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
similarity index 100%
rename from drivers/staging/media/imx/imx8mq-mipi-csi2.c
rename to drivers/media/platform/nxp/imx8mq-mipi-csi2.c
diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 21fd79515042..5b393e29d29e 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -15,7 +15,7 @@ config VIDEO_IMX_MEDIA
 	  driver for the i.MX5/6 SOC.
 
 if VIDEO_IMX_MEDIA
-menu "i.MX5/6/7/8 Media Sub devices"
+menu "i.MX5/6 Media Sub devices"
 
 config VIDEO_IMX_CSI
 	tristate "i.MX5/6 Camera Sensor Interface driver"
@@ -25,13 +25,3 @@ config VIDEO_IMX_CSI
 	  A video4linux camera sensor interface driver for i.MX5/6.
 endmenu
 endif
-
-config VIDEO_IMX8MQ_MIPI_CSI2
-	tristate "NXP i.MX8MQ MIPI CSI-2 receiver"
-	depends on ARCH_MXC || COMPILE_TEST
-	depends on VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  V4L2 driver for the MIPI CSI-2 receiver found in the i.MX8MQ SoC.
diff --git a/drivers/staging/media/imx/Makefile b/drivers/staging/media/imx/Makefile
index 906a422aa656..b69951deff9a 100644
--- a/drivers/staging/media/imx/Makefile
+++ b/drivers/staging/media/imx/Makefile
@@ -13,5 +13,3 @@ obj-$(CONFIG_VIDEO_IMX_MEDIA) += imx-media-common.o
 obj-$(CONFIG_VIDEO_IMX_CSI) += imx6-media.o
 obj-$(CONFIG_VIDEO_IMX_CSI) += imx6-media-csi.o
 obj-$(CONFIG_VIDEO_IMX_CSI) += imx6-mipi-csi2.o
-
-obj-$(CONFIG_VIDEO_IMX8MQ_MIPI_CSI2) += imx8mq-mipi-csi2.o
-- 
2.30.2

