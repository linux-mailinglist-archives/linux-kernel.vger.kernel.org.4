Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCA61F5D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiKGOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKGOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:24:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6C240BA;
        Mon,  7 Nov 2022 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667830768; x=1699366768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tq3Hh0bofOkQXI48ZPfM0ndYV3g5+FvaA/EGF0x6MDs=;
  b=ui+MGgkzOtukjg16kIhvCqBskRdgr9vGLdmyzMhz6aWgimD+CwwEfyJI
   pFZSuozZgUYEcD7wdf3GNlCY96DmQaES9mCtwXp8ya8zNGoa+sdNc3RSP
   t5yxexS+aKW9TblEySC3F05BDILbnrP8JleIHUGa2AXGDx3nPKiEX7xOJ
   3Gyt6LBBUi0/ddqamu6WRyOFpBv1JLQg1gJj9X3A3sSQYWmHVgJBxeN5a
   fxiIHk7sovFhi/Iho5d7NREbAAm0KrfnqV37xl0V1y04aTTIlQHEB/eUG
   QmWhYOp2t5+ipGqH6OMzMN5ZymaUUyyqM8iTxOyA0jOa7u1n9WBPLzBpU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="198727482"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 07:18:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 07:18:41 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 07:18:39 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v12 6/6] media: atmel: atmel-isc: move to staging
Date:   Mon, 7 Nov 2022 16:18:18 +0200
Message-ID: <20221107141818.104937-7-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107141818.104937-1-eugen.hristev@microchip.com>
References: <20221107141818.104937-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Atmel ISC driver is not compliant with media controller specification.
In order to evolve this driver, it has to move to media controller, to
support enhanced features and future products which embed it.
The move to media controller involves several changes which are
not backwards compatible with the current usability of the driver.

The best example is the way the format is propagated from the top video
driver /dev/videoX down to the sensor.

In a simple configuration sensor ==> isc , the isc just calls subdev s_fmt
and controls the sensor directly. This is achieved by having a lot of code
inside the driver that will query the subdev at probe time and make a list
of formats which are usable.
Basically the user has nothing to configure, as the isc will handle
everything at the top level. This is an easy way to capture, but also comes
with the drawback of lack of flexibility.
In a more complicated pipeline
sensor ==> controller 1 ==> controller 2 ==> isc
this will not be achievable, as controller 1 and controller 2 might be
media-controller configurable, and will not propagate the formats down to
the sensor.

After discussions with the media maintainers, the decision is to move
Atmel ISC to staging as-is, to keep the Kconfig symbols and the users
to the driver in staging. Thus, all the existing users of the non
media-controller paradigm will continue to be happy and use the old config
way.

The new driver was added in the media subsystem with a different
symbol, with the conversion to media controller done, and new users
of the driver will be able to use all the new features.

This patch is merely a file move to staging, not affecting any of the
users.

The exported symbols had to be renamed to atmel_* to avoid duplication with
the new Microchip ISC driver.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v12:
- move to deprecated dir
- added TODO file
- make it dependant on !VIDEO_MICROCHIP_ISC_BASE

 MAINTAINERS                                   |  4 +-
 drivers/media/platform/atmel/Kconfig          | 36 --------------
 drivers/media/platform/atmel/Makefile         |  6 ---
 drivers/staging/media/Kconfig                 |  1 +
 drivers/staging/media/Makefile                |  1 +
 .../staging/media/deprecated/atmel/Kconfig    | 48 +++++++++++++++++++
 .../staging/media/deprecated/atmel/Makefile   |  8 ++++
 drivers/staging/media/deprecated/atmel/TODO   | 34 +++++++++++++
 .../media/deprecated}/atmel/atmel-isc-base.c  | 20 ++++----
 .../media/deprecated}/atmel/atmel-isc-clk.c   |  8 ++--
 .../media/deprecated}/atmel/atmel-isc-regs.h  |  0
 .../media/deprecated}/atmel/atmel-isc.h       | 16 +++----
 .../deprecated}/atmel/atmel-sama5d2-isc.c     | 18 +++----
 .../deprecated}/atmel/atmel-sama7g5-isc.c     | 18 +++----
 14 files changed, 134 insertions(+), 84 deletions(-)
 create mode 100644 drivers/staging/media/deprecated/atmel/Kconfig
 create mode 100644 drivers/staging/media/deprecated/atmel/Makefile
 create mode 100644 drivers/staging/media/deprecated/atmel/TODO
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc-base.c (99%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc-clk.c (97%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc-regs.h (100%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc.h (96%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-sama5d2-isc.c (97%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-sama7g5-isc.c (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fa2438e540e..c8447917924c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13488,8 +13488,8 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/media/atmel,isc.yaml
 F:	Documentation/devicetree/bindings/media/microchip,xisc.yaml
-F:	drivers/media/platform/atmel/atmel-isc*
-F:	drivers/media/platform/atmel/atmel-sama*-isc*
+F:	drivers/staging/media/deprecated/atmel/atmel-isc*
+F:	drivers/staging/media/deprecated/atmel/atmel-sama*-isc*
 F:	drivers/media/platform/microchip/microchip-isc*
 F:	drivers/media/platform/microchip/microchip-sama*-isc*
 F:	include/linux/atmel-isc-media.h
diff --git a/drivers/media/platform/atmel/Kconfig b/drivers/media/platform/atmel/Kconfig
index 6d07a31d4c0e..3866ccae07df 100644
--- a/drivers/media/platform/atmel/Kconfig
+++ b/drivers/media/platform/atmel/Kconfig
@@ -2,42 +2,6 @@
 
 comment "Atmel media platform drivers"
 
-config VIDEO_ATMEL_ISC
-	tristate "ATMEL Image Sensor Controller (ISC) support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK
-	depends on ARCH_AT91 || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	select REGMAP_MMIO
-	select V4L2_FWNODE
-	select VIDEO_ATMEL_ISC_BASE
-	help
-	   This module makes the ATMEL Image Sensor Controller available
-	   as a v4l2 device.
-
-config VIDEO_ATMEL_XISC
-	tristate "ATMEL eXtended Image Sensor Controller (XISC) support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK
-	depends on ARCH_AT91 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select REGMAP_MMIO
-	select V4L2_FWNODE
-	select VIDEO_ATMEL_ISC_BASE
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	   This module makes the ATMEL eXtended Image Sensor Controller
-	   available as a v4l2 device.
-
-config VIDEO_ATMEL_ISC_BASE
-	tristate
-	default n
-	help
-	  ATMEL ISC and XISC common code base.
-
 config VIDEO_ATMEL_ISI
 	tristate "ATMEL Image Sensor Interface (ISI) support"
 	depends on V4L_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/atmel/Makefile b/drivers/media/platform/atmel/Makefile
index ab3890f95776..a14ac6b5211d 100644
--- a/drivers/media/platform/atmel/Makefile
+++ b/drivers/media/platform/atmel/Makefile
@@ -1,9 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-atmel-isc-objs = atmel-sama5d2-isc.o
-atmel-xisc-objs = atmel-sama7g5-isc.o
-atmel-isc-common-objs = atmel-isc-base.o atmel-isc-clk.o
 
 obj-$(CONFIG_VIDEO_ATMEL_ISI) += atmel-isi.o
-obj-$(CONFIG_VIDEO_ATMEL_ISC_BASE) += atmel-isc-common.o
-obj-$(CONFIG_VIDEO_ATMEL_ISC) += atmel-isc.o
-obj-$(CONFIG_VIDEO_ATMEL_XISC) += atmel-xisc.o
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index d4f03b203ae5..b79f93684c4f 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -51,6 +51,7 @@ menuconfig STAGING_MEDIA_DEPRECATED
 	  If in doubt, say N here.
 
 if STAGING_MEDIA_DEPRECATED
+source "drivers/staging/media/deprecated/atmel/Kconfig"
 source "drivers/staging/media/deprecated/cpia2/Kconfig"
 source "drivers/staging/media/deprecated/fsl-viu/Kconfig"
 source "drivers/staging/media/deprecated/meye/Kconfig"
diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index a387692b84f2..54bbdd4b0d08 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIDEO_ATMEL_ISC_BASE)	+= deprecated/atmel/
 obj-$(CONFIG_INTEL_ATOMISP)     += atomisp/
 obj-$(CONFIG_VIDEO_CPIA2)	+= deprecated/cpia2/
 obj-$(CONFIG_VIDEO_IMX_MEDIA)	+= imx/
diff --git a/drivers/staging/media/deprecated/atmel/Kconfig b/drivers/staging/media/deprecated/atmel/Kconfig
new file mode 100644
index 000000000000..7d8af45d59d3
--- /dev/null
+++ b/drivers/staging/media/deprecated/atmel/Kconfig
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "Atmel media platform drivers"
+
+config VIDEO_ATMEL_ISC
+	tristate "ATMEL Image Sensor Controller (ISC) support (DEPRECATED)"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && COMMON_CLK
+	depends on ARCH_AT91 || COMPILE_TEST
+	depends on !VIDEO_MICROCHIP_ISC_BASE || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select REGMAP_MMIO
+	select V4L2_FWNODE
+	select VIDEO_ATMEL_ISC_BASE
+	help
+	   This module makes the ATMEL Image Sensor Controller available
+	   as a v4l2 device.
+
+	   This driver is deprecated and is scheduled for removal by
+	   the beginning of 2026. See the TODO file for more information.
+
+config VIDEO_ATMEL_XISC
+	tristate "ATMEL eXtended Image Sensor Controller (XISC) support (DEPRECATED)"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && COMMON_CLK
+	depends on ARCH_AT91 || COMPILE_TEST
+	depends on !VIDEO_MICROCHIP_ISC_BASE || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select REGMAP_MMIO
+	select V4L2_FWNODE
+	select VIDEO_ATMEL_ISC_BASE
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	   This module makes the ATMEL eXtended Image Sensor Controller
+	   available as a v4l2 device.
+
+	   This driver is deprecated and is scheduled for removal by
+	   the beginning of 2026. See the TODO file for more information.
+
+config VIDEO_ATMEL_ISC_BASE
+	tristate
+	default n
+	help
+	  ATMEL ISC and XISC common code base.
+
diff --git a/drivers/staging/media/deprecated/atmel/Makefile b/drivers/staging/media/deprecated/atmel/Makefile
new file mode 100644
index 000000000000..34eaeeac5bba
--- /dev/null
+++ b/drivers/staging/media/deprecated/atmel/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+atmel-isc-objs = atmel-sama5d2-isc.o
+atmel-xisc-objs = atmel-sama7g5-isc.o
+atmel-isc-common-objs = atmel-isc-base.o atmel-isc-clk.o
+
+obj-$(CONFIG_VIDEO_ATMEL_ISC_BASE) += atmel-isc-common.o
+obj-$(CONFIG_VIDEO_ATMEL_ISC) += atmel-isc.o
+obj-$(CONFIG_VIDEO_ATMEL_XISC) += atmel-xisc.o
diff --git a/drivers/staging/media/deprecated/atmel/TODO b/drivers/staging/media/deprecated/atmel/TODO
new file mode 100644
index 000000000000..71691df07a80
--- /dev/null
+++ b/drivers/staging/media/deprecated/atmel/TODO
@@ -0,0 +1,34 @@
+The Atmel ISC driver is not compliant with media controller specification.
+In order to evolve this driver, it has to move to media controller, to
+support enhanced features and future products which embed it.
+The move to media controller involves several changes which are
+not backwards compatible with the current usability of the driver.
+
+The best example is the way the format is propagated from the top video
+driver /dev/videoX down to the sensor.
+
+In a simple configuration sensor ==> isc , the isc just calls subdev s_fmt
+and controls the sensor directly. This is achieved by having a lot of code
+inside the driver that will query the subdev at probe time and make a list
+of formats which are usable.
+Basically the user has nothing to configure, as the isc will handle
+everything at the top level. This is an easy way to capture, but also comes
+with the drawback of lack of flexibility.
+In a more complicated pipeline
+sensor ==> controller 1 ==> controller 2 ==> isc
+this will not be achievable, as controller 1 and controller 2 might be
+media-controller configurable, and will not propagate the formats down to
+the sensor.
+
+After discussions with the media maintainers, the decision is to move
+Atmel ISC to staging as-is, to keep the Kconfig symbols and the users
+to the driver in staging. Thus, all the existing users of the non
+media-controller paradigm will continue to be happy and use the old config
+way.
+
+The new driver was added in the media subsystem with a different
+symbol, with the conversion to media controller done, and new users
+of the driver will be able to use all the new features.
+
+The replacement driver is named VIDEO_MICROCHIP_ISC or
+VIDEO_MICROCHIP_XISC depending on the product flavor.
diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
similarity index 99%
rename from drivers/media/platform/atmel/atmel-isc-base.c
rename to drivers/staging/media/deprecated/atmel/atmel-isc-base.c
index 9e5317a7d516..99e61bbfc9bc 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
@@ -1221,7 +1221,7 @@ static const struct v4l2_file_operations isc_fops = {
 	.poll		= vb2_fop_poll,
 };
 
-irqreturn_t isc_interrupt(int irq, void *dev_id)
+irqreturn_t atmel_isc_interrupt(int irq, void *dev_id)
 {
 	struct isc_device *isc = (struct isc_device *)dev_id;
 	struct regmap *regmap = isc->regmap;
@@ -1267,7 +1267,7 @@ irqreturn_t isc_interrupt(int irq, void *dev_id)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(isc_interrupt);
+EXPORT_SYMBOL_GPL(atmel_isc_interrupt);
 
 static void isc_hist_count(struct isc_device *isc, u32 *min, u32 *max)
 {
@@ -1934,14 +1934,14 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	return ret;
 }
 
-const struct v4l2_async_notifier_operations isc_async_ops = {
+const struct v4l2_async_notifier_operations atmel_isc_async_ops = {
 	.bound = isc_async_bound,
 	.unbind = isc_async_unbind,
 	.complete = isc_async_complete,
 };
-EXPORT_SYMBOL_GPL(isc_async_ops);
+EXPORT_SYMBOL_GPL(atmel_isc_async_ops);
 
-void isc_subdev_cleanup(struct isc_device *isc)
+void atmel_isc_subdev_cleanup(struct isc_device *isc)
 {
 	struct isc_subdev_entity *subdev_entity;
 
@@ -1952,9 +1952,9 @@ void isc_subdev_cleanup(struct isc_device *isc)
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 }
-EXPORT_SYMBOL_GPL(isc_subdev_cleanup);
+EXPORT_SYMBOL_GPL(atmel_isc_subdev_cleanup);
 
-int isc_pipeline_init(struct isc_device *isc)
+int atmel_isc_pipeline_init(struct isc_device *isc)
 {
 	struct device *dev = isc->dev;
 	struct regmap *regmap = isc->regmap;
@@ -1993,17 +1993,17 @@ int isc_pipeline_init(struct isc_device *isc)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(isc_pipeline_init);
+EXPORT_SYMBOL_GPL(atmel_isc_pipeline_init);
 
 /* regmap configuration */
 #define ATMEL_ISC_REG_MAX    0xd5c
-const struct regmap_config isc_regmap_config = {
+const struct regmap_config atmel_isc_regmap_config = {
 	.reg_bits       = 32,
 	.reg_stride     = 4,
 	.val_bits       = 32,
 	.max_register	= ATMEL_ISC_REG_MAX,
 };
-EXPORT_SYMBOL_GPL(isc_regmap_config);
+EXPORT_SYMBOL_GPL(atmel_isc_regmap_config);
 
 MODULE_AUTHOR("Songjun Wu");
 MODULE_AUTHOR("Eugen Hristev");
diff --git a/drivers/media/platform/atmel/atmel-isc-clk.c b/drivers/staging/media/deprecated/atmel/atmel-isc-clk.c
similarity index 97%
rename from drivers/media/platform/atmel/atmel-isc-clk.c
rename to drivers/staging/media/deprecated/atmel/atmel-isc-clk.c
index 2059fe376b00..d442b5f4c931 100644
--- a/drivers/media/platform/atmel/atmel-isc-clk.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-isc-clk.c
@@ -277,7 +277,7 @@ static int isc_clk_register(struct isc_device *isc, unsigned int id)
 	return 0;
 }
 
-int isc_clk_init(struct isc_device *isc)
+int atmel_isc_clk_init(struct isc_device *isc)
 {
 	unsigned int i;
 	int ret;
@@ -293,9 +293,9 @@ int isc_clk_init(struct isc_device *isc)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(isc_clk_init);
+EXPORT_SYMBOL_GPL(atmel_isc_clk_init);
 
-void isc_clk_cleanup(struct isc_device *isc)
+void atmel_isc_clk_cleanup(struct isc_device *isc)
 {
 	unsigned int i;
 
@@ -308,4 +308,4 @@ void isc_clk_cleanup(struct isc_device *isc)
 			clk_unregister(isc_clk->clk);
 	}
 }
-EXPORT_SYMBOL_GPL(isc_clk_cleanup);
+EXPORT_SYMBOL_GPL(atmel_isc_clk_cleanup);
diff --git a/drivers/media/platform/atmel/atmel-isc-regs.h b/drivers/staging/media/deprecated/atmel/atmel-isc-regs.h
similarity index 100%
rename from drivers/media/platform/atmel/atmel-isc-regs.h
rename to drivers/staging/media/deprecated/atmel/atmel-isc-regs.h
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/staging/media/deprecated/atmel/atmel-isc.h
similarity index 96%
rename from drivers/media/platform/atmel/atmel-isc.h
rename to drivers/staging/media/deprecated/atmel/atmel-isc.h
index ff60ba020cb9..dfc030b5a08f 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/staging/media/deprecated/atmel/atmel-isc.h
@@ -350,13 +350,13 @@ struct isc_device {
 	u32				formats_list_size;
 };
 
-extern const struct regmap_config isc_regmap_config;
-extern const struct v4l2_async_notifier_operations isc_async_ops;
-
-irqreturn_t isc_interrupt(int irq, void *dev_id);
-int isc_pipeline_init(struct isc_device *isc);
-int isc_clk_init(struct isc_device *isc);
-void isc_subdev_cleanup(struct isc_device *isc);
-void isc_clk_cleanup(struct isc_device *isc);
+extern const struct regmap_config atmel_isc_regmap_config;
+extern const struct v4l2_async_notifier_operations atmel_isc_async_ops;
+
+irqreturn_t atmel_isc_interrupt(int irq, void *dev_id);
+int atmel_isc_pipeline_init(struct isc_device *isc);
+int atmel_isc_clk_init(struct isc_device *isc);
+void atmel_isc_subdev_cleanup(struct isc_device *isc);
+void atmel_isc_clk_cleanup(struct isc_device *isc);
 
 #endif
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
similarity index 97%
rename from drivers/media/platform/atmel/atmel-sama5d2-isc.c
rename to drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
index 9881d89a645b..ba0614f981a2 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-sama5d2-isc.c
@@ -408,7 +408,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-	isc->regmap = devm_regmap_init_mmio(dev, io_base, &isc_regmap_config);
+	isc->regmap = devm_regmap_init_mmio(dev, io_base, &atmel_isc_regmap_config);
 	if (IS_ERR(isc->regmap)) {
 		ret = PTR_ERR(isc->regmap);
 		dev_err(dev, "failed to init register map: %d\n", ret);
@@ -419,7 +419,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
+	ret = devm_request_irq(dev, irq, atmel_isc_interrupt, 0,
 			       "atmel-sama5d2-isc", isc);
 	if (ret < 0) {
 		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
@@ -464,7 +464,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	/* sama5d2-isc : ISPCK is required and mandatory */
 	isc->ispck_required = true;
 
-	ret = isc_pipeline_init(isc);
+	ret = atmel_isc_pipeline_init(isc);
 	if (ret)
 		return ret;
 
@@ -481,7 +481,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = isc_clk_init(isc);
+	ret = atmel_isc_clk_init(isc);
 	if (ret) {
 		dev_err(dev, "failed to init isc clock: %d\n", ret);
 		goto unprepare_hclk;
@@ -523,7 +523,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 			goto cleanup_subdev;
 		}
 
-		subdev_entity->notifier.ops = &isc_async_ops;
+		subdev_entity->notifier.ops = &atmel_isc_async_ops;
 
 		ret = v4l2_async_nf_register(&isc->v4l2_dev,
 					     &subdev_entity->notifier);
@@ -567,7 +567,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 
 cleanup_subdev:
-	isc_subdev_cleanup(isc);
+	atmel_isc_subdev_cleanup(isc);
 
 unregister_v4l2_device:
 	v4l2_device_unregister(&isc->v4l2_dev);
@@ -575,7 +575,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 unprepare_hclk:
 	clk_disable_unprepare(isc->hclock);
 
-	isc_clk_cleanup(isc);
+	atmel_isc_clk_cleanup(isc);
 
 	return ret;
 }
@@ -586,14 +586,14 @@ static int atmel_isc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	isc_subdev_cleanup(isc);
+	atmel_isc_subdev_cleanup(isc);
 
 	v4l2_device_unregister(&isc->v4l2_dev);
 
 	clk_disable_unprepare(isc->ispck);
 	clk_disable_unprepare(isc->hclock);
 
-	isc_clk_cleanup(isc);
+	atmel_isc_clk_cleanup(isc);
 
 	return 0;
 }
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
similarity index 97%
rename from drivers/media/platform/atmel/atmel-sama7g5-isc.c
rename to drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
index 8b11aa8340d7..01ababdfcbd9 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-sama7g5-isc.c
@@ -397,7 +397,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-	isc->regmap = devm_regmap_init_mmio(dev, io_base, &isc_regmap_config);
+	isc->regmap = devm_regmap_init_mmio(dev, io_base, &atmel_isc_regmap_config);
 	if (IS_ERR(isc->regmap)) {
 		ret = PTR_ERR(isc->regmap);
 		dev_err(dev, "failed to init register map: %d\n", ret);
@@ -408,7 +408,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
+	ret = devm_request_irq(dev, irq, atmel_isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {
 		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
@@ -453,7 +453,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	/* sama7g5-isc : ISPCK does not exist, ISC is clocked by MCK */
 	isc->ispck_required = false;
 
-	ret = isc_pipeline_init(isc);
+	ret = atmel_isc_pipeline_init(isc);
 	if (ret)
 		return ret;
 
@@ -470,7 +470,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = isc_clk_init(isc);
+	ret = atmel_isc_clk_init(isc);
 	if (ret) {
 		dev_err(dev, "failed to init isc clock: %d\n", ret);
 		goto unprepare_hclk;
@@ -513,7 +513,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 			goto cleanup_subdev;
 		}
 
-		subdev_entity->notifier.ops = &isc_async_ops;
+		subdev_entity->notifier.ops = &atmel_isc_async_ops;
 
 		ret = v4l2_async_nf_register(&isc->v4l2_dev,
 					     &subdev_entity->notifier);
@@ -536,7 +536,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	return 0;
 
 cleanup_subdev:
-	isc_subdev_cleanup(isc);
+	atmel_isc_subdev_cleanup(isc);
 
 unregister_v4l2_device:
 	v4l2_device_unregister(&isc->v4l2_dev);
@@ -544,7 +544,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 unprepare_hclk:
 	clk_disable_unprepare(isc->hclock);
 
-	isc_clk_cleanup(isc);
+	atmel_isc_clk_cleanup(isc);
 
 	return ret;
 }
@@ -555,13 +555,13 @@ static int microchip_xisc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	isc_subdev_cleanup(isc);
+	atmel_isc_subdev_cleanup(isc);
 
 	v4l2_device_unregister(&isc->v4l2_dev);
 
 	clk_disable_unprepare(isc->hclock);
 
-	isc_clk_cleanup(isc);
+	atmel_isc_clk_cleanup(isc);
 
 	return 0;
 }
-- 
2.25.1

