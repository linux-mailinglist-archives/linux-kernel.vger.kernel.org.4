Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1761F5C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiKGOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiKGOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:23:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359B220FD;
        Mon,  7 Nov 2022 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667830741; x=1699366741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UdHr9EPfk2rI3xfTinW5/BgZpjVmDpj9RNJNkwC8ntc=;
  b=ThEQH43L67ta7ashiayjPWrpuyq9zV2kkBCHzVa4FUYmMr7qf5MiYoHl
   DFmPVbHU0uvSNBlAZ/NLX0drkLG4sWZ3DTD9pgrU80gYV8VEmW0vlycSG
   PrHg2SIwcHCQHZGWiprDaya8cUl8jdTlv8n/kIXaywLZrGgLrtJ2WyZpN
   YiZ1L4U1mlYexUk1tjOEAvOTniVtZEre9N6xgd1ax4m2E+RypY7KdggMR
   vvBAlwKgGyGzzn57G2F/TLfvCLW0oHo2gEuF7rJ20r3Zm+inHp4ediv5X
   bcmhJxSlkqPZ/C5HXKu+1uFvPDwTRPorWYdlfHbUR2XKj8EIKfw7C80N6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="182276996"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 07:18:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 07:18:30 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 07:18:28 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v12 1/6] media: atmel: move microchip_csi2dc to dedicated microchip platform
Date:   Mon, 7 Nov 2022 16:18:13 +0200
Message-ID: <20221107141818.104937-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107141818.104937-1-eugen.hristev@microchip.com>
References: <20221107141818.104937-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Atmel ISC will be moved to staging thus the atmel platform will only
have the ISI driver.
The new media-controller converted ISC driver will be placed inside a
dedicated microchip platform directory.
It is then natural to have the microchip-csi2dc moved to this new platform
directory.
The next step is to add the Microchip ISC driver to the new platform
directory and reside together with the Microchip CSI2DC driver.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS                                   |  2 +-
 drivers/media/platform/Kconfig                |  1 +
 drivers/media/platform/Makefile               |  1 +
 drivers/media/platform/atmel/Kconfig          | 15 ---------------
 drivers/media/platform/atmel/Makefile         |  1 -
 drivers/media/platform/microchip/Kconfig      | 19 +++++++++++++++++++
 drivers/media/platform/microchip/Makefile     |  3 +++
 .../{atmel => microchip}/microchip-csi2dc.c   |  0
 8 files changed, 25 insertions(+), 17 deletions(-)
 create mode 100644 drivers/media/platform/microchip/Kconfig
 create mode 100644 drivers/media/platform/microchip/Makefile
 rename drivers/media/platform/{atmel => microchip}/microchip-csi2dc.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 307775bfbf99..2991dfd61d9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13461,7 +13461,7 @@ M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
-F:	drivers/media/platform/atmel/microchip-csi2dc.c
+F:	drivers/media/platform/microchip/microchip-csi2dc.c
 
 MICROCHIP ECC DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 87c05acebb83..bc8969d20167 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -73,6 +73,7 @@ source "drivers/media/platform/dwc/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/Kconfig"
+source "drivers/media/platform/microchip/Kconfig"
 source "drivers/media/platform/nvidia/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 533a18d61f5f..d5c5e02f7855 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -16,6 +16,7 @@ obj-y += dwc/
 obj-y += intel/
 obj-y += marvell/
 obj-y += mediatek/
+obj-y += microchip/
 obj-y += nvidia/
 obj-y += nxp/
 obj-y += qcom/
diff --git a/drivers/media/platform/atmel/Kconfig b/drivers/media/platform/atmel/Kconfig
index f399dba62e17..6d07a31d4c0e 100644
--- a/drivers/media/platform/atmel/Kconfig
+++ b/drivers/media/platform/atmel/Kconfig
@@ -49,18 +49,3 @@ config VIDEO_ATMEL_ISI
 	  This module makes the ATMEL Image Sensor Interface available
 	  as a v4l2 device.
 
-config VIDEO_MICROCHIP_CSI2DC
-	tristate "Microchip CSI2 Demux Controller"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK && OF
-	depends on ARCH_AT91 || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  CSI2 Demux Controller driver. CSI2DC is a helper chip
-	  that converts IDI interface byte stream to a parallel pixel stream.
-	  It supports various RAW formats as input.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called microchip-csi2dc.
diff --git a/drivers/media/platform/atmel/Makefile b/drivers/media/platform/atmel/Makefile
index 794e8f739287..ab3890f95776 100644
--- a/drivers/media/platform/atmel/Makefile
+++ b/drivers/media/platform/atmel/Makefile
@@ -7,4 +7,3 @@ obj-$(CONFIG_VIDEO_ATMEL_ISI) += atmel-isi.o
 obj-$(CONFIG_VIDEO_ATMEL_ISC_BASE) += atmel-isc-common.o
 obj-$(CONFIG_VIDEO_ATMEL_ISC) += atmel-isc.o
 obj-$(CONFIG_VIDEO_ATMEL_XISC) += atmel-xisc.o
-obj-$(CONFIG_VIDEO_MICROCHIP_CSI2DC) += microchip-csi2dc.o
diff --git a/drivers/media/platform/microchip/Kconfig b/drivers/media/platform/microchip/Kconfig
new file mode 100644
index 000000000000..aa9e902f41f0
--- /dev/null
+++ b/drivers/media/platform/microchip/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "Microchip Technology, Inc. media platform drivers"
+
+config VIDEO_MICROCHIP_CSI2DC
+	tristate "Microchip CSI2 Demux Controller"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && COMMON_CLK && OF
+	depends on ARCH_AT91 || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  CSI2 Demux Controller driver. CSI2DC is a helper chip
+	  that converts IDI interface byte stream to a parallel pixel stream.
+	  It supports various RAW formats as input.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called microchip-csi2dc.
diff --git a/drivers/media/platform/microchip/Makefile b/drivers/media/platform/microchip/Makefile
new file mode 100644
index 000000000000..cbcde4a73117
--- /dev/null
+++ b/drivers/media/platform/microchip/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_VIDEO_MICROCHIP_CSI2DC) += microchip-csi2dc.o
diff --git a/drivers/media/platform/atmel/microchip-csi2dc.c b/drivers/media/platform/microchip/microchip-csi2dc.c
similarity index 100%
rename from drivers/media/platform/atmel/microchip-csi2dc.c
rename to drivers/media/platform/microchip/microchip-csi2dc.c
-- 
2.25.1

