Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F96163A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiKBNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiKBNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:15:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15322BE2;
        Wed,  2 Nov 2022 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667394934; x=1698930934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8YcP/KVFQ9U8dvVE/ykoKmyQh7Z0my7Hf1iKzU2y2pk=;
  b=meVaGNSaH8J9N5srbyYxz4MVFCT6gYKvnnnIqMuDIeyZQ6hlC1HDBhVq
   qcidH2W+Dl8UFsLWWFr6nxIvG4GzhFfhvShsECL1HbYbx5o3j1F0LFVq5
   YkiDa7cbQl5UZlztbeZgOotCEyGMwLtmfJEqO6XM4loQRcCdC7KqeUckS
   PM0vMKAMWU1oxoKkeE7iERZ9Tvhxh06eARc/WahQVUuijEWm6N3CBBEbz
   RDuwfZ5XMSWxU8/5+RFw0sp1dU4Ru6d7Y448tmi1+8tlIyB/09vz/TY/8
   AvX8sNxIrjsBNinVZEnEp78ArLpzSn6gqkpM9oAXAz/C3rCOlb5pHvcST
   A==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="187289474"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2022 06:15:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 2 Nov 2022 06:15:31 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 2 Nov 2022 06:15:29 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v11 3/6] media: microchip: re-add ISC driver as Microchip ISC
Date:   Wed, 2 Nov 2022 15:14:57 +0200
Message-ID: <20221102131500.476024-4-eugen.hristev@microchip.com>
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

The Atmel ISC driver was moved to staging to support old users that were
not using the media controller paradigm.
The ISC driver was converted to media controller in the public patch
series:

https://lore.kernel.org/lkml/20220503095127.48710-1-eugen.hristev@microchip.com/T/#m2c320fa8153c01379a1c35b1d90a00903949513a

However the conversion cannot be done directly as it would affect existing
users by breaking the old way of configuration for sama5d2 platforms.

After discussions with the media maintainers, the decision is to move
Atmel ISC to staging as-is, to keep the Kconfig symbols and the users
to the driver in staging. Thus, all the existing users of the non
media-controller paradigm will continue to be happy and use the old config
way.

The converted driver would support both sama5d2 and sama7g5 platforms with
media controller paradigm, but it requires userspace configuration of the
pipeline for all the pipeline modules.

In a simple configuration sensor ==> isc , the old isc driver used to call
subdev s_fmt and control the sensor directly.
This was achieved by having a lot of code inside the driver that was
querying the subdev at probe time and made a list of formats which are
usable.
Basically the user had nothing to configure, as the isc would handle
everything at the top level. This was an easy way to capture, but also came
with the drawback of lack of flexibility.
In a more complicated pipeline
 sensor ==> controller 1 ==> controller 2 ==> isc
this would not be achievable, as controller 1 and controller 2 might be
media-controller configurable, and will not propagate the formats down to
the sensor.
The new driver Microchip ISC would solve all these problems and exposes pads
entities and links to userspace.
For the ease of tracking, the patches that convert to media controller come
on top of this patch that simply readds the driver to the new location under
the new Kconfig symbols.

To differentiate between the old driver and the new driver, I have renamed
the new driver to Microchip ISC, renaming the Kconfig symbols as well, and
all the mentions inside the driver.
The only thing that remains common is the file
include/linux/atmel-isc-media.h which is the ABI for the v4l2 custom
controls that the ISC exposes.
This file is used by both driver, so I kept it as-is.
To further avoid confusion all files have been renamed and all functions
named isc_* as well.
Other than that, I have fixed small checkpatch issues when readding the
driver.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS                                   |    2 +
 drivers/media/platform/microchip/Kconfig      |   42 +
 drivers/media/platform/microchip/Makefile     |    6 +
 .../platform/microchip/microchip-isc-base.c   | 2011 +++++++++++++++++
 .../platform/microchip/microchip-isc-clk.c    |  311 +++
 .../platform/microchip/microchip-isc-regs.h   |  413 ++++
 .../media/platform/microchip/microchip-isc.h  |  362 +++
 .../microchip/microchip-sama5d2-isc.c         |  653 ++++++
 .../microchip/microchip-sama7g5-isc.c         |  616 +++++
 9 files changed, 4416 insertions(+)
 create mode 100644 drivers/media/platform/microchip/microchip-isc-base.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc-clk.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc-regs.h
 create mode 100644 drivers/media/platform/microchip/microchip-isc.h
 create mode 100644 drivers/media/platform/microchip/microchip-sama5d2-isc.c
 create mode 100644 drivers/media/platform/microchip/microchip-sama7g5-isc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a0e1cc80362..4e8850afdcd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13488,6 +13488,8 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/media/atmel,isc.yaml
 F:	Documentation/devicetree/bindings/media/microchip,xisc.yaml
+F:	drivers/media/platform/microchip/microchip-isc*
+F:	drivers/media/platform/microchip/microchip-sama*-isc*
 F:	drivers/staging/media/atmel/atmel-isc*
 F:	drivers/staging/media/atmel/atmel-sama*-isc*
 F:	include/linux/atmel-isc-media.h
diff --git a/drivers/media/platform/microchip/Kconfig b/drivers/media/platform/microchip/Kconfig
index aa9e902f41f0..4f30807aae43 100644
--- a/drivers/media/platform/microchip/Kconfig
+++ b/drivers/media/platform/microchip/Kconfig
@@ -2,6 +2,48 @@
 
 comment "Microchip Technology, Inc. media platform drivers"
 
+config VIDEO_MICROCHIP_ISC
+	tristate "Microchip Image Sensor Controller (ISC) support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && COMMON_CLK
+	depends on ARCH_AT91 || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select REGMAP_MMIO
+	select V4L2_FWNODE
+	select VIDEO_MICROCHIP_ISC_BASE
+	help
+	   This module makes the Microchip Image Sensor Controller available
+	   as a v4l2 device.
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called microchip-isc.
+
+config VIDEO_MICROCHIP_XISC
+	tristate "Microchip eXtended Image Sensor Controller (XISC) support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && COMMON_CLK && VIDEO_V4L2_SUBDEV_API
+	depends on ARCH_AT91 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select REGMAP_MMIO
+	select V4L2_FWNODE
+	select VIDEO_MICROCHIP_ISC_BASE
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	   This module makes the Microchip eXtended Image Sensor Controller
+	   available as a v4l2 device.
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called microchip-xisc.
+
+config VIDEO_MICROCHIP_ISC_BASE
+	tristate
+	default n
+	help
+	  Microchip ISC and XISC common code base.
+
 config VIDEO_MICROCHIP_CSI2DC
 	tristate "Microchip CSI2 Demux Controller"
 	depends on V4L_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/microchip/Makefile b/drivers/media/platform/microchip/Makefile
index cbcde4a73117..498a0fafc1b3 100644
--- a/drivers/media/platform/microchip/Makefile
+++ b/drivers/media/platform/microchip/Makefile
@@ -1,3 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
+microchip-isc-objs = microchip-sama5d2-isc.o
+microchip-xisc-objs = microchip-sama7g5-isc.o
+microchip-isc-common-objs = microchip-isc-base.o microchip-isc-clk.o
 
+obj-$(CONFIG_VIDEO_MICROCHIP_ISC_BASE) += microchip-isc-common.o
+obj-$(CONFIG_VIDEO_MICROCHIP_ISC) += microchip-isc.o
+obj-$(CONFIG_VIDEO_MICROCHIP_XISC) += microchip-xisc.o
 obj-$(CONFIG_VIDEO_MICROCHIP_CSI2DC) += microchip-csi2dc.o
diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
new file mode 100644
index 000000000000..8080cb01b0dd
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -0,0 +1,2011 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Microchip Image Sensor Controller (ISC) common driver base
+ *
+ * Copyright (C) 2016-2019 Microchip Technology, Inc.
+ *
+ * Author: Songjun Wu
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/videodev2.h>
+#include <linux/atmel-isc-media.h>
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-image-sizes.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "microchip-isc-regs.h"
+#include "microchip-isc.h"
+
+static unsigned int debug;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "debug level (0-2)");
+
+static unsigned int sensor_preferred = 1;
+module_param(sensor_preferred, uint, 0644);
+MODULE_PARM_DESC(sensor_preferred,
+		 "Sensor is preferred to output the specified format (1-on 0-off), default 1");
+
+#define ISC_IS_FORMAT_RAW(mbus_code) \
+	(((mbus_code) & 0xf000) == 0x3000)
+
+#define ISC_IS_FORMAT_GREY(mbus_code) \
+	(((mbus_code) == MEDIA_BUS_FMT_Y10_1X10) | \
+	(((mbus_code) == MEDIA_BUS_FMT_Y8_1X8)))
+
+static inline void isc_update_v4l2_ctrls(struct isc_device *isc)
+{
+	struct isc_ctrls *ctrls = &isc->ctrls;
+
+	/* In here we set the v4l2 controls w.r.t. our pipeline config */
+	v4l2_ctrl_s_ctrl(isc->r_gain_ctrl, ctrls->gain[ISC_HIS_CFG_MODE_R]);
+	v4l2_ctrl_s_ctrl(isc->b_gain_ctrl, ctrls->gain[ISC_HIS_CFG_MODE_B]);
+	v4l2_ctrl_s_ctrl(isc->gr_gain_ctrl, ctrls->gain[ISC_HIS_CFG_MODE_GR]);
+	v4l2_ctrl_s_ctrl(isc->gb_gain_ctrl, ctrls->gain[ISC_HIS_CFG_MODE_GB]);
+
+	v4l2_ctrl_s_ctrl(isc->r_off_ctrl, ctrls->offset[ISC_HIS_CFG_MODE_R]);
+	v4l2_ctrl_s_ctrl(isc->b_off_ctrl, ctrls->offset[ISC_HIS_CFG_MODE_B]);
+	v4l2_ctrl_s_ctrl(isc->gr_off_ctrl, ctrls->offset[ISC_HIS_CFG_MODE_GR]);
+	v4l2_ctrl_s_ctrl(isc->gb_off_ctrl, ctrls->offset[ISC_HIS_CFG_MODE_GB]);
+}
+
+static inline void isc_update_awb_ctrls(struct isc_device *isc)
+{
+	struct isc_ctrls *ctrls = &isc->ctrls;
+
+	/* In here we set our actual hw pipeline config */
+
+	regmap_write(isc->regmap, ISC_WB_O_RGR,
+		     ((ctrls->offset[ISC_HIS_CFG_MODE_R])) |
+		     ((ctrls->offset[ISC_HIS_CFG_MODE_GR]) << 16));
+	regmap_write(isc->regmap, ISC_WB_O_BGB,
+		     ((ctrls->offset[ISC_HIS_CFG_MODE_B])) |
+		     ((ctrls->offset[ISC_HIS_CFG_MODE_GB]) << 16));
+	regmap_write(isc->regmap, ISC_WB_G_RGR,
+		     ctrls->gain[ISC_HIS_CFG_MODE_R] |
+		     (ctrls->gain[ISC_HIS_CFG_MODE_GR] << 16));
+	regmap_write(isc->regmap, ISC_WB_G_BGB,
+		     ctrls->gain[ISC_HIS_CFG_MODE_B] |
+		     (ctrls->gain[ISC_HIS_CFG_MODE_GB] << 16));
+}
+
+static inline void isc_reset_awb_ctrls(struct isc_device *isc)
+{
+	unsigned int c;
+
+	for (c = ISC_HIS_CFG_MODE_GR; c <= ISC_HIS_CFG_MODE_B; c++) {
+		/* gains have a fixed point at 9 decimals */
+		isc->ctrls.gain[c] = 1 << 9;
+		/* offsets are in 2's complements */
+		isc->ctrls.offset[c] = 0;
+	}
+}
+
+static int isc_queue_setup(struct vb2_queue *vq,
+			   unsigned int *nbuffers, unsigned int *nplanes,
+			   unsigned int sizes[], struct device *alloc_devs[])
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+	unsigned int size = isc->fmt.fmt.pix.sizeimage;
+
+	if (*nplanes)
+		return sizes[0] < size ? -EINVAL : 0;
+
+	*nplanes = 1;
+	sizes[0] = size;
+
+	return 0;
+}
+
+static int isc_buffer_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct isc_device *isc = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long size = isc->fmt.fmt.pix.sizeimage;
+
+	if (vb2_plane_size(vb, 0) < size) {
+		v4l2_err(&isc->v4l2_dev, "buffer too small (%lu < %lu)\n",
+			 vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb, 0, size);
+
+	vbuf->field = isc->fmt.fmt.pix.field;
+
+	return 0;
+}
+
+static void isc_crop_pfe(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 h, w;
+
+	h = isc->fmt.fmt.pix.height;
+	w = isc->fmt.fmt.pix.width;
+
+	/*
+	 * In case the sensor is not RAW, it will output a pixel (12-16 bits)
+	 * with two samples on the ISC Data bus (which is 8-12)
+	 * ISC will count each sample, so, we need to multiply these values
+	 * by two, to get the real number of samples for the required pixels.
+	 */
+	if (!ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code)) {
+		h <<= 1;
+		w <<= 1;
+	}
+
+	/*
+	 * We limit the column/row count that the ISC will output according
+	 * to the configured resolution that we want.
+	 * This will avoid the situation where the sensor is misconfigured,
+	 * sending more data, and the ISC will just take it and DMA to memory,
+	 * causing corruption.
+	 */
+	regmap_write(regmap, ISC_PFE_CFG1,
+		     (ISC_PFE_CFG1_COLMIN(0) & ISC_PFE_CFG1_COLMIN_MASK) |
+		     (ISC_PFE_CFG1_COLMAX(w - 1) & ISC_PFE_CFG1_COLMAX_MASK));
+
+	regmap_write(regmap, ISC_PFE_CFG2,
+		     (ISC_PFE_CFG2_ROWMIN(0) & ISC_PFE_CFG2_ROWMIN_MASK) |
+		     (ISC_PFE_CFG2_ROWMAX(h - 1) & ISC_PFE_CFG2_ROWMAX_MASK));
+
+	regmap_update_bits(regmap, ISC_PFE_CFG0,
+			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN,
+			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN);
+}
+
+static void isc_start_dma(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 sizeimage = isc->fmt.fmt.pix.sizeimage;
+	u32 dctrl_dview;
+	dma_addr_t addr0;
+
+	addr0 = vb2_dma_contig_plane_dma_addr(&isc->cur_frm->vb.vb2_buf, 0);
+	regmap_write(regmap, ISC_DAD0 + isc->offsets.dma, addr0);
+
+	switch (isc->config.fourcc) {
+	case V4L2_PIX_FMT_YUV420:
+		regmap_write(regmap, ISC_DAD1 + isc->offsets.dma,
+			     addr0 + (sizeimage * 2) / 3);
+		regmap_write(regmap, ISC_DAD2 + isc->offsets.dma,
+			     addr0 + (sizeimage * 5) / 6);
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		regmap_write(regmap, ISC_DAD1 + isc->offsets.dma,
+			     addr0 + sizeimage / 2);
+		regmap_write(regmap, ISC_DAD2 + isc->offsets.dma,
+			     addr0 + (sizeimage * 3) / 4);
+		break;
+	default:
+		break;
+	}
+
+	dctrl_dview = isc->config.dctrl_dview;
+
+	regmap_write(regmap, ISC_DCTRL + isc->offsets.dma,
+		     dctrl_dview | ISC_DCTRL_IE_IS);
+	spin_lock(&isc->awb_lock);
+	regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_CAPTURE);
+	spin_unlock(&isc->awb_lock);
+}
+
+static void isc_set_pipeline(struct isc_device *isc, u32 pipeline)
+{
+	struct regmap *regmap = isc->regmap;
+	struct isc_ctrls *ctrls = &isc->ctrls;
+	u32 val, bay_cfg;
+	const u32 *gamma;
+	unsigned int i;
+
+	/* WB-->CFA-->CC-->GAM-->CSC-->CBC-->SUB422-->SUB420 */
+	for (i = 0; i < ISC_PIPE_LINE_NODE_NUM; i++) {
+		val = pipeline & BIT(i) ? 1 : 0;
+		regmap_field_write(isc->pipeline[i], val);
+	}
+
+	if (!pipeline)
+		return;
+
+	bay_cfg = isc->config.sd_format->cfa_baycfg;
+
+	regmap_write(regmap, ISC_WB_CFG, bay_cfg);
+	isc_update_awb_ctrls(isc);
+	isc_update_v4l2_ctrls(isc);
+
+	regmap_write(regmap, ISC_CFA_CFG, bay_cfg | ISC_CFA_CFG_EITPOL);
+
+	gamma = &isc->gamma_table[ctrls->gamma_index][0];
+	regmap_bulk_write(regmap, ISC_GAM_BENTRY, gamma, GAMMA_ENTRIES);
+	regmap_bulk_write(regmap, ISC_GAM_GENTRY, gamma, GAMMA_ENTRIES);
+	regmap_bulk_write(regmap, ISC_GAM_RENTRY, gamma, GAMMA_ENTRIES);
+
+	isc->config_dpc(isc);
+	isc->config_csc(isc);
+	isc->config_cbc(isc);
+	isc->config_cc(isc);
+	isc->config_gam(isc);
+}
+
+static int isc_update_profile(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 sr;
+	int counter = 100;
+
+	regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_UPPRO);
+
+	regmap_read(regmap, ISC_CTRLSR, &sr);
+	while ((sr & ISC_CTRL_UPPRO) && counter--) {
+		usleep_range(1000, 2000);
+		regmap_read(regmap, ISC_CTRLSR, &sr);
+	}
+
+	if (counter < 0) {
+		v4l2_warn(&isc->v4l2_dev, "Time out to update profile\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void isc_set_histogram(struct isc_device *isc, bool enable)
+{
+	struct regmap *regmap = isc->regmap;
+	struct isc_ctrls *ctrls = &isc->ctrls;
+
+	if (enable) {
+		regmap_write(regmap, ISC_HIS_CFG + isc->offsets.his,
+			     ISC_HIS_CFG_MODE_GR |
+			     (isc->config.sd_format->cfa_baycfg
+					<< ISC_HIS_CFG_BAYSEL_SHIFT) |
+					ISC_HIS_CFG_RAR);
+		regmap_write(regmap, ISC_HIS_CTRL + isc->offsets.his,
+			     ISC_HIS_CTRL_EN);
+		regmap_write(regmap, ISC_INTEN, ISC_INT_HISDONE);
+		ctrls->hist_id = ISC_HIS_CFG_MODE_GR;
+		isc_update_profile(isc);
+		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
+
+		ctrls->hist_stat = HIST_ENABLED;
+	} else {
+		regmap_write(regmap, ISC_INTDIS, ISC_INT_HISDONE);
+		regmap_write(regmap, ISC_HIS_CTRL + isc->offsets.his,
+			     ISC_HIS_CTRL_DIS);
+
+		ctrls->hist_stat = HIST_DISABLED;
+	}
+}
+
+static int isc_configure(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 pfe_cfg0, dcfg, mask, pipeline;
+	struct isc_subdev_entity *subdev = isc->current_subdev;
+
+	pfe_cfg0 = isc->config.sd_format->pfe_cfg0_bps;
+	pipeline = isc->config.bits_pipeline;
+
+	dcfg = isc->config.dcfg_imode | isc->dcfg;
+
+	pfe_cfg0  |= subdev->pfe_cfg0 | ISC_PFE_CFG0_MODE_PROGRESSIVE;
+	mask = ISC_PFE_CFG0_BPS_MASK | ISC_PFE_CFG0_HPOL_LOW |
+	       ISC_PFE_CFG0_VPOL_LOW | ISC_PFE_CFG0_PPOL_LOW |
+	       ISC_PFE_CFG0_MODE_MASK | ISC_PFE_CFG0_CCIR_CRC |
+	       ISC_PFE_CFG0_CCIR656 | ISC_PFE_CFG0_MIPI;
+
+	regmap_update_bits(regmap, ISC_PFE_CFG0, mask, pfe_cfg0);
+
+	isc->config_rlp(isc);
+
+	regmap_write(regmap, ISC_DCFG + isc->offsets.dma, dcfg);
+
+	/* Set the pipeline */
+	isc_set_pipeline(isc, pipeline);
+
+	/*
+	 * The current implemented histogram is available for RAW R, B, GB, GR
+	 * channels. We need to check if sensor is outputting RAW BAYER
+	 */
+	if (isc->ctrls.awb &&
+	    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
+		isc_set_histogram(isc, true);
+	else
+		isc_set_histogram(isc, false);
+
+	/* Update profile */
+	return isc_update_profile(isc);
+}
+
+static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+	struct regmap *regmap = isc->regmap;
+	struct isc_buffer *buf;
+	unsigned long flags;
+	int ret;
+
+	/* Enable stream on the sub device */
+	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
+	if (ret && ret != -ENOIOCTLCMD) {
+		v4l2_err(&isc->v4l2_dev, "stream on failed in subdev %d\n",
+			 ret);
+		goto err_start_stream;
+	}
+
+	ret = pm_runtime_resume_and_get(isc->dev);
+	if (ret < 0) {
+		v4l2_err(&isc->v4l2_dev, "RPM resume failed in subdev %d\n",
+			 ret);
+		goto err_pm_get;
+	}
+
+	ret = isc_configure(isc);
+	if (unlikely(ret))
+		goto err_configure;
+
+	/* Enable DMA interrupt */
+	regmap_write(regmap, ISC_INTEN, ISC_INT_DDONE);
+
+	spin_lock_irqsave(&isc->dma_queue_lock, flags);
+
+	isc->sequence = 0;
+	isc->stop = false;
+	reinit_completion(&isc->comp);
+
+	isc->cur_frm = list_first_entry(&isc->dma_queue,
+					struct isc_buffer, list);
+	list_del(&isc->cur_frm->list);
+
+	isc_crop_pfe(isc);
+	isc_start_dma(isc);
+
+	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
+
+	/* if we streaming from RAW, we can do one-shot white balance adj */
+	if (ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
+		v4l2_ctrl_activate(isc->do_wb_ctrl, true);
+
+	return 0;
+
+err_configure:
+	pm_runtime_put_sync(isc->dev);
+err_pm_get:
+	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
+
+err_start_stream:
+	spin_lock_irqsave(&isc->dma_queue_lock, flags);
+	list_for_each_entry(buf, &isc->dma_queue, list)
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
+	INIT_LIST_HEAD(&isc->dma_queue);
+	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
+
+	return ret;
+}
+
+static void isc_stop_streaming(struct vb2_queue *vq)
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+	unsigned long flags;
+	struct isc_buffer *buf;
+	int ret;
+
+	mutex_lock(&isc->awb_mutex);
+	v4l2_ctrl_activate(isc->do_wb_ctrl, false);
+
+	isc->stop = true;
+
+	/* Wait until the end of the current frame */
+	if (isc->cur_frm && !wait_for_completion_timeout(&isc->comp, 5 * HZ))
+		v4l2_err(&isc->v4l2_dev,
+			 "Timeout waiting for end of the capture\n");
+
+	mutex_unlock(&isc->awb_mutex);
+
+	/* Disable DMA interrupt */
+	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
+
+	pm_runtime_put_sync(isc->dev);
+
+	/* Disable stream on the sub device */
+	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
+	if (ret && ret != -ENOIOCTLCMD)
+		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
+
+	/* Release all active buffers */
+	spin_lock_irqsave(&isc->dma_queue_lock, flags);
+	if (unlikely(isc->cur_frm)) {
+		vb2_buffer_done(&isc->cur_frm->vb.vb2_buf,
+				VB2_BUF_STATE_ERROR);
+		isc->cur_frm = NULL;
+	}
+	list_for_each_entry(buf, &isc->dma_queue, list)
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	INIT_LIST_HEAD(&isc->dma_queue);
+	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
+}
+
+static void isc_buffer_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct isc_buffer *buf = container_of(vbuf, struct isc_buffer, vb);
+	struct isc_device *isc = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long flags;
+
+	spin_lock_irqsave(&isc->dma_queue_lock, flags);
+	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
+	    vb2_start_streaming_called(vb->vb2_queue)) {
+		isc->cur_frm = buf;
+		isc_start_dma(isc);
+	} else {
+		list_add_tail(&buf->list, &isc->dma_queue);
+	}
+	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
+}
+
+static struct isc_format *find_format_by_fourcc(struct isc_device *isc,
+						unsigned int fourcc)
+{
+	unsigned int num_formats = isc->num_user_formats;
+	struct isc_format *fmt;
+	unsigned int i;
+
+	for (i = 0; i < num_formats; i++) {
+		fmt = isc->user_formats[i];
+		if (fmt->fourcc == fourcc)
+			return fmt;
+	}
+
+	return NULL;
+}
+
+static const struct vb2_ops isc_vb2_ops = {
+	.queue_setup		= isc_queue_setup,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+	.buf_prepare		= isc_buffer_prepare,
+	.start_streaming	= isc_start_streaming,
+	.stop_streaming		= isc_stop_streaming,
+	.buf_queue		= isc_buffer_queue,
+};
+
+static int isc_querycap(struct file *file, void *priv,
+			struct v4l2_capability *cap)
+{
+	struct isc_device *isc = video_drvdata(file);
+
+	strscpy(cap->driver, "microchip-isc", sizeof(cap->driver));
+	strscpy(cap->card, "Microchip Image Sensor Controller", sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info),
+		 "platform:%s", isc->v4l2_dev.name);
+
+	return 0;
+}
+
+static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
+				struct v4l2_fmtdesc *f)
+{
+	struct isc_device *isc = video_drvdata(file);
+	u32 index = f->index;
+	u32 i, supported_index;
+
+	if (index < isc->controller_formats_size) {
+		f->pixelformat = isc->controller_formats[index].fourcc;
+		return 0;
+	}
+
+	index -= isc->controller_formats_size;
+
+	supported_index = 0;
+
+	for (i = 0; i < isc->formats_list_size; i++) {
+		if (!ISC_IS_FORMAT_RAW(isc->formats_list[i].mbus_code) ||
+		    !isc->formats_list[i].sd_support)
+			continue;
+		if (supported_index == index) {
+			f->pixelformat = isc->formats_list[i].fourcc;
+			return 0;
+		}
+		supported_index++;
+	}
+
+	return -EINVAL;
+}
+
+static int isc_g_fmt_vid_cap(struct file *file, void *priv,
+			     struct v4l2_format *fmt)
+{
+	struct isc_device *isc = video_drvdata(file);
+
+	*fmt = isc->fmt;
+
+	return 0;
+}
+
+/*
+ * Checks the current configured format, if ISC can output it,
+ * considering which type of format the ISC receives from the sensor
+ */
+static int isc_try_validate_formats(struct isc_device *isc)
+{
+	int ret;
+	bool bayer = false, yuv = false, rgb = false, grey = false;
+
+	/* all formats supported by the RLP module are OK */
+	switch (isc->try_config.fourcc) {
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_SBGGR10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SRGGB10:
+	case V4L2_PIX_FMT_SBGGR12:
+	case V4L2_PIX_FMT_SGBRG12:
+	case V4L2_PIX_FMT_SGRBG12:
+	case V4L2_PIX_FMT_SRGGB12:
+		ret = 0;
+		bayer = true;
+		break;
+
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YUV422P:
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_VYUY:
+		ret = 0;
+		yuv = true;
+		break;
+
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
+	case V4L2_PIX_FMT_ARGB444:
+	case V4L2_PIX_FMT_ARGB555:
+		ret = 0;
+		rgb = true;
+		break;
+	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y10:
+	case V4L2_PIX_FMT_Y16:
+		ret = 0;
+		grey = true;
+		break;
+	default:
+	/* any other different formats are not supported */
+		ret = -EINVAL;
+	}
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
+		 rgb, yuv, grey, bayer);
+
+	/* we cannot output RAW if we do not receive RAW */
+	if ((bayer) && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
+		return -EINVAL;
+
+	/* we cannot output GREY if we do not receive RAW/GREY */
+	if (grey && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code) &&
+	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code))
+		return -EINVAL;
+
+	return ret;
+}
+
+/*
+ * Configures the RLP and DMA modules, depending on the output format
+ * configured for the ISC.
+ * If direct_dump == true, just dump raw data 8/16 bits depending on format.
+ */
+static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
+{
+	isc->try_config.rlp_cfg_mode = 0;
+
+	switch (isc->try_config.fourcc) {
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DAT8;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 8;
+		isc->try_config.bpp_v4l2 = 8;
+		break;
+	case V4L2_PIX_FMT_SBGGR10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SRGGB10:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DAT10;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_SBGGR12:
+	case V4L2_PIX_FMT_SGBRG12:
+	case V4L2_PIX_FMT_SGRBG12:
+	case V4L2_PIX_FMT_SRGGB12:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DAT12;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_RGB565:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_RGB565;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_ARGB444:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB444;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_ARGB555:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB555;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB32;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 32;
+		isc->try_config.bpp_v4l2 = 32;
+		break;
+	case V4L2_PIX_FMT_YUV420:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YYCC;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_YC420P;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PLANAR;
+		isc->try_config.bpp = 12;
+		isc->try_config.bpp_v4l2 = 8; /* only first plane */
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YYCC;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_YC422P;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PLANAR;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 8; /* only first plane */
+		break;
+	case V4L2_PIX_FMT_YUYV:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_YUYV;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_UYVY:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_UYVY;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_VYUY:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_VYUY;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	case V4L2_PIX_FMT_GREY:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DATY8;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 8;
+		isc->try_config.bpp_v4l2 = 8;
+		break;
+	case V4L2_PIX_FMT_Y16:
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DATY10 | ISC_RLP_CFG_LSH;
+		fallthrough;
+	case V4L2_PIX_FMT_Y10:
+		isc->try_config.rlp_cfg_mode |= ISC_RLP_CFG_MODE_DATY10;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (direct_dump) {
+		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DAT8;
+		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
+		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
+		return 0;
+	}
+
+	return 0;
+}
+
+/*
+ * Configuring pipeline modules, depending on which format the ISC outputs
+ * and considering which format it has as input from the sensor.
+ */
+static int isc_try_configure_pipeline(struct isc_device *isc)
+{
+	switch (isc->try_config.fourcc) {
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_ARGB555:
+	case V4L2_PIX_FMT_ARGB444:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
+		/* if sensor format is RAW, we convert inside ISC */
+		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+			isc->try_config.bits_pipeline = CFA_ENABLE |
+				WB_ENABLE | GAM_ENABLES | DPC_BLCENABLE |
+				CC_ENABLE;
+		} else {
+			isc->try_config.bits_pipeline = 0x0;
+		}
+		break;
+	case V4L2_PIX_FMT_YUV420:
+		/* if sensor format is RAW, we convert inside ISC */
+		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+			isc->try_config.bits_pipeline = CFA_ENABLE |
+				CSC_ENABLE | GAM_ENABLES | WB_ENABLE |
+				SUB420_ENABLE | SUB422_ENABLE | CBC_ENABLE |
+				DPC_BLCENABLE;
+		} else {
+			isc->try_config.bits_pipeline = 0x0;
+		}
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		/* if sensor format is RAW, we convert inside ISC */
+		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+			isc->try_config.bits_pipeline = CFA_ENABLE |
+				CSC_ENABLE | WB_ENABLE | GAM_ENABLES |
+				SUB422_ENABLE | CBC_ENABLE | DPC_BLCENABLE;
+		} else {
+			isc->try_config.bits_pipeline = 0x0;
+		}
+		break;
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_VYUY:
+		/* if sensor format is RAW, we convert inside ISC */
+		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+			isc->try_config.bits_pipeline = CFA_ENABLE |
+				CSC_ENABLE | WB_ENABLE | GAM_ENABLES |
+				SUB422_ENABLE | CBC_ENABLE | DPC_BLCENABLE;
+		} else {
+			isc->try_config.bits_pipeline = 0x0;
+		}
+		break;
+	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y16:
+		/* if sensor format is RAW, we convert inside ISC */
+		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+			isc->try_config.bits_pipeline = CFA_ENABLE |
+				CSC_ENABLE | WB_ENABLE | GAM_ENABLES |
+				CBC_ENABLE | DPC_BLCENABLE;
+		} else {
+			isc->try_config.bits_pipeline = 0x0;
+		}
+		break;
+	default:
+		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
+			isc->try_config.bits_pipeline = WB_ENABLE | DPC_BLCENABLE;
+		else
+			isc->try_config.bits_pipeline = 0x0;
+	}
+
+	/* Tune the pipeline to product specific */
+	isc->adapt_pipeline(isc);
+
+	return 0;
+}
+
+static void isc_try_fse(struct isc_device *isc,
+			struct v4l2_subdev_state *sd_state)
+{
+	int ret;
+	struct v4l2_subdev_frame_size_enum fse = {};
+
+	/*
+	 * If we do not know yet which format the subdev is using, we cannot
+	 * do anything.
+	 */
+	if (!isc->try_config.sd_format)
+		return;
+
+	fse.code = isc->try_config.sd_format->mbus_code;
+	fse.which = V4L2_SUBDEV_FORMAT_TRY;
+
+	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, enum_frame_size,
+			       sd_state, &fse);
+	/*
+	 * Attempt to obtain format size from subdev. If not available,
+	 * just use the maximum ISC can receive.
+	 */
+	if (ret) {
+		sd_state->pads->try_crop.width = isc->max_width;
+		sd_state->pads->try_crop.height = isc->max_height;
+	} else {
+		sd_state->pads->try_crop.width = fse.max_width;
+		sd_state->pads->try_crop.height = fse.max_height;
+	}
+}
+
+static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
+		       u32 *code)
+{
+	int i;
+	struct isc_format *sd_fmt = NULL, *direct_fmt = NULL;
+	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
+	struct v4l2_subdev_pad_config pad_cfg = {};
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg
+		};
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_TRY,
+	};
+	u32 mbus_code;
+	int ret;
+	bool rlp_dma_direct_dump = false;
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	/* Step 1: find a RAW format that is supported */
+	for (i = 0; i < isc->num_user_formats; i++) {
+		if (ISC_IS_FORMAT_RAW(isc->user_formats[i]->mbus_code)) {
+			sd_fmt = isc->user_formats[i];
+			break;
+		}
+	}
+	/* Step 2: We can continue with this RAW format, or we can look
+	 * for better: maybe sensor supports directly what we need.
+	 */
+	direct_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
+
+	/* Step 3: We have both. We decide given the module parameter which
+	 * one to use.
+	 */
+	if (direct_fmt && sd_fmt && sensor_preferred)
+		sd_fmt = direct_fmt;
+
+	/* Step 4: we do not have RAW but we have a direct format. Use it. */
+	if (direct_fmt && !sd_fmt)
+		sd_fmt = direct_fmt;
+
+	/* Step 5: if we are using a direct format, we need to package
+	 * everything as 8 bit data and just dump it
+	 */
+	if (sd_fmt == direct_fmt)
+		rlp_dma_direct_dump = true;
+
+	/* Step 6: We have no format. This can happen if the userspace
+	 * requests some weird/invalid format.
+	 * In this case, default to whatever we have
+	 */
+	if (!sd_fmt && !direct_fmt) {
+		sd_fmt = isc->user_formats[isc->num_user_formats - 1];
+		v4l2_dbg(1, debug, &isc->v4l2_dev,
+			 "Sensor not supporting %.4s, using %.4s\n",
+			 (char *)&pixfmt->pixelformat, (char *)&sd_fmt->fourcc);
+	}
+
+	if (!sd_fmt) {
+		ret = -EINVAL;
+		goto isc_try_fmt_err;
+	}
+
+	/* Step 7: Print out what we decided for debugging */
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "Preferring to have sensor using format %.4s\n",
+		 (char *)&sd_fmt->fourcc);
+
+	/* Step 8: at this moment we decided which format the subdev will use */
+	isc->try_config.sd_format = sd_fmt;
+
+	/* Limit to Microchip ISC hardware capabilities */
+	if (pixfmt->width > isc->max_width)
+		pixfmt->width = isc->max_width;
+	if (pixfmt->height > isc->max_height)
+		pixfmt->height = isc->max_height;
+
+	/*
+	 * The mbus format is the one the subdev outputs.
+	 * The pixels will be transferred in this format Sensor -> ISC
+	 */
+	mbus_code = sd_fmt->mbus_code;
+
+	/*
+	 * Validate formats. If the required format is not OK, default to raw.
+	 */
+
+	isc->try_config.fourcc = pixfmt->pixelformat;
+
+	if (isc_try_validate_formats(isc)) {
+		pixfmt->pixelformat = isc->try_config.fourcc = sd_fmt->fourcc;
+		/* Re-try to validate the new format */
+		ret = isc_try_validate_formats(isc);
+		if (ret)
+			goto isc_try_fmt_err;
+	}
+
+	ret = isc_try_configure_rlp_dma(isc, rlp_dma_direct_dump);
+	if (ret)
+		goto isc_try_fmt_err;
+
+	ret = isc_try_configure_pipeline(isc);
+	if (ret)
+		goto isc_try_fmt_err;
+
+	/* Obtain frame sizes if possible to have crop requirements ready */
+	isc_try_fse(isc, &pad_state);
+
+	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
+	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
+			       &pad_state, &format);
+	if (ret < 0)
+		goto isc_try_fmt_subdev_err;
+
+	v4l2_fill_pix_format(pixfmt, &format.format);
+
+	/* Limit to Microchip ISC hardware capabilities */
+	if (pixfmt->width > isc->max_width)
+		pixfmt->width = isc->max_width;
+	if (pixfmt->height > isc->max_height)
+		pixfmt->height = isc->max_height;
+
+	pixfmt->field = V4L2_FIELD_NONE;
+	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
+	pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
+			     pixfmt->height;
+
+	if (code)
+		*code = mbus_code;
+
+	return 0;
+
+isc_try_fmt_err:
+	v4l2_err(&isc->v4l2_dev, "Could not find any possible format for a working pipeline\n");
+isc_try_fmt_subdev_err:
+	memset(&isc->try_config, 0, sizeof(isc->try_config));
+
+	return ret;
+}
+
+static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
+{
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	u32 mbus_code = 0;
+	int ret;
+
+	ret = isc_try_fmt(isc, f, &mbus_code);
+	if (ret)
+		return ret;
+
+	v4l2_fill_mbus_format(&format.format, &f->fmt.pix, mbus_code);
+	ret = v4l2_subdev_call(isc->current_subdev->sd, pad,
+			       set_fmt, NULL, &format);
+	if (ret < 0)
+		return ret;
+
+	/* Limit to Microchip ISC hardware capabilities */
+	if (f->fmt.pix.width > isc->max_width)
+		f->fmt.pix.width = isc->max_width;
+	if (f->fmt.pix.height > isc->max_height)
+		f->fmt.pix.height = isc->max_height;
+
+	isc->fmt = *f;
+
+	if (isc->try_config.sd_format && isc->config.sd_format &&
+	    isc->try_config.sd_format != isc->config.sd_format) {
+		isc->ctrls.hist_stat = HIST_INIT;
+		isc_reset_awb_ctrls(isc);
+		isc_update_v4l2_ctrls(isc);
+	}
+	/* make the try configuration active */
+	isc->config = isc->try_config;
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
+
+	return 0;
+}
+
+static int isc_s_fmt_vid_cap(struct file *file, void *priv,
+			     struct v4l2_format *f)
+{
+	struct isc_device *isc = video_drvdata(file);
+
+	if (vb2_is_busy(&isc->vb2_vidq))
+		return -EBUSY;
+
+	return isc_set_fmt(isc, f);
+}
+
+static int isc_try_fmt_vid_cap(struct file *file, void *priv,
+			       struct v4l2_format *f)
+{
+	struct isc_device *isc = video_drvdata(file);
+
+	return isc_try_fmt(isc, f, NULL);
+}
+
+static int isc_enum_input(struct file *file, void *priv,
+			  struct v4l2_input *inp)
+{
+	if (inp->index != 0)
+		return -EINVAL;
+
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+	inp->std = 0;
+	strscpy(inp->name, "Camera", sizeof(inp->name));
+
+	return 0;
+}
+
+static int isc_g_input(struct file *file, void *priv, unsigned int *i)
+{
+	*i = 0;
+
+	return 0;
+}
+
+static int isc_s_input(struct file *file, void *priv, unsigned int i)
+{
+	if (i > 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int isc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct isc_device *isc = video_drvdata(file);
+
+	return v4l2_g_parm_cap(video_devdata(file), isc->current_subdev->sd, a);
+}
+
+static int isc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct isc_device *isc = video_drvdata(file);
+
+	return v4l2_s_parm_cap(video_devdata(file), isc->current_subdev->sd, a);
+}
+
+static int isc_enum_framesizes(struct file *file, void *fh,
+			       struct v4l2_frmsizeenum *fsize)
+{
+	struct isc_device *isc = video_drvdata(file);
+	int ret = -EINVAL;
+	int i;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	for (i = 0; i < isc->num_user_formats; i++)
+		if (isc->user_formats[i]->fourcc == fsize->pixel_format)
+			ret = 0;
+
+	for (i = 0; i < isc->controller_formats_size; i++)
+		if (isc->controller_formats[i].fourcc == fsize->pixel_format)
+			ret = 0;
+
+	if (ret)
+		return ret;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+
+	fsize->stepwise.min_width = 16;
+	fsize->stepwise.max_width = isc->max_width;
+	fsize->stepwise.min_height = 16;
+	fsize->stepwise.max_height = isc->max_height;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops isc_ioctl_ops = {
+	.vidioc_querycap		= isc_querycap,
+	.vidioc_enum_fmt_vid_cap	= isc_enum_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap		= isc_g_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap		= isc_s_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap		= isc_try_fmt_vid_cap,
+
+	.vidioc_enum_input		= isc_enum_input,
+	.vidioc_g_input			= isc_g_input,
+	.vidioc_s_input			= isc_s_input,
+
+	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
+	.vidioc_querybuf		= vb2_ioctl_querybuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
+	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
+	.vidioc_streamon		= vb2_ioctl_streamon,
+	.vidioc_streamoff		= vb2_ioctl_streamoff,
+
+	.vidioc_g_parm			= isc_g_parm,
+	.vidioc_s_parm			= isc_s_parm,
+	.vidioc_enum_framesizes		= isc_enum_framesizes,
+
+	.vidioc_log_status		= v4l2_ctrl_log_status,
+	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
+};
+
+static int isc_open(struct file *file)
+{
+	struct isc_device *isc = video_drvdata(file);
+	struct v4l2_subdev *sd = isc->current_subdev->sd;
+	int ret;
+
+	if (mutex_lock_interruptible(&isc->lock))
+		return -ERESTARTSYS;
+
+	ret = v4l2_fh_open(file);
+	if (ret < 0)
+		goto unlock;
+
+	if (!v4l2_fh_is_singular_file(file))
+		goto unlock;
+
+	ret = v4l2_subdev_call(sd, core, s_power, 1);
+	if (ret < 0 && ret != -ENOIOCTLCMD) {
+		v4l2_fh_release(file);
+		goto unlock;
+	}
+
+	ret = isc_set_fmt(isc, &isc->fmt);
+	if (ret) {
+		v4l2_subdev_call(sd, core, s_power, 0);
+		v4l2_fh_release(file);
+	}
+
+unlock:
+	mutex_unlock(&isc->lock);
+	return ret;
+}
+
+static int isc_release(struct file *file)
+{
+	struct isc_device *isc = video_drvdata(file);
+	struct v4l2_subdev *sd = isc->current_subdev->sd;
+	bool fh_singular;
+	int ret;
+
+	mutex_lock(&isc->lock);
+
+	fh_singular = v4l2_fh_is_singular_file(file);
+
+	ret = _vb2_fop_release(file, NULL);
+
+	if (fh_singular)
+		v4l2_subdev_call(sd, core, s_power, 0);
+
+	mutex_unlock(&isc->lock);
+
+	return ret;
+}
+
+static const struct v4l2_file_operations isc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= isc_open,
+	.release	= isc_release,
+	.unlocked_ioctl	= video_ioctl2,
+	.read		= vb2_fop_read,
+	.mmap		= vb2_fop_mmap,
+	.poll		= vb2_fop_poll,
+};
+
+irqreturn_t isc_interrupt(int irq, void *dev_id)
+{
+	struct isc_device *isc = (struct isc_device *)dev_id;
+	struct regmap *regmap = isc->regmap;
+	u32 isc_intsr, isc_intmask, pending;
+	irqreturn_t ret = IRQ_NONE;
+
+	regmap_read(regmap, ISC_INTSR, &isc_intsr);
+	regmap_read(regmap, ISC_INTMASK, &isc_intmask);
+
+	pending = isc_intsr & isc_intmask;
+
+	if (likely(pending & ISC_INT_DDONE)) {
+		spin_lock(&isc->dma_queue_lock);
+		if (isc->cur_frm) {
+			struct vb2_v4l2_buffer *vbuf = &isc->cur_frm->vb;
+			struct vb2_buffer *vb = &vbuf->vb2_buf;
+
+			vb->timestamp = ktime_get_ns();
+			vbuf->sequence = isc->sequence++;
+			vb2_buffer_done(vb, VB2_BUF_STATE_DONE);
+			isc->cur_frm = NULL;
+		}
+
+		if (!list_empty(&isc->dma_queue) && !isc->stop) {
+			isc->cur_frm = list_first_entry(&isc->dma_queue,
+							struct isc_buffer, list);
+			list_del(&isc->cur_frm->list);
+
+			isc_start_dma(isc);
+		}
+
+		if (isc->stop)
+			complete(&isc->comp);
+
+		ret = IRQ_HANDLED;
+		spin_unlock(&isc->dma_queue_lock);
+	}
+
+	if (pending & ISC_INT_HISDONE) {
+		schedule_work(&isc->awb_work);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(isc_interrupt);
+
+static void isc_hist_count(struct isc_device *isc, u32 *min, u32 *max)
+{
+	struct regmap *regmap = isc->regmap;
+	struct isc_ctrls *ctrls = &isc->ctrls;
+	u32 *hist_count = &ctrls->hist_count[ctrls->hist_id];
+	u32 *hist_entry = &ctrls->hist_entry[0];
+	u32 i;
+
+	*min = 0;
+	*max = HIST_ENTRIES;
+
+	regmap_bulk_read(regmap, ISC_HIS_ENTRY + isc->offsets.his_entry,
+			 hist_entry, HIST_ENTRIES);
+
+	*hist_count = 0;
+	/*
+	 * we deliberately ignore the end of the histogram,
+	 * the most white pixels
+	 */
+	for (i = 1; i < HIST_ENTRIES; i++) {
+		if (*hist_entry && !*min)
+			*min = i;
+		if (*hist_entry)
+			*max = i;
+		*hist_count += i * (*hist_entry++);
+	}
+
+	if (!*min)
+		*min = 1;
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "isc wb: hist_id %u, hist_count %u",
+		 ctrls->hist_id, *hist_count);
+}
+
+static void isc_wb_update(struct isc_ctrls *ctrls)
+{
+	struct isc_device *isc = container_of(ctrls, struct isc_device, ctrls);
+	u32 *hist_count = &ctrls->hist_count[0];
+	u32 c, offset[4];
+	u64 avg = 0;
+	/* We compute two gains, stretch gain and grey world gain */
+	u32 s_gain[4], gw_gain[4];
+
+	/*
+	 * According to Grey World, we need to set gains for R/B to normalize
+	 * them towards the green channel.
+	 * Thus we want to keep Green as fixed and adjust only Red/Blue
+	 * Compute the average of the both green channels first
+	 */
+	avg = (u64)hist_count[ISC_HIS_CFG_MODE_GR] +
+		(u64)hist_count[ISC_HIS_CFG_MODE_GB];
+	avg >>= 1;
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "isc wb: green components average %llu\n", avg);
+
+	/* Green histogram is null, nothing to do */
+	if (!avg)
+		return;
+
+	for (c = ISC_HIS_CFG_MODE_GR; c <= ISC_HIS_CFG_MODE_B; c++) {
+		/*
+		 * the color offset is the minimum value of the histogram.
+		 * we stretch this color to the full range by substracting
+		 * this value from the color component.
+		 */
+		offset[c] = ctrls->hist_minmax[c][HIST_MIN_INDEX];
+		/*
+		 * The offset is always at least 1. If the offset is 1, we do
+		 * not need to adjust it, so our result must be zero.
+		 * the offset is computed in a histogram on 9 bits (0..512)
+		 * but the offset in register is based on
+		 * 12 bits pipeline (0..4096).
+		 * we need to shift with the 3 bits that the histogram is
+		 * ignoring
+		 */
+		ctrls->offset[c] = (offset[c] - 1) << 3;
+
+		/*
+		 * the offset is then taken and converted to 2's complements,
+		 * and must be negative, as we subtract this value from the
+		 * color components
+		 */
+		ctrls->offset[c] = -ctrls->offset[c];
+
+		/*
+		 * the stretch gain is the total number of histogram bins
+		 * divided by the actual range of color component (Max - Min)
+		 * If we compute gain like this, the actual color component
+		 * will be stretched to the full histogram.
+		 * We need to shift 9 bits for precision, we have 9 bits for
+		 * decimals
+		 */
+		s_gain[c] = (HIST_ENTRIES << 9) /
+			(ctrls->hist_minmax[c][HIST_MAX_INDEX] -
+			ctrls->hist_minmax[c][HIST_MIN_INDEX] + 1);
+
+		/*
+		 * Now we have to compute the gain w.r.t. the average.
+		 * Add/lose gain to the component towards the average.
+		 * If it happens that the component is zero, use the
+		 * fixed point value : 1.0 gain.
+		 */
+		if (hist_count[c])
+			gw_gain[c] = div_u64(avg << 9, hist_count[c]);
+		else
+			gw_gain[c] = 1 << 9;
+
+		v4l2_dbg(1, debug, &isc->v4l2_dev,
+			 "isc wb: component %d, s_gain %u, gw_gain %u\n",
+			 c, s_gain[c], gw_gain[c]);
+		/* multiply both gains and adjust for decimals */
+		ctrls->gain[c] = s_gain[c] * gw_gain[c];
+		ctrls->gain[c] >>= 9;
+
+		/* make sure we are not out of range */
+		ctrls->gain[c] = clamp_val(ctrls->gain[c], 0, GENMASK(12, 0));
+
+		v4l2_dbg(1, debug, &isc->v4l2_dev,
+			 "isc wb: component %d, final gain %u\n",
+			 c, ctrls->gain[c]);
+	}
+}
+
+static void isc_awb_work(struct work_struct *w)
+{
+	struct isc_device *isc =
+		container_of(w, struct isc_device, awb_work);
+	struct regmap *regmap = isc->regmap;
+	struct isc_ctrls *ctrls = &isc->ctrls;
+	u32 hist_id = ctrls->hist_id;
+	u32 baysel;
+	unsigned long flags;
+	u32 min, max;
+	int ret;
+
+	if (ctrls->hist_stat != HIST_ENABLED)
+		return;
+
+	isc_hist_count(isc, &min, &max);
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "isc wb mode %d: hist min %u , max %u\n", hist_id, min, max);
+
+	ctrls->hist_minmax[hist_id][HIST_MIN_INDEX] = min;
+	ctrls->hist_minmax[hist_id][HIST_MAX_INDEX] = max;
+
+	if (hist_id != ISC_HIS_CFG_MODE_B) {
+		hist_id++;
+	} else {
+		isc_wb_update(ctrls);
+		hist_id = ISC_HIS_CFG_MODE_GR;
+	}
+
+	ctrls->hist_id = hist_id;
+	baysel = isc->config.sd_format->cfa_baycfg << ISC_HIS_CFG_BAYSEL_SHIFT;
+
+	ret = pm_runtime_resume_and_get(isc->dev);
+	if (ret < 0)
+		return;
+
+	/*
+	 * only update if we have all the required histograms and controls
+	 * if awb has been disabled, we need to reset registers as well.
+	 */
+	if (hist_id == ISC_HIS_CFG_MODE_GR || ctrls->awb == ISC_WB_NONE) {
+		/*
+		 * It may happen that DMA Done IRQ will trigger while we are
+		 * updating white balance registers here.
+		 * In that case, only parts of the controls have been updated.
+		 * We can avoid that by locking the section.
+		 */
+		spin_lock_irqsave(&isc->awb_lock, flags);
+		isc_update_awb_ctrls(isc);
+		spin_unlock_irqrestore(&isc->awb_lock, flags);
+
+		/*
+		 * if we are doing just the one time white balance adjustment,
+		 * we are basically done.
+		 */
+		if (ctrls->awb == ISC_WB_ONETIME) {
+			v4l2_info(&isc->v4l2_dev,
+				  "Completed one time white-balance adjustment.\n");
+			/* update the v4l2 controls values */
+			isc_update_v4l2_ctrls(isc);
+			ctrls->awb = ISC_WB_NONE;
+		}
+	}
+	regmap_write(regmap, ISC_HIS_CFG + isc->offsets.his,
+		     hist_id | baysel | ISC_HIS_CFG_RAR);
+
+	/*
+	 * We have to make sure the streaming has not stopped meanwhile.
+	 * ISC requires a frame to clock the internal profile update.
+	 * To avoid issues, lock the sequence with a mutex
+	 */
+	mutex_lock(&isc->awb_mutex);
+
+	/* streaming is not active anymore */
+	if (isc->stop) {
+		mutex_unlock(&isc->awb_mutex);
+		return;
+	}
+
+	isc_update_profile(isc);
+
+	mutex_unlock(&isc->awb_mutex);
+
+	/* if awb has been disabled, we don't need to start another histogram */
+	if (ctrls->awb)
+		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
+
+	pm_runtime_put_sync(isc->dev);
+}
+
+static int isc_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct isc_device *isc = container_of(ctrl->handler,
+					     struct isc_device, ctrls.handler);
+	struct isc_ctrls *ctrls = &isc->ctrls;
+
+	if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_BRIGHTNESS:
+		ctrls->brightness = ctrl->val & ISC_CBC_BRIGHT_MASK;
+		break;
+	case V4L2_CID_CONTRAST:
+		ctrls->contrast = ctrl->val & ISC_CBC_CONTRAST_MASK;
+		break;
+	case V4L2_CID_GAMMA:
+		ctrls->gamma_index = ctrl->val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops isc_ctrl_ops = {
+	.s_ctrl	= isc_s_ctrl,
+};
+
+static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct isc_device *isc = container_of(ctrl->handler,
+					     struct isc_device, ctrls.handler);
+	struct isc_ctrls *ctrls = &isc->ctrls;
+
+	if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_AUTO_WHITE_BALANCE:
+		if (ctrl->val == 1)
+			ctrls->awb = ISC_WB_AUTO;
+		else
+			ctrls->awb = ISC_WB_NONE;
+
+		/* configure the controls with new values from v4l2 */
+		if (ctrl->cluster[ISC_CTRL_R_GAIN]->is_new)
+			ctrls->gain[ISC_HIS_CFG_MODE_R] = isc->r_gain_ctrl->val;
+		if (ctrl->cluster[ISC_CTRL_B_GAIN]->is_new)
+			ctrls->gain[ISC_HIS_CFG_MODE_B] = isc->b_gain_ctrl->val;
+		if (ctrl->cluster[ISC_CTRL_GR_GAIN]->is_new)
+			ctrls->gain[ISC_HIS_CFG_MODE_GR] = isc->gr_gain_ctrl->val;
+		if (ctrl->cluster[ISC_CTRL_GB_GAIN]->is_new)
+			ctrls->gain[ISC_HIS_CFG_MODE_GB] = isc->gb_gain_ctrl->val;
+
+		if (ctrl->cluster[ISC_CTRL_R_OFF]->is_new)
+			ctrls->offset[ISC_HIS_CFG_MODE_R] = isc->r_off_ctrl->val;
+		if (ctrl->cluster[ISC_CTRL_B_OFF]->is_new)
+			ctrls->offset[ISC_HIS_CFG_MODE_B] = isc->b_off_ctrl->val;
+		if (ctrl->cluster[ISC_CTRL_GR_OFF]->is_new)
+			ctrls->offset[ISC_HIS_CFG_MODE_GR] = isc->gr_off_ctrl->val;
+		if (ctrl->cluster[ISC_CTRL_GB_OFF]->is_new)
+			ctrls->offset[ISC_HIS_CFG_MODE_GB] = isc->gb_off_ctrl->val;
+
+		isc_update_awb_ctrls(isc);
+
+		mutex_lock(&isc->awb_mutex);
+		if (vb2_is_streaming(&isc->vb2_vidq)) {
+			/*
+			 * If we are streaming, we can update profile to
+			 * have the new settings in place.
+			 */
+			isc_update_profile(isc);
+		} else {
+			/*
+			 * The auto cluster will activate automatically this
+			 * control. This has to be deactivated when not
+			 * streaming.
+			 */
+			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
+		}
+		mutex_unlock(&isc->awb_mutex);
+
+		/* if we have autowhitebalance on, start histogram procedure */
+		if (ctrls->awb == ISC_WB_AUTO &&
+		    vb2_is_streaming(&isc->vb2_vidq) &&
+		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
+			isc_set_histogram(isc, true);
+
+		/*
+		 * for one time whitebalance adjustment, check the button,
+		 * if it's pressed, perform the one time operation.
+		 */
+		if (ctrls->awb == ISC_WB_NONE &&
+		    ctrl->cluster[ISC_CTRL_DO_WB]->is_new &&
+		    !(ctrl->cluster[ISC_CTRL_DO_WB]->flags &
+		    V4L2_CTRL_FLAG_INACTIVE)) {
+			ctrls->awb = ISC_WB_ONETIME;
+			isc_set_histogram(isc, true);
+			v4l2_dbg(1, debug, &isc->v4l2_dev,
+				 "One time white-balance started.\n");
+		}
+		return 0;
+	}
+	return 0;
+}
+
+static int isc_g_volatile_awb_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct isc_device *isc = container_of(ctrl->handler,
+					     struct isc_device, ctrls.handler);
+	struct isc_ctrls *ctrls = &isc->ctrls;
+
+	switch (ctrl->id) {
+	/* being a cluster, this id will be called for every control */
+	case V4L2_CID_AUTO_WHITE_BALANCE:
+		ctrl->cluster[ISC_CTRL_R_GAIN]->val =
+					ctrls->gain[ISC_HIS_CFG_MODE_R];
+		ctrl->cluster[ISC_CTRL_B_GAIN]->val =
+					ctrls->gain[ISC_HIS_CFG_MODE_B];
+		ctrl->cluster[ISC_CTRL_GR_GAIN]->val =
+					ctrls->gain[ISC_HIS_CFG_MODE_GR];
+		ctrl->cluster[ISC_CTRL_GB_GAIN]->val =
+					ctrls->gain[ISC_HIS_CFG_MODE_GB];
+
+		ctrl->cluster[ISC_CTRL_R_OFF]->val =
+			ctrls->offset[ISC_HIS_CFG_MODE_R];
+		ctrl->cluster[ISC_CTRL_B_OFF]->val =
+			ctrls->offset[ISC_HIS_CFG_MODE_B];
+		ctrl->cluster[ISC_CTRL_GR_OFF]->val =
+			ctrls->offset[ISC_HIS_CFG_MODE_GR];
+		ctrl->cluster[ISC_CTRL_GB_OFF]->val =
+			ctrls->offset[ISC_HIS_CFG_MODE_GB];
+		break;
+	}
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops isc_awb_ops = {
+	.s_ctrl = isc_s_awb_ctrl,
+	.g_volatile_ctrl = isc_g_volatile_awb_ctrl,
+};
+
+#define ISC_CTRL_OFF(_name, _id, _name_str) \
+	static const struct v4l2_ctrl_config _name = { \
+		.ops = &isc_awb_ops, \
+		.id = _id, \
+		.name = _name_str, \
+		.type = V4L2_CTRL_TYPE_INTEGER, \
+		.flags = V4L2_CTRL_FLAG_SLIDER, \
+		.min = -4095, \
+		.max = 4095, \
+		.step = 1, \
+		.def = 0, \
+	}
+
+ISC_CTRL_OFF(isc_r_off_ctrl, ISC_CID_R_OFFSET, "Red Component Offset");
+ISC_CTRL_OFF(isc_b_off_ctrl, ISC_CID_B_OFFSET, "Blue Component Offset");
+ISC_CTRL_OFF(isc_gr_off_ctrl, ISC_CID_GR_OFFSET, "Green Red Component Offset");
+ISC_CTRL_OFF(isc_gb_off_ctrl, ISC_CID_GB_OFFSET, "Green Blue Component Offset");
+
+#define ISC_CTRL_GAIN(_name, _id, _name_str) \
+	static const struct v4l2_ctrl_config _name = { \
+		.ops = &isc_awb_ops, \
+		.id = _id, \
+		.name = _name_str, \
+		.type = V4L2_CTRL_TYPE_INTEGER, \
+		.flags = V4L2_CTRL_FLAG_SLIDER, \
+		.min = 0, \
+		.max = 8191, \
+		.step = 1, \
+		.def = 512, \
+	}
+
+ISC_CTRL_GAIN(isc_r_gain_ctrl, ISC_CID_R_GAIN, "Red Component Gain");
+ISC_CTRL_GAIN(isc_b_gain_ctrl, ISC_CID_B_GAIN, "Blue Component Gain");
+ISC_CTRL_GAIN(isc_gr_gain_ctrl, ISC_CID_GR_GAIN, "Green Red Component Gain");
+ISC_CTRL_GAIN(isc_gb_gain_ctrl, ISC_CID_GB_GAIN, "Green Blue Component Gain");
+
+static int isc_ctrl_init(struct isc_device *isc)
+{
+	const struct v4l2_ctrl_ops *ops = &isc_ctrl_ops;
+	struct isc_ctrls *ctrls = &isc->ctrls;
+	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
+	int ret;
+
+	ctrls->hist_stat = HIST_INIT;
+	isc_reset_awb_ctrls(isc);
+
+	ret = v4l2_ctrl_handler_init(hdl, 13);
+	if (ret < 0)
+		return ret;
+
+	/* Initialize product specific controls. For example, contrast */
+	isc->config_ctrls(isc, ops);
+
+	ctrls->brightness = 0;
+
+	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_BRIGHTNESS, -1024, 1023, 1, 0);
+	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAMMA, 0, isc->gamma_max, 1,
+			  isc->gamma_max);
+	isc->awb_ctrl = v4l2_ctrl_new_std(hdl, &isc_awb_ops,
+					  V4L2_CID_AUTO_WHITE_BALANCE,
+					  0, 1, 1, 1);
+
+	/* do_white_balance is a button, so min,max,step,default are ignored */
+	isc->do_wb_ctrl = v4l2_ctrl_new_std(hdl, &isc_awb_ops,
+					    V4L2_CID_DO_WHITE_BALANCE,
+					    0, 0, 0, 0);
+
+	if (!isc->do_wb_ctrl) {
+		ret = hdl->error;
+		v4l2_ctrl_handler_free(hdl);
+		return ret;
+	}
+
+	v4l2_ctrl_activate(isc->do_wb_ctrl, false);
+
+	isc->r_gain_ctrl = v4l2_ctrl_new_custom(hdl, &isc_r_gain_ctrl, NULL);
+	isc->b_gain_ctrl = v4l2_ctrl_new_custom(hdl, &isc_b_gain_ctrl, NULL);
+	isc->gr_gain_ctrl = v4l2_ctrl_new_custom(hdl, &isc_gr_gain_ctrl, NULL);
+	isc->gb_gain_ctrl = v4l2_ctrl_new_custom(hdl, &isc_gb_gain_ctrl, NULL);
+	isc->r_off_ctrl = v4l2_ctrl_new_custom(hdl, &isc_r_off_ctrl, NULL);
+	isc->b_off_ctrl = v4l2_ctrl_new_custom(hdl, &isc_b_off_ctrl, NULL);
+	isc->gr_off_ctrl = v4l2_ctrl_new_custom(hdl, &isc_gr_off_ctrl, NULL);
+	isc->gb_off_ctrl = v4l2_ctrl_new_custom(hdl, &isc_gb_off_ctrl, NULL);
+
+	/*
+	 * The cluster is in auto mode with autowhitebalance enabled
+	 * and manual mode otherwise.
+	 */
+	v4l2_ctrl_auto_cluster(10, &isc->awb_ctrl, 0, true);
+
+	v4l2_ctrl_handler_setup(hdl);
+
+	return 0;
+}
+
+static int isc_async_bound(struct v4l2_async_notifier *notifier,
+			   struct v4l2_subdev *subdev,
+			   struct v4l2_async_subdev *asd)
+{
+	struct isc_device *isc = container_of(notifier->v4l2_dev,
+					      struct isc_device, v4l2_dev);
+	struct isc_subdev_entity *subdev_entity =
+		container_of(notifier, struct isc_subdev_entity, notifier);
+
+	if (video_is_registered(&isc->video_dev)) {
+		v4l2_err(&isc->v4l2_dev, "only supports one sub-device.\n");
+		return -EBUSY;
+	}
+
+	subdev_entity->sd = subdev;
+
+	return 0;
+}
+
+static void isc_async_unbind(struct v4l2_async_notifier *notifier,
+			     struct v4l2_subdev *subdev,
+			     struct v4l2_async_subdev *asd)
+{
+	struct isc_device *isc = container_of(notifier->v4l2_dev,
+					      struct isc_device, v4l2_dev);
+	mutex_destroy(&isc->awb_mutex);
+	cancel_work_sync(&isc->awb_work);
+	video_unregister_device(&isc->video_dev);
+	v4l2_ctrl_handler_free(&isc->ctrls.handler);
+}
+
+static struct isc_format *find_format_by_code(struct isc_device *isc,
+					      unsigned int code, int *index)
+{
+	struct isc_format *fmt = &isc->formats_list[0];
+	unsigned int i;
+
+	for (i = 0; i < isc->formats_list_size; i++) {
+		if (fmt->mbus_code == code) {
+			*index = i;
+			return fmt;
+		}
+
+		fmt++;
+	}
+
+	return NULL;
+}
+
+static int isc_formats_init(struct isc_device *isc)
+{
+	struct isc_format *fmt;
+	struct v4l2_subdev *subdev = isc->current_subdev->sd;
+	unsigned int num_fmts, i, j;
+	u32 list_size = isc->formats_list_size;
+	struct v4l2_subdev_mbus_code_enum mbus_code = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+
+	num_fmts = 0;
+	while (!v4l2_subdev_call(subdev, pad, enum_mbus_code,
+				 NULL, &mbus_code)) {
+		mbus_code.index++;
+
+		fmt = find_format_by_code(isc, mbus_code.code, &i);
+		if (!fmt) {
+			v4l2_warn(&isc->v4l2_dev, "Mbus code %x not supported\n",
+				  mbus_code.code);
+			continue;
+		}
+
+		fmt->sd_support = true;
+		num_fmts++;
+	}
+
+	if (!num_fmts)
+		return -ENXIO;
+
+	isc->num_user_formats = num_fmts;
+	isc->user_formats = devm_kcalloc(isc->dev,
+					 num_fmts, sizeof(*isc->user_formats),
+					 GFP_KERNEL);
+	if (!isc->user_formats)
+		return -ENOMEM;
+
+	fmt = &isc->formats_list[0];
+	for (i = 0, j = 0; i < list_size; i++) {
+		if (fmt->sd_support)
+			isc->user_formats[j++] = fmt;
+		fmt++;
+	}
+
+	return 0;
+}
+
+static int isc_set_default_fmt(struct isc_device *isc)
+{
+	struct v4l2_format f = {
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+		.fmt.pix = {
+			.width		= VGA_WIDTH,
+			.height		= VGA_HEIGHT,
+			.field		= V4L2_FIELD_NONE,
+			.pixelformat	= isc->user_formats[0]->fourcc,
+		},
+	};
+	int ret;
+
+	ret = isc_try_fmt(isc, &f, NULL);
+	if (ret)
+		return ret;
+
+	isc->fmt = f;
+	return 0;
+}
+
+static int isc_async_complete(struct v4l2_async_notifier *notifier)
+{
+	struct isc_device *isc = container_of(notifier->v4l2_dev,
+					      struct isc_device, v4l2_dev);
+	struct video_device *vdev = &isc->video_dev;
+	struct vb2_queue *q = &isc->vb2_vidq;
+	int ret = 0;
+
+	INIT_WORK(&isc->awb_work, isc_awb_work);
+
+	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
+	if (ret < 0) {
+		v4l2_err(&isc->v4l2_dev, "Failed to register subdev nodes\n");
+		return ret;
+	}
+
+	isc->current_subdev = container_of(notifier,
+					   struct isc_subdev_entity, notifier);
+	mutex_init(&isc->lock);
+	mutex_init(&isc->awb_mutex);
+
+	init_completion(&isc->comp);
+
+	/* Initialize videobuf2 queue */
+	q->type			= V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->io_modes		= VB2_MMAP | VB2_DMABUF | VB2_READ;
+	q->drv_priv		= isc;
+	q->buf_struct_size	= sizeof(struct isc_buffer);
+	q->ops			= &isc_vb2_ops;
+	q->mem_ops		= &vb2_dma_contig_memops;
+	q->timestamp_flags	= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock			= &isc->lock;
+	q->min_buffers_needed	= 1;
+	q->dev			= isc->dev;
+
+	ret = vb2_queue_init(q);
+	if (ret < 0) {
+		v4l2_err(&isc->v4l2_dev,
+			 "vb2_queue_init() failed: %d\n", ret);
+		goto isc_async_complete_err;
+	}
+
+	/* Init video dma queues */
+	INIT_LIST_HEAD(&isc->dma_queue);
+	spin_lock_init(&isc->dma_queue_lock);
+	spin_lock_init(&isc->awb_lock);
+
+	ret = isc_formats_init(isc);
+	if (ret < 0) {
+		v4l2_err(&isc->v4l2_dev,
+			 "Init format failed: %d\n", ret);
+		goto isc_async_complete_err;
+	}
+
+	ret = isc_set_default_fmt(isc);
+	if (ret) {
+		v4l2_err(&isc->v4l2_dev, "Could not set default format\n");
+		goto isc_async_complete_err;
+	}
+
+	ret = isc_ctrl_init(isc);
+	if (ret) {
+		v4l2_err(&isc->v4l2_dev, "Init isc ctrols failed: %d\n", ret);
+		goto isc_async_complete_err;
+	}
+
+	/* Register video device */
+	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
+	vdev->release		= video_device_release_empty;
+	vdev->fops		= &isc_fops;
+	vdev->ioctl_ops		= &isc_ioctl_ops;
+	vdev->v4l2_dev		= &isc->v4l2_dev;
+	vdev->vfl_dir		= VFL_DIR_RX;
+	vdev->queue		= q;
+	vdev->lock		= &isc->lock;
+	vdev->ctrl_handler	= &isc->ctrls.handler;
+	vdev->device_caps	= V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
+	video_set_drvdata(vdev, isc);
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		v4l2_err(&isc->v4l2_dev,
+			 "video_register_device failed: %d\n", ret);
+		goto isc_async_complete_err;
+	}
+
+	return 0;
+
+isc_async_complete_err:
+	mutex_destroy(&isc->awb_mutex);
+	mutex_destroy(&isc->lock);
+	return ret;
+}
+
+const struct v4l2_async_notifier_operations isc_async_ops = {
+	.bound = isc_async_bound,
+	.unbind = isc_async_unbind,
+	.complete = isc_async_complete,
+};
+EXPORT_SYMBOL_GPL(isc_async_ops);
+
+void isc_subdev_cleanup(struct isc_device *isc)
+{
+	struct isc_subdev_entity *subdev_entity;
+
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
+		v4l2_async_nf_unregister(&subdev_entity->notifier);
+		v4l2_async_nf_cleanup(&subdev_entity->notifier);
+	}
+
+	INIT_LIST_HEAD(&isc->subdev_entities);
+}
+EXPORT_SYMBOL_GPL(isc_subdev_cleanup);
+
+int isc_pipeline_init(struct isc_device *isc)
+{
+	struct device *dev = isc->dev;
+	struct regmap *regmap = isc->regmap;
+	struct regmap_field *regs;
+	unsigned int i;
+
+	/*
+	 * DPCEN-->GDCEN-->BLCEN-->WB-->CFA-->CC-->
+	 * GAM-->VHXS-->CSC-->CBC-->SUB422-->SUB420
+	 */
+	const struct reg_field regfields[ISC_PIPE_LINE_NODE_NUM] = {
+		REG_FIELD(ISC_DPC_CTRL, 0, 0),
+		REG_FIELD(ISC_DPC_CTRL, 1, 1),
+		REG_FIELD(ISC_DPC_CTRL, 2, 2),
+		REG_FIELD(ISC_WB_CTRL, 0, 0),
+		REG_FIELD(ISC_CFA_CTRL, 0, 0),
+		REG_FIELD(ISC_CC_CTRL, 0, 0),
+		REG_FIELD(ISC_GAM_CTRL, 0, 0),
+		REG_FIELD(ISC_GAM_CTRL, 1, 1),
+		REG_FIELD(ISC_GAM_CTRL, 2, 2),
+		REG_FIELD(ISC_GAM_CTRL, 3, 3),
+		REG_FIELD(ISC_VHXS_CTRL, 0, 0),
+		REG_FIELD(ISC_CSC_CTRL + isc->offsets.csc, 0, 0),
+		REG_FIELD(ISC_CBC_CTRL + isc->offsets.cbc, 0, 0),
+		REG_FIELD(ISC_SUB422_CTRL + isc->offsets.sub422, 0, 0),
+		REG_FIELD(ISC_SUB420_CTRL + isc->offsets.sub420, 0, 0),
+	};
+
+	for (i = 0; i < ISC_PIPE_LINE_NODE_NUM; i++) {
+		regs = devm_regmap_field_alloc(dev, regmap, regfields[i]);
+		if (IS_ERR(regs))
+			return PTR_ERR(regs);
+
+		isc->pipeline[i] =  regs;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(isc_pipeline_init);
+
+/* regmap configuration */
+#define MICROCHIP_ISC_REG_MAX    0xd5c
+const struct regmap_config isc_regmap_config = {
+	.reg_bits       = 32,
+	.reg_stride     = 4,
+	.val_bits       = 32,
+	.max_register	= MICROCHIP_ISC_REG_MAX,
+};
+EXPORT_SYMBOL_GPL(isc_regmap_config);
+
+MODULE_AUTHOR("Songjun Wu");
+MODULE_AUTHOR("Eugen Hristev");
+MODULE_DESCRIPTION("Microchip ISC common code base");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/microchip/microchip-isc-clk.c b/drivers/media/platform/microchip/microchip-isc-clk.c
new file mode 100644
index 000000000000..74742f2d4ad5
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-isc-clk.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Microchip Image Sensor Controller (ISC) common clock driver setup
+ *
+ * Copyright (C) 2016 Microchip Technology, Inc.
+ *
+ * Author: Songjun Wu
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "microchip-isc-regs.h"
+#include "microchip-isc.h"
+
+static int isc_wait_clk_stable(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	struct regmap *regmap = isc_clk->regmap;
+	unsigned long timeout = jiffies + usecs_to_jiffies(1000);
+	unsigned int status;
+
+	while (time_before(jiffies, timeout)) {
+		regmap_read(regmap, ISC_CLKSR, &status);
+		if (!(status & ISC_CLKSR_SIP))
+			return 0;
+
+		usleep_range(10, 250);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int isc_clk_prepare(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(isc_clk->dev);
+	if (ret < 0)
+		return ret;
+
+	return isc_wait_clk_stable(hw);
+}
+
+static void isc_clk_unprepare(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+
+	isc_wait_clk_stable(hw);
+
+	pm_runtime_put_sync(isc_clk->dev);
+}
+
+static int isc_clk_enable(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	u32 id = isc_clk->id;
+	struct regmap *regmap = isc_clk->regmap;
+	unsigned long flags;
+	unsigned int status;
+
+	dev_dbg(isc_clk->dev, "ISC CLK: %s, id = %d, div = %d, parent id = %d\n",
+		__func__, id, isc_clk->div, isc_clk->parent_id);
+
+	spin_lock_irqsave(&isc_clk->lock, flags);
+	regmap_update_bits(regmap, ISC_CLKCFG,
+			   ISC_CLKCFG_DIV_MASK(id) | ISC_CLKCFG_SEL_MASK(id),
+			   (isc_clk->div << ISC_CLKCFG_DIV_SHIFT(id)) |
+			   (isc_clk->parent_id << ISC_CLKCFG_SEL_SHIFT(id)));
+
+	regmap_write(regmap, ISC_CLKEN, ISC_CLK(id));
+	spin_unlock_irqrestore(&isc_clk->lock, flags);
+
+	regmap_read(regmap, ISC_CLKSR, &status);
+	if (status & ISC_CLK(id))
+		return 0;
+	else
+		return -EINVAL;
+}
+
+static void isc_clk_disable(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	u32 id = isc_clk->id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&isc_clk->lock, flags);
+	regmap_write(isc_clk->regmap, ISC_CLKDIS, ISC_CLK(id));
+	spin_unlock_irqrestore(&isc_clk->lock, flags);
+}
+
+static int isc_clk_is_enabled(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	u32 status;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(isc_clk->dev);
+	if (ret < 0)
+		return 0;
+
+	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
+
+	pm_runtime_put_sync(isc_clk->dev);
+
+	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
+}
+
+static unsigned long
+isc_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+
+	return DIV_ROUND_CLOSEST(parent_rate, isc_clk->div + 1);
+}
+
+static int isc_clk_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	long best_rate = -EINVAL;
+	int best_diff = -1;
+	unsigned int i, div;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		struct clk_hw *parent;
+		unsigned long parent_rate;
+
+		parent = clk_hw_get_parent_by_index(hw, i);
+		if (!parent)
+			continue;
+
+		parent_rate = clk_hw_get_rate(parent);
+		if (!parent_rate)
+			continue;
+
+		for (div = 1; div < ISC_CLK_MAX_DIV + 2; div++) {
+			unsigned long rate;
+			int diff;
+
+			rate = DIV_ROUND_CLOSEST(parent_rate, div);
+			diff = abs(req->rate - rate);
+
+			if (best_diff < 0 || best_diff > diff) {
+				best_rate = rate;
+				best_diff = diff;
+				req->best_parent_rate = parent_rate;
+				req->best_parent_hw = parent;
+			}
+
+			if (!best_diff || rate < req->rate)
+				break;
+		}
+
+		if (!best_diff)
+			break;
+	}
+
+	dev_dbg(isc_clk->dev,
+		"ISC CLK: %s, best_rate = %ld, parent clk: %s @ %ld\n",
+		__func__, best_rate,
+		__clk_get_name((req->best_parent_hw)->clk),
+		req->best_parent_rate);
+
+	if (best_rate < 0)
+		return best_rate;
+
+	req->rate = best_rate;
+
+	return 0;
+}
+
+static int isc_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+
+	if (index >= clk_hw_get_num_parents(hw))
+		return -EINVAL;
+
+	isc_clk->parent_id = index;
+
+	return 0;
+}
+
+static u8 isc_clk_get_parent(struct clk_hw *hw)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+
+	return isc_clk->parent_id;
+}
+
+static int isc_clk_set_rate(struct clk_hw *hw,
+			    unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct isc_clk *isc_clk = to_isc_clk(hw);
+	u32 div;
+
+	if (!rate)
+		return -EINVAL;
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if (div > (ISC_CLK_MAX_DIV + 1) || !div)
+		return -EINVAL;
+
+	isc_clk->div = div - 1;
+
+	return 0;
+}
+
+static const struct clk_ops isc_clk_ops = {
+	.prepare	= isc_clk_prepare,
+	.unprepare	= isc_clk_unprepare,
+	.enable		= isc_clk_enable,
+	.disable	= isc_clk_disable,
+	.is_enabled	= isc_clk_is_enabled,
+	.recalc_rate	= isc_clk_recalc_rate,
+	.determine_rate	= isc_clk_determine_rate,
+	.set_parent	= isc_clk_set_parent,
+	.get_parent	= isc_clk_get_parent,
+	.set_rate	= isc_clk_set_rate,
+};
+
+static int isc_clk_register(struct isc_device *isc, unsigned int id)
+{
+	struct regmap *regmap = isc->regmap;
+	struct device_node *np = isc->dev->of_node;
+	struct isc_clk *isc_clk;
+	struct clk_init_data init;
+	const char *clk_name = np->name;
+	const char *parent_names[3];
+	int num_parents;
+
+	if (id == ISC_ISPCK && !isc->ispck_required)
+		return 0;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents < 1 || num_parents > 3)
+		return -EINVAL;
+
+	if (num_parents > 2 && id == ISC_ISPCK)
+		num_parents = 2;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	if (id == ISC_MCK)
+		of_property_read_string(np, "clock-output-names", &clk_name);
+	else
+		clk_name = "isc-ispck";
+
+	init.parent_names	= parent_names;
+	init.num_parents	= num_parents;
+	init.name		= clk_name;
+	init.ops		= &isc_clk_ops;
+	init.flags		= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
+
+	isc_clk = &isc->isc_clks[id];
+	isc_clk->hw.init	= &init;
+	isc_clk->regmap		= regmap;
+	isc_clk->id		= id;
+	isc_clk->dev		= isc->dev;
+	spin_lock_init(&isc_clk->lock);
+
+	isc_clk->clk = clk_register(isc->dev, &isc_clk->hw);
+	if (IS_ERR(isc_clk->clk)) {
+		dev_err(isc->dev, "%s: clock register fail\n", clk_name);
+		return PTR_ERR(isc_clk->clk);
+	} else if (id == ISC_MCK) {
+		of_clk_add_provider(np, of_clk_src_simple_get, isc_clk->clk);
+	}
+
+	return 0;
+}
+
+int isc_clk_init(struct isc_device *isc)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(isc->isc_clks); i++)
+		isc->isc_clks[i].clk = ERR_PTR(-EINVAL);
+
+	for (i = 0; i < ARRAY_SIZE(isc->isc_clks); i++) {
+		ret = isc_clk_register(isc, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(isc_clk_init);
+
+void isc_clk_cleanup(struct isc_device *isc)
+{
+	unsigned int i;
+
+	of_clk_del_provider(isc->dev->of_node);
+
+	for (i = 0; i < ARRAY_SIZE(isc->isc_clks); i++) {
+		struct isc_clk *isc_clk = &isc->isc_clks[i];
+
+		if (!IS_ERR(isc_clk->clk))
+			clk_unregister(isc_clk->clk);
+	}
+}
+EXPORT_SYMBOL_GPL(isc_clk_cleanup);
diff --git a/drivers/media/platform/microchip/microchip-isc-regs.h b/drivers/media/platform/microchip/microchip-isc-regs.h
new file mode 100644
index 000000000000..e77e1d9a1db8
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-isc-regs.h
@@ -0,0 +1,413 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MICROCHIP_ISC_REGS_H
+#define __MICROCHIP_ISC_REGS_H
+
+#include <linux/bitops.h>
+
+/* ISC Control Enable Register 0 */
+#define ISC_CTRLEN      0x00000000
+
+/* ISC Control Disable Register 0 */
+#define ISC_CTRLDIS     0x00000004
+
+/* ISC Control Status Register 0 */
+#define ISC_CTRLSR      0x00000008
+
+#define ISC_CTRL_CAPTURE	BIT(0)
+#define ISC_CTRL_UPPRO		BIT(1)
+#define ISC_CTRL_HISREQ		BIT(2)
+#define ISC_CTRL_HISCLR		BIT(3)
+
+/* ISC Parallel Front End Configuration 0 Register */
+#define ISC_PFE_CFG0    0x0000000c
+
+#define ISC_PFE_CFG0_HPOL_LOW   BIT(0)
+#define ISC_PFE_CFG0_VPOL_LOW   BIT(1)
+#define ISC_PFE_CFG0_PPOL_LOW   BIT(2)
+#define ISC_PFE_CFG0_CCIR656    BIT(9)
+#define ISC_PFE_CFG0_CCIR_CRC   BIT(10)
+#define ISC_PFE_CFG0_MIPI	BIT(14)
+
+#define ISC_PFE_CFG0_MODE_PROGRESSIVE   (0x0 << 4)
+#define ISC_PFE_CFG0_MODE_MASK          GENMASK(6, 4)
+
+#define ISC_PFE_CFG0_BPS_EIGHT  (0x4 << 28)
+#define ISC_PFG_CFG0_BPS_NINE   (0x3 << 28)
+#define ISC_PFG_CFG0_BPS_TEN    (0x2 << 28)
+#define ISC_PFG_CFG0_BPS_ELEVEN (0x1 << 28)
+#define ISC_PFG_CFG0_BPS_TWELVE (0x0 << 28)
+#define ISC_PFE_CFG0_BPS_MASK   GENMASK(30, 28)
+
+#define ISC_PFE_CFG0_COLEN	BIT(12)
+#define ISC_PFE_CFG0_ROWEN	BIT(13)
+
+/* ISC Parallel Front End Configuration 1 Register */
+#define ISC_PFE_CFG1    0x00000010
+
+#define ISC_PFE_CFG1_COLMIN(v)		((v))
+#define ISC_PFE_CFG1_COLMIN_MASK	GENMASK(15, 0)
+#define ISC_PFE_CFG1_COLMAX(v)		((v) << 16)
+#define ISC_PFE_CFG1_COLMAX_MASK	GENMASK(31, 16)
+
+/* ISC Parallel Front End Configuration 2 Register */
+#define ISC_PFE_CFG2    0x00000014
+
+#define ISC_PFE_CFG2_ROWMIN(v)		((v))
+#define ISC_PFE_CFG2_ROWMIN_MASK	GENMASK(15, 0)
+#define ISC_PFE_CFG2_ROWMAX(v)		((v) << 16)
+#define ISC_PFE_CFG2_ROWMAX_MASK	GENMASK(31, 16)
+
+/* ISC Clock Enable Register */
+#define ISC_CLKEN               0x00000018
+
+/* ISC Clock Disable Register */
+#define ISC_CLKDIS              0x0000001c
+
+/* ISC Clock Status Register */
+#define ISC_CLKSR               0x00000020
+#define ISC_CLKSR_SIP		BIT(31)
+
+#define ISC_CLK(n)		BIT(n)
+
+/* ISC Clock Configuration Register */
+#define ISC_CLKCFG              0x00000024
+#define ISC_CLKCFG_DIV_SHIFT(n) ((n) * 16)
+#define ISC_CLKCFG_DIV_MASK(n)  GENMASK(((n) * 16 + 7), (n) * 16)
+#define ISC_CLKCFG_SEL_SHIFT(n) ((n) * 16 + 8)
+#define ISC_CLKCFG_SEL_MASK(n)  GENMASK(((n) * 17 + 8), ((n) * 16 + 8))
+
+/* ISC Interrupt Enable Register */
+#define ISC_INTEN       0x00000028
+
+/* ISC Interrupt Disable Register */
+#define ISC_INTDIS      0x0000002c
+
+/* ISC Interrupt Mask Register */
+#define ISC_INTMASK     0x00000030
+
+/* ISC Interrupt Status Register */
+#define ISC_INTSR       0x00000034
+
+#define ISC_INT_DDONE		BIT(8)
+#define ISC_INT_HISDONE		BIT(12)
+
+/* ISC DPC Control Register */
+#define ISC_DPC_CTRL	0x40
+
+#define ISC_DPC_CTRL_DPCEN	BIT(0)
+#define ISC_DPC_CTRL_GDCEN	BIT(1)
+#define ISC_DPC_CTRL_BLCEN	BIT(2)
+
+/* ISC DPC Config Register */
+#define ISC_DPC_CFG	0x44
+
+#define ISC_DPC_CFG_BAYSEL_SHIFT	0
+
+#define ISC_DPC_CFG_EITPOL		BIT(4)
+
+#define ISC_DPC_CFG_TA_ENABLE		BIT(14)
+#define ISC_DPC_CFG_TC_ENABLE		BIT(13)
+#define ISC_DPC_CFG_TM_ENABLE		BIT(12)
+
+#define ISC_DPC_CFG_RE_MODE		BIT(17)
+
+#define ISC_DPC_CFG_GDCCLP_SHIFT	20
+#define ISC_DPC_CFG_GDCCLP_MASK		GENMASK(22, 20)
+
+#define ISC_DPC_CFG_BLOFF_SHIFT		24
+#define ISC_DPC_CFG_BLOFF_MASK		GENMASK(31, 24)
+
+#define ISC_DPC_CFG_BAYCFG_SHIFT	0
+#define ISC_DPC_CFG_BAYCFG_MASK		GENMASK(1, 0)
+/* ISC DPC Threshold Median Register */
+#define ISC_DPC_THRESHM	0x48
+
+/* ISC DPC Threshold Closest Register */
+#define ISC_DPC_THRESHC	0x4C
+
+/* ISC DPC Threshold Average Register */
+#define ISC_DPC_THRESHA	0x50
+
+/* ISC DPC STatus Register */
+#define ISC_DPC_SR	0x54
+
+/* ISC White Balance Control Register */
+#define ISC_WB_CTRL     0x00000058
+
+/* ISC White Balance Configuration Register */
+#define ISC_WB_CFG      0x0000005c
+
+/* ISC White Balance Offset for R, GR Register */
+#define ISC_WB_O_RGR	0x00000060
+
+/* ISC White Balance Offset for B, GB Register */
+#define ISC_WB_O_BGB	0x00000064
+
+/* ISC White Balance Gain for R, GR Register */
+#define ISC_WB_G_RGR	0x00000068
+
+/* ISC White Balance Gain for B, GB Register */
+#define ISC_WB_G_BGB	0x0000006c
+
+/* ISC Color Filter Array Control Register */
+#define ISC_CFA_CTRL    0x00000070
+
+/* ISC Color Filter Array Configuration Register */
+#define ISC_CFA_CFG     0x00000074
+#define ISC_CFA_CFG_EITPOL	BIT(4)
+
+#define ISC_BAY_CFG_GRGR	0x0
+#define ISC_BAY_CFG_RGRG	0x1
+#define ISC_BAY_CFG_GBGB	0x2
+#define ISC_BAY_CFG_BGBG	0x3
+
+/* ISC Color Correction Control Register */
+#define ISC_CC_CTRL     0x00000078
+
+/* ISC Color Correction RR RG Register */
+#define ISC_CC_RR_RG	0x0000007c
+
+/* ISC Color Correction RB OR Register */
+#define ISC_CC_RB_OR	0x00000080
+
+/* ISC Color Correction GR GG Register */
+#define ISC_CC_GR_GG	0x00000084
+
+/* ISC Color Correction GB OG Register */
+#define ISC_CC_GB_OG	0x00000088
+
+/* ISC Color Correction BR BG Register */
+#define ISC_CC_BR_BG	0x0000008c
+
+/* ISC Color Correction BB OB Register */
+#define ISC_CC_BB_OB	0x00000090
+
+/* ISC Gamma Correction Control Register */
+#define ISC_GAM_CTRL    0x00000094
+
+#define ISC_GAM_CTRL_BIPART	BIT(4)
+
+/* ISC_Gamma Correction Blue Entry Register */
+#define ISC_GAM_BENTRY	0x00000098
+
+/* ISC_Gamma Correction Green Entry Register */
+#define ISC_GAM_GENTRY	0x00000198
+
+/* ISC_Gamma Correction Green Entry Register */
+#define ISC_GAM_RENTRY	0x00000298
+
+/* ISC VHXS Control Register */
+#define ISC_VHXS_CTRL	0x398
+
+/* ISC VHXS Source Size Register */
+#define ISC_VHXS_SS	0x39C
+
+/* ISC VHXS Destination Size Register */
+#define ISC_VHXS_DS	0x3A0
+
+/* ISC Vertical Factor Register */
+#define ISC_VXS_FACT	0x3a4
+
+/* ISC Horizontal Factor Register */
+#define ISC_HXS_FACT	0x3a8
+
+/* ISC Vertical Config Register */
+#define ISC_VXS_CFG	0x3ac
+
+/* ISC Horizontal Config Register */
+#define ISC_HXS_CFG	0x3b0
+
+/* ISC Vertical Tap Register */
+#define ISC_VXS_TAP	0x3b4
+
+/* ISC Horizontal Tap Register */
+#define ISC_HXS_TAP	0x434
+
+/* Offset for CSC register specific to sama5d2 product */
+#define ISC_SAMA5D2_CSC_OFFSET	0
+/* Offset for CSC register specific to sama7g5 product */
+#define ISC_SAMA7G5_CSC_OFFSET	0x11c
+
+/* Color Space Conversion Control Register */
+#define ISC_CSC_CTRL    0x00000398
+
+/* Color Space Conversion YR YG Register */
+#define ISC_CSC_YR_YG	0x0000039c
+
+/* Color Space Conversion YB OY Register */
+#define ISC_CSC_YB_OY	0x000003a0
+
+/* Color Space Conversion CBR CBG Register */
+#define ISC_CSC_CBR_CBG	0x000003a4
+
+/* Color Space Conversion CBB OCB Register */
+#define ISC_CSC_CBB_OCB	0x000003a8
+
+/* Color Space Conversion CRR CRG Register */
+#define ISC_CSC_CRR_CRG	0x000003ac
+
+/* Color Space Conversion CRB OCR Register */
+#define ISC_CSC_CRB_OCR	0x000003b0
+
+/* Offset for CBC register specific to sama5d2 product */
+#define ISC_SAMA5D2_CBC_OFFSET	0
+/* Offset for CBC register specific to sama7g5 product */
+#define ISC_SAMA7G5_CBC_OFFSET	0x11c
+
+/* Contrast And Brightness Control Register */
+#define ISC_CBC_CTRL    0x000003b4
+
+/* Contrast And Brightness Configuration Register */
+#define ISC_CBC_CFG	0x000003b8
+
+/* Brightness Register */
+#define ISC_CBC_BRIGHT	0x000003bc
+#define ISC_CBC_BRIGHT_MASK	GENMASK(10, 0)
+
+/* Contrast Register */
+#define ISC_CBC_CONTRAST	0x000003c0
+#define ISC_CBC_CONTRAST_MASK	GENMASK(11, 0)
+
+/* Hue Register */
+#define ISC_CBCHS_HUE	0x4e0
+/* Saturation Register */
+#define ISC_CBCHS_SAT	0x4e4
+
+/* Offset for SUB422 register specific to sama5d2 product */
+#define ISC_SAMA5D2_SUB422_OFFSET	0
+/* Offset for SUB422 register specific to sama7g5 product */
+#define ISC_SAMA7G5_SUB422_OFFSET	0x124
+
+/* Subsampling 4:4:4 to 4:2:2 Control Register */
+#define ISC_SUB422_CTRL 0x000003c4
+
+/* Offset for SUB420 register specific to sama5d2 product */
+#define ISC_SAMA5D2_SUB420_OFFSET	0
+/* Offset for SUB420 register specific to sama7g5 product */
+#define ISC_SAMA7G5_SUB420_OFFSET	0x124
+/* Subsampling 4:2:2 to 4:2:0 Control Register */
+#define ISC_SUB420_CTRL 0x000003cc
+
+/* Offset for RLP register specific to sama5d2 product */
+#define ISC_SAMA5D2_RLP_OFFSET	0
+/* Offset for RLP register specific to sama7g5 product */
+#define ISC_SAMA7G5_RLP_OFFSET	0x124
+/* Rounding, Limiting and Packing Configuration Register */
+#define ISC_RLP_CFG     0x000003d0
+
+#define ISC_RLP_CFG_MODE_DAT8           0x0
+#define ISC_RLP_CFG_MODE_DAT9           0x1
+#define ISC_RLP_CFG_MODE_DAT10          0x2
+#define ISC_RLP_CFG_MODE_DAT11          0x3
+#define ISC_RLP_CFG_MODE_DAT12          0x4
+#define ISC_RLP_CFG_MODE_DATY8          0x5
+#define ISC_RLP_CFG_MODE_DATY10         0x6
+#define ISC_RLP_CFG_MODE_ARGB444        0x7
+#define ISC_RLP_CFG_MODE_ARGB555        0x8
+#define ISC_RLP_CFG_MODE_RGB565         0x9
+#define ISC_RLP_CFG_MODE_ARGB32         0xa
+#define ISC_RLP_CFG_MODE_YYCC           0xb
+#define ISC_RLP_CFG_MODE_YYCC_LIMITED   0xc
+#define ISC_RLP_CFG_MODE_YCYC           0xd
+#define ISC_RLP_CFG_MODE_MASK           GENMASK(3, 0)
+
+#define ISC_RLP_CFG_LSH			BIT(5)
+
+#define ISC_RLP_CFG_YMODE_YUYV		(3 << 6)
+#define ISC_RLP_CFG_YMODE_YVYU		(2 << 6)
+#define ISC_RLP_CFG_YMODE_VYUY		(0 << 6)
+#define ISC_RLP_CFG_YMODE_UYVY		(1 << 6)
+
+#define ISC_RLP_CFG_YMODE_MASK		GENMASK(7, 6)
+
+/* Offset for HIS register specific to sama5d2 product */
+#define ISC_SAMA5D2_HIS_OFFSET	0
+/* Offset for HIS register specific to sama7g5 product */
+#define ISC_SAMA7G5_HIS_OFFSET	0x124
+/* Histogram Control Register */
+#define ISC_HIS_CTRL	0x000003d4
+
+#define ISC_HIS_CTRL_EN			BIT(0)
+#define ISC_HIS_CTRL_DIS		0x0
+
+/* Histogram Configuration Register */
+#define ISC_HIS_CFG	0x000003d8
+
+#define ISC_HIS_CFG_MODE_GR		0x0
+#define ISC_HIS_CFG_MODE_R		0x1
+#define ISC_HIS_CFG_MODE_GB		0x2
+#define ISC_HIS_CFG_MODE_B		0x3
+#define ISC_HIS_CFG_MODE_Y		0x4
+#define ISC_HIS_CFG_MODE_RAW		0x5
+#define ISC_HIS_CFG_MODE_YCCIR656	0x6
+
+#define ISC_HIS_CFG_BAYSEL_SHIFT	4
+
+#define ISC_HIS_CFG_RAR			BIT(8)
+
+/* Offset for DMA register specific to sama5d2 product */
+#define ISC_SAMA5D2_DMA_OFFSET	0
+/* Offset for DMA register specific to sama7g5 product */
+#define ISC_SAMA7G5_DMA_OFFSET	0x13c
+
+/* DMA Configuration Register */
+#define ISC_DCFG        0x000003e0
+#define ISC_DCFG_IMODE_PACKED8          0x0
+#define ISC_DCFG_IMODE_PACKED16         0x1
+#define ISC_DCFG_IMODE_PACKED32         0x2
+#define ISC_DCFG_IMODE_YC422SP          0x3
+#define ISC_DCFG_IMODE_YC422P           0x4
+#define ISC_DCFG_IMODE_YC420SP          0x5
+#define ISC_DCFG_IMODE_YC420P           0x6
+#define ISC_DCFG_IMODE_MASK             GENMASK(2, 0)
+
+#define ISC_DCFG_YMBSIZE_SINGLE         (0x0 << 4)
+#define ISC_DCFG_YMBSIZE_BEATS4         (0x1 << 4)
+#define ISC_DCFG_YMBSIZE_BEATS8         (0x2 << 4)
+#define ISC_DCFG_YMBSIZE_BEATS16        (0x3 << 4)
+#define ISC_DCFG_YMBSIZE_BEATS32        (0x4 << 4)
+#define ISC_DCFG_YMBSIZE_MASK           GENMASK(6, 4)
+
+#define ISC_DCFG_CMBSIZE_SINGLE         (0x0 << 8)
+#define ISC_DCFG_CMBSIZE_BEATS4         (0x1 << 8)
+#define ISC_DCFG_CMBSIZE_BEATS8         (0x2 << 8)
+#define ISC_DCFG_CMBSIZE_BEATS16        (0x3 << 8)
+#define ISC_DCFG_CMBSIZE_BEATS32        (0x4 << 8)
+#define ISC_DCFG_CMBSIZE_MASK           GENMASK(10, 8)
+
+/* DMA Control Register */
+#define ISC_DCTRL       0x000003e4
+
+#define ISC_DCTRL_DVIEW_PACKED          (0x0 << 1)
+#define ISC_DCTRL_DVIEW_SEMIPLANAR      (0x1 << 1)
+#define ISC_DCTRL_DVIEW_PLANAR          (0x2 << 1)
+#define ISC_DCTRL_DVIEW_MASK            GENMASK(2, 1)
+
+#define ISC_DCTRL_IE_IS			(0x0 << 4)
+
+/* DMA Descriptor Address Register */
+#define ISC_DNDA        0x000003e8
+
+/* DMA Address 0 Register */
+#define ISC_DAD0        0x000003ec
+
+/* DMA Address 1 Register */
+#define ISC_DAD1        0x000003f4
+
+/* DMA Address 2 Register */
+#define ISC_DAD2        0x000003fc
+
+/* Offset for version register specific to sama5d2 product */
+#define ISC_SAMA5D2_VERSION_OFFSET	0
+#define ISC_SAMA7G5_VERSION_OFFSET	0x13c
+/* Version Register */
+#define ISC_VERSION	0x0000040c
+
+/* Offset for version register specific to sama5d2 product */
+#define ISC_SAMA5D2_HIS_ENTRY_OFFSET	0
+/* Offset for version register specific to sama7g5 product */
+#define ISC_SAMA7G5_HIS_ENTRY_OFFSET	0x14c
+/* Histogram Entry */
+#define ISC_HIS_ENTRY	0x00000410
+
+#endif
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
new file mode 100644
index 000000000000..565ccb09ec28
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -0,0 +1,362 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Microchip Image Sensor Controller (ISC) driver header file
+ *
+ * Copyright (C) 2016-2019 Microchip Technology, Inc.
+ *
+ * Author: Songjun Wu
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ */
+#ifndef _MICROCHIP_ISC_H_
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-dma-contig.h>
+
+#define ISC_CLK_MAX_DIV		255
+
+enum isc_clk_id {
+	ISC_ISPCK = 0,
+	ISC_MCK = 1,
+};
+
+struct isc_clk {
+	struct clk_hw   hw;
+	struct clk      *clk;
+	struct regmap   *regmap;
+	spinlock_t	lock;	/* serialize access to clock registers */
+	u8		id;
+	u8		parent_id;
+	u32		div;
+	struct device	*dev;
+};
+
+#define to_isc_clk(v) container_of(v, struct isc_clk, hw)
+
+struct isc_buffer {
+	struct vb2_v4l2_buffer  vb;
+	struct list_head	list;
+};
+
+struct isc_subdev_entity {
+	struct v4l2_subdev		*sd;
+	struct v4l2_async_subdev	*asd;
+	struct device_node		*epn;
+	struct v4l2_async_notifier      notifier;
+
+	u32 pfe_cfg0;
+
+	struct list_head list;
+};
+
+/*
+ * struct isc_format - ISC media bus format information
+			This structure represents the interface between the ISC
+			and the sensor. It's the input format received by
+			the ISC.
+ * @fourcc:		Fourcc code for this format
+ * @mbus_code:		V4L2 media bus format code.
+ * @cfa_baycfg:		If this format is RAW BAYER, indicate the type of bayer.
+			this is either BGBG, RGRG, etc.
+ * @pfe_cfg0_bps:	Number of hardware data lines connected to the ISC
+ */
+
+struct isc_format {
+	u32	fourcc;
+	u32	mbus_code;
+	u32	cfa_baycfg;
+
+	bool	sd_support;
+	u32	pfe_cfg0_bps;
+};
+
+/* Pipeline bitmap */
+#define DPC_DPCENABLE	BIT(0)
+#define DPC_GDCENABLE	BIT(1)
+#define DPC_BLCENABLE	BIT(2)
+#define WB_ENABLE	BIT(3)
+#define CFA_ENABLE	BIT(4)
+#define CC_ENABLE	BIT(5)
+#define GAM_ENABLE	BIT(6)
+#define GAM_BENABLE	BIT(7)
+#define GAM_GENABLE	BIT(8)
+#define GAM_RENABLE	BIT(9)
+#define VHXS_ENABLE	BIT(10)
+#define CSC_ENABLE	BIT(11)
+#define CBC_ENABLE	BIT(12)
+#define SUB422_ENABLE	BIT(13)
+#define SUB420_ENABLE	BIT(14)
+
+#define GAM_ENABLES	(GAM_RENABLE | GAM_GENABLE | GAM_BENABLE | GAM_ENABLE)
+
+/*
+ * struct fmt_config - ISC format configuration and internal pipeline
+			This structure represents the internal configuration
+			of the ISC.
+			It also holds the format that ISC will present to v4l2.
+ * @sd_format:		Pointer to an isc_format struct that holds the sensor
+			configuration.
+ * @fourcc:		Fourcc code for this format.
+ * @bpp:		Bytes per pixel in the current format.
+ * @bpp_v4l2:		Bytes per pixel in the current format, for v4l2.
+			This differs from 'bpp' in the sense that in planar
+			formats, it refers only to the first plane.
+ * @rlp_cfg_mode:	Configuration of the RLP (rounding, limiting packaging)
+ * @dcfg_imode:		Configuration of the input of the DMA module
+ * @dctrl_dview:	Configuration of the output of the DMA module
+ * @bits_pipeline:	Configuration of the pipeline, which modules are enabled
+ */
+struct fmt_config {
+	struct isc_format	*sd_format;
+
+	u32			fourcc;
+	u8			bpp;
+	u8			bpp_v4l2;
+
+	u32			rlp_cfg_mode;
+	u32			dcfg_imode;
+	u32			dctrl_dview;
+
+	u32			bits_pipeline;
+};
+
+#define HIST_ENTRIES		512
+#define HIST_BAYER		(ISC_HIS_CFG_MODE_B + 1)
+
+enum{
+	HIST_INIT = 0,
+	HIST_ENABLED,
+	HIST_DISABLED,
+};
+
+struct isc_ctrls {
+	struct v4l2_ctrl_handler handler;
+
+	u32 brightness;
+	u32 contrast;
+	u8 gamma_index;
+#define ISC_WB_NONE	0
+#define ISC_WB_AUTO	1
+#define ISC_WB_ONETIME	2
+	u8 awb;
+
+	/* one for each component : GR, R, GB, B */
+	u32 gain[HIST_BAYER];
+	s32 offset[HIST_BAYER];
+
+	u32 hist_entry[HIST_ENTRIES];
+	u32 hist_count[HIST_BAYER];
+	u8 hist_id;
+	u8 hist_stat;
+#define HIST_MIN_INDEX		0
+#define HIST_MAX_INDEX		1
+	u32 hist_minmax[HIST_BAYER][2];
+};
+
+#define ISC_PIPE_LINE_NODE_NUM	15
+
+/*
+ * struct isc_reg_offsets - ISC device register offsets
+ * @csc:		Offset for the CSC register
+ * @cbc:		Offset for the CBC register
+ * @sub422:		Offset for the SUB422 register
+ * @sub420:		Offset for the SUB420 register
+ * @rlp:		Offset for the RLP register
+ * @his:		Offset for the HIS related registers
+ * @dma:		Offset for the DMA related registers
+ * @version:		Offset for the version register
+ * @his_entry:		Offset for the HIS entries registers
+ */
+struct isc_reg_offsets {
+	u32 csc;
+	u32 cbc;
+	u32 sub422;
+	u32 sub420;
+	u32 rlp;
+	u32 his;
+	u32 dma;
+	u32 version;
+	u32 his_entry;
+};
+
+/*
+ * struct isc_device - ISC device driver data/config struct
+ * @regmap:		Register map
+ * @hclock:		Hclock clock input (refer datasheet)
+ * @ispck:		iscpck clock (refer datasheet)
+ * @isc_clks:		ISC clocks
+ * @ispck_required:	ISC requires ISP Clock initialization
+ * @dcfg:		DMA master configuration, architecture dependent
+ *
+ * @dev:		Registered device driver
+ * @v4l2_dev:		v4l2 registered device
+ * @video_dev:		registered video device
+ *
+ * @vb2_vidq:		video buffer 2 video queue
+ * @dma_queue_lock:	lock to serialize the dma buffer queue
+ * @dma_queue:		the queue for dma buffers
+ * @cur_frm:		current isc frame/buffer
+ * @sequence:		current frame number
+ * @stop:		true if isc is not streaming, false if streaming
+ * @comp:		completion reference that signals frame completion
+ *
+ * @fmt:		current v42l format
+ * @user_formats:	list of formats that are supported and agreed with sd
+ * @num_user_formats:	how many formats are in user_formats
+ *
+ * @config:		current ISC format configuration
+ * @try_config:		the current ISC try format , not yet activated
+ *
+ * @ctrls:		holds information about ISC controls
+ * @do_wb_ctrl:		control regarding the DO_WHITE_BALANCE button
+ * @awb_work:		workqueue reference for autowhitebalance histogram
+ *			analysis
+ *
+ * @lock:		lock for serializing userspace file operations
+ *			with ISC operations
+ * @awb_mutex:		serialize access to streaming status from awb work queue
+ * @awb_lock:		lock for serializing awb work queue operations
+ *			with DMA/buffer operations
+ *
+ * @pipeline:		configuration of the ISC pipeline
+ *
+ * @current_subdev:	current subdevice: the sensor
+ * @subdev_entities:	list of subdevice entitites
+ *
+ * @gamma_table:	pointer to the table with gamma values, has
+ *			gamma_max sets of GAMMA_ENTRIES entries each
+ * @gamma_max:		maximum number of sets of inside the gamma_table
+ *
+ * @max_width:		maximum frame width, dependent on the internal RAM
+ * @max_height:		maximum frame height, dependent on the internal RAM
+ *
+ * @config_dpc:		pointer to a function that initializes product
+ *			specific DPC module
+ * @config_csc:		pointer to a function that initializes product
+ *			specific CSC module
+ * @config_cbc:		pointer to a function that initializes product
+ *			specific CBC module
+ * @config_cc:		pointer to a function that initializes product
+ *			specific CC module
+ * @config_gam:		pointer to a function that initializes product
+ *			specific GAMMA module
+ * @config_rlp:		pointer to a function that initializes product
+ *			specific RLP module
+ * @config_ctrls:	pointer to a functoin that initializes product
+ *			specific v4l2 controls.
+ *
+ * @adapt_pipeline:	pointer to a function that adapts the pipeline bits
+ *			to the product specific pipeline
+ *
+ * @offsets:		struct holding the product specific register offsets
+ * @controller_formats:	pointer to the array of possible formats that the
+ *			controller can output
+ * @formats_list:	pointer to the array of possible formats that can
+ *			be used as an input to the controller
+ * @controller_formats_size:	size of controller_formats array
+ * @formats_list_size:	size of formats_list array
+ */
+struct isc_device {
+	struct regmap		*regmap;
+	struct clk		*hclock;
+	struct clk		*ispck;
+	struct isc_clk		isc_clks[2];
+	bool			ispck_required;
+	u32			dcfg;
+
+	struct device		*dev;
+	struct v4l2_device	v4l2_dev;
+	struct video_device	video_dev;
+
+	struct vb2_queue	vb2_vidq;
+	spinlock_t		dma_queue_lock;
+	struct list_head	dma_queue;
+	struct isc_buffer	*cur_frm;
+	unsigned int		sequence;
+	bool			stop;
+	struct completion	comp;
+
+	struct v4l2_format	fmt;
+	struct isc_format	**user_formats;
+	unsigned int		num_user_formats;
+
+	struct fmt_config	config;
+	struct fmt_config	try_config;
+
+	struct isc_ctrls	ctrls;
+	struct work_struct	awb_work;
+
+	struct mutex		lock;
+	struct mutex		awb_mutex;
+	spinlock_t		awb_lock;
+
+	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
+
+	struct isc_subdev_entity	*current_subdev;
+	struct list_head		subdev_entities;
+
+	struct {
+#define ISC_CTRL_DO_WB 1
+#define ISC_CTRL_R_GAIN 2
+#define ISC_CTRL_B_GAIN 3
+#define ISC_CTRL_GR_GAIN 4
+#define ISC_CTRL_GB_GAIN 5
+#define ISC_CTRL_R_OFF 6
+#define ISC_CTRL_B_OFF 7
+#define ISC_CTRL_GR_OFF 8
+#define ISC_CTRL_GB_OFF 9
+		struct v4l2_ctrl	*awb_ctrl;
+		struct v4l2_ctrl	*do_wb_ctrl;
+		struct v4l2_ctrl	*r_gain_ctrl;
+		struct v4l2_ctrl	*b_gain_ctrl;
+		struct v4l2_ctrl	*gr_gain_ctrl;
+		struct v4l2_ctrl	*gb_gain_ctrl;
+		struct v4l2_ctrl	*r_off_ctrl;
+		struct v4l2_ctrl	*b_off_ctrl;
+		struct v4l2_ctrl	*gr_off_ctrl;
+		struct v4l2_ctrl	*gb_off_ctrl;
+	};
+
+#define GAMMA_ENTRIES	64
+	/* pointer to the defined gamma table */
+	const u32	(*gamma_table)[GAMMA_ENTRIES];
+	u32		gamma_max;
+
+	u32		max_width;
+	u32		max_height;
+
+	struct {
+		void (*config_dpc)(struct isc_device *isc);
+		void (*config_csc)(struct isc_device *isc);
+		void (*config_cbc)(struct isc_device *isc);
+		void (*config_cc)(struct isc_device *isc);
+		void (*config_gam)(struct isc_device *isc);
+		void (*config_rlp)(struct isc_device *isc);
+
+		void (*config_ctrls)(struct isc_device *isc,
+				     const struct v4l2_ctrl_ops *ops);
+
+		void (*adapt_pipeline)(struct isc_device *isc);
+	};
+
+	struct isc_reg_offsets		offsets;
+	const struct isc_format		*controller_formats;
+	struct isc_format		*formats_list;
+	u32				controller_formats_size;
+	u32				formats_list_size;
+};
+
+extern const struct regmap_config isc_regmap_config;
+extern const struct v4l2_async_notifier_operations isc_async_ops;
+
+irqreturn_t isc_interrupt(int irq, void *dev_id);
+int isc_pipeline_init(struct isc_device *isc);
+int isc_clk_init(struct isc_device *isc);
+void isc_subdev_cleanup(struct isc_device *isc);
+void isc_clk_cleanup(struct isc_device *isc);
+
+#endif
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
new file mode 100644
index 000000000000..5b088fdb2389
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Image Sensor Controller (ISC) driver
+ *
+ * Copyright (C) 2016-2019 Microchip Technology, Inc.
+ *
+ * Author: Songjun Wu
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ *
+ * Sensor-->PFE-->WB-->CFA-->CC-->GAM-->CSC-->CBC-->SUB-->RLP-->DMA
+ *
+ * ISC video pipeline integrates the following submodules:
+ * PFE: Parallel Front End to sample the camera sensor input stream
+ *  WB: Programmable white balance in the Bayer domain
+ * CFA: Color filter array interpolation module
+ *  CC: Programmable color correction
+ * GAM: Gamma correction
+ * CSC: Programmable color space conversion
+ * CBC: Contrast and Brightness control
+ * SUB: This module performs YCbCr444 to YCbCr420 chrominance subsampling
+ * RLP: This module performs rounding, range limiting
+ *      and packing of the incoming data
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/videodev2.h>
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-image-sizes.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "microchip-isc-regs.h"
+#include "microchip-isc.h"
+
+#define ISC_SAMA5D2_MAX_SUPPORT_WIDTH   2592
+#define ISC_SAMA5D2_MAX_SUPPORT_HEIGHT  1944
+
+#define ISC_SAMA5D2_PIPELINE \
+	(WB_ENABLE | CFA_ENABLE | CC_ENABLE | GAM_ENABLES | CSC_ENABLE | \
+	CBC_ENABLE | SUB422_ENABLE | SUB420_ENABLE)
+
+/* This is a list of the formats that the ISC can *output* */
+static const struct isc_format sama5d2_controller_formats[] = {
+	{
+		.fourcc		= V4L2_PIX_FMT_ARGB444,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_ARGB555,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB565,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_ABGR32,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_XBGR32,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUV420,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUYV,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUV422P,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_GREY,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_Y10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+	},
+};
+
+/* This is a list of formats that the ISC can receive as *input* */
+static struct isc_format sama5d2_formats_list[] = {
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_GBGB,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_GRGR,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_GBGB,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_GRGR,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR12,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_GBGB,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_GRGR,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB12,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_GREY,
+		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_YUYV,
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_RGB565,
+		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_LE,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_Y10,
+		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+	},
+
+};
+
+static void isc_sama5d2_config_csc(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	/* Convert RGB to YUV */
+	regmap_write(regmap, ISC_CSC_YR_YG + isc->offsets.csc,
+		     0x42 | (0x81 << 16));
+	regmap_write(regmap, ISC_CSC_YB_OY + isc->offsets.csc,
+		     0x19 | (0x10 << 16));
+	regmap_write(regmap, ISC_CSC_CBR_CBG + isc->offsets.csc,
+		     0xFDA | (0xFB6 << 16));
+	regmap_write(regmap, ISC_CSC_CBB_OCB + isc->offsets.csc,
+		     0x70 | (0x80 << 16));
+	regmap_write(regmap, ISC_CSC_CRR_CRG + isc->offsets.csc,
+		     0x70 | (0xFA2 << 16));
+	regmap_write(regmap, ISC_CSC_CRB_OCR + isc->offsets.csc,
+		     0xFEE | (0x80 << 16));
+}
+
+static void isc_sama5d2_config_cbc(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	regmap_write(regmap, ISC_CBC_BRIGHT + isc->offsets.cbc,
+		     isc->ctrls.brightness);
+	regmap_write(regmap, ISC_CBC_CONTRAST + isc->offsets.cbc,
+		     isc->ctrls.contrast);
+}
+
+static void isc_sama5d2_config_cc(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	/* Configure each register at the neutral fixed point 1.0 or 0.0 */
+	regmap_write(regmap, ISC_CC_RR_RG, (1 << 8));
+	regmap_write(regmap, ISC_CC_RB_OR, 0);
+	regmap_write(regmap, ISC_CC_GR_GG, (1 << 8) << 16);
+	regmap_write(regmap, ISC_CC_GB_OG, 0);
+	regmap_write(regmap, ISC_CC_BR_BG, 0);
+	regmap_write(regmap, ISC_CC_BB_OB, (1 << 8));
+}
+
+static void isc_sama5d2_config_ctrls(struct isc_device *isc,
+				     const struct v4l2_ctrl_ops *ops)
+{
+	struct isc_ctrls *ctrls = &isc->ctrls;
+	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
+
+	ctrls->contrast = 256;
+
+	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_CONTRAST, -2048, 2047, 1, 256);
+}
+
+static void isc_sama5d2_config_dpc(struct isc_device *isc)
+{
+	/* This module is not present on sama5d2 pipeline */
+}
+
+static void isc_sama5d2_config_gam(struct isc_device *isc)
+{
+	/* No specific gamma configuration */
+}
+
+static void isc_sama5d2_config_rlp(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 rlp_mode = isc->config.rlp_cfg_mode;
+
+	/*
+	 * In sama5d2, the YUV planar modes and the YUYV modes are treated
+	 * in the same way in RLP register.
+	 * Normally, YYCC mode should be Luma(n) - Color B(n) - Color R (n)
+	 * and YCYC should be Luma(n + 1) - Color B (n) - Luma (n) - Color R (n)
+	 * but in sama5d2, the YCYC mode does not exist, and YYCC must be
+	 * selected for both planar and interleaved modes, as in fact
+	 * both modes are supported.
+	 *
+	 * Thus, if the YCYC mode is selected, replace it with the
+	 * sama5d2-compliant mode which is YYCC .
+	 */
+	if ((rlp_mode & ISC_RLP_CFG_MODE_MASK) == ISC_RLP_CFG_MODE_YCYC) {
+		rlp_mode &= ~ISC_RLP_CFG_MODE_MASK;
+		rlp_mode |= ISC_RLP_CFG_MODE_YYCC;
+	}
+
+	regmap_update_bits(regmap, ISC_RLP_CFG + isc->offsets.rlp,
+			   ISC_RLP_CFG_MODE_MASK, rlp_mode);
+}
+
+static void isc_sama5d2_adapt_pipeline(struct isc_device *isc)
+{
+	isc->try_config.bits_pipeline &= ISC_SAMA5D2_PIPELINE;
+}
+
+/* Gamma table with gamma 1/2.2 */
+static const u32 isc_sama5d2_gamma_table[][GAMMA_ENTRIES] = {
+	/* 0 --> gamma 1/1.8 */
+	{      0x65,  0x66002F,  0x950025,  0xBB0020,  0xDB001D,  0xF8001A,
+	  0x1130018, 0x12B0017, 0x1420016, 0x1580014, 0x16D0013, 0x1810012,
+	  0x1940012, 0x1A60012, 0x1B80011, 0x1C90010, 0x1DA0010, 0x1EA000F,
+	  0x1FA000F, 0x209000F, 0x218000F, 0x227000E, 0x235000E, 0x243000E,
+	  0x251000E, 0x25F000D, 0x26C000D, 0x279000D, 0x286000D, 0x293000C,
+	  0x2A0000C, 0x2AC000C, 0x2B8000C, 0x2C4000C, 0x2D0000B, 0x2DC000B,
+	  0x2E7000B, 0x2F3000B, 0x2FE000B, 0x309000B, 0x314000B, 0x31F000A,
+	  0x32A000A, 0x334000B, 0x33F000A, 0x349000A, 0x354000A, 0x35E000A,
+	  0x368000A, 0x372000A, 0x37C000A, 0x386000A, 0x3900009, 0x399000A,
+	  0x3A30009, 0x3AD0009, 0x3B60009, 0x3BF000A, 0x3C90009, 0x3D20009,
+	  0x3DB0009, 0x3E40009, 0x3ED0009, 0x3F60009 },
+
+	/* 1 --> gamma 1/2 */
+	{      0x7F,  0x800034,  0xB50028,  0xDE0021, 0x100001E, 0x11E001B,
+	  0x1390019, 0x1520017, 0x16A0015, 0x1800014, 0x1940014, 0x1A80013,
+	  0x1BB0012, 0x1CD0011, 0x1DF0010, 0x1EF0010, 0x200000F, 0x20F000F,
+	  0x21F000E, 0x22D000F, 0x23C000E, 0x24A000E, 0x258000D, 0x265000D,
+	  0x273000C, 0x27F000D, 0x28C000C, 0x299000C, 0x2A5000C, 0x2B1000B,
+	  0x2BC000C, 0x2C8000B, 0x2D3000C, 0x2DF000B, 0x2EA000A, 0x2F5000A,
+	  0x2FF000B, 0x30A000A, 0x314000B, 0x31F000A, 0x329000A, 0x333000A,
+	  0x33D0009, 0x3470009, 0x350000A, 0x35A0009, 0x363000A, 0x36D0009,
+	  0x3760009, 0x37F0009, 0x3880009, 0x3910009, 0x39A0009, 0x3A30009,
+	  0x3AC0008, 0x3B40009, 0x3BD0008, 0x3C60008, 0x3CE0008, 0x3D60009,
+	  0x3DF0008, 0x3E70008, 0x3EF0008, 0x3F70008 },
+
+	/* 2 --> gamma 1/2.2 */
+	{      0x99,  0x9B0038,  0xD4002A,  0xFF0023, 0x122001F, 0x141001B,
+	  0x15D0019, 0x1760017, 0x18E0015, 0x1A30015, 0x1B80013, 0x1CC0012,
+	  0x1DE0011, 0x1F00010, 0x2010010, 0x2110010, 0x221000F, 0x230000F,
+	  0x23F000E, 0x24D000E, 0x25B000D, 0x269000C, 0x276000C, 0x283000C,
+	  0x28F000C, 0x29B000C, 0x2A7000C, 0x2B3000B, 0x2BF000B, 0x2CA000B,
+	  0x2D5000B, 0x2E0000A, 0x2EB000A, 0x2F5000A, 0x2FF000A, 0x30A000A,
+	  0x3140009, 0x31E0009, 0x327000A, 0x3310009, 0x33A0009, 0x3440009,
+	  0x34D0009, 0x3560009, 0x35F0009, 0x3680008, 0x3710008, 0x3790009,
+	  0x3820008, 0x38A0008, 0x3930008, 0x39B0008, 0x3A30008, 0x3AB0008,
+	  0x3B30008, 0x3BB0008, 0x3C30008, 0x3CB0007, 0x3D20008, 0x3DA0007,
+	  0x3E20007, 0x3E90007, 0x3F00008, 0x3F80007 },
+};
+
+static int isc_parse_dt(struct device *dev, struct isc_device *isc)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *epn = NULL;
+	struct isc_subdev_entity *subdev_entity;
+	unsigned int flags;
+	int ret;
+
+	INIT_LIST_HEAD(&isc->subdev_entities);
+
+	while (1) {
+		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
+
+		epn = of_graph_get_next_endpoint(np, epn);
+		if (!epn)
+			return 0;
+
+		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
+						 &v4l2_epn);
+		if (ret) {
+			ret = -EINVAL;
+			dev_err(dev, "Could not parse the endpoint\n");
+			break;
+		}
+
+		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
+					     GFP_KERNEL);
+		if (!subdev_entity) {
+			ret = -ENOMEM;
+			break;
+		}
+		subdev_entity->epn = epn;
+
+		flags = v4l2_epn.bus.parallel.flags;
+
+		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+			subdev_entity->pfe_cfg0 = ISC_PFE_CFG0_HPOL_LOW;
+
+		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_VPOL_LOW;
+
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_PPOL_LOW;
+
+		if (v4l2_epn.bus_type == V4L2_MBUS_BT656)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_CCIR_CRC |
+					ISC_PFE_CFG0_CCIR656;
+
+		list_add_tail(&subdev_entity->list, &isc->subdev_entities);
+	}
+	of_node_put(epn);
+
+	return ret;
+}
+
+static int microchip_isc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct isc_device *isc;
+	struct resource *res;
+	void __iomem *io_base;
+	struct isc_subdev_entity *subdev_entity;
+	int irq;
+	int ret;
+	u32 ver;
+
+	isc = devm_kzalloc(dev, sizeof(*isc), GFP_KERNEL);
+	if (!isc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, isc);
+	isc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	io_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	isc->regmap = devm_regmap_init_mmio(dev, io_base, &isc_regmap_config);
+	if (IS_ERR(isc->regmap)) {
+		ret = PTR_ERR(isc->regmap);
+		dev_err(dev, "failed to init register map: %d\n", ret);
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
+			       "microchip-sama5d2-isc", isc);
+	if (ret < 0) {
+		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
+			irq, ret);
+		return ret;
+	}
+
+	isc->gamma_table = isc_sama5d2_gamma_table;
+	isc->gamma_max = 2;
+
+	isc->max_width = ISC_SAMA5D2_MAX_SUPPORT_WIDTH;
+	isc->max_height = ISC_SAMA5D2_MAX_SUPPORT_HEIGHT;
+
+	isc->config_dpc = isc_sama5d2_config_dpc;
+	isc->config_csc = isc_sama5d2_config_csc;
+	isc->config_cbc = isc_sama5d2_config_cbc;
+	isc->config_cc = isc_sama5d2_config_cc;
+	isc->config_gam = isc_sama5d2_config_gam;
+	isc->config_rlp = isc_sama5d2_config_rlp;
+	isc->config_ctrls = isc_sama5d2_config_ctrls;
+
+	isc->adapt_pipeline = isc_sama5d2_adapt_pipeline;
+
+	isc->offsets.csc = ISC_SAMA5D2_CSC_OFFSET;
+	isc->offsets.cbc = ISC_SAMA5D2_CBC_OFFSET;
+	isc->offsets.sub422 = ISC_SAMA5D2_SUB422_OFFSET;
+	isc->offsets.sub420 = ISC_SAMA5D2_SUB420_OFFSET;
+	isc->offsets.rlp = ISC_SAMA5D2_RLP_OFFSET;
+	isc->offsets.his = ISC_SAMA5D2_HIS_OFFSET;
+	isc->offsets.dma = ISC_SAMA5D2_DMA_OFFSET;
+	isc->offsets.version = ISC_SAMA5D2_VERSION_OFFSET;
+	isc->offsets.his_entry = ISC_SAMA5D2_HIS_ENTRY_OFFSET;
+
+	isc->controller_formats = sama5d2_controller_formats;
+	isc->controller_formats_size = ARRAY_SIZE(sama5d2_controller_formats);
+	isc->formats_list = sama5d2_formats_list;
+	isc->formats_list_size = ARRAY_SIZE(sama5d2_formats_list);
+
+	/* sama5d2-isc - 8 bits per beat */
+	isc->dcfg = ISC_DCFG_YMBSIZE_BEATS8 | ISC_DCFG_CMBSIZE_BEATS8;
+
+	/* sama5d2-isc : ISPCK is required and mandatory */
+	isc->ispck_required = true;
+
+	ret = isc_pipeline_init(isc);
+	if (ret)
+		return ret;
+
+	isc->hclock = devm_clk_get(dev, "hclock");
+	if (IS_ERR(isc->hclock)) {
+		ret = PTR_ERR(isc->hclock);
+		dev_err(dev, "failed to get hclock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(isc->hclock);
+	if (ret) {
+		dev_err(dev, "failed to enable hclock: %d\n", ret);
+		return ret;
+	}
+
+	ret = isc_clk_init(isc);
+	if (ret) {
+		dev_err(dev, "failed to init isc clock: %d\n", ret);
+		goto unprepare_hclk;
+	}
+	ret = v4l2_device_register(dev, &isc->v4l2_dev);
+	if (ret) {
+		dev_err(dev, "unable to register v4l2 device.\n");
+		goto unprepare_clk;
+	}
+
+	ret = isc_parse_dt(dev, isc);
+	if (ret) {
+		dev_err(dev, "fail to parse device tree\n");
+		goto unregister_v4l2_device;
+	}
+
+	if (list_empty(&isc->subdev_entities)) {
+		dev_err(dev, "no subdev found\n");
+		ret = -ENODEV;
+		goto unregister_v4l2_device;
+	}
+
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
+		struct v4l2_async_subdev *asd;
+		struct fwnode_handle *fwnode =
+			of_fwnode_handle(subdev_entity->epn);
+
+		v4l2_async_nf_init(&subdev_entity->notifier);
+
+		asd = v4l2_async_nf_add_fwnode_remote(&subdev_entity->notifier,
+						      fwnode,
+						      struct v4l2_async_subdev);
+
+		of_node_put(subdev_entity->epn);
+		subdev_entity->epn = NULL;
+
+		if (IS_ERR(asd)) {
+			ret = PTR_ERR(asd);
+			goto cleanup_subdev;
+		}
+
+		subdev_entity->notifier.ops = &isc_async_ops;
+
+		ret = v4l2_async_nf_register(&isc->v4l2_dev,
+					     &subdev_entity->notifier);
+		if (ret) {
+			dev_err(dev, "fail to register async notifier\n");
+			goto cleanup_subdev;
+		}
+
+		if (video_is_registered(&isc->video_dev))
+			break;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_request_idle(dev);
+
+	isc->ispck = isc->isc_clks[ISC_ISPCK].clk;
+
+	ret = clk_prepare_enable(isc->ispck);
+	if (ret) {
+		dev_err(dev, "failed to enable ispck: %d\n", ret);
+		goto disable_pm;
+	}
+
+	/* ispck should be greater or equal to hclock */
+	ret = clk_set_rate(isc->ispck, clk_get_rate(isc->hclock));
+	if (ret) {
+		dev_err(dev, "failed to set ispck rate: %d\n", ret);
+		goto unprepare_clk;
+	}
+
+	regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
+	dev_info(dev, "Microchip ISC version %x\n", ver);
+
+	return 0;
+
+unprepare_clk:
+	clk_disable_unprepare(isc->ispck);
+
+disable_pm:
+	pm_runtime_disable(dev);
+
+cleanup_subdev:
+	isc_subdev_cleanup(isc);
+
+unregister_v4l2_device:
+	v4l2_device_unregister(&isc->v4l2_dev);
+
+unprepare_hclk:
+	clk_disable_unprepare(isc->hclock);
+
+	isc_clk_cleanup(isc);
+
+	return ret;
+}
+
+static int microchip_isc_remove(struct platform_device *pdev)
+{
+	struct isc_device *isc = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	isc_subdev_cleanup(isc);
+
+	v4l2_device_unregister(&isc->v4l2_dev);
+
+	clk_disable_unprepare(isc->ispck);
+	clk_disable_unprepare(isc->hclock);
+
+	isc_clk_cleanup(isc);
+
+	return 0;
+}
+
+static int __maybe_unused isc_runtime_suspend(struct device *dev)
+{
+	struct isc_device *isc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(isc->ispck);
+	clk_disable_unprepare(isc->hclock);
+
+	return 0;
+}
+
+static int __maybe_unused isc_runtime_resume(struct device *dev)
+{
+	struct isc_device *isc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(isc->hclock);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(isc->ispck);
+	if (ret)
+		clk_disable_unprepare(isc->hclock);
+
+	return ret;
+}
+
+static const struct dev_pm_ops microchip_isc_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(isc_runtime_suspend, isc_runtime_resume, NULL)
+};
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id microchip_isc_of_match[] = {
+	{ .compatible = "atmel,sama5d2-isc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, microchip_isc_of_match);
+#endif
+
+static struct platform_driver microchip_isc_driver = {
+	.probe	= microchip_isc_probe,
+	.remove	= microchip_isc_remove,
+	.driver	= {
+		.name		= "microchip-sama5d2-isc",
+		.pm		= &microchip_isc_dev_pm_ops,
+		.of_match_table = of_match_ptr(microchip_isc_of_match),
+	},
+};
+
+module_platform_driver(microchip_isc_driver);
+
+MODULE_AUTHOR("Songjun Wu");
+MODULE_DESCRIPTION("The V4L2 driver for Microchip-ISC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
new file mode 100644
index 000000000000..1f3774dde12d
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip eXtended Image Sensor Controller (XISC) driver
+ *
+ * Copyright (C) 2019-2021 Microchip Technology, Inc. and its subsidiaries
+ *
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ * Sensor-->PFE-->DPC-->WB-->CFA-->CC-->GAM-->VHXS-->CSC-->CBHS-->SUB-->RLP-->DMA-->HIS
+ *
+ * ISC video pipeline integrates the following submodules:
+ * PFE: Parallel Front End to sample the camera sensor input stream
+ * DPC: Defective Pixel Correction with black offset correction, green disparity
+ *      correction and defective pixel correction (3 modules total)
+ *  WB: Programmable white balance in the Bayer domain
+ * CFA: Color filter array interpolation module
+ *  CC: Programmable color correction
+ * GAM: Gamma correction
+ *VHXS: Vertical and Horizontal Scaler
+ * CSC: Programmable color space conversion
+ *CBHS: Contrast Brightness Hue and Saturation control
+ * SUB: This module performs YCbCr444 to YCbCr420 chrominance subsampling
+ * RLP: This module performs rounding, range limiting
+ *      and packing of the incoming data
+ * DMA: This module performs DMA master accesses to write frames to external RAM
+ * HIS: Histogram module performs statistic counters on the frames
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/videodev2.h>
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-image-sizes.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "microchip-isc-regs.h"
+#include "microchip-isc.h"
+
+#define ISC_SAMA7G5_MAX_SUPPORT_WIDTH   3264
+#define ISC_SAMA7G5_MAX_SUPPORT_HEIGHT  2464
+
+#define ISC_SAMA7G5_PIPELINE \
+	(WB_ENABLE | CFA_ENABLE | CC_ENABLE | GAM_ENABLES | CSC_ENABLE | \
+	CBC_ENABLE | SUB422_ENABLE | SUB420_ENABLE)
+
+/* This is a list of the formats that the ISC can *output* */
+static const struct isc_format sama7g5_controller_formats[] = {
+	{
+		.fourcc		= V4L2_PIX_FMT_ARGB444,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_ARGB555,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB565,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_ABGR32,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_XBGR32,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUV420,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_UYVY,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_VYUY,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUYV,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUV422P,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_GREY,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_Y10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_Y16,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+	},
+};
+
+/* This is a list of formats that the ISC can receive as *input* */
+static struct isc_format sama7g5_formats_list[] = {
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_GBGB,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_GRGR,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_GBGB,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_GRGR,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR12,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_GBGB,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_GRGR,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB12,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TWELVE,
+		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_GREY,
+		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_YUYV,
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_UYVY,
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_RGB565,
+		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_LE,
+		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_Y10,
+		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
+		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
+	},
+};
+
+static void isc_sama7g5_config_csc(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	/* Convert RGB to YUV */
+	regmap_write(regmap, ISC_CSC_YR_YG + isc->offsets.csc,
+		     0x42 | (0x81 << 16));
+	regmap_write(regmap, ISC_CSC_YB_OY + isc->offsets.csc,
+		     0x19 | (0x10 << 16));
+	regmap_write(regmap, ISC_CSC_CBR_CBG + isc->offsets.csc,
+		     0xFDA | (0xFB6 << 16));
+	regmap_write(regmap, ISC_CSC_CBB_OCB + isc->offsets.csc,
+		     0x70 | (0x80 << 16));
+	regmap_write(regmap, ISC_CSC_CRR_CRG + isc->offsets.csc,
+		     0x70 | (0xFA2 << 16));
+	regmap_write(regmap, ISC_CSC_CRB_OCR + isc->offsets.csc,
+		     0xFEE | (0x80 << 16));
+}
+
+static void isc_sama7g5_config_cbc(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	/* Configure what is set via v4l2 ctrls */
+	regmap_write(regmap, ISC_CBC_BRIGHT + isc->offsets.cbc, isc->ctrls.brightness);
+	regmap_write(regmap, ISC_CBC_CONTRAST + isc->offsets.cbc, isc->ctrls.contrast);
+	/* Configure Hue and Saturation as neutral midpoint */
+	regmap_write(regmap, ISC_CBCHS_HUE, 0);
+	regmap_write(regmap, ISC_CBCHS_SAT, (1 << 4));
+}
+
+static void isc_sama7g5_config_cc(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	/* Configure each register at the neutral fixed point 1.0 or 0.0 */
+	regmap_write(regmap, ISC_CC_RR_RG, (1 << 8));
+	regmap_write(regmap, ISC_CC_RB_OR, 0);
+	regmap_write(regmap, ISC_CC_GR_GG, (1 << 8) << 16);
+	regmap_write(regmap, ISC_CC_GB_OG, 0);
+	regmap_write(regmap, ISC_CC_BR_BG, 0);
+	regmap_write(regmap, ISC_CC_BB_OB, (1 << 8));
+}
+
+static void isc_sama7g5_config_ctrls(struct isc_device *isc,
+				     const struct v4l2_ctrl_ops *ops)
+{
+	struct isc_ctrls *ctrls = &isc->ctrls;
+	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
+
+	ctrls->contrast = 16;
+
+	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_CONTRAST, -2048, 2047, 1, 16);
+}
+
+static void isc_sama7g5_config_dpc(struct isc_device *isc)
+{
+	u32 bay_cfg = isc->config.sd_format->cfa_baycfg;
+	struct regmap *regmap = isc->regmap;
+
+	regmap_update_bits(regmap, ISC_DPC_CFG, ISC_DPC_CFG_BLOFF_MASK,
+			   (64 << ISC_DPC_CFG_BLOFF_SHIFT));
+	regmap_update_bits(regmap, ISC_DPC_CFG, ISC_DPC_CFG_BAYCFG_MASK,
+			   (bay_cfg << ISC_DPC_CFG_BAYCFG_SHIFT));
+}
+
+static void isc_sama7g5_config_gam(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+
+	regmap_update_bits(regmap, ISC_GAM_CTRL, ISC_GAM_CTRL_BIPART,
+			   ISC_GAM_CTRL_BIPART);
+}
+
+static void isc_sama7g5_config_rlp(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 rlp_mode = isc->config.rlp_cfg_mode;
+
+	regmap_update_bits(regmap, ISC_RLP_CFG + isc->offsets.rlp,
+			   ISC_RLP_CFG_MODE_MASK | ISC_RLP_CFG_LSH |
+			   ISC_RLP_CFG_YMODE_MASK, rlp_mode);
+}
+
+static void isc_sama7g5_adapt_pipeline(struct isc_device *isc)
+{
+	isc->try_config.bits_pipeline &= ISC_SAMA7G5_PIPELINE;
+}
+
+/* Gamma table with gamma 1/2.2 */
+static const u32 isc_sama7g5_gamma_table[][GAMMA_ENTRIES] = {
+	/* index 0 --> gamma bipartite */
+	{
+	      0x980,  0x4c0320,  0x650260,  0x7801e0,  0x8701a0,  0x940180,
+	   0xa00160,  0xab0120,  0xb40120,  0xbd0120,  0xc60100,  0xce0100,
+	   0xd600e0,  0xdd00e0,  0xe400e0,  0xeb00c0,  0xf100c0,  0xf700c0,
+	   0xfd00c0, 0x10300a0, 0x10800c0, 0x10e00a0, 0x11300a0, 0x11800a0,
+	  0x11d00a0, 0x12200a0, 0x12700a0, 0x12c0080, 0x13000a0, 0x1350080,
+	  0x13900a0, 0x13e0080, 0x1420076, 0x17d0062, 0x1ae0054, 0x1d8004a,
+	  0x1fd0044, 0x21f003e, 0x23e003a, 0x25b0036, 0x2760032, 0x28f0030,
+	  0x2a7002e, 0x2be002c, 0x2d4002c, 0x2ea0028, 0x2fe0028, 0x3120026,
+	  0x3250024, 0x3370024, 0x3490022, 0x35a0022, 0x36b0020, 0x37b0020,
+	  0x38b0020, 0x39b001e, 0x3aa001e, 0x3b9001c, 0x3c7001c, 0x3d5001c,
+	  0x3e3001c, 0x3f1001c, 0x3ff001a, 0x40c001a },
+};
+
+static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *epn = NULL;
+	struct isc_subdev_entity *subdev_entity;
+	unsigned int flags;
+	int ret;
+	bool mipi_mode;
+
+	INIT_LIST_HEAD(&isc->subdev_entities);
+
+	mipi_mode = of_property_read_bool(np, "microchip,mipi-mode");
+
+	while (1) {
+		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
+
+		epn = of_graph_get_next_endpoint(np, epn);
+		if (!epn)
+			return 0;
+
+		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
+						 &v4l2_epn);
+		if (ret) {
+			ret = -EINVAL;
+			dev_err(dev, "Could not parse the endpoint\n");
+			break;
+		}
+
+		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
+					     GFP_KERNEL);
+		if (!subdev_entity) {
+			ret = -ENOMEM;
+			break;
+		}
+		subdev_entity->epn = epn;
+
+		flags = v4l2_epn.bus.parallel.flags;
+
+		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+			subdev_entity->pfe_cfg0 = ISC_PFE_CFG0_HPOL_LOW;
+
+		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_VPOL_LOW;
+
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_PPOL_LOW;
+
+		if (v4l2_epn.bus_type == V4L2_MBUS_BT656)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_CCIR_CRC |
+					ISC_PFE_CFG0_CCIR656;
+
+		if (mipi_mode)
+			subdev_entity->pfe_cfg0 |= ISC_PFE_CFG0_MIPI;
+
+		list_add_tail(&subdev_entity->list, &isc->subdev_entities);
+	}
+	of_node_put(epn);
+
+	return ret;
+}
+
+static int microchip_xisc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct isc_device *isc;
+	struct resource *res;
+	void __iomem *io_base;
+	struct isc_subdev_entity *subdev_entity;
+	int irq;
+	int ret;
+	u32 ver;
+
+	isc = devm_kzalloc(dev, sizeof(*isc), GFP_KERNEL);
+	if (!isc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, isc);
+	isc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	io_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	isc->regmap = devm_regmap_init_mmio(dev, io_base, &isc_regmap_config);
+	if (IS_ERR(isc->regmap)) {
+		ret = PTR_ERR(isc->regmap);
+		dev_err(dev, "failed to init register map: %d\n", ret);
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
+			       "microchip-sama7g5-xisc", isc);
+	if (ret < 0) {
+		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
+			irq, ret);
+		return ret;
+	}
+
+	isc->gamma_table = isc_sama7g5_gamma_table;
+	isc->gamma_max = 0;
+
+	isc->max_width = ISC_SAMA7G5_MAX_SUPPORT_WIDTH;
+	isc->max_height = ISC_SAMA7G5_MAX_SUPPORT_HEIGHT;
+
+	isc->config_dpc = isc_sama7g5_config_dpc;
+	isc->config_csc = isc_sama7g5_config_csc;
+	isc->config_cbc = isc_sama7g5_config_cbc;
+	isc->config_cc = isc_sama7g5_config_cc;
+	isc->config_gam = isc_sama7g5_config_gam;
+	isc->config_rlp = isc_sama7g5_config_rlp;
+	isc->config_ctrls = isc_sama7g5_config_ctrls;
+
+	isc->adapt_pipeline = isc_sama7g5_adapt_pipeline;
+
+	isc->offsets.csc = ISC_SAMA7G5_CSC_OFFSET;
+	isc->offsets.cbc = ISC_SAMA7G5_CBC_OFFSET;
+	isc->offsets.sub422 = ISC_SAMA7G5_SUB422_OFFSET;
+	isc->offsets.sub420 = ISC_SAMA7G5_SUB420_OFFSET;
+	isc->offsets.rlp = ISC_SAMA7G5_RLP_OFFSET;
+	isc->offsets.his = ISC_SAMA7G5_HIS_OFFSET;
+	isc->offsets.dma = ISC_SAMA7G5_DMA_OFFSET;
+	isc->offsets.version = ISC_SAMA7G5_VERSION_OFFSET;
+	isc->offsets.his_entry = ISC_SAMA7G5_HIS_ENTRY_OFFSET;
+
+	isc->controller_formats = sama7g5_controller_formats;
+	isc->controller_formats_size = ARRAY_SIZE(sama7g5_controller_formats);
+	isc->formats_list = sama7g5_formats_list;
+	isc->formats_list_size = ARRAY_SIZE(sama7g5_formats_list);
+
+	/* sama7g5-isc RAM access port is full AXI4 - 32 bits per beat */
+	isc->dcfg = ISC_DCFG_YMBSIZE_BEATS32 | ISC_DCFG_CMBSIZE_BEATS32;
+
+	/* sama7g5-isc : ISPCK does not exist, ISC is clocked by MCK */
+	isc->ispck_required = false;
+
+	ret = isc_pipeline_init(isc);
+	if (ret)
+		return ret;
+
+	isc->hclock = devm_clk_get(dev, "hclock");
+	if (IS_ERR(isc->hclock)) {
+		ret = PTR_ERR(isc->hclock);
+		dev_err(dev, "failed to get hclock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(isc->hclock);
+	if (ret) {
+		dev_err(dev, "failed to enable hclock: %d\n", ret);
+		return ret;
+	}
+
+	ret = isc_clk_init(isc);
+	if (ret) {
+		dev_err(dev, "failed to init isc clock: %d\n", ret);
+		goto unprepare_hclk;
+	}
+
+	ret = v4l2_device_register(dev, &isc->v4l2_dev);
+	if (ret) {
+		dev_err(dev, "unable to register v4l2 device.\n");
+		goto unprepare_hclk;
+	}
+
+	ret = xisc_parse_dt(dev, isc);
+	if (ret) {
+		dev_err(dev, "fail to parse device tree\n");
+		goto unregister_v4l2_device;
+	}
+
+	if (list_empty(&isc->subdev_entities)) {
+		dev_err(dev, "no subdev found\n");
+		ret = -ENODEV;
+		goto unregister_v4l2_device;
+	}
+
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
+		struct v4l2_async_subdev *asd;
+		struct fwnode_handle *fwnode =
+			of_fwnode_handle(subdev_entity->epn);
+
+		v4l2_async_nf_init(&subdev_entity->notifier);
+
+		asd = v4l2_async_nf_add_fwnode_remote(&subdev_entity->notifier,
+						      fwnode,
+						      struct v4l2_async_subdev);
+
+		of_node_put(subdev_entity->epn);
+		subdev_entity->epn = NULL;
+
+		if (IS_ERR(asd)) {
+			ret = PTR_ERR(asd);
+			goto cleanup_subdev;
+		}
+
+		subdev_entity->notifier.ops = &isc_async_ops;
+
+		ret = v4l2_async_nf_register(&isc->v4l2_dev,
+					     &subdev_entity->notifier);
+		if (ret) {
+			dev_err(dev, "fail to register async notifier\n");
+			goto cleanup_subdev;
+		}
+
+		if (video_is_registered(&isc->video_dev))
+			break;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_request_idle(dev);
+
+	regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
+	dev_info(dev, "Microchip XISC version %x\n", ver);
+
+	return 0;
+
+cleanup_subdev:
+	isc_subdev_cleanup(isc);
+
+unregister_v4l2_device:
+	v4l2_device_unregister(&isc->v4l2_dev);
+
+unprepare_hclk:
+	clk_disable_unprepare(isc->hclock);
+
+	isc_clk_cleanup(isc);
+
+	return ret;
+}
+
+static int microchip_xisc_remove(struct platform_device *pdev)
+{
+	struct isc_device *isc = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	isc_subdev_cleanup(isc);
+
+	v4l2_device_unregister(&isc->v4l2_dev);
+
+	clk_disable_unprepare(isc->hclock);
+
+	isc_clk_cleanup(isc);
+
+	return 0;
+}
+
+static int __maybe_unused xisc_runtime_suspend(struct device *dev)
+{
+	struct isc_device *isc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(isc->hclock);
+
+	return 0;
+}
+
+static int __maybe_unused xisc_runtime_resume(struct device *dev)
+{
+	struct isc_device *isc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(isc->hclock);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static const struct dev_pm_ops microchip_xisc_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(xisc_runtime_suspend, xisc_runtime_resume, NULL)
+};
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id microchip_xisc_of_match[] = {
+	{ .compatible = "microchip,sama7g5-isc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, microchip_xisc_of_match);
+#endif
+
+static struct platform_driver microchip_xisc_driver = {
+	.probe	= microchip_xisc_probe,
+	.remove	= microchip_xisc_remove,
+	.driver	= {
+		.name		= "microchip-sama7g5-xisc",
+		.pm		= &microchip_xisc_dev_pm_ops,
+		.of_match_table = of_match_ptr(microchip_xisc_of_match),
+	},
+};
+
+module_platform_driver(microchip_xisc_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
+MODULE_DESCRIPTION("The V4L2 driver for Microchip-XISC");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

