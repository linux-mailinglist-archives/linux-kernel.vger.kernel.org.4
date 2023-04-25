Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901C6EDEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjDYJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjDYJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:09:06 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332F4EFA;
        Tue, 25 Apr 2023 02:09:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 96648E2183;
        Tue, 25 Apr 2023 02:08:24 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jdee2LPDzAn0; Tue, 25 Apr 2023 02:08:23 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1682413703; bh=RANDJgVEZfcC+aHTZtmkEYXohM3JUlJ0SajyC9WzVnk=;
        h=From:To:Cc:Subject:Date:From;
        b=dzxxqQpZ3r1A8fN9PdN6IME5MXJtWoY26q5WUDTcK1BLVrkbNsTnxUCapey+L2k1K
         x1ZVSkh+bWtb+AtAlgxPMjJK6mw+5tRDlhpcvqcLngb8FvVLvQKpUwlRMvRuGEOg93
         +vdFkCy7iwIAQr7xQWH3lBcONDkv2Nyj7cFRe0wY8VEMiA1luZ1/RpBmOJkWQyfCb1
         Vb9Ers8IRXTbV3FQQ5V0UVA3XLe/6eOeYUUVO5kFz1ZIBewYa87ifUudoOLB7hOGmA
         5akAEQYts5/tFiCxzq/juWt0NvssA35rmcpBRgguyNq50Il9Tnuj/+PFsMrLKpY91Q
         uxqhfaOgjLK8g==
To:     mchehab@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        slongerbeam@gmail.com, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com, hverkuil-cisco@xs4all.nl,
        rmfrfs@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2] media: imx: Unstage the imx8mq-mipi-csi2 driver
Date:   Tue, 25 Apr 2023 11:08:04 +0200
Message-Id: <20230425090804.2664466-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mq-mipi-csi2 MIPI CSI-2 receiver driver is used and maintained.
There is no reason to keep it in staging. The accompanying CSI bridge
driver that uses it is in drivers/media/platform/nxp as well.

One TODO is to get rid of csi_state's "state" and "lock" variables.
Especially make sure suspend/resume is working without them. That can
very well be worked on from the new location.

Also add a MAINTAINERS section for the imx8mq-mipi-csi2 mipi receiver
driver.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
v2: (thank you Laurent)
* simplify MAINTAINERS entries by adding to existing one
* minor ordering fixes and drop unrelated changes

v1:
* initial patch
  https://lore.kernel.org/linux-media/20230424091209.GC14888@pendragon.ideasonboard.com/T/#t


 MAINTAINERS                                           |  6 +++++-
 drivers/media/platform/nxp/Kconfig                    | 11 +++++++++++
 drivers/media/platform/nxp/Makefile                   |  1 +
 .../imx => media/platform/nxp}/imx8mq-mipi-csi2.c     |  0
 drivers/staging/media/imx/Kconfig                     | 10 ----------
 drivers/staging/media/imx/Makefile                    |  2 --
 6 files changed, 17 insertions(+), 13 deletions(-)
 rename drivers/{staging/media/imx => media/platform/nxp}/imx8mq-mipi-csi2.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f50945bb7d1b..711aabed0e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12907,17 +12907,21 @@ F:	drivers/staging/media/imx/
 F:	include/linux/imx-media.h
 F:	include/media/imx.h
 
-MEDIA DRIVERS FOR FREESCALE IMX7
+MEDIA DRIVERS FOR FREESCALE IMX7/8
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Martin Kepplinger <martin.kepplinger@puri.sm>
+R:	Purism Kernel Team <kernel@puri.sm>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/imx7.rst
 F:	Documentation/devicetree/bindings/media/nxp,imx-mipi-csi2.yaml
 F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
 F:	drivers/media/platform/nxp/imx-mipi-csis.c
 F:	drivers/media/platform/nxp/imx7-media-csi.c
+F:	drivers/media/platform/nxp/imx8mq-mipi-csi.c
 
 MEDIA DRIVERS FOR HELENE
 M:	Abylay Ospan <aospan@netup.ru>
diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
index a0ca6b297fb8..40e3436669e2 100644
--- a/drivers/media/platform/nxp/Kconfig
+++ b/drivers/media/platform/nxp/Kconfig
@@ -17,6 +17,17 @@ config VIDEO_IMX7_CSI
 	  Driver for the NXP Camera Sensor Interface (CSI) Bridge. This device
 	  is found in the i.MX6UL/L, i.MX7 and i.MX8M[MQ] SoCs.
 
+config VIDEO_IMX8MQ_MIPI_CSI2
+	tristate "NXP i.MX8MQ MIPI CSI-2 receiver"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  Video4Linux2 driver for the MIPI CSI-2 receiver found on the i.MX8MQ
+	  SoC.
+
 config VIDEO_IMX_MIPI_CSIS
 	tristate "NXP MIPI CSI-2 CSIS receiver found on i.MX7 and i.MX8 models"
 	depends on ARCH_MXC || COMPILE_TEST
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
index 21fd79515042..b42af427b88b 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
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

