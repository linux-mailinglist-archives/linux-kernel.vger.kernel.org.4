Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEDC6163AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKBNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKBNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:15:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7322BDA;
        Wed,  2 Nov 2022 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667394931; x=1698930931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0b5zankxi2at9S0+GIieTR3PENAi5v5dwTY12DWbYGU=;
  b=LUBW3jN/vyOoPXpasQnukpApXNejxvN9TRyodOdqVVQTa+6jp4uhKMjN
   HQrE5b0iFzxIqyPciUkRRZ5WE8pMa5DycuFH1l005qr1MJzdDWP527aAK
   eX3Qa9p/SDKrhsbUIFnehgoTN7TPcqlNrF9CRIXlw8VGFy3v/uJZKBlgp
   Nl9QthW+h8JkfxB08LF0ohQttlYvzqv7B/v3RIJbVlwx/6YXYVmZ4Rt98
   /nFDhLP/1AMdFpcmq2VdPLz6i9UVBUbS1u9D6d/idQPeKCXj+lc9RzSQ8
   HKZSYxeFY/J5VmoXaZ4RaeqRnWX9T3cD0eYH/O0IxX6g7yU4UudzDF/J0
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="187289430"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2022 06:15:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 2 Nov 2022 06:15:29 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 2 Nov 2022 06:15:27 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v11 2/6] media: atmel: move microchip_csi2dc to dedicated microchip platform
Date:   Wed, 2 Nov 2022 15:14:56 +0200
Message-ID: <20221102131500.476024-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102131500.476024-1-eugen.hristev@microchip.com>
References: <20221102131500.476024-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Atmel ISC has been moved to staging, the atmel platform only has the
ISI driver.
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
index 8b28d8d4c55e..4a0e1cc80362 100644
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
index f438a98542e8..3866ccae07df 100644
--- a/drivers/media/platform/atmel/Kconfig
+++ b/drivers/media/platform/atmel/Kconfig
@@ -13,18 +13,3 @@ config VIDEO_ATMEL_ISI
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
index 86f77030e6e2..a14ac6b5211d 100644
--- a/drivers/media/platform/atmel/Makefile
+++ b/drivers/media/platform/atmel/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_VIDEO_ATMEL_ISI) += atmel-isi.o
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

