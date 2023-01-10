Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BB663701
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjAJB43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbjAJB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:56:14 -0500
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1515.securemx.jp [210.130.202.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215AA1659A;
        Mon,  9 Jan 2023 17:56:03 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id 30A1loAs018299; Tue, 10 Jan 2023 10:47:51 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 30A1l7LA018306; Tue, 10 Jan 2023 10:47:07 +0900
X-Iguazu-Qid: 34tMMX4C9tR2EoqbZq
X-Iguazu-QSIG: v=2; s=0; t=1673315227; q=34tMMX4C9tR2EoqbZq; m=cOhUzRxD4D91wJ7V9obzeA0dbp8gGt6oBanm1a2sqcA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 30A1l665007751
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Jan 2023 10:47:06 +0900
X-SA-MID: 52735590
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v4 2/6] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
Date:   Tue, 10 Jan 2023 10:41:39 +0900
X-TSB-HOP2: ON
Message-Id: <20230110014143.18684-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
The interface device includes CSI2 Receiver,
frame grabber, video DMAC and image signal processor.
This patch provides operations to handle registers of HW listed above.

The Video DMACs have 32bit address space
and currently corresponding IOMMU driver is not provided.
Therefore, memory-block address for captured image is 32bit IOVA
which is equal to 32bit-truncated phisical address.
When the Visconti IOMMU driver (currently under development) is accepted,
the hardware layer will use 32bit IOVA mapped by the attached IOMMU.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters

Changelog v4:
- Split patches because the v3 patch exceeds size limit 
- Stop using ID number to identify driver instance:
  - Use dynamically allocated structure to hold driver's context,
    instead of static one indexed by ID number.
  - Functions accept driver's context structure instead of ID number.
---
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    8 +
 drivers/media/platform/visconti/hwd_viif.c    | 1690 ++++++++++
 drivers/media/platform/visconti/hwd_viif.h    |  710 +++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  610 ++++
 .../platform/visconti/hwd_viif_internal.h     |  340 ++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
 include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
 10 files changed, 7895 insertions(+)
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 include/uapi/linux/visconti_viif.h

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a9334263fa9..0908158036d 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -83,6 +83,7 @@ source "drivers/media/platform/sunxi/Kconfig"
 source "drivers/media/platform/ti/Kconfig"
 source "drivers/media/platform/verisilicon/Kconfig"
 source "drivers/media/platform/via/Kconfig"
+source "drivers/media/platform/visconti/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
 endif # MEDIA_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index a91f4202427..1c67cb56244 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -26,6 +26,7 @@ obj-y += sunxi/
 obj-y += ti/
 obj-y += verisilicon/
 obj-y += via/
+obj-y += visconti/
 obj-y += xilinx/
 
 # Please place here only ancillary drivers that aren't SoC-specific
diff --git a/drivers/media/platform/visconti/Kconfig b/drivers/media/platform/visconti/Kconfig
new file mode 100644
index 00000000000..031e4610809
--- /dev/null
+++ b/drivers/media/platform/visconti/Kconfig
@@ -0,0 +1,9 @@
+config VIDEO_VISCONTI_VIIF
+	tristate "Visconti Camera Interface driver"
+	depends on V4L_PLATFORM_DRIVERS && MEDIA_CONTROLLER && VIDEO_DEV
+	depends on ARCH_VISCONTI
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  This is V4L2 driver for Toshiba Visconti Camera Interface driver
+
diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
new file mode 100644
index 00000000000..e14b904df75
--- /dev/null
+++ b/drivers/media/platform/visconti/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Visconti video input device driver
+#
+
+visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
+
+obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/visconti/hwd_viif.c b/drivers/media/platform/visconti/hwd_viif.c
new file mode 100644
index 00000000000..260293fa4d0
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.c
@@ -0,0 +1,1690 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "hwd_viif.h"
+#include "hwd_viif_internal.h"
+
+/* MIPI CSI2 DataType definition */
+#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
+#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
+#define CSI2_DT_RGB565	  VISCONTI_CSI2_DT_RGB565
+#define CSI2_DT_RGB888	  VISCONTI_CSI2_DT_RGB888
+#define CSI2_DT_RAW8	  VISCONTI_CSI2_DT_RAW8
+#define CSI2_DT_RAW10	  VISCONTI_CSI2_DT_RAW10
+#define CSI2_DT_RAW12	  VISCONTI_CSI2_DT_RAW12
+#define CSI2_DT_RAW14	  VISCONTI_CSI2_DT_RAW14
+
+struct hwd_viif_res *allocate_viif_res(struct device *dev, void *csi2host_vaddr,
+				       void *capture_vaddr)
+{
+	struct hwd_viif_res *res = devm_kzalloc(dev, sizeof(struct hwd_viif_res), GFP_KERNEL);
+
+	res->csi2host_reg = csi2host_vaddr;
+	res->capture_reg = capture_vaddr;
+	res->run_flag_main = (bool)false;
+	return res;
+}
+
+/* Convert the unit of time-period (from sysclk, to num lines in the image) */
+static u32 sysclk_to_numlines(u64 time_in_sysclk, const struct hwd_viif_input_img *img)
+{
+	u64 v1 = time_in_sysclk * (u64)img->pixel_clock;
+	u64 v2 = (u64)img->htotal_size * HWD_VIIF_SYS_CLK;
+
+	return (u32)(v1 / v2);
+}
+
+static u32 lineperiod_in_sysclk(u64 hsize, u64 pixel_clock)
+{
+	return (u32)(hsize * HWD_VIIF_SYS_CLK / pixel_clock);
+}
+
+/**
+ * hwd_viif_main_set_unit() - Set static configuration of MAIN unit(CH0 or CH1)
+ *
+ * @dt_image: DT of image [0x10-0x17, 0x1B, 0x1E, 0x1F, 0x22, 0x24-0x27, 0x2A-0x3F])
+ * @in_img: Pointer to input image information
+ * @color_type: Color type of image [0x0, 0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @rawpack: RAW pack mode. For more refer @ref hwd_viif_raw_pack_mode
+ * @yuv_conv: YUV422 to YUV444 conversion mode. For more refer @ref hwd_viif_yuv_conversion_mode
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "dt_image" is out of range
+ * - [2] "in_img" is NULL
+ * - [3] member of "in_img" is invalid
+ * - [4] "color_type" is out of range
+ * - [5] "color_type" doesn't meet the condition shown in the below note
+ * - [6] "rawpack" is out of range
+ * - [7] "rawpack" is not HWD_VIIF_RAWPACK_DISABLE when color_type is other than RAW(0x2A-0x2C)
+ * - [8] "yuv_conv" is out of range
+ * - [9] "yuv_conv" is not HWD_VIIF_YUV_CONV_REPEAT
+ *       when color_type is other than YUV422(0x1E or 0x1F)
+ *
+ * Note: valid combination between "dt_image" and "color_type" is
+ * - when "dt_image" is [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F], "color_type" must be [0x2A-0x2D].
+ * - when "dt_image" is valid value and other than [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F],
+ *   "color_type" must be "dt_image"
+ */
+s32 hwd_viif_main_set_unit(struct hwd_viif_res *res, u32 dt_image,
+			   const struct hwd_viif_input_img *in_img, u32 color_type, u32 rawpack,
+			   u32 yuv_conv)
+{
+	u32 total_hact_size = 0U, total_vact_size = 0U;
+	u32 sw_delay0, sw_delay1, hw_delay;
+	u32 val, color, sysclk_num;
+	u32 i;
+
+	/*
+	 * 0x00-0x09: ShortPacket/Undefined
+	 * 0x18-0x1A: YUV420
+	 * 0x1C,0x1D: YUV420 CSPS
+	 * 0x20,0x21,0x23: RGB444, RGB555, RGB666
+	 * 0x28,0x29: RAW6, RAW7
+	 */
+	if (dt_image <= 0x09U || (dt_image >= 0x18U && dt_image <= 0x1AU) || dt_image == 0x1CU ||
+	    dt_image == 0x1DU || dt_image == 0x20U || dt_image == 0x21U || dt_image == 0x23U ||
+	    dt_image == 0x28U || dt_image == 0x29U || dt_image > HWD_VIIF_CSI2_MAX_DT) {
+		return -EINVAL;
+	}
+
+	/*Case: Generic Long Packet, Reserved, User-Defined*/
+	if ((dt_image >= 0x10U && dt_image <= 0x17U) || dt_image == 0x1bU ||
+	    (dt_image >= 0x25U && dt_image <= 0x27U) || dt_image >= 0x2eU) {
+		if (color_type != CSI2_DT_RAW8 && color_type != CSI2_DT_RAW10 &&
+		    color_type != CSI2_DT_RAW12 && color_type != CSI2_DT_RAW14) {
+			return -EINVAL;
+		}
+	} else {
+		/*Case: Otherwise: YUV, RGB, RAW*/
+		/*Constraint: color_type must be dt_image*/
+		if (color_type != dt_image)
+			return -EINVAL;
+	}
+
+	if (!in_img)
+		return -EINVAL;
+	if (rawpack != HWD_VIIF_RAWPACK_DISABLE && rawpack != HWD_VIIF_RAWPACK_MSBFIRST &&
+	    rawpack != HWD_VIIF_RAWPACK_LSBFIRST) {
+		return -EINVAL;
+	}
+	if (color_type != CSI2_DT_RAW8 && color_type != CSI2_DT_RAW10 &&
+	    color_type != CSI2_DT_RAW12 && rawpack != HWD_VIIF_RAWPACK_DISABLE) {
+		return -EINVAL;
+	}
+
+	if (in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK ||
+	    in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK ||
+	    in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL ||
+	    in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL ||
+	    in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE ||
+	    in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE ||
+	    in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE || in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE ||
+	    ((in_img->hactive_size % 2U) != 0U) || ((in_img->vactive_size % 2U) != 0U)) {
+		return -EINVAL;
+	}
+
+	if (in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE &&
+	    in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL) {
+		return -EINVAL;
+	}
+
+	if (in_img->input_num < HWD_VIIF_L1_INPUT_NUM_MIN ||
+	    in_img->input_num > HWD_VIIF_L1_INPUT_NUM_MAX) {
+		return -EINVAL;
+	}
+
+	if (in_img->hobc_width != 0U && in_img->hobc_width != 16U && in_img->hobc_width != 32U &&
+	    in_img->hobc_width != 64U && in_img->hobc_width != 128U) {
+		return -EINVAL;
+	}
+
+	if (in_img->hobc_margin > 30U || ((in_img->hobc_margin % 2U) != 0U))
+		return -EINVAL;
+
+	if (in_img->hobc_width == 0U && in_img->hobc_margin != 0U)
+		return -EINVAL;
+
+	if (in_img->hobc_width != 0U && in_img->hobc_margin == 0U)
+		return -EINVAL;
+
+	if (color_type == CSI2_DT_RAW8 || color_type == CSI2_DT_RAW10 ||
+	    color_type == CSI2_DT_RAW12 || color_type == CSI2_DT_RAW14) {
+		/* parameter check in case of L1ISP(in case of RAW) */
+		if (in_img->hactive_size < HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP ||
+		    in_img->hactive_size > HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP ||
+		    in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP ||
+		    in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP ||
+		    ((in_img->hactive_size % 8U) != 0U)) {
+			return -EINVAL;
+		}
+
+		/* check vbp range in case of L1ISP on */
+		/* the constant value "7" is configuration margin */
+		val = sysclk_to_numlines(
+			      HWD_VIIF_TABLE_LOAD_TIME + HWD_VIIF_REGBUF_ACCESS_TIME * 2U, in_img) +
+		      HWD_VIIF_L1_DELAY_W_HDRC + 7U;
+		if (in_img->vbp_size < val)
+			return -EINVAL;
+
+		/* calculate total of horizontal active size and vertical active size */
+		if (rawpack != HWD_VIIF_RAWPACK_DISABLE) {
+			val = (in_img->hactive_size + in_img->hobc_width + in_img->hobc_margin) *
+			      2U;
+		} else {
+			val = in_img->hactive_size + in_img->hobc_width + in_img->hobc_margin;
+		}
+		if (in_img->interpolation_mode == HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) {
+			total_hact_size = val;
+			total_vact_size = in_img->vactive_size * in_img->input_num;
+		} else {
+			total_hact_size = val * in_img->input_num;
+			total_vact_size = in_img->vactive_size;
+		}
+	} else {
+		/* OTHER input than RAW(L1ISP is off) */
+		if (in_img->hactive_size < HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP ||
+		    in_img->hactive_size > HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP ||
+		    in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
+		    in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
+		    in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE ||
+		    in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN || in_img->hobc_width != 0U) {
+			return -EINVAL;
+		}
+
+		/* check vbp range in case of L1ISP off */
+		/* the constant value "16" is configuration margin */
+		val = sysclk_to_numlines(HWD_VIIF_TABLE_LOAD_TIME + HWD_VIIF_REGBUF_ACCESS_TIME,
+					 in_img) +
+		      16U;
+		if (in_img->vbp_size < val)
+			return -EINVAL;
+
+		total_hact_size = in_img->hactive_size;
+		total_vact_size = in_img->vactive_size;
+	}
+
+	if (in_img->htotal_size <= total_hact_size ||
+	    (in_img->vtotal_size <= (in_img->vbp_size + total_vact_size))) {
+		return -EINVAL;
+	}
+
+	if (yuv_conv != HWD_VIIF_YUV_CONV_REPEAT && yuv_conv != HWD_VIIF_YUV_CONV_INTERPOLATION)
+		return -EINVAL;
+
+	if (color_type != CSI2_DT_YUV4228B && color_type != CSI2_DT_YUV42210B &&
+	    yuv_conv != HWD_VIIF_YUV_CONV_REPEAT) {
+		return -EINVAL;
+	}
+
+	/* Set DT and color type of image data */
+	writel((color_type << 8U) | dt_image, &res->capture_reg->sys.IPORTM_MAIN_DT);
+	writel(0x00, &res->capture_reg->sys.IPORTM_OTHER);
+	res->dt_image_main_w_isp = dt_image;
+
+	/* Set back porch*/
+	writel((in_img->vbp_size << 16U) | HWD_VIIF_HBP_SYSCLK,
+	       &res->capture_reg->sys.BACK_PORCH_M);
+
+	/* single pulse of vsync is input to DPGM */
+	writel(HWD_VIIF_DPGM_VSYNC_PULSE, &res->capture_reg->sys.DPGM_VSYNC_SOURCE);
+
+	/* image data will be input */
+	/* set preprocess type before L2ISP based on color_type. */
+	if (color_type == CSI2_DT_YUV4228B || color_type == CSI2_DT_YUV42210B) {
+		/* YUV422 */
+		color = 3U;
+	} else if (color_type == CSI2_DT_RGB565 || color_type == CSI2_DT_RGB888) {
+		/* RGB */
+		color = 0U;
+	} else {
+		/* RGB or YUV444 from L1ISP */
+		color = 1U;
+	}
+	writel(color << 4U, &res->capture_reg->sys.PREPROCCESS_FMTM);
+
+	/* set Total size and valid size information of image data */
+	sysclk_num = lineperiod_in_sysclk(in_img->htotal_size, in_img->pixel_clock);
+	sysclk_num &= GENMASK(15, 0);
+	writel((in_img->vtotal_size << 16U) | sysclk_num, &res->capture_reg->sys.TOTALSIZE_M);
+	writel((total_vact_size << 16U) | total_hact_size, &res->capture_reg->sys.VALSIZE_M);
+
+	/* set image size information to L2ISP */
+	writel(in_img->vactive_size, &res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE);
+	writel(in_img->hactive_size, &res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE);
+
+	/* RAW input case */
+	if (color_type >= CSI2_DT_RAW8) {
+		val = (in_img->interpolation_mode << 3U) | (in_img->input_num);
+		writel(val, &res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER);
+		writel(in_img->vactive_size, &res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		writel(in_img->hactive_size, &res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		val = (in_img->hobc_margin << 8U) | in_img->hobc_width;
+		writel(val, &res->capture_reg->l1isp.L1_HOBC_MARGIN);
+	}
+
+	/* Set rawpack */
+	writel(rawpack, &res->capture_reg->sys.IPORTM_MAIN_RAW);
+
+	/* Set yuv_conv */
+	writel(yuv_conv, &res->capture_reg->sys.PREPROCCESS_C24M);
+
+	/* Set vsync delay */
+	hw_delay = in_img->vbp_size - sysclk_to_numlines(HWD_VIIF_TABLE_LOAD_TIME, in_img) + 4U;
+	hw_delay = min(hw_delay, 255U);
+
+	sw_delay0 = hw_delay - sysclk_to_numlines(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) + 2U;
+
+	if (color_type == CSI2_DT_RAW8 || color_type == CSI2_DT_RAW10 ||
+	    color_type == CSI2_DT_RAW12 || color_type == CSI2_DT_RAW14) {
+		sw_delay1 = sysclk_to_numlines(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) +
+			    HWD_VIIF_L1_DELAY_WO_HDRC + 1U;
+	} else {
+		sw_delay1 = 10U;
+	}
+	writel(sw_delay0 << 16U, &res->capture_reg->sys.INT_M0_LINE);
+	writel((sw_delay1 << 16U) | hw_delay, &res->capture_reg->sys.INT_M1_LINE);
+
+	/* M2_LINE is the same condition as M1_LINE */
+	writel((sw_delay1 << 16U) | hw_delay, &res->capture_reg->sys.INT_M2_LINE);
+
+	/* Update internal information of pixel clock, htotal_size, information of L2 ROI */
+	res->pixel_clock = in_img->pixel_clock;
+	res->htotal_size = in_img->htotal_size;
+	res->l2_roi_path_info.roi_num = 0;
+	for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
+		res->l2_roi_path_info.post_enable_flag[i] = false;
+		res->l2_roi_path_info.post_crop_x[i] = 0;
+		res->l2_roi_path_info.post_crop_y[i] = 0;
+		res->l2_roi_path_info.post_crop_w[i] = 0;
+		res->l2_roi_path_info.post_crop_h[i] = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_main_mask_vlatch() - Control Vlatch mask of MAIN unit
+ *
+ * @enable: or disable Vlatch mask of MAIN unit. For more refer @ref hwd_viif_enable_flag.
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is out of range
+ */
+s32 hwd_viif_main_mask_vlatch(struct hwd_viif_res *res, u32 enable)
+{
+	if (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	if (enable == HWD_VIIF_ENABLE)
+		enable |= HWD_VIIF_ISP_VLATCH_MASK;
+
+	/* Control Vlatch mask */
+	writel(enable, &res->capture_reg->sys.IPORTM0_LD);
+	writel(enable, &res->capture_reg->sys.IPORTM1_LD);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_main_status_err_set_irq_mask() - Set mask condition for STATUS error of MAIN unit
+ *
+ * @mask: STATUS error mask condition
+ * Return: None
+ */
+void hwd_viif_main_status_err_set_irq_mask(struct hwd_viif_res *res, u32 mask)
+{
+	writel(mask, &res->capture_reg->sys.INT_M_MASK);
+}
+
+/**
+ * hwd_viif_main_vsync_set_irq_mask() - Set mask condition for Vsync of MAIN unit
+ *
+ * @mask: Vsync mask condition
+ * Return: None
+ */
+void hwd_viif_main_vsync_set_irq_mask(struct hwd_viif_res *res, u32 mask)
+{
+	writel(mask, &res->capture_reg->sys.INT_M_SYNC_MASK);
+}
+
+#define VDM_BIT_W00 BIT(0)
+#define VDM_BIT_W01 BIT(1)
+#define VDM_BIT_W02 BIT(2)
+#define VDM_BIT_W03 BIT(3)
+#define VDM_BIT_W04 BIT(4)
+#define VDM_BIT_W05 BIT(5)
+#define VDM_BIT_R00 BIT(0)
+#define VDM_BIT_R01 BIT(1)
+#define VDM_BIT_R02 BIT(2)
+
+#define VDM_ABORT_MASK_SUB_W  (VDM_BIT_W03 | VDM_BIT_W04 | VDM_BIT_W05)
+#define VDM_ABORT_MASK_MAIN_W (VDM_BIT_W00 | VDM_BIT_W01 | VDM_BIT_W02)
+#define VDM_ABORT_MASK_MAIN_R (VDM_BIT_R00 | VDM_BIT_R01 | VDM_BIT_R02)
+
+/**
+ * hwd_viif_sub_set_unit() - Set static configuration of SUB unit
+ *
+ * @dt_image: DT of image [0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @in_img: Pointer to input image information
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "dt_image" is out of range
+ * - [2] "in_img" is NULL
+ * - [3] member of "in_img" is invalid
+ */
+s32 hwd_viif_sub_set_unit(struct hwd_viif_res *res, u32 dt_image,
+			  const struct hwd_viif_input_img *in_img)
+{
+	u32 sysclk_num, temp_delay;
+
+	if (dt_image < 0x2aU || dt_image > 0x2dU)
+		return -EINVAL;
+
+	if (!in_img)
+		return -EINVAL;
+
+	if (in_img->hactive_size != 0U ||
+	    in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE ||
+	    in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN || in_img->hobc_width != 0U ||
+	    in_img->hobc_margin != 0U) {
+		return -EINVAL;
+	}
+
+	if (in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK ||
+	    in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK ||
+	    in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL ||
+	    in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL ||
+	    in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE ||
+	    in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE ||
+	    in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE || in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE ||
+	    in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
+	    in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
+	    ((in_img->vactive_size % 2U) != 0U)) {
+		return -EINVAL;
+	}
+
+	if (in_img->vtotal_size <= (in_img->vbp_size + in_img->vactive_size))
+		return -EINVAL;
+
+	/* Set DT of image data and DT of long packet data*/
+	writel(dt_image, &res->capture_reg->sys.IPORTS_MAIN_DT);
+	writel(0x00, &res->capture_reg->sys.IPORTS_OTHER);
+
+	/* Set line size and delay value of delayed Vsync */
+	sysclk_num = lineperiod_in_sysclk(in_img->htotal_size, in_img->pixel_clock);
+	writel(sysclk_num & GENMASK(15, 0), &res->capture_reg->sys.INT_SA0_LINE);
+	temp_delay = in_img->vbp_size - 4U;
+	if (temp_delay > 255U) {
+		/* Replace the value with HW max spec */
+		temp_delay = 255U;
+	}
+	writel(temp_delay, &res->capture_reg->sys.INT_SA1_LINE);
+
+	return 0;
+}
+
+/* DMA settings */
+#define VDMAC_SRAM_BASE_ADDR_W03 0x440U
+#define SRAM_SIZE_W_PORT	 0x200
+#define PORT_SEL_SUB_IMAGE	 3
+
+/**
+ * hwd_viif_sub_set_img_transmission() - Set image transfer condition of SUB unit
+ *
+ * @img: Pointer to output image information
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] Member of "img" is invalid
+ */
+s32 hwd_viif_sub_set_img_transmission(struct hwd_viif_res *res, const struct hwd_viif_img *img)
+{
+	struct hwd_viif_vdm_write_port_reg *wport;
+	u32 img_start_addr, img_end_addr;
+	u32 data_width, pitch, height;
+	u32 k, port_control;
+
+	/* disable VDMAC when img is NULL */
+	if (!img) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_IMGEN);
+		port_control = ~((u32)1U << 3U) & readl(&res->capture_reg->vdm.VDM_W_ENABLE);
+		writel(port_control, &res->capture_reg->vdm.VDM_W_ENABLE);
+		return 0;
+	}
+
+	if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U))
+		return -EINVAL;
+
+	if (img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH ||
+	    img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT ||
+	    img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB ||
+	    img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB) {
+		return -EINVAL;
+	}
+
+	img_start_addr = (u32)img->pixelmap[0].pmap_paddr;
+	pitch = img->pixelmap[0].pitch;
+	height = img->height;
+
+	switch (img->format) {
+	case HWD_VIIF_ONE_COLOR_8:
+		data_width = 0U;
+		img_end_addr = img_start_addr + img->width - 1U;
+		k = 1;
+		break;
+	case HWD_VIIF_ONE_COLOR_16:
+		data_width = 1U;
+		img_end_addr = img_start_addr + (img->width * 2U) - 1U;
+		k = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ((img_start_addr % 4U) != 0U)
+		return -EINVAL;
+
+	if ((pitch < (img->width * k)) || pitch > HWD_VIIF_MAX_PITCH || ((pitch % 4U) != 0U))
+		return -EINVAL;
+
+	wport = &res->capture_reg->vdm.w_port[PORT_SEL_SUB_IMAGE];
+	writel(VDMAC_SRAM_BASE_ADDR_W03, &wport->VDM_W_SRAM_BASE);
+	writel(SRAM_SIZE_W_PORT, &wport->VDM_W_SRAM_SIZE);
+	writel(img_start_addr, &wport->VDM_W_STADR);
+	writel(img_end_addr, &wport->VDM_W_ENDADR);
+	writel(height, &wport->VDM_W_HEIGHT);
+	writel(pitch, &wport->VDM_W_PITCH);
+	writel(data_width << 8U, &wport->VDM_W_CFG0);
+	port_control = BIT(3) | readl(&res->capture_reg->vdm.VDM_W_ENABLE);
+	writel(port_control, &res->capture_reg->vdm.VDM_W_ENABLE);
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->sys.IPORTS_IMGEN);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_sub_status_err_set_irq_mask() -
+ *  Set mask condition for STATUS error of SUB unit or VOIF loopback
+ *
+ * @mask: STATUS error mask condition
+ * Return: None
+ */
+void hwd_viif_sub_status_err_set_irq_mask(struct hwd_viif_res *res, u32 mask)
+{
+	writel(mask, &res->capture_reg->sys.INT_S_MASK);
+}
+
+/**
+ * hwd_viif_sub_vsync_set_irq_mask() - Set mask condition for Vsync of SUB unit or VOIF loopback
+ *
+ * @mask: Vsync mask condition
+ * Return: None
+ */
+void hwd_viif_sub_vsync_set_irq_mask(struct hwd_viif_res *res, const u32 mask)
+{
+	writel(mask, &res->capture_reg->sys.INT_S_SYNC_MASK);
+}
+
+/**
+ * hwd_viif_isp_set_regbuf_auto_transmission() - Set register buffer auto transmission
+ *
+ * Return: None
+ */
+void hwd_viif_isp_set_regbuf_auto_transmission(struct hwd_viif_res *res)
+{
+	u32 val;
+
+	/* Set parameters for auto read transmission of register buffer */
+
+	if (res->dt_image_main_w_isp != 0x0U) {
+		/*
+		 * configuration is done
+		 * only when dt_image is not 0, means image data is input to ISP.
+		 */
+		writel(0x0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+		writel(0x0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+		writel(HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT,
+		       &res->capture_reg->l1isp.L1_CRGBF_TRN_RBADDR);
+		writel(HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT,
+		       &res->capture_reg->l1isp.L1_CRGBF_TRN_READDR);
+		writel(HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT,
+		       &res->capture_reg->l2isp.L2_CRGBF_TRN_RBADDR);
+		writel(HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT,
+		       &res->capture_reg->l2isp.L2_CRGBF_TRN_READDR);
+		val = BIT(16);
+		writel(val, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+		writel(val, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+	}
+}
+
+/**
+ * hwd_viif_isp_disable_regbuf_auto_transmission() - Disable register buffer auto transmission
+ *
+ * Return: None
+ */
+void hwd_viif_isp_disable_regbuf_auto_transmission(struct hwd_viif_res *res)
+{
+	if (res->dt_image_main_w_isp != 0x0U) {
+		writel(0x0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+		writel(0x0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+	}
+}
+
+/**
+ * hwd_viif_isp_guard_start() - stop register auto update
+ *
+ *
+ * This function call stops update of some hardware registers
+ * while the manual setup of VIIF, L1ISP registers is in progress.
+ *
+ * * regbuf control: load/store HW register (settings, status) values to backup SRAM.
+ * * vlatch control: copy timer-counter register value to status register.
+ */
+void hwd_viif_isp_guard_start(struct hwd_viif_res *res)
+{
+	hwd_viif_isp_disable_regbuf_auto_transmission(res);
+	ndelay(500);
+	hwd_viif_main_mask_vlatch(res, HWD_VIIF_ENABLE);
+}
+
+/**
+ * hwd_viif_isp_guard_start() - restart register auto update
+ *
+ *
+ * see also hwd_viif_isp_guard_start().
+ */
+void hwd_viif_isp_guard_end(struct hwd_viif_res *res)
+{
+	hwd_viif_main_mask_vlatch(res, HWD_VIIF_DISABLE);
+	hwd_viif_isp_set_regbuf_auto_transmission(res);
+}
+
+#define L2_STATUS_REPORT_MASK 0x1eU
+
+/**
+ * hwd_viif_isp_get_info() - Get processing information of L1ISP and L2ISP
+ *
+ * @l1_info: L1ISP processing information
+ * @l2_transfer_status: status of L2ISP transmission
+ * Return: None
+ */
+void hwd_viif_isp_get_info(struct hwd_viif_res *res, struct hwd_viif_l1_info *l1_info,
+			   u32 *l2_transfer_status)
+{
+	u32 val, l2_status;
+	int i, j;
+
+	if (l1_info) {
+		/* change register buffer to regbuf0 where driver gets information */
+		writel(HWD_VIIF_ISP_REGBUF_MODE_BUFFER, &res->capture_reg->l1isp.L1_CRGBF_ACC_CONF);
+
+		/* get AWB info */
+		l1_info->awb_ave_u = readl(&res->capture_reg->l1isp.L1_AWHB_AVE_USIG);
+		l1_info->awb_ave_v = readl(&res->capture_reg->l1isp.L1_AWHB_AVE_VSIG);
+		l1_info->awb_accumulated_pixel = readl(&res->capture_reg->l1isp.L1_AWHB_NUM_UVON);
+		l1_info->awb_gain_r = readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAINR);
+		l1_info->awb_gain_g = readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAING);
+		l1_info->awb_gain_b = readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAINB);
+		val = readl(&res->capture_reg->l1isp.L1_AWHB_R_CTR_STOP);
+		l1_info->awb_status_u = (FIELD_GET(BIT(1), val) != 0);
+		l1_info->awb_status_v = (FIELD_GET(BIT(0), val) != 0);
+
+		/* get average luminance info */
+		l1_info->avg_lum_weight = readl(&res->capture_reg->l1isp.L1_AEXP_RESULT_AVE);
+		val = readl(&res->capture_reg->l1isp.L1_AEXP_SATUR_BLACK_PIXNUM);
+		l1_info->avg_satur_pixnum = FIELD_GET(GENMASK(31, 16), val);
+		l1_info->avg_black_pixnum = FIELD_GET(GENMASK(15, 0), val);
+		for (i = 0; i < 8; i++) {
+			for (j = 0; j < 8; j++) {
+				l1_info->avg_lum_block[i][j] =
+					readl(&res->capture_reg->l1isp.L1_AEXP_AVE[i][j]);
+			}
+		}
+		l1_info->avg_lum_four_line_lum[0] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES0);
+		l1_info->avg_lum_four_line_lum[1] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES1);
+		l1_info->avg_lum_four_line_lum[2] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES2);
+		l1_info->avg_lum_four_line_lum[3] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES3);
+
+		/* revert to register access from register buffer access */
+		writel(HWD_VIIF_ISP_REGBUF_MODE_BYPASS, &res->capture_reg->l1isp.L1_CRGBF_ACC_CONF);
+	}
+
+	if (l2_transfer_status) {
+		/* get L2ISP abort information */
+		l2_status = readl(&res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
+		writel(l2_status, &res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
+		*l2_transfer_status = l2_status & L2_STATUS_REPORT_MASK;
+	}
+}
+
+/**
+ * hwd_viif_isp_set_regbuf_irq_mask() - Set mask condition for ISP register buffer
+ *
+ * @mask_l1: Pointer to mask configuration for L1ISP register buffer interruption
+ * @mask_l2: Pointer to mask configuration for L2ISP register buffer interruption
+ * Return: None
+ */
+void hwd_viif_isp_set_regbuf_irq_mask(struct hwd_viif_res *res, const u32 *mask_l1,
+				      const u32 *mask_l2)
+{
+	writel(*mask_l1, &res->capture_reg->l1isp.L1_CRGBF_INT_MASK);
+	writel(*mask_l2, &res->capture_reg->l2isp.L2_CRGBF_INT_MASK);
+}
+
+/**
+ * hwd_viif_l2_set_input_csc() - Set input CSC parameters of L2ISP
+ *
+ * @param: Pointer to input csc parameters of L2ISP
+ * @is_l1_rgb: input information of L2ISP
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] Member of "param" is invalid
+ */
+s32 hwd_viif_l2_set_input_csc(struct hwd_viif_res *res, const struct hwd_viif_csc_param *param,
+			      bool is_l1_rgb)
+{
+	struct hwd_viif_csc_param hwd_param;
+	u32 enable = HWD_VIIF_ENABLE;
+	bool csc_enable_flag = true;
+	u32 i, val;
+
+	if (param) {
+		if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET) {
+			return -EINVAL;
+		}
+
+		for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
+			if (param->coef[i] > HWD_VIIF_CSC_MAX_COEF_VALUE)
+				return -EINVAL;
+		}
+
+		if (is_l1_rgb) {
+			/* translated parameters are used */
+			hwd_param.r_cr_in_offset = param->b_cb_in_offset;
+			hwd_param.g_y_in_offset = param->r_cr_in_offset;
+			hwd_param.b_cb_in_offset = param->g_y_in_offset;
+			hwd_param.r_cr_out_offset = param->r_cr_out_offset;
+			hwd_param.g_y_out_offset = param->g_y_out_offset;
+			hwd_param.b_cb_out_offset = param->b_cb_out_offset;
+			hwd_param.coef[0] = param->coef[2];
+			hwd_param.coef[1] = param->coef[0];
+			hwd_param.coef[2] = param->coef[1];
+			hwd_param.coef[3] = param->coef[5];
+			hwd_param.coef[4] = param->coef[3];
+			hwd_param.coef[5] = param->coef[4];
+			hwd_param.coef[6] = param->coef[8];
+			hwd_param.coef[7] = param->coef[6];
+			hwd_param.coef[8] = param->coef[7];
+		} else {
+			/* original parameters are used */
+			hwd_param.r_cr_in_offset = param->r_cr_in_offset;
+			hwd_param.g_y_in_offset = param->g_y_in_offset;
+			hwd_param.b_cb_in_offset = param->b_cb_in_offset;
+			hwd_param.r_cr_out_offset = param->r_cr_out_offset;
+			hwd_param.g_y_out_offset = param->g_y_out_offset;
+			hwd_param.b_cb_out_offset = param->b_cb_out_offset;
+			hwd_param.coef[0] = param->coef[0];
+			hwd_param.coef[1] = param->coef[1];
+			hwd_param.coef[2] = param->coef[2];
+			hwd_param.coef[3] = param->coef[3];
+			hwd_param.coef[4] = param->coef[4];
+			hwd_param.coef[5] = param->coef[5];
+			hwd_param.coef[6] = param->coef[6];
+			hwd_param.coef[7] = param->coef[7];
+			hwd_param.coef[8] = param->coef[8];
+		}
+	} else {
+		if (is_l1_rgb) {
+			/* fixed parameters are used */
+			hwd_param.r_cr_in_offset = 0U;
+			hwd_param.g_y_in_offset = 0U;
+			hwd_param.b_cb_in_offset = 0U;
+			hwd_param.r_cr_out_offset = 0U;
+			hwd_param.g_y_out_offset = 0U;
+			hwd_param.b_cb_out_offset = 0U;
+			hwd_param.coef[0] = 0U;
+			hwd_param.coef[1] = 0x1000U;
+			hwd_param.coef[2] = 0U;
+			hwd_param.coef[3] = 0U;
+			hwd_param.coef[4] = 0U;
+			hwd_param.coef[5] = 0x1000U;
+			hwd_param.coef[6] = 0x1000U;
+			hwd_param.coef[7] = 0U;
+			hwd_param.coef[8] = 0U;
+		} else {
+			/* csc is disabled */
+			enable = HWD_VIIF_DISABLE;
+			csc_enable_flag = false;
+		}
+	}
+
+	if (csc_enable_flag) {
+		writel(hwd_param.g_y_in_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETI);
+		writel(hwd_param.coef[0], &res->capture_reg->sys.l2isp_input_csc.MTB_YG1);
+		val = (hwd_param.coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
+		      (hwd_param.coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
+		writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_YG2);
+		writel(hwd_param.g_y_out_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETO);
+		writel(hwd_param.b_cb_in_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETI);
+		writel(hwd_param.coef[3], &res->capture_reg->sys.l2isp_input_csc.MTB_CB1);
+		val = (hwd_param.coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
+		      (hwd_param.coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
+		writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_CB2);
+		writel(hwd_param.b_cb_out_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETO);
+		writel(hwd_param.r_cr_in_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETI);
+		writel(hwd_param.coef[6], &res->capture_reg->sys.l2isp_input_csc.MTB_CR1);
+		val = (hwd_param.coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
+		      (hwd_param.coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
+		writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_CR2);
+		writel(hwd_param.r_cr_out_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETO);
+	}
+
+	writel(enable, &res->capture_reg->sys.l2isp_input_csc.MTB);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_undist() - Set undistortion parameters of L2ISP
+ *
+ * @param: Pointer to undistortion parameters of L2ISP
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "param" is NULL
+ * - [2] Member of "param" is invalid
+ */
+s32 hwd_viif_l2_set_undist(struct hwd_viif_res *res, const struct viif_l2_undist *param)
+{
+	u32 grid_num_h, grid_num_v;
+	u32 i, val;
+
+	if (!param)
+		return -EINVAL;
+
+	if (param->through_mode != HWD_VIIF_ENABLE && param->through_mode != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	if (param->roi_mode[0] != HWD_VIIF_L2_UNDIST_POLY &&
+	    param->roi_mode[0] != HWD_VIIF_L2_UNDIST_GRID &&
+	    param->roi_mode[0] != HWD_VIIF_L2_UNDIST_POLY_TO_GRID &&
+	    param->roi_mode[0] != HWD_VIIF_L2_UNDIST_GRID_TO_POLY) {
+		return -EINVAL;
+	}
+	if (param->roi_mode[1] != HWD_VIIF_L2_UNDIST_POLY &&
+	    param->roi_mode[1] != HWD_VIIF_L2_UNDIST_GRID &&
+	    param->roi_mode[1] != HWD_VIIF_L2_UNDIST_POLY_TO_GRID &&
+	    param->roi_mode[1] != HWD_VIIF_L2_UNDIST_GRID_TO_POLY) {
+		return -EINVAL;
+	}
+	if (param->roi_write_area_delta[0] >= HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA ||
+	    param->roi_write_area_delta[1] >= HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA ||
+	    param->sensor_crop_ofs_h < HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H ||
+	    param->sensor_crop_ofs_h > HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H ||
+	    param->sensor_crop_ofs_v < HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V ||
+	    param->sensor_crop_ofs_v > HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V ||
+	    param->norm_scale > HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE ||
+	    param->valid_r_norm2_poly >= HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2 ||
+	    param->valid_r_norm2_grid >= HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
+		if (param->poly_write_g_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_write_g_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
+		    param->poly_read_b_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_read_b_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
+		    param->poly_read_g_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_read_g_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
+		    param->poly_read_r_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_read_r_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->grid_node_num_h < HWD_VIIF_L2_UNDIST_MIN_GRID_NUM ||
+	    param->grid_node_num_h > HWD_VIIF_L2_UNDIST_MAX_GRID_NUM ||
+	    param->grid_node_num_v < HWD_VIIF_L2_UNDIST_MIN_GRID_NUM ||
+	    param->grid_node_num_v > HWD_VIIF_L2_UNDIST_MAX_GRID_NUM) {
+		return -EINVAL;
+	}
+
+	grid_num_h = param->grid_node_num_h;
+	grid_num_v = param->grid_node_num_v;
+	if ((grid_num_h % 2U) != 0U)
+		grid_num_h += 1U;
+
+	if ((grid_num_v % 2U) != 0U)
+		grid_num_v += 1U;
+
+	if ((grid_num_v * grid_num_h) > HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM ||
+	    param->grid_patch_hsize_inv >= HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV ||
+	    param->grid_patch_vsize_inv >= HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV) {
+		return -EINVAL;
+	}
+
+	val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE) & GENMASK(12, 0);
+	if (((param->sensor_crop_ofs_h / 2) + ((s16)val)) > 4095)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE) & GENMASK(11, 0);
+	if (((param->sensor_crop_ofs_v / 2) + ((s16)val)) > 2047)
+		return -EINVAL;
+
+	/* set parameters related to L2ISP UNDIST */
+	if (param->through_mode == HWD_VIIF_ENABLE) {
+		/* Enable through mode */
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l2isp.L2_MODE);
+	} else {
+		val = (param->roi_mode[0] << 1U) | (param->roi_mode[1] << 3U);
+		writel(val, &res->capture_reg->l2isp.L2_MODE);
+		val = (u32)param->sensor_crop_ofs_h & GENMASK(13, 0);
+		writel(val, &res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_H);
+		val = (u32)param->sensor_crop_ofs_v & GENMASK(12, 0);
+		writel(val, &res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_V);
+		writel(param->norm_scale, &res->capture_reg->l2isp.L2_NORM_SCALE);
+		writel(param->valid_r_norm2_poly, &res->capture_reg->l2isp.L2_VALID_R_NORM2_POLY);
+		writel(param->valid_r_norm2_grid, &res->capture_reg->l2isp.L2_VALID_R_NORM2_GRID);
+		writel(param->roi_write_area_delta[0],
+		       &res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[0]);
+		writel(param->roi_write_area_delta[1],
+		       &res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[1]);
+
+		for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
+			val = (u32)param->poly_write_g_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_WRITE_G_COEF[i]);
+			val = (u32)param->poly_read_b_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_READ_B_COEF[i]);
+			val = (u32)param->poly_read_g_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_READ_G_COEF[i]);
+			val = (u32)param->poly_read_r_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_READ_R_COEF[i]);
+		}
+		writel(param->grid_node_num_h, &res->capture_reg->l2isp.L2_GRID_NODE_NUM_H);
+		writel(param->grid_node_num_v, &res->capture_reg->l2isp.L2_GRID_NODE_NUM_V);
+		writel(param->grid_patch_hsize_inv,
+		       &res->capture_reg->l2isp.L2_GRID_PATCH_HSIZE_INV);
+		writel(param->grid_patch_vsize_inv,
+		       &res->capture_reg->l2isp.L2_GRID_PATCH_VSIZE_INV);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_undist_table_transmission() -
+ *  Configure L2ISP transferring grid table for undistortion.
+ *
+ * @write_g: grid table address for G-WRITE(physical address)
+ * @read_b: grid table address for B-READ(physical address)
+ * @read_g: grid table address for G-READ(physical address)
+ * @read_r: grid table address for R-READ(physical address)
+ * @size: of each table [1024..8192] [byte]
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "write_g", "read_b", "read_g" or "read_r" is not 4byte alignment
+ * - "size" is out of range
+ * - "size" is not 0 when all table addresses are 0
+ */
+s32 hwd_viif_l2_set_undist_table_transmission(struct hwd_viif_res *res, uintptr_t write_g,
+					      uintptr_t read_b, uintptr_t read_g, uintptr_t read_r,
+					      u32 size)
+{
+	u32 val = 0U;
+
+	if (((write_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_b % HWD_VIIF_L2_VDM_ALIGN) != 0U) ||
+	    ((read_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_r % HWD_VIIF_L2_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+
+	if ((size != 0U && size < HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE) ||
+	    size > HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE) {
+		return -EINVAL;
+	}
+
+	if ((size % 4U) != 0U)
+		return -EINVAL;
+
+	if (write_g == 0U && read_b == 0U && read_g == 0U && read_r == 0U && size != 0U)
+		return -EINVAL;
+
+	if ((write_g != 0U || read_b != 0U || read_g != 0U || read_r != 0U) && size == 0U)
+		return -EINVAL;
+
+	/* read_b: t_port[8], read_g: t_port[9], read_r: t_port[10], write_g: t_port[11] */
+	if (read_b != 0U) {
+		writel((u32)read_b, &res->capture_reg->vdm.t_port[8].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[8].VDM_T_SIZE);
+		val |= BIT(8);
+	}
+	if (read_g != 0U) {
+		writel((u32)read_g, &res->capture_reg->vdm.t_port[9].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[9].VDM_T_SIZE);
+		val |= BIT(9);
+	}
+	if (read_r != 0U) {
+		writel((u32)read_r, &res->capture_reg->vdm.t_port[10].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[10].VDM_T_SIZE);
+		val |= BIT(10);
+	}
+	if (write_g != 0U) {
+		writel((u32)write_g, &res->capture_reg->vdm.t_port[11].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[11].VDM_T_SIZE);
+		val |= BIT(11);
+	}
+
+	if (val != 0U) {
+		/*
+		 * Set SRAM base address and size.
+		 * t_group[1] is used only to transfer UNDIST table
+		 */
+		writel(HWD_VIIF_VDM_CFG_PARAM, &res->capture_reg->vdm.t_group[1].VDM_T_CFG);
+		writel(HWD_VIIF_L2_VDM_GRID_SRAM_BASE,
+		       &res->capture_reg->vdm.t_group[1].VDM_T_SRAM_BASE);
+		writel(HWD_VIIF_L2_VDM_GRID_SRAM_SIZE,
+		       &res->capture_reg->vdm.t_group[1].VDM_T_SRAM_SIZE);
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & ~((u32)0xfU << 8U));
+	writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_roi_num_1() - Set ROI path condition when ROI num is 1
+ */
+static void hwd_viif_l2_set_roi_num_1(struct hwd_viif_res *res)
+{
+	struct hwd_viif_l2_roi_path_info *info = &res->l2_roi_path_info;
+	u32 val, x_min, x_max, y_min, y_max;
+	u32 i, x, y, w, h;
+
+	/* ROI0 is input to POST0 and POST1 */
+	if (info->post_enable_flag[0]) {
+		/* POST0 is enabled */
+		x_min = info->post_crop_x[0];
+		x_max = info->post_crop_x[0] + info->post_crop_w[0];
+		y_min = info->post_crop_y[0];
+		y_max = info->post_crop_y[0] + info->post_crop_h[0];
+		if (info->post_enable_flag[1]) {
+			/* POST1 is enabled */
+			x_min = min(x_min, info->post_crop_x[1]);
+			val = info->post_crop_x[1] + info->post_crop_w[1];
+			x_max = max(x_max, val);
+			y_min = min(y_min, info->post_crop_y[1]);
+			val = info->post_crop_y[1] + info->post_crop_h[1];
+			y_max = max(y_max, val);
+		}
+		x = x_min;
+		y = y_min;
+		w = x_max - x_min;
+		h = y_max - y_min;
+	} else if (info->post_enable_flag[1]) {
+		/* POST0 is disabled and POST1 is enabled */
+		x = info->post_crop_x[1];
+		w = info->post_crop_w[1];
+		y = info->post_crop_y[1];
+		h = info->post_crop_h[1];
+	} else {
+		/* All POSTs are disabled */
+		x = 0;
+		y = 0;
+		w = HWD_VIIF_CROP_MIN_W;
+		h = HWD_VIIF_CROP_MIN_H;
+	}
+	writel(x, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_H);
+	writel(y, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_V);
+	writel(w, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_HSIZE);
+	writel(h, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_VSIZE);
+
+	for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
+		if (info->post_enable_flag[i])
+			writel(0, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+		else
+			writel(HWD_VIIF_L2_ROI_NONE, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+	}
+}
+
+/**
+ * hwd_viif_l2_set_roi_num_2() - Set ROI path condition when ROI num is 2
+ */
+static void hwd_viif_l2_set_roi_num_2(struct hwd_viif_res *res)
+{
+	struct hwd_viif_l2_roi_path_info *info = &res->l2_roi_path_info;
+	u32 i;
+
+	for (i = 0; i < HWD_VIIF_L2_ROI_MAX_NUM; i++) {
+		/* ROI-n is the same as CROP area of POST-n */
+		if (info->post_enable_flag[i]) {
+			writel(info->post_crop_x[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H);
+			writel(info->post_crop_y[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V);
+			writel(info->post_crop_w[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE);
+			writel(info->post_crop_h[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE);
+			writel(i, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+		} else {
+			writel(0, &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H);
+			writel(0, &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V);
+			writel(HWD_VIIF_CROP_MIN_W,
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE);
+			writel(HWD_VIIF_CROP_MIN_H,
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE);
+			writel(HWD_VIIF_L2_ROI_NONE, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+		}
+	}
+}
+
+/**
+ * hwd_viif_l2_set_roi_path() - Set ROI path condition
+ */
+static void hwd_viif_l2_set_roi_path(struct hwd_viif_res *res)
+{
+	if (res->l2_roi_path_info.roi_num == 1U)
+		hwd_viif_l2_set_roi_num_1(res);
+	else
+		hwd_viif_l2_set_roi_num_2(res);
+}
+
+/**
+ * hwd_viif_l2_set_roi() - Set ROI parameters of L2ISP
+ *
+ * @param: Pointer to ROI parameters of L2ISP
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "param" is NULL
+ * - [2] Member of "param" is invalid
+ *
+ * see also: #hwd_viif_l2_set_roi_path
+ */
+s32 hwd_viif_l2_set_roi(struct hwd_viif_res *res, const struct viif_l2_roi_config *param)
+{
+	u32 val;
+	int i;
+
+	if (!param)
+		return -EINVAL;
+
+	if (param->roi_num < 1 || param->roi_num > 2)
+		return -EINVAL;
+
+	for (i = 0; i < 2; i++) {
+		if (param->roi_scale[i] < HWD_VIIF_L2_ROI_MIN_SCALE ||
+		    param->roi_scale[i] > HWD_VIIF_L2_ROI_MAX_SCALE ||
+		    param->roi_scale_inv[i] < HWD_VIIF_L2_ROI_MIN_SCALE_INV ||
+		    param->roi_scale_inv[i] > HWD_VIIF_L2_ROI_MAX_SCALE_INV ||
+		    param->corrected_wo_scale_hsize[i] <
+			    HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE ||
+		    param->corrected_wo_scale_hsize[i] >
+			    HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE ||
+		    param->corrected_wo_scale_vsize[i] <
+			    HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE ||
+		    param->corrected_wo_scale_vsize[i] >
+			    HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE ||
+		    param->corrected_hsize[i] < HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE ||
+		    param->corrected_hsize[i] > HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE ||
+		    param->corrected_vsize[i] < HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE ||
+		    param->corrected_vsize[i] > HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE) {
+			return -EINVAL;
+		}
+	}
+
+	/* Set the number of ROI and update resource info with roi_num */
+	writel(param->roi_num, &res->capture_reg->l2isp.L2_ROI_NUM);
+	res->l2_roi_path_info.roi_num = param->roi_num;
+
+	/* Update ROI area and input to each POST */
+	hwd_viif_l2_set_roi_path(res);
+
+	/* Set the remaining parameters */
+	for (i = 0; i < 2; i++) {
+		writel(param->roi_scale[i], &res->capture_reg->l2isp.roi[i].L2_ROI_SCALE);
+		writel(param->roi_scale_inv[i], &res->capture_reg->l2isp.roi[i].L2_ROI_SCALE_INV);
+		val = (param->corrected_wo_scale_hsize[i] << 13U) | param->corrected_hsize[i];
+		writel(val, &res->capture_reg->l2isp.roi[i].L2_ROI_CORRECTED_HSIZE);
+		val = (param->corrected_wo_scale_vsize[i] << 12U) | param->corrected_vsize[i];
+		writel(val, &res->capture_reg->l2isp.roi[i].L2_ROI_CORRECTED_VSIZE);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_gamma() - Set Gamma correction parameters of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @enable: or disable gamma correction of L2ISP. For more refer @ref hwd_viif_enable_flag.
+ * @vsplit: changing line position from 1st table to 2nd table [0..4094]
+ * @mode: Gamma correction mode. For more refer @ref hwd_viif_gamma_table_mode.
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id", "enable", "vsplit"  or "mode" is out of range
+ * - [2] "vsplit" is not 0 when "enable" is HWD_VIIF_DISABLE
+ * - [3] "mode" is not HWD_VIIF_GAMMA_COMPRESSED when enable is HWD_VIIF_DISABLE
+ *
+ * see also: #hwd_viif_l2_set_gamma
+ */
+s32 hwd_viif_l2_set_gamma(struct hwd_viif_res *res, u32 post_id, u32 enable, u32 vsplit, u32 mode)
+{
+	u32 val;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM ||
+	    (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE) ||
+	    vsplit > HWD_VIIF_GAMMA_MAX_VSPLIT ||
+	    (mode != HWD_VIIF_GAMMA_COMPRESSED && mode != HWD_VIIF_GAMMA_LINEAR) ||
+	    (enable == HWD_VIIF_DISABLE && vsplit != 0x0U) ||
+	    (enable == HWD_VIIF_DISABLE && mode != HWD_VIIF_GAMMA_COMPRESSED)) {
+		return -EINVAL;
+	}
+
+	/* Set gamma parameters of L2ISP */
+	val = (vsplit << 16U) | (mode << 4U) | enable;
+	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_GAMMA_M);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_gamma_table_transmission() - Configure L2ISP transferring gamma table.
+ *
+ * @post_id: POST ID [0..1]
+ * @gamma_table: Pointer to gamma table information
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" is out of range
+ * - [2] Member of "gamma_table" is invalid
+ */
+s32 hwd_viif_l2_set_gamma_table_transmission(struct hwd_viif_res *res, u32 post_id,
+					     const struct hwd_viif_l2_gamma_table *gamma_table)
+{
+	u32 vdm_enable = 0U;
+	u32 i, base_addr;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	for (i = 0; i < 6U; i++) {
+		if ((gamma_table->table[i] % HWD_VIIF_L2_VDM_ALIGN) != 0U)
+			return -EINVAL;
+	}
+
+	/* table[0]: LUT0-G/Y: t_port[12 + post_id * 6] */
+	/* table[1]: LUT1-G/Y: t_port[13 + post_id * 6] */
+	/* table[2]: LUT0-B/U: t_port[14 + post_id * 6] */
+	/* table[3]: LUT1-B/U: t_port[15 + post_id * 6] */
+	/* table[4]: LUT0-R/V: t_port[16 + post_id * 6] */
+	/* table[5]: LUT1-R/V: t_port[17 + post_id * 6] */
+	for (i = 0; i < 6U; i++) {
+		if (gamma_table->table[i] != 0U) {
+			int idx = 12U + i + post_id * 6U;
+
+			writel((u32)gamma_table->table[i],
+			       &res->capture_reg->vdm.t_port[idx].VDM_T_STADR);
+			writel(HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE,
+			       &res->capture_reg->vdm.t_port[idx].VDM_T_SIZE);
+			vdm_enable |= BIT(i);
+		}
+	}
+	if (vdm_enable != 0U) {
+		/* t_group[2..3] is used only to transfer GAMMA table */
+		/* [2]: POST0, [3]: POST1 */
+		writel(HWD_VIIF_VDM_CFG_PARAM,
+		       &res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_CFG);
+		base_addr = HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE +
+			    (HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE * post_id);
+		writel(base_addr, &res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_SRAM_BASE);
+		writel(HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE,
+		       &res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_SRAM_SIZE);
+		vdm_enable = vdm_enable << (12U + (post_id * 6U));
+	}
+	vdm_enable |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) &
+		       ~((u32)0x3fU << (12U + (post_id * 6U))));
+	writel(vdm_enable, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_output_csc() - Set output CSC parameters of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @param: Pointer to output csc parameters of L2ISP
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" is out of range
+ * - [2] Member of "param" is invalid
+ */
+s32 hwd_viif_l2_set_output_csc(struct hwd_viif_res *res, u32 post_id,
+			       const struct hwd_viif_csc_param *param)
+{
+	struct hwd_viif_l2isp_post_reg *reg_l2isp_post;
+	u32 i, val;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	/* disable csc matrix when param is NULL */
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l2isp.post[post_id].csc.MTB);
+		return 0;
+	}
+
+	/* param is specified: go further check */
+	if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
+		if (param->coef[i] > HWD_VIIF_CSC_MAX_COEF_VALUE)
+			return -EINVAL;
+	}
+
+	reg_l2isp_post = &res->capture_reg->l2isp.post[post_id];
+
+	writel(param->g_y_in_offset, &reg_l2isp_post->csc.MTB_YG_OFFSETI);
+	writel(param->coef[0], &reg_l2isp_post->csc.MTB_YG1);
+	val = (param->coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
+	      (param->coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
+	writel(val, &reg_l2isp_post->csc.MTB_YG2);
+	writel(param->g_y_out_offset, &reg_l2isp_post->csc.MTB_YG_OFFSETO);
+	writel(param->b_cb_in_offset, &reg_l2isp_post->csc.MTB_CB_OFFSETI);
+	writel(param->coef[3], &reg_l2isp_post->csc.MTB_CB1);
+	val = (param->coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
+	      (param->coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
+	writel(val, &reg_l2isp_post->csc.MTB_CB2);
+	writel(param->b_cb_out_offset, &reg_l2isp_post->csc.MTB_CB_OFFSETO);
+	writel(param->r_cr_in_offset, &reg_l2isp_post->csc.MTB_CR_OFFSETI);
+	writel(param->coef[6], &reg_l2isp_post->csc.MTB_CR1);
+	val = (param->coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
+	      (param->coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
+	writel(val, &reg_l2isp_post->csc.MTB_CR2);
+	writel(param->r_cr_out_offset, &reg_l2isp_post->csc.MTB_CR_OFFSETO);
+	writel(HWD_VIIF_ENABLE, &reg_l2isp_post->csc.MTB);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_img_transmission() - Set image transfer condition of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @enable: or disable image transfer of MAIN unit. For more refer @ref hwd_viif_enable_flag.
+ * @src: Pointer to crop area information
+ * @out_process: Pointer to output process information
+ * @img: Pointer to output image information
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" or "enable" is out of range
+ * - [2] "src" or "out_process" is NULL when "enable" is HWD_VIIF_ENABLE
+ * - [3] "src" or "out_process" is not NULL when "enable" is HWD_VIIF_DISABLE
+ * - [4] Member of "src" is out of range
+ * - [5] "w" of "src" is not equal to 2 * "width" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
+ * - [6] "h" of "src" is not equal to 2 * "height" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
+ * - [7] "w" of "src" is not equal to "width" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
+ * - [8] "h" of "src" is not equal to "height" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
+ * - [9] Member of "out_process" is invalid
+ * - [10] "alpha" of "out_process" is not 0 when "format" of "img" is not HWD_VIIF_ARGB8888_PACKED
+ * - [11] "format" of "img" is not HWD_VIIF_ONE_COLOR_8 or HWD_VIIF_ONE_COLOR_16
+ *   when "select_color" of "out_process"
+ *   is HWD_VIIF_COLOR_Y_G, HWD_VIIF_COLOR_U_B or HWD_VIIF_COLOR_V_R
+ * - [12] Member of "img" is invalid
+ *
+ * see also: #hwd_viif_l2_set_roi_path
+ */
+s32 hwd_viif_l2_set_img_transmission(struct hwd_viif_res *res, u32 post_id, u32 enable,
+				     const struct hwd_viif_img_area *src,
+				     const struct hwd_viif_out_process *out_process,
+				     const struct hwd_viif_img *img)
+{
+	u32 pitch[HWD_VIIF_MAX_PLANE_NUM], img_start_addr[HWD_VIIF_MAX_PLANE_NUM];
+	u32 i, val, loop, k, r[HWD_VIIF_MAX_PLANE_NUM];
+	s32 ret = 0;
+
+	/* pitch alignment for planar or one color format */
+	u32 pitch_align = 128U;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM ||
+	    (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE) ||
+	    (enable == HWD_VIIF_ENABLE && (!src || !out_process)) ||
+	    (enable == HWD_VIIF_DISABLE && (src || out_process))) {
+		return -EINVAL;
+	}
+
+	/* DISABLE: no DMA transmission setup, set minimum crop rectangle */
+	if (enable == HWD_VIIF_DISABLE) {
+		res->l2_roi_path_info.post_enable_flag[post_id] = false;
+		res->l2_roi_path_info.post_crop_x[post_id] = 0U;
+		res->l2_roi_path_info.post_crop_y[post_id] = 0U;
+		res->l2_roi_path_info.post_crop_w[post_id] = HWD_VIIF_CROP_MIN_W;
+		res->l2_roi_path_info.post_crop_h[post_id] = HWD_VIIF_CROP_MIN_H;
+		hwd_viif_l2_set_roi_path(res);
+
+		return 0;
+	}
+
+	/* further parameter check for ENABLE */
+	if (out_process->half_scale != HWD_VIIF_ENABLE &&
+	    out_process->half_scale != HWD_VIIF_DISABLE) {
+		return -EINVAL;
+	}
+
+	if (out_process->select_color != HWD_VIIF_COLOR_Y_G &&
+	    out_process->select_color != HWD_VIIF_COLOR_U_B &&
+	    out_process->select_color != HWD_VIIF_COLOR_V_R &&
+	    out_process->select_color != HWD_VIIF_COLOR_YUV_RGB) {
+		return -EINVAL;
+	}
+
+	if (img->format != HWD_VIIF_ARGB8888_PACKED && out_process->alpha != 0U)
+		return -EINVAL;
+
+	if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U) ||
+	    img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH ||
+	    img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT ||
+	    img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP ||
+	    img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP) {
+		return -EINVAL;
+	}
+
+	if (src->x > HWD_VIIF_CROP_MAX_X_ISP || src->y > HWD_VIIF_CROP_MAX_Y_ISP ||
+	    src->w < HWD_VIIF_CROP_MIN_W || src->w > HWD_VIIF_CROP_MAX_W_ISP ||
+	    src->h < HWD_VIIF_CROP_MIN_H || src->h > HWD_VIIF_CROP_MAX_H_ISP) {
+		return -EINVAL;
+	}
+
+	if (out_process->half_scale == HWD_VIIF_ENABLE) {
+		if ((src->w != (img->width * 2U)) || (src->h != (img->height * 2U)))
+			return -EINVAL;
+	} else {
+		if (src->w != img->width || src->h != img->height)
+			return -EINVAL;
+	}
+
+	if (out_process->select_color == HWD_VIIF_COLOR_Y_G ||
+	    out_process->select_color == HWD_VIIF_COLOR_U_B ||
+	    out_process->select_color == HWD_VIIF_COLOR_V_R) {
+		if (img->format != HWD_VIIF_ONE_COLOR_8 && img->format != HWD_VIIF_ONE_COLOR_16)
+			return -EINVAL;
+	}
+
+	/* build DMAC parameter */
+	switch (img->format) {
+	case HWD_VIIF_YCBCR422_8_PACKED:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 2U;
+		r[0] = 1U;
+		pitch_align = 256U;
+		break;
+	case HWD_VIIF_RGB888_PACKED:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 3U;
+		r[0] = 1U;
+		pitch_align = 384U;
+		break;
+	case HWD_VIIF_ARGB8888_PACKED:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 4U;
+		r[0] = 1U;
+		pitch_align = 512U;
+		break;
+	case HWD_VIIF_ONE_COLOR_8:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 1U;
+		r[0] = 1U;
+		break;
+	case HWD_VIIF_ONE_COLOR_16:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 2U;
+		r[0] = 1U;
+		break;
+	case HWD_VIIF_YCBCR422_8_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 1U;
+		r[0] = 1U;
+		r[1] = 2U;
+		r[2] = 2U;
+		break;
+	case HWD_VIIF_RGB888_YCBCR444_8_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 1U;
+		r[0] = 1U;
+		r[1] = 1U;
+		r[2] = 1U;
+		break;
+	case HWD_VIIF_YCBCR422_16_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 2U;
+		r[0] = 1U;
+		r[1] = 2U;
+		r[2] = 2U;
+		break;
+	case HWD_VIIF_RGB161616_YCBCR444_16_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 2U;
+		r[0] = 1U;
+		r[1] = 1U;
+		r[2] = 1U;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < loop; i++) {
+		val = max(((img->width * k) / r[i]), 128U);
+		if (pitch[i] < val || pitch[i] > HWD_VIIF_MAX_PITCH_ISP ||
+		    ((pitch[i] % pitch_align) != 0U) || ((img_start_addr[i] % 4U) != 0U)) {
+			return -EINVAL;
+		}
+	}
+
+	writel(img_start_addr[0], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_G);
+	writel(pitch[0], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_G);
+	if (loop == HWD_VIIF_MAX_PLANE_NUM) {
+		writel(img_start_addr[1],
+		       &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_B);
+		writel(img_start_addr[2],
+		       &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_R);
+		writel(pitch[1], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_B);
+		writel(pitch[2], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_R);
+	}
+
+	/* Set CROP */
+	val = (src->y << 16U) | src->x;
+	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_OFFSET);
+	val = (src->h << 16U) | src->w;
+	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_SIZE);
+
+	/* Set output process */
+	writel(out_process->half_scale,
+	       &res->capture_reg->l2isp.post[post_id].L2_POST_HALF_SCALE_EN);
+	writel(out_process->select_color, &res->capture_reg->l2isp.post[post_id].L2_POST_C_SELECT);
+	writel((u32)out_process->alpha, &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTALP);
+	writel(img->format, &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTFMT);
+
+	/* Update ROI area and input to each POST */
+	res->l2_roi_path_info.post_enable_flag[post_id] = true;
+	res->l2_roi_path_info.post_crop_x[post_id] = src->x;
+	res->l2_roi_path_info.post_crop_y[post_id] = src->y;
+	res->l2_roi_path_info.post_crop_w[post_id] = src->w;
+	res->l2_roi_path_info.post_crop_h[post_id] = src->h;
+	hwd_viif_l2_set_roi_path(res);
+
+	return ret;
+}
+
+/**
+ * hwd_viif_l2_set_irq_mask() - Set mask condition for L2ISP
+ *
+ * @mask: L2ISP mask condition
+ * Return: None
+ */
+void hwd_viif_l2_set_irq_mask(struct hwd_viif_res *res, u32 mask)
+{
+	writel(mask, &res->capture_reg->l2isp.L2_CRGBF_ISP_INT_MASK);
+}
+
+/**
+ * hwd_viif_csi2rx_err_irq_handler() - CSI-2 RX error interruption handler
+ *
+ * Return: event information of CSI-2 RX error interruption
+ */
+u32 hwd_viif_csi2rx_err_irq_handler(struct hwd_viif_res *res)
+{
+	return readl(&res->csi2host_reg->CSI2RX_INT_ST_MAIN);
+}
+
+/**
+ * hwd_viif_status_err_irq_handler() - STATUS error interruption handler
+ *
+ * @event_main: information of STATUS error interruption of MAIN unit
+ * @event_sub: information of STATUS error interruption of SUB unit(CH0 and CH1)
+ * Return: None
+ */
+void hwd_viif_status_err_irq_handler(struct hwd_viif_res *res, u32 *event_main, u32 *event_sub)
+{
+	u32 val, mask;
+
+	*event_main = HWD_VIIF_NO_EVENT;
+	*event_sub = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->sys.INT_M_STATUS);
+	mask = readl(&res->capture_reg->sys.INT_M_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_M_STATUS);
+		*event_main = val;
+	}
+
+	val = readl(&res->capture_reg->sys.INT_S_STATUS);
+	mask = readl(&res->capture_reg->sys.INT_S_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_S_STATUS);
+		*event_sub = val;
+	}
+}
+
+/**
+ * hwd_viif_vsync_irq_handler() - Vsync interruption handler
+ *
+ * @event_main: information of Vsync interruption of MAIN unit
+ * @event_sub: information of Vsync interruption of SUB unit(CH0 and CH1)
+ * Return: None
+ */
+void hwd_viif_vsync_irq_handler(struct hwd_viif_res *res, u32 *event_main, u32 *event_sub)
+{
+	u32 val, mask;
+
+	*event_main = HWD_VIIF_NO_EVENT;
+	*event_sub = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->sys.INT_M_SYNC);
+	mask = readl(&res->capture_reg->sys.INT_M_SYNC_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_M_SYNC);
+		*event_main = val;
+	}
+
+	val = readl(&res->capture_reg->sys.INT_S_SYNC);
+	mask = readl(&res->capture_reg->sys.INT_S_SYNC_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_S_SYNC);
+		*event_sub = val;
+	}
+}
+
+/**
+ * hwd_viif_isp_regbuf_irq_handler() - ISP register buffer interruption handler
+ *
+ * @event_l1: information of register buffer interruption of L1ISP
+ * @event_l2: information of register buffer interruption of L2ISP
+ * Return: None
+ */
+void hwd_viif_isp_regbuf_irq_handler(struct hwd_viif_res *res, u32 *event_l1, u32 *event_l2)
+{
+	u32 val;
+
+	*event_l1 = HWD_VIIF_NO_EVENT;
+	*event_l2 = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->l1isp.L1_CRGBF_INT_MASKED_STAT);
+	if (val != HWD_VIIF_NO_EVENT) {
+		*event_l1 = val;
+		writel(val, &res->capture_reg->l1isp.L1_CRGBF_INT_STAT);
+	}
+
+	val = readl(&res->capture_reg->l2isp.L2_CRGBF_INT_MASKED_STAT);
+	if (val != HWD_VIIF_NO_EVENT) {
+		*event_l2 = val;
+		writel(val, &res->capture_reg->l2isp.L2_CRGBF_INT_STAT);
+	}
+}
diff --git a/drivers/media/platform/visconti/hwd_viif.h b/drivers/media/platform/visconti/hwd_viif.h
new file mode 100644
index 00000000000..100afda8436
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.h
@@ -0,0 +1,710 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef HWD_VIIF_H
+#define HWD_VIIF_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <linux/visconti_viif.h>
+
+enum hwd_power_ctrl {
+	HWD_POWER_OFF = 0, /**< Power off */
+	HWD_POWER_ON /**< Power on  */
+};
+
+/* MIPI CSI2 Data Types */
+#define VISCONTI_CSI2_DT_YUV4228B  0x1E
+#define VISCONTI_CSI2_DT_YUV42210B 0x1F
+#define VISCONTI_CSI2_DT_RGB565	   0x22
+#define VISCONTI_CSI2_DT_RGB888	   0x24
+#define VISCONTI_CSI2_DT_RAW8	   0x2A
+#define VISCONTI_CSI2_DT_RAW10	   0x2B
+#define VISCONTI_CSI2_DT_RAW12	   0x2C
+#define VISCONTI_CSI2_DT_RAW14	   0x2D
+
+/* hwd_viif_enable_flag */
+#define HWD_VIIF_DISABLE (0U)
+#define HWD_VIIF_ENABLE	 (1U)
+
+/* hwd_viif_memory_sync_type */
+#define HWD_VIIF_MEM_SYNC_INTERNAL (0U)
+#define HWD_VIIF_MEM_SYNC_CSI2	   (1U)
+
+/* hwd_viif_color_format */
+#define HWD_VIIF_YCBCR422_8_PACKED	      (0U)
+#define HWD_VIIF_RGB888_PACKED		      (1U)
+#define HWD_VIIF_ARGB8888_PACKED	      (3U)
+#define HWD_VIIF_YCBCR422_8_PLANAR	      (8U)
+#define HWD_VIIF_RGB888_YCBCR444_8_PLANAR     (9U)
+#define HWD_VIIF_ONE_COLOR_8		      (11U)
+#define HWD_VIIF_YCBCR422_16_PLANAR	      (12U)
+#define HWD_VIIF_RGB161616_YCBCR444_16_PLANAR (13U)
+#define HWD_VIIF_ONE_COLOR_16		      (15U)
+
+/* hwd_viif_raw_pack_mode */
+#define HWD_VIIF_RAWPACK_DISABLE  (0U)
+#define HWD_VIIF_RAWPACK_MSBFIRST (2U)
+#define HWD_VIIF_RAWPACK_LSBFIRST (3U)
+
+/* hwd_viif_yuv_conversion_mode */
+#define HWD_VIIF_YUV_CONV_REPEAT	(0U)
+#define HWD_VIIF_YUV_CONV_INTERPOLATION (1U)
+
+/* hwd_viif_gamma_table_mode */
+#define HWD_VIIF_GAMMA_COMPRESSED (0U)
+#define HWD_VIIF_GAMMA_LINEAR	  (1U)
+
+/* hwd_viif_output_color_mode */
+#define HWD_VIIF_COLOR_Y_G     (0U)
+#define HWD_VIIF_COLOR_U_B     (1U)
+#define HWD_VIIF_COLOR_V_R     (2U)
+#define HWD_VIIF_COLOR_YUV_RGB (4U)
+
+/* hwd_viif_hw_params */
+#define HWD_VIIF_MAX_CH	       (6U)
+#define HWD_VIIF_MAX_PLANE_NUM (3U)
+
+/**
+ * enum hwd_viif_csi2_dphy - D-PHY Lane assignment
+ *
+ * specifies which line(L0-L3) is assigned to D0-D3
+ */
+enum hwd_viif_csi2_dphy {
+	HWD_VIIF_CSI2_DPHY_L0L1L2L3 = 0U,
+	HWD_VIIF_CSI2_DPHY_L0L3L1L2 = 1U,
+	HWD_VIIF_CSI2_DPHY_L0L2L3L1 = 2U,
+	HWD_VIIF_CSI2_DPHY_L0L1L3L2 = 4U,
+	HWD_VIIF_CSI2_DPHY_L0L3L2L1 = 5U,
+	HWD_VIIF_CSI2_DPHY_L0L2L1L3 = 6U
+};
+
+/* hwd_viif_csi2rx_cal_status */
+#define HWD_VIIF_CSI2_CAL_NOT_DONE (0U)
+#define HWD_VIIF_CSI2_CAL_SUCCESS  (1U)
+#define HWD_VIIF_CSI2_CAL_FAIL	   (2U)
+
+/* hwd_viif_csi2rx_not_capture */
+#define HWD_VIIF_CSI2_NOT_CAPTURE (-1) /**< csi2 not capture */
+
+/* hwd_viif_l1_input_mode */
+#define HWD_VIIF_L1_INPUT_HDR		  (0U)
+#define HWD_VIIF_L1_INPUT_PWL		  (1U)
+#define HWD_VIIF_L1_INPUT_SDR		  (2U)
+#define HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT (3U)
+#define HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT (4U)
+
+/* hwd_viif_l1_raw_color_filter_mode */
+#define HWD_VIIF_L1_RAW_GR_R_B_GB (0U)
+#define HWD_VIIF_L1_RAW_R_GR_GB_B (1U)
+#define HWD_VIIF_L1_RAW_B_GB_GR_R (2U)
+#define HWD_VIIF_L1_RAW_GB_B_R_GR (3U)
+
+/* hwd_viif_l1_input_interpolation_mode */
+#define HWD_VIIF_L1_INPUT_INTERPOLATION_LINE  (0U)
+#define HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL (1U)
+
+/* hwd_viif_l1_img_sens */
+#define HWD_VIIF_L1_IMG_SENSITIVITY_HIGH       (0U)
+#define HWD_VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED (1U)
+#define HWD_VIIF_L1_IMG_SENSITIVITY_LOW	       (2U)
+
+/* hwd_viif_l1_dpc */
+#define HWD_VIIF_L1_DPC_1PIXEL (0U)
+#define HWD_VIIF_L1_DPC_2PIXEL (1U)
+
+/* hwd_viif_l1_rcnr_hry_type */
+#define HWD_VIIF_L1_RCNR_LOW_RESOLUTION	       (0U)
+#define HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION     (1U)
+#define HWD_VIIF_L1_RCNR_HIGH_RESOLUTION       (2U)
+#define HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION (3U)
+
+/* hwd_viif_l1_rcnr_msf_blend_ratio */
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 (0U)
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 (1U)
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 (2U)
+
+/* hwd_viif_l1_hdrs */
+#define HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE (0U)
+#define HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE	   (1U)
+
+/* hwd_viif_l1_lsc_para_mag */
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH (0U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH (1U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND (2U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST  (3U)
+
+/* hwd_viif_l1_lsc_grid_mag */
+#define HWD_VIIF_L1_GRID_COEF_GAIN_X1 (0U)
+#define HWD_VIIF_L1_GRID_COEF_GAIN_X2 (1U)
+
+/* hwd_viif_l1_demosaic */
+#define HWD_VIIF_L1_DEMOSAIC_ACPI (0U)
+#define HWD_VIIF_L1_DEMOSAIC_DMG  (1U)
+
+/* hwd_viif_l1_awb_restart_cond */
+/* macros for L1ISP condition to restart auto white balance */
+#define HWD_VIIF_L1_AWB_RESTART_NO	 (0U)
+#define HWD_VIIF_L1_AWB_RESTART_128FRAME (1U)
+#define HWD_VIIF_L1_AWB_RESTART_64FRAME	 (2U)
+#define HWD_VIIF_L1_AWB_RESTART_32FRAME	 (3U)
+#define HWD_VIIF_L1_AWB_RESTART_16FRAME	 (4U)
+#define HWD_VIIF_L1_AWB_RESTART_8FRAME	 (5U)
+#define HWD_VIIF_L1_AWB_RESTART_4FRAME	 (6U)
+#define HWD_VIIF_L1_AWB_RESTART_2FRAME	 (7U)
+
+/* hwd_viif_l1_awb_mag */
+#define HWD_VIIF_L1_AWB_ONE_SECOND (0U)
+#define HWD_VIIF_L1_AWB_X1	   (1U)
+#define HWD_VIIF_L1_AWB_X2	   (2U)
+#define HWD_VIIF_L1_AWB_X4	   (3U)
+
+/* hwd_viif_l1_awb_area_mode */
+#define HWD_VIIF_L1_AWB_AREA_MODE0 (0U)
+#define HWD_VIIF_L1_AWB_AREA_MODE1 (1U)
+#define HWD_VIIF_L1_AWB_AREA_MODE2 (2U)
+#define HWD_VIIF_L1_AWB_AREA_MODE3 (3U)
+
+/* hwd_viif_l1_hdrc_tone_type */
+#define HWD_VIIF_L1_HDRC_TONE_USER   (0U)
+#define HWD_VIIF_L1_HDRC_TONE_PRESET (1U)
+
+/* hwd_viif_l1_bin_mode */
+#define HWD_VIIF_L1_HIST_BIN_MODE_LINEAR (0U)
+#define HWD_VIIF_L1_HIST_BIN_MODE_LOG	 (1U)
+
+/* hwd_viif_l2_undist_mode */
+#define HWD_VIIF_L2_UNDIST_POLY		(0U)
+#define HWD_VIIF_L2_UNDIST_GRID		(1U)
+#define HWD_VIIF_L2_UNDIST_POLY_TO_GRID (2U)
+#define HWD_VIIF_L2_UNDIST_GRID_TO_POLY (3U)
+
+/**
+ * struct hwd_viif_csi2rx_line_err_target
+ *
+ * Virtual Channel and Data Type pair for CSI2RX line error monitor
+ *
+ * When 0 is set to dt, line error detection is disabled.
+ *
+ * * VC can be 0 .. 3
+ * * DT can be 0 or 0x10 .. 0x3F
+ */
+#define VISCONTI_CSI2_ERROR_MONITORS_NUM 8
+struct hwd_viif_csi2rx_line_err_target {
+	u32 vc[VISCONTI_CSI2_ERROR_MONITORS_NUM];
+	u32 dt[VISCONTI_CSI2_ERROR_MONITORS_NUM];
+};
+
+/**
+ * struct hwd_viif_csi2rx_irq_mask
+ * @mask: mask setting for CSI2RX error interruption
+ *
+ * * mask[0]: D-PHY fatal error
+ * * mask[1]: Packet fatal error
+ * * mask[2]: Frame fatal error
+ * * mask[3]: D-PHY error
+ * * mask[4]: Packet error
+ * * mask[5]: Line error
+ */
+#define VISCONTI_CSI2RX_IRQ_MASKS_NUM	      6
+#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_FATAL   0
+#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_FATAL 1
+#define VISCONTI_CSI2RX_IRQ_MASK_FRAME_FATAL  2
+#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_ERROR   3
+#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_ERROR 4
+#define VISCONTI_CSI2RX_IRQ_MASK_LINE_ERROR   5
+struct hwd_viif_csi2rx_irq_mask {
+	u32 mask[VISCONTI_CSI2RX_IRQ_MASKS_NUM];
+};
+
+/**
+ * struct hwd_viif_csi2rx_packet - CSI2 packet information
+ * @word_count: word count included in one packet[byte] [0..16384]
+ * @packet_num: the number of packet included in one packet [0..8192]
+ *
+ * each element means as below.
+ * * [0]: embedded data of MAIN unit
+ * * [1]: long packet data of MAIN unit
+ * * [2]: embedded data of SUB unit
+ * * [3]: long packet data of SUB unit
+ *
+ * Regarding word_count of long packet data,
+ * word count of odd line needs to be set in case of DT = 0x18, 0x19, 0x1C or 0x1D.
+ */
+#define VISCONTI_CSI2RX_PACKET_TYPES_NUM      4
+#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN  0
+#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN 1
+#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB   2
+#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB  3
+struct hwd_viif_csi2rx_packet {
+	u32 word_count[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
+	u32 packet_num[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
+};
+
+/**
+ * struct hwd_viif_pixelmap - pixelmap information
+ * @pmap_paddr: start address of pixel data(physical address). 4byte alignment.
+ * @pitch: pitch size of pixel map[byte]
+ *
+ * Condition of pitch in case of L2ISP output is as below.
+ * * max: 32704[byte]
+ * * min: the larger value of (active width of image * k / r) and 128[byte]
+ * * alignment: 64[byte]
+ *
+ * Condition of pitch in the other cases is as below.
+ * * max: 65536[byte]
+ * * min: active width of image * k / r[byte]
+ * * alignment: 4[byte]
+ *
+ * k is the size of 1 pixel and the value is as below.
+ * * HWD_VIIF_YCBCR422_8_PACKED: 2
+ * * HWD_VIIF_RGB888_PACKED: 3
+ * * HWD_VIIF_ARGB8888_PACKED: 4
+ * * HWD_VIIF_YCBCR422_8_PLANAR: 1
+ * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR: 1
+ * * HWD_VIIF_ONE_COLOR_8: 1
+ * * HWD_VIIF_YCBCR422_16_PLANAR: 2
+ * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR: 2
+ * * HWD_VIIF_ONE_COLOR_16: 2
+ *
+ * r is the correction factor for Cb or Cr of YCbCr422 planar and the value is as below.
+ * * YCbCr422 Cb-planar: 2
+ * * YCbCr422 Cr-planar: 2
+ * * others: 1
+ *
+ */
+struct hwd_viif_pixelmap {
+	uintptr_t pmap_paddr;
+	u32 pitch;
+};
+
+/**
+ * struct hwd_viif_img - image information
+ * @width: active width of image[pixel]
+ * * [128..5760](output from L2ISP)
+ * * [128..4096](input to MAIN unit(memory input))
+ * * [128..4096](output from SUB unit)
+ * * The value should be even.
+ *
+ * @height: active height of image[line]
+ * * [128..3240](output from L2ISP)
+ * * [128..2160](input to MAIN unit(memory input))
+ * * [128..2160](output from SUB unit)
+ * * The value should be even.
+ *
+ * @format: hwd_viif_color_format "color format"
+ * * Below color formats are supported for input and output of MAIN unit
+ * * HWD_VIIF_YCBCR422_8_PACKED
+ * * HWD_VIIF_RGB888_PACKED
+ * * HWD_VIIF_ARGB8888_PACKED
+ * * HWD_VIIF_YCBCR422_8_PLANAR
+ * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR
+ * * HWD_VIIF_ONE_COLOR_8
+ * * HWD_VIIF_YCBCR422_16_PLANAR
+ * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR
+ * * HWD_VIIF_ONE_COLOR_16
+ * * Below color formats are supported for output of SUB unit
+ * * HWD_VIIF_ONE_COLOR_8
+ * * HWD_VIIF_ONE_COLOR_16
+ *
+ * @pixelmap: pixelmap information
+ * * [0]: Y/G-planar, packed/Y/RAW
+ * * [1]: Cb/B-planar
+ * * [2]: Cr/R-planar
+ */
+struct hwd_viif_img {
+	u32 width;
+	u32 height;
+	u32 format;
+	struct hwd_viif_pixelmap pixelmap[3];
+};
+
+/**
+ * struct hwd_viif_input_img - input image information
+ * @pixel_clock: pixel clock [3375..600000] [kHz]. 0 needs to be set for long packet data.
+ * @htotal_size: horizontal total size
+ * * [143..65535] [pixel] for image data
+ * * [239..109225] [ns] for long packet data
+ * @hactive_size: horizontal active size [pixel]
+ * * [128..4096] without L1ISP
+ * * [640..3840] with L1ISP
+ * * The value should be even. In addition, the value should be a multiple of 8 with L1ISP
+ * * 0 needs to be set for the configuration of long packet data or SUB unit output.
+ * @vtotal_size: vertical total size [line]
+ * * [144..16383] for image data
+ * * 0 needs to be set for the configuration of long packet data.
+ * @vbp_size: vertical back porch size
+ * * [5..4095] [line] for image data
+ * * [5..4095] [the number of packet] for long packet data
+ * @vactive_size: vertical active size [line]
+ * * [128..2160] without L1ISP
+ * * [480..2160] with L1ISP
+ * * The value should be even.
+ * * 0 needs to be set for the configuration of long packet data.
+ * @interpolation_mode: input image interpolation mode for hwd_viif_l1_input_interpolation_mode
+ * * HWD_VIIF_L1_INPUT_INTERPOLATION_LINE needs to be set in the below cases.
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ * @input_num: the number of input images [1..3]
+ * * 1 needs to be set in the below cases.
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ * @hobc_width: the number of horizontal optical black pixels [0,16,32,64 or 128]
+ * * 0 needs to be set in the below cases.
+ * * in case of hobc_margin = 0
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ * @hobc_margin: the number of horizontal optical black margin[0..30] (even number)
+ * * 0 needs to be set in the below cases.
+ * * in case of hobc_width = 0
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ *
+ * Below conditions need to be satisfied.
+ * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_LINE:
+ *   (htotal_size > (hactive_size + hobc_width + hobc_margin)) &&
+ *   (vtotal_size > (vbp_size + vactive_size * input_num))
+ * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL:
+ *   (htotal_size > ((hactive_size + hobc_width + hobc_margin) * input_num)) &&
+ *   (vtotal_size > (vbp_size + vactive_size))
+ * * L1ISP is used:
+ *   vbp_size >= (54720[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 38 + ISST time
+ * * L1ISP is not used:
+ *   vbp_size >= (39360[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 16 + ISST time
+ *
+ * Note: L1ISP is used when RAW data is input to MAIN unit
+ */
+struct hwd_viif_input_img {
+	u32 pixel_clock;
+	u32 htotal_size;
+	u32 hactive_size;
+	u32 vtotal_size;
+	u32 vbp_size;
+	u32 vactive_size;
+	u32 interpolation_mode;
+	u32 input_num;
+	u32 hobc_width;
+	u32 hobc_margin;
+};
+
+/**
+ * struct hwd_viif_csc_param - color conversion information
+ * @r_cr_in_offset: input offset of R/Cr[pix value] [0x0..0x1FFFF]
+ * @g_y_in_offset: input offset of G/Y[pix value] [0x0..0x1FFFF]
+ * @b_cb_in_offset: input offset of B/Cb[pix value] [0x0..0x1FFFF]
+ * @coef: coefficient of matrix [0x0..0xFFFF]
+ * * [0] : c00(YG_YG), [1] : c01(UB_YG), [2] : c02(VR_YG),
+ * * [3] : c10(YG_UB), [4] : c11(UB_UB), [5] : c12(VR_UB),
+ * * [6] : c20(YG_VR), [7] : c21(UB_VR), [8] : c22(VR_VR)
+ * @r_cr_out_offset: output offset of R/Cr[pix value] [0x0..0x1FFFF]
+ * @g_y_out_offset: output offset of G/Y[pix value] [0x0..0x1FFFF]
+ * @b_cb_out_offset: output offset of B/Cb[pix value] [0x0..0x1FFFF]
+ */
+struct hwd_viif_csc_param {
+	u32 r_cr_in_offset;
+	u32 g_y_in_offset;
+	u32 b_cb_in_offset;
+	u32 coef[9];
+	u32 r_cr_out_offset;
+	u32 g_y_out_offset;
+	u32 b_cb_out_offset;
+};
+
+/**
+ * struct hwd_viif_img_area - image area definition
+ * @x: x position [0..8062] [pixel]
+ * @y: y position [0..3966] [line]
+ * @w: image width [128..8190] [pixel]
+ * @h: image height [128..4094] [line]
+ */
+struct hwd_viif_img_area {
+	u32 x;
+	u32 y;
+	u32 w;
+	u32 h;
+};
+
+/**
+ * struct hwd_viif_out_process - configuration of output process of MAIN unit and L2ISP
+ * @half_scale: hwd_viif_enable_flag "enable or disable half scale"
+ * @select_color: hwd_viif_output_color_mode "select output color"
+ * @alpha: alpha value used in case of ARGB8888 output [0..255]
+ */
+struct hwd_viif_out_process {
+	u32 half_scale;
+	u32 select_color;
+	u8 alpha;
+};
+
+/**
+ * struct hwd_viif_l1_lsc - HWD L1ISP lens shading correction parameters
+ * @lssc_parabola_param: parabola shading correction parameter
+ * * NULL: disable parabola shading correction
+ * * not NULL: enable parabola shading correction
+ * @lssc_grid_param: grid shading correction parameter
+ * * NULL: disable grid shading correction
+ * * not NULL: enable grid shading correction
+ * @lssc_pwhb_r_gain_max: maximum R gain of preset white balance correction
+ * @lssc_pwhb_r_gain_min: minimum R gain of preset white balance correction
+ * @lssc_pwhb_gr_gain_max: maximum Gr gain of preset white balance correction
+ * @lssc_pwhb_gr_gain_min: minimum Gr gain of preset white balance correction
+ * @lssc_pwhb_gb_gain_max: maximum Gb gain of preset white balance correction
+ * @lssc_pwhb_gb_gain_min: minimum Gb gain of preset white balance correction
+ * @lssc_pwhb_b_gain_max: maximum B gain of preset white balance correction
+ * @lssc_pwhb_b_gain_min: minimum B gain of preset white balance correction
+ *
+ * Range and accuracy of lssc_pwhb_xxx_gain_xxx are as below.
+ * - range: [0x0..0x7FF]
+ * - accuracy : 1/256
+ */
+struct hwd_viif_l1_lsc {
+	struct viif_l1_lsc_parabola_param *lssc_parabola_param;
+	struct viif_l1_lsc_grid_param *lssc_grid_param;
+	u32 lssc_pwhb_r_gain_max;
+	u32 lssc_pwhb_r_gain_min;
+	u32 lssc_pwhb_gr_gain_max;
+	u32 lssc_pwhb_gr_gain_min;
+	u32 lssc_pwhb_gb_gain_max;
+	u32 lssc_pwhb_gb_gain_min;
+	u32 lssc_pwhb_b_gain_max;
+	u32 lssc_pwhb_b_gain_min;
+};
+
+/**
+ * struct hwd_viif_l1_img_quality_adjustment - HWD L1ISP image quality adjustment parameters
+ * @coef_cb: Cb coefficient [0x0..0xffff] accuracy: 1/65536
+ * @coef_cr: Cr coefficient [0x0..0xffff] accuracy: 1/65536
+ * @brightness: brightness value [-32768..32767] (0 means off.)
+ * @linear_contrast: linear contrast value [0x0..0xff] accuracy: 1/128 (128 means off.)
+ * @*nonlinear_contrast: pointer to nonlinear contrast parameter
+ * @*lum_noise_reduction: pointer to luminance noise reduction parameter
+ * @*edge_enhancement: pointer to edge enhancement parameter
+ * @*uv_suppression: pointer to UV suppression parameter
+ * @*coring_suppression: pointer to coring suppression parameter
+ * @*edge_suppression: pointer to edge enhancement parameter
+ * @*color_level: pointer to color level adjustment parameter
+ * @color_noise_reduction_enable: enable/disable color noise reduction @ref hwd_viif_enable_flag
+ */
+struct hwd_viif_l1_img_quality_adjustment {
+	u16 coef_cb;
+	u16 coef_cr;
+	s16 brightness;
+	u8 linear_contrast;
+	struct viif_l1_nonlinear_contrast *nonlinear_contrast;
+	struct viif_l1_lum_noise_reduction *lum_noise_reduction;
+	struct viif_l1_edge_enhancement *edge_enhancement;
+	struct viif_l1_uv_suppression *uv_suppression;
+	struct viif_l1_coring_suppression *coring_suppression;
+	struct viif_l1_edge_suppression *edge_suppression;
+	struct viif_l1_color_level *color_level;
+	u32 color_noise_reduction_enable;
+};
+
+/**
+ * struct hwd_viif_l1_info - HWD L1ISP processing information
+ * @context_id: context id
+ * @ag_cont_hobc_high: analog gain for high sensitivity image of OBCC
+ * @ag_cont_hobc_middle_led: analog gain for middle sensitivity or led image of OBCC
+ * @ag_cont_hobc_low: analog gain for low sensitivity image of OBCC
+ * @ag_cont_abpc_high: analog gain for high sensitivity image of ABPC
+ * @ag_cont_abpc_middle_led: analog gain for middle sensitivity or led image of ABPC
+ * @ag_cont_abpc_low: analog gain for low sensitivity image of ABPC
+ * @ag_cont_rcnr_high: analog gain for high sensitivity image of RCNR
+ * @ag_cont_rcnr_middle_led: analog gain for middle sensitivity or led image of RCNR
+ * @ag_cont_rcnr_low: analog gain for low sensitivity image of RCNR
+ * @ag_cont_lssc: analog gain for LSSC
+ * @ag_cont_mpro: analog gain for color matrix correction
+ * @ag_cont_vpro: analog gain for image quality adjustment
+ * @dpc_defect_num_h:
+ *     the number of dynamically corrected defective pixel(high sensitivity image)
+ * @dpc_defect_num_m:
+ *     the number of dynamically corrected defective pixel(middle sensitivity or led image)
+ * @dpc_defect_num_l:
+ *     the number of dynamically corrected defective pixel(low sensitivity image)
+ * @hdrc_tnp_fb_smth_max: the maximum value of luminance information after smoothing filter at HDRC
+ * @avg_lum_weight: weighted average luminance value at average luminance generation
+ * @avg_lum_block[8][8]:
+ *     average luminance of each block [y][x]:
+ *     y means vertical position and x means horizontal position.
+ * @avg_lum_four_line_lum[4]:
+ *     4-lines average luminance. avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
+ * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
+ * @avg_black_pixnum: the number of black pixel at average luminance generation
+ * @awb_ave_u: average U at AWHB [pixel]
+ * @awb_ave_v: average V at AWHB [pixel]
+ * @awb_accumulated_pixel: the number of accumulated pixel at AWHB
+ * @awb_gain_r: R gain applied in the next frame at AWHB
+ * @awb_gain_g: G gain applied in the next frame at AWHB
+ * @awb_gain_b: B gain applied in the next frame at AWHB
+ * @awb_status_u: status of U convergence at AWHB (true: converged, false: not converged)
+ * @awb_status_v: status of V convergence at AWHB (true: converged, false: not converged)
+ */
+struct hwd_viif_l1_info {
+	u32 context_id;
+	u8 ag_cont_hobc_high;
+	u8 ag_cont_hobc_middle_led;
+	u8 ag_cont_hobc_low;
+	u8 ag_cont_abpc_high;
+	u8 ag_cont_abpc_middle_led;
+	u8 ag_cont_abpc_low;
+	u8 ag_cont_rcnr_high;
+	u8 ag_cont_rcnr_middle_led;
+	u8 ag_cont_rcnr_low;
+	u8 ag_cont_lssc;
+	u8 ag_cont_mpro;
+	u8 ag_cont_vpro;
+	u32 dpc_defect_num_h;
+	u32 dpc_defect_num_m;
+	u32 dpc_defect_num_l;
+	u32 hdrc_tnp_fb_smth_max;
+	u32 avg_lum_weight;
+	u32 avg_lum_block[8][8];
+	u32 avg_lum_four_line_lum[4];
+	u16 avg_satur_pixnum;
+	u16 avg_black_pixnum;
+	u32 awb_ave_u;
+	u32 awb_ave_v;
+	u32 awb_accumulated_pixel;
+	u32 awb_gain_r;
+	u32 awb_gain_g;
+	u32 awb_gain_b;
+	bool awb_status_u;
+	bool awb_status_v;
+};
+
+/**
+ * struct hwd_viif_l2_gamma_table - HWD L2ISP Gamma table physical address
+ * @table[6]: table address(physical address) 4byte alignment
+ *
+ * relation between element and table is as below.
+ * * [0]: G/Y(1st table)
+ * * [1]: G/Y(2nd table)
+ * * [2]: B/U(1st table)
+ * * [3]: B/U(2nd table)
+ * * [4]: R/V(1st table)
+ * * [5]: R/V(2nd table)
+ *
+ * when 0 is set to table address, table transfer is disabled.
+ */
+struct hwd_viif_l2_gamma_table {
+	uintptr_t table[6];
+};
+
+struct hwd_viif_res;
+
+/* VIIF common */
+u32 hwd_viif_csi2rx_err_irq_handler(struct hwd_viif_res *res);
+void hwd_viif_status_err_irq_handler(struct hwd_viif_res *res, u32 *event_main, u32 *event_sub);
+void hwd_viif_vsync_irq_handler(struct hwd_viif_res *res, u32 *event_main, u32 *event_sub);
+void hwd_viif_isp_regbuf_irq_handler(struct hwd_viif_res *res, u32 *event_l1, u32 *event_l2);
+
+/* control MAIN unit */
+s32 hwd_viif_main_set_unit(struct hwd_viif_res *res, u32 dt_image,
+			   const struct hwd_viif_input_img *in_img, u32 color_type, u32 rawpack,
+			   u32 yuv_conv);
+s32 hwd_viif_main_mask_vlatch(struct hwd_viif_res *res, u32 enable);
+void hwd_viif_main_status_err_set_irq_mask(struct hwd_viif_res *res, u32 mask);
+void hwd_viif_main_vsync_set_irq_mask(struct hwd_viif_res *res, u32 mask);
+
+/* conrol SUB unit */
+s32 hwd_viif_sub_set_unit(struct hwd_viif_res *res, u32 dt_image,
+			  const struct hwd_viif_input_img *in_img);
+s32 hwd_viif_sub_set_img_transmission(struct hwd_viif_res *res, const struct hwd_viif_img *img);
+void hwd_viif_sub_status_err_set_irq_mask(struct hwd_viif_res *res, u32 mask);
+void hwd_viif_sub_vsync_set_irq_mask(struct hwd_viif_res *res, u32 mask);
+
+/* control MIPI CSI2 Receiver unit */
+s32 hwd_viif_csi2rx_initialize(struct hwd_viif_res *res, u32 num_lane, u32 lane_assign,
+			       u32 dphy_rate, u32 rext_calibration,
+			       const struct hwd_viif_csi2rx_line_err_target *err_target,
+			       const struct hwd_viif_csi2rx_irq_mask *mask);
+s32 hwd_viif_csi2rx_uninitialize(struct hwd_viif_res *res);
+s32 hwd_viif_csi2rx_start(struct hwd_viif_res *res, s32 vc_main, s32 vc_sub,
+			  const struct hwd_viif_csi2rx_packet *packet);
+s32 hwd_viif_csi2rx_stop(struct hwd_viif_res *res);
+s32 hwd_viif_csi2rx_get_calibration_status(
+	struct hwd_viif_res *res, struct viif_csi2rx_dphy_calibration_status *calibration_status);
+s32 hwd_viif_csi2rx_get_err_status(struct hwd_viif_res *res, u32 *err_phy_fatal, u32 *err_pkt_fatal,
+				   u32 *err_frame_fatal, u32 *err_phy, u32 *err_pkt, u32 *err_line);
+
+/* control L1 Image Signal Processor */
+void hwd_viif_isp_set_regbuf_auto_transmission(struct hwd_viif_res *res);
+void hwd_viif_isp_disable_regbuf_auto_transmission(struct hwd_viif_res *res);
+void hwd_viif_isp_get_info(struct hwd_viif_res *res, struct hwd_viif_l1_info *l1_info,
+			   u32 *l2_transfer_status);
+void hwd_viif_isp_set_regbuf_irq_mask(struct hwd_viif_res *res, const u32 *mask_l1,
+				      const u32 *mask_l2);
+
+s32 hwd_viif_l1_set_input_mode(struct hwd_viif_res *res, u32 mode, u32 depth, u32 raw_color_filter);
+s32 hwd_viif_l1_set_rgb_to_y_coef(struct hwd_viif_res *res, u16 coef_r, u16 coef_g, u16 coef_b);
+s32 hwd_viif_l1_set_ag_mode(struct hwd_viif_res *res, const struct viif_l1_ag_mode_config *param);
+s32 hwd_viif_l1_set_ag(struct hwd_viif_res *res, u16 gain_h, u16 gain_m, u16 gain_l);
+s32 hwd_viif_l1_set_hdre(struct hwd_viif_res *res, const struct viif_l1_hdre_config *param);
+s32 hwd_viif_l1_set_img_extraction(struct hwd_viif_res *res, u32 input_black_gr, u32 input_black_r,
+				   u32 input_black_b, u32 input_black_gb);
+s32 hwd_viif_l1_set_dpc(struct hwd_viif_res *res, const struct viif_l1_dpc *param_h,
+			const struct viif_l1_dpc *param_m, const struct viif_l1_dpc *param_l);
+s32 hwd_viif_l1_set_dpc_table_transmission(struct hwd_viif_res *res, uintptr_t table_h,
+					   uintptr_t table_m, uintptr_t table_l);
+s32 hwd_viif_l1_set_preset_white_balance(struct hwd_viif_res *res, u32 dstmaxval,
+					 const struct viif_l1_preset_wb *param_h,
+					 const struct viif_l1_preset_wb *param_m,
+					 const struct viif_l1_preset_wb *param_l);
+s32 hwd_viif_l1_set_raw_color_noise_reduction(
+	struct hwd_viif_res *res, const struct viif_l1_raw_color_noise_reduction *param_h,
+	const struct viif_l1_raw_color_noise_reduction *param_m,
+	const struct viif_l1_raw_color_noise_reduction *param_l);
+s32 hwd_viif_l1_set_hdrs(struct hwd_viif_res *res, const struct viif_l1_hdrs_config *param);
+s32 hwd_viif_l1_set_black_level_correction(
+	struct hwd_viif_res *res, const struct viif_l1_black_level_correction_config *param);
+s32 hwd_viif_l1_set_lsc(struct hwd_viif_res *res, const struct hwd_viif_l1_lsc *param);
+s32 hwd_viif_l1_set_lsc_table_transmission(struct hwd_viif_res *res, uintptr_t table_gr,
+					   uintptr_t table_r, uintptr_t table_b,
+					   uintptr_t table_gb);
+s32 hwd_viif_l1_set_main_process(struct hwd_viif_res *res, u32 demosaic_mode, u32 damp_lsbsel,
+				 const struct viif_l1_color_matrix_correction *color_matrix,
+				 u32 dst_maxval);
+s32 hwd_viif_l1_set_awb(struct hwd_viif_res *res, const struct viif_l1_awb *param, u32 awhb_wbmrg,
+			u32 awhb_wbmgg, u32 awhb_wbmbg);
+s32 hwd_viif_l1_lock_awb_gain(struct hwd_viif_res *res, u32 enable);
+s32 hwd_viif_l1_set_hdrc(struct hwd_viif_res *res, const struct viif_l1_hdrc *param,
+			 u32 hdrc_thr_sft_amt);
+s32 hwd_viif_l1_set_hdrc_ltm(struct hwd_viif_res *res, const struct viif_l1_hdrc_ltm_config *param);
+s32 hwd_viif_l1_set_gamma(struct hwd_viif_res *res, const struct viif_l1_gamma *param);
+s32 hwd_viif_l1_set_img_quality_adjustment(struct hwd_viif_res *res,
+					   const struct hwd_viif_l1_img_quality_adjustment *param);
+s32 hwd_viif_l1_set_avg_lum_generation(struct hwd_viif_res *res,
+				       const struct viif_l1_avg_lum_generation_config *param);
+void hwd_viif_l1_set_irq_mask(struct hwd_viif_res *res, u32 mask);
+
+/* control L2 Image Signal Processor */
+s32 hwd_viif_l2_set_input_csc(struct hwd_viif_res *res, const struct hwd_viif_csc_param *param,
+			      bool is_l1_rgb);
+s32 hwd_viif_l2_set_undist(struct hwd_viif_res *res, const struct viif_l2_undist *param);
+s32 hwd_viif_l2_set_undist_table_transmission(struct hwd_viif_res *res, uintptr_t write_g,
+					      uintptr_t read_b, uintptr_t read_g, uintptr_t read_r,
+					      u32 size);
+s32 hwd_viif_l2_set_roi(struct hwd_viif_res *res, const struct viif_l2_roi_config *param);
+s32 hwd_viif_l2_set_gamma(struct hwd_viif_res *res, u32 post_id, u32 enable, u32 vsplit, u32 mode);
+s32 hwd_viif_l2_set_gamma_table_transmission(struct hwd_viif_res *res, u32 post_id,
+					     const struct hwd_viif_l2_gamma_table *gamma_table);
+s32 hwd_viif_l2_set_output_csc(struct hwd_viif_res *res, u32 post_id,
+			       const struct hwd_viif_csc_param *param);
+s32 hwd_viif_l2_set_img_transmission(struct hwd_viif_res *res, u32 post_id, u32 enable,
+				     const struct hwd_viif_img_area *src,
+				     const struct hwd_viif_out_process *out_process,
+				     const struct hwd_viif_img *img);
+void hwd_viif_l2_set_irq_mask(struct hwd_viif_res *res, u32 mask);
+
+void hwd_viif_isp_guard_start(struct hwd_viif_res *res);
+void hwd_viif_isp_guard_end(struct hwd_viif_res *res);
+
+struct hwd_viif_res *allocate_viif_res(struct device *dev, void *csi2host_vaddr,
+				       void *capture_vaddr);
+
+#endif /* HWD_VIIF_H */
diff --git a/drivers/media/platform/visconti/hwd_viif_csi2rx.c b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
new file mode 100644
index 00000000000..f49869c5bdd
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/timekeeping.h>
+#include "hwd_viif.h"
+#include "hwd_viif_internal.h"
+
+#define CSI2_DT_YUV4208	  0x18
+#define CSI2_DT_YUV42010  0x19
+#define CSI2_DT_YUV4208L  0x1A
+#define CSI2_DT_YUV4208C  0x1C
+#define CSI2_DT_YUV42010C 0x1D
+#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
+#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
+#define CSI2_DT_RGB444	  0x20
+#define CSI2_DT_RGB555	  0x21
+#define CSI2_DT_RGB565	  VISCONTI_CSI2_DT_RGB565
+#define CSI2_DT_RGB666	  0x23
+#define CSI2_DT_RGB888	  VISCONTI_CSI2_DT_RGB888
+#define CSI2_DT_RAW8	  VISCONTI_CSI2_DT_RAW8
+#define CSI2_DT_RAW10	  VISCONTI_CSI2_DT_RAW10
+#define CSI2_DT_RAW12	  VISCONTI_CSI2_DT_RAW12
+#define CSI2_DT_RAW14	  VISCONTI_CSI2_DT_RAW14
+
+#define TESTCTRL0_PHY_TESTCLK_1	     0x2
+#define TESTCTRL0_PHY_TESTCLK_0	     0x0
+#define TESTCTRL1_PHY_TESTEN	     0x10000
+#define TESTCTRL1_PHY_TESTDOUT_SHIFT 8U
+
+/**
+ * write_dphy_param() - Write CSI2RX DPHY params
+ *
+ * @test_mode: test code address
+ * @test_in: test code data
+ * Return: None
+ */
+static void write_dphy_param(u32 test_mode, u8 test_in, struct hwd_viif_res *res)
+{
+	/* select MSB address register */
+	writel(TESTCTRL1_PHY_TESTEN, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* set MSB address of test_mode */
+	writel(FIELD_GET(0xF00, test_mode), &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* select and set LSB address register */
+	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
+	       &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* set the test code data */
+	writel((u32)test_in, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+}
+
+/**
+ * read_dphy_param() - Read CSI2RX DPHY params
+ *
+ * @test_mode: test code address
+ * Return: test code data
+ */
+static u8 read_dphy_param(u32 test_mode, struct hwd_viif_res *res)
+{
+	u32 read_data;
+
+	/* select MSB address register */
+	writel(TESTCTRL1_PHY_TESTEN, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* set MSB address of test_mode */
+	writel(FIELD_GET(0xF00, test_mode), &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* select and set LSB address register */
+	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
+	       &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* read the test code data */
+	read_data = readl(&res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+	return (u8)(read_data >> TESTCTRL1_PHY_TESTDOUT_SHIFT);
+}
+
+/**
+ * enum dphy_testcode - DPHY registers via the local communication path
+ */
+enum dphy_testcode {
+	DIG_RDWR_RX_SYS_0 = 0x001,
+	DIG_RDWR_RX_SYS_1 = 0x002,
+	DIG_RDWR_RX_SYS_3 = 0x004,
+	DIG_RDWR_RX_SYS_7 = 0x008,
+	DIG_RDWR_RX_RX_STARTUP_OVR_2 = 0x0E2,
+	DIG_RDWR_RX_RX_STARTUP_OVR_3 = 0x0E3,
+	DIG_RDWR_RX_RX_STARTUP_OVR_4 = 0x0E4,
+	DIG_RDWR_RX_RX_STARTUP_OVR_5 = 0x0E5,
+	DIG_RDWR_RX_CB_2 = 0x1AC,
+	DIG_RD_RX_TERM_CAL_0 = 0x220,
+	DIG_RD_RX_TERM_CAL_1 = 0x221,
+	DIG_RD_RX_TERM_CAL_2 = 0x222,
+	DIG_RDWR_RX_CLKLANE_LANE_6 = 0x307,
+	DIG_RD_RX_CLKLANE_OFFSET_CAL_0 = 0x39D,
+	DIG_RD_RX_LANE0_OFFSET_CAL_0 = 0x59F,
+	DIG_RD_RX_LANE0_DDL_0 = 0x5E0,
+	DIG_RD_RX_LANE1_OFFSET_CAL_0 = 0x79F,
+	DIG_RD_RX_LANE1_DDL_0 = 0x7E0,
+	DIG_RD_RX_LANE2_OFFSET_CAL_0 = 0x99F,
+	DIG_RD_RX_LANE2_DDL_0 = 0x9E0,
+	DIG_RD_RX_LANE3_OFFSET_CAL_0 = 0xB9F,
+	DIG_RD_RX_LANE3_DDL_0 = 0xBE0,
+};
+
+#define SYS_0_HSFREQRANGE_OVR  BIT(5)
+#define SYS_7_RESERVED	       FIELD_PREP(0x1F, 0x0C)
+#define SYS_7_DESKEW_POL       BIT(5)
+#define STARTUP_OVR_4_CNTVAL   FIELD_PREP(0x70, 0x01)
+#define STARTUP_OVR_4_DDL_EN   BIT(0)
+#define STARTUP_OVR_5_BYPASS   BIT(0)
+#define CB_2_LPRX_BIAS	       BIT(6)
+#define CB_2_RESERVED	       FIELD_PREP(0x3F, 0x0B)
+#define CLKLANE_RXHS_PULL_LONG BIT(7)
+
+static const struct hwd_viif_dphy_hs_info dphy_hs_info[] = {
+	{ 80, 0x0, 0x1cc },   { 85, 0x10, 0x1cc },   { 95, 0x20, 0x1cc },   { 105, 0x30, 0x1cc },
+	{ 115, 0x1, 0x1cc },  { 125, 0x11, 0x1cc },  { 135, 0x21, 0x1cc },  { 145, 0x31, 0x1cc },
+	{ 155, 0x2, 0x1cc },  { 165, 0x12, 0x1cc },  { 175, 0x22, 0x1cc },  { 185, 0x32, 0x1cc },
+	{ 198, 0x3, 0x1cc },  { 213, 0x13, 0x1cc },  { 228, 0x23, 0x1cc },  { 243, 0x33, 0x1cc },
+	{ 263, 0x4, 0x1cc },  { 288, 0x14, 0x1cc },  { 313, 0x25, 0x1cc },  { 338, 0x35, 0x1cc },
+	{ 375, 0x5, 0x1cc },  { 425, 0x16, 0x1cc },  { 475, 0x26, 0x1cc },  { 525, 0x37, 0x1cc },
+	{ 575, 0x7, 0x1cc },  { 625, 0x18, 0x1cc },  { 675, 0x28, 0x1cc },  { 725, 0x39, 0x1cc },
+	{ 775, 0x9, 0x1cc },  { 825, 0x19, 0x1cc },  { 875, 0x29, 0x1cc },  { 925, 0x3a, 0x1cc },
+	{ 975, 0xa, 0x1cc },  { 1025, 0x1a, 0x1cc }, { 1075, 0x2a, 0x1cc }, { 1125, 0x3b, 0x1cc },
+	{ 1175, 0xb, 0x1cc }, { 1225, 0x1b, 0x1cc }, { 1275, 0x2b, 0x1cc }, { 1325, 0x3c, 0x1cc },
+	{ 1375, 0xc, 0x1cc }, { 1425, 0x1c, 0x1cc }, { 1475, 0x2c, 0x1cc }
+};
+
+/**
+ * get_dphy_hs_transfer_info() - Get DPHY HS info from table
+ *
+ * @dphy_rate: DPHY clock in MHz
+ * @hsfreqrange: HS Frequency Range
+ * @osc_freq_target: OSC Frequency Target
+ * Return: None
+ */
+static void get_dphy_hs_transfer_info(u32 dphy_rate, u32 *hsfreqrange, u32 *osc_freq_target,
+				      struct hwd_viif_res *res)
+{
+	int table_size = ARRAY_SIZE(dphy_hs_info);
+	int i;
+
+	for (i = 1; i < table_size; i++) {
+		if (dphy_rate < dphy_hs_info[i].rate) {
+			*hsfreqrange = dphy_hs_info[i - 1].hsfreqrange;
+			*osc_freq_target = dphy_hs_info[i - 1].osc_freq_target;
+			return;
+		}
+	}
+
+	/* not found; return the largest entry */
+	*hsfreqrange = dphy_hs_info[table_size - 1].hsfreqrange;
+	*osc_freq_target = dphy_hs_info[table_size - 1].osc_freq_target;
+}
+
+/**
+ * hwd_viif_csi2rx_set_dphy_rate() - Set D-PHY rate
+ *
+ * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
+ * Return: None
+ */
+static void hwd_viif_csi2rx_set_dphy_rate(u32 dphy_rate, struct hwd_viif_res *res)
+{
+	u32 hsfreqrange, osc_freq_target;
+
+	get_dphy_hs_transfer_info(dphy_rate, &hsfreqrange, &osc_freq_target, res);
+
+	write_dphy_param(DIG_RDWR_RX_SYS_1, (u8)hsfreqrange, res);
+	write_dphy_param(DIG_RDWR_RX_SYS_0, SYS_0_HSFREQRANGE_OVR, res);
+	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_5, STARTUP_OVR_5_BYPASS, res);
+	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL, res);
+	write_dphy_param(DIG_RDWR_RX_CB_2, CB_2_LPRX_BIAS | CB_2_RESERVED, res);
+	write_dphy_param(DIG_RDWR_RX_SYS_7, SYS_7_DESKEW_POL | SYS_7_RESERVED, res);
+	write_dphy_param(DIG_RDWR_RX_CLKLANE_LANE_6, CLKLANE_RXHS_PULL_LONG, res);
+	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_2, FIELD_GET(0xff, osc_freq_target), res);
+	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_3, FIELD_GET(0xf00, osc_freq_target), res);
+	write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL | STARTUP_OVR_4_DDL_EN,
+			 res);
+
+	writel(HWD_VIIF_DPHY_CFG_CLK_25M, &res->capture_reg->sys.DPHY_FREQRANGE);
+}
+
+/**
+ * check_dphy_calibration_status() - Check D-PHY calibration status
+ *
+ * @test_mode: test code related to calibration information
+ * @shift_val_err: shift value related to error information
+ * @shift_val_done: shift value related to done information
+ * Return: HWD_VIIF_CSI2_CAL_NOT_DONE calibration is not done(out of target or not completed)
+ * Return: HWD_VIIF_CSI2_CAL_FAIL calibration was failed
+ * Return: HWD_VIIF_CSI2_CAL_SUCCESS calibration was succeeded
+ */
+static u32 check_dphy_calibration_status(u32 test_mode, u32 shift_val_err, u32 shift_val_done,
+					 struct hwd_viif_res *res)
+{
+	u32 read_data = (u32)read_dphy_param(test_mode, res);
+
+	if (!(read_data & BIT(shift_val_done)))
+		return HWD_VIIF_CSI2_CAL_NOT_DONE;
+
+	/* error check is not required for termination calibration with REXT(0x221) */
+	if (test_mode == DIG_RD_RX_TERM_CAL_1)
+		return HWD_VIIF_CSI2_CAL_SUCCESS;
+
+	/* done with error */
+	if (read_data & BIT(shift_val_err))
+		return HWD_VIIF_CSI2_CAL_FAIL;
+
+	return HWD_VIIF_CSI2_CAL_SUCCESS;
+}
+
+/**
+ * hwd_viif_csi2rx_initialize() - Initialize CSI-2 RX driver
+ *
+ * @num_lane: [1..4](VIIF CH0-CH1)
+ * @lane_assign: lane connection. For more refer @ref hwd_viif_dphy_lane_assignment
+ * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
+ * @rext_calibration: enable or disable rext calibration.
+ *                    For more refer @ref hwd_viif_csi2rx_cal_status
+ * @err_target: Pointer to configuration for Line error detection.
+ * @mask: MASK of CSI-2 RX error interruption
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "num_lane", "lane_assign", "dphy_rate", "rext_calibration" or "input_mode" is out of range
+ * - [2] "err_target" is NULL
+ * - [3] member of "err_target" is invalid
+ */
+s32 hwd_viif_csi2rx_initialize(struct hwd_viif_res *res, u32 num_lane, u32 lane_assign,
+			       u32 dphy_rate, u32 rext_calibration,
+			       const struct hwd_viif_csi2rx_line_err_target *err_target,
+			       const struct hwd_viif_csi2rx_irq_mask *mask)
+{
+	u32 i, val;
+
+	if (num_lane == 0U || num_lane > 4U || lane_assign > HWD_VIIF_CSI2_DPHY_L0L2L1L3)
+		return -EINVAL;
+
+	if (dphy_rate < HWD_VIIF_DPHY_MIN_DATA_RATE || dphy_rate > HWD_VIIF_DPHY_MAX_DATA_RATE ||
+	    (rext_calibration != HWD_VIIF_ENABLE && rext_calibration != HWD_VIIF_DISABLE) ||
+	    !err_target) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 8U; i++) {
+		if (err_target->vc[i] > HWD_VIIF_CSI2_MAX_VC ||
+		    err_target->dt[i] > HWD_VIIF_CSI2_MAX_DT ||
+		    (err_target->dt[i] < HWD_VIIF_CSI2_MIN_DT && err_target->dt[i] != 0U)) {
+			return -EINVAL;
+		}
+	}
+
+	/* 1st phase of initialization */
+	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_RESETN);
+	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
+	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
+	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	ndelay(15U);
+	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* Configure D-PHY frequency range */
+	hwd_viif_csi2rx_set_dphy_rate(dphy_rate, res);
+
+	/* 2nd phase of initialization */
+	writel((num_lane - 1U), &res->csi2host_reg->CSI2RX_NLANES);
+	ndelay(5U);
+
+	/* configuration not to use rext */
+	if (rext_calibration == HWD_VIIF_DISABLE) {
+		write_dphy_param(0x004, 0x10, res);
+		ndelay(5U);
+	}
+
+	/* Release D-PHY from Reset */
+	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
+	ndelay(5U);
+	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
+
+	/* configuration of line error target */
+	val = (err_target->vc[3] << 30U) | (err_target->dt[3] << 24U) | (err_target->vc[2] << 22U) |
+	      (err_target->dt[2] << 16U) | (err_target->vc[1] << 14U) | (err_target->dt[1] << 8U) |
+	      (err_target->vc[0] << 6U) | (err_target->dt[0]);
+	writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_1);
+	val = (err_target->vc[7] << 30U) | (err_target->dt[7] << 24U) | (err_target->vc[6] << 22U) |
+	      (err_target->dt[6] << 16U) | (err_target->vc[5] << 14U) | (err_target->dt[5] << 8U) |
+	      (err_target->vc[4] << 6U) | (err_target->dt[4]);
+	writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_2);
+
+	/* configuration of mask */
+	writel(mask->mask[0], &res->csi2host_reg->CSI2RX_INT_MSK_PHY_FATAL);
+	writel(mask->mask[1], &res->csi2host_reg->CSI2RX_INT_MSK_PKT_FATAL);
+	writel(mask->mask[2], &res->csi2host_reg->CSI2RX_INT_MSK_FRAME_FATAL);
+	writel(mask->mask[3], &res->csi2host_reg->CSI2RX_INT_MSK_PHY);
+	writel(mask->mask[4], &res->csi2host_reg->CSI2RX_INT_MSK_PKT);
+	writel(mask->mask[5], &res->csi2host_reg->CSI2RX_INT_MSK_LINE);
+
+	/* configuration of lane assignment */
+	writel(lane_assign, &res->capture_reg->sys.DPHY_LANE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_uninitialize() - Uninitialize CSI-2 RX driver
+ *
+ * Return: 0 Operation completes successfully
+ */
+s32 hwd_viif_csi2rx_uninitialize(struct hwd_viif_res *res)
+{
+	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
+	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
+	writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_RESETN);
+
+	return 0;
+}
+
+#define PORT_SEL_MAIN_LONG  0
+#define PORT_SEL_MAIN_EMBED 1
+#define PORT_SEL_SUB_LONG   4
+#define PORT_SEL_SUB_EMBED  5
+
+static void config_vdm_wport(struct hwd_viif_res *res, int port_sel, u32 height, u32 pitch)
+{
+	struct hwd_viif_vdm_write_port_reg *wport;
+	u32 start_addr, end_addr;
+
+	wport = &res->capture_reg->vdm.w_port[port_sel];
+
+	writel(pitch, &wport->VDM_W_PITCH);
+	writel(height, &wport->VDM_W_HEIGHT);
+	start_addr = readl(&wport->VDM_W_STADR);
+	end_addr = start_addr + pitch - 1U;
+	writel(end_addr, &wport->VDM_W_ENDADR);
+}
+
+/**
+ * hwd_viif_csi2rx_start() - Start CSI-2 input
+ *
+ * @vc_main: control CSI-2 input of MAIN unit.
+ *           enable with configured VC: 0, 1, 2 or 3, keep disabling:
+ * @vc_sub: control CSI-2 input of SUB unit.
+ *          enable with configured VC: 0, 1, 2 or 3, keep disabling:
+ * @packet: Pointer to packet information of embedded data and long packet data
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * HWD_VIIF_CSI2_NOT_CAPTURE
+ * HWD_VIIF_CSI2_NOT_CAPTURE
+ * - [1] "vc_main" or "vc_sub" is out of range
+ * - [2] member of "packet" is invalid
+ */
+s32 hwd_viif_csi2rx_start(struct hwd_viif_res *res, s32 vc_main, s32 vc_sub,
+			  const struct hwd_viif_csi2rx_packet *packet)
+{
+	u32 val, i, pitch, height, dt;
+	u32 enable_vc0 = HWD_VIIF_DISABLE;
+	u32 enable_vc1 = HWD_VIIF_DISABLE;
+
+	if (vc_main > 3 || vc_main < HWD_VIIF_CSI2_NOT_CAPTURE || vc_sub > 3 ||
+	    vc_sub < HWD_VIIF_CSI2_NOT_CAPTURE) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < VISCONTI_CSI2RX_PACKET_TYPES_NUM; i++) {
+		if (packet->word_count[i] > HWD_VIIF_CSI2_MAX_WORD_COUNT ||
+		    packet->packet_num[i] > HWD_VIIF_CSI2_MAX_PACKET_NUM) {
+			return -EINVAL;
+		}
+	}
+
+	writel(HWD_VIIF_INPUT_CSI2, &res->capture_reg->sys.IPORTM);
+
+	if (vc_main != HWD_VIIF_CSI2_NOT_CAPTURE) {
+		writel((u32)vc_main, &res->capture_reg->sys.VCID0SELECT);
+		enable_vc0 = HWD_VIIF_ENABLE;
+	}
+	if (vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE) {
+		writel((u32)vc_sub, &res->capture_reg->sys.VCID1SELECT);
+		enable_vc1 = HWD_VIIF_ENABLE;
+	}
+
+	/* configure Embedded Data transfer of MAIN unit */
+	height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN];
+	pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN], 4);
+	config_vdm_wport(res, PORT_SEL_MAIN_EMBED, height, pitch);
+
+	/* configure Long Packet transfer of MAIN unit */
+	dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
+	if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208C ||
+	    dt == CSI2_DT_YUV42010C) {
+		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN], 4) +
+			ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN] * 2U, 4);
+		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN] >> 1U;
+	} else {
+		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN], 4);
+		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN];
+	}
+	config_vdm_wport(res, PORT_SEL_MAIN_LONG, height, pitch);
+
+	/* configure Embedded Data transfer of SUB unit */
+	height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB];
+	pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB], 4);
+	config_vdm_wport(res, PORT_SEL_SUB_EMBED, height, pitch);
+
+	/* configure Long Packet transfer of SUB unit */
+	dt = readl(&res->capture_reg->sys.IPORTS_OTHER);
+	if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV42010 || dt == CSI2_DT_YUV4208C ||
+	    dt == CSI2_DT_YUV42010C) {
+		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB], 4) +
+			ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB] * 2U, 4);
+		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB] >> 1U;
+	} else {
+		pitch = ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB], 4);
+		height = packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB];
+	}
+	config_vdm_wport(res, PORT_SEL_SUB_LONG, height, pitch);
+
+	/* Control VC port enable */
+	val = enable_vc0 | (enable_vc1 << 4U);
+	writel(val, &res->capture_reg->sys.VCPORTEN);
+
+	if (enable_vc0 == HWD_VIIF_ENABLE) {
+		/* Update flag information for run status of MAIN unit */
+		res->run_flag_main = true;
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_stop() - Stop CSI-2 input
+ *
+ * Return: 0 Operation completes successfully
+ * Return: -ETIMEDOUT Driver timeout error
+ */
+s32 hwd_viif_csi2rx_stop(struct hwd_viif_res *res)
+{
+	u32 status_r, status_w, status_t, l2_status;
+	u64 timeout_ns, cur_ns;
+	bool run_flag = true;
+	s32 ret = 0;
+
+	/* Disable auto transmission of register buffer */
+	writel(0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+	writel(0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+
+	/* Wait for completion of register buffer transmission */
+	udelay(HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
+
+	/* Stop all VCs, long packet input and emb data input of MAIN unit */
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.VCPORTEN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTM_OTHEREN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTM_EMBEN);
+
+	/* Stop image data input, long packet input and emb data input of SUB unit */
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_OTHEREN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_EMBEN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_IMGEN);
+
+	/* Stop VDMAC for all table ports, input ports and write ports */
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_T_ENABLE);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_R_ENABLE);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_W_ENABLE);
+
+	/* Stop all groups(g00, g01 and g02) of VDMAC */
+	writel(0x7, &res->capture_reg->vdm.VDM_ABORTSET);
+
+	timeout_ns = ktime_get_ns() + HWD_VIIF_WAIT_ABORT_COMPLETE_TIME * 1000;
+
+	do {
+		/* Get VDMAC transfer status  */
+		status_r = readl(&res->capture_reg->vdm.VDM_R_RUN);
+		status_w = readl(&res->capture_reg->vdm.VDM_W_RUN);
+		status_t = readl(&res->capture_reg->vdm.VDM_T_RUN);
+
+		l2_status = readl(&res->capture_reg->l2isp.L2_BUS_L2_STATUS);
+
+		if (status_r == 0U && status_w == 0U && status_t == 0U && l2_status == 0U)
+			run_flag = false;
+
+		cur_ns = ktime_get_ns();
+
+		if (cur_ns > timeout_ns) {
+			ret = -ETIMEDOUT;
+			run_flag = false;
+		}
+	} while (run_flag);
+
+	if (ret == 0) {
+		/* Clear run flag of MAIN unit */
+		res->run_flag_main = false;
+	}
+
+	return ret;
+}
+
+/**
+ * hwd_viif_csi2rx_get_calibration_status() - Get CSI-2 RX calibration status
+ *
+ * @calibration_status: Pointer to D-PHY calibration status information
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "calibration_status" is NULL
+ */
+s32 hwd_viif_csi2rx_get_calibration_status(
+	struct hwd_viif_res *res, struct viif_csi2rx_dphy_calibration_status *calibration_status)
+{
+	if (!calibration_status)
+		return -EINVAL;
+
+	/* arg0; test register, arg1: error bit, arg2: done bit */
+	/* 0x221: termination calibration with REXT */
+	calibration_status->term_cal_with_rext =
+		check_dphy_calibration_status(DIG_RD_RX_TERM_CAL_1, 0, 7, res);
+	/* 0x39D: clock lane offset calibration */
+	calibration_status->clock_lane_offset_cal =
+		check_dphy_calibration_status(DIG_RD_RX_CLKLANE_OFFSET_CAL_0, 4, 0, res);
+	/* 0x59F: data lane0 offset calibration */
+	calibration_status->data_lane0_offset_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE0_OFFSET_CAL_0, 2, 1, res);
+	/* 0x79F: data lane1 offset calibration */
+	calibration_status->data_lane1_offset_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE1_OFFSET_CAL_0, 2, 1, res);
+	/* 0x99F: data lane2 offset calibration */
+	calibration_status->data_lane2_offset_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE2_OFFSET_CAL_0, 2, 1, res);
+	/* 0xB9F: data lane3 offset calibration */
+	calibration_status->data_lane3_offset_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE3_OFFSET_CAL_0, 2, 1, res);
+
+	/* 0x5E0: data lane0 DDL(Digital Delay Line) calibration */
+	calibration_status->data_lane0_ddl_tuning_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE0_DDL_0, 1, 2, res);
+	/* 0x7E0: data lane1 DDL calibration */
+	calibration_status->data_lane1_ddl_tuning_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE1_DDL_0, 1, 2, res);
+	/* 0x9E0: data lane2 DDL calibration */
+	calibration_status->data_lane2_ddl_tuning_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE2_DDL_0, 1, 2, res);
+	/* 0xBE0: data lane3 DDL calibration */
+	calibration_status->data_lane3_ddl_tuning_cal =
+		check_dphy_calibration_status(DIG_RD_RX_LANE3_DDL_0, 1, 2, res);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_get_err_status() - Get CSI-2 RX error status
+ *
+ * @err_phy_fatal: Pointer to D-PHY fatal error information
+ * @err_pkt_fatal: Pointer to Packet fatal error information
+ * @err_frame_fatal: Pointer to Frame fatal error information
+ * @err_phy: Pointer to D-PHY error information
+ * @err_pkt: Pointer to Packet error information
+ * @err_line: Pointer to Line error information
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error,
+ *         when "err_phy_fatal", "err_pkt_fatal", "err_frame_fatal",
+ *         "err_phy", "err_pkt" or "err_line" is NULL
+ */
+s32 hwd_viif_csi2rx_get_err_status(struct hwd_viif_res *res, u32 *err_phy_fatal, u32 *err_pkt_fatal,
+				   u32 *err_frame_fatal, u32 *err_phy, u32 *err_pkt, u32 *err_line)
+{
+	if (!err_phy_fatal || !err_pkt_fatal || !err_frame_fatal || !err_phy || !err_pkt ||
+	    !err_line) {
+		return -EINVAL;
+	}
+	*err_phy_fatal = readl(&res->csi2host_reg->CSI2RX_INT_ST_PHY_FATAL);
+	*err_pkt_fatal = readl(&res->csi2host_reg->CSI2RX_INT_ST_PKT_FATAL);
+	*err_frame_fatal = readl(&res->csi2host_reg->CSI2RX_INT_ST_FRAME_FATAL);
+	*err_phy = readl(&res->csi2host_reg->CSI2RX_INT_ST_PHY);
+	*err_pkt = readl(&res->csi2host_reg->CSI2RX_INT_ST_PKT);
+	*err_line = readl(&res->csi2host_reg->CSI2RX_INT_ST_LINE);
+
+	return 0;
+}
diff --git a/drivers/media/platform/visconti/hwd_viif_internal.h b/drivers/media/platform/visconti/hwd_viif_internal.h
new file mode 100644
index 00000000000..c954e804946
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_internal.h
@@ -0,0 +1,340 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef HWD_VIIF_INTERNAL_H
+#define HWD_VIIF_INTERNAL_H
+
+#include "hwd_viif_reg.h"
+
+#define HWD_VIIF_CSI2_MAX_VC		    (3U)
+#define HWD_VIIF_CSI2_MIN_DT		    (0x10U)
+#define HWD_VIIF_CSI2_MAX_DT		    (0x3fU)
+#define HWD_VIIF_CSI2_MAX_WORD_COUNT	    (16384U)
+#define HWD_VIIF_CSI2_MAX_PACKET_NUM	    (8192U)
+#define HWD_VIIF_DPHY_MIN_DATA_RATE	    (80U)
+#define HWD_VIIF_DPHY_MAX_DATA_RATE	    (1500U)
+#define HWD_VIIF_DPHY_CFG_CLK_25M	    (32U)
+#define HWD_VIIF_DPHY_TRANSFER_HS_TABLE_NUM (43U)
+
+/* maximum horizontal/vertical position/dimension of CROP with ISP */
+#define HWD_VIIF_CROP_MAX_X_ISP (8062U)
+#define HWD_VIIF_CROP_MAX_Y_ISP (3966U)
+#define HWD_VIIF_CROP_MAX_W_ISP (8190U)
+#define HWD_VIIF_CROP_MAX_H_ISP (4094U)
+
+/* maximum horizontal/vertical position/dimension of CROP without ISP */
+#define HWD_VIIF_CROP_MAX_X (1920U)
+#define HWD_VIIF_CROP_MAX_Y (1408U)
+#define HWD_VIIF_CROP_MIN_W (128U)
+#define HWD_VIIF_CROP_MAX_W (2048U)
+#define HWD_VIIF_CROP_MIN_H (128U)
+#define HWD_VIIF_CROP_MAX_H (1536U)
+
+/* pixel clock: [kHz] */
+#define HWD_VIIF_MIN_PIXEL_CLOCK (3375U)
+#define HWD_VIIF_MAX_PIXEL_CLOCK (600000U)
+
+/* picture size: [pixel], [ns] */
+#define HWD_VIIF_MIN_HTOTAL_PIXEL (143U)
+#define HWD_VIIF_MIN_HTOTAL_NSEC  (239U)
+#define HWD_VIIF_MAX_HTOTAL_PIXEL (65535U)
+#define HWD_VIIF_MAX_HTOTAL_NSEC  (109225U)
+
+/* horizontal back porch size: [system clock] */
+#define HWD_VIIF_HBP_SYSCLK (10U)
+
+/* active picture size: [pixel] */
+#define HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP (128U)
+#define HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP (4096U)
+#define HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP  (640U)
+#define HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP  (3840U)
+
+/* picture vertical size: [line], [packet] */
+#define HWD_VIIF_MIN_VTOTAL_LINE	   (144U)
+#define HWD_VIIF_MAX_VTOTAL_LINE	   (16383U)
+#define HWD_VIIF_MIN_VBP_LINE		   (5U)
+#define HWD_VIIF_MAX_VBP_LINE		   (4095U)
+#define HWD_VIIF_MIN_VBP_PACKET		   (5U)
+#define HWD_VIIF_MAX_VBP_PACKET		   (4095U)
+#define HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP (128U)
+#define HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP (2160U)
+#define HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP  (480U)
+#define HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP  (2160U)
+
+/* image source select */
+#define HWD_VIIF_INPUT_CSI2 (0U)
+
+#define HWD_VIIF_CSC_MAX_OFFSET	       (0x0001FFFFU)
+#define HWD_VIIF_CSC_MAX_COEF_VALUE    (0x0000FFFFU)
+#define HWD_VIIF_CSC_MAX_COEF_NUM      (9U)
+#define HWD_VIIF_GAMMA_MAX_VSPLIT      (4094U)
+#define HWD_VIIF_MTB_CB_YG_COEF_OFFSET (16U)
+#define HWD_VIIF_MTB_CR_YG_COEF_OFFSET (0U)
+#define HWD_VIIF_MTB_CB_CB_COEF_OFFSET (16U)
+#define HWD_VIIF_MTB_CR_CB_COEF_OFFSET (0U)
+#define HWD_VIIF_MTB_CB_CR_COEF_OFFSET (16U)
+#define HWD_VIIF_MTB_CR_CR_COEF_OFFSET (0U)
+#define HWD_VIIF_MAX_PITCH_ISP	       (32704U)
+#define HWD_VIIF_MAX_PITCH	       (65536U)
+
+/* size of minimum/maximum input image */
+#define HWD_VIIF_MIN_INPUT_IMG_WIDTH	  (128U)
+#define HWD_VIIF_MAX_INPUT_IMG_WIDTH_ISP  (4096U)
+#define HWD_VIIF_MAX_INPUT_IMG_WIDTH	  (2048U)
+#define HWD_VIIF_MIN_INPUT_IMG_HEIGHT	  (128U)
+#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT_ISP (2160U)
+#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT	  (1536U)
+#define HWD_VIIF_MAX_INPUT_LINE_SIZE	  (16384U)
+
+/* size of minimum/maximum output image */
+#define HWD_VIIF_MIN_OUTPUT_IMG_WIDTH	  (128U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
+
+#define HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT	   (128U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
+
+#define HWD_VIIF_NO_EVENT (0x0U)
+
+/* System clock: [kHz] */
+#define HWD_VIIF_SYS_CLK (500000UL)
+
+/*
+ * wait time for force abort to complete(max 1line time = 1228.8[us]
+ * when width = 4096, RAW24, 80Mbps
+ */
+#define HWD_VIIF_WAIT_ABORT_COMPLETE_TIME (1229U)
+
+/*
+ * complete time of register buffer transfer.
+ * actual time is about 30us in case of L1ISP
+ */
+#define HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME (39U)
+
+/* internal operation latencies: [system clock]*/
+#define HWD_VIIF_TABLE_LOAD_TIME    (24000UL)
+#define HWD_VIIF_REGBUF_ACCESS_TIME (15360UL)
+
+/* offset of Vsync delay: [line] */
+#define HWD_VIIF_L1_DELAY_W_HDRC  (31U)
+#define HWD_VIIF_L1_DELAY_WO_HDRC (11U)
+
+/* data width is 32bit */
+#define HWD_VIIF_VDM_CFG_PARAM (0x00000210U)
+
+/* vsync mode is pulse */
+#define HWD_VIIF_DPGM_VSYNC_PULSE (1U)
+
+/* Vlatch mask bit for L1ISP and L2ISP */
+#define HWD_VIIF_ISP_VLATCH_MASK (2U)
+
+/* Register buffer */
+#define HWD_VIIF_ISP_MAX_CONTEXT_NUM	(4U)
+#define HWD_VIIF_ISP_REGBUF_MODE_BYPASS (0U)
+#define HWD_VIIF_ISP_REGBUF_MODE_BUFFER (1U)
+#define HWD_VIIF_ISP_REGBUF_READ	(1U)
+
+/* constants for L1 ISP*/
+#define HWD_VIIF_L1_INPUT_MODE_NUM			 (5U)
+#define HWD_VIIF_L1_INPUT_DEPTH_MIN			 (8U)
+#define HWD_VIIF_L1_INPUT_DEPTH_MAX			 (24U)
+#define HWD_VIIF_L1_INPUT_DEPTH_SDR_MAX			 (12U)
+#define HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX			 (14U)
+#define HWD_VIIF_L1_RAW_MODE_NUM			 (4U)
+#define HWD_VIIF_L1_INPUT_NUM_MIN			 (1U)
+#define HWD_VIIF_L1_INPUT_NUM_MAX			 (3U)
+#define HWD_VIIF_L1_AG_ID_NUM				 (4U)
+#define HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM		 (3U)
+#define HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL		 (0x3fffU)
+#define HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL		 (0xffffffU)
+#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO		 (0x400000U)
+#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL		 (0xffffffU)
+#define HWD_VIIF_L1_OBCC_MAX_AG_VAL			 (511U)
+#define HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL	 (0xffffffU)
+#define HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL		 (1023U)
+#define HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL		 (1U)
+#define HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL		 (31U)
+#define HWD_VIIF_L1_VDM_ALIGN				 (0x8U) /* port interface width is 64bit */
+#define HWD_VIIF_L1_VDM_CFG_PARAM			 (0x00000310U) /* data width is 64bit */
+#define HWD_VIIF_L1_VDM_SRAM_BASE			 (0x00000600U)
+#define HWD_VIIF_L1_VDM_SRAM_SIZE			 (0x00000020U)
+#define HWD_VIIF_L1_VDM_DPC_TABLE_SIZE			 (0x2000U)
+#define HWD_VIIF_L1_VDM_LSC_TABLE_SIZE			 (0x600U)
+#define HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL		 (4095U)
+#define HWD_VIIF_L1_PWHB_MAX_GAIN_VAL			 (0x80000U)
+#define HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL	 (63U)
+#define HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL (31U)
+#define HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL	 (3U)
+#define HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL		 (256U)
+#define HWD_VIIF_L1_RCNR_MAX_BLEND_VAL			 (16U)
+#define HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL		 (64U)
+#define HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL		 (4U)
+#define HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL		 (16U)
+#define HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL	 (32U)
+#define HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL	 (2U)
+#define HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO	 (15U)
+#define HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO		 (0x400U)
+#define HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO		 (0x400000U)
+#define HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL		 (0x400000U)
+#define HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL		 (0xffffffU)
+#define HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL		 (4095U)
+#define HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL			 (0xffffffU)
+#define HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL		 (0x100000U)
+#define HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL		 (0xffffffU)
+#define HWD_VIIF_LSC_MIN_GAIN				 (-4096)
+#define HWD_VIIF_LSC_MAX_GAIN				 (4096)
+#define HWD_VIIF_LSC_GRID_MIN_COORDINATE		 (1U)
+#define HWD_VIIF_LSC_PWB_MAX_COEF_VAL			 (0x800U)
+#define HWD_VIIF_DAMP_MAX_LSBSEL			 (15U)
+#define HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL		 (0xffffffU)
+#define HWD_VIIF_AWB_MIN_GAIN				 (64U)
+#define HWD_VIIF_AWB_MAX_GAIN				 (1024U)
+#define HWD_VIIF_AWB_GATE_LOWER				 (-127)
+#define HWD_VIIF_AWB_GATE_UPPER				 (127)
+#define HWD_VIIF_AWB_UNSIGNED_GATE_UPPER		 (127U)
+#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED		 (15U)
+#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL		 (31U)
+#define HWD_VIIF_AWB_INTEGRATION_STOP_TH		 (1023U)
+#define HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL		 (8U)
+#define HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH		 (10U)
+#define HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH		 (24U)
+#define HWD_VIIF_L1_HDRC_MAX_PT_SLOPE			 (13U)
+#define HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO		 (256U)
+#define HWD_VIIF_L1_HDRC_MAX_FLARE_VAL			 (0xffffffU)
+#define HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA			 (16U)
+#define HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO	 (0x400000U)
+#define HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION		 (0x4000U)
+#define HWD_VIIF_L1_HDRC_RATIO_OFFSET			 (10U)
+#define HWD_VIIF_L1_GAMMA_MAX_VAL			 (8191U)
+#define HWD_VIIF_L1_SUPPRESSION_MAX_VAL			 (0x4000U)
+#define HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT		 (15U)
+#define HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN		 (0x1000U)
+#define HWD_VIIF_L1_AEXP_MAX_WEIGHT			 (3U)
+#define HWD_VIIF_L1_AEXP_MAX_BLOCK_TH			 (256U)
+#define HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH	 (0xffffffU)
+#define HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH		 (64U)
+#define HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT		 (64U)
+#define HWD_VIIF_L1_HIST_COLOR_RGBY			 (2U)
+#define HWD_VIIF_L1_HIST_MAX_BLOCK_NUM			 (8U)
+#define HWD_VIIF_L1_HIST_MAX_STEP			 (15U)
+#define HWD_VIIF_L1_HIST_MAX_BIN_SHIFT			 (31U)
+#define HWD_VIIF_L1_HIST_MAX_COEF			 (65536U)
+#define HWD_VIIF_L1_HIST_MIN_ADD_B_COEF			 (-65536)
+#define HWD_VIIF_L1_HIST_MIN_ADD_A_COEF			 (-16777216)
+#define HWD_VIIF_L1_HIST_MAX_ADD_A_COEF			 (16777216)
+#define HWD_VIIF_L1_HIST_VDM_SIZE			 (4096U)
+#define HWD_VIIF_L1_HIST_VDM_SRAM_BASE			 (0x00000400U)
+#define HWD_VIIF_L1_HIST_VDM_SRAM_SIZE			 (0x00000040U)
+#define HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT		 (0x0200U)
+#define HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT		 (0x10BFU)
+#define HWD_VIIF_L1_COEF_MIN				 (256U)
+#define HWD_VIIF_L1_COEF_MAX				 (65024U)
+
+/* constants for L2 ISP */
+#define HWD_VIIF_L2_VDM_ALIGN			     (0x4U)
+#define HWD_VIIF_L2_VDM_GRID_SRAM_BASE		     (0x00000620U)
+#define HWD_VIIF_L2_VDM_GRID_SRAM_SIZE		     (0x00000020U)
+#define HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE		     (0x00000640U)
+#define HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE		     (0x00000020U)
+#define HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE	     (0x00000200U)
+#define HWD_VIIF_L2_UNDIST_POLY_NUM		     (11U)
+#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H     (-4296)
+#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H     (4296)
+#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V     (-2360)
+#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V     (2360)
+#define HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE	     (1677721U)
+#define HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2	     (0x4000000U)
+#define HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA  (0x800U)
+#define HWD_VIIF_L2_UNDIST_MIN_POLY_COEF	     (-2147352576)
+#define HWD_VIIF_L2_UNDIST_MAX_POLY_COEF	     (2147352576)
+#define HWD_VIIF_L2_UNDIST_MIN_GRID_NUM		     (16U)
+#define HWD_VIIF_L2_UNDIST_MAX_GRID_NUM		     (64U)
+#define HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM	     (2048U)
+#define HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV   (0x800000U)
+#define HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE	     (0x400U)
+#define HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE	     (0x2000U)
+#define HWD_VIIF_L2_ROI_MIN_NUM			     (1U)
+#define HWD_VIIF_L2_ROI_MAX_NUM			     (2U)
+#define HWD_VIIF_L2_ROI_MIN_SCALE		     (32768U)
+#define HWD_VIIF_L2_ROI_MAX_SCALE		     (131072U)
+#define HWD_VIIF_L2_ROI_MIN_SCALE_INV		     (32768U)
+#define HWD_VIIF_L2_ROI_MAX_SCALE_INV		     (131072U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE (8190U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE (4094U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE	     (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE	     (8190U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE	     (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE	     (4094U)
+#define HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT	     (0x1CU)
+#define HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT	     (0x1FU)
+#define HWD_VIIF_L2_ROI_NONE			     (3U)
+#define HWD_VIIF_MAX_POST_NUM			     (2U)
+#define HWD_VIIF_L2_INPUT_OTHER_CH		     (0x50U)
+
+/**
+ * struct hwd_viif_l2_roi_path_info - L2ISP ROI path control information
+ *
+ * @roi_num: the number of ROIs which are used.
+ * @post_enable_flag: flag to show which of POST is enabled.
+ * @post_crop_x: CROP x of each L2ISP POST
+ * @post_crop_y: CROP y of each L2ISP POST
+ * @post_crop_w: CROP w of each L2ISP POST
+ * @post_crop_h: CROP h of each L2ISP POST
+ */
+struct hwd_viif_l2_roi_path_info {
+	u32 roi_num;
+	bool post_enable_flag[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_x[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_y[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_w[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_h[HWD_VIIF_MAX_POST_NUM];
+};
+
+/**
+ * struct hwd_viif_res - driver internal resource structure
+ *
+ * @clock_id: clock ID of each unit
+ * @csi2_clock_id: clock ID of CSI-2 RX
+ * @csi2_reset_id: reset ID of CSI-2 RX
+ * @pixel_clock: pixel clock
+ * @htotal_size: horizontal total size
+ * @dt_image_main_w_isp: Data type of image data for ISP path
+ * @csi2host_reg: pointer to register access structure of CSI-2 RX host controller
+ * @capture_reg: pointer to register access structure of capture unit
+ * @l2_roi_path_info: ROI path information of L2ISP
+ * @run_flag_main: run flag of MAIN unit(true: run, false: not run)
+ */
+struct hwd_viif_res {
+	//u32 clock_id;
+	//u32 csi2_clock_id;
+	//u32 csi2_reset_id;
+	u32 pixel_clock;
+	u32 htotal_size;
+	u32 dt_image_main_w_isp;
+	struct hwd_viif_csi2host_reg *csi2host_reg;
+	struct hwd_viif_capture_reg *capture_reg;
+	struct hwd_viif_l2_roi_path_info l2_roi_path_info;
+	bool run_flag_main;
+};
+
+/**
+ * struct hwd_viif_dphy_hs_info - dphy hs information
+ *
+ * @rate: Data rate [Mbps]
+ * @hsfreqrange: IP operating frequency(hsfreqrange)
+ * @osc_freq_target: DDL target oscillation frequency(osc_freq_target)
+ */
+struct hwd_viif_dphy_hs_info {
+	u32 rate;
+	u32 hsfreqrange;
+	u32 osc_freq_target;
+};
+
+#endif /* HWD_VIIF_INTERNAL_H */
diff --git a/drivers/media/platform/visconti/hwd_viif_reg.h b/drivers/media/platform/visconti/hwd_viif_reg.h
new file mode 100644
index 00000000000..b7f43c5fe95
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_reg.h
@@ -0,0 +1,2802 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef HWD_VIIF_REG_H
+#define HWD_VIIF_REG_H
+
+/**
+ * struct hwd_viif_csi2host_reg - Registers for VIIF CSI2HOST control
+ */
+struct hwd_viif_csi2host_reg {
+	u32 RESERVED_A_1;
+	u32 CSI2RX_NLANES;
+	u32 CSI2RX_RESETN;
+	u32 CSI2RX_INT_ST_MAIN;
+	u32 CSI2RX_DATA_IDS_1;
+	u32 CSI2RX_DATA_IDS_2;
+	u32 RESERVED_B_1[10];
+	u32 CSI2RX_PHY_SHUTDOWNZ;
+	u32 CSI2RX_PHY_RSTZ;
+	u32 CSI2RX_PHY_RX;
+	u32 CSI2RX_PHY_STOPSTATE;
+	u32 CSI2RX_PHY_TESTCTRL0;
+	u32 CSI2RX_PHY_TESTCTRL1;
+	u32 RESERVED_B_2[34];
+	u32 CSI2RX_INT_ST_PHY_FATAL;
+	u32 CSI2RX_INT_MSK_PHY_FATAL;
+	u32 CSI2RX_INT_FORCE_PHY_FATAL;
+	u32 RESERVED_B_3[1];
+	u32 CSI2RX_INT_ST_PKT_FATAL;
+	u32 CSI2RX_INT_MSK_PKT_FATAL;
+	u32 CSI2RX_INT_FORCE_PKT_FATAL;
+	u32 RESERVED_B_4[1];
+	u32 CSI2RX_INT_ST_FRAME_FATAL;
+	u32 CSI2RX_INT_MSK_FRAME_FATAL;
+	u32 CSI2RX_INT_FORCE_FRAME_FATAL;
+	u32 RESERVED_B_5[1];
+	u32 CSI2RX_INT_ST_PHY;
+	u32 CSI2RX_INT_MSK_PHY;
+	u32 CSI2RX_INT_FORCE_PHY;
+	u32 RESERVED_B_6[1];
+	u32 CSI2RX_INT_ST_PKT;
+	u32 CSI2RX_INT_MSK_PKT;
+	u32 CSI2RX_INT_FORCE_PKT;
+	u32 RESERVED_B_7[1];
+	u32 CSI2RX_INT_ST_LINE;
+	u32 CSI2RX_INT_MSK_LINE;
+	u32 CSI2RX_INT_FORCE_LINE;
+	u32 RESERVED_B_8[113];
+	u32 RESERVED_A_2;
+	u32 RESERVED_A_3;
+	u32 RESERVED_A_4;
+	u32 RESERVED_A_5;
+	u32 RESERVED_A_6;
+	u32 RESERVED_B_9[58];
+	u32 RESERVED_A_7;
+};
+
+/**
+ * struct hwd_viif_csc_reg - Registers for VIIF system control
+ */
+struct hwd_viif_csc_reg {
+	u32 MTB;
+	u32 RESERVED_B_16[3];
+	u32 MTB_YG_OFFSETI;
+	u32 MTB_YG1;
+	u32 MTB_YG2;
+	u32 MTB_YG_OFFSETO;
+	u32 MTB_CB_OFFSETI;
+	u32 MTB_CB1;
+	u32 MTB_CB2;
+	u32 MTB_CB_OFFSETO;
+	u32 MTB_CR_OFFSETI;
+	u32 MTB_CR1;
+	u32 MTB_CR2;
+	u32 MTB_CR_OFFSETO;
+};
+
+struct hwd_viif_system_reg {
+	u32 IPORTM0_LD;
+	u32 IPORTM1_LD;
+	u32 RESERVED_B_1[6];
+	u32 IPORTS0_LD;
+	u32 RESERVED_A_1;
+	u32 RESERVED_B_2[2];
+	u32 VCID0SELECT;
+	u32 VCID1SELECT;
+	u32 RESERVED_A_2;
+	u32 VCPORTEN;
+	u32 CSI2SELECT;
+	u32 CSI2THROUGHEN;
+	u32 RESERVED_B_3[2];
+	u32 IPORTM_TEST;
+	u32 IPORTM;
+	u32 IPORTM_MAIN_DT;
+	u32 IPORTM_MAIN_RAW;
+	u32 IPORTM_OTHER;
+	u32 IPORTM_OTHEREN;
+	u32 IPORTM_EMBEN;
+	u32 RESERVED_B_4[2];
+	u32 IPORTS;
+	u32 IPORTS_MAIN_DT;
+	u32 IPORTS_MAIN_RAW;
+	u32 IPORTS_OTHER;
+	u32 IPORTS_OTHEREN;
+	u32 IPORTS_EMBEN;
+	u32 IPORTS_IMGEN;
+	u32 RESERVED_A_3;
+	u32 RESERVED_A_4;
+	u32 RESERVED_B_5[2];
+	u32 IPORTI_M_SYNCEN;
+	u32 IPORTI_M_SYNCMODE;
+	u32 IPORTI_M_PIXFMT;
+	u32 RESERVED_B_6[5];
+	u32 TOTALSIZE_M;
+	u32 VALSIZE_M;
+	u32 BACK_PORCH_M;
+	u32 RESERVED_B_7[5];
+	u32 MAINIMG_PKTSIZE;
+	u32 MAINIMG_HEIGHT;
+	u32 MAINOTHER_PKTSIZE;
+	u32 MAINOTHER_HEIGHT;
+	u32 MAINEMBTOP_SIZE;
+	u32 MAINEMBBOT_SIZE;
+	u32 RESERVED_B_8[2];
+	u32 SUBIMG_PKTSIZE;
+	u32 SUBIMG_HEIGHT;
+	u32 SUBOTHER_PKTSIZE;
+	u32 SUBOTHER_HEIGHT;
+	u32 SUBEMBTOP_SIZE;
+	u32 SUBEMBBOT_SIZE;
+	u32 RESERVED_A_5;
+	u32 RESERVED_A_6;
+	u32 TESTAREA_M_START;
+	u32 TESTAREA_M_SIZE;
+	u32 RESERVED_B_9[2];
+	u32 INT_M_SYNC;
+	u32 INT_M_SYNC_MASK;
+	u32 INT_S_SYNC;
+	u32 INT_S_SYNC_MASK;
+	u32 INT_M0_LINE;
+	u32 INT_M1_LINE;
+	u32 INT_M2_LINE;
+	u32 RESERVED_B_10[5];
+	u32 INT_SA0_LINE;
+	u32 INT_SA1_LINE;
+	u32 RESERVED_B_11[2];
+	u32 RESERVED_A_9;
+	u32 RESERVED_A_10;
+	u32 RESERVED_B_12[2];
+	u32 INT_M_STATUS;
+	u32 INT_M_MASK;
+	u32 INT_S_STATUS;
+	u32 INT_S_MASK;
+	u32 RESERVED_B_13[28];
+	u32 MAIN_TEST_DEN;
+	u32 RESERVED_B_14[3];
+	u32 PREPROCCESS_FMTM;
+	u32 PREPROCCESS_C24M;
+	u32 FRAMEPACK_M;
+	u32 RESERVED_B_15[1];
+	struct hwd_viif_csc_reg l2isp_input_csc;
+	u32 COM0_CK_ENABLE;
+	u32 RESERVED_A_13;
+	u32 RESERVED_A_14;
+	u32 RESERVED_B_17[1];
+	u32 COM0EN;
+	u32 RESERVED_A_16;
+	u32 RESERVED_A_17;
+	u32 RESERVED_B_18[33];
+	u32 COM0_CAP_OFFSET;
+	u32 COM0_CAP_SIZE;
+	u32 RESERVED_B_19[18];
+	u32 GAMMA_M;
+	u32 RESERVED_B_20[3];
+	u32 COM0_C_SELECT;
+	u32 RESERVED_B_21[3];
+	struct hwd_viif_csc_reg com0_csc;
+	u32 COM0_OPORTALP;
+	u32 COM0_OPORTFMT;
+	u32 RESERVED_B_23[2];
+	u32 RESERVED_A_37;
+	u32 RESERVED_A_38;
+	u32 RESERVED_A_39;
+	u32 RESERVED_B_24[1];
+	u32 RESERVED_A_40;
+	u32 RESERVED_A_41;
+	u32 RESERVED_A_42;
+	u32 RESERVED_B_25[1];
+	u32 RESERVED_A_43;
+	u32 RESERVED_A_44;
+	u32 RESERVED_A_45;
+	u32 RESERVED_B_26[1];
+	u32 RESERVED_A_46;
+	u32 RESERVED_B_27[3];
+	u32 RESERVED_A_47;
+	u32 RESERVED_A_48;
+	u32 RESERVED_B_28[18];
+	u32 RESERVED_A_49;
+	u32 RESERVED_B_29[3];
+	u32 RESERVED_A_50;
+	u32 RESERVED_B_30[3];
+	u32 RESERVED_A_51;
+	u32 RESERVED_B_31[3];
+	u32 RESERVED_A_52;
+	u32 RESERVED_A_53;
+	u32 RESERVED_A_54;
+	u32 RESERVED_A_55;
+	u32 RESERVED_A_56;
+	u32 RESERVED_A_57;
+	u32 RESERVED_A_58;
+	u32 RESERVED_A_59;
+	u32 RESERVED_A_60;
+	u32 RESERVED_A_61;
+	u32 RESERVED_A_62;
+	u32 RESERVED_A_63;
+	u32 RESERVED_A_64;
+	u32 RESERVED_A_65;
+	u32 RESERVED_B_32[2];
+	u32 RESERVED_A_66;
+	u32 RESERVED_A_67;
+	u32 RESERVED_A_68;
+	u32 RESERVED_B_33[1];
+	u32 RESERVED_A_69;
+	u32 RESERVED_A_70;
+	u32 RESERVED_A_71;
+	u32 RESERVED_B_34[1];
+	u32 RESERVED_A_72;
+	u32 RESERVED_A_73;
+	u32 RESERVED_A_74;
+	u32 RESERVED_B_35[1];
+	u32 RESERVED_A_75;
+	u32 RESERVED_B_36[3];
+	u32 RESERVED_A_76;
+	u32 RESERVED_A_77;
+	u32 RESERVED_B_37[18];
+	u32 RESERVED_A_78;
+	u32 RESERVED_B_38[3];
+	u32 RESERVED_A_79;
+	u32 RESERVED_B_39[3];
+	u32 RESERVED_A_80;
+	u32 RESERVED_B_40[3];
+	u32 RESERVED_A_81;
+	u32 RESERVED_A_82;
+	u32 RESERVED_A_83;
+	u32 RESERVED_A_84;
+	u32 RESERVED_A_85;
+	u32 RESERVED_A_86;
+	u32 RESERVED_A_87;
+	u32 RESERVED_A_88;
+	u32 RESERVED_A_89;
+	u32 RESERVED_A_90;
+	u32 RESERVED_A_91;
+	u32 RESERVED_A_92;
+	u32 RESERVED_A_93;
+	u32 RESERVED_A_94;
+	u32 RESERVED_B_41[2];
+	u32 RESERVED_A_95;
+	u32 RESERVED_A_96;
+	u32 RESERVED_A_97;
+	u32 RESERVED_B_42[1];
+	u32 RESERVED_A_98;
+	u32 RESERVED_A_99;
+	u32 RESERVED_A_100;
+	u32 RESERVED_B_43[1];
+	u32 RESERVED_A_101;
+	u32 RESERVED_A_102;
+	u32 RESERVED_A_103;
+	u32 RESERVED_B_44[1];
+	u32 RESERVED_A_104;
+	u32 RESERVED_B_45[3];
+	u32 FN_M0;
+	u32 FN_M1;
+	u32 FN_M2;
+	u32 RESERVED_B_46[5];
+	u32 FN_SA0;
+	u32 FN_SA1;
+	u32 RESERVED_B_47[2];
+	u32 RESERVED_A_105;
+	u32 RESERVED_A_106;
+	u32 RESERVED_B_48[18];
+	u32 LBIST_STAT;
+	u32 MEM_ECC_DCLS_ALARM;
+	u32 RESERVED_B_49[30];
+	u32 DPHY_FREQRANGE;
+	u32 RESERVED_B_50[3];
+	u32 DPHY_LANE;
+	u32 RESERVED_B_51[59];
+	u32 INT_SOURCE;
+	u32 DPGM_VSYNC_SOURCE;
+	u32 RESERVED_B_52[23];
+	u32 RESERVED_A_107;
+	u32 RESERVED_A_108;
+	u32 RESERVED_B_53[6];
+	u32 RESERVED_A_109;
+	u32 RESERVED_A_110;
+	u32 RESERVED_A_111;
+	u32 RESERVED_B_54[1];
+	u32 RESERVED_A_112;
+	u32 RESERVED_B_55[35];
+	u32 RESERVED_A_113;
+	u32 RESERVED_B_56[54];
+	u32 RESERVED_A_114;
+	u32 RESERVED_B_57[3];
+	u32 RESERVED_A_115;
+	u32 RESERVED_A_116;
+	u32 RESERVED_A_117;
+	u32 RESERVED_B_58[1];
+	u32 RESERVED_A_118;
+	u32 RESERVED_B_59[3];
+	u32 RESERVED_A_119;
+	u32 RESERVED_A_120;
+	u32 RESERVED_A_121;
+	u32 RESERVED_A_122;
+	u32 RESERVED_A_123;
+	u32 RESERVED_A_124;
+	u32 RESERVED_A_125;
+	u32 RESERVED_A_126;
+	u32 RESERVED_A_127;
+	u32 RESERVED_A_128;
+	u32 RESERVED_A_129;
+	u32 RESERVED_A_130;
+	u32 RESERVED_B_60[4];
+	u32 RESERVED_A_131;
+	u32 RESERVED_A_132;
+	u32 RESERVED_A_133;
+	u32 RESERVED_B_61[33];
+	u32 RESERVED_A_134;
+	u32 RESERVED_A_135;
+	u32 RESERVED_B_62[18];
+	u32 RESERVED_A_136;
+	u32 RESERVED_B_63[3];
+	u32 RESERVED_A_137;
+	u32 RESERVED_B_64[3];
+	u32 RESERVED_A_138;
+	u32 RESERVED_B_65[3];
+	u32 RESERVED_A_139;
+	u32 RESERVED_A_140;
+	u32 RESERVED_A_141;
+	u32 RESERVED_A_142;
+	u32 RESERVED_A_143;
+	u32 RESERVED_A_144;
+	u32 RESERVED_A_145;
+	u32 RESERVED_A_146;
+	u32 RESERVED_A_147;
+	u32 RESERVED_A_148;
+	u32 RESERVED_A_149;
+	u32 RESERVED_A_150;
+	u32 RESERVED_A_151;
+	u32 RESERVED_A_152;
+	u32 RESERVED_B_66[2];
+	u32 RESERVED_A_153;
+	u32 RESERVED_A_154;
+	u32 RESERVED_A_155;
+	u32 RESERVED_B_67[1];
+	u32 RESERVED_A_156;
+	u32 RESERVED_A_157;
+	u32 RESERVED_A_158;
+	u32 RESERVED_B_68[1];
+	u32 RESERVED_A_159;
+	u32 RESERVED_A_160;
+	u32 RESERVED_A_161;
+	u32 RESERVED_B_69[1];
+	u32 RESERVED_A_162;
+	u32 RESERVED_B_70[3];
+	u32 RESERVED_A_163;
+	u32 RESERVED_A_164;
+	u32 RESERVED_B_71[18];
+	u32 RESERVED_A_165;
+	u32 RESERVED_B_72[3];
+	u32 RESERVED_A_166;
+	u32 RESERVED_B_73[3];
+	u32 RESERVED_A_167;
+	u32 RESERVED_B_74[3];
+	u32 RESERVED_A_168;
+	u32 RESERVED_A_169;
+	u32 RESERVED_A_170;
+	u32 RESERVED_A_171;
+	u32 RESERVED_A_172;
+	u32 RESERVED_A_173;
+	u32 RESERVED_A_174;
+	u32 RESERVED_A_175;
+	u32 RESERVED_A_176;
+	u32 RESERVED_A_177;
+	u32 RESERVED_A_178;
+	u32 RESERVED_A_179;
+	u32 RESERVED_A_180;
+	u32 RESERVED_A_181;
+	u32 RESERVED_B_75[2];
+	u32 RESERVED_A_182;
+	u32 RESERVED_A_183;
+	u32 RESERVED_A_184;
+	u32 RESERVED_B_76[1];
+	u32 RESERVED_A_185;
+	u32 RESERVED_A_186;
+	u32 RESERVED_A_187;
+	u32 RESERVED_B_77[1];
+	u32 RESERVED_A_188;
+	u32 RESERVED_A_189;
+	u32 RESERVED_A_190;
+	u32 RESERVED_B_78[1];
+	u32 RESERVED_A_191;
+	u32 RESERVED_B_79[3];
+	u32 RESERVED_A_192;
+	u32 RESERVED_A_193;
+	u32 RESERVED_B_80[18];
+	u32 RESERVED_A_194;
+	u32 RESERVED_B_81[3];
+	u32 RESERVED_A_195;
+	u32 RESERVED_B_82[3];
+	u32 RESERVED_A_196;
+	u32 RESERVED_B_83[3];
+	u32 RESERVED_A_197;
+	u32 RESERVED_A_198;
+	u32 RESERVED_A_199;
+	u32 RESERVED_A_200;
+	u32 RESERVED_A_201;
+	u32 RESERVED_A_202;
+	u32 RESERVED_A_203;
+	u32 RESERVED_A_204;
+	u32 RESERVED_A_205;
+	u32 RESERVED_A_206;
+	u32 RESERVED_A_207;
+	u32 RESERVED_A_208;
+	u32 RESERVED_A_209;
+	u32 RESERVED_A_210;
+	u32 RESERVED_B_84[2];
+	u32 RESERVED_A_211;
+	u32 RESERVED_A_212;
+	u32 RESERVED_A_213;
+	u32 RESERVED_B_85[1];
+	u32 RESERVED_A_214;
+	u32 RESERVED_A_215;
+	u32 RESERVED_A_216;
+	u32 RESERVED_B_86[1];
+	u32 RESERVED_A_217;
+	u32 RESERVED_A_218;
+	u32 RESERVED_A_219;
+	u32 RESERVED_B_87[1];
+	u32 RESERVED_A_220;
+	u32 RESERVED_B_88[130];
+	u32 RESERVED_A_221;
+};
+
+/**
+ * struct hwd_viif_vdm_table_group_reg - Registers for VIIF vdm control
+ */
+struct hwd_viif_vdm_table_group_reg {
+	u32 VDM_T_CFG;
+	u32 VDM_T_SRAM_BASE;
+	u32 VDM_T_SRAM_SIZE;
+	u32 RESERVED_A_4;
+};
+
+struct hwd_viif_vdm_table_port_reg {
+	u32 VDM_T_STADR;
+	u32 VDM_T_SIZE;
+};
+
+struct hwd_viif_vdm_read_port_reg {
+	u32 VDM_R_STADR;
+	u32 VDM_R_ENDADR;
+	u32 VDM_R_HEIGHT;
+	u32 VDM_R_PITCH;
+	u32 VDM_R_CFG0;
+	u32 RESERVED_A_11;
+	u32 VDM_R_SRAM_BASE;
+	u32 VDM_R_SRAM_SIZE;
+	u32 RESERVED_A_12;
+	u32 RESERVED_B_5[7];
+};
+
+struct hwd_viif_vdm_write_port_reg {
+	u32 VDM_W_STADR;
+	u32 VDM_W_ENDADR;
+	u32 VDM_W_HEIGHT;
+	u32 VDM_W_PITCH;
+	u32 VDM_W_CFG0;
+	u32 RESERVED_A_17;
+	u32 VDM_W_SRAM_BASE;
+	u32 VDM_W_SRAM_SIZE;
+	u32 RESERVED_A_18;
+	u32 RESERVED_B_8[7];
+};
+
+struct hwd_viif_vdm_write_port_buf_reg {
+	u32 VDM_W_STADR_BUF;
+	u32 RESERVED_A_120;
+	u32 RESERVED_A_121;
+	u32 RESERVED_A_122;
+	u32 RESERVED_A_123;
+	u32 RESERVED_A_124;
+	u32 RESERVED_B_20[2];
+};
+
+struct hwd_viif_vdm_reg {
+	u32 RESERVED_A_1;
+	u32 RESERVED_A_2;
+	u32 RESERVED_B_1[4];
+	u32 RESERVED_A_3;
+	u32 VDM_CFG;
+	u32 VDM_INT_MASK;
+	u32 RESERVED_B_2[3];
+	u32 VDM_R_ENABLE;
+	u32 VDM_W_ENABLE;
+	u32 VDM_T_ENABLE;
+	u32 VDM_ABORTSET;
+	struct hwd_viif_vdm_table_group_reg t_group[4];
+	u32 RESERVED_A_8;
+	u32 RESERVED_A_9;
+	u32 RESERVED_A_10;
+	u32 RESERVED_A_11;
+	u32 RESERVED_B_3[28];
+	struct hwd_viif_vdm_table_port_reg t_port[24];
+	u32 RESERVED_A_14;
+	u32 RESERVED_A_15;
+	u32 RESERVED_A_16;
+	u32 RESERVED_A_17;
+	u32 RESERVED_A_18;
+	u32 RESERVED_A_19;
+	u32 RESERVED_A_20;
+	u32 RESERVED_A_21;
+	u32 RESERVED_A_22;
+	u32 RESERVED_A_23;
+	u32 RESERVED_A_24;
+	u32 RESERVED_A_25;
+	u32 RESERVED_B_4[4];
+	struct hwd_viif_vdm_read_port_reg r_port[3];
+	u32 RESERVED_B_7[16];
+	struct hwd_viif_vdm_write_port_reg w_port[6];
+	u32 RESERVED_A_29;
+	u32 RESERVED_A_30;
+	u32 RESERVED_A_31;
+	u32 RESERVED_A_32;
+	u32 RESERVED_A_33;
+	u32 RESERVED_A_34;
+	u32 RESERVED_A_35;
+	u32 RESERVED_A_36;
+	u32 RESERVED_A_37;
+	u32 RESERVED_B_14[215];
+	u32 RESERVED_A_38;
+	u32 RESERVED_A_39;
+	u32 RESERVED_A_40;
+	u32 RESERVED_B_15[61];
+	u32 RESERVED_A_41;
+	u32 RESERVED_A_42;
+	u32 RESERVED_A_43;
+	u32 RESERVED_A_44;
+	u32 RESERVED_A_45;
+	u32 RESERVED_A_46;
+	u32 RESERVED_A_47;
+	u32 RESERVED_A_48;
+	u32 RESERVED_A_49;
+	u32 RESERVED_A_50;
+	u32 RESERVED_A_51;
+	u32 RESERVED_A_52;
+	u32 RESERVED_A_53;
+	u32 RESERVED_A_54;
+	u32 RESERVED_A_55;
+	u32 RESERVED_A_56;
+	u32 RESERVED_A_57;
+	u32 RESERVED_A_58;
+	u32 RESERVED_A_59;
+	u32 RESERVED_A_60;
+	u32 RESERVED_A_61;
+	u32 RESERVED_A_62;
+	u32 RESERVED_A_63;
+	u32 RESERVED_A_64;
+	u32 RESERVED_A_65;
+	u32 RESERVED_A_66;
+	u32 RESERVED_A_67;
+	u32 RESERVED_A_68;
+	u32 RESERVED_A_69;
+	u32 RESERVED_A_70;
+	u32 RESERVED_A_71;
+	u32 RESERVED_A_72;
+	u32 RESERVED_A_73;
+	u32 RESERVED_A_74;
+	u32 RESERVED_A_75;
+	u32 RESERVED_A_76;
+	u32 RESERVED_A_77;
+	u32 RESERVED_A_78;
+	u32 RESERVED_A_79;
+	u32 RESERVED_A_80;
+	u32 RESERVED_A_81;
+	u32 RESERVED_A_82;
+	u32 RESERVED_A_83;
+	u32 RESERVED_A_84;
+	u32 RESERVED_A_85;
+	u32 RESERVED_A_86;
+	u32 RESERVED_A_87;
+	u32 RESERVED_A_88;
+	u32 RESERVED_A_89;
+	u32 RESERVED_A_90;
+	u32 RESERVED_A_91;
+	u32 RESERVED_A_92;
+	u32 RESERVED_A_93;
+	u32 RESERVED_A_94;
+	u32 RESERVED_A_95;
+	u32 RESERVED_A_96;
+	u32 RESERVED_A_97;
+	u32 RESERVED_A_98;
+	u32 RESERVED_A_99;
+	u32 RESERVED_A_100;
+	u32 RESERVED_B_16[4];
+	u32 RESERVED_A_101;
+	u32 RESERVED_A_102;
+	u32 RESERVED_A_103;
+	u32 RESERVED_A_104;
+	u32 RESERVED_A_105;
+	u32 RESERVED_A_106;
+	u32 RESERVED_B_17[2];
+	u32 RESERVED_A_107;
+	u32 RESERVED_A_108;
+	u32 RESERVED_A_109;
+	u32 RESERVED_A_110;
+	u32 RESERVED_A_111;
+	u32 RESERVED_A_112;
+	u32 RESERVED_B_18[2];
+	u32 RESERVED_A_113;
+	u32 RESERVED_A_114;
+	u32 RESERVED_A_115;
+	u32 RESERVED_A_116;
+	u32 RESERVED_A_117;
+	u32 RESERVED_A_118;
+	u32 RESERVED_B_19[42];
+	struct hwd_viif_vdm_write_port_buf_reg w_port_buf[6];
+	u32 RESERVED_A_155;
+	u32 RESERVED_A_156;
+	u32 RESERVED_A_157;
+	u32 RESERVED_A_158;
+	u32 RESERVED_A_159;
+	u32 RESERVED_A_160;
+	u32 RESERVED_B_26[138];
+	u32 RESERVED_A_161;
+	u32 VDM_INT;
+	u32 RESERVED_A_162;
+	u32 RESERVED_A_163;
+	u32 VDM_R_STOP;
+	u32 VDM_W_STOP;
+	u32 VDM_R_RUN;
+	u32 VDM_W_RUN;
+	u32 VDM_T_RUN;
+	u32 RESERVED_B_27[7];
+	u32 RESERVED_A_164;
+	u32 RESERVED_A_165;
+	u32 RESERVED_A_166;
+	u32 RESERVED_A_167;
+	u32 RESERVED_B_28[12];
+	u32 RESERVED_A_168;
+	u32 RESERVED_A_169;
+	u32 RESERVED_A_170;
+	u32 RESERVED_A_171;
+	u32 RESERVED_A_172;
+	u32 RESERVED_B_29[27];
+	u32 RESERVED_A_173;
+	u32 RESERVED_A_174;
+	u32 RESERVED_A_175;
+	u32 RESERVED_A_176;
+	u32 RESERVED_A_177;
+	u32 RESERVED_A_178;
+	u32 RESERVED_B_30[10];
+	u32 RESERVED_A_179;
+	u32 RESERVED_A_180;
+	u32 RESERVED_A_181;
+	u32 RESERVED_A_182;
+	u32 RESERVED_A_183;
+	u32 RESERVED_A_184;
+	u32 RESERVED_A_185;
+	u32 RESERVED_A_186;
+	u32 RESERVED_A_187;
+	u32 RESERVED_A_188;
+	u32 RESERVED_A_189;
+	u32 RESERVED_A_190;
+	u32 RESERVED_A_191;
+	u32 RESERVED_A_192;
+	u32 RESERVED_B_31[33];
+	u32 RESERVED_A_193;
+};
+
+/**
+ * struct hwd_viif_l1isp_reg - Registers for VIIF L1ISP control
+ */
+struct hwd_viif_l1isp_reg {
+	u32 L1_SYSM_WIDTH;
+	u32 L1_SYSM_HEIGHT;
+	u32 L1_SYSM_START_COLOR;
+	u32 L1_SYSM_INPUT_MODE;
+	u32 RESERVED_A_1;
+	u32 L1_SYSM_YCOEF_R;
+	u32 L1_SYSM_YCOEF_G;
+	u32 L1_SYSM_YCOEF_B;
+	u32 L1_SYSM_INT_STAT;
+	u32 L1_SYSM_INT_MASKED_STAT;
+	u32 L1_SYSM_INT_MASK;
+	u32 RESERVED_A_2;
+	u32 RESERVED_A_3;
+	u32 RESERVED_A_4;
+	u32 RESERVED_B_1[2];
+	u32 L1_SYSM_AG_H;
+	u32 L1_SYSM_AG_M;
+	u32 L1_SYSM_AG_L;
+	u32 L1_SYSM_AG_PARAM_A;
+	u32 L1_SYSM_AG_PARAM_B;
+	u32 L1_SYSM_AG_PARAM_C;
+	u32 L1_SYSM_AG_PARAM_D;
+	u32 L1_SYSM_AG_SEL_HOBC;
+	u32 L1_SYSM_AG_SEL_ABPC;
+	u32 L1_SYSM_AG_SEL_RCNR;
+	u32 L1_SYSM_AG_SEL_LSSC;
+	u32 L1_SYSM_AG_SEL_MPRO;
+	u32 L1_SYSM_AG_SEL_VPRO;
+	u32 L1_SYSM_AG_CONT_HOBC01_EN;
+	u32 L1_SYSM_AG_CONT_HOBC2_EN;
+	u32 L1_SYSM_AG_CONT_ABPC01_EN;
+	u32 L1_SYSM_AG_CONT_ABPC2_EN;
+	u32 L1_SYSM_AG_CONT_RCNR01_EN;
+	u32 L1_SYSM_AG_CONT_RCNR2_EN;
+	u32 L1_SYSM_AG_CONT_LSSC_EN;
+	u32 L1_SYSM_AG_CONT_MPRO_EN;
+	u32 L1_SYSM_AG_CONT_VPRO_EN;
+	u32 L1_SYSM_CTXT;
+	u32 L1_SYSM_MAN_CTXT;
+	u32 RESERVED_A_5;
+	u32 RESERVED_B_2[7];
+	u32 RESERVED_A_6;
+	u32 L1_HDRE_SRCPOINT00;
+	u32 L1_HDRE_SRCPOINT01;
+	u32 L1_HDRE_SRCPOINT02;
+	u32 L1_HDRE_SRCPOINT03;
+	u32 L1_HDRE_SRCPOINT04;
+	u32 L1_HDRE_SRCPOINT05;
+	u32 L1_HDRE_SRCPOINT06;
+	u32 L1_HDRE_SRCPOINT07;
+	u32 L1_HDRE_SRCPOINT08;
+	u32 L1_HDRE_SRCPOINT09;
+	u32 L1_HDRE_SRCPOINT10;
+	u32 L1_HDRE_SRCPOINT11;
+	u32 L1_HDRE_SRCPOINT12;
+	u32 L1_HDRE_SRCPOINT13;
+	u32 L1_HDRE_SRCPOINT14;
+	u32 L1_HDRE_SRCPOINT15;
+	u32 L1_HDRE_SRCBASE00;
+	u32 L1_HDRE_SRCBASE01;
+	u32 L1_HDRE_SRCBASE02;
+	u32 L1_HDRE_SRCBASE03;
+	u32 L1_HDRE_SRCBASE04;
+	u32 L1_HDRE_SRCBASE05;
+	u32 L1_HDRE_SRCBASE06;
+	u32 L1_HDRE_SRCBASE07;
+	u32 L1_HDRE_SRCBASE08;
+	u32 L1_HDRE_SRCBASE09;
+	u32 L1_HDRE_SRCBASE10;
+	u32 L1_HDRE_SRCBASE11;
+	u32 L1_HDRE_SRCBASE12;
+	u32 L1_HDRE_SRCBASE13;
+	u32 L1_HDRE_SRCBASE14;
+	u32 L1_HDRE_SRCBASE15;
+	u32 L1_HDRE_SRCBASE16;
+	u32 L1_HDRE_RATIO00;
+	u32 L1_HDRE_RATIO01;
+	u32 L1_HDRE_RATIO02;
+	u32 L1_HDRE_RATIO03;
+	u32 L1_HDRE_RATIO04;
+	u32 L1_HDRE_RATIO05;
+	u32 L1_HDRE_RATIO06;
+	u32 L1_HDRE_RATIO07;
+	u32 L1_HDRE_RATIO08;
+	u32 L1_HDRE_RATIO09;
+	u32 L1_HDRE_RATIO10;
+	u32 L1_HDRE_RATIO11;
+	u32 L1_HDRE_RATIO12;
+	u32 L1_HDRE_RATIO13;
+	u32 L1_HDRE_RATIO14;
+	u32 L1_HDRE_RATIO15;
+	u32 L1_HDRE_RATIO16;
+	u32 L1_HDRE_DSTBASE00;
+	u32 L1_HDRE_DSTBASE01;
+	u32 L1_HDRE_DSTBASE02;
+	u32 L1_HDRE_DSTBASE03;
+	u32 L1_HDRE_DSTBASE04;
+	u32 L1_HDRE_DSTBASE05;
+	u32 L1_HDRE_DSTBASE06;
+	u32 L1_HDRE_DSTBASE07;
+	u32 L1_HDRE_DSTBASE08;
+	u32 L1_HDRE_DSTBASE09;
+	u32 L1_HDRE_DSTBASE10;
+	u32 L1_HDRE_DSTBASE11;
+	u32 L1_HDRE_DSTBASE12;
+	u32 L1_HDRE_DSTBASE13;
+	u32 L1_HDRE_DSTBASE14;
+	u32 L1_HDRE_DSTBASE15;
+	u32 L1_HDRE_DSTBASE16;
+	u32 L1_HDRE_DSTMAXVAL;
+	u32 RESERVED_B_3[11];
+	u32 L1_AEXP_ON;
+	u32 L1_AEXP_RESULT_AVE;
+	u32 RESERVED_A_7;
+	u32 L1_AEXP_FORCE_INTERRUPT_Y;
+	u32 L1_AEXP_START_X;
+	u32 L1_AEXP_START_Y;
+	u32 L1_AEXP_BLOCK_WIDTH;
+	u32 L1_AEXP_BLOCK_HEIGHT;
+	u32 L1_AEXP_WEIGHT_0;
+	u32 L1_AEXP_WEIGHT_1;
+	u32 L1_AEXP_WEIGHT_2;
+	u32 L1_AEXP_WEIGHT_3;
+	u32 L1_AEXP_WEIGHT_4;
+	u32 L1_AEXP_WEIGHT_5;
+	u32 L1_AEXP_WEIGHT_6;
+	u32 L1_AEXP_WEIGHT_7;
+	u32 L1_AEXP_SATUR_RATIO;
+	u32 L1_AEXP_BLACK_RATIO;
+	u32 L1_AEXP_SATUR_LEVEL;
+	u32 RESERVED_A_8;
+	/* [y][x] */
+	u32 L1_AEXP_AVE[8][8];
+	u32 L1_AEXP_SATUR_BLACK_PIXNUM;
+	u32 L1_AEXP_AVE4LINESY0;
+	u32 L1_AEXP_AVE4LINESY1;
+	u32 L1_AEXP_AVE4LINESY2;
+	u32 L1_AEXP_AVE4LINESY3;
+	u32 L1_AEXP_AVE4LINES0;
+	u32 L1_AEXP_AVE4LINES1;
+	u32 L1_AEXP_AVE4LINES2;
+	u32 L1_AEXP_AVE4LINES3;
+	u32 RESERVED_B_4[3];
+	u32 L1_IBUF_DEPTH;
+	u32 L1_IBUF_INPUT_ORDER;
+	u32 RESERVED_B_5[2];
+	u32 L1_SLIC_SRCBLACKLEVEL_GR;
+	u32 L1_SLIC_SRCBLACKLEVEL_R;
+	u32 L1_SLIC_SRCBLACKLEVEL_B;
+	u32 L1_SLIC_SRCBLACKLEVEL_GB;
+	u32 RESERVED_A_9;
+	u32 RESERVED_A_10;
+	u32 RESERVED_A_11;
+	u32 RESERVED_A_12;
+	u32 RESERVED_A_13;
+	u32 RESERVED_B_6[19];
+	u32 RESERVED_A_14;
+	u32 RESERVED_A_15;
+	u32 L1_ABPC012_AG_CONT;
+	u32 L1_ABPC012_STA_EN;
+	u32 L1_ABPC012_DYN_EN;
+	u32 L1_ABPC012_DYN_MODE;
+	u32 RESERVED_A_16;
+	u32 RESERVED_A_17;
+	u32 RESERVED_A_18;
+	u32 L1_ABPC0_RATIO_LIMIT;
+	u32 RESERVED_A_19;
+	u32 L1_ABPC0_DARK_LIMIT;
+	u32 L1_ABPC0_SN_COEF_W_AG_MIN;
+	u32 L1_ABPC0_SN_COEF_W_AG_MID;
+	u32 L1_ABPC0_SN_COEF_W_AG_MAX;
+	u32 L1_ABPC0_SN_COEF_W_TH_MIN;
+	u32 L1_ABPC0_SN_COEF_W_TH_MAX;
+	u32 L1_ABPC0_SN_COEF_B_AG_MIN;
+	u32 L1_ABPC0_SN_COEF_B_AG_MID;
+	u32 L1_ABPC0_SN_COEF_B_AG_MAX;
+	u32 L1_ABPC0_SN_COEF_B_TH_MIN;
+	u32 L1_ABPC0_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_20;
+	u32 L1_ABPC0_DETECT;
+	u32 L1_ABPC1_RATIO_LIMIT;
+	u32 RESERVED_A_21;
+	u32 L1_ABPC1_DARK_LIMIT;
+	u32 L1_ABPC1_SN_COEF_W_AG_MIN;
+	u32 L1_ABPC1_SN_COEF_W_AG_MID;
+	u32 L1_ABPC1_SN_COEF_W_AG_MAX;
+	u32 L1_ABPC1_SN_COEF_W_TH_MIN;
+	u32 L1_ABPC1_SN_COEF_W_TH_MAX;
+	u32 L1_ABPC1_SN_COEF_B_AG_MIN;
+	u32 L1_ABPC1_SN_COEF_B_AG_MID;
+	u32 L1_ABPC1_SN_COEF_B_AG_MAX;
+	u32 L1_ABPC1_SN_COEF_B_TH_MIN;
+	u32 L1_ABPC1_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_22;
+	u32 L1_ABPC1_DETECT;
+	u32 L1_ABPC2_RATIO_LIMIT;
+	u32 RESERVED_A_23;
+	u32 L1_ABPC2_DARK_LIMIT;
+	u32 L1_ABPC2_SN_COEF_W_AG_MIN;
+	u32 L1_ABPC2_SN_COEF_W_AG_MID;
+	u32 L1_ABPC2_SN_COEF_W_AG_MAX;
+	u32 L1_ABPC2_SN_COEF_W_TH_MIN;
+	u32 L1_ABPC2_SN_COEF_W_TH_MAX;
+	u32 L1_ABPC2_SN_COEF_B_AG_MIN;
+	u32 L1_ABPC2_SN_COEF_B_AG_MID;
+	u32 L1_ABPC2_SN_COEF_B_AG_MAX;
+	u32 L1_ABPC2_SN_COEF_B_TH_MIN;
+	u32 L1_ABPC2_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_24;
+	u32 L1_ABPC2_DETECT;
+	u32 RESERVED_B_7[42];
+	u32 RESERVED_A_25;
+	u32 L1_PWHB_H_GR;
+	u32 L1_PWHB_HR;
+	u32 L1_PWHB_HB;
+	u32 L1_PWHB_H_GB;
+	u32 L1_PWHB_M_GR;
+	u32 L1_PWHB_MR;
+	u32 L1_PWHB_MB;
+	u32 L1_PWHB_M_GB;
+	u32 L1_PWHB_L_GR;
+	u32 L1_PWHB_LR;
+	u32 L1_PWHB_LB;
+	u32 L1_PWHB_L_GB;
+	u32 L1_PWHB_DSTMAXVAL;
+	u32 RESERVED_B_8[18];
+	u32 L1_RCNR0_AG_CONT;
+	u32 RESERVED_A_26;
+	u32 L1_RCNR0_SW;
+	u32 L1_RCNR0_CNF_DARK_AG0;
+	u32 L1_RCNR0_CNF_DARK_AG1;
+	u32 L1_RCNR0_CNF_DARK_AG2;
+	u32 L1_RCNR0_CNF_RATIO_AG0;
+	u32 L1_RCNR0_CNF_RATIO_AG1;
+	u32 L1_RCNR0_CNF_RATIO_AG2;
+	u32 L1_RCNR0_CNF_CLIP_GAIN_R;
+	u32 L1_RCNR0_CNF_CLIP_GAIN_G;
+	u32 L1_RCNR0_CNF_CLIP_GAIN_B;
+	u32 L1_RCNR0_A1L_DARK_AG0;
+	u32 L1_RCNR0_A1L_DARK_AG1;
+	u32 L1_RCNR0_A1L_DARK_AG2;
+	u32 L1_RCNR0_A1L_RATIO_AG0;
+	u32 L1_RCNR0_A1L_RATIO_AG1;
+	u32 L1_RCNR0_A1L_RATIO_AG2;
+	u32 L1_RCNR0_INF_ZERO_CLIP;
+	u32 RESERVED_A_27;
+	u32 L1_RCNR0_MERGE_D2BLEND_AG0;
+	u32 L1_RCNR0_MERGE_D2BLEND_AG1;
+	u32 L1_RCNR0_MERGE_D2BLEND_AG2;
+	u32 L1_RCNR0_MERGE_BLACK;
+	u32 L1_RCNR0_MERGE_MINDIV;
+	u32 L1_RCNR0_HRY_TYPE;
+	u32 L1_RCNR0_ANF_BLEND_AG0;
+	u32 L1_RCNR0_ANF_BLEND_AG1;
+	u32 L1_RCNR0_ANF_BLEND_AG2;
+	u32 RESERVED_A_28;
+	u32 L1_RCNR0_LPF_THRESHOLD;
+	u32 L1_RCNR0_MERGE_HLBLEND_AG0;
+	u32 L1_RCNR0_MERGE_HLBLEND_AG1;
+	u32 L1_RCNR0_MERGE_HLBLEND_AG2;
+	u32 L1_RCNR0_GNR_SW;
+	u32 L1_RCNR0_GNR_RATIO;
+	u32 L1_RCNR0_GNR_WIDE_EN;
+	u32 L1_RCNR1_AG_CONT;
+	u32 RESERVED_A_29;
+	u32 L1_RCNR1_SW;
+	u32 L1_RCNR1_CNF_DARK_AG0;
+	u32 L1_RCNR1_CNF_DARK_AG1;
+	u32 L1_RCNR1_CNF_DARK_AG2;
+	u32 L1_RCNR1_CNF_RATIO_AG0;
+	u32 L1_RCNR1_CNF_RATIO_AG1;
+	u32 L1_RCNR1_CNF_RATIO_AG2;
+	u32 L1_RCNR1_CNF_CLIP_GAIN_R;
+	u32 L1_RCNR1_CNF_CLIP_GAIN_G;
+	u32 L1_RCNR1_CNF_CLIP_GAIN_B;
+	u32 L1_RCNR1_A1L_DARK_AG0;
+	u32 L1_RCNR1_A1L_DARK_AG1;
+	u32 L1_RCNR1_A1L_DARK_AG2;
+	u32 L1_RCNR1_A1L_RATIO_AG0;
+	u32 L1_RCNR1_A1L_RATIO_AG1;
+	u32 L1_RCNR1_A1L_RATIO_AG2;
+	u32 L1_RCNR1_INF_ZERO_CLIP;
+	u32 RESERVED_A_30;
+	u32 L1_RCNR1_MERGE_D2BLEND_AG0;
+	u32 L1_RCNR1_MERGE_D2BLEND_AG1;
+	u32 L1_RCNR1_MERGE_D2BLEND_AG2;
+	u32 L1_RCNR1_MERGE_BLACK;
+	u32 L1_RCNR1_MERGE_MINDIV;
+	u32 L1_RCNR1_HRY_TYPE;
+	u32 L1_RCNR1_ANF_BLEND_AG0;
+	u32 L1_RCNR1_ANF_BLEND_AG1;
+	u32 L1_RCNR1_ANF_BLEND_AG2;
+	u32 RESERVED_A_31;
+	u32 L1_RCNR1_LPF_THRESHOLD;
+	u32 L1_RCNR1_MERGE_HLBLEND_AG0;
+	u32 L1_RCNR1_MERGE_HLBLEND_AG1;
+	u32 L1_RCNR1_MERGE_HLBLEND_AG2;
+	u32 L1_RCNR1_GNR_SW;
+	u32 L1_RCNR1_GNR_RATIO;
+	u32 L1_RCNR1_GNR_WIDE_EN;
+	u32 L1_RCNR2_AG_CONT;
+	u32 RESERVED_A_32;
+	u32 L1_RCNR2_SW;
+	u32 L1_RCNR2_CNF_DARK_AG0;
+	u32 L1_RCNR2_CNF_DARK_AG1;
+	u32 L1_RCNR2_CNF_DARK_AG2;
+	u32 L1_RCNR2_CNF_RATIO_AG0;
+	u32 L1_RCNR2_CNF_RATIO_AG1;
+	u32 L1_RCNR2_CNF_RATIO_AG2;
+	u32 L1_RCNR2_CNF_CLIP_GAIN_R;
+	u32 L1_RCNR2_CNF_CLIP_GAIN_G;
+	u32 L1_RCNR2_CNF_CLIP_GAIN_B;
+	u32 L1_RCNR2_A1L_DARK_AG0;
+	u32 L1_RCNR2_A1L_DARK_AG1;
+	u32 L1_RCNR2_A1L_DARK_AG2;
+	u32 L1_RCNR2_A1L_RATIO_AG0;
+	u32 L1_RCNR2_A1L_RATIO_AG1;
+	u32 L1_RCNR2_A1L_RATIO_AG2;
+	u32 L1_RCNR2_INF_ZERO_CLIP;
+	u32 RESERVED_A_33;
+	u32 L1_RCNR2_MERGE_D2BLEND_AG0;
+	u32 L1_RCNR2_MERGE_D2BLEND_AG1;
+	u32 L1_RCNR2_MERGE_D2BLEND_AG2;
+	u32 L1_RCNR2_MERGE_BLACK;
+	u32 L1_RCNR2_MERGE_MINDIV;
+	u32 L1_RCNR2_HRY_TYPE;
+	u32 L1_RCNR2_ANF_BLEND_AG0;
+	u32 L1_RCNR2_ANF_BLEND_AG1;
+	u32 L1_RCNR2_ANF_BLEND_AG2;
+	u32 RESERVED_A_34;
+	u32 L1_RCNR2_LPF_THRESHOLD;
+	u32 L1_RCNR2_MERGE_HLBLEND_AG0;
+	u32 L1_RCNR2_MERGE_HLBLEND_AG1;
+	u32 L1_RCNR2_MERGE_HLBLEND_AG2;
+	u32 L1_RCNR2_GNR_SW;
+	u32 L1_RCNR2_GNR_RATIO;
+	u32 L1_RCNR2_GNR_WIDE_EN;
+	u32 RESERVED_B_9[49];
+	u32 RESERVED_A_35;
+	u32 L1_HDRS_HDRRATIO_M;
+	u32 L1_HDRS_HDRRATIO_L;
+	u32 L1_HDRS_HDRRATIO_E;
+	u32 RESERVED_A_36;
+	u32 RESERVED_A_37;
+	u32 L1_HDRS_BLENDEND_H;
+	u32 L1_HDRS_BLENDEND_M;
+	u32 L1_HDRS_BLENDEND_E;
+	u32 L1_HDRS_BLENDBEG_H;
+	u32 L1_HDRS_BLENDBEG_M;
+	u32 L1_HDRS_BLENDBEG_E;
+	u32 RESERVED_A_38;
+	u32 RESERVED_A_39;
+	u32 RESERVED_A_40;
+	u32 RESERVED_A_41;
+	u32 RESERVED_A_42;
+	u32 RESERVED_A_43;
+	u32 L1_HDRS_DG_H;
+	u32 L1_HDRS_DG_M;
+	u32 L1_HDRS_DG_L;
+	u32 L1_HDRS_DG_E;
+	u32 L1_HDRS_LEDMODE_ON;
+	u32 L1_HDRS_HDRMODE;
+	u32 RESERVED_A_44;
+	u32 RESERVED_A_45;
+	u32 RESERVED_A_46;
+	u32 L1_HDRS_DSTMAXVAL;
+	u32 RESERVED_B_10[4];
+	u32 L1_BLVC_SRCBLACKLEVEL_GR;
+	u32 L1_BLVC_SRCBLACKLEVEL_R;
+	u32 L1_BLVC_SRCBLACKLEVEL_B;
+	u32 L1_BLVC_SRCBLACKLEVELGB;
+	u32 L1_BLVC_MULTVAL_GR;
+	u32 L1_BLVC_MULTVAL_R;
+	u32 L1_BLVC_MULTVAL_B;
+	u32 L1_BLVC_MULTVAL_GB;
+	u32 L1_BLVC_DSTMAXVAL;
+	u32 RESERVED_A_47;
+	u32 RESERVED_A_48;
+	u32 RESERVED_A_49;
+	u32 RESERVED_A_50;
+	u32 RESERVED_A_51;
+	u32 RESERVED_A_52;
+	u32 RESERVED_B_11[17];
+	u32 L1_LSSC_EN;
+	u32 L1_LSSC_AG_CONT;
+	u32 RESERVED_A_53;
+	u32 RESERVED_A_54;
+	u32 L1_LSSC_PWHB_R_GAIN;
+	u32 L1_LSSC_PWHB_GR_GAIN;
+	u32 L1_LSSC_PWHB_GB_GAIN;
+	u32 L1_LSSC_PWHB_B_GAIN;
+	u32 L1_LSSC_PARA_EN;
+	u32 L1_LSSC_PARA_H_CENTER;
+	u32 L1_LSSC_PARA_V_CENTER;
+	u32 L1_LSSC_PARA_H_GAIN;
+	u32 L1_LSSC_PARA_V_GAIN;
+	u32 L1_LSSC_PARA_MGSEL2;
+	u32 L1_LSSC_PARA_MGSEL4;
+	u32 L1_LSSC_PARA_R_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_R_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_R_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_R_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_R_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_R_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_R_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_R_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_RD;
+	u32 L1_LSSC_PARA_GR_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_GR_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_GR_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_GR_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_GR_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_GR_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_GR_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_GR_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_RD;
+	u32 L1_LSSC_PARA_GB_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_GB_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_GB_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_GB_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_GB_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_GB_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_GB_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_GB_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_RD;
+	u32 L1_LSSC_PARA_B_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_B_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_B_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_B_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_B_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_B_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_B_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_B_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_RD;
+	u32 L1_LSSC_GRID_EN;
+	u32 L1_LSSC_GRID_H_CENTER;
+	u32 L1_LSSC_GRID_V_CENTER;
+	u32 L1_LSSC_GRID_H_SIZE;
+	u32 L1_LSSC_GRID_V_SIZE;
+	u32 L1_LSSC_GRID_MGSEL;
+	u32 RESERVED_B_12[11];
+	u32 L1_MPRO_SW;
+	u32 L1_MPRO_CONF;
+	u32 RESERVED_A_55;
+	u32 L1_MPRO_DST_MINVAL;
+	u32 L1_MPRO_DST_MAXVAL;
+	u32 L1_MPRO_AG_CONT;
+	u32 RESERVED_A_56;
+	u32 RESERVED_A_57;
+	u32 L1_MPRO_LM0_RMG_MIN;
+	u32 L1_MPRO_LM0_RMB_MIN;
+	u32 L1_MPRO_LM0_GMR_MIN;
+	u32 L1_MPRO_LM0_GMB_MIN;
+	u32 L1_MPRO_LM0_BMR_MIN;
+	u32 L1_MPRO_LM0_BMG_MIN;
+	u32 L1_MPRO_LM0_RMG_MAX;
+	u32 L1_MPRO_LM0_RMB_MAX;
+	u32 L1_MPRO_LM0_GMR_MAX;
+	u32 L1_MPRO_LM0_GMB_MAX;
+	u32 L1_MPRO_LM0_BMR_MAX;
+	u32 L1_MPRO_LM0_BMG_MAX;
+	u32 RESERVED_A_58;
+	u32 RESERVED_A_59;
+	u32 RESERVED_A_60;
+	u32 RESERVED_A_61;
+	u32 RESERVED_A_62;
+	u32 RESERVED_A_63;
+	u32 RESERVED_A_64;
+	u32 RESERVED_A_65;
+	u32 RESERVED_A_66;
+	u32 RESERVED_A_67;
+	u32 RESERVED_A_68;
+	u32 RESERVED_A_69;
+	u32 RESERVED_A_70;
+	u32 RESERVED_A_71;
+	u32 RESERVED_A_72;
+	u32 RESERVED_A_73;
+	u32 RESERVED_A_74;
+	u32 RESERVED_A_75;
+	u32 RESERVED_A_76;
+	u32 RESERVED_A_77;
+	u32 RESERVED_A_78;
+	u32 RESERVED_A_79;
+	u32 RESERVED_A_80;
+	u32 RESERVED_A_81;
+	u32 RESERVED_A_82;
+	u32 RESERVED_A_83;
+	u32 RESERVED_A_84;
+	u32 RESERVED_A_85;
+	u32 RESERVED_A_86;
+	u32 RESERVED_A_87;
+	u32 RESERVED_A_88;
+	u32 RESERVED_A_89;
+	u32 RESERVED_A_90;
+	u32 RESERVED_A_91;
+	u32 RESERVED_A_92;
+	u32 RESERVED_A_93;
+	u32 RESERVED_A_94;
+	u32 RESERVED_A_95;
+	u32 RESERVED_A_96;
+	u32 RESERVED_B_13[1];
+	u32 L1_MPRO_LCS_MODE;
+	u32 RESERVED_A_97;
+	u32 RESERVED_A_98;
+	u32 RESERVED_A_99;
+	u32 RESERVED_A_100;
+	u32 RESERVED_A_101;
+	u32 RESERVED_A_102;
+	u32 RESERVED_A_103;
+	u32 RESERVED_A_104;
+	u32 RESERVED_A_105;
+	u32 RESERVED_A_106;
+	u32 RESERVED_A_107;
+	u32 RESERVED_A_108;
+	u32 RESERVED_A_109;
+	u32 RESERVED_A_110;
+	u32 RESERVED_A_111;
+	u32 RESERVED_A_112;
+	u32 RESERVED_A_113;
+	u32 RESERVED_A_114;
+	u32 RESERVED_A_115;
+	u32 RESERVED_A_116;
+	u32 RESERVED_A_117;
+	u32 RESERVED_A_118;
+	u32 RESERVED_A_119;
+	u32 RESERVED_A_120;
+	u32 RESERVED_A_121;
+	u32 RESERVED_A_122;
+	u32 RESERVED_A_123;
+	u32 RESERVED_A_124;
+	u32 RESERVED_A_125;
+	u32 RESERVED_B_14[70];
+	u32 L1_VPRO_PGC_SW;
+	u32 RESERVED_A_126;
+	u32 L1_VPRO_YUVC_SW;
+	u32 L1_VPRO_YNR_SW;
+	u32 L1_VPRO_ETE_SW;
+	u32 L1_VPRO_CSUP_UVSUP_SW;
+	u32 L1_VPRO_CSUP_CORING_SW;
+	u32 L1_VPRO_BRIGHT_SW;
+	u32 L1_VPRO_LCNT_SW;
+	u32 L1_VPRO_NLCNT_SW;
+	u32 RESERVED_A_127;
+	u32 L1_VPRO_EDGE_SUP_SW;
+	u32 L1_VPRO_CNR_SW;
+	u32 L1_VPRO_AG_CONT;
+	u32 L1_VPRO_BLKADJ;
+	u32 L1_VPRO_GAM01P;
+	u32 L1_VPRO_GAM02P;
+	u32 L1_VPRO_GAM03P;
+	u32 L1_VPRO_GAM04P;
+	u32 L1_VPRO_GAM05P;
+	u32 L1_VPRO_GAM06P;
+	u32 L1_VPRO_GAM07P;
+	u32 L1_VPRO_GAM08P;
+	u32 L1_VPRO_GAM09P;
+	u32 L1_VPRO_GAM10P;
+	u32 L1_VPRO_GAM11P;
+	u32 L1_VPRO_GAM12P;
+	u32 L1_VPRO_GAM13P;
+	u32 L1_VPRO_GAM14P;
+	u32 L1_VPRO_GAM15P;
+	u32 L1_VPRO_GAM16P;
+	u32 L1_VPRO_GAM17P;
+	u32 L1_VPRO_GAM18P;
+	u32 L1_VPRO_GAM19P;
+	u32 L1_VPRO_GAM20P;
+	u32 L1_VPRO_GAM21P;
+	u32 L1_VPRO_GAM22P;
+	u32 L1_VPRO_GAM23P;
+	u32 L1_VPRO_GAM24P;
+	u32 L1_VPRO_GAM25P;
+	u32 L1_VPRO_GAM26P;
+	u32 L1_VPRO_GAM27P;
+	u32 L1_VPRO_GAM28P;
+	u32 L1_VPRO_GAM29P;
+	u32 L1_VPRO_GAM30P;
+	u32 L1_VPRO_GAM31P;
+	u32 L1_VPRO_GAM32P;
+	u32 L1_VPRO_GAM33P;
+	u32 L1_VPRO_GAM34P;
+	u32 L1_VPRO_GAM35P;
+	u32 L1_VPRO_GAM36P;
+	u32 L1_VPRO_GAM37P;
+	u32 L1_VPRO_GAM38P;
+	u32 L1_VPRO_GAM39P;
+	u32 L1_VPRO_GAM40P;
+	u32 L1_VPRO_GAM41P;
+	u32 L1_VPRO_GAM42P;
+	u32 L1_VPRO_GAM43P;
+	u32 L1_VPRO_GAM44P;
+	u32 L1_VPRO_CB_MAT;
+	u32 L1_VPRO_CR_MAT;
+	u32 L1_VPRO_BRIGHT;
+	u32 L1_VPRO_LCONT_LEV;
+	u32 L1_VPRO_BLK_KNEE;
+	u32 L1_VPRO_WHT_KNEE;
+	u32 L1_VPRO_BLK_CONT0;
+	u32 L1_VPRO_BLK_CONT1;
+	u32 L1_VPRO_BLK_CONT2;
+	u32 L1_VPRO_WHT_CONT0;
+	u32 L1_VPRO_WHT_CONT1;
+	u32 L1_VPRO_WHT_CONT2;
+	u32 RESERVED_A_128;
+	u32 RESERVED_A_129;
+	u32 RESERVED_A_130;
+	u32 RESERVED_A_131;
+	u32 RESERVED_A_132;
+	u32 RESERVED_A_133;
+	u32 L1_VPRO_YNR_GAIN_MIN;
+	u32 L1_VPRO_YNR_GAIN_MAX;
+	u32 L1_VPRO_YNR_LIM_MIN;
+	u32 L1_VPRO_YNR_LIM_MAX;
+	u32 L1_VPRO_ETE_GAIN_MIN;
+	u32 L1_VPRO_ETE_GAIN_MAX;
+	u32 L1_VPRO_ETE_LIM_MIN;
+	u32 L1_VPRO_ETE_LIM_MAX;
+	u32 L1_VPRO_ETE_CORING_MIN;
+	u32 L1_VPRO_ETE_CORING_MAX;
+	u32 L1_VPRO_CB_GAIN;
+	u32 L1_VPRO_CR_GAIN;
+	u32 L1_VPRO_CBR_MGAIN_MIN;
+	u32 L1_VPRO_CB_P_GAIN_MAX;
+	u32 L1_VPRO_CB_M_GAIN_MAX;
+	u32 L1_VPRO_CR_P_GAIN_MAX;
+	u32 L1_VPRO_CR_M_GAIN_MAX;
+	u32 L1_VPRO_CSUP_CORING_LV_MIN;
+	u32 L1_VPRO_CSUP_CORING_LV_MAX;
+	u32 L1_VPRO_CSUP_CORING_GAIN_MIN;
+	u32 L1_VPRO_CSUP_CORING_GAIN_MAX;
+	u32 L1_VPRO_CSUP_BK_SLV;
+	u32 L1_VPRO_CSUP_BK_MP;
+	u32 L1_VPRO_CSUP_BLACK;
+	u32 L1_VPRO_CSUP_WH_SLV;
+	u32 L1_VPRO_CSUP_WH_MP;
+	u32 L1_VPRO_CSUP_WHITE;
+	u32 L1_VPRO_EDGE_SUP_GAIN;
+	u32 L1_VPRO_EDGE_SUP_LIM;
+	u32 RESERVED_B_15[22];
+	u32 L1_AWHB_SW;
+	u32 RESERVED_A_134;
+	u32 L1_AWHB_WBMRG;
+	u32 L1_AWHB_WBMGG;
+	u32 L1_AWHB_WBMBG;
+	u32 L1_AWHB_GATE_CONF0;
+	u32 L1_AWHB_GATE_CONF1;
+	u32 L1_AWHB_AREA_HSIZE;
+	u32 L1_AWHB_AREA_VSIZE;
+	u32 L1_AWHB_AREA_HOFS;
+	u32 L1_AWHB_AREA_VOFS;
+	u32 L1_AWHB_AREA_MASKH;
+	u32 L1_AWHB_AREA_MASKL;
+	u32 L1_AWHB_SQ_CONF;
+	u32 L1_AWHB_YGATEH;
+	u32 L1_AWHB_YGATEL;
+	u32 RESERVED_A_135;
+	u32 RESERVED_A_136;
+	u32 L1_AWHB_BYCUT0P;
+	u32 L1_AWHB_BYCUT0N;
+	u32 L1_AWHB_RYCUT0P;
+	u32 L1_AWHB_RYCUT0N;
+	u32 L1_AWHB_RBCUT0H;
+	u32 L1_AWHB_RBCUT0L;
+	u32 RESERVED_A_137;
+	u32 RESERVED_A_138;
+	u32 RESERVED_A_139;
+	u32 RESERVED_A_140;
+	u32 RESERVED_A_141;
+	u32 RESERVED_A_142;
+	u32 L1_AWHB_BYCUT1H;
+	u32 L1_AWHB_BYCUT1L;
+	u32 L1_AWHB_RYCUT1H;
+	u32 L1_AWHB_RYCUT1L;
+	u32 L1_AWHB_BYCUT2H;
+	u32 L1_AWHB_BYCUT2L;
+	u32 L1_AWHB_RYCUT2H;
+	u32 L1_AWHB_RYCUT2L;
+	u32 L1_AWHB_BYCUT3H;
+	u32 L1_AWHB_BYCUT3L;
+	u32 L1_AWHB_RYCUT3H;
+	u32 L1_AWHB_RYCUT3L;
+	u32 L1_AWHB_AWBSFTU;
+	u32 L1_AWHB_AWBSFTV;
+	u32 L1_AWHB_AWBSPD;
+	u32 L1_AWHB_AWBULV;
+	u32 L1_AWHB_AWBVLV;
+	u32 L1_AWHB_AWBWAIT;
+	u32 L1_AWHB_AWBONDOT;
+	u32 L1_AWHB_AWBFZTIM;
+	u32 L1_AWHB_WBGRMAX;
+	u32 L1_AWHB_WBGRMIN;
+	u32 L1_AWHB_WBGBMAX;
+	u32 L1_AWHB_WBGBMIN;
+	u32 RESERVED_A_143;
+	u32 RESERVED_A_144;
+	u32 RESERVED_A_145;
+	u32 RESERVED_A_146;
+	u32 RESERVED_A_147;
+	u32 RESERVED_A_148;
+	u32 RESERVED_A_149;
+	u32 RESERVED_A_150;
+	u32 RESERVED_A_151;
+	u32 RESERVED_A_152;
+	u32 RESERVED_A_153;
+	u32 RESERVED_A_154;
+	u32 RESERVED_A_155;
+	u32 L1_AWHB_AVE_USIG;
+	u32 L1_AWHB_AVE_VSIG;
+	u32 L1_AWHB_NUM_UVON;
+	u32 L1_AWHB_AWBGAINR;
+	u32 L1_AWHB_AWBGAING;
+	u32 L1_AWHB_AWBGAINB;
+	u32 RESERVED_A_156;
+	u32 RESERVED_A_157;
+	u32 RESERVED_A_158;
+	u32 L1_AWHB_R_CTR_STOP;
+	u32 RESERVED_A_159;
+	u32 RESERVED_B_16[2];
+	u32 L1_HOBC_EN;
+	u32 L1_HOBC_MARGIN;
+	u32 L1_HOBC01_AG_CONT;
+	u32 L1_HOBC2_AG_CONT;
+	u32 L1_HOBC0_LOB_REFLV_GR;
+	u32 L1_HOBC0_LOB_WIDTH_GR;
+	u32 L1_HOBC0_LOB_REFLV_R;
+	u32 L1_HOBC0_LOB_WIDTH_R;
+	u32 L1_HOBC0_LOB_REFLV_B;
+	u32 L1_HOBC0_LOB_WIDTH_B;
+	u32 L1_HOBC0_LOB_REFLV_GB;
+	u32 L1_HOBC0_LOB_WIDTH_GB;
+	u32 L1_HOBC1_LOB_REFLV_GR;
+	u32 L1_HOBC1_LOB_WIDTH_GR;
+	u32 L1_HOBC1_LOB_REFLV_R;
+	u32 L1_HOBC1_LOB_WIDTH_R;
+	u32 L1_HOBC1_LOB_REFLV_B;
+	u32 L1_HOBC1_LOB_WIDTH_B;
+	u32 L1_HOBC1_LOB_REFLV_GB;
+	u32 L1_HOBC1_LOB_WIDTH_GB;
+	u32 L1_HOBC2_LOB_REFLV_GR;
+	u32 L1_HOBC2_LOB_WIDTH_GR;
+	u32 L1_HOBC2_LOB_REFLV_R;
+	u32 L1_HOBC2_LOB_WIDTH_R;
+	u32 L1_HOBC2_LOB_REFLV_B;
+	u32 L1_HOBC2_LOB_WIDTH_B;
+	u32 L1_HOBC2_LOB_REFLV_GB;
+	u32 L1_HOBC2_LOB_WIDTH_GB;
+	u32 L1_HOBC0_SRC_BLKLV_GR;
+	u32 L1_HOBC0_SRC_BLKLV_R;
+	u32 L1_HOBC0_SRC_BLKLV_B;
+	u32 L1_HOBC0_SRC_BLKLV_GB;
+	u32 L1_HOBC1_SRC_BLKLV_GR;
+	u32 L1_HOBC1_SRC_BLKLV_R;
+	u32 L1_HOBC1_SRC_BLKLV_B;
+	u32 L1_HOBC1_SRC_BLKLV_GB;
+	u32 L1_HOBC2_SRC_BLKLV_GR;
+	u32 L1_HOBC2_SRC_BLKLV_R;
+	u32 L1_HOBC2_SRC_BLKLV_B;
+	u32 L1_HOBC2_SRC_BLKLV_GB;
+	u32 RESERVED_A_160;
+	u32 RESERVED_A_161;
+	u32 RESERVED_A_162;
+	u32 RESERVED_A_163;
+	u32 RESERVED_A_164;
+	u32 RESERVED_A_165;
+	u32 L1_HOBC_MAX_VAL;
+	u32 RESERVED_B_17[33];
+	u32 L1_HDRC_EN;
+	u32 L1_HDRC_THR_SFT_AMT;
+	u32 RESERVED_A_166;
+	u32 L1_HDRC_RATIO;
+	u32 RESERVED_A_167;
+	u32 RESERVED_A_168;
+	u32 RESERVED_A_169;
+	u32 L1_HDRC_PT_RATIO;
+	u32 L1_HDRC_PT_BLEND;
+	u32 L1_HDRC_PT_BLEND2;
+	u32 L1_HDRC_PT_SAT;
+	u32 L1_HDRC_TN_TYPE;
+	u32 L1_HDRC_TNP_MAX;
+	u32 L1_HDRC_TNP_MAG;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX0;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX1;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX2;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX3;
+	u32 L1_HDRC_TNP_FIL0;
+	u32 L1_HDRC_TNP_FIL1;
+	u32 L1_HDRC_TNP_FIL2;
+	u32 L1_HDRC_TNP_FIL3;
+	u32 L1_HDRC_TNP_FIL4;
+	u32 L1_HDRC_UTN_TBL0;
+	u32 L1_HDRC_UTN_TBL1;
+	u32 L1_HDRC_UTN_TBL2;
+	u32 L1_HDRC_UTN_TBL3;
+	u32 L1_HDRC_UTN_TBL4;
+	u32 L1_HDRC_UTN_TBL5;
+	u32 L1_HDRC_UTN_TBL6;
+	u32 L1_HDRC_UTN_TBL7;
+	u32 L1_HDRC_UTN_TBL8;
+	u32 L1_HDRC_UTN_TBL9;
+	u32 L1_HDRC_UTN_TBL10;
+	u32 L1_HDRC_UTN_TBL11;
+	u32 L1_HDRC_UTN_TBL12;
+	u32 L1_HDRC_UTN_TBL13;
+	u32 L1_HDRC_UTN_TBL14;
+	u32 L1_HDRC_UTN_TBL15;
+	u32 L1_HDRC_UTN_TBL16;
+	u32 L1_HDRC_UTN_TBL17;
+	u32 L1_HDRC_UTN_TBL18;
+	u32 L1_HDRC_UTN_TBL19;
+	u32 L1_HDRC_FLR_VAL;
+	u32 L1_HDRC_FLR_ADP;
+	u32 RESERVED_A_170;
+	u32 RESERVED_A_171;
+	u32 RESERVED_A_172;
+	u32 RESERVED_A_173;
+	u32 RESERVED_A_174;
+	u32 RESERVED_A_175;
+	u32 RESERVED_A_176;
+	u32 RESERVED_A_177;
+	u32 RESERVED_A_178;
+	u32 RESERVED_A_179;
+	u32 RESERVED_A_180;
+	u32 RESERVED_A_181;
+	u32 RESERVED_A_182;
+	u32 RESERVED_A_183;
+	u32 L1_HDRC_YBR_OFF;
+	u32 L1_HDRC_ORGY_BLEND;
+	u32 RESERVED_A_184;
+	u32 RESERVED_A_185;
+	u32 RESERVED_A_186;
+	u32 L1_HDRC_MAR_TOP;
+	u32 L1_HDRC_MAR_LEFT;
+	u32 RESERVED_A_187;
+	u32 RESERVED_A_188;
+	u32 RESERVED_B_18[28];
+	u32 L1_HIST_EN;
+	u32 L1_HIST_MODE;
+	u32 L1_HIST_BLOCK_OFST;
+	u32 L1_HIST_BLOCK_SIZE;
+	u32 L1_HIST_BLOCK_NUM;
+	u32 L1_HIST_BLOCK_STEP;
+	u32 L1_HIST_LINEAR_SFT;
+	u32 L1_HIST_MULT_A_R;
+	u32 L1_HIST_ADD_A_R;
+	u32 L1_HIST_MULT_B_R;
+	u32 L1_HIST_ADD_B_R;
+	u32 L1_HIST_MULT_A_G;
+	u32 L1_HIST_ADD_A_G;
+	u32 L1_HIST_MULT_B_G;
+	u32 L1_HIST_ADD_B_G;
+	u32 L1_HIST_MULT_A_B;
+	u32 L1_HIST_ADD_A_B;
+	u32 L1_HIST_MULT_B_B;
+	u32 L1_HIST_ADD_B_B;
+	u32 L1_HIST_MULT_A_Y;
+	u32 L1_HIST_ADD_A_Y;
+	u32 L1_HIST_MULT_B_Y;
+	u32 L1_HIST_ADD_B_Y;
+	u32 RESERVED_B_19[201];
+	u32 L1_CRGBF_ACC_CONF;
+	u32 L1_CRGBF_TRN_M_RUN;
+	u32 L1_CRGBF_TRN_M_CONF;
+	u32 L1_CRGBF_TRN_A_CONF;
+	u32 L1_CRGBF_TRN_STAT_CLR;
+	u32 L1_CRGBF_TRN_STAT;
+	u32 L1_CRGBF_INT_STAT;
+	u32 L1_CRGBF_INT_MASK;
+	u32 L1_CRGBF_INT_MASKED_STAT;
+	u32 L1_CRGBF_TRN_WBADDR;
+	u32 L1_CRGBF_TRN_WEADDR;
+	u32 L1_CRGBF_TRN_RBADDR;
+	u32 L1_CRGBF_TRN_READDR;
+	u32 L1_CRGBF_ISP_INT;
+	u32 L1_CRGBF_ISP_INT_MASK;
+	u32 L1_CRGBF_ISP_INT_MASKED_STAT;
+	u32 RESERVED_A_189;
+	u32 RESERVED_B_20[47];
+	u32 L1_VLATCH_SYSM_WIDTH;
+	u32 L1_VLATCH_SYSM_HEIGHT;
+	u32 L1_VLATCH_SYSM_START_COLOR;
+	u32 L1_VLATCH_SYSM_INPUT_MODE;
+	u32 RESERVED_A_190;
+	u32 L1_VLATCH_SYSM_YCOEF_R;
+	u32 L1_VLATCH_SYSM_YCOEF_G;
+	u32 L1_VLATCH_SYSM_YCOEF_B;
+	u32 RESERVED_A_191;
+	u32 RESERVED_A_192;
+	u32 RESERVED_A_193;
+	u32 RESERVED_A_194;
+	u32 RESERVED_A_195;
+	u32 RESERVED_A_196;
+	u32 RESERVED_B_21[2];
+	u32 L1_VLATCH_SYSM_AG_H;
+	u32 L1_VLATCH_SYSM_AG_M;
+	u32 L1_VLATCH_SYSM_AG_L;
+	u32 L1_VLATCH_SYSM_AG_PARAM_A;
+	u32 L1_VLATCH_SYSM_AG_PARAM_B;
+	u32 L1_VLATCH_SYSM_AG_PARAM_C;
+	u32 L1_VLATCH_SYSM_AG_PARAM_D;
+	u32 L1_VLATCH_SYSM_AG_SEL_HOBC;
+	u32 L1_VLATCH_SYSM_AG_SEL_ABPC;
+	u32 L1_VLATCH_SYSM_AG_SEL_RCNR;
+	u32 L1_VLATCH_SYSM_AG_SEL_LSSC;
+	u32 L1_VLATCH_SYSM_AG_SEL_MPRO;
+	u32 L1_VLATCH_SYSM_AG_SEL_VPRO;
+	u32 L1_VLATCH_SYSM_AG_CONT_HOBC01_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_HOBC2_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_ABPC01_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_ABPC2_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_RCNR01_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_RCNR2_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_LSSC_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_MPRO_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_VPRO_EN;
+	u32 RESERVED_A_197;
+	u32 L1_VLATCH_SYSM_MAN_CTXT;
+	u32 RESERVED_A_198;
+	u32 RESERVED_B_22[7];
+	u32 RESERVED_A_199;
+	u32 L1_VLATCH_HDRE_SRCPOINT00;
+	u32 L1_VLATCH_HDRE_SRCPOINT01;
+	u32 L1_VLATCH_HDRE_SRCPOINT02;
+	u32 L1_VLATCH_HDRE_SRCPOINT03;
+	u32 L1_VLATCH_HDRE_SRCPOINT04;
+	u32 L1_VLATCH_HDRE_SRCPOINT05;
+	u32 L1_VLATCH_HDRE_SRCPOINT06;
+	u32 L1_VLATCH_HDRE_SRCPOINT07;
+	u32 L1_VLATCH_HDRE_SRCPOINT08;
+	u32 L1_VLATCH_HDRE_SRCPOINT09;
+	u32 L1_VLATCH_HDRE_SRCPOINT10;
+	u32 L1_VLATCH_HDRE_SRCPOINT11;
+	u32 L1_VLATCH_HDRE_SRCPOINT12;
+	u32 L1_VLATCH_HDRE_SRCPOINT13;
+	u32 L1_VLATCH_HDRE_SRCPOINT14;
+	u32 L1_VLATCH_HDRE_SRCPOINT15;
+	u32 L1_VLATCH_HDRE_SRCBASE00;
+	u32 L1_VLATCH_HDRE_SRCBASE01;
+	u32 L1_VLATCH_HDRE_SRCBASE02;
+	u32 L1_VLATCH_HDRE_SRCBASE03;
+	u32 L1_VLATCH_HDRE_SRCBASE04;
+	u32 L1_VLATCH_HDRE_SRCBASE05;
+	u32 L1_VLATCH_HDRE_SRCBASE06;
+	u32 L1_VLATCH_HDRE_SRCBASE07;
+	u32 L1_VLATCH_HDRE_SRCBASE08;
+	u32 L1_VLATCH_HDRE_SRCBASE09;
+	u32 L1_VLATCH_HDRE_SRCBASE10;
+	u32 L1_VLATCH_HDRE_SRCBASE11;
+	u32 L1_VLATCH_HDRE_SRCBASE12;
+	u32 L1_VLATCH_HDRE_SRCBASE13;
+	u32 L1_VLATCH_HDRE_SRCBASE14;
+	u32 L1_VLATCH_HDRE_SRCBASE15;
+	u32 L1_VLATCH_HDRE_SRCBASE16;
+	u32 L1_VLATCH_HDRE_RATIO00;
+	u32 L1_VLATCH_HDRE_RATIO01;
+	u32 L1_VLATCH_HDRE_RATIO02;
+	u32 L1_VLATCH_HDRE_RATIO03;
+	u32 L1_VLATCH_HDRE_RATIO04;
+	u32 L1_VLATCH_HDRE_RATIO05;
+	u32 L1_VLATCH_HDRE_RATIO06;
+	u32 L1_VLATCH_HDRE_RATIO07;
+	u32 L1_VLATCH_HDRE_RATIO08;
+	u32 L1_VLATCH_HDRE_RATIO09;
+	u32 L1_VLATCH_HDRE_RATIO10;
+	u32 L1_VLATCH_HDRE_RATIO11;
+	u32 L1_VLATCH_HDRE_RATIO12;
+	u32 L1_VLATCH_HDRE_RATIO13;
+	u32 L1_VLATCH_HDRE_RATIO14;
+	u32 L1_VLATCH_HDRE_RATIO15;
+	u32 L1_VLATCH_HDRE_RATIO16;
+	u32 L1_VLATCH_HDRE_DSTBASE00;
+	u32 L1_VLATCH_HDRE_DSTBASE01;
+	u32 L1_VLATCH_HDRE_DSTBASE02;
+	u32 L1_VLATCH_HDRE_DSTBASE03;
+	u32 L1_VLATCH_HDRE_DSTBASE04;
+	u32 L1_VLATCH_HDRE_DSTBASE05;
+	u32 L1_VLATCH_HDRE_DSTBASE06;
+	u32 L1_VLATCH_HDRE_DSTBASE07;
+	u32 L1_VLATCH_HDRE_DSTBASE08;
+	u32 L1_VLATCH_HDRE_DSTBASE09;
+	u32 L1_VLATCH_HDRE_DSTBASE10;
+	u32 L1_VLATCH_HDRE_DSTBASE11;
+	u32 L1_VLATCH_HDRE_DSTBASE12;
+	u32 L1_VLATCH_HDRE_DSTBASE13;
+	u32 L1_VLATCH_HDRE_DSTBASE14;
+	u32 L1_VLATCH_HDRE_DSTBASE15;
+	u32 L1_VLATCH_HDRE_DSTBASE16;
+	u32 L1_VLATCH_HDRE_DSTMAXVAL;
+	u32 RESERVED_B_23[11];
+	u32 L1_VLATCH_AEXP_ON;
+	u32 RESERVED_A_200;
+	u32 RESERVED_A_201;
+	u32 L1_VLATCH_AEXP_FORCE_INTERRUPT_Y;
+	u32 L1_VLATCH_AEXP_START_X;
+	u32 L1_VLATCH_AEXP_START_Y;
+	u32 L1_VLATCH_AEXP_BLOCK_WIDTH;
+	u32 L1_VLATCH_AEXP_BLOCK_HEIGHT;
+	u32 L1_VLATCH_AEXP_WEIGHT_0;
+	u32 L1_VLATCH_AEXP_WEIGHT_1;
+	u32 L1_VLATCH_AEXP_WEIGHT_2;
+	u32 L1_VLATCH_AEXP_WEIGHT_3;
+	u32 L1_VLATCH_AEXP_WEIGHT_4;
+	u32 L1_VLATCH_AEXP_WEIGHT_5;
+	u32 L1_VLATCH_AEXP_WEIGHT_6;
+	u32 L1_VLATCH_AEXP_WEIGHT_7;
+	u32 L1_VLATCH_AEXP_SATUR_RATIO;
+	u32 L1_VLATCH_AEXP_BLACK_RATIO;
+	u32 L1_VLATCH_AEXP_SATUR_LEVEL;
+	u32 RESERVED_A_202;
+	u32 RESERVED_A_203;
+	u32 RESERVED_A_204;
+	u32 RESERVED_A_205;
+	u32 RESERVED_A_206;
+	u32 RESERVED_A_207;
+	u32 RESERVED_A_208;
+	u32 RESERVED_A_209;
+	u32 RESERVED_A_210;
+	u32 RESERVED_A_211;
+	u32 RESERVED_A_212;
+	u32 RESERVED_A_213;
+	u32 RESERVED_A_214;
+	u32 RESERVED_A_215;
+	u32 RESERVED_A_216;
+	u32 RESERVED_A_217;
+	u32 RESERVED_A_218;
+	u32 RESERVED_A_219;
+	u32 RESERVED_A_220;
+	u32 RESERVED_A_221;
+	u32 RESERVED_A_222;
+	u32 RESERVED_A_223;
+	u32 RESERVED_A_224;
+	u32 RESERVED_A_225;
+	u32 RESERVED_A_226;
+	u32 RESERVED_A_227;
+	u32 RESERVED_A_228;
+	u32 RESERVED_A_229;
+	u32 RESERVED_A_230;
+	u32 RESERVED_A_231;
+	u32 RESERVED_A_232;
+	u32 RESERVED_A_233;
+	u32 RESERVED_A_234;
+	u32 RESERVED_A_235;
+	u32 RESERVED_A_236;
+	u32 RESERVED_A_237;
+	u32 RESERVED_A_238;
+	u32 RESERVED_A_239;
+	u32 RESERVED_A_240;
+	u32 RESERVED_A_241;
+	u32 RESERVED_A_242;
+	u32 RESERVED_A_243;
+	u32 RESERVED_A_244;
+	u32 RESERVED_A_245;
+	u32 RESERVED_A_246;
+	u32 RESERVED_A_247;
+	u32 RESERVED_A_248;
+	u32 RESERVED_A_249;
+	u32 RESERVED_A_250;
+	u32 RESERVED_A_251;
+	u32 RESERVED_A_252;
+	u32 RESERVED_A_253;
+	u32 RESERVED_A_254;
+	u32 RESERVED_A_255;
+	u32 RESERVED_A_256;
+	u32 RESERVED_A_257;
+	u32 RESERVED_A_258;
+	u32 RESERVED_A_259;
+	u32 RESERVED_A_260;
+	u32 RESERVED_A_261;
+	u32 RESERVED_A_262;
+	u32 RESERVED_A_263;
+	u32 RESERVED_A_264;
+	u32 RESERVED_A_265;
+	u32 RESERVED_A_266;
+	u32 RESERVED_A_267;
+	u32 L1_VLATCH_AEXP_AVE4LINESY0;
+	u32 L1_VLATCH_AEXP_AVE4LINESY1;
+	u32 L1_VLATCH_AEXP_AVE4LINESY2;
+	u32 L1_VLATCH_AEXP_AVE4LINESY3;
+	u32 RESERVED_A_268;
+	u32 RESERVED_A_269;
+	u32 RESERVED_A_270;
+	u32 RESERVED_A_271;
+	u32 RESERVED_B_24[3];
+	u32 L1_VLATCH_IBUF_DEPTH;
+	u32 L1_VLATCH_IBUF_INPUT_ORDER;
+	u32 RESERVED_B_25[2];
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_GR;
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_R;
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_B;
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_GB;
+	u32 RESERVED_A_272;
+	u32 RESERVED_A_273;
+	u32 RESERVED_A_274;
+	u32 RESERVED_A_275;
+	u32 RESERVED_A_276;
+	u32 RESERVED_B_26[19];
+	u32 RESERVED_A_277;
+	u32 RESERVED_A_278;
+	u32 RESERVED_A_279;
+	u32 L1_VLATCH_ABPC012_STA_EN;
+	u32 L1_VLATCH_ABPC012_DYN_EN;
+	u32 L1_VLATCH_ABPC012_DYN_MODE;
+	u32 RESERVED_A_280;
+	u32 RESERVED_A_281;
+	u32 RESERVED_A_282;
+	u32 L1_VLATCH_ABPC0_RATIO_LIMIT;
+	u32 RESERVED_A_283;
+	u32 L1_VLATCH_ABPC0_DARK_LIMIT;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_AG_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_AG_MID;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_AG_MAX;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_TH_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_TH_MAX;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_AG_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_AG_MID;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_AG_MAX;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_TH_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_284;
+	u32 RESERVED_A_285;
+	u32 L1_VLATCH_ABPC1_RATIO_LIMIT;
+	u32 RESERVED_A_286;
+	u32 L1_VLATCH_ABPC1_DARK_LIMIT;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_AG_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_AG_MID;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_AG_MAX;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_TH_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_TH_MAX;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_AG_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_AG_MID;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_AG_MAX;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_TH_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_287;
+	u32 RESERVED_A_288;
+	u32 L1_VLATCH_ABPC2_RATIO_LIMIT;
+	u32 RESERVED_A_289;
+	u32 L1_VLATCH_ABPC2_DARK_LIMIT;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_AG_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_AG_MID;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_AG_MAX;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_TH_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_TH_MAX;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_AG_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_AG_MID;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_AG_MAX;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_TH_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_290;
+	u32 RESERVED_A_291;
+	u32 RESERVED_B_27[42];
+	u32 RESERVED_A_292;
+	u32 L1_VLATCH_PWHB_H_GR;
+	u32 L1_VLATCH_PWHB_HR;
+	u32 L1_VLATCH_PWHB_HB;
+	u32 L1_VLATCH_PWHB_H_GB;
+	u32 L1_VLATCH_PWHB_M_GR;
+	u32 L1_VLATCH_PWHB_MR;
+	u32 L1_VLATCH_PWHB_MB;
+	u32 L1_VLATCH_PWHB_M_GB;
+	u32 L1_VLATCH_PWHB_L_GR;
+	u32 L1_VLATCH_PWHB_LR;
+	u32 L1_VLATCH_PWHB_LB;
+	u32 L1_VLATCH_PWHB_L_GB;
+	u32 L1_VLATCH_PWHB_DSTMAXVAL;
+	u32 RESERVED_B_28[18];
+	u32 RESERVED_A_293;
+	u32 RESERVED_A_294;
+	u32 L1_VLATCH_RCNR0_SW;
+	u32 L1_VLATCH_RCNR0_CNF_DARK_AG0;
+	u32 L1_VLATCH_RCNR0_CNF_DARK_AG1;
+	u32 L1_VLATCH_RCNR0_CNF_DARK_AG2;
+	u32 L1_VLATCH_RCNR0_CNF_RATIO_AG0;
+	u32 L1_VLATCH_RCNR0_CNF_RATIO_AG1;
+	u32 L1_VLATCH_RCNR0_CNF_RATIO_AG2;
+	u32 L1_VLATCH_RCNR0_CNF_CLIP_GAIN_R;
+	u32 L1_VLATCH_RCNR0_CNF_CLIP_GAIN_G;
+	u32 L1_VLATCH_RCNR0_CNF_CLIP_GAIN_B;
+	u32 L1_VLATCH_RCNR0_A1L_DARK_AG0;
+	u32 L1_VLATCH_RCNR0_A1L_DARK_AG1;
+	u32 L1_VLATCH_RCNR0_A1L_DARK_AG2;
+	u32 L1_VLATCH_RCNR0_A1L_RATIO_AG0;
+	u32 L1_VLATCH_RCNR0_A1L_RATIO_AG1;
+	u32 L1_VLATCH_RCNR0_A1L_RATIO_AG2;
+	u32 L1_VLATCH_RCNR0_INF_ZERO_CLIP;
+	u32 RESERVED_A_295;
+	u32 L1_VLATCH_RCNR0_MERGE_D2BLEND_AG0;
+	u32 L1_VLATCH_RCNR0_MERGE_D2BLEND_AG1;
+	u32 L1_VLATCH_RCNR0_MERGE_D2BLEND_AG2;
+	u32 L1_VLATCH_RCNR0_MERGE_BLACK;
+	u32 L1_VLATCH_RCNR0_MERGE_MINDIV;
+	u32 L1_VLATCH_RCNR0_HRY_TYPE;
+	u32 L1_VLATCH_RCNR0_ANF_BLEND_AG0;
+	u32 L1_VLATCH_RCNR0_ANF_BLEND_AG1;
+	u32 L1_VLATCH_RCNR0_ANF_BLEND_AG2;
+	u32 RESERVED_A_296;
+	u32 L1_VLATCH_RCNR0_LPF_THRESHOLD;
+	u32 L1_VLATCH_RCNR0_MERGE_HLBLEND_AG0;
+	u32 L1_VLATCH_RCNR0_MERGE_HLBLEND_AG1;
+	u32 L1_VLATCH_RCNR0_MERGE_HLBLEND_AG2;
+	u32 L1_VLATCH_RCNR0_GNR_SW;
+	u32 L1_VLATCH_RCNR0_GNR_RATIO;
+	u32 L1_VLATCH_RCNR0_GNR_WIDE_EN;
+	u32 RESERVED_A_297;
+	u32 RESERVED_A_298;
+	u32 L1_VLATCH_RCNR1_SW;
+	u32 L1_VLATCH_RCNR1_CNF_DARK_AG0;
+	u32 L1_VLATCH_RCNR1_CNF_DARK_AG1;
+	u32 L1_VLATCH_RCNR1_CNF_DARK_AG2;
+	u32 L1_VLATCH_RCNR1_CNF_RATIO_AG0;
+	u32 L1_VLATCH_RCNR1_CNF_RATIO_AG1;
+	u32 L1_VLATCH_RCNR1_CNF_RATIO_AG2;
+	u32 L1_VLATCH_RCNR1_CNF_CLIP_GAIN_R;
+	u32 L1_VLATCH_RCNR1_CNF_CLIP_GAIN_G;
+	u32 L1_VLATCH_RCNR1_CNF_CLIP_GAIN_B;
+	u32 L1_VLATCH_RCNR1_A1L_DARK_AG0;
+	u32 L1_VLATCH_RCNR1_A1L_DARK_AG1;
+	u32 L1_VLATCH_RCNR1_A1L_DARK_AG2;
+	u32 L1_VLATCH_RCNR1_A1L_RATIO_AG0;
+	u32 L1_VLATCH_RCNR1_A1L_RATIO_AG1;
+	u32 L1_VLATCH_RCNR1_A1L_RATIO_AG2;
+	u32 L1_VLATCH_RCNR1_INF_ZERO_CLIP;
+	u32 RESERVED_A_299;
+	u32 L1_VLATCH_RCNR1_MERGE_D2BLEND_AG0;
+	u32 L1_VLATCH_RCNR1_MERGE_D2BLEND_AG1;
+	u32 L1_VLATCH_RCNR1_MERGE_D2BLEND_AG2;
+	u32 L1_VLATCH_RCNR1_MERGE_BLACK;
+	u32 L1_VLATCH_RCNR1_MERGE_MINDIV;
+	u32 L1_VLATCH_RCNR1_HRY_TYPE;
+	u32 L1_VLATCH_RCNR1_ANF_BLEND_AG0;
+	u32 L1_VLATCH_RCNR1_ANF_BLEND_AG1;
+	u32 L1_VLATCH_RCNR1_ANF_BLEND_AG2;
+	u32 RESERVED_A_300;
+	u32 L1_VLATCH_RCNR1_LPF_THRESHOLD;
+	u32 L1_VLATCH_RCNR1_MERGE_HLBLEND_AG0;
+	u32 L1_VLATCH_RCNR1_MERGE_HLBLEND_AG1;
+	u32 L1_VLATCH_RCNR1_MERGE_HLBLEND_AG2;
+	u32 L1_VLATCH_RCNR1_GNR_SW;
+	u32 L1_VLATCH_RCNR1_GNR_RATIO;
+	u32 L1_VLATCH_RCNR1_GNR_WIDE_EN;
+	u32 RESERVED_A_301;
+	u32 RESERVED_A_302;
+	u32 L1_VLATCH_RCNR2_SW;
+	u32 L1_VLATCH_RCNR2_CNF_DARK_AG0;
+	u32 L1_VLATCH_RCNR2_CNF_DARK_AG1;
+	u32 L1_VLATCH_RCNR2_CNF_DARK_AG2;
+	u32 L1_VLATCH_RCNR2_CNF_RATIO_AG0;
+	u32 L1_VLATCH_RCNR2_CNF_RATIO_AG1;
+	u32 L1_VLATCH_RCNR2_CNF_RATIO_AG2;
+	u32 L1_VLATCH_RCNR2_CNF_CLIP_GAIN_R;
+	u32 L1_VLATCH_RCNR2_CNF_CLIP_GAIN_G;
+	u32 L1_VLATCH_RCNR2_CNF_CLIP_GAIN_B;
+	u32 L1_VLATCH_RCNR2_A1L_DARK_AG0;
+	u32 L1_VLATCH_RCNR2_A1L_DARK_AG1;
+	u32 L1_VLATCH_RCNR2_A1L_DARK_AG2;
+	u32 L1_VLATCH_RCNR2_A1L_RATIO_AG0;
+	u32 L1_VLATCH_RCNR2_A1L_RATIO_AG1;
+	u32 L1_VLATCH_RCNR2_A1L_RATIO_AG2;
+	u32 L1_VLATCH_RCNR2_INF_ZERO_CLIP;
+	u32 RESERVED_A_303;
+	u32 L1_VLATCH_RCNR2_MERGE_D2BLEND_AG0;
+	u32 L1_VLATCH_RCNR2_MERGE_D2BLEND_AG1;
+	u32 L1_VLATCH_RCNR2_MERGE_D2BLEND_AG2;
+	u32 L1_VLATCH_RCNR2_MERGE_BLACK;
+	u32 L1_VLATCH_RCNR2_MERGE_MINDIV;
+	u32 L1_VLATCH_RCNR2_HRY_TYPE;
+	u32 L1_VLATCH_RCNR2_ANF_BLEND_AG0;
+	u32 L1_VLATCH_RCNR2_ANF_BLEND_AG1;
+	u32 L1_VLATCH_RCNR2_ANF_BLEND_AG2;
+	u32 RESERVED_A_304;
+	u32 L1_VLATCH_RCNR2_LPF_THRESHOLD;
+	u32 L1_VLATCH_RCNR2_MERGE_HLBLEND_AG0;
+	u32 L1_VLATCH_RCNR2_MERGE_HLBLEND_AG1;
+	u32 L1_VLATCH_RCNR2_MERGE_HLBLEND_AG2;
+	u32 L1_VLATCH_RCNR2_GNR_SW;
+	u32 L1_VLATCH_RCNR2_GNR_RATIO;
+	u32 L1_VLATCH_RCNR2_GNR_WIDE_EN;
+	u32 RESERVED_B_29[49];
+	u32 RESERVED_A_305;
+	u32 L1_VLATCH_HDRS_HDRRATIO_M;
+	u32 L1_VLATCH_HDRS_HDRRATIO_L;
+	u32 L1_VLATCH_HDRS_HDRRATIO_E;
+	u32 RESERVED_A_306;
+	u32 RESERVED_A_307;
+	u32 L1_VLATCH_HDRS_BLENDEND_H;
+	u32 L1_VLATCH_HDRS_BLENDEND_M;
+	u32 L1_VLATCH_HDRS_BLENDEND_E;
+	u32 L1_VLATCH_HDRS_BLENDBEG_H;
+	u32 L1_VLATCH_HDRS_BLENDBEG_M;
+	u32 L1_VLATCH_HDRS_BLENDBEG_E;
+	u32 RESERVED_A_308;
+	u32 RESERVED_A_309;
+	u32 RESERVED_A_310;
+	u32 RESERVED_A_311;
+	u32 RESERVED_A_312;
+	u32 RESERVED_A_313;
+	u32 L1_VLATCH_HDRS_DgH;
+	u32 L1_VLATCH_HDRS_DgM;
+	u32 L1_VLATCH_HDRS_DgL;
+	u32 L1_VLATCH_HDRS_DgE;
+	u32 L1_VLATCH_HDRS_LEDMODE_ON;
+	u32 L1_VLATCH_HDRS_HDRMODE;
+	u32 RESERVED_A_314;
+	u32 RESERVED_A_315;
+	u32 RESERVED_A_316;
+	u32 L1_VLATCH_HDRS_DSTMAXVAL;
+	u32 RESERVED_B_30[4];
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_GR;
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_R;
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_B;
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_GB;
+	u32 L1_VLATCH_BLVC_MULTVAL_GR;
+	u32 L1_VLATCH_BLVC_MULTVALR;
+	u32 L1_VLATCH_BLVC_MULTVALB;
+	u32 L1_VLATCH_BLVC_MULTVAL_GB;
+	u32 L1_VLATCH_BLVC_DSTMAXVAL;
+	u32 RESERVED_A_317;
+	u32 RESERVED_A_318;
+	u32 RESERVED_A_319;
+	u32 RESERVED_A_320;
+	u32 RESERVED_A_321;
+	u32 RESERVED_A_322;
+	u32 RESERVED_B_31[17];
+	u32 L1_VLATCH_LSSC_EN;
+	u32 RESERVED_A_323;
+	u32 RESERVED_A_324;
+	u32 RESERVED_A_325;
+	u32 L1_VLATCH_LSSC_PWHB_R_GAIN;
+	u32 L1_VLATCH_LSSC_PWHB_GR_GAIN;
+	u32 L1_VLATCH_LSSC_PWHB_GB_GAIN;
+	u32 L1_VLATCH_LSSC_PWHB_B_GAIN;
+	u32 L1_VLATCH_LSSC_PARA_EN;
+	u32 L1_VLATCH_LSSC_PARA_H_CENTER;
+	u32 L1_VLATCH_LSSC_PARA_V_CENTER;
+	u32 L1_VLATCH_LSSC_PARA_H_GAIN;
+	u32 L1_VLATCH_LSSC_PARA_V_GAIN;
+	u32 L1_VLATCH_LSSC_PARA_MGSEL2;
+	u32 L1_VLATCH_LSSC_PARA_MGSEL4;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_GRID_EN;
+	u32 L1_VLATCH_LSSC_GRID_H_CENTER;
+	u32 L1_VLATCH_LSSC_GRID_V_CENTER;
+	u32 L1_VLATCH_LSSC_GRID_H_SIZE;
+	u32 L1_VLATCH_LSSC_GRID_V_SIZE;
+	u32 L1_VLATCH_LSSC_GRID_MGSEL;
+	u32 RESERVED_B_32[11];
+	u32 L1_VLATCH_MPRO_SW;
+	u32 L1_VLATCH_MPRO_CONF;
+	u32 RESERVED_A_326;
+	u32 L1_VLATCH_MPRO_DST_MINVAL;
+	u32 L1_VLATCH_MPRO_DST_MAXVAL;
+	u32 RESERVED_A_327;
+	u32 RESERVED_A_328;
+	u32 RESERVED_A_329;
+	u32 L1_VLATCH_MPRO_LM0_RMG_MIN;
+	u32 L1_VLATCH_MPRO_LM0_RMB_MIN;
+	u32 L1_VLATCH_MPRO_LM0_GMR_MIN;
+	u32 L1_VLATCH_MPRO_LM0_GMB_MIN;
+	u32 L1_VLATCH_MPRO_LM0_BMR_MIN;
+	u32 L1_VLATCH_MPRO_LM0_BMG_MIN;
+	u32 L1_VLATCH_MPRO_LM0_RMG_MAX;
+	u32 L1_VLATCH_MPRO_LM0_RMB_MAX;
+	u32 L1_VLATCH_MPRO_LM0_GMR_MAX;
+	u32 L1_VLATCH_MPRO_LM0_GMB_MAX;
+	u32 L1_VLATCH_MPRO_LM0_BMR_MAX;
+	u32 L1_VLATCH_MPRO_LM0_BMG_MAX;
+	u32 RESERVED_A_330;
+	u32 RESERVED_A_331;
+	u32 RESERVED_A_332;
+	u32 RESERVED_A_333;
+	u32 RESERVED_A_334;
+	u32 RESERVED_A_335;
+	u32 RESERVED_A_336;
+	u32 RESERVED_A_337;
+	u32 RESERVED_A_338;
+	u32 RESERVED_A_339;
+	u32 RESERVED_A_340;
+	u32 RESERVED_A_341;
+	u32 RESERVED_A_342;
+	u32 RESERVED_A_343;
+	u32 RESERVED_A_344;
+	u32 RESERVED_A_345;
+	u32 RESERVED_A_346;
+	u32 RESERVED_A_347;
+	u32 RESERVED_A_348;
+	u32 RESERVED_A_349;
+	u32 RESERVED_A_350;
+	u32 RESERVED_A_351;
+	u32 RESERVED_A_352;
+	u32 RESERVED_A_353;
+	u32 RESERVED_A_354;
+	u32 RESERVED_A_355;
+	u32 RESERVED_A_356;
+	u32 RESERVED_A_357;
+	u32 RESERVED_A_358;
+	u32 RESERVED_A_359;
+	u32 RESERVED_A_360;
+	u32 RESERVED_A_361;
+	u32 RESERVED_A_362;
+	u32 RESERVED_A_363;
+	u32 RESERVED_A_364;
+	u32 RESERVED_A_365;
+	u32 RESERVED_A_366;
+	u32 RESERVED_A_367;
+	u32 RESERVED_A_368;
+	u32 RESERVED_B_33[1];
+	u32 L1_VLATCH_MPRO_LCS_MODE;
+	u32 RESERVED_A_369;
+	u32 RESERVED_A_370;
+	u32 RESERVED_A_371;
+	u32 RESERVED_A_372;
+	u32 RESERVED_A_373;
+	u32 RESERVED_A_374;
+	u32 RESERVED_A_375;
+	u32 RESERVED_A_376;
+	u32 RESERVED_A_377;
+	u32 RESERVED_A_378;
+	u32 RESERVED_A_379;
+	u32 RESERVED_A_380;
+	u32 RESERVED_A_381;
+	u32 RESERVED_A_382;
+	u32 RESERVED_A_383;
+	u32 RESERVED_A_384;
+	u32 RESERVED_A_385;
+	u32 RESERVED_A_386;
+	u32 RESERVED_A_387;
+	u32 RESERVED_A_388;
+	u32 RESERVED_A_389;
+	u32 RESERVED_A_390;
+	u32 RESERVED_A_391;
+	u32 RESERVED_A_392;
+	u32 RESERVED_A_393;
+	u32 RESERVED_A_394;
+	u32 RESERVED_A_395;
+	u32 RESERVED_A_396;
+	u32 RESERVED_A_397;
+	u32 RESERVED_B_34[70];
+	u32 L1_VLATCH_VPRO_PGC_SW;
+	u32 RESERVED_A_398;
+	u32 L1_VLATCH_VPRO_YUVC_SW;
+	u32 L1_VLATCH_VPRO_YNR_SW;
+	u32 L1_VLATCH_VPRO_ETE_SW;
+	u32 L1_VLATCH_VPRO_CSUP_UVSUP_SW;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_SW;
+	u32 L1_VLATCH_VPRO_BRIGHT_SW;
+	u32 L1_VLATCH_VPRO_LCNT_SW;
+	u32 L1_VLATCH_VPRO_NLCNT_SW;
+	u32 RESERVED_A_399;
+	u32 L1_VLATCH_VPRO_EDGE_SUP_SW;
+	u32 L1_VLATCH_VPRO_CNR_SW;
+	u32 RESERVED_A_400;
+	u32 L1_VLATCH_VPRO_BLKADJ;
+	u32 L1_VLATCH_VPRO_GAM01P;
+	u32 L1_VLATCH_VPRO_GAM02P;
+	u32 L1_VLATCH_VPRO_GAM03P;
+	u32 L1_VLATCH_VPRO_GAM04P;
+	u32 L1_VLATCH_VPRO_GAM05P;
+	u32 L1_VLATCH_VPRO_GAM06P;
+	u32 L1_VLATCH_VPRO_GAM07P;
+	u32 L1_VLATCH_VPRO_GAM08P;
+	u32 L1_VLATCH_VPRO_GAM09P;
+	u32 L1_VLATCH_VPRO_GAM10P;
+	u32 L1_VLATCH_VPRO_GAM11P;
+	u32 L1_VLATCH_VPRO_GAM12P;
+	u32 L1_VLATCH_VPRO_GAM13P;
+	u32 L1_VLATCH_VPRO_GAM14P;
+	u32 L1_VLATCH_VPRO_GAM15P;
+	u32 L1_VLATCH_VPRO_GAM16P;
+	u32 L1_VLATCH_VPRO_GAM17P;
+	u32 L1_VLATCH_VPRO_GAM18P;
+	u32 L1_VLATCH_VPRO_GAM19P;
+	u32 L1_VLATCH_VPRO_GAM20P;
+	u32 L1_VLATCH_VPRO_GAM21P;
+	u32 L1_VLATCH_VPRO_GAM22P;
+	u32 L1_VLATCH_VPRO_GAM23P;
+	u32 L1_VLATCH_VPRO_GAM24P;
+	u32 L1_VLATCH_VPRO_GAM25P;
+	u32 L1_VLATCH_VPRO_GAM26P;
+	u32 L1_VLATCH_VPRO_GAM27P;
+	u32 L1_VLATCH_VPRO_GAM28P;
+	u32 L1_VLATCH_VPRO_GAM29P;
+	u32 L1_VLATCH_VPRO_GAM30P;
+	u32 L1_VLATCH_VPRO_GAM31P;
+	u32 L1_VLATCH_VPRO_GAM32P;
+	u32 L1_VLATCH_VPRO_GAM33P;
+	u32 L1_VLATCH_VPRO_GAM34P;
+	u32 L1_VLATCH_VPRO_GAM35P;
+	u32 L1_VLATCH_VPRO_GAM36P;
+	u32 L1_VLATCH_VPRO_GAM37P;
+	u32 L1_VLATCH_VPRO_GAM38P;
+	u32 L1_VLATCH_VPRO_GAM39P;
+	u32 L1_VLATCH_VPRO_GAM40P;
+	u32 L1_VLATCH_VPRO_GAM41P;
+	u32 L1_VLATCH_VPRO_GAM42P;
+	u32 L1_VLATCH_VPRO_GAM43P;
+	u32 L1_VLATCH_VPRO_GAM44P;
+	u32 L1_VLATCH_VPRO_CB_MAT;
+	u32 L1_VLATCH_VPRO_CR_MAT;
+	u32 L1_VLATCH_VPRO_BRIGHT;
+	u32 L1_VLATCH_VPRO_LCONT_LEV;
+	u32 L1_VLATCH_VPRO_BLK_KNEE;
+	u32 L1_VLATCH_VPRO_WHT_KNEE;
+	u32 L1_VLATCH_VPRO_BLK_CONT0;
+	u32 L1_VLATCH_VPRO_BLK_CONT1;
+	u32 L1_VLATCH_VPRO_BLK_CONT2;
+	u32 L1_VLATCH_VPRO_WHT_CONT0;
+	u32 L1_VLATCH_VPRO_WHT_CONT1;
+	u32 L1_VLATCH_VPRO_WHT_CONT2;
+	u32 RESERVED_A_401;
+	u32 RESERVED_A_402;
+	u32 RESERVED_A_403;
+	u32 RESERVED_A_404;
+	u32 RESERVED_A_405;
+	u32 RESERVED_A_406;
+	u32 L1_VLATCH_VPRO_YNR_GAIN_MIN;
+	u32 L1_VLATCH_VPRO_YNR_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_YNR_LIM_MIN;
+	u32 L1_VLATCH_VPRO_YNR_LIM_MAX;
+	u32 L1_VLATCH_VPRO_ETE_GAIN_MIN;
+	u32 L1_VLATCH_VPRO_ETE_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_ETE_LIM_MIN;
+	u32 L1_VLATCH_VPRO_ETE_LIM_MAX;
+	u32 L1_VLATCH_VPRO_ETE_CORING_MIN;
+	u32 L1_VLATCH_VPRO_ETE_CORING_MAX;
+	u32 L1_VLATCH_VPRO_CB_GAIN;
+	u32 L1_VLATCH_VPRO_CR_GAIN;
+	u32 L1_VLATCH_VPRO_CBR_MGAIN_MIN;
+	u32 L1_VLATCH_VPRO_CbP_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CbM_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CrP_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CrM_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_LV_MIN;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_LV_MAX;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_GAIN_MIN;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CSUP_BK_SLV;
+	u32 L1_VLATCH_VPRO_CSUP_BK_MP;
+	u32 L1_VLATCH_VPRO_CSUP_BLACK;
+	u32 L1_VLATCH_VPRO_CSUP_WH_SLV;
+	u32 L1_VLATCH_VPRO_CSUP_WH_MP;
+	u32 L1_VLATCH_VPRO_CSUP_WHITE;
+	u32 L1_VLATCH_VPRO_EDGE_SUP_GAIN;
+	u32 L1_VLATCH_VPRO_EDGE_SUP_LIM;
+	u32 RESERVED_B_35[22];
+	u32 L1_VLATCH_AWHB_SW;
+	u32 RESERVED_A_407;
+	u32 L1_VLATCH_AWHB_WBMRG;
+	u32 L1_VLATCH_AWHB_WBMGG;
+	u32 L1_VLATCH_AWHB_WBMBG;
+	u32 L1_VLATCH_AWHB_GATE_CONF0;
+	u32 L1_VLATCH_AWHB_GATE_CONF1;
+	u32 L1_VLATCH_AWHB_AREA_HSIZE;
+	u32 L1_VLATCH_AWHB_AREA_VSIZE;
+	u32 L1_VLATCH_AWHB_AREA_HOFS;
+	u32 L1_VLATCH_AWHB_AREA_VOFS;
+	u32 L1_VLATCH_AWHB_AREA_MASKH;
+	u32 L1_VLATCH_AWHB_AREA_MASKL;
+	u32 L1_VLATCH_AWHB_SQ_CONF;
+	u32 L1_VLATCH_AWHB_YGATEH;
+	u32 L1_VLATCH_AWHB_YGATEL;
+	u32 RESERVED_A_408;
+	u32 RESERVED_A_409;
+	u32 L1_VLATCH_AWHB_BYCUT0P;
+	u32 L1_VLATCH_AWHB_BYCUT0N;
+	u32 L1_VLATCH_AWHB_RYCUT0P;
+	u32 L1_VLATCH_AWHB_RYCUT0N;
+	u32 L1_VLATCH_AWHB_RBCUT0H;
+	u32 L1_VLATCH_AWHB_RBCUT0L;
+	u32 RESERVED_A_410;
+	u32 RESERVED_A_411;
+	u32 RESERVED_A_412;
+	u32 RESERVED_A_413;
+	u32 RESERVED_A_414;
+	u32 RESERVED_A_415;
+	u32 L1_VLATCH_AWHB_BYCUT1H;
+	u32 L1_VLATCH_AWHB_BYCUT1L;
+	u32 L1_VLATCH_AWHB_RYCUT1H;
+	u32 L1_VLATCH_AWHB_RYCUT1L;
+	u32 L1_VLATCH_AWHB_BYCUT2H;
+	u32 L1_VLATCH_AWHB_BYCUT2L;
+	u32 L1_VLATCH_AWHB_RYCUT2H;
+	u32 L1_VLATCH_AWHB_RYCUT2L;
+	u32 L1_VLATCH_AWHB_BYCUT3H;
+	u32 L1_VLATCH_AWHB_BYCUT3L;
+	u32 L1_VLATCH_AWHB_RYCUT3H;
+	u32 L1_VLATCH_AWHB_RYCUT3L;
+	u32 L1_VLATCH_AWHB_AWBSFTU;
+	u32 L1_VLATCH_AWHB_AWBSFTV;
+	u32 L1_VLATCH_AWHB_AWBSPD;
+	u32 L1_VLATCH_AWHB_AWBULV;
+	u32 L1_VLATCH_AWHB_AWBVLV;
+	u32 L1_VLATCH_AWHB_AWBWAIT;
+	u32 L1_VLATCH_AWHB_AWBONDOT;
+	u32 L1_VLATCH_AWHB_AWBFZTIM;
+	u32 L1_VLATCH_AWHB_WBGRMAX;
+	u32 L1_VLATCH_AWHB_WBGRMIN;
+	u32 L1_VLATCH_AWHB_WBGBMAX;
+	u32 L1_VLATCH_AWHB_WBGBMIN;
+	u32 RESERVED_A_416;
+	u32 RESERVED_A_417;
+	u32 RESERVED_A_418;
+	u32 RESERVED_A_419;
+	u32 RESERVED_A_420;
+	u32 RESERVED_A_421;
+	u32 RESERVED_A_422;
+	u32 RESERVED_A_423;
+	u32 RESERVED_A_424;
+	u32 RESERVED_A_425;
+	u32 RESERVED_A_426;
+	u32 RESERVED_A_427;
+	u32 RESERVED_A_428;
+	u32 RESERVED_A_429;
+	u32 RESERVED_A_430;
+	u32 RESERVED_A_431;
+	u32 RESERVED_A_432;
+	u32 RESERVED_A_433;
+	u32 RESERVED_A_434;
+	u32 RESERVED_A_435;
+	u32 RESERVED_A_436;
+	u32 RESERVED_A_437;
+	u32 RESERVED_A_438;
+	u32 RESERVED_A_439;
+	u32 RESERVED_B_36[2];
+	u32 L1_VLATCH_HOBC_EN;
+	u32 L1_VLATCH_HOBC_MARGIN;
+	u32 RESERVED_A_440;
+	u32 RESERVED_A_441;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_GR;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_GR;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_R;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_R;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_B;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_B;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_GB;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_GB;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_GR;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_GR;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_R;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_R;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_B;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_B;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_GB;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_GB;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_GR;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_GR;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_R;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_R;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_B;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_B;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_GB;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_GB;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_GR;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_R;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_B;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_GB;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_GR;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_R;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_B;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_GB;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_GR;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_R;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_B;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_GB;
+	u32 RESERVED_A_442;
+	u32 RESERVED_A_443;
+	u32 RESERVED_A_444;
+	u32 RESERVED_A_445;
+	u32 RESERVED_A_446;
+	u32 RESERVED_A_447;
+	u32 L1_VLATCH_HOBC_MAX_VAL;
+	u32 RESERVED_B_37[33];
+	u32 L1_VLATCH_HDRC_EN;
+	u32 L1_VLATCH_HDRC_THR_SFT_AMT;
+	u32 RESERVED_A_448;
+	u32 L1_VLATCH_HDRC_RATIO;
+	u32 RESERVED_A_449;
+	u32 RESERVED_A_450;
+	u32 RESERVED_A_451;
+	u32 L1_VLATCH_HDRC_PT_RATIO;
+	u32 L1_VLATCH_HDRC_PT_BLEND;
+	u32 L1_VLATCH_HDRC_PT_BLEND2;
+	u32 L1_VLATCH_HDRC_PT_SAT;
+	u32 L1_VLATCH_HDRC_TN_TYPE;
+	u32 L1_VLATCH_HDRC_TNP_MAX;
+	u32 L1_VLATCH_HDRC_TNP_MAG;
+	u32 RESERVED_A_452;
+	u32 RESERVED_A_453;
+	u32 RESERVED_A_454;
+	u32 RESERVED_A_455;
+	u32 L1_VLATCH_HDRC_TNP_FIL0;
+	u32 L1_VLATCH_HDRC_TNP_FIL1;
+	u32 L1_VLATCH_HDRC_TNP_FIL2;
+	u32 L1_VLATCH_HDRC_TNP_FIL3;
+	u32 L1_VLATCH_HDRC_TNP_FIL4;
+	u32 L1_VLATCH_HDRC_UTN_TBL0;
+	u32 L1_VLATCH_HDRC_UTN_TBL1;
+	u32 L1_VLATCH_HDRC_UTN_TBL2;
+	u32 L1_VLATCH_HDRC_UTN_TBL3;
+	u32 L1_VLATCH_HDRC_UTN_TBL4;
+	u32 L1_VLATCH_HDRC_UTN_TBL5;
+	u32 L1_VLATCH_HDRC_UTN_TBL6;
+	u32 L1_VLATCH_HDRC_UTN_TBL7;
+	u32 L1_VLATCH_HDRC_UTN_TBL8;
+	u32 L1_VLATCH_HDRC_UTN_TBL9;
+	u32 L1_VLATCH_HDRC_UTN_TBL10;
+	u32 L1_VLATCH_HDRC_UTN_TBL11;
+	u32 L1_VLATCH_HDRC_UTN_TBL12;
+	u32 L1_VLATCH_HDRC_UTN_TBL13;
+	u32 L1_VLATCH_HDRC_UTN_TBL14;
+	u32 L1_VLATCH_HDRC_UTN_TBL15;
+	u32 L1_VLATCH_HDRC_UTN_TBL16;
+	u32 L1_VLATCH_HDRC_UTN_TBL17;
+	u32 L1_VLATCH_HDRC_UTN_TBL18;
+	u32 L1_VLATCH_HDRC_UTN_TBL19;
+	u32 L1_VLATCH_HDRC_FLR_VAL;
+	u32 L1_VLATCH_HDRC_FLR_ADP;
+	u32 RESERVED_A_456;
+	u32 RESERVED_A_457;
+	u32 RESERVED_A_458;
+	u32 RESERVED_A_459;
+	u32 RESERVED_A_460;
+	u32 RESERVED_A_461;
+	u32 RESERVED_A_462;
+	u32 RESERVED_A_463;
+	u32 RESERVED_A_464;
+	u32 RESERVED_A_465;
+	u32 RESERVED_A_466;
+	u32 RESERVED_A_467;
+	u32 RESERVED_A_468;
+	u32 RESERVED_A_469;
+	u32 L1_VLATCH_HDRC_YBR_OFF;
+	u32 L1_VLATCH_HDRC_ORGY_BLEND;
+	u32 RESERVED_A_470;
+	u32 RESERVED_A_471;
+	u32 RESERVED_A_472;
+	u32 L1_VLATCH_HDRC_MAR_TOP;
+	u32 L1_VLATCH_HDRC_MAR_LEFT;
+	u32 RESERVED_A_473;
+	u32 RESERVED_A_474;
+	u32 RESERVED_B_38[28];
+	u32 L1_VLATCH_HIST_EN;
+	u32 L1_VLATCH_HIST_MODE;
+	u32 L1_VLATCH_HIST_BLOCK_OFST;
+	u32 L1_VLATCH_HIST_BLOCK_SIZE;
+	u32 L1_VLATCH_HIST_BLOCK_NUM;
+	u32 L1_VLATCH_HIST_BLOCK_STEP;
+	u32 L1_VLATCH_HIST_LINEAR_SFT;
+	u32 L1_VLATCH_HIST_MULT_A_R;
+	u32 L1_VLATCH_HIST_ADD_A_R;
+	u32 L1_VLATCH_HIST_MULT_B_R;
+	u32 L1_VLATCH_HIST_ADD_B_R;
+	u32 L1_VLATCH_HIST_MULT_A_G;
+	u32 L1_VLATCH_HIST_ADD_A_G;
+	u32 L1_VLATCH_HIST_MULT_B_G;
+	u32 L1_VLATCH_HIST_ADD_B_G;
+	u32 L1_VLATCH_HIST_MULT_A_B;
+	u32 L1_VLATCH_HIST_ADD_A_B;
+	u32 L1_VLATCH_HIST_MULT_B_B;
+	u32 L1_VLATCH_HIST_ADD_B_B;
+	u32 L1_VLATCH_HIST_MULT_A_Y;
+	u32 L1_VLATCH_HIST_ADD_A_Y;
+	u32 L1_VLATCH_HIST_MULT_B_Y;
+	u32 L1_VLATCH_HIST_ADD_B_Y;
+	u32 RESERVED_B_39[265];
+};
+
+/**
+ * struct hwd_viif_l2isp_stadr_buf_reg - Registers for L2ISP control
+ */
+struct hwd_viif_l2isp_stadr_buf_reg {
+	u32 L2_POST_OUT_STADR_B_BUF;
+	u32 L2_POST_OUT_STADR_G_BUF;
+	u32 L2_POST_OUT_STADR_R_BUF;
+};
+
+struct hwd_viif_l2isp_roi_reg {
+	u32 L2_ROI_SCALE;
+	u32 L2_ROI_SCALE_INV;
+	u32 L2_ROI_CORRECTED_HSIZE;
+	u32 L2_ROI_CORRECTED_VSIZE;
+	u32 L2_ROI_OUT_OFS_H;
+	u32 L2_ROI_OUT_OFS_V;
+	u32 L2_ROI_OUT_HSIZE;
+	u32 L2_ROI_OUT_VSIZE;
+};
+
+struct hwd_viif_l2isp_post_reg {
+	u32 L2_POST_CAP_OFFSET;
+	u32 L2_POST_CAP_SIZE;
+	u32 L2_POST_HALF_SCALE_EN;
+	u32 RESERVED_B_47[17];
+	u32 L2_POST_GAMMA_M;
+	u32 RESERVED_B_48[3];
+	u32 L2_POST_C_SELECT;
+	u32 RESERVED_B_49[3];
+	struct hwd_viif_csc_reg csc;
+	u32 L2_POST_OPORTALP;
+	u32 L2_POST_OPORTFMT;
+	u32 L2_POST_OUT_STADR_B;
+	u32 L2_POST_OUT_STADR_G;
+	u32 L2_POST_OUT_STADR_R;
+	u32 L2_POST_OUT_PITCH_B;
+	u32 L2_POST_OUT_PITCH_G;
+	u32 L2_POST_OUT_PITCH_R;
+	u32 L2_POST_DUMMY_READ_EN;
+	u32 RESERVED_B_51[11];
+};
+
+struct hwd_viif_l2isp_reg {
+	u32 L2_SENSOR_CROP_OFS_H;
+	u32 L2_SENSOR_CROP_OFS_V;
+	u32 L2_SENSOR_CROP_HSIZE;
+	u32 L2_SENSOR_CROP_VSIZE;
+	u32 RESERVED_A_475;
+	u32 L2_L2_STATUS;
+	u32 L2_BUS_L2_STATUS;
+	/* [0]: POST0, [1]: POST1 */
+	struct hwd_viif_l2isp_stadr_buf_reg stadr_buf[2];
+	u32 RESERVED_B_40[3];
+	u32 L2_ROI_NUM;
+	/* [0]: POST0, [1]: POST1 */
+	u32 L2_ROI_TO_POST[2];
+	u32 RESERVED_B_41;
+	/* [0]: ROI0, [1]: ROI1 */
+	struct hwd_viif_l2isp_roi_reg roi[2];
+	u32 RESERVED_B_42[8];
+	u32 L2_VALID_R_NORM2_POLY;
+	u32 L2_VALID_R_NORM2_GRID;
+	u32 RESERVED_A_476;
+	u32 RESERVED_B_43[17];
+	u32 L2_MODE;
+	u32 L2_NORM_SCALE;
+	u32 RESERVED_B_44;
+	/* [0]: ROI0, [1]: ROI1 */
+	u32 L2_ROI_WRITE_AREA_DELTA[2];
+	u32 RESERVED_B_45;
+	u32 L2_GRID_NODE_NUM_H;
+	u32 L2_GRID_NODE_NUM_V;
+	u32 L2_GRID_PATCH_HSIZE_INV;
+	u32 L2_GRID_PATCH_VSIZE_INV;
+	u32 L2_POLY10_WRITE_G_COEF[11];
+	u32 L2_POLY10_READ_B_COEF[11];
+	u32 L2_POLY10_READ_G_COEF[11];
+	u32 L2_POLY10_READ_R_COEF[11];
+	u32 RESERVED_B_46[10];
+	/* [0]: POST0, [1]: POST1 */
+	struct hwd_viif_l2isp_post_reg post[2];
+	u32 RESERVED_B_56[192];
+	u32 L2_CRGBF_ACC_CONF;
+	u32 L2_CRGBF_TRN_M_RUN;
+	u32 L2_CRGBF_TRN_M_CONF;
+	u32 L2_CRGBF_TRN_A_CONF;
+	u32 L2_CRGBF_TRN_STAT_CLR;
+	u32 L2_CRGBF_TRN_STAT;
+	u32 L2_CRGBF_INT_STAT;
+	u32 L2_CRGBF_INT_MASK;
+	u32 L2_CRGBF_INT_MASKED_STAT;
+	u32 L2_CRGBF_TRN_WBADDR;
+	u32 L2_CRGBF_TRN_WEADDR;
+	u32 L2_CRGBF_TRN_RBADDR;
+	u32 L2_CRGBF_TRN_READDR;
+	u32 L2_CRGBF_ISP_INT;
+	u32 L2_CRGBF_ISP_INT_MASK;
+	u32 L2_CRGBF_ISP_INT_MASKED_STAT;
+	u32 RESERVED_A_477;
+	u32 RESERVED_B_57[47];
+	u32 L2_SENSOR_CROP_OFS_H_BUF;
+	u32 L2_SENSOR_CROP_OFS_V_BUF;
+	u32 L2_SENSOR_CROP_HSIZE_BUF;
+	u32 L2_SENSOR_CROP_VSIZE_BUF;
+	u32 RESERVED_A_478;
+	u32 RESERVED_B_58[11];
+	u32 L2_ROI_NUM_BUF;
+	u32 L2_ROI_TO_POST0_BUF;
+	u32 L2_ROI_TO_POST1_BUF;
+	u32 RESERVED_B_59;
+	u32 L2_ROI0_SCALE_BUF;
+	u32 L2_ROI0_SCALE_INV_BUF;
+	u32 L2_ROI0_CORRECTED_HSIZE_BUF;
+	u32 L2_ROI0_CORRECTED_VSIZE_BUF;
+	u32 L2_ROI0_OUT_OFS_H_BUF;
+	u32 L2_ROI0_OUT_OFS_V_BUF;
+	u32 L2_ROI0_OUT_HSIZE_BUF;
+	u32 L2_ROI0_OUT_VSIZE_BUF;
+	u32 L2_ROI1_SCALE_BUF;
+	u32 L2_ROI1_SCALE_INV_BUF;
+	u32 L2_ROI1_CORRECTED_HSIZE_BUF;
+	u32 L2_ROI1_CORRECTED_VSIZE_BUF;
+	u32 L2_ROI1_OUT_OFS_H_BUF;
+	u32 L2_ROI1_OUT_OFS_V_BUF;
+	u32 L2_ROI1_OUT_HSIZE_BUF;
+	u32 L2_ROI1_OUT_VSIZE_BUF;
+	u32 RESERVED_B_60[8];
+	u32 L2_VALID_R_NORM2_POLY_BUF;
+	u32 L2_VALID_R_NORM2_GRID_BUF;
+	u32 RESERVED_A_479;
+	u32 RESERVED_B_61[17];
+	u32 L2_MODE_BUF;
+	u32 L2_NORM_SCALE_BUF;
+	u32 RESERVED_B_62;
+	u32 L2_ROI0_WRITE_AREA_DELTA_BUF;
+	u32 L2_ROI1_WRITE_AREA_DELTA_BUF;
+	u32 RESERVED_B_63;
+	u32 L2_GRID_NODE_NUM_H_BUF;
+	u32 L2_GRID_NODE_NUM_V_BUF;
+	u32 L2_GRID_PATCH_HSIZE_INV_BUF;
+	u32 L2_GRID_PATCH_VSIZE_INV_BUF;
+	u32 L2_POLY10_WRITE_G_COEF00_BUF;
+	u32 L2_POLY10_WRITE_G_COEF01_BUF;
+	u32 L2_POLY10_WRITE_G_COEF02_BUF;
+	u32 L2_POLY10_WRITE_G_COEF03_BUF;
+	u32 L2_POLY10_WRITE_G_COEF04_BUF;
+	u32 L2_POLY10_WRITE_G_COEF05_BUF;
+	u32 L2_POLY10_WRITE_G_COEF06_BUF;
+	u32 L2_POLY10_WRITE_G_COEF07_BUF;
+	u32 L2_POLY10_WRITE_G_COEF08_BUF;
+	u32 L2_POLY10_WRITE_G_COEF09_BUF;
+	u32 L2_POLY10_WRITE_G_COEF10_BUF;
+	u32 L2_POLY10_READ_B_COEF00_BUF;
+	u32 L2_POLY10_READ_B_COEF01_BUF;
+	u32 L2_POLY10_READ_B_COEF02_BUF;
+	u32 L2_POLY10_READ_B_COEF03_BUF;
+	u32 L2_POLY10_READ_B_COEF04_BUF;
+	u32 L2_POLY10_READ_B_COEF05_BUF;
+	u32 L2_POLY10_READ_B_COEF06_BUF;
+	u32 L2_POLY10_READ_B_COEF07_BUF;
+	u32 L2_POLY10_READ_B_COEF08_BUF;
+	u32 L2_POLY10_READ_B_COEF09_BUF;
+	u32 L2_POLY10_READ_B_COEF10_BUF;
+	u32 L2_POLY10_READ_G_COEF00_BUF;
+	u32 L2_POLY10_READ_G_COEF01_BUF;
+	u32 L2_POLY10_READ_G_COEF02_BUF;
+	u32 L2_POLY10_READ_G_COEF03_BUF;
+	u32 L2_POLY10_READ_G_COEF04_BUF;
+	u32 L2_POLY10_READ_G_COEF05_BUF;
+	u32 L2_POLY10_READ_G_COEF06_BUF;
+	u32 L2_POLY10_READ_G_COEF07_BUF;
+	u32 L2_POLY10_READ_G_COEF08_BUF;
+	u32 L2_POLY10_READ_G_COEF09_BUF;
+	u32 L2_POLY10_READ_G_COEF10_BUF;
+	u32 L2_POLY10_READ_R_COEF00_BUF;
+	u32 L2_POLY10_READ_R_COEF01_BUF;
+	u32 L2_POLY10_READ_R_COEF02_BUF;
+	u32 L2_POLY10_READ_R_COEF03_BUF;
+	u32 L2_POLY10_READ_R_COEF04_BUF;
+	u32 L2_POLY10_READ_R_COEF05_BUF;
+	u32 L2_POLY10_READ_R_COEF06_BUF;
+	u32 L2_POLY10_READ_R_COEF07_BUF;
+	u32 L2_POLY10_READ_R_COEF08_BUF;
+	u32 L2_POLY10_READ_R_COEF09_BUF;
+	u32 L2_POLY10_READ_R_COEF10_BUF;
+	u32 RESERVED_B_64[10];
+	u32 L2_POST0_CAP_OFFSET_BUF;
+	u32 L2_POST0_CAP_SIZE_BUF;
+	u32 L2_POST0_HALF_SCALE_EN_BUF;
+	u32 RESERVED_B_65[17];
+	u32 L2_POST0_GAMMA_M_BUF;
+	u32 RESERVED_B_66[3];
+	u32 L2_POST0_C_SELECT_BUF;
+	u32 RESERVED_B_67[3];
+	u32 L2_POST0_MTB_BUF;
+	u32 RESERVED_B_68[3];
+	u32 L2_POST0_MTB_YG_OFFSETI_BUF;
+	u32 L2_POST0_MTB_YG1_BUF;
+	u32 L2_POST0_MTB_YG2_BUF;
+	u32 L2_POST0_MTB_YG_OFFSETO_BUF;
+	u32 L2_POST0_MTB_CB_OFFSETI_BUF;
+	u32 L2_POST0_MTB_CB1_BUF;
+	u32 L2_POST0_MTB_CB2_BUF;
+	u32 L2_POST0_MTB_CB_OFFSETO_BUF;
+	u32 L2_POST0_MTB_CR_OFFSETI_BUF;
+	u32 L2_POST0_MTB_CR1_BUF;
+	u32 L2_POST0_MTB_CR2_BUF;
+	u32 L2_POST0_MTB_CR_OFFSETO_BUF;
+	u32 L2_POST0_OPORTALP_BUF;
+	u32 L2_POST0_OPORTFMT_BUF;
+	u32 RESERVED_B_69[3];
+	u32 L2_POST0_OUT_PITCH_B_BUF;
+	u32 L2_POST0_OUT_PITCH_G_BUF;
+	u32 L2_POST0_OUT_PITCH_R_BUF;
+	u32 L2_POST0_DUMMY_READ_EN_BUF;
+	u32 RESERVED_B_70[11];
+	u32 L2_POST1_CAP_OFFSET_BUF;
+	u32 L2_POST1_CAP_SIZE_BUF;
+	u32 L2_POST1_HALF_SCALE_EN_BUF;
+	u32 RESERVED_B_71[17];
+	u32 L2_POST1_GAMMA_M_BUF;
+	u32 RESERVED_B_72[3];
+	u32 L2_POST1_C_SELECT_BUF;
+	u32 RESERVED_B_73[3];
+	u32 L2_POST1_MTB_BUF;
+	u32 RESERVED_B_74[3];
+	u32 L2_POST1_MTB_YG_OFFSETI_BUF;
+	u32 L2_POST1_MTB_YG1_BUF;
+	u32 L2_POST1_MTB_YG2_BUF;
+	u32 L2_POST1_MTB_YG_OFFSETO_BUF;
+	u32 L2_POST1_MTB_CB_OFFSETI_BUF;
+	u32 L2_POST1_MTB_CB1_BUF;
+	u32 L2_POST1_MTB_CB2_BUF;
+	u32 L2_POST1_MTB_CB_OFFSETO_BUF;
+	u32 L2_POST1_MTB_CR_OFFSETI_BUF;
+	u32 L2_POST1_MTB_CR1_BUF;
+	u32 L2_POST1_MTB_CR2_BUF;
+	u32 L2_POST1_MTB_CR_OFFSETO_BUF;
+	u32 L2_POST1_OPORTALP_BUF;
+	u32 L2_POST1_OPORTFMT_BUF;
+	u32 RESERVED_B_75[3];
+	u32 L2_POST1_OUT_PITCH_B_BUF;
+	u32 L2_POST1_OUT_PITCH_G_BUF;
+	u32 L2_POST1_OUT_PITCH_R_BUF;
+	u32 L2_POST1_DUMMY_READ_EN_BUF;
+	u32 RESERVED_B_76[64];
+};
+
+/**
+ * struct hwd_viif_capture_reg - Registers for VIIF CAPTURE control
+ */
+struct hwd_viif_capture_reg {
+	struct hwd_viif_system_reg sys;
+	struct hwd_viif_vdm_reg vdm;
+	struct hwd_viif_l1isp_reg l1isp;
+	struct hwd_viif_l2isp_reg l2isp;
+};
+
+#endif /* HWD_VIIF_REG_H */
diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
new file mode 100644
index 00000000000..f92278425b7
--- /dev/null
+++ b/include/uapi/linux/visconti_viif.h
@@ -0,0 +1,1724 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef __UAPI_VISCONTI_VIIF_H_
+#define __UAPI_VISCONTI_VIIF_H_
+
+#include <linux/types.h>
+#include <linux/videodev2.h>
+
+/* Visconti specific compound controls */
+#define V4L2_CID_VISCONTI_VIIF_BASE			       (V4L2_CID_USER_BASE + 0x1000)
+#define V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 1)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 2)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF	       (V4L2_CID_VISCONTI_VIIF_BASE + 3)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 4)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG		       (V4L2_CID_VISCONTI_VIIF_BASE + 5)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE		       (V4L2_CID_VISCONTI_VIIF_BASE + 6)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION       (V4L2_CID_VISCONTI_VIIF_BASE + 7)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC		       (V4L2_CID_VISCONTI_VIIF_BASE + 8)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE (V4L2_CID_VISCONTI_VIIF_BASE + 9)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION                                \
+	(V4L2_CID_VISCONTI_VIIF_BASE + 10)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS			 (V4L2_CID_VISCONTI_VIIF_BASE + 11)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION (V4L2_CID_VISCONTI_VIIF_BASE + 12)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC			 (V4L2_CID_VISCONTI_VIIF_BASE + 13)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS		 (V4L2_CID_VISCONTI_VIIF_BASE + 14)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB			 (V4L2_CID_VISCONTI_VIIF_BASE + 15)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN		 (V4L2_CID_VISCONTI_VIIF_BASE + 16)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC			 (V4L2_CID_VISCONTI_VIIF_BASE + 17)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM		 (V4L2_CID_VISCONTI_VIIF_BASE + 18)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA			 (V4L2_CID_VISCONTI_VIIF_BASE + 19)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT (V4L2_CID_VISCONTI_VIIF_BASE + 20)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION	 (V4L2_CID_VISCONTI_VIIF_BASE + 21)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST		 (V4L2_CID_VISCONTI_VIIF_BASE + 22)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI			 (V4L2_CID_VISCONTI_VIIF_BASE + 23)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA			 (V4L2_CID_VISCONTI_VIIF_BASE + 24)
+#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS	 (V4L2_CID_VISCONTI_VIIF_BASE + 25)
+#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS		 (V4L2_CID_VISCONTI_VIIF_BASE + 26)
+#define V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS		 (V4L2_CID_VISCONTI_VIIF_BASE + 27)
+#define V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS		 (V4L2_CID_VISCONTI_VIIF_BASE + 28)
+
+/* Enable/Disable flag */
+#define VIIF_DISABLE (0U)
+#define VIIF_ENABLE  (1U)
+
+/**
+ * enum viif_rawpack_mode - RAW pack mode for ioctl(VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE)
+ *
+ * @VIIF_RAWPACK_DISABLE: RAW pack disable
+ * @VIIF_RAWPACK_MSBFIRST: RAW pack enable (MSB First)
+ * @VIIF_RAWPACK_LSBFIRST: RAW pack enable (LSB First)
+ */
+enum viif_rawpack_mode {
+	VIIF_RAWPACK_DISABLE = 0,
+	VIIF_RAWPACK_MSBFIRST = 2,
+	VIIF_RAWPACK_LSBFIRST = 3,
+};
+
+/**
+ * enum viif_l1_input - L1ISP preprocessing mode
+ *
+ * @VIIF_L1_INPUT_HDR: bypass(HDR input)
+ * @VIIF_L1_INPUT_PWL: HDRE(PWL input)
+ * @VIIF_L1_INPUT_HDR_IMG_CORRECT: SLIC-ABPC-PWHB-RCNR-HDRS
+ * @VIIF_L1_INPUT_PWL_IMG_CORRECT: HDRE-SLIC-ABPC-PWHB-RCNR-HDRS
+ */
+enum viif_l1_input {
+	VIIF_L1_INPUT_HDR = 0,
+	VIIF_L1_INPUT_PWL = 1,
+	VIIF_L1_INPUT_HDR_IMG_CORRECT = 3,
+	VIIF_L1_INPUT_PWL_IMG_CORRECT = 4,
+};
+
+/**
+ * enum viif_l1_raw - L1ISP RAW color filter mode
+ *
+ * @VIIF_L1_RAW_GR_R_B_GB: Gr-R-B-Gb
+ * @VIIF_L1_RAW_R_GR_GB_B: R-Gr-Gb-B
+ * @VIIF_L1_RAW_B_GB_GR_R: B-Gb-Gr-R
+ * @VIIF_L1_RAW_GB_B_R_GR: Gb-B-R-Gr
+ */
+enum viif_l1_raw {
+	VIIF_L1_RAW_GR_R_B_GB = 0,
+	VIIF_L1_RAW_R_GR_GB_B = 1,
+	VIIF_L1_RAW_B_GB_GR_R = 2,
+	VIIF_L1_RAW_GB_B_R_GR = 3,
+};
+
+/**
+ * struct viif_l1_input_mode_config - L1ISP INPUT MODE parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`
+ * @mode: &enum viif_l1_input value.
+ * @depth: Color depth (even only). Range for each L1ISP pre-processing mode is:
+ *
+ *  * VIIF_L1_INPUT_HDR/HDR_IMG_CORRECT: Range: [8..24].
+ *  * VIIF_L1_INPUT_PWL/PWL_IMG_CORRECT: Range: [8..14].
+ * @raw_color_filter: &enum viif_l1_raw value.
+ */
+struct viif_l1_input_mode_config {
+	__u32 mode;
+	__u32 depth;
+	__u32 raw_color_filter;
+};
+
+/**
+ * struct viif_l1_rgb_to_y_coef_config - L1ISP coefficient for calculating
+ * Y from RGB parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF`
+ * @coef_r: R co-efficient [256..65024] accuracy: 1/65536
+ * @coef_g: R co-efficient [256..65024] accuracy: 1/65536
+ * @coef_b: R co-efficient [256..65024] accuracy: 1/65536
+ */
+struct viif_l1_rgb_to_y_coef_config {
+	__u16 coef_r;
+	__u16 coef_g;
+	__u16 coef_b;
+};
+
+/**
+ * enum viif_l1_img_sensitivity_mode - L1ISP image sensitivity
+ *
+ * @VIIF_L1_IMG_SENSITIVITY_HIGH: high sensitivity
+ * @VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED: middle sensitivity or led
+ * @VIIF_L1_IMG_SENSITIVITY_LOW: low sensitivity
+ */
+enum viif_l1_img_sensitivity_mode {
+	VIIF_L1_IMG_SENSITIVITY_HIGH = 0,
+	VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED = 1,
+	VIIF_L1_IMG_SENSITIVITY_LOW = 2,
+};
+
+/**
+ * struct viif_l1_ag_mode_config - L1ISP AG mode parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE`
+ * @sysm_ag_grad: Analog gain slope [0..255] (element is id)
+ * @sysm_ag_ofst: Analog gain offset [0..65535] (element is id)
+ * @sysm_ag_cont_hobc_en_high: 1:enable/0:disable to control analog gain
+ *                             for high sensitivity image of OBCC
+ * @sysm_ag_psel_hobc_high: Analog gain id for high sensitivity image of OBCC [0..3]
+ * @sysm_ag_cont_hobc_en_middle_led: 1:enable/0:disable to control analog gain
+ *                                   for middle sensitivity or LED image of OBCC
+ * @sysm_ag_psel_hobc_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of OBCC [0..3]
+ * @sysm_ag_cont_hobc_en_low: 1:enable/0:disable to control analog gain
+ *                            for low sensitivity image of OBCC
+ * @sysm_ag_psel_hobc_low: Analog gain id for low sensitivity image of OBCC [0..3]
+ * @sysm_ag_cont_abpc_en_high: 1:enable/0:disable to control analog gain
+ *                             for high sensitivity image of ABPC
+ * @sysm_ag_psel_abpc_high: Analog gain id for high sensitivity image of ABPC [0..3]
+ * @sysm_ag_cont_abpc_en_middle_led: 1:enable/0:disable to control analog gain
+ *                                   for middle sensitivity or LED image of ABPC
+ * @sysm_ag_psel_abpc_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of ABPC [0..3]
+ * @sysm_ag_cont_abpc_en_low: 1:enable/0:disable to control analog gain
+ *                            for low sensitivity image of ABPC
+ * @sysm_ag_psel_abpc_low: Analog gain id for low sensitivity image of ABPC [0..3]
+ * @sysm_ag_cont_rcnr_en_high: 1:enable/0:disable to control analog gain
+ *                             for high sensitivity image of RCNR
+ * @sysm_ag_psel_rcnr_high: Analog gain id for high sensitivity image of RCNR [0..3]
+ * @sysm_ag_cont_rcnr_en_middle_led: 1:enable/0:disable to control analog gain
+ *                                   for middle sensitivity or LED image of RCNR
+ * @sysm_ag_psel_rcnr_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of RCNR [0..3]
+ * @sysm_ag_cont_rcnr_en_low: 1:enable/0:disable to control analog gain
+ *                            for low sensitivity image of RCNR
+ * @sysm_ag_psel_rcnr_low: Analog gain id for low sensitivity image of RCNR [0..3]
+ * @sysm_ag_cont_lssc_en: 1:enable/0:disable to control analog gain for LSC
+ * @sysm_ag_ssel_lssc: &enum viif_l1_img_sensitivity_mode value. Sensitive image used for LSC.
+ * @sysm_ag_psel_lssc: Analog gain id for LSC [0..3]
+ * @sysm_ag_cont_mpro_en: 1:enable/0:disable to control analog gain for color matrix
+ * @sysm_ag_ssel_mpro: &enum viif_l1_img_sensitivity_mode value.
+ *                     Sensitive image used for color matrix.
+ * @sysm_ag_psel_mpro:Aanalog gain id for color matrix [0..3]
+ * @sysm_ag_cont_vpro_en: 1:enable/0:disable to control analog gain for image adjustment
+ * @sysm_ag_ssel_vpro: &enum viif_l1_img_sensitivity_mode value.
+ *                     Sensitive image used for image adjustment.
+ * @sysm_ag_psel_vpro: Analog gain id for image adjustment [0..3]
+ * @sysm_ag_cont_hobc_test_high: Manual analog gain for high sensitivity image
+ *                               of OBCC [0..255]
+ * @sysm_ag_cont_hobc_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of OBCC [0..255]
+ * @sysm_ag_cont_hobc_test_low: Manual analog gain for low sensitivity image
+ *                              of OBCC [0..255]
+ * @sysm_ag_cont_abpc_test_high: Manual analog gain for high sensitivity image
+ *                               of ABPC [0..255]
+ * @sysm_ag_cont_abpc_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of ABPC [0..255]
+ * @sysm_ag_cont_abpc_test_low: Manual analog gain for low sensitivity image
+ *                              of ABPC [0..255]
+ * @sysm_ag_cont_rcnr_test_high: Manual analog gain for high sensitivity image
+ *                               of RCNR [0..255]
+ * @sysm_ag_cont_rcnr_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of RCNR [0..255]
+ * @sysm_ag_cont_rcnr_test_low: Manual analog gain for low sensitivity image
+ *                              of RCNR [0..255]
+ * @sysm_ag_cont_lssc_test: Manual analog gain for LSSC [0..255]
+ * @sysm_ag_cont_mpro_test: Manual analog gain for color matrix [0..255]
+ * @sysm_ag_cont_vpro_test: Manual analog gain for image adjustment [0..255]
+ *
+ * Operation setting of L1ISP analog gain function.
+ * Analog gain control is disabled if following settings are done.
+ * "sysm_ag_cont_*_en = DRV_VIIF_DISABLE" and "sysm_ag_cont_*_test = 0"
+ * In case "VIIF_L1_INPUT_HDR" or "VIIF_L1_INPUT_PWL" is set to "mode" which is
+ * an &struct viif_l1_input_mode_config, analog gain control needs to be disabled.
+ * Even if this condition is not satisfied, this driver doesn't return error.
+ *
+ * The value set in sysm_ag_psel_xxx indicates analog gain system to be used and
+ * corresponds to the element number of sysm_ag_grad and sysm_ag_ofst.
+ * For example, if sysm_ag_psel_hobc_high is set to 2, then values set in
+ * sysm_ag_grad[2] and sysm_ag_ofst[2] are used for high sensitivity images
+ * in OBCC processing.
+ */
+struct viif_l1_ag_mode_config {
+	__u8 sysm_ag_grad[4];
+	__u16 sysm_ag_ofst[4];
+	__u32 sysm_ag_cont_hobc_en_high;
+	__u32 sysm_ag_psel_hobc_high;
+	__u32 sysm_ag_cont_hobc_en_middle_led;
+	__u32 sysm_ag_psel_hobc_middle_led;
+	__u32 sysm_ag_cont_hobc_en_low;
+	__u32 sysm_ag_psel_hobc_low;
+	__u32 sysm_ag_cont_abpc_en_high;
+	__u32 sysm_ag_psel_abpc_high;
+	__u32 sysm_ag_cont_abpc_en_middle_led;
+	__u32 sysm_ag_psel_abpc_middle_led;
+	__u32 sysm_ag_cont_abpc_en_low;
+	__u32 sysm_ag_psel_abpc_low;
+	__u32 sysm_ag_cont_rcnr_en_high;
+	__u32 sysm_ag_psel_rcnr_high;
+	__u32 sysm_ag_cont_rcnr_en_middle_led;
+	__u32 sysm_ag_psel_rcnr_middle_led;
+	__u32 sysm_ag_cont_rcnr_en_low;
+	__u32 sysm_ag_psel_rcnr_low;
+	__u32 sysm_ag_cont_lssc_en;
+	__u32 sysm_ag_ssel_lssc;
+	__u32 sysm_ag_psel_lssc;
+	__u32 sysm_ag_cont_mpro_en;
+	__u32 sysm_ag_ssel_mpro;
+	__u32 sysm_ag_psel_mpro;
+	__u32 sysm_ag_cont_vpro_en;
+	__u32 sysm_ag_ssel_vpro;
+	__u32 sysm_ag_psel_vpro;
+	__u8 sysm_ag_cont_hobc_test_high;
+	__u8 sysm_ag_cont_hobc_test_middle_led;
+	__u8 sysm_ag_cont_hobc_test_low;
+	__u8 sysm_ag_cont_abpc_test_high;
+	__u8 sysm_ag_cont_abpc_test_middle_led;
+	__u8 sysm_ag_cont_abpc_test_low;
+	__u8 sysm_ag_cont_rcnr_test_high;
+	__u8 sysm_ag_cont_rcnr_test_middle_led;
+	__u8 sysm_ag_cont_rcnr_test_low;
+	__u8 sysm_ag_cont_lssc_test;
+	__u8 sysm_ag_cont_mpro_test;
+	__u8 sysm_ag_cont_vpro_test;
+};
+
+/**
+ * struct viif_l1_ag_config - L1ISP AG parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG`
+ * @gain_h: Analog gain for high sensitive image [0..65535]
+ * @gain_m: Analog gain for middle sensitive image or LED image [0..65535]
+ * @gain_l: Analog gain for low sensitive image [0..65535]
+ */
+struct viif_l1_ag_config {
+	__u16 gain_h;
+	__u16 gain_m;
+	__u16 gain_l;
+};
+
+/**
+ * struct viif_l1_hdre_config - L1ISP HDRE parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE`
+ * @hdre_src_point: Knee point N value of PWL compressed signal [0..0x3FFF]
+ * @hdre_dst_base: Offset value of HDR signal in Knee area M [0..0xFFFFFF]
+ * @hdre_ratio: Slope of output pixel value in Knee area M
+ *              [0..0x3FFFFF], accuracy: 1/64
+ * @hdre_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
+ */
+struct viif_l1_hdre_config {
+	__u32 hdre_src_point[16];
+	__u32 hdre_dst_base[17];
+	__u32 hdre_ratio[17];
+	__u32 hdre_dst_max_val;
+};
+
+/**
+ * struct viif_l1_img_extraction_config -  L1ISP image extraction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION`
+ * @input_black_gr: Black level of input pixel (Gr) [0..0xFFFFFF]
+ * @input_black_r: Black level of input pixel (R) [0..0xFFFFFF]
+ * @input_black_b: Black level of input pixel (B) [0..0xFFFFFF]
+ * @input_black_gb: Black level of input pixel (Gb) [0..0xFFFFFF]
+ */
+struct viif_l1_img_extraction_config {
+	__u32 input_black_gr;
+	__u32 input_black_r;
+	__u32 input_black_b;
+	__u32 input_black_gb;
+};
+
+/**
+ * enum viif_l1_dpc_mode - L1ISP defect pixel correction mode
+ * @VIIF_L1_DPC_1PIXEL: 1 pixel correction mode
+ * @VIIF_L1_DPC_2PIXEL: 2 pixel correction mode
+ */
+enum viif_l1_dpc_mode {
+	VIIF_L1_DPC_1PIXEL = 0,
+	VIIF_L1_DPC_2PIXEL = 1,
+};
+
+/**
+ * struct viif_l1_dpc - L1ISP defect pixel correction parameters
+ * for &struct viif_l1_dpc_config
+ * @abpc_sta_en: 1:enable/0:disable setting of Static DPC
+ * @abpc_dyn_en: 1:enable/0:disable setting of Dynamic DPC
+ * @abpc_dyn_mode: &enume viif_l1_dpc_mode value. Sets dynamic DPC mode.
+ * @abpc_ratio_limit: Variation adjustment of dynamic DPC [0..1023]
+ * @abpc_dark_limit: White defect judgment limit of dark area [0..1023]
+ * @abpc_sn_coef_w_ag_min: Luminance difference adjustment of white DPC
+ *                         (undere lower threshold) [1..31]
+ * @abpc_sn_coef_w_ag_mid: Luminance difference adjustment of white DPC
+ *                         (between lower and upper threshold) [1..31]
+ * @abpc_sn_coef_w_ag_max: Luminance difference adjustment of white DPC
+ *                         (over upper threshold) [1..31]
+ * @abpc_sn_coef_b_ag_min: Luminance difference adjustment of black DPC
+ *                         (undere lower threshold) [1..31]
+ * @abpc_sn_coef_b_ag_mid: Luminance difference adjustment of black DPC
+ *                         (between lower and upper threshold) [1..31]
+ * @abpc_sn_coef_b_ag_max: Luminance difference adjustment of black DPC
+ *                         (over upper threshold) [1..31]
+ * @abpc_sn_coef_w_th_min: Luminance difference adjustment of white DPC
+ *                         analog gain lower threshold [0..255]
+ * @abpc_sn_coef_w_th_max: Luminance difference adjustment of white DPC
+ *                         analog gain upper threshold [0..255]
+ * @abpc_sn_coef_b_th_min: Luminance difference adjustment of black DPC
+ *                         analog gain lower threshold [0..255]
+ * @abpc_sn_coef_b_th_max: Luminance difference adjustment of black DPC
+ *                         analog gain upper threshold [0..255]
+ *
+ * Parameters should meet the following conditions.
+ * "abpc_sn_coef_w_th_min < abpc_sn_coef_w_th_max" and
+ * "abpc_sn_coef_b_th_min < abpc_sn_coef_b_th_max"
+ */
+struct viif_l1_dpc {
+	__u32 abpc_sta_en;
+	__u32 abpc_dyn_en;
+	__u32 abpc_dyn_mode;
+	__u32 abpc_ratio_limit;
+	__u32 abpc_dark_limit;
+	__u32 abpc_sn_coef_w_ag_min;
+	__u32 abpc_sn_coef_w_ag_mid;
+	__u32 abpc_sn_coef_w_ag_max;
+	__u32 abpc_sn_coef_b_ag_min;
+	__u32 abpc_sn_coef_b_ag_mid;
+	__u32 abpc_sn_coef_b_ag_max;
+	__u8 abpc_sn_coef_w_th_min;
+	__u8 abpc_sn_coef_w_th_max;
+	__u8 abpc_sn_coef_b_th_min;
+	__u8 abpc_sn_coef_b_th_max;
+};
+
+/**
+ * struct viif_l1_dpc_config - L1ISP defect pixel correction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC`
+ * @param_h: DPC parameter for high sensitive image. Refer to &struct viif_l1_dpc
+ * @param_m: DPC parameter for middle sensitive image. Refer to &struct viif_l1_dpc
+ * @param_l: DPC parameter for low sensitive image. Refer to &struct viif_l1_dpc
+ * @table_h_addr: DPC table address for high sensitive image.
+ *                The table size is sizeof(u32) * 2048.
+ *                Set zero to disable this table.
+ * @table_m_addr: DPC table address for middle sensitive image or LED image.
+ *                The table size is sizeof(u32) * 2048.
+ *                Set zero to disable this table.
+ * @table_l_addr: DPC table address for low sensitive image.
+ *                The table size is sizeof(u32) * 2048.
+ *                Set zero to disable this table.
+ *
+ * The size of each table is fixed at 8192 Byte.
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the DPC table.
+ */
+struct viif_l1_dpc_config {
+	struct viif_l1_dpc param_h;
+	struct viif_l1_dpc param_m;
+	struct viif_l1_dpc param_l;
+	__u64 table_h_addr;
+	__u64 table_m_addr;
+	__u64 table_l_addr;
+};
+
+/**
+ * struct viif_l1_preset_wb - L1ISP  preset white balance parameters
+ * for &struct viif_l1_preset_white_balance_config
+ * @gain_gr: Gr gain [0..524287], accuracy 1/16384
+ * @gain_r: R gain [0..524287], accuracy 1/16384
+ * @gain_b: B gain [0..524287], accuracy 1/16384
+ * @gain_gb: Gb gain [0..524287], accuracy 1/16384
+ */
+struct viif_l1_preset_wb {
+	__u32 gain_gr;
+	__u32 gain_r;
+	__u32 gain_b;
+	__u32 gain_gb;
+};
+
+/**
+ * struct viif_l1_preset_white_balance_config - L1ISP  preset white balance
+ * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE`
+ * @dstmaxval: Maximum value of output pixel [pixel] [0..4095]
+ * @param_h: Preset white balance parameter for high sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_m: Preset white balance parameters for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_l: Preset white balance parameters for low sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ */
+struct viif_l1_preset_white_balance_config {
+	__u32 dstmaxval;
+	struct viif_l1_preset_wb param_h;
+	struct viif_l1_preset_wb param_m;
+	struct viif_l1_preset_wb param_l;
+};
+
+/**
+ * enum viif_l1_rcnr_type - L1ISP high resolution luminance filter type
+ *
+ * @VIIF_L1_RCNR_LOW_RESOLUTION: low resolution
+ * @VIIF_L1_RCNR_MIDDLE_RESOLUTION: middle resolution
+ * @VIIF_L1_RCNR_HIGH_RESOLUTION: high resolution
+ * @VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION: ultra high resolution
+ */
+enum viif_l1_rcnr_type {
+	VIIF_L1_RCNR_LOW_RESOLUTION = 0,
+	VIIF_L1_RCNR_MIDDLE_RESOLUTION = 1,
+	VIIF_L1_RCNR_HIGH_RESOLUTION = 2,
+	VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION = 3,
+};
+
+/**
+ * enum viif_l1_msf_blend_ratio - L1ISP MSF blend ratio
+ *
+ * @VIIF_L1_MSF_BLEND_RATIO_0_DIV_64: 0/64
+ * @VIIF_L1_MSF_BLEND_RATIO_1_DIV_64: 1/64
+ * @VIIF_L1_MSF_BLEND_RATIO_2_DIV_64: 2/64
+ */
+enum viif_l1_msf_blend_ratio {
+	VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 = 0,
+	VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 = 1,
+	VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 = 2,
+};
+
+/**
+ * struct viif_l1_raw_color_noise_reduction - L1ISP RCNR parameters
+ * for &struct viif_l1_raw_color_noise_reduction_config
+ * @rcnr_sw: 1:Enable/0:Disable setting of RAW color noise reduction
+ * @rcnr_cnf_dark_ag0: Maximum value of LSF dark noise adjustment[0..63]
+ * @rcnr_cnf_dark_ag1: Middle value of LSF dark noise adjustment [0..63]
+ * @rcnr_cnf_dark_ag2: Minimum value of LSF dark noise adjustment [0..63]
+ * @rcnr_cnf_ratio_ag0: Maximum value of LSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_cnf_ratio_ag1: Middle value of LSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_cnf_ratio_ag2: Minimum value of LSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_cnf_clip_gain_r: LSF color correction limit adjustment gain R [0..3]
+ * @rcnr_cnf_clip_gain_g: LSF color correction limit adjustment gain G [0..3]
+ * @rcnr_cnf_clip_gain_b: LSF color correction limit adjustment gain B [0..3]
+ * @rcnr_a1l_dark_ag0: Maximum value of MSF dark noise adjustment [0..63]
+ * @rcnr_a1l_dark_ag1: Middle value of MSF dark noise adjustment [0..63]
+ * @rcnr_a1l_dark_ag2: Minimum value of MSF dark noise adjustment [0..63]
+ * @rcnr_a1l_ratio_ag0: Maximum value of MSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_a1l_ratio_ag1: Middle value of MSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_a1l_ratio_ag2: Minimum value of MSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_inf_zero_clip: Input stage zero clip setting [0..256]
+ * @rcnr_merge_d2blend_ag0: Maximum value of filter results and input blend ratio [0..16]
+ * @rcnr_merge_d2blend_ag1: Middle value of filter results and input blend ratio [0..16]
+ * @rcnr_merge_d2blend_ag2: Minimum value of filter results and input blend ratio [0..16]
+ * @rcnr_merge_black: Black level minimum value [0..64]
+ * @rcnr_merge_mindiv: 0 div guard value of inverse arithmetic unit [4..16]
+ * @rcnr_hry_type: &enum viif_l1_rcnr_type value. Filter type for HSF filter process.
+ * @rcnr_anf_blend_ag0: &enum viif_l1_msf_blend_ratio value.
+ *                      Maximum value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_anf_blend_ag1: &enum viif_l1_msf_blend_ratio value.
+ *                      Middle value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_anf_blend_ag2: &enum viif_l1_msf_blend_ratio value.
+ *                      Minimum value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_lpf_threshold: Multiplier value for calculating dark noise / luminance
+ *                      interlock noise of MSF [0..31], accuracy: 1/8
+ * @rcnr_merge_hlblend_ag0: Maximum value of luminance signal generation blend [0..2]
+ * @rcnr_merge_hlblend_ag1: Middle value of luminance signal generation blend [0..2]
+ * @rcnr_merge_hlblend_ag2: Minimum value of luminance signal generation blend [0..2]
+ * @rcnr_gnr_sw: 1:Enable/0:Disable setting of Gr/Gb sensitivity ratio
+ *               correction function switching
+ * @rcnr_gnr_ratio: Upper limit of Gr/Gb sensitivity ratio correction factor [0..15]
+ * @rcnr_gnr_wide_en: 1:Enable/0:Disable setting of the function to double
+ *                    correction upper limit ratio of rcnr_gnr_ratio
+ */
+struct viif_l1_raw_color_noise_reduction {
+	__u32 rcnr_sw;
+	__u32 rcnr_cnf_dark_ag0;
+	__u32 rcnr_cnf_dark_ag1;
+	__u32 rcnr_cnf_dark_ag2;
+	__u32 rcnr_cnf_ratio_ag0;
+	__u32 rcnr_cnf_ratio_ag1;
+	__u32 rcnr_cnf_ratio_ag2;
+	__u32 rcnr_cnf_clip_gain_r;
+	__u32 rcnr_cnf_clip_gain_g;
+	__u32 rcnr_cnf_clip_gain_b;
+	__u32 rcnr_a1l_dark_ag0;
+	__u32 rcnr_a1l_dark_ag1;
+	__u32 rcnr_a1l_dark_ag2;
+	__u32 rcnr_a1l_ratio_ag0;
+	__u32 rcnr_a1l_ratio_ag1;
+	__u32 rcnr_a1l_ratio_ag2;
+	__u32 rcnr_inf_zero_clip;
+	__u32 rcnr_merge_d2blend_ag0;
+	__u32 rcnr_merge_d2blend_ag1;
+	__u32 rcnr_merge_d2blend_ag2;
+	__u32 rcnr_merge_black;
+	__u32 rcnr_merge_mindiv;
+	__u32 rcnr_hry_type;
+	__u32 rcnr_anf_blend_ag0;
+	__u32 rcnr_anf_blend_ag1;
+	__u32 rcnr_anf_blend_ag2;
+	__u32 rcnr_lpf_threshold;
+	__u32 rcnr_merge_hlblend_ag0;
+	__u32 rcnr_merge_hlblend_ag1;
+	__u32 rcnr_merge_hlblend_ag2;
+	__u32 rcnr_gnr_sw;
+	__u32 rcnr_gnr_ratio;
+	__u32 rcnr_gnr_wide_en;
+};
+
+/**
+ * struct viif_l1_raw_color_noise_reduction_config - L1ISP RCNR parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION`
+ * @param_h: RAW color noise reduction parameter for high sensitive image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ * @param_m: RAW color noise reduction parameter for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ * @param_l: RAW color noise reduction parameter for low sensitive image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ */
+struct viif_l1_raw_color_noise_reduction_config {
+	struct viif_l1_raw_color_noise_reduction param_h;
+	struct viif_l1_raw_color_noise_reduction param_m;
+	struct viif_l1_raw_color_noise_reduction param_l;
+};
+
+/**
+ * enum viif_l1_hdrs_middle_img_mode - L1ISP HDR setting
+ *
+ * @VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE: not use middle image
+ * @VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE: use middle image
+ */
+enum viif_l1_hdrs_middle_img_mode {
+	VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE = 0,
+	VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE = 1,
+};
+
+/**
+ * struct viif_l1_hdrs_config - L1ISP HDRS parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS`
+ * @hdrs_hdr_mode: &enum viif_l1_hdrs_middle_img_mode value.
+ *                 Use/No use settings of middle sensitivity image in HDRS.
+ * @hdrs_hdr_ratio_m: Magnification ratio of middle sensitivity image for high
+ *                    sensitivity image [0x400..0x400000] accuracy: 1/1024
+ * @hdrs_hdr_ratio_l: Magnification ratio of low sensitivity image for high
+ *                    sensitivity image [0x400..0x400000], accuracy: 1/1024
+ * @hdrs_hdr_ratio_e: Magnification ratio of LED image for high sensitivity image
+ *                    [0x400..0x400000], accuracy: 1/1024
+ * @hdrs_dg_h: High sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_dg_m: Middle sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_dg_l: Low sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_dg_e: LED image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_blendend_h: Maximum luminance used for blend high sensitivity image [0..4095]
+ * @hdrs_blendend_m: Maximum luminance used for blend middle sensitivity image [0..4095]
+ * @hdrs_blendend_e: Maximum luminance used for blend LED image [0..4095]
+ * @hdrs_blendbeg_h: Minimum luminance used for blend high sensitivity image [0..4095]
+ * @hdrs_blendbeg_m: Minimum luminance used for blend middle sensitivity image [0..4095]
+ * @hdrs_blendbeg_e: Minimum luminance used for blend LED image [0..4095]
+ * @hdrs_led_mode_on: 1:Enable/0:Disable settings of LED mode
+ * @hdrs_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
+ *
+ * parameter error needs to be returned in the below condition.
+ * (hdrs_hdr_mode == VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE) && (hdrs_led_mode_on == 1)
+ */
+struct viif_l1_hdrs_config {
+	__u32 hdrs_hdr_mode;
+	__u32 hdrs_hdr_ratio_m;
+	__u32 hdrs_hdr_ratio_l;
+	__u32 hdrs_hdr_ratio_e;
+	__u32 hdrs_dg_h;
+	__u32 hdrs_dg_m;
+	__u32 hdrs_dg_l;
+	__u32 hdrs_dg_e;
+	__u32 hdrs_blendend_h;
+	__u32 hdrs_blendend_m;
+	__u32 hdrs_blendend_e;
+	__u32 hdrs_blendbeg_h;
+	__u32 hdrs_blendbeg_m;
+	__u32 hdrs_blendbeg_e;
+	__u32 hdrs_led_mode_on;
+	__u32 hdrs_dst_max_val;
+};
+
+/**
+ * struct viif_l1_black_level_correction_config -  L1ISP image level conversion
+ * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION`
+ * @srcblacklevel_gr: Black level of Gr input pixel [pixel] [0..0xFFFFFF]
+ * @srcblacklevel_r: Black level of R input pixel [pixel] [0..0xFFFFFF]
+ * @srcblacklevel_b: Black level of B input pixel [pixel] [0..0xFFFFFF]
+ * @srcblacklevel_gb: Black level of Gb input pixel [pixel] [0..0xFFFFFF]
+ * @mulval_gr: Gr gain [0..0xFFFFF], accuracy: 1/256
+ * @mulval_r: R gain [0..0xFFFFF], accuracy: 1/256
+ * @mulval_b: B gain [0..0xFFFFF], accuracy: 1/256
+ * @mulval_gb: Gb gain [0..0xFFFFF], accuracy: 1/256
+ * @dstmaxval: Maximum value of output pixel [pixel] [0..0xFFFFFF]
+ */
+struct viif_l1_black_level_correction_config {
+	__u32 srcblacklevel_gr;
+	__u32 srcblacklevel_r;
+	__u32 srcblacklevel_b;
+	__u32 srcblacklevel_gb;
+	__u32 mulval_gr;
+	__u32 mulval_r;
+	__u32 mulval_b;
+	__u32 mulval_gb;
+	__u32 dstmaxval;
+};
+
+/**
+ * enum viif_l1_para_coef_gain - L1ISP parabola shading correction coefficient ratio
+ *
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH: 1/8
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH: 1/4
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_SECOND: 1/2
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_FIRST: 1/1
+ */
+enum viif_l1_para_coef_gain {
+	VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH = 0, /* 1/8 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH = 1, /* 1/4 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_SECOND = 2, /* 1/2 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_FIRST = 3, /* 1/1 */
+};
+
+/**
+ * enum viif_l1_grid_coef_gain - L1ISP grid shading correction coefficient ratio
+ *
+ * @VIIF_L1_GRID_COEF_GAIN_X1: x1
+ * @VIIF_L1_GRID_COEF_GAIN_X2: x2
+ */
+enum viif_l1_grid_coef_gain {
+	VIIF_L1_GRID_COEF_GAIN_X1 = 0,
+	VIIF_L1_GRID_COEF_GAIN_X2 = 1,
+};
+
+/**
+ * struct viif_l1_lsc_parabola_ag_param - L2ISP parabola shading parameters
+ * for &struct viif_l1_lsc_parabola_param
+ * @lssc_paracoef_h_l_max: Parabola coefficient left maximum gain value
+ * @lssc_paracoef_h_l_min: Parabola coefficient left minimum gain value
+ * @lssc_paracoef_h_r_max: Parabola coefficient right maximum gain value
+ * @lssc_paracoef_h_r_min: Parabola coefficient right minimum gain value
+ * @lssc_paracoef_v_u_max: Parabola coefficient upper maximum gain value
+ * @lssc_paracoef_v_u_min: Parabola coefficient upper minimum gain value
+ * @lssc_paracoef_v_d_max: Parabola coefficient lower maximum gain value
+ * @lssc_paracoef_v_d_min: Parabola coefficient lower minimum gain value
+ * @lssc_paracoef_hv_lu_max: Parabola coefficient upper left gain maximum value
+ * @lssc_paracoef_hv_lu_min: Parabola coefficient upper left gain minimum value
+ * @lssc_paracoef_hv_ru_max: Parabola coefficient upper right gain maximum value
+ * @lssc_paracoef_hv_ru_min: Parabola coefficient upper right minimum gain value
+ * @lssc_paracoef_hv_ld_max: Parabola coefficient lower left gain maximum value
+ * @lssc_paracoef_hv_ld_min: Parabola coefficient lower left gain minimum value
+ * @lssc_paracoef_hv_rd_max: Parabola coefficient lower right gain maximum value
+ * @lssc_paracoef_hv_rd_min: Parabola coefficient lower right minimum gain value
+ *
+ * The range and accuracy of each coefficient are as
+ * "range: [-4096..4095], accuracy: 1/256 "
+ *
+ * Each coefficient should meet the following conditions.
+ * "lssc_paracoef_xx_xx_min <= lssc_paracoef_xx_xx_max"
+ */
+struct viif_l1_lsc_parabola_ag_param {
+	__s16 lssc_paracoef_h_l_max;
+	__s16 lssc_paracoef_h_l_min;
+	__s16 lssc_paracoef_h_r_max;
+	__s16 lssc_paracoef_h_r_min;
+	__s16 lssc_paracoef_v_u_max;
+	__s16 lssc_paracoef_v_u_min;
+	__s16 lssc_paracoef_v_d_max;
+	__s16 lssc_paracoef_v_d_min;
+	__s16 lssc_paracoef_hv_lu_max;
+	__s16 lssc_paracoef_hv_lu_min;
+	__s16 lssc_paracoef_hv_ru_max;
+	__s16 lssc_paracoef_hv_ru_min;
+	__s16 lssc_paracoef_hv_ld_max;
+	__s16 lssc_paracoef_hv_ld_min;
+	__s16 lssc_paracoef_hv_rd_max;
+	__s16 lssc_paracoef_hv_rd_min;
+};
+
+/**
+ * struct viif_l1_lsc_parabola_param - L2ISP parabola shading parameters
+ * for &struct viif_l1_lsc
+ * @lssc_para_h_center: Horizontal coordinate of central optical axis [pixel]
+ *                      [0..(Input image width - 1)]
+ * @lssc_para_v_center: Vertical coordinate of central optical axis [line]
+ *                      [0..(Input image height - 1)]
+ * @lssc_para_h_gain: Horizontal distance gain with the optical axis
+ *                    [0..4095], accuracy: 1/256
+ * @lssc_para_v_gain: Vertical distance gain with the optical axis
+ *                    [0..4095], accuracy: 1/256
+ * @lssc_para_mgsel2: &enum viif_l1_para_coef_gain value.
+ *                    Parabola 2D correction coefficient gain magnification ratio.
+ * @lssc_para_mgsel4: &enum viif_l1_para_coef_gain value.
+ *                    Parabola 4D correction coefficient gain magnification ratio.
+ * @r_2d: 2D parabola coefficient for R.
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @r_4d: 4D parabola coefficient for R.
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gr_2d: 2D parabola coefficient for Gr
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gr_4d: 4D parabola coefficient for Gr
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gb_2d: 2D parabola coefficient for Gb
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gb_4d: 4D parabola coefficient for Gb
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @b_2d: 2D parabola coefficient for B
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @b_4d: 4D parabola coefficient for B
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ */
+struct viif_l1_lsc_parabola_param {
+	__u32 lssc_para_h_center;
+	__u32 lssc_para_v_center;
+	__u32 lssc_para_h_gain;
+	__u32 lssc_para_v_gain;
+	__u32 lssc_para_mgsel2;
+	__u32 lssc_para_mgsel4;
+	struct viif_l1_lsc_parabola_ag_param r_2d;
+	struct viif_l1_lsc_parabola_ag_param r_4d;
+	struct viif_l1_lsc_parabola_ag_param gr_2d;
+	struct viif_l1_lsc_parabola_ag_param gr_4d;
+	struct viif_l1_lsc_parabola_ag_param gb_2d;
+	struct viif_l1_lsc_parabola_ag_param gb_4d;
+	struct viif_l1_lsc_parabola_ag_param b_2d;
+	struct viif_l1_lsc_parabola_ag_param b_4d;
+};
+
+/**
+ * struct viif_l1_lsc_grid_param - L2ISP grid shading parameters
+ * for &struct viif_l1_lsc
+ * @lssc_grid_h_size: Grid horizontal direction pixel count [32, 64, 128, 256, 512]
+ * @lssc_grid_v_size: Grid vertical direction pixel count [32, 64, 128, 256, 512]
+ * @lssc_grid_h_center: Horizontal coordinates of grid (1, 1) [pixel] [1..lssc_grid_h_size]
+ *                      Should meet the following condition.
+ *                      "Input image width <= lssc_grid_h_center + lssc_grid_h_size * 31"
+ * @lssc_grid_v_center: Vertical coordinates of grid (1, 1) [line] [1..lssc_grid_v_size]
+ *                      Should meet the following condition.
+ *                      "Input image height <= lssc_grid_v_center + lssc_grid_v_size * 23"
+ * @lssc_grid_mgsel: &enum viif_l1_grid_coef_gain value.
+ *                   Grid correction coefficient gain value magnification ratio.
+ */
+struct viif_l1_lsc_grid_param {
+	__u32 lssc_grid_h_size;
+	__u32 lssc_grid_v_size;
+	__u32 lssc_grid_h_center;
+	__u32 lssc_grid_v_center;
+	__u32 lssc_grid_mgsel;
+};
+
+/**
+ * struct viif_l1_lsc - L2ISP LSC parameters for &struct viif_l1_lsc_config
+ * @lssc_parabola_param_addr: Address of a &struct viif_l1_lsc_parabola_param instance.
+ *                            Set 0 to disable parabola shading correction.
+ * @lssc_grid_param_addr: Address of a &struct viif_l1_lsc_grid_param instance,
+ *                        Set 0 to disable grid shading correction.
+ * @lssc_pwhb_r_gain_max: PWB R correction processing coefficient maximum value
+ * @lssc_pwhb_r_gain_min: PWB R correction processing coefficient minimum value
+ * @lssc_pwhb_gr_gain_max: PWB Gr correction processing coefficient maximum value
+ * @lssc_pwhb_gr_gain_min: PWB Gr correction processing coefficient minimum value
+ * @lssc_pwhb_gb_gain_max: PWB Gb correction processing coefficient maximum value
+ * @lssc_pwhb_gb_gain_min: PWB Gb correction processing coefficient minimum value
+ * @lssc_pwhb_b_gain_max: PWB B correction processing coefficient maximum value
+ * @lssc_pwhb_b_gain_min: PWB B correction processing coefficient minimum value
+ *
+ * The range and accuracy of preset white balance (PWB) correction process
+ * coefficient (lssc_pwhb_{r/gr/gb/b}_gain_{max/min}) are as below.
+ * "range: [0..2047], accuracy: 1/256"
+ *
+ * PWB correction process coefficient
+ * (lssc_pwhb_{r/gr/gb/b}_gain_{max/min}) should meet the following conditions.
+ * "lssc_pwhb_{r/gr/gb/b}_gain_min <= lssc_pwhb_{r/gr/gb/b}_gain_max"
+ */
+struct viif_l1_lsc {
+	__u64 lssc_parabola_param_addr;
+	__u64 lssc_grid_param_addr;
+	__u32 lssc_pwhb_r_gain_max;
+	__u32 lssc_pwhb_r_gain_min;
+	__u32 lssc_pwhb_gr_gain_max;
+	__u32 lssc_pwhb_gr_gain_min;
+	__u32 lssc_pwhb_gb_gain_max;
+	__u32 lssc_pwhb_gb_gain_min;
+	__u32 lssc_pwhb_b_gain_max;
+	__u32 lssc_pwhb_b_gain_min;
+};
+
+/**
+ * struct viif_l1_lsc_config - L2ISP LSC parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC`
+ * @param_addr: Address of a &struct viif_l1_lsc instance.
+ *              Set 0 to disable LSC operation.
+ * @table_gr_addr: Address of the grid table for LSC of Gr component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ * @table_r_addr:  Address of the grid table for LSC of R component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ * @table_b_addr:  Address of the grid table for LSC of B component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ * @table_gb_addr: Address of the grid table for LSC of Gb component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ *
+ * The size of each table is fixed to 1,536 Bytes.
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the grid table.
+ */
+struct viif_l1_lsc_config {
+	__u64 param_addr;
+	__u64 table_gr_addr;
+	__u64 table_r_addr;
+	__u64 table_b_addr;
+	__u64 table_gb_addr;
+};
+
+/**
+ * enum viif_l1_demosaic_mode - L1ISP demosaic modeenum viif_l1_demosaic_mode
+ *
+ * @VIIF_L1_DEMOSAIC_ACPI: Toshiba ACPI algorithm
+ * @VIIF_L1_DEMOSAIC_DMG: DMG algorithm
+ */
+enum viif_l1_demosaic_mode {
+	VIIF_L1_DEMOSAIC_ACPI = 0,
+	VIIF_L1_DEMOSAIC_DMG = 1,
+};
+
+/**
+ * struct viif_l1_color_matrix_correction - L1ISP color matrix correction
+ * parameters for &struct viif_l1_main_process_config
+ * @coef_rmg_min: (R-G) Minimum coefficient
+ * @coef_rmg_max: (R-G) Maximum coefficient
+ * @coef_rmb_min: (R-B) Minimum coefficient
+ * @coef_rmb_max: (R-B) Maximum coefficient
+ * @coef_gmr_min: (G-R) Minimum coefficient
+ * @coef_gmr_max: (G-R) Maximum coefficient
+ * @coef_gmb_min: (G-B) Minimum coefficient
+ * @coef_gmb_max: (G-B) Maximum coefficient
+ * @coef_bmr_min: (B-R) Minimum coefficient
+ * @coef_bmr_max: (B-R) Maximum coefficient
+ * @coef_bmg_min: (B-G) Minimum coefficient
+ * @coef_bmg_max: (B-G) Maximum coefficient
+ * @dst_minval: Minimum value of output pixel [0..0xFFFF] [pixel]
+ *
+ * The range and accuracy of each coefficient are as
+ * "range: [-32768..32767], accuracy: 1/ 4096"
+ *
+ * Also, each coefficient should meet "coef_xxx_min <= coef_xxx_max" condition
+ */
+struct viif_l1_color_matrix_correction {
+	__s16 coef_rmg_min;
+	__s16 coef_rmg_max;
+	__s16 coef_rmb_min;
+	__s16 coef_rmb_max;
+	__s16 coef_gmr_min;
+	__s16 coef_gmr_max;
+	__s16 coef_gmb_min;
+	__s16 coef_gmb_max;
+	__s16 coef_bmr_min;
+	__s16 coef_bmr_max;
+	__s16 coef_bmg_min;
+	__s16 coef_bmg_max;
+	__u16 dst_minval;
+};
+
+/**
+ * struct viif_l1_main_process_config - L1ISP Main process operating parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS`
+ * @demosaic_mode: &enum viif_l1_demosaic_mode value. Sets demosaic mode.
+ * @damp_lsbsel: Clipping range of output pixel value to AWB adjustment function [0..15]
+ * @param_addr: Address to a &struct viif_l1_color_matrix_correction instance.
+ *              Set 0 to disable color matrix correction.
+ * @dst_maxval: Maximum value of output pixel [0..0xFFFFFF].
+ *              Applicable to output of each process (digital amplifier,
+ *              demosaicing and color matrix correction) in L1ISP Main process.
+ */
+struct viif_l1_main_process_config {
+	__u32 demosaic_mode;
+	__u32 damp_lsbsel;
+	__u64 param_addr;
+	__u32 dst_maxval;
+};
+
+/**
+ * enum viif_l1_awb_mag - L1ISP signal magnification before AWB adjustment
+ *
+ * @VIIF_L1_AWB_ONE_SECOND: x 1/2
+ * @VIIF_L1_AWB_X1: 1 times
+ * @VIIF_L1_AWB_X2: 2 times
+ * @VIIF_L1_AWB_X4: 4 times
+ */
+enum viif_l1_awb_mag {
+	VIIF_L1_AWB_ONE_SECOND = 0,
+	VIIF_L1_AWB_X1 = 1,
+	VIIF_L1_AWB_X2 = 2,
+	VIIF_L1_AWB_X4 = 3,
+};
+
+/**
+ * enum viif_l1_awb_area_mode - L1ISP AWB detection target area
+ *
+ * @VIIF_L1_AWB_AREA_MODE0: only center area
+ * @VIIF_L1_AWB_AREA_MODE1: center area when uv is in square gate
+ * @VIIF_L1_AWB_AREA_MODE2: all area except center area
+ * @VIIF_L1_AWB_AREA_MODE3: all area
+ */
+enum viif_l1_awb_area_mode {
+	VIIF_L1_AWB_AREA_MODE0 = 0,
+	VIIF_L1_AWB_AREA_MODE1 = 1,
+	VIIF_L1_AWB_AREA_MODE2 = 2,
+	VIIF_L1_AWB_AREA_MODE3 = 3,
+};
+
+/**
+ * enum viif_l1_awb_restart_cond - L1ISP AWB adjustment restart conditions
+ *
+ * @VIIF_L1_AWB_RESTART_NO: no restart
+ * @VIIF_L1_AWB_RESTART_128FRAME: restart after 128 frame
+ * @VIIF_L1_AWB_RESTART_64FRAME: restart after 64 frame
+ * @VIIF_L1_AWB_RESTART_32FRAME: restart after 32 frame
+ * @VIIF_L1_AWB_RESTART_16FRAME: restart after 16 frame
+ * @VIIF_L1_AWB_RESTART_8FRAME: restart after 8 frame
+ * @VIIF_L1_AWB_RESTART_4FRAME: restart after 4 frame
+ * @VIIF_L1_AWB_RESTART_2FRAME: restart after 2 frame
+ */
+enum viif_l1_awb_restart_cond {
+	VIIF_L1_AWB_RESTART_NO = 0,
+	VIIF_L1_AWB_RESTART_128FRAME = 1,
+	VIIF_L1_AWB_RESTART_64FRAME = 2,
+	VIIF_L1_AWB_RESTART_32FRAME = 3,
+	VIIF_L1_AWB_RESTART_16FRAME = 4,
+	VIIF_L1_AWB_RESTART_8FRAME = 5,
+	VIIF_L1_AWB_RESTART_4FRAME = 6,
+	VIIF_L1_AWB_RESTART_2FRAME = 7,
+};
+
+/**
+ * struct viif_l1_awb - L1ISP AWB adjustment parameters
+ * for &struct viif_l1_awb_config
+ * @awhb_ygate_sel: 1:Enable/0:Disable to fix Y value at YUV conversion
+ * @awhb_ygate_data: Y value in case Y value is fixed [64, 128, 256, 512]
+ * @awhb_cgrange: &enum viif_l1_awb_mag value.
+ *                Signal output magnification ratio before AWB adjustment.
+ * @awhb_ygatesw: 1:Enable/0:Disable settings of luminance gate
+ * @awhb_hexsw: 1:Enable/0:Disable settings of hexa-gate
+ * @awhb_areamode: &enum viif_l1_awb_area_mode value.
+ *                 Final selection of accumulation area for detection target area.
+ * @awhb_area_hsize: Horizontal size per block in central area [pixel]
+ *                   [1..(Input image width -8)/8]
+ * @awhb_area_vsize: Vertical size per block in central area [line]
+ *                   [1..(Input image height -4)/8]
+ * @awhb_area_hofs: Horizontal offset of block [0] in central area [pixel]
+ *                  [0..(Input image width -9)]
+ * @awhb_area_vofs: Vertical offset of block [0] in central area [line]
+ *                  [0..(Input image height -5)]
+ * @awhb_area_maskh: Setting 1:Enable/0:Disable( of accumulated selection.
+ *                   Each bit implies the following.
+ *                   [31:0] = {
+ *                   (7, 3),(6, 3),(5, 3),(4, 3),(3, 3),(2, 3),(1, 3),(0, 3),
+ *                   (7, 2),(6, 2),(5, 2),(4, 2),(3, 2),(2, 2),(1, 2),(0, 2),
+ *                   (7, 1),(6, 1),(5, 1),(4, 1),(3, 1),(2, 1),(1, 1),(0, 1),
+ *                   (7, 0),(6, 0),(5, 0),(4, 0),(3, 0),(2, 0),(1, 0),(0, 0)}
+ * @awhb_area_maskl: Setting 1:Enable/0:Disable of accumulated selection.
+ *                   Each bit implies the following.
+ *                   [31:0] = {
+ *                   (7, 7),(6, 7),(5, 7),(4, 7),(3, 7),(2, 7),(1, 7),(0, 7),
+ *                   (7, 6),(6, 6),(5, 6),(4, 6),(3, 6),(2, 6),(1, 6),(0, 6),
+ *                   (7, 5),(6, 5),(5, 5),(4, 5),(3, 5),(2, 5),(1, 5),(0, 5),
+ *                   (7, 4),(6, 4),(5, 4),(4, 4),(3, 4),(2, 4),(1, 4),(0, 4)}
+ * @awhb_sq_sw: 1:Enable/0:Disable each square gate
+ * @awhb_sq_pol: 1:Enable/0:Disable to add accumulated gate for each square gate
+ * @awhb_bycut0p: U upper end value [pixel] [0..127]
+ * @awhb_bycut0n: U lower end value [pixel] [0..127]
+ * @awhb_rycut0p: V upper end value [pixel] [0..127]
+ * @awhb_rycut0n: V lower end value [pixel] [0..127]
+ * @awhb_rbcut0h: V-axis intercept upper end [pixel] [-127..127]
+ * @awhb_rbcut0l: V-axis intercept lower end [pixel] [-127..127]
+ * @awhb_bycut_h: U direction center value of each square gate [-127..127]
+ * @awhb_bycut_l: U direction width of each square gate [0..127]
+ * @awhb_rycut_h: V direction center value of each square gate [-127..127]
+ * @awhb_rycut_l: V direction width of each square gate [0..127]
+ * @awhb_awbsftu: U gain offset [-127..127]
+ * @awhb_awbsftv: V gain offset [-127..127]
+ * @awhb_awbhuecor: 1:Enable/0:Disable setting of color correlation retention function
+ * @awhb_awbspd: UV convergence speed [0..15] [times] (0 means "stop")
+ * @awhb_awbulv: U convergence point level [0..31]
+ * @awhb_awbvlv: V convergence point level [0..31]
+ * @awhb_awbondot: Accumulation operation stop pixel count threshold [pixel] [0..1023]
+ * @awhb_awbfztim: &enum viif_l1_awb_restart_cond value. Condition to restart AWB process.
+ * @awhb_wbgrmax: B gain adjustment range (Width from center to upper limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_wbgbmax: R gain adjustment range (Width from center to upper limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_wbgrmin: B gain adjustment range (Width from center to lower limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_wbgbmin: R gain adjustment range (Width from center to lower limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_ygateh: Luminance gate maximum value [pixel] [0..255]
+ * @awhb_ygatel: Luminance gate minimum value [pixel] [0..255]
+ * @awhb_awbwait: Number of restart frames after UV convergence freeze [0..255]
+ */
+struct viif_l1_awb {
+	__u32 awhb_ygate_sel;
+	__u32 awhb_ygate_data;
+	__u32 awhb_cgrange;
+	__u32 awhb_ygatesw;
+	__u32 awhb_hexsw;
+	__u32 awhb_areamode;
+	__u32 awhb_area_hsize;
+	__u32 awhb_area_vsize;
+	__u32 awhb_area_hofs;
+	__u32 awhb_area_vofs;
+	__u32 awhb_area_maskh;
+	__u32 awhb_area_maskl;
+	__u32 awhb_sq_sw[3];
+	__u32 awhb_sq_pol[3];
+	__u32 awhb_bycut0p;
+	__u32 awhb_bycut0n;
+	__u32 awhb_rycut0p;
+	__u32 awhb_rycut0n;
+	__s32 awhb_rbcut0h;
+	__s32 awhb_rbcut0l;
+	__s32 awhb_bycut_h[3];
+	__u32 awhb_bycut_l[3];
+	__s32 awhb_rycut_h[3];
+	__u32 awhb_rycut_l[3];
+	__s32 awhb_awbsftu;
+	__s32 awhb_awbsftv;
+	__u32 awhb_awbhuecor;
+	__u32 awhb_awbspd;
+	__u32 awhb_awbulv;
+	__u32 awhb_awbvlv;
+	__u32 awhb_awbondot;
+	__u32 awhb_awbfztim;
+	__u8 awhb_wbgrmax;
+	__u8 awhb_wbgbmax;
+	__u8 awhb_wbgrmin;
+	__u8 awhb_wbgbmin;
+	__u8 awhb_ygateh;
+	__u8 awhb_ygatel;
+	__u8 awhb_awbwait;
+};
+
+/**
+ * struct viif_l1_awb_config - L1ISP AWB parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB`
+ * @param_addr: Address to a &struct viif_l1_awb instance.
+ *              Set 0 to disable AWB adjustment.
+ * @awhb_wbmrg: White balance adjustment R gain [64..1023], accuracy: 1/256
+ * @awhb_wbmgg: White balance adjustment G gain [64..1023], accuracy: 1/256
+ * @awhb_wbmbg: White balance adjustment B gain [64..1023], accuracy: 1/256
+ */
+struct viif_l1_awb_config {
+	__u64 param_addr;
+	__u32 awhb_wbmrg;
+	__u32 awhb_wbmgg;
+	__u32 awhb_wbmbg;
+};
+
+/**
+ * enum viif_l1_hdrc_tone_type - L1ISP HDRC tone type
+ *
+ * @VIIF_L1_HDRC_TONE_USER: User Tone
+ * @VIIF_L1_HDRC_TONE_PRESET: Preset Tone
+ */
+enum viif_l1_hdrc_tone_type {
+	VIIF_L1_HDRC_TONE_USER = 0,
+	VIIF_L1_HDRC_TONE_PRESET = 1,
+};
+
+/**
+ * struct viif_l1_hdrc - L1ISP HDRC parameters for &struct viif_l1_hdrc_config
+ * @hdrc_ratio: Data width of input image [bit] [10..24]
+ * @hdrc_pt_ratio: Preset Tone curve slope [0..13]
+ * @hdrc_pt_blend: Preset Tone0 curve blend ratio [0..256], accuracy: 1/256
+ * @hdrc_pt_blend2: Preset Tone2 curve blend ratio [0..256], accuracy: 1/256
+ * @hdrc_tn_type: &enum viif_l1_hdrc_tone_type value. L1ISP HDRC tone type.
+ * @hdrc_utn_tbl: HDRC value of User Tone curve [0..0xFFFF]
+ * @hdrc_flr_val: Constant flare value [0..0xFFFFFF]
+ * @hdrc_flr_adp: 1:Enable/0:Disable setting of dynamic flare measurement
+ * @hdrc_ybr_off: 1:Enable(function OFF) / 0:Disable(function ON) settings
+ *                of bilateral luminance filter function OFF
+ * @hdrc_orgy_blend: Blend settings of luminance correction data after HDRC
+ *                   and data before luminance correction [0..16].
+ *                   (0:Luminance correction 100%, 8:Luminance correction 50%,
+ *                   16:Luminance correction 0%)
+ * @hdrc_pt_sat: Preset Tone saturation value [0..0xFFFF]
+ *
+ * Parameter error needs to be returned in
+ * "hdrc_pt_blend + hdrc_pt_blend2 > 256" condition.
+ *
+ * In case application enables dynamic flare control, input image height should
+ * satisfy the following condition. Even if this condition is not satisfied,
+ * this driver doesn't return error in case other conditions for each parameter
+ * are satisfied. "Input image height % 64 != 18, 20, 22, 24, 26"
+ *
+ * hdrc_utn_tbl should satisfy the following condition. Even if this condition
+ * is not satisfied, this driver doesn't return error in case other conditions
+ * for each parameter are satisfied. "hdrc_utn_tbl[N] <= hdrc_utn_tbl[N+1]"
+ */
+struct viif_l1_hdrc {
+	__u32 hdrc_ratio;
+	__u32 hdrc_pt_ratio;
+	__u32 hdrc_pt_blend;
+	__u32 hdrc_pt_blend2;
+	__u32 hdrc_tn_type;
+	__u16 hdrc_utn_tbl[20];
+	__u32 hdrc_flr_val;
+	__u32 hdrc_flr_adp;
+	__u32 hdrc_ybr_off;
+	__u32 hdrc_orgy_blend;
+	__u16 hdrc_pt_sat;
+};
+
+/**
+ * struct viif_l1_hdrc_config - L1ISP HDRC parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC`
+ * @param_addr: Address to a &struct viif_l1_hdrc instance.
+ *              Set 0 to disable HDR compression.
+ * @hdrc_thr_sft_amt: Amount of right shift in through mode (HDRC disabled) [0..8].
+ *                    Should set 0 if HDRC is enabled
+ */
+struct viif_l1_hdrc_config {
+	__u64 param_addr;
+	__u32 hdrc_thr_sft_amt;
+};
+
+/**
+ * struct viif_l1_hdrc_ltm_config - L1ISP HDRC LTM parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM`
+ * @tnp_max: Tone blend rate maximum value of LTM function
+ *           [0..4194303], accuracy: 1/64. In case of 0, LTM function is OFF
+ * @tnp_mag: Intensity adjustment of LTM function [0..16383], accuracy: 1/64
+ * @tnp_fil: Smoothing filter coefficient [0..255].
+ *           [0]: coef0, [1]: coef1, [2]: coef2, [3]: coef3, [4]: coef4
+ *           EINVAL needs to be returned in the below condition.
+ *           "(coef1 + coef2 + coef3 + coef4) * 2 + coef0 != 1024"
+ */
+struct viif_l1_hdrc_ltm_config {
+	__u32 tnp_max;
+	__u32 tnp_mag;
+	__u8 tnp_fil[5];
+};
+
+/**
+ * struct viif_l1_gamma - L1ISP gamma correction parameters
+ * for &struct viif_l1_gamma_config
+ * @gam_p: Luminance value after gamma correction [0..8191]
+ * @blkadj: Black level adjustment value after gamma correction [0..65535]
+ */
+struct viif_l1_gamma {
+	__u16 gam_p[44];
+	__u16 blkadj;
+};
+
+/**
+ * struct viif_l1_gamma_config - L1ISP gamma correction parameters
+ * @param_addr: Address to a &struct viif_l1_gamma instance.
+ *              Set 0 to disable gamma correction at l1 ISP.
+ */
+struct viif_l1_gamma_config {
+	__u64 param_addr;
+};
+
+/**
+ * struct viif_l1_nonlinear_contrast -  L1ISP non-linear contrast parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @blk_knee: Black side peak luminance value [0..0xFFFF]
+ * @wht_knee: White side peak luminance value[0..0xFFFF]
+ * @blk_cont: Black side slope [0..255], accuracy: 1/256
+ *            [0]:the value at AG minimum, [1]:the value at AG less than 128,
+ *            [2]:the value at AG equal to or more than 128
+ * @wht_cont: White side slope [0..255], accuracy: 1/256
+ *            [0]:the value at AG minimum, [1]:the value at AG less than 128,
+ *            [2]:the value at AG equal to or more than 128
+ */
+struct viif_l1_nonlinear_contrast {
+	__u16 blk_knee;
+	__u16 wht_knee;
+	__u8 blk_cont[3];
+	__u8 wht_cont[3];
+};
+
+/**
+ * struct viif_l1_lum_noise_reduction -  L1ISP luminance noise reduction
+ * parameters for &struct viif_l1_img_quality_adjustment_config
+ * @gain_min: Minimum value of extracted noise gain [0..0xFFFF], accuracy: 1/256
+ * @gain_max: Maximum value of extracted noise gain [0..0xFFFF], accuracy: 1/256
+ * @lim_min: Minimum value of extracted noise limit [0..0xFFFF]
+ * @lim_max: Maximum value of extracted noise limit [0..0xFFFF]
+ *
+ * Parameter error needs to be returned in the below conditions.
+ * "gain_min > gain_max" or "lim_min > lim_max"
+ */
+struct viif_l1_lum_noise_reduction {
+	__u16 gain_min;
+	__u16 gain_max;
+	__u16 lim_min;
+	__u16 lim_max;
+};
+
+/**
+ * struct viif_l1_edge_enhancement -  L1ISP edge enhancement parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain_min: Extracted edge gain minimum value [0..0xFFFF], accuracy: 1/256
+ * @gain_max: Extracted edge gain maximum value [0..0xFFFF], accuracy: 1/256
+ * @lim_min: Extracted edge limit minimum value [0..0xFFFF]
+ * @lim_max: Extracted edge limit maximum value [0..0xFFFF]
+ * @coring_min: Extracted edge coring threshold minimum value [0..0xFFFF]
+ * @coring_max: Extracted edge coring threshold maximum value [0..0xFFFF]
+ *
+ * Parameter error needs to be returned in the below conditions.
+ * "gain_min > gain_max" or "lim_min > lim_max" or "coring_min > coring_max"
+ */
+struct viif_l1_edge_enhancement {
+	__u16 gain_min;
+	__u16 gain_max;
+	__u16 lim_min;
+	__u16 lim_max;
+	__u16 coring_min;
+	__u16 coring_max;
+};
+
+/**
+ * struct viif_l1_uv_suppression -  L1ISP UV suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @bk_mp: Black side slope [0..0x3FFF], accuracy: 1/16384
+ * @black: Minimum black side gain [0..0x3FFF], accuracy: 1/16384
+ * @wh_mp: White side slope [0..0x3FFF], accuracy: 1/16384
+ * @white: Minimum white side gain [0..0x3FFF], accuracy: 1/16384
+ * @bk_slv: Black side intercept [0..0xFFFF]
+ * @wh_slv: White side intercept [0..0xFFFF]
+ *
+ * parameter error needs to be returned in "bk_slv >= wh_slv" condition.
+ */
+struct viif_l1_uv_suppression {
+	__u32 bk_mp;
+	__u32 black;
+	__u32 wh_mp;
+	__u32 white;
+	__u16 bk_slv;
+	__u16 wh_slv;
+};
+
+/**
+ * struct viif_l1_coring_suppression -  L1ISP coring suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @lv_min: Minimum coring threshold [0..0xFFFF]
+ * @lv_max: Maximum coring threshold [0..0xFFFF]
+ * @gain_min: Minimum gain [0..0xFFFF], accuracy: 1/65536
+ * @gain_max: Maximum gain [0..0xFFFF], accuracy: 1/65536
+ *
+ * Parameter error needs to be returned in the below condition.
+ * "lv_min > lv_max" or "gain_min > gain_max"
+ */
+struct viif_l1_coring_suppression {
+	__u16 lv_min;
+	__u16 lv_max;
+	__u16 gain_min;
+	__u16 gain_max;
+};
+
+/**
+ * struct viif_l1_edge_suppression -  L1ISP edge suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain: Gain of edge color suppression [0..0xFFFF], accuracy: 1/256
+ * @lim: Limiter threshold of edge color suppression [0..15]
+ */
+struct viif_l1_edge_suppression {
+	__u16 gain;
+	__u32 lim;
+};
+
+/**
+ * struct viif_l1_color_level -  L1ISP color level parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @cb_gain: U component gain [0..0xFFF], accuracy: 1/2048
+ * @cr_gain: V component gain [0..0xFFF], accuracy: 1/2048
+ * @cbr_mgain_min: UV component gain [0..0xFFF], accuracy: 1/2048
+ * @cbp_gain_max: Positive U component gain [0..0xFFF], accuracy: 1/2048
+ * @cbm_gain_max: Negative V component gain [0..0xFFF], accuracy: 1/2048
+ * @crp_gain_max: Positive U component gain [0..0xFFF], accuracy: 1/2048
+ * @crm_gain_max: Negative V component gain [0..0xFFF], accuracy: 1/2048
+ */
+struct viif_l1_color_level {
+	__u32 cb_gain;
+	__u32 cr_gain;
+	__u32 cbr_mgain_min;
+	__u32 cbp_gain_max;
+	__u32 cbm_gain_max;
+	__u32 crp_gain_max;
+	__u32 crm_gain_max;
+};
+
+/**
+ * struct viif_l1_img_quality_adjustment_config -  L1ISP image quality
+ * adjustment parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT`
+ * @coef_cb: Cb coefficient used in RGB to YUV conversion
+ *           [0..0xFFFF], accuracy: 1/65536
+ * @coef_cr: Cr coefficient used in RGB to YUV conversion
+ *           [0..0xFFFF], accuracy: 1/65536
+ * @brightness: Brightness value [-32768..32767] (0 means off)
+ * @linear_contrast: Linear contrast adjustment value
+ *                   [0..0xFF], accuracy: 1/128 (128 means off)
+ * @nonlinear_contrast_addr: Address to a &struct viif_l1_nonlinear_contrast instance.
+ *                           Set 0 to disable nonlinear contrast adjustment.
+ * @lum_noise_reduction_addr: Address to a &struct viif_l1_lum_noise_reduction instance.
+ *                            Set 0 to disable luminance noise reduction.
+ * @edge_enhancement_addr: Address to a &struct viif_l1_edge_enhancement instance.
+ *                         Set 0 to disable edge enhancement,
+ * @uv_suppression_addr: Address to a &struct viif_l1_uv_suppression instance.
+ *                       Set 0 to disable chroma suppression.
+ * @coring_suppression_addr: Address to a &struct viif_l1_coring_suppression instance.
+ *                           Set 0 to disable coring suppression.
+ * @edge_suppression_addr: Address to a &struct viif_l1_edge_suppression instance.
+ *                         Set 0 to disable chroma edge suppression.
+ * @color_level_addr: Address to a &struct viif_l1_color_level instance.
+ *                    Set 0 to disable color level adjustment.
+ * @color_noise_reduction_enable: 1:Enable/0:disable setting of
+ *                                color component noise reduction processing
+ */
+struct viif_l1_img_quality_adjustment_config {
+	__u16 coef_cb;
+	__u16 coef_cr;
+	__s16 brightness;
+	__u8 linear_contrast;
+	__u64 nonlinear_contrast_addr;
+	__u64 lum_noise_reduction_addr;
+	__u64 edge_enhancement_addr;
+	__u64 uv_suppression_addr;
+	__u64 coring_suppression_addr;
+	__u64 edge_suppression_addr;
+	__u64 color_level_addr;
+	__u32 color_noise_reduction_enable;
+};
+
+/**
+ * struct viif_l1_avg_lum_generation_config - L1ISP average luminance generation configuration
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION`
+ * @aexp_start_x: horizontal position of block[0] [0.."width of input image - 1"] [pixel]
+ * @aexp_start_y: vertical position of block[0] [0.."height of input image - 1"] [line]
+ * @aexp_block_width: width of one block(needs to be multiple of 64)
+ *                    [64.."width of input image"] [pixel]
+ * @aexp_block_height: height of one block(needs to be multiple of 64)
+ *                     [64.."height of input image"] [line]
+ * @aexp_weight: weight of each block [0..3]  [y][x]:
+ *               y means vertical position and x means horizontal position
+ * @aexp_satur_ratio: threshold to judge whether saturated block or not [0..256]
+ * @aexp_black_ratio: threshold to judge whether black block or not [0..256]
+ * @aexp_satur_level: threshold to judge whether saturated pixel or not [0x0..0xffffff]
+ * @aexp_ave4linesy: vertical position of the initial line
+ *                   for 4-lines average luminance [0.."height of input image - 4"] [line]
+ */
+struct viif_l1_avg_lum_generation_config {
+	__u32 aexp_start_x;
+	__u32 aexp_start_y;
+	__u32 aexp_block_width;
+	__u32 aexp_block_height;
+	__u32 aexp_weight[8][8];
+	__u32 aexp_satur_ratio;
+	__u32 aexp_black_ratio;
+	__u32 aexp_satur_level;
+	__u32 aexp_ave4linesy[4];
+};
+
+/**
+ * enum viif_l2_undist_mode - L2ISP undistortion mode
+ * @VIIF_L2_UNDIST_POLY: polynomial mode
+ * @VIIF_L2_UNDIST_GRID: grid table mode
+ * @VIIF_L2_UNDIST_POLY_TO_GRID: polynomial, then grid table mode
+ * @VIIF_L2_UNDIST_GRID_TO_POLY: grid table, then polynomial mode
+ */
+enum viif_l2_undist_mode {
+	VIIF_L2_UNDIST_POLY = 0,
+	VIIF_L2_UNDIST_GRID = 1,
+	VIIF_L2_UNDIST_POLY_TO_GRID = 2,
+	VIIF_L2_UNDIST_GRID_TO_POLY = 3,
+};
+
+/**
+ * struct viif_l2_undist - L2ISP UNDIST parameters
+ * for &struct viif_l2_undist_config
+ * @through_mode: 1:enable or 0:disable through mode of undistortion
+ * @roi_mode: &enum viif_l2_undist_mode value. Sets L2ISP undistortion mode.
+ * @sensor_crop_ofs_h: Horizontal start position of sensor crop area[pixel]
+ *                     [-4296..4296], accuracy: 1/2
+ * @sensor_crop_ofs_v: Vertical start position of sensor crop area[line]
+ *                     [-2360..2360], accuracy: 1/2
+ * @norm_scale: Normalization coefficient for distance from center
+ *              [0..1677721], accuracy: 1/33554432
+ * @valid_r_norm2_poly: Setting target area for polynomial correction
+ *                      [0..0x3FFFFFF], accuracy: 1/33554432
+ * @valid_r_norm2_grid: Setting target area for grid table correction
+ *                      [0..0x3FFFFFF], accuracy: 1/33554432
+ * @roi_write_area_delta: Error adjustment value of forward function and
+ *                        inverse function for pixel position calculation
+ *                        [0..0x7FF], accuracy: 1/1024
+ * @poly_write_g_coef: 10th-order polynomial coefficient for G write pixel position calculation
+ *                     [-2147352576..2147352576], accuracy: 1/131072
+ * @poly_read_b_coef: 10th-order polynomial coefficient for B read pixel position calculation
+ *                    [-2147352576..2147352576], accuracy: 1/131072
+ * @poly_read_g_coef: 10th-order polynomial coefficient for G read pixel position calculation
+ *                    [-2147352576..2147352576], accuracy: 1/131072
+ * @poly_read_r_coef: 10th-order polynomial coefficient for R read pixel position calculation
+ *                    [-2147352576..2147352576], accuracy: 1/131072
+ * @grid_node_num_h: Number of horizontal grids [16..64]
+ * @grid_node_num_v: Number of vertical grids [16..64]
+ * @grid_patch_hsize_inv: Inverse pixel size between horizontal grids
+ *                        [0..0x7FFFFF], accuracy: 1/8388608
+ * @grid_patch_vsize_inv: Inverse pixel size between vertical grids
+ *                        [0..0x7FFFFF], accuracy: 1/8388608
+ */
+struct viif_l2_undist {
+	__u32 through_mode;
+	__u32 roi_mode[2];
+	__s32 sensor_crop_ofs_h;
+	__s32 sensor_crop_ofs_v;
+	__u32 norm_scale;
+	__u32 valid_r_norm2_poly;
+	__u32 valid_r_norm2_grid;
+	__u32 roi_write_area_delta[2];
+	__s32 poly_write_g_coef[11];
+	__s32 poly_read_b_coef[11];
+	__s32 poly_read_g_coef[11];
+	__s32 poly_read_r_coef[11];
+	__u32 grid_node_num_h;
+	__u32 grid_node_num_v;
+	__u32 grid_patch_hsize_inv;
+	__u32 grid_patch_vsize_inv;
+};
+
+/**
+ * struct viif_l2_undist_config - L2ISP UNDIST parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST`
+ * @param: &struct viif_l2_undist
+ * @write_g_addr: Address to write-G grid table.
+ *                Table size is specified by member size.
+ *                Set 0 to disable this table.
+ * @read_b_addr: Address to read-B grid table.
+ *               Table size is specified by member size.
+ *               Set 0 to disable this table.
+ * @read_g_addr: Address to read-G grid table.
+ *               Table size is specified by member size.
+ *               Set 0 to disable this table.
+ * @read_r_addr: Address to read-R grid table.
+ *               Table size is specified by member size.
+ *               Set 0 to disable this table.
+ * @size: Table size [byte]. Range: [1024..8192] or 0.
+ *        The value should be "grid_node_num_h * grid_node_num_v * 4".
+ *        See also &struct viif_l2_undist.
+ *        Set 0 if NULL is set for all tables.
+ *        Set valid size value if at least one table is valid.
+ *
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the contents of specified grid table.
+ */
+struct viif_l2_undist_config {
+	struct viif_l2_undist param;
+	__u64 write_g_addr;
+	__u64 read_b_addr;
+	__u64 read_g_addr;
+	__u64 read_r_addr;
+	__u32 size;
+};
+
+/**
+ * struct viif_l2_roi_config - L2ISP ROI parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI`
+ * @roi_num:
+ *     1 when only capture path0 is activated,
+ *     2 when both capture path 0 and path 1 are activated.
+ * @roi_scale: Scale value for each ROI [32768..131072], accuracy: 1/65536
+ * @roi_scale_inv: Inverse scale value for each ROI [32768..131072], accuracy: 1/65536
+ * @corrected_wo_scale_hsize: Corrected image width for each ROI [pixel] [128..8190]
+ * @corrected_wo_scale_vsize: Corrected image height for each ROI [line] [128..4094]
+ * @corrected_hsize: Corrected and scaled image width for each ROI [pixel] [128..8190]
+ * @corrected_vsize: Corrected and scaled image height for each ROI [line] [128..4094]
+ */
+struct viif_l2_roi_config {
+	__u32 roi_num;
+	__u32 roi_scale[2];
+	__u32 roi_scale_inv[2];
+	__u32 corrected_wo_scale_hsize[2];
+	__u32 corrected_wo_scale_vsize[2];
+	__u32 corrected_hsize[2];
+	__u32 corrected_vsize[2];
+};
+
+/** enum viif_gamma_mode - Gamma correction mode
+ *
+ * @VIIF_GAMMA_COMPRESSED: compressed table mode
+ * @VIIF_GAMMA_LINEAR: linear table mode
+ */
+enum viif_gamma_mode {
+	VIIF_GAMMA_COMPRESSED = 0,
+	VIIF_GAMMA_LINEAR = 1,
+};
+
+/**
+ * struct viif_l2_gamma_config - L2ISP gamma correction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA`
+ * @pathid: 0 for Capture Path 0, 1 for Capture Path 1.
+ * @enable: 1:Enable, 0:Disable settings of L2ISP gamma correction control
+ * @vsplit: Line switching position of first table and second table [line] [0..4094].
+ *          Should set 0 in case 0 is set to @enable
+ * @mode: &enum viif_gamma_mode value.
+ *        Should set VIIF_GAMMA_COMPRESSED when 0 is set to @enable
+ * @table_addr: Address to gamma table for L2ISP gamma.
+ *              The table has 6 channels;
+ *              [0]: G/Y(1st table), [1]: G/Y(2nd table), [2]: B/U(1st table)
+ *              [3]: B/U(2nd table), [4]: R/V(1st table), [5]: R/V(2nd table)
+ *              Each channel of the table is __u16 typed and 512 bytes.
+ */
+struct viif_l2_gamma_config {
+	__u32 pathid;
+	__u32 enable;
+	__u32 vsplit;
+	__u32 mode;
+	__u64 table_addr[6];
+};
+
+/**
+ * enum viif_csi2_cal_status - CSI2RX calibration status
+ *
+ * @VIIF_CSI2_CAL_NOT_DONE: Calibration not complete
+ * @VIIF_CSI2_CAL_SUCCESS: Calibration success
+ * @VIIF_CSI2_CAL_FAIL: Calibration failed
+ */
+enum viif_csi2_cal_status {
+	VIIF_CSI2_CAL_NOT_DONE = 0,
+	VIIF_CSI2_CAL_SUCCESS = 1,
+	VIIF_CSI2_CAL_FAIL = 2,
+};
+
+/**
+ * struct viif_csi2rx_dphy_calibration_status - CSI2-RX D-PHY Calibration
+ * information for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS`
+ * @term_cal_with_rext: Result of termination calibration with rext
+ * @clock_lane_offset_cal: Result of offset calibration of clock lane
+ * @data_lane0_offset_cal: Result of offset calibration of data lane0
+ * @data_lane1_offset_cal: Result of offset calibration of data lane1
+ * @data_lane2_offset_cal: Result of offset calibration of data lane2
+ * @data_lane3_offset_cal: Result of offset calibration of data lane3
+ * @data_lane0_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane0
+ * @data_lane1_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane1
+ * @data_lane2_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane2
+ * @data_lane3_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane3
+ *
+ * Values for each member is typed &enum viif_csi2_cal_status.
+ */
+struct viif_csi2rx_dphy_calibration_status {
+	__u32 term_cal_with_rext;
+	__u32 clock_lane_offset_cal;
+	__u32 data_lane0_offset_cal;
+	__u32 data_lane1_offset_cal;
+	__u32 data_lane2_offset_cal;
+	__u32 data_lane3_offset_cal;
+	__u32 data_lane0_ddl_tuning_cal;
+	__u32 data_lane1_ddl_tuning_cal;
+	__u32 data_lane2_ddl_tuning_cal;
+	__u32 data_lane3_ddl_tuning_cal;
+};
+
+/**
+ * struct viif_csi2rx_err_status - CSI2RX Error status parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS`
+ * @err_phy_fatal: D-PHY FATAL error.
+ *
+ *  * bit[3]: Start of transmission error on DATA Lane3.
+ *  * bit[2]: Start of transmission error on DATA Lane2.
+ *  * bit[1]: Start of transmission error on DATA Lane1.
+ *  * bit[0]: Start of transmission error on DATA Lane0.
+ * @err_pkt_fatal: Packet FATAL error.
+ *
+ *  * bit[16]: Header ECC contains 2 errors, unrecoverable.
+ *  * bit[3]: Checksum error detected on virtual channel 3.
+ *  * bit[2]: Checksum error detected on virtual channel 2.
+ *  * bit[1]: Checksum error detected on virtual channel 1.
+ *  * bit[0]: Checksum error detected on virtual channel 0.
+ * @err_frame_fatal: Frame FATAL error.
+ *
+ *  * bit[19]: Last received Frame, in virtual channel 3, has at least one CRC error.
+ *  * bit[18]: Last received Frame, in virtual channel 2, has at least one CRC error.
+ *  * bit[17]: Last received Frame, in virtual channel 1, has at least one CRC error.
+ *  * bit[16]: Last received Frame, in virtual channel 0, has at least one CRC error.
+ *  * bit[11]: Incorrect Frame Sequence detected in virtual channel 3.
+ *  * bit[10]: Incorrect Frame Sequence detected in virtual channel 2.
+ *  * bit[9]: Incorrect Frame Sequence detected in virtual channel 1.
+ *  * bit[8]: Incorrect Frame Sequence detected in virtual channel 0.
+ *  * bit[3]: Error matching Frame Start with Frame End for virtual channel 3.
+ *  * bit[2]: Error matching Frame Start with Frame End for virtual channel 2.
+ *  * bit[1]: Error matching Frame Start with Frame End for virtual channel 1.
+ *  * bit[0]: Error matching Frame Start with Frame End for virtual channel 0.
+ * @err_phy: D-PHY error.
+ *
+ *  * bit[19]: Escape Entry Error on Data Lane 3.
+ *  * bit[18]: Escape Entry Error on Data Lane 2.
+ *  * bit[17]: Escape Entry Error on Data Lane 1.
+ *  * bit[16]: Escape Entry Error on Data Lane 0.
+ *  * bit[3]: Start of Transmission Error on Data Lane 3 (synchronization can still be achieved).
+ *  * bit[2]: Start of Transmission Error on Data Lane 2 (synchronization can still be achieved).
+ *  * bit[1]: Start of Transmission Error on Data Lane 1 (synchronization can still be achieved).
+ *  * bit[0]: Start of Transmission Error on Data Lane 0 (synchronization can still be achieved).
+ * @err_pkt: Packet error.
+ *
+ *  * bit[19]: Header Error detected and corrected on virtual channel 3.
+ *  * bit[18]: Header Error detected and corrected on virtual channel 2.
+ *  * bit[17]: Header Error detected and corrected on virtual channel 1.
+ *  * bit[16]: Header Error detected and corrected on virtual channel 0.
+ *  * bit[3]: Unrecognized or unimplemented data type detected in virtual channel 3.
+ *  * bit[2]: Unrecognized or unimplemented data type detected in virtual channel 2.
+ *  * bit[1]: Unrecognized or unimplemented data type detected in virtual channel 1.
+ *  * bit[0]: Unrecognized or unimplemented data type detected in virtual channel 0.
+ * @err_line: Line error.
+ *
+ *  * bit[23]: Error in the sequence of lines for vc7 and dt7.
+ *  * bit[22]: Error in the sequence of lines for vc6 and dt6.
+ *  * bit[21]: Error in the sequence of lines for vc5 and dt5.
+ *  * bit[20]: Error in the sequence of lines for vc4 and dt4.
+ *  * bit[19]: Error in the sequence of lines for vc3 and dt3.
+ *  * bit[18]: Error in the sequence of lines for vc2 and dt2.
+ *  * bit[17]: Error in the sequence of lines for vc1 and dt1.
+ *  * bit[16]: Error in the sequence of lines for vc0 and dt0.
+ *  * bit[7]: Error matching Line Start with Line End for vc7 and dt7.
+ *  * bit[6]: Error matching Line Start with Line End for vc6 and dt6.
+ *  * bit[5]: Error matching Line Start with Line End for vc5 and dt5.
+ *  * bit[4]: Error matching Line Start with Line End for vc4 and dt4.
+ *  * bit[3]: Error matching Line Start with Line End for vc3 and dt3.
+ *  * bit[2]: Error matching Line Start with Line End for vc2 and dt2.
+ *  * bit[1]: Error matching Line Start with Line End for vc1 and dt1.
+ *  * bit[0]: Error matching Line Start with Line End for vc0 and dt0.
+ */
+struct viif_csi2rx_err_status {
+	__u32 err_phy_fatal;
+	__u32 err_pkt_fatal;
+	__u32 err_frame_fatal;
+	__u32 err_phy;
+	__u32 err_pkt;
+	__u32 err_line;
+};
+
+/**
+ * struct viif_l1_info - L1ISP AWB information
+ * for &struct viif_isp_capture_status
+ * @avg_lum_weight: weighted average luminance value at average luminance generation
+ * @avg_lum_block: average luminance of each block [y][x]:
+ *                 y means vertical position and x means horizontal position
+ * @avg_lum_four_line_lum: 4-lines average luminance.
+ *                         avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
+ * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
+ * @avg_black_pixnum: the number of black pixel at average luminance generation
+ * @awb_ave_u: U average value of AWB adjustment [pixel]
+ * @awb_ave_v: V average value of AWB adjustment [pixel]
+ * @awb_accumulated_pixel: Accumulated pixel count of AWB adjustment
+ * @awb_gain_r: R gain used in the next frame of AWB adjustment
+ * @awb_gain_g: G gain used in the next frame of AWB adjustment
+ * @awb_gain_b: B gain used in the next frame of AWB adjustment
+ * @awb_status_u: boolean value of U convergence state of AWB adjustment
+ *                (0: not-converged, 1: converged)
+ * @awb_status_v: boolean value of V convergence state of AWB adjustment
+ *                (0: not-converged, 1: converged)
+ */
+struct viif_l1_info {
+	__u32 avg_lum_weight;
+	__u32 avg_lum_block[8][8];
+	__u32 avg_lum_four_line_lum[4];
+	__u32 avg_satur_pixnum;
+	__u32 avg_black_pixnum;
+	__u32 awb_ave_u;
+	__u32 awb_ave_v;
+	__u32 awb_accumulated_pixel;
+	__u32 awb_gain_r;
+	__u32 awb_gain_g;
+	__u32 awb_gain_b;
+	__u8 awb_status_u;
+	__u8 awb_status_v;
+};
+
+/**
+ * struct viif_isp_capture_status - L1ISP capture information
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS`
+ * @l1_info: L1ISP AWB information. Refer to &struct viif_l1_info
+ */
+struct viif_isp_capture_status {
+	struct viif_l1_info l1_info;
+};
+
+/**
+ * struct viif_reported_errors - Errors since last call
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS`
+ * @main: error flag value for capture device 0 and 1
+ * @sub: error flag value for capture device 2
+ * @csi2rx: error flag value for CSI2 receiver
+ */
+struct viif_reported_errors {
+	__u32 main;
+	__u32 sub;
+	__u32 csi2rx;
+};
+
+#endif /* __UAPI_VISCONTI_VIIF_H_ */
-- 
2.25.1


