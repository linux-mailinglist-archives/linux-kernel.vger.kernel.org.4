Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9666375B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbjAJC2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbjAJC2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:28:43 -0500
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1115.securemx.jp [210.130.202.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8766471;
        Mon,  9 Jan 2023 18:28:37 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 30A1loRM014436; Tue, 10 Jan 2023 10:47:50 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 30A1l7KF014745; Tue, 10 Jan 2023 10:47:07 +0900
X-Iguazu-Qid: 2wGqnqi0HsNvxKBQp7
X-Iguazu-QSIG: v=2; s=0; t=1673315227; q=2wGqnqi0HsNvxKBQp7; m=NHLcIqThtQFtAv6S2DPctkaxqPlUqytgzpziVPA9Hww=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1112) id 30A1l5Kj017320
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Jan 2023 10:47:05 +0900
X-SA-MID: 48793546
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v4 4/6] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver v4l2 controls handler
Date:   Tue, 10 Jan 2023 10:41:41 +0900
X-TSB-HOP2: ON
Message-Id: <20230110014143.18684-5-yuji2.ishikawa@toshiba.co.jp>
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

Add support to Image Signal Processors of Visconti's Video Input Interface.
This patch adds vendor specific compound controls
to configure the image signal processor.

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
  - Use dynamically allocated structure to hold HW specific context,
    instead of static one.
  - Call HW layer functions with the context structure instead of ID number
---
 drivers/media/platform/visconti/Makefile      |    4 +-
 .../media/platform/visconti/hwd_viif_l1isp.c  | 2674 +++++++++++++++++
 .../media/platform/visconti/viif_controls.c   | 1153 +++++++
 drivers/media/platform/visconti/viif_isp.c    |    2 +
 4 files changed, 3831 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
 create mode 100644 drivers/media/platform/visconti/viif_controls.c

diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
index d7a23c1f4e8..13cf70ce309 100644
--- a/drivers/media/platform/visconti/Makefile
+++ b/drivers/media/platform/visconti/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Visconti video input device driver
 #
 
-visconti-viif-objs = viif.o viif_capture.o viif_isp.o
-visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
+visconti-viif-objs = viif.o viif_capture.o viif_controls.o viif_isp.o
+visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o hwd_viif_l1isp.o
 
 obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/visconti/hwd_viif_l1isp.c b/drivers/media/platform/visconti/hwd_viif_l1isp.c
new file mode 100644
index 00000000000..882eea92205
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_l1isp.c
@@ -0,0 +1,2674 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/io.h>
+#include "hwd_viif.h"
+#include "hwd_viif_internal.h"
+
+/**
+ * hwd_viif_l1_set_input_mode() - Configure L1ISP input mode.
+ *
+ * @mode: L1ISP preprocessing mode @ref hwd_viif_l1_input_mode
+ * @depth: input color depth (even only)
+ * - [8..24] in case of mode = #HWD_VIIF_L1_INPUT_HDR or #HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT
+ * - [8..14] in case of mode = #HWD_VIIF_L1_INPUT_PWL or #HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT
+ * - [8..12] in case of mode = #HWD_VIIF_L1_INPUT_SDR
+ * @raw_color_filter: RAW color filter array @ref hwd_viif_l1_raw_color_filter_mode
+ * @interpolation_order: interpolation order for input image
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "mode" is out of range
+ * - "depth" is out of range
+ * - "raw_color_filter" is out of range
+ * - "interpolation_order" is NULL in case of "mode" == #HWD_VIIF_L1_INPUT_SDR
+ * - "interpolation_order" is not NULL in case of "mode" != #HWD_VIIF_L1_INPUT_SDR
+ *
+ * Note that if 'mode' is not HWD_VIIF_L1_INPUT_SDR, NULL shall be set to 'interpolation_order'.
+ */
+s32 hwd_viif_l1_set_input_mode(struct hwd_viif_res *res, u32 mode, u32 depth, u32 raw_color_filter)
+{
+	u32 depth_max;
+
+	if (mode >= HWD_VIIF_L1_INPUT_MODE_NUM || mode == HWD_VIIF_L1_INPUT_SDR)
+		return -EINVAL;
+
+	if (mode == HWD_VIIF_L1_INPUT_PWL || mode == HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT)
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX;
+	else
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_MAX;
+
+	if (depth < HWD_VIIF_L1_INPUT_DEPTH_MIN || depth > depth_max || ((depth % 2U) != 0U) ||
+	    raw_color_filter >= HWD_VIIF_L1_RAW_MODE_NUM) {
+		return -EINVAL;
+	}
+
+	writel(mode, &res->capture_reg->l1isp.L1_SYSM_INPUT_MODE);
+	writel(depth, &res->capture_reg->l1isp.L1_IBUF_DEPTH);
+	writel(raw_color_filter, &res->capture_reg->l1isp.L1_SYSM_START_COLOR);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_rgb_to_y_coef() - Configure L1ISP RGB coefficients to calculate Y.
+ *
+ * @coef_r: R coefficient to calculate Y [256..65024] accuracy: 1/65536
+ * @coef_g: G coefficient to calculate Y [256..65024] accuracy: 1/65536
+ * @coef_b: B coefficient to calculate Y [256..65024] accuracy: 1/65536
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "coef_r" is out of range
+ * - "coef_g" is out of range
+ * - "coef_b" is out of range
+ *
+ * Note that it is possible that coef_r/g/b has rounding error when the value is set to HW register
+ */
+s32 hwd_viif_l1_set_rgb_to_y_coef(struct hwd_viif_res *res, u16 coef_r, u16 coef_g, u16 coef_b)
+{
+	if (coef_r < HWD_VIIF_L1_COEF_MIN || coef_r > HWD_VIIF_L1_COEF_MAX ||
+	    coef_g < HWD_VIIF_L1_COEF_MIN || coef_g > HWD_VIIF_L1_COEF_MAX ||
+	    coef_b < HWD_VIIF_L1_COEF_MIN || coef_b > HWD_VIIF_L1_COEF_MAX) {
+		return -EINVAL;
+	}
+
+	writel((u32)coef_r, &res->capture_reg->l1isp.L1_SYSM_YCOEF_R);
+	writel((u32)coef_g, &res->capture_reg->l1isp.L1_SYSM_YCOEF_G);
+	writel((u32)coef_b, &res->capture_reg->l1isp.L1_SYSM_YCOEF_B);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_ag_mode() - Configure L1ISP AG mode.
+ *
+ * @param: pointer to struct hwd_viif_l1_ag_mode
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each member of "param" is invalid
+ */
+s32 hwd_viif_l1_set_ag_mode(struct hwd_viif_res *res, const struct viif_l1_ag_mode_config *param)
+{
+	u32 val;
+
+	if (!param || param->sysm_ag_psel_hobc_high >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_hobc_middle_led >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_hobc_low >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_abpc_high >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_abpc_middle_led >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_abpc_low >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_rcnr_high >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_rcnr_middle_led >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_rcnr_low >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_ssel_lssc >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM ||
+	    param->sysm_ag_psel_lssc >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_ssel_mpro >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM ||
+	    param->sysm_ag_psel_mpro >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_ssel_vpro >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM ||
+	    param->sysm_ag_psel_vpro >= HWD_VIIF_L1_AG_ID_NUM ||
+	    (param->sysm_ag_cont_hobc_en_high != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_hobc_en_high != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_hobc_en_middle_led != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_hobc_en_middle_led != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_hobc_en_low != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_hobc_en_low != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_rcnr_en_high != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_rcnr_en_high != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_rcnr_en_middle_led != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_rcnr_en_middle_led != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_rcnr_en_low != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_rcnr_en_low != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_lssc_en != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_lssc_en != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_mpro_en != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_mpro_en != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_vpro_en != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_vpro_en != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_abpc_en_middle_led != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_abpc_en_middle_led != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_abpc_en_high != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_abpc_en_high != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_abpc_en_low != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_abpc_en_low != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	/* SYSM_AG_PARAM */
+	val = ((u32)param->sysm_ag_grad[0] << 16U) | ((u32)param->sysm_ag_ofst[0]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_A);
+	val = ((u32)param->sysm_ag_grad[1] << 16U) | ((u32)param->sysm_ag_ofst[1]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_B);
+	val = ((u32)param->sysm_ag_grad[2] << 16U) | ((u32)param->sysm_ag_ofst[2]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_C);
+	val = ((u32)param->sysm_ag_grad[3] << 16U) | ((u32)param->sysm_ag_ofst[3]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_D);
+
+	/* SYSM_AG_SEL */
+	val = ((u32)param->sysm_ag_psel_hobc_high << 6U) |
+	      ((u32)param->sysm_ag_psel_hobc_middle_led << 4U) |
+	      ((u32)param->sysm_ag_psel_hobc_low << 2U);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_HOBC);
+
+	val = ((u32)param->sysm_ag_psel_abpc_high << 6U) |
+	      ((u32)param->sysm_ag_psel_abpc_middle_led << 4U) |
+	      ((u32)param->sysm_ag_psel_abpc_low << 2U);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_ABPC);
+
+	val = ((u32)param->sysm_ag_psel_rcnr_high << 6U) |
+	      ((u32)param->sysm_ag_psel_rcnr_middle_led << 4U) |
+	      ((u32)param->sysm_ag_psel_rcnr_low << 2U);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_RCNR);
+
+	val = ((u32)param->sysm_ag_ssel_lssc << 2U) | ((u32)param->sysm_ag_psel_lssc);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_LSSC);
+
+	val = ((u32)param->sysm_ag_ssel_mpro << 2U) | ((u32)param->sysm_ag_psel_mpro);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_MPRO);
+
+	val = ((u32)param->sysm_ag_ssel_vpro << 2U) | ((u32)param->sysm_ag_psel_vpro);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_VPRO);
+
+	/* SYSM_AG_CONT */
+	val = (param->sysm_ag_cont_hobc_en_middle_led << 24U) |
+	      ((u32)(param->sysm_ag_cont_hobc_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_hobc_en_high << 8U) | (u32)param->sysm_ag_cont_hobc_test_high;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_HOBC01_EN);
+	val = (param->sysm_ag_cont_hobc_en_low << 8U) | (u32)param->sysm_ag_cont_hobc_test_low;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_HOBC2_EN);
+
+	val = (param->sysm_ag_cont_abpc_en_middle_led << 24U) |
+	      ((u32)(param->sysm_ag_cont_abpc_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_abpc_en_high << 8U) | (u32)param->sysm_ag_cont_abpc_test_high;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_ABPC01_EN);
+	val = (param->sysm_ag_cont_abpc_en_low << 8U) | (u32)param->sysm_ag_cont_abpc_test_low;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_ABPC2_EN);
+
+	val = (param->sysm_ag_cont_rcnr_en_middle_led << 24U) |
+	      ((u32)(param->sysm_ag_cont_rcnr_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_rcnr_en_high << 8U) | (u32)param->sysm_ag_cont_rcnr_test_high;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_RCNR01_EN);
+	val = (param->sysm_ag_cont_rcnr_en_low << 8U) | (u32)param->sysm_ag_cont_rcnr_test_low;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_RCNR2_EN);
+
+	val = (param->sysm_ag_cont_lssc_en << 8U) | (u32)param->sysm_ag_cont_lssc_test;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_LSSC_EN);
+
+	val = (param->sysm_ag_cont_mpro_en << 8U) | (u32)param->sysm_ag_cont_mpro_test;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_MPRO_EN);
+
+	val = (param->sysm_ag_cont_vpro_en << 8U) | (u32)param->sysm_ag_cont_vpro_test;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_VPRO_EN);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_ag() - Configure L1ISP analog gain.
+ *
+ * @gain_h: analog gain value for high sensitivity image [0..65535]
+ * @gain_m: analog gain value for middle sensitivity or led image [0..65535]
+ * @gain_l: analog gain value for low sensitivity image [0..65535]
+ * Return: 0 operation completed successfully
+ */
+s32 hwd_viif_l1_set_ag(struct hwd_viif_res *res, u16 gain_h, u16 gain_m, u16 gain_l)
+{
+	writel((u32)gain_h, &res->capture_reg->l1isp.L1_SYSM_AG_H);
+	writel((u32)gain_m, &res->capture_reg->l1isp.L1_SYSM_AG_M);
+	writel((u32)gain_l, &res->capture_reg->l1isp.L1_SYSM_AG_L);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdre() - Configure L1ISP HDR extension parameters.
+ *
+ * @param: pointer to struct hwd_viif_l1_hdre
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each member of "param" is invalid
+ */
+s32 hwd_viif_l1_set_hdre(struct hwd_viif_res *res, const struct viif_l1_hdre_config *param)
+{
+	u32 idx;
+
+	if (!param)
+		return -EINVAL;
+
+	for (idx = 0; idx < 16U; idx++) {
+		if (param->hdre_src_point[idx] > HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL)
+			return -EINVAL;
+	}
+
+	for (idx = 0; idx < 17U; idx++) {
+		if (param->hdre_dst_base[idx] > HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL ||
+		    param->hdre_ratio[idx] >= HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->hdre_dst_max_val > HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	writel(param->hdre_src_point[0], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT00);
+	writel(param->hdre_src_point[1], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT01);
+	writel(param->hdre_src_point[2], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT02);
+	writel(param->hdre_src_point[3], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT03);
+	writel(param->hdre_src_point[4], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT04);
+	writel(param->hdre_src_point[5], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT05);
+	writel(param->hdre_src_point[6], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT06);
+	writel(param->hdre_src_point[7], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT07);
+	writel(param->hdre_src_point[8], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT08);
+	writel(param->hdre_src_point[9], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT09);
+	writel(param->hdre_src_point[10], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT10);
+	writel(param->hdre_src_point[11], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT11);
+	writel(param->hdre_src_point[12], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT12);
+	writel(param->hdre_src_point[13], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT13);
+	writel(param->hdre_src_point[14], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT14);
+	writel(param->hdre_src_point[15], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT15);
+
+	writel(0, &res->capture_reg->l1isp.L1_HDRE_SRCBASE00);
+	writel(param->hdre_src_point[0], &res->capture_reg->l1isp.L1_HDRE_SRCBASE01);
+	writel(param->hdre_src_point[1], &res->capture_reg->l1isp.L1_HDRE_SRCBASE02);
+	writel(param->hdre_src_point[2], &res->capture_reg->l1isp.L1_HDRE_SRCBASE03);
+	writel(param->hdre_src_point[3], &res->capture_reg->l1isp.L1_HDRE_SRCBASE04);
+	writel(param->hdre_src_point[4], &res->capture_reg->l1isp.L1_HDRE_SRCBASE05);
+	writel(param->hdre_src_point[5], &res->capture_reg->l1isp.L1_HDRE_SRCBASE06);
+	writel(param->hdre_src_point[6], &res->capture_reg->l1isp.L1_HDRE_SRCBASE07);
+	writel(param->hdre_src_point[7], &res->capture_reg->l1isp.L1_HDRE_SRCBASE08);
+	writel(param->hdre_src_point[8], &res->capture_reg->l1isp.L1_HDRE_SRCBASE09);
+	writel(param->hdre_src_point[9], &res->capture_reg->l1isp.L1_HDRE_SRCBASE10);
+	writel(param->hdre_src_point[10], &res->capture_reg->l1isp.L1_HDRE_SRCBASE11);
+	writel(param->hdre_src_point[11], &res->capture_reg->l1isp.L1_HDRE_SRCBASE12);
+	writel(param->hdre_src_point[12], &res->capture_reg->l1isp.L1_HDRE_SRCBASE13);
+	writel(param->hdre_src_point[13], &res->capture_reg->l1isp.L1_HDRE_SRCBASE14);
+	writel(param->hdre_src_point[14], &res->capture_reg->l1isp.L1_HDRE_SRCBASE15);
+	writel(param->hdre_src_point[15], &res->capture_reg->l1isp.L1_HDRE_SRCBASE16);
+
+	writel(param->hdre_dst_base[0], &res->capture_reg->l1isp.L1_HDRE_DSTBASE00);
+	writel(param->hdre_dst_base[1], &res->capture_reg->l1isp.L1_HDRE_DSTBASE01);
+	writel(param->hdre_dst_base[2], &res->capture_reg->l1isp.L1_HDRE_DSTBASE02);
+	writel(param->hdre_dst_base[3], &res->capture_reg->l1isp.L1_HDRE_DSTBASE03);
+	writel(param->hdre_dst_base[4], &res->capture_reg->l1isp.L1_HDRE_DSTBASE04);
+	writel(param->hdre_dst_base[5], &res->capture_reg->l1isp.L1_HDRE_DSTBASE05);
+	writel(param->hdre_dst_base[6], &res->capture_reg->l1isp.L1_HDRE_DSTBASE06);
+	writel(param->hdre_dst_base[7], &res->capture_reg->l1isp.L1_HDRE_DSTBASE07);
+	writel(param->hdre_dst_base[8], &res->capture_reg->l1isp.L1_HDRE_DSTBASE08);
+	writel(param->hdre_dst_base[9], &res->capture_reg->l1isp.L1_HDRE_DSTBASE09);
+	writel(param->hdre_dst_base[10], &res->capture_reg->l1isp.L1_HDRE_DSTBASE10);
+	writel(param->hdre_dst_base[11], &res->capture_reg->l1isp.L1_HDRE_DSTBASE11);
+	writel(param->hdre_dst_base[12], &res->capture_reg->l1isp.L1_HDRE_DSTBASE12);
+	writel(param->hdre_dst_base[13], &res->capture_reg->l1isp.L1_HDRE_DSTBASE13);
+	writel(param->hdre_dst_base[14], &res->capture_reg->l1isp.L1_HDRE_DSTBASE14);
+	writel(param->hdre_dst_base[15], &res->capture_reg->l1isp.L1_HDRE_DSTBASE15);
+	writel(param->hdre_dst_base[16], &res->capture_reg->l1isp.L1_HDRE_DSTBASE16);
+
+	writel(param->hdre_ratio[0], &res->capture_reg->l1isp.L1_HDRE_RATIO00);
+	writel(param->hdre_ratio[1], &res->capture_reg->l1isp.L1_HDRE_RATIO01);
+	writel(param->hdre_ratio[2], &res->capture_reg->l1isp.L1_HDRE_RATIO02);
+	writel(param->hdre_ratio[3], &res->capture_reg->l1isp.L1_HDRE_RATIO03);
+	writel(param->hdre_ratio[4], &res->capture_reg->l1isp.L1_HDRE_RATIO04);
+	writel(param->hdre_ratio[5], &res->capture_reg->l1isp.L1_HDRE_RATIO05);
+	writel(param->hdre_ratio[6], &res->capture_reg->l1isp.L1_HDRE_RATIO06);
+	writel(param->hdre_ratio[7], &res->capture_reg->l1isp.L1_HDRE_RATIO07);
+	writel(param->hdre_ratio[8], &res->capture_reg->l1isp.L1_HDRE_RATIO08);
+	writel(param->hdre_ratio[9], &res->capture_reg->l1isp.L1_HDRE_RATIO09);
+	writel(param->hdre_ratio[10], &res->capture_reg->l1isp.L1_HDRE_RATIO10);
+	writel(param->hdre_ratio[11], &res->capture_reg->l1isp.L1_HDRE_RATIO11);
+	writel(param->hdre_ratio[12], &res->capture_reg->l1isp.L1_HDRE_RATIO12);
+	writel(param->hdre_ratio[13], &res->capture_reg->l1isp.L1_HDRE_RATIO13);
+	writel(param->hdre_ratio[14], &res->capture_reg->l1isp.L1_HDRE_RATIO14);
+	writel(param->hdre_ratio[15], &res->capture_reg->l1isp.L1_HDRE_RATIO15);
+	writel(param->hdre_ratio[16], &res->capture_reg->l1isp.L1_HDRE_RATIO16);
+
+	writel(param->hdre_dst_max_val, &res->capture_reg->l1isp.L1_HDRE_DSTMAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_img_extraction() - Configure L1ISP image extraction parameters.
+ *
+ * @input_black_gr: black level of Gr input pixel [0x0..0xffffff]
+ * @input_black_r: black level of R input pixel [0x0..0xffffff]
+ * @input_black_b: black level of B input pixel [0x0..0xffffff]
+ * @input_black_gb: black level of Gb input pixel [0x0..0xffffff]
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "input_black_gr" is out of range
+ * - "input_black_r" is out of range
+ * - "input_black_b" is out of range
+ * - "input_black_gb" is out of range
+ */
+s32 hwd_viif_l1_set_img_extraction(struct hwd_viif_res *res, u32 input_black_gr, u32 input_black_r,
+				   u32 input_black_b, u32 input_black_gb)
+{
+	if (input_black_gr > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL ||
+	    input_black_r > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL ||
+	    input_black_b > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL ||
+	    input_black_gb > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL) {
+		return -EINVAL;
+	}
+
+	writel(input_black_gr, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_GR);
+	writel(input_black_r, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_R);
+	writel(input_black_b, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_B);
+	writel(input_black_gb, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_GB);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_dpc() - Configure L1ISP defect pixel correction parameters.
+ *
+ * @param_h: pointer to defect pixel correction parameters for high sensitivity image
+ * @param_m: pointer to defect pixel correction parameters for middle sensitivity or led image
+ * @param_l: pointer to defect pixel correction parameters for low sensitivity image
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param_h", "param_m" and "param_l" are NULL
+ * - each member of "param_h" is invalid
+ * - each member of "param_m" is invalid
+ * - each member of "param_l" is invalid
+ */
+s32 hwd_viif_l1_set_dpc(struct hwd_viif_res *res, const struct viif_l1_dpc *param_h,
+			const struct viif_l1_dpc *param_m, const struct viif_l1_dpc *param_l)
+{
+	const struct viif_l1_dpc *param;
+	u32 idx;
+	u32 val;
+
+	if (!param_h && !param_m && !param_l)
+		return -EINVAL;
+
+	for (idx = 0U; idx < 3U; idx++) {
+		if (idx == 0U)
+			param = param_h;
+		else if (idx == 1U)
+			param = param_m;
+		else
+			param = param_l;
+
+		if (!param)
+			continue;
+
+		if ((param->abpc_sta_en != HWD_VIIF_ENABLE &&
+		     param->abpc_sta_en != HWD_VIIF_DISABLE) ||
+		    (param->abpc_dyn_en != HWD_VIIF_ENABLE &&
+		     param->abpc_dyn_en != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->abpc_dyn_en != HWD_VIIF_ENABLE)
+			continue;
+
+		if ((param->abpc_dyn_mode != HWD_VIIF_L1_DPC_1PIXEL &&
+		     param->abpc_dyn_mode != HWD_VIIF_L1_DPC_2PIXEL) ||
+		    param->abpc_ratio_limit > HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL ||
+		    param->abpc_dark_limit > HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL ||
+		    param->abpc_sn_coef_w_ag_min < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_min > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_mid < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_mid > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_max < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_max > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_min < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_min > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_mid < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_mid > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_max < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_max > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_th_min >= param->abpc_sn_coef_w_th_max ||
+		    param->abpc_sn_coef_b_th_min >= param->abpc_sn_coef_b_th_max) {
+			return -EINVAL;
+		}
+	}
+
+	val = 0;
+	if (param_h)
+		val |= param_h->abpc_sta_en << 24U;
+
+	if (param_m)
+		val |= param_m->abpc_sta_en << 16U;
+
+	if (param_l)
+		val |= param_l->abpc_sta_en << 8U;
+
+	writel(val, &res->capture_reg->l1isp.L1_ABPC012_STA_EN);
+
+	val = 0;
+	if (param_h)
+		val |= param_h->abpc_dyn_en << 24U;
+
+	if (param_m)
+		val |= param_m->abpc_dyn_en << 16U;
+
+	if (param_l)
+		val |= param_l->abpc_dyn_en << 8U;
+
+	writel(val, &res->capture_reg->l1isp.L1_ABPC012_DYN_EN);
+
+	val = 0;
+	if (param_h)
+		val |= param_h->abpc_dyn_mode << 24U;
+
+	if (param_m)
+		val |= param_m->abpc_dyn_mode << 16U;
+
+	if (param_l)
+		val |= param_l->abpc_dyn_mode << 8U;
+
+	writel(val, &res->capture_reg->l1isp.L1_ABPC012_DYN_MODE);
+
+	if (param_h) {
+		writel(param_h->abpc_ratio_limit, &res->capture_reg->l1isp.L1_ABPC0_RATIO_LIMIT);
+		writel(param_h->abpc_dark_limit, &res->capture_reg->l1isp.L1_ABPC0_DARK_LIMIT);
+		writel(param_h->abpc_sn_coef_w_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MIN);
+		writel(param_h->abpc_sn_coef_w_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MID);
+		writel(param_h->abpc_sn_coef_w_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MAX);
+		writel(param_h->abpc_sn_coef_b_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MIN);
+		writel(param_h->abpc_sn_coef_b_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MID);
+		writel(param_h->abpc_sn_coef_b_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MAX);
+		writel((u32)param_h->abpc_sn_coef_w_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_TH_MIN);
+		writel((u32)param_h->abpc_sn_coef_w_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_TH_MAX);
+		writel((u32)param_h->abpc_sn_coef_b_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_TH_MIN);
+		writel((u32)param_h->abpc_sn_coef_b_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_TH_MAX);
+	}
+
+	if (param_m) {
+		writel(param_m->abpc_ratio_limit, &res->capture_reg->l1isp.L1_ABPC1_RATIO_LIMIT);
+		writel(param_m->abpc_dark_limit, &res->capture_reg->l1isp.L1_ABPC1_DARK_LIMIT);
+		writel(param_m->abpc_sn_coef_w_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MIN);
+		writel(param_m->abpc_sn_coef_w_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MID);
+		writel(param_m->abpc_sn_coef_w_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MAX);
+		writel(param_m->abpc_sn_coef_b_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MIN);
+		writel(param_m->abpc_sn_coef_b_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MID);
+		writel(param_m->abpc_sn_coef_b_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MAX);
+		writel((u32)param_m->abpc_sn_coef_w_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_TH_MIN);
+		writel((u32)param_m->abpc_sn_coef_w_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_TH_MAX);
+		writel((u32)param_m->abpc_sn_coef_b_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_TH_MIN);
+		writel((u32)param_m->abpc_sn_coef_b_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_TH_MAX);
+	}
+
+	if (param_l) {
+		writel(param_l->abpc_ratio_limit, &res->capture_reg->l1isp.L1_ABPC2_RATIO_LIMIT);
+		writel(param_l->abpc_dark_limit, &res->capture_reg->l1isp.L1_ABPC2_DARK_LIMIT);
+		writel(param_l->abpc_sn_coef_w_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MIN);
+		writel(param_l->abpc_sn_coef_w_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MID);
+		writel(param_l->abpc_sn_coef_w_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MAX);
+		writel(param_l->abpc_sn_coef_b_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MIN);
+		writel(param_l->abpc_sn_coef_b_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MID);
+		writel(param_l->abpc_sn_coef_b_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MAX);
+		writel((u32)param_l->abpc_sn_coef_w_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_TH_MIN);
+		writel((u32)param_l->abpc_sn_coef_w_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_TH_MAX);
+		writel((u32)param_l->abpc_sn_coef_b_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_TH_MIN);
+		writel((u32)param_l->abpc_sn_coef_b_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_TH_MAX);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_dpc_table_transmission() -
+ *  Configure L1ISP transferring defect pixel correction table.
+ *
+ * @table_h: defect pixel correction table for high sensitivity image(physical address)
+ * @table_m: defect pixel correction table for middle sensitivity or led image(physical address)
+ * @table_l: defect pixel correction table for low sensitivity image(physical address)
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "table_h", "table_m" or "table_l" is not 8byte alignment
+ *
+ * Note that when 0 is set to table address, table transfer of the table is disabled.
+ */
+s32 hwd_viif_l1_set_dpc_table_transmission(struct hwd_viif_res *res, uintptr_t table_h,
+					   uintptr_t table_m, uintptr_t table_l)
+{
+	u32 val = 0x0U;
+
+	if (((table_h % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_m % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_l % HWD_VIIF_L1_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+
+	/* VDM common settings */
+
+	writel(HWD_VIIF_L1_VDM_CFG_PARAM, &res->capture_reg->vdm.t_group[0].VDM_T_CFG);
+	writel(HWD_VIIF_L1_VDM_SRAM_BASE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_BASE);
+	writel(HWD_VIIF_L1_VDM_SRAM_SIZE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_SIZE);
+
+	if (table_h != 0U) {
+		writel((u32)table_h, &res->capture_reg->vdm.t_port[0].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE, &res->capture_reg->vdm.t_port[0].VDM_T_SIZE);
+		val |= 0x1U;
+	}
+
+	if (table_m != 0U) {
+		writel((u32)table_m, &res->capture_reg->vdm.t_port[1].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE, &res->capture_reg->vdm.t_port[1].VDM_T_SIZE);
+		val |= 0x2U;
+	}
+
+	if (table_l != 0U) {
+		writel((u32)table_l, &res->capture_reg->vdm.t_port[2].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE, &res->capture_reg->vdm.t_port[2].VDM_T_SIZE);
+		val |= 0x4U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & 0xfffffff8U);
+	writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_preset_white_balance() - Configure L1ISP preset white balance parameters.
+ *
+ * @dstmaxval: maximum output pixel value [0..4095]
+ * @param_h: pointer to preset white balance parameters for high sensitivity image
+ * @param_m: pointer to preset white balance parameters for middle sensitivity or led image
+ * @param_l: pointer to preset white balance parameters for low sensitivity image
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "dstmaxval" is out of range
+ * - "param_h", "param_m", and "param_l" are NULL
+ * - each parameter of "param_h" is out of range
+ * - each parameter of "param_m" is out of range
+ * - each parameter of "param_l" is out of range
+ * Note that when NULL is set to "param_{h/m/l}", the corresponding parameters are not set to HW.
+ */
+s32 hwd_viif_l1_set_preset_white_balance(struct hwd_viif_res *res, u32 dstmaxval,
+					 const struct viif_l1_preset_wb *param_h,
+					 const struct viif_l1_preset_wb *param_m,
+					 const struct viif_l1_preset_wb *param_l)
+{
+	if (dstmaxval > HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL || (!param_h && !param_m && !param_l))
+		return -EINVAL;
+
+	if (param_h) {
+		if (param_h->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_h->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_h->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_h->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	if (param_m) {
+		if (param_m->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_m->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_m->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_m->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	if (param_l) {
+		if (param_l->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_l->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_l->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_l->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	writel(dstmaxval, &res->capture_reg->l1isp.L1_PWHB_DSTMAXVAL);
+
+	if (param_h) {
+		writel(param_h->gain_gr, &res->capture_reg->l1isp.L1_PWHB_H_GR);
+		writel(param_h->gain_r, &res->capture_reg->l1isp.L1_PWHB_HR);
+		writel(param_h->gain_b, &res->capture_reg->l1isp.L1_PWHB_HB);
+		writel(param_h->gain_gb, &res->capture_reg->l1isp.L1_PWHB_H_GB);
+	}
+
+	if (param_m) {
+		writel(param_m->gain_gr, &res->capture_reg->l1isp.L1_PWHB_M_GR);
+		writel(param_m->gain_r, &res->capture_reg->l1isp.L1_PWHB_MR);
+		writel(param_m->gain_b, &res->capture_reg->l1isp.L1_PWHB_MB);
+		writel(param_m->gain_gb, &res->capture_reg->l1isp.L1_PWHB_M_GB);
+	}
+
+	if (param_l) {
+		writel(param_l->gain_gr, &res->capture_reg->l1isp.L1_PWHB_L_GR);
+		writel(param_l->gain_r, &res->capture_reg->l1isp.L1_PWHB_LR);
+		writel(param_l->gain_b, &res->capture_reg->l1isp.L1_PWHB_LB);
+		writel(param_l->gain_gb, &res->capture_reg->l1isp.L1_PWHB_L_GB);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_raw_color_noise_reduction() -
+ *  Configure L1ISP raw color noise reduction parameters.
+ *
+ * @param_h: pointer to raw color noise reduction parameters for high sensitivity image
+ * @param_m: pointer to raw color noise reduction parameters for middle sensitivity or led image
+ * @param_l: pointer to raw color noise reduction parameters for low sensitivity image
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param_h", "param_m", and "param_l" are NULL
+ * - each parameter of "param_h" is out of range
+ * - each parameter of "param_m" is out of range
+ * - each parameter of "param_l" is out of range
+ * Note that when NULL is set to "param_{h/m/l}", the corresponding parameters are not set to HW.
+ */
+s32 hwd_viif_l1_set_raw_color_noise_reduction(
+	struct hwd_viif_res *res, const struct viif_l1_raw_color_noise_reduction *param_h,
+	const struct viif_l1_raw_color_noise_reduction *param_m,
+	const struct viif_l1_raw_color_noise_reduction *param_l)
+{
+	const struct viif_l1_raw_color_noise_reduction *param;
+	u32 idx;
+
+	if (!param_h && !param_m && !param_l)
+		return -EINVAL;
+
+	for (idx = 0; idx < 3U; idx++) {
+		if (idx == 0U)
+			param = param_h;
+		else if (idx == 1U)
+			param = param_m;
+		else
+			param = param_l;
+
+		if (!param)
+			continue;
+
+		if (param->rcnr_sw != HWD_VIIF_ENABLE && param->rcnr_sw != HWD_VIIF_DISABLE)
+			return -EINVAL;
+
+		if (param->rcnr_cnf_dark_ag0 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_dark_ag1 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_dark_ag2 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_ratio_ag0 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_ratio_ag1 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_ratio_ag2 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_clip_gain_r > HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL ||
+		    param->rcnr_cnf_clip_gain_g > HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL ||
+		    param->rcnr_cnf_clip_gain_b > HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL ||
+		    param->rcnr_a1l_dark_ag0 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_dark_ag1 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_dark_ag2 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_ratio_ag0 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_ratio_ag1 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_ratio_ag2 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_inf_zero_clip > HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL ||
+		    param->rcnr_merge_d2blend_ag0 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL ||
+		    param->rcnr_merge_d2blend_ag1 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL ||
+		    param->rcnr_merge_d2blend_ag2 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL ||
+		    param->rcnr_merge_black > HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL ||
+		    param->rcnr_merge_mindiv < HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL ||
+		    param->rcnr_merge_mindiv > HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL) {
+			return -EINVAL;
+		}
+
+		switch (param->rcnr_hry_type) {
+		case HWD_VIIF_L1_RCNR_LOW_RESOLUTION:
+		case HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION:
+		case HWD_VIIF_L1_RCNR_HIGH_RESOLUTION:
+		case HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 &&
+		    param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 &&
+		    param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64) {
+			return -EINVAL;
+		}
+		if (param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 &&
+		    param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 &&
+		    param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64) {
+			return -EINVAL;
+		}
+		if (param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 &&
+		    param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 &&
+		    param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64) {
+			return -EINVAL;
+		}
+
+		if (param->rcnr_lpf_threshold >= HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL ||
+		    param->rcnr_merge_hlblend_ag0 > HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL ||
+		    param->rcnr_merge_hlblend_ag1 > HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL ||
+		    param->rcnr_merge_hlblend_ag2 > HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL ||
+		    (param->rcnr_gnr_sw != HWD_VIIF_DISABLE &&
+		     param->rcnr_gnr_sw != HWD_VIIF_ENABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			if (param->rcnr_gnr_ratio > HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO)
+				return -EINVAL;
+			if (param->rcnr_gnr_wide_en != HWD_VIIF_DISABLE &&
+			    param->rcnr_gnr_wide_en != HWD_VIIF_ENABLE) {
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param_h) {
+		writel(param_h->rcnr_sw, &res->capture_reg->l1isp.L1_RCNR0_SW);
+
+		writel(param_h->rcnr_cnf_dark_ag0, &res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG0);
+		writel(param_h->rcnr_cnf_dark_ag1, &res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG1);
+		writel(param_h->rcnr_cnf_dark_ag2, &res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG2);
+
+		writel(param_h->rcnr_cnf_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG0);
+		writel(param_h->rcnr_cnf_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG1);
+		writel(param_h->rcnr_cnf_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG2);
+
+		writel(param_h->rcnr_cnf_clip_gain_r,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_R);
+		writel(param_h->rcnr_cnf_clip_gain_g,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_G);
+		writel(param_h->rcnr_cnf_clip_gain_b,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_B);
+
+		writel(param_h->rcnr_a1l_dark_ag0, &res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG0);
+		writel(param_h->rcnr_a1l_dark_ag1, &res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG1);
+		writel(param_h->rcnr_a1l_dark_ag2, &res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG2);
+
+		writel(param_h->rcnr_a1l_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG0);
+		writel(param_h->rcnr_a1l_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG1);
+		writel(param_h->rcnr_a1l_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG2);
+
+		writel(param_h->rcnr_inf_zero_clip,
+		       &res->capture_reg->l1isp.L1_RCNR0_INF_ZERO_CLIP);
+
+		writel(param_h->rcnr_merge_d2blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG0);
+		writel(param_h->rcnr_merge_d2blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG1);
+		writel(param_h->rcnr_merge_d2blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG2);
+		writel(param_h->rcnr_merge_black, &res->capture_reg->l1isp.L1_RCNR0_MERGE_BLACK);
+		writel(param_h->rcnr_merge_mindiv, &res->capture_reg->l1isp.L1_RCNR0_MERGE_MINDIV);
+
+		writel(param_h->rcnr_hry_type, &res->capture_reg->l1isp.L1_RCNR0_HRY_TYPE);
+
+		writel(param_h->rcnr_anf_blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG0);
+		writel(param_h->rcnr_anf_blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG1);
+		writel(param_h->rcnr_anf_blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG2);
+
+		writel(param_h->rcnr_lpf_threshold,
+		       &res->capture_reg->l1isp.L1_RCNR0_LPF_THRESHOLD);
+
+		writel(param_h->rcnr_merge_hlblend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG0);
+		writel(param_h->rcnr_merge_hlblend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG1);
+		writel(param_h->rcnr_merge_hlblend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG2);
+
+		writel(param_h->rcnr_gnr_sw, &res->capture_reg->l1isp.L1_RCNR0_GNR_SW);
+
+		if (param_h->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_h->rcnr_gnr_ratio,
+			       &res->capture_reg->l1isp.L1_RCNR0_GNR_RATIO);
+			writel(param_h->rcnr_gnr_wide_en,
+			       &res->capture_reg->l1isp.L1_RCNR0_GNR_WIDE_EN);
+		}
+	}
+
+	if (param_m) {
+		writel(param_m->rcnr_sw, &res->capture_reg->l1isp.L1_RCNR1_SW);
+
+		writel(param_m->rcnr_cnf_dark_ag0, &res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG0);
+		writel(param_m->rcnr_cnf_dark_ag1, &res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG1);
+		writel(param_m->rcnr_cnf_dark_ag2, &res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG2);
+
+		writel(param_m->rcnr_cnf_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG0);
+		writel(param_m->rcnr_cnf_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG1);
+		writel(param_m->rcnr_cnf_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG2);
+
+		writel(param_m->rcnr_cnf_clip_gain_r,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_R);
+		writel(param_m->rcnr_cnf_clip_gain_g,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_G);
+		writel(param_m->rcnr_cnf_clip_gain_b,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_B);
+
+		writel(param_m->rcnr_a1l_dark_ag0, &res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG0);
+		writel(param_m->rcnr_a1l_dark_ag1, &res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG1);
+		writel(param_m->rcnr_a1l_dark_ag2, &res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG2);
+
+		writel(param_m->rcnr_a1l_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG0);
+		writel(param_m->rcnr_a1l_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG1);
+		writel(param_m->rcnr_a1l_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG2);
+
+		writel(param_m->rcnr_inf_zero_clip,
+		       &res->capture_reg->l1isp.L1_RCNR1_INF_ZERO_CLIP);
+
+		writel(param_m->rcnr_merge_d2blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG0);
+		writel(param_m->rcnr_merge_d2blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG1);
+		writel(param_m->rcnr_merge_d2blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG2);
+		writel(param_m->rcnr_merge_black, &res->capture_reg->l1isp.L1_RCNR1_MERGE_BLACK);
+		writel(param_m->rcnr_merge_mindiv, &res->capture_reg->l1isp.L1_RCNR1_MERGE_MINDIV);
+
+		writel(param_m->rcnr_hry_type, &res->capture_reg->l1isp.L1_RCNR1_HRY_TYPE);
+
+		writel(param_m->rcnr_anf_blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG0);
+		writel(param_m->rcnr_anf_blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG1);
+		writel(param_m->rcnr_anf_blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG2);
+
+		writel(param_m->rcnr_lpf_threshold,
+		       &res->capture_reg->l1isp.L1_RCNR1_LPF_THRESHOLD);
+
+		writel(param_m->rcnr_merge_hlblend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG0);
+		writel(param_m->rcnr_merge_hlblend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG1);
+		writel(param_m->rcnr_merge_hlblend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG2);
+
+		writel(param_m->rcnr_gnr_sw, &res->capture_reg->l1isp.L1_RCNR1_GNR_SW);
+
+		if (param_m->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_m->rcnr_gnr_ratio,
+			       &res->capture_reg->l1isp.L1_RCNR1_GNR_RATIO);
+			writel(param_m->rcnr_gnr_wide_en,
+			       &res->capture_reg->l1isp.L1_RCNR1_GNR_WIDE_EN);
+		}
+	}
+
+	if (param_l) {
+		writel(param_l->rcnr_sw, &res->capture_reg->l1isp.L1_RCNR2_SW);
+
+		writel(param_l->rcnr_cnf_dark_ag0, &res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG0);
+		writel(param_l->rcnr_cnf_dark_ag1, &res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG1);
+		writel(param_l->rcnr_cnf_dark_ag2, &res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG2);
+
+		writel(param_l->rcnr_cnf_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG0);
+		writel(param_l->rcnr_cnf_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG1);
+		writel(param_l->rcnr_cnf_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG2);
+
+		writel(param_l->rcnr_cnf_clip_gain_r,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_R);
+		writel(param_l->rcnr_cnf_clip_gain_g,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_G);
+		writel(param_l->rcnr_cnf_clip_gain_b,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_B);
+
+		writel(param_l->rcnr_a1l_dark_ag0, &res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG0);
+		writel(param_l->rcnr_a1l_dark_ag1, &res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG1);
+		writel(param_l->rcnr_a1l_dark_ag2, &res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG2);
+
+		writel(param_l->rcnr_a1l_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG0);
+		writel(param_l->rcnr_a1l_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG1);
+		writel(param_l->rcnr_a1l_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG2);
+
+		writel(param_l->rcnr_inf_zero_clip,
+		       &res->capture_reg->l1isp.L1_RCNR2_INF_ZERO_CLIP);
+
+		writel(param_l->rcnr_merge_d2blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG0);
+		writel(param_l->rcnr_merge_d2blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG1);
+		writel(param_l->rcnr_merge_d2blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG2);
+		writel(param_l->rcnr_merge_black, &res->capture_reg->l1isp.L1_RCNR2_MERGE_BLACK);
+		writel(param_l->rcnr_merge_mindiv, &res->capture_reg->l1isp.L1_RCNR2_MERGE_MINDIV);
+
+		writel(param_l->rcnr_hry_type, &res->capture_reg->l1isp.L1_RCNR2_HRY_TYPE);
+
+		writel(param_l->rcnr_anf_blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG0);
+		writel(param_l->rcnr_anf_blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG1);
+		writel(param_l->rcnr_anf_blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG2);
+
+		writel(param_l->rcnr_lpf_threshold,
+		       &res->capture_reg->l1isp.L1_RCNR2_LPF_THRESHOLD);
+
+		writel(param_l->rcnr_merge_hlblend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG0);
+		writel(param_l->rcnr_merge_hlblend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG1);
+		writel(param_l->rcnr_merge_hlblend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG2);
+
+		writel(param_l->rcnr_gnr_sw, &res->capture_reg->l1isp.L1_RCNR2_GNR_SW);
+
+		if (param_l->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_l->rcnr_gnr_ratio,
+			       &res->capture_reg->l1isp.L1_RCNR2_GNR_RATIO);
+			writel(param_l->rcnr_gnr_wide_en,
+			       &res->capture_reg->l1isp.L1_RCNR2_GNR_WIDE_EN);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdrs() - Configure L1ISP HDR synthesis parameters.
+ *
+ * @param: pointer to HDR synthesis parameters
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_hdrs(struct hwd_viif_res *res, const struct viif_l1_hdrs_config *param)
+{
+	if (!param ||
+	    (param->hdrs_hdr_mode != HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE &&
+	     param->hdrs_hdr_mode != HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE) ||
+	    param->hdrs_hdr_ratio_m < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_m > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_l < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_l > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_e < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_e > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO ||
+	    param->hdrs_dg_h >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_dg_m >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_dg_l >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_dg_e >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_blendend_h > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendend_m > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendend_e > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendbeg_h > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendbeg_m > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendbeg_e > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    (param->hdrs_led_mode_on != HWD_VIIF_ENABLE &&
+	     param->hdrs_led_mode_on != HWD_VIIF_DISABLE) ||
+	    param->hdrs_dst_max_val > HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL) {
+		return -EINVAL;
+	}
+
+	writel(param->hdrs_hdr_mode, &res->capture_reg->l1isp.L1_HDRS_HDRMODE);
+
+	writel(param->hdrs_hdr_ratio_m, &res->capture_reg->l1isp.L1_HDRS_HDRRATIO_M);
+	writel(param->hdrs_hdr_ratio_l, &res->capture_reg->l1isp.L1_HDRS_HDRRATIO_L);
+	writel(param->hdrs_hdr_ratio_e, &res->capture_reg->l1isp.L1_HDRS_HDRRATIO_E);
+
+	writel(param->hdrs_dg_h, &res->capture_reg->l1isp.L1_HDRS_DG_H);
+	writel(param->hdrs_dg_m, &res->capture_reg->l1isp.L1_HDRS_DG_M);
+	writel(param->hdrs_dg_l, &res->capture_reg->l1isp.L1_HDRS_DG_L);
+	writel(param->hdrs_dg_e, &res->capture_reg->l1isp.L1_HDRS_DG_E);
+
+	writel(param->hdrs_blendend_h, &res->capture_reg->l1isp.L1_HDRS_BLENDEND_H);
+	writel(param->hdrs_blendend_m, &res->capture_reg->l1isp.L1_HDRS_BLENDEND_M);
+	writel(param->hdrs_blendend_e, &res->capture_reg->l1isp.L1_HDRS_BLENDEND_E);
+
+	writel(param->hdrs_blendbeg_h, &res->capture_reg->l1isp.L1_HDRS_BLENDBEG_H);
+	writel(param->hdrs_blendbeg_m, &res->capture_reg->l1isp.L1_HDRS_BLENDBEG_M);
+	writel(param->hdrs_blendbeg_e, &res->capture_reg->l1isp.L1_HDRS_BLENDBEG_E);
+
+	writel(param->hdrs_led_mode_on, &res->capture_reg->l1isp.L1_HDRS_LEDMODE_ON);
+	writel(param->hdrs_dst_max_val, &res->capture_reg->l1isp.L1_HDRS_DSTMAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_black_level_correction() - Configure L1ISP black level correction parameters.
+ *
+ * @param: pointer to black level correction parameters
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_black_level_correction(
+	struct hwd_viif_res *res, const struct viif_l1_black_level_correction_config *param)
+{
+	if (!param || param->srcblacklevel_gr > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->srcblacklevel_r > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->srcblacklevel_b > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->srcblacklevel_gb > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->mulval_gr >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->mulval_r >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->mulval_b >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->mulval_gb >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->dstmaxval > HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL) {
+		return -EINVAL;
+	}
+
+	writel(param->srcblacklevel_gr, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVEL_GR);
+	writel(param->srcblacklevel_r, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVEL_R);
+	writel(param->srcblacklevel_b, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVEL_B);
+	writel(param->srcblacklevel_gb, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVELGB);
+
+	writel(param->mulval_gr, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_GR);
+	writel(param->mulval_r, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_R);
+	writel(param->mulval_b, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_B);
+	writel(param->mulval_gb, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_GB);
+
+	writel(param->dstmaxval, &res->capture_reg->l1isp.L1_BLVC_DSTMAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_lsc() - Configure L1ISP lens shading correction parameters.
+ *
+ * @param: pointer to lens shading correction parameters
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ * @note when NULL is set to "param"
+ */
+s32 hwd_viif_l1_set_lsc(struct hwd_viif_res *res, const struct hwd_viif_l1_lsc *param)
+{
+	u32 sysm_width, sysm_height;
+	u32 grid_h_size = 0U;
+	u32 grid_v_size = 0U;
+	s32 ret = 0;
+	u32 idx;
+	u32 val;
+	u32 tmp;
+
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_LSSC_EN);
+		return 0;
+	}
+
+	sysm_width = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+	sysm_height = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+
+	if (param->lssc_parabola_param) {
+		if (param->lssc_parabola_param->lssc_para_h_center >= sysm_width ||
+		    param->lssc_parabola_param->lssc_para_v_center >= sysm_height ||
+		    param->lssc_parabola_param->lssc_para_h_gain >= HWD_VIIF_LSC_MAX_GAIN ||
+		    param->lssc_parabola_param->lssc_para_v_gain >= HWD_VIIF_LSC_MAX_GAIN) {
+			return -EINVAL;
+		}
+
+		switch (param->lssc_parabola_param->lssc_para_mgsel2) {
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (param->lssc_parabola_param->lssc_para_mgsel4) {
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		for (idx = 0U; idx < 8U; idx++) {
+			const struct viif_l1_lsc_parabola_ag_param *ag_param;
+
+			switch (idx) {
+			case 0U:
+				ag_param = &param->lssc_parabola_param->r_2d;
+				break;
+			case 1U:
+				ag_param = &param->lssc_parabola_param->r_4d;
+				break;
+			case 2U:
+				ag_param = &param->lssc_parabola_param->gr_2d;
+				break;
+			case 3U:
+				ag_param = &param->lssc_parabola_param->gr_4d;
+				break;
+			case 4U:
+				ag_param = &param->lssc_parabola_param->gb_2d;
+				break;
+			case 5U:
+				ag_param = &param->lssc_parabola_param->gb_4d;
+				break;
+			case 6U:
+				ag_param = &param->lssc_parabola_param->b_2d;
+				break;
+			default:
+				ag_param = &param->lssc_parabola_param->b_4d;
+				break;
+			}
+
+			if (!ag_param || ag_param->lssc_paracoef_h_l_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_l_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_l_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_l_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_l_min > ag_param->lssc_paracoef_h_l_max ||
+			    ag_param->lssc_paracoef_h_r_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_r_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_r_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_r_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_r_min > ag_param->lssc_paracoef_h_r_max ||
+			    ag_param->lssc_paracoef_v_u_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_u_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_u_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_u_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_u_min > ag_param->lssc_paracoef_v_u_max ||
+			    ag_param->lssc_paracoef_v_d_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_d_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_d_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_d_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_d_min > ag_param->lssc_paracoef_v_d_max ||
+			    ag_param->lssc_paracoef_hv_lu_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_min > ag_param->lssc_paracoef_hv_lu_max ||
+			    ag_param->lssc_paracoef_hv_ru_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_min > ag_param->lssc_paracoef_hv_ru_max ||
+			    ag_param->lssc_paracoef_hv_ld_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_min > ag_param->lssc_paracoef_hv_ld_max ||
+			    ag_param->lssc_paracoef_hv_rd_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_min > ag_param->lssc_paracoef_hv_rd_max) {
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param->lssc_grid_param) {
+		switch (param->lssc_grid_param->lssc_grid_h_size) {
+		case 32U:
+			grid_h_size = 5U;
+			break;
+		case 64U:
+			grid_h_size = 6U;
+			break;
+		case 128U:
+			grid_h_size = 7U;
+			break;
+		case 256U:
+			grid_h_size = 8U;
+			break;
+		case 512U:
+			grid_h_size = 9U;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret != 0)
+			return ret;
+
+		switch (param->lssc_grid_param->lssc_grid_v_size) {
+		case 32U:
+			grid_v_size = 5U;
+			break;
+		case 64U:
+			grid_v_size = 6U;
+			break;
+		case 128U:
+			grid_v_size = 7U;
+			break;
+		case 256U:
+			grid_v_size = 8U;
+			break;
+		case 512U:
+			grid_v_size = 9U;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret != 0)
+			return ret;
+
+		if (param->lssc_grid_param->lssc_grid_h_center < HWD_VIIF_LSC_GRID_MIN_COORDINATE ||
+		    param->lssc_grid_param->lssc_grid_h_center >
+			    param->lssc_grid_param->lssc_grid_h_size) {
+			return -EINVAL;
+		}
+
+		if (sysm_width > (param->lssc_grid_param->lssc_grid_h_center +
+				  (param->lssc_grid_param->lssc_grid_h_size * 31U))) {
+			return -EINVAL;
+		}
+
+		if (param->lssc_grid_param->lssc_grid_v_center < HWD_VIIF_LSC_GRID_MIN_COORDINATE ||
+		    param->lssc_grid_param->lssc_grid_v_center >
+			    param->lssc_grid_param->lssc_grid_v_size) {
+			return -EINVAL;
+		}
+
+		if (sysm_height > (param->lssc_grid_param->lssc_grid_v_center +
+				   (param->lssc_grid_param->lssc_grid_v_size * 23U))) {
+			return -EINVAL;
+		}
+
+		if (param->lssc_grid_param->lssc_grid_mgsel != HWD_VIIF_L1_GRID_COEF_GAIN_X1 &&
+		    param->lssc_grid_param->lssc_grid_mgsel != HWD_VIIF_L1_GRID_COEF_GAIN_X2) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->lssc_pwhb_r_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_r_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_r_gain_min > param->lssc_pwhb_r_gain_max ||
+	    param->lssc_pwhb_gr_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gr_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gr_gain_min > param->lssc_pwhb_gr_gain_max ||
+	    param->lssc_pwhb_gb_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gb_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gb_gain_min > param->lssc_pwhb_gb_gain_max ||
+	    param->lssc_pwhb_b_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_b_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_b_gain_min > param->lssc_pwhb_b_gain_max) {
+		return -EINVAL;
+	}
+
+	/* parabola shading */
+	if (param->lssc_parabola_param) {
+		struct viif_l1_lsc_parabola_ag_param *r_2d;
+		struct viif_l1_lsc_parabola_ag_param *r_4d;
+		struct viif_l1_lsc_parabola_ag_param *gr_2d;
+		struct viif_l1_lsc_parabola_ag_param *gr_4d;
+		struct viif_l1_lsc_parabola_ag_param *gb_2d;
+		struct viif_l1_lsc_parabola_ag_param *gb_4d;
+		struct viif_l1_lsc_parabola_ag_param *b_2d;
+		struct viif_l1_lsc_parabola_ag_param *b_4d;
+
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_LSSC_PARA_EN);
+
+		writel(param->lssc_parabola_param->lssc_para_h_center,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_H_CENTER);
+		writel(param->lssc_parabola_param->lssc_para_v_center,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_V_CENTER);
+
+		writel(param->lssc_parabola_param->lssc_para_h_gain,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_H_GAIN);
+		writel(param->lssc_parabola_param->lssc_para_v_gain,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_V_GAIN);
+
+		writel(param->lssc_parabola_param->lssc_para_mgsel2,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_MGSEL2);
+		writel(param->lssc_parabola_param->lssc_para_mgsel4,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_MGSEL4);
+
+		/* R 2D */
+		r_2d = &param->lssc_parabola_param->r_2d;
+		tmp = (u32)r_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_H_L);
+
+		tmp = (u32)r_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_H_R);
+
+		tmp = (u32)r_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_V_U);
+
+		tmp = (u32)r_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_V_D);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_LU);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_RU);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_LD);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_RD);
+
+		/* R 4D */
+		r_4d = &param->lssc_parabola_param->r_4d;
+		tmp = (u32)r_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_H_L);
+
+		tmp = (u32)r_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_H_R);
+
+		tmp = (u32)r_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_V_U);
+
+		tmp = (u32)r_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_V_D);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_LU);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_RU);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_LD);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_RD);
+
+		/* GR 2D */
+		gr_2d = &param->lssc_parabola_param->gr_2d;
+		tmp = (u32)gr_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_H_L);
+
+		tmp = (u32)gr_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_H_R);
+
+		tmp = (u32)gr_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_V_U);
+
+		tmp = (u32)gr_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_V_D);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_LU);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_RU);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_LD);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_RD);
+
+		/* GR 4D */
+		gr_4d = &param->lssc_parabola_param->gr_4d;
+		tmp = (u32)gr_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_H_L);
+
+		tmp = (u32)gr_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_H_R);
+
+		tmp = (u32)gr_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_V_U);
+
+		tmp = (u32)gr_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_V_D);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_LU);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_RU);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_LD);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_RD);
+
+		/* GB 2D */
+		gb_2d = &param->lssc_parabola_param->gb_2d;
+		tmp = (u32)gb_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_H_L);
+
+		tmp = (u32)gb_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_H_R);
+
+		tmp = (u32)gb_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_V_U);
+
+		tmp = (u32)gb_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_V_D);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_LU);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_RU);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_LD);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_RD);
+
+		/* GB 4D */
+		gb_4d = &param->lssc_parabola_param->gb_4d;
+		tmp = (u32)gb_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_H_L);
+
+		tmp = (u32)gb_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_H_R);
+
+		tmp = (u32)gb_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_V_U);
+
+		tmp = (u32)gb_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_V_D);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_LU);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_RU);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_LD);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_RD);
+
+		/* B 2D */
+		b_2d = &param->lssc_parabola_param->b_2d;
+		tmp = (u32)b_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_H_L);
+
+		tmp = (u32)b_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_H_R);
+
+		tmp = (u32)b_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_V_U);
+
+		tmp = (u32)b_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_V_D);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_LU);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_RU);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_LD);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_RD);
+
+		/* B 4D */
+		b_4d = &param->lssc_parabola_param->b_4d;
+		tmp = (u32)b_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_H_L);
+
+		tmp = (u32)b_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_H_R);
+
+		tmp = (u32)b_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_V_U);
+
+		tmp = (u32)b_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_V_D);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_LU);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_RU);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_LD);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_RD);
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_LSSC_PARA_EN);
+	}
+
+	/* grid shading */
+	if (param->lssc_grid_param) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_LSSC_GRID_EN);
+		writel(grid_h_size, &res->capture_reg->l1isp.L1_LSSC_GRID_H_SIZE);
+		writel(grid_v_size, &res->capture_reg->l1isp.L1_LSSC_GRID_V_SIZE);
+		writel(param->lssc_grid_param->lssc_grid_h_center,
+		       &res->capture_reg->l1isp.L1_LSSC_GRID_H_CENTER);
+		writel(param->lssc_grid_param->lssc_grid_v_center,
+		       &res->capture_reg->l1isp.L1_LSSC_GRID_V_CENTER);
+		writel(param->lssc_grid_param->lssc_grid_mgsel,
+		       &res->capture_reg->l1isp.L1_LSSC_GRID_MGSEL);
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_LSSC_GRID_EN);
+	}
+
+	/* preset white balance */
+	val = (param->lssc_pwhb_r_gain_max << 16U) | (param->lssc_pwhb_r_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_R_GAIN);
+
+	val = (param->lssc_pwhb_gr_gain_max << 16U) | (param->lssc_pwhb_gr_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_GR_GAIN);
+
+	val = (param->lssc_pwhb_gb_gain_max << 16U) | (param->lssc_pwhb_gb_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_GB_GAIN);
+
+	val = (param->lssc_pwhb_b_gain_max << 16U) | (param->lssc_pwhb_b_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_B_GAIN);
+
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_LSSC_EN);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_lsc_table_transmission() - Configure L1ISP transferring lens shading grid table.
+ *
+ * @table_gr: grid shading table for Gr(physical address)
+ * @table_r: grid shading table for R(physical address)
+ * @table_b: grid shading table for B(physical address)
+ * @table_gb: grid shading table for Gb(physical address)
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "table_h", "table_m" or "table_l" is not 8byte alignment
+ *
+ * Note that when 0 is set to table address, table transfer of the table is disabled.
+ */
+s32 hwd_viif_l1_set_lsc_table_transmission(struct hwd_viif_res *res, uintptr_t table_gr,
+					   uintptr_t table_r, uintptr_t table_b, uintptr_t table_gb)
+{
+	u32 val = 0x0U;
+
+	if (((table_gr % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_r % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_b % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_gb % HWD_VIIF_L1_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+	/* VDM common settings */
+	writel(HWD_VIIF_L1_VDM_CFG_PARAM, &res->capture_reg->vdm.t_group[0].VDM_T_CFG);
+	writel(HWD_VIIF_L1_VDM_SRAM_BASE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_BASE);
+	writel(HWD_VIIF_L1_VDM_SRAM_SIZE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_SIZE);
+
+	if (table_gr != 0U) {
+		writel((u32)table_gr, &res->capture_reg->vdm.t_port[4].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[4].VDM_T_SIZE);
+		val |= 0x10U;
+	}
+
+	if (table_r != 0U) {
+		writel((u32)table_r, &res->capture_reg->vdm.t_port[5].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[5].VDM_T_SIZE);
+		val |= 0x20U;
+	}
+
+	if (table_b != 0U) {
+		writel((u32)table_b, &res->capture_reg->vdm.t_port[6].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[6].VDM_T_SIZE);
+		val |= 0x40U;
+	}
+
+	if (table_gb != 0U) {
+		writel((u32)table_gb, &res->capture_reg->vdm.t_port[7].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[7].VDM_T_SIZE);
+		val |= 0x80U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & 0xffffff0fU);
+	writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_main_process() - Configure L1ISP main process.
+ *
+ * @demosaic_mode: demosaic mode @ref hwd_viif_l1_demosaic
+ * @damp_lsbsel: output pixel clip range for auto white balance [0..15]
+ * @color_matrix: pointer to color matrix correction parameters
+ * @dst_maxval: output pixel maximum value [0x0..0xffffff]
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * main process means digital amp, demosaic, and color matrix correction
+ *             NULL means disabling color matrix correction
+ * - "demosaic_mode" is neither HWD_VIIF_L1_DEMOSAIC_ACPI nor HWD_VIIF_L1_DEMOSAIC_DMG
+ * - "damp_lsbsel" is out of range
+ * - each parameter of "color_matrix" is out of range
+ * - "dst_maxval" is out of range
+ */
+s32 hwd_viif_l1_set_main_process(struct hwd_viif_res *res, u32 demosaic_mode, u32 damp_lsbsel,
+				 const struct viif_l1_color_matrix_correction *color_matrix,
+				 u32 dst_maxval)
+{
+	u32 val;
+
+	if (demosaic_mode != HWD_VIIF_L1_DEMOSAIC_ACPI &&
+	    demosaic_mode != HWD_VIIF_L1_DEMOSAIC_DMG) {
+		return -EINVAL;
+	}
+
+	if (damp_lsbsel > HWD_VIIF_DAMP_MAX_LSBSEL)
+		return -EINVAL;
+
+	if (color_matrix) {
+		if (color_matrix->coef_rmg_min > color_matrix->coef_rmg_max ||
+		    color_matrix->coef_rmb_min > color_matrix->coef_rmb_max ||
+		    color_matrix->coef_gmr_min > color_matrix->coef_gmr_max ||
+		    color_matrix->coef_gmb_min > color_matrix->coef_gmb_max ||
+		    color_matrix->coef_bmr_min > color_matrix->coef_bmr_max ||
+		    color_matrix->coef_bmg_min > color_matrix->coef_bmg_max ||
+		    (u32)color_matrix->dst_minval > dst_maxval)
+			return -EINVAL;
+	}
+
+	if (dst_maxval > HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	val = damp_lsbsel << 4U;
+	writel(val, &res->capture_reg->l1isp.L1_MPRO_CONF);
+
+	writel(demosaic_mode, &res->capture_reg->l1isp.L1_MPRO_LCS_MODE);
+
+	if (color_matrix) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_MPRO_SW);
+
+		val = (u32)color_matrix->coef_rmg_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMG_MIN);
+
+		val = (u32)color_matrix->coef_rmg_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMG_MAX);
+
+		val = (u32)color_matrix->coef_rmb_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMB_MIN);
+
+		val = (u32)color_matrix->coef_rmb_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMB_MAX);
+
+		val = (u32)color_matrix->coef_gmr_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMR_MIN);
+
+		val = (u32)color_matrix->coef_gmr_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMR_MAX);
+
+		val = (u32)color_matrix->coef_gmb_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMB_MIN);
+
+		val = (u32)color_matrix->coef_gmb_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMB_MAX);
+
+		val = (u32)color_matrix->coef_bmr_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMR_MIN);
+
+		val = (u32)color_matrix->coef_bmr_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMR_MAX);
+
+		val = (u32)color_matrix->coef_bmg_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMG_MIN);
+
+		val = (u32)color_matrix->coef_bmg_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMG_MAX);
+
+		writel((u32)color_matrix->dst_minval, &res->capture_reg->l1isp.L1_MPRO_DST_MINVAL);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_MPRO_SW);
+	}
+
+	writel(dst_maxval, &res->capture_reg->l1isp.L1_MPRO_DST_MAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_awb() - Configure L1ISP auto white balance parameters.
+ *
+ * @param: pointer to auto white balance parameters; NULL means disabling auto white balance
+ * @awhb_wbmrg: R gain of white balance adjustment [0x40..0x3FF] accuracy: 1/256
+ * @awhb_wbmgg: G gain of white balance adjustment [0x40..0x3FF] accuracy: 1/256
+ * @awhb_wbmbg: B gain of white balance adjustment [0x40..0x3FF] accuracy: 1/256
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL
+ * - each parameter of "param" is out of range
+ * - awhb_wbm*g is out of range
+ */
+s32 hwd_viif_l1_set_awb(struct hwd_viif_res *res, const struct viif_l1_awb *param, u32 awhb_wbmrg,
+			u32 awhb_wbmgg, u32 awhb_wbmbg)
+{
+	u32 val, ygate_data;
+
+	if (awhb_wbmrg < HWD_VIIF_AWB_MIN_GAIN || awhb_wbmrg >= HWD_VIIF_AWB_MAX_GAIN ||
+	    awhb_wbmgg < HWD_VIIF_AWB_MIN_GAIN || awhb_wbmgg >= HWD_VIIF_AWB_MAX_GAIN ||
+	    awhb_wbmbg < HWD_VIIF_AWB_MIN_GAIN || awhb_wbmbg >= HWD_VIIF_AWB_MAX_GAIN) {
+		return -EINVAL;
+	}
+
+	if (param) {
+		if (param->awhb_ygate_sel != HWD_VIIF_ENABLE &&
+		    param->awhb_ygate_sel != HWD_VIIF_DISABLE) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_ygate_data != 64U && param->awhb_ygate_data != 128U &&
+		    param->awhb_ygate_data != 256U && param->awhb_ygate_data != 512U) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_cgrange != HWD_VIIF_L1_AWB_ONE_SECOND &&
+		    param->awhb_cgrange != HWD_VIIF_L1_AWB_X1 &&
+		    param->awhb_cgrange != HWD_VIIF_L1_AWB_X2 &&
+		    param->awhb_cgrange != HWD_VIIF_L1_AWB_X4) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_ygatesw != HWD_VIIF_ENABLE &&
+		    param->awhb_ygatesw != HWD_VIIF_DISABLE) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_hexsw != HWD_VIIF_ENABLE && param->awhb_hexsw != HWD_VIIF_DISABLE)
+			return -EINVAL;
+
+		if (param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE0 &&
+		    param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE1 &&
+		    param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE2 &&
+		    param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE3) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		if (param->awhb_area_hsize < 1U || (param->awhb_area_hsize > ((val - 8U) / 8U)) ||
+		    param->awhb_area_hofs > (val - 9U)) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		if (param->awhb_area_vsize < 1U || (param->awhb_area_vsize > ((val - 4U) / 8U)) ||
+		    param->awhb_area_vofs > (val - 5U)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_sq_sw[0] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_sw[0] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_sw[1] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_sw[1] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_sw[2] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_sw[2] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_pol[0] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_pol[0] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_pol[1] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_pol[1] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_pol[2] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_pol[2] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_bycut0p > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_bycut0n > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut0p > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut0n > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rbcut0h < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rbcut0h > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rbcut0l < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rbcut0l > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_h[0] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_bycut_h[0] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_h[1] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_bycut_h[1] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_h[2] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_bycut_h[2] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_l[0] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_bycut_l[1] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_bycut_l[2] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut_h[0] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rycut_h[0] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rycut_h[1] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rycut_h[1] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rycut_h[2] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rycut_h[2] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rycut_l[0] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut_l[1] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut_l[2] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_awbsftu < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_awbsftu > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_awbsftv < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_awbsftv > HWD_VIIF_AWB_GATE_UPPER ||
+		    (param->awhb_awbhuecor != HWD_VIIF_ENABLE &&
+		     param->awhb_awbhuecor != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_awbspd > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED ||
+		    param->awhb_awbulv > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL ||
+		    param->awhb_awbvlv > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL ||
+		    param->awhb_awbondot > HWD_VIIF_AWB_INTEGRATION_STOP_TH) {
+			return -EINVAL;
+		}
+
+		switch (param->awhb_awbfztim) {
+		case HWD_VIIF_L1_AWB_RESTART_NO:
+		case HWD_VIIF_L1_AWB_RESTART_128FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_64FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_32FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_16FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_8FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_4FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_2FRAME:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	writel(awhb_wbmrg, &res->capture_reg->l1isp.L1_AWHB_WBMRG);
+	writel(awhb_wbmgg, &res->capture_reg->l1isp.L1_AWHB_WBMGG);
+	writel(awhb_wbmbg, &res->capture_reg->l1isp.L1_AWHB_WBMBG);
+
+	val = readl(&res->capture_reg->l1isp.L1_AWHB_SW) & 0xffffff7fU;
+
+	if (param) {
+		val |= (HWD_VIIF_ENABLE << 7U);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_SW);
+
+		if (param->awhb_ygate_data == 64U)
+			ygate_data = 0U;
+		else if (param->awhb_ygate_data == 128U)
+			ygate_data = 1U;
+		else if (param->awhb_ygate_data == 256U)
+			ygate_data = 2U;
+		else
+			ygate_data = 3U;
+
+		val = (param->awhb_ygate_sel << 7U) | (ygate_data << 5U) | (param->awhb_cgrange);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_GATE_CONF0);
+
+		val = (param->awhb_ygatesw << 5U) | (param->awhb_hexsw << 4U) |
+		      (param->awhb_areamode);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_GATE_CONF1);
+
+		writel(param->awhb_area_hsize, &res->capture_reg->l1isp.L1_AWHB_AREA_HSIZE);
+		writel(param->awhb_area_vsize, &res->capture_reg->l1isp.L1_AWHB_AREA_VSIZE);
+		writel(param->awhb_area_hofs, &res->capture_reg->l1isp.L1_AWHB_AREA_HOFS);
+		writel(param->awhb_area_vofs, &res->capture_reg->l1isp.L1_AWHB_AREA_VOFS);
+
+		writel(param->awhb_area_maskh, &res->capture_reg->l1isp.L1_AWHB_AREA_MASKH);
+		writel(param->awhb_area_maskl, &res->capture_reg->l1isp.L1_AWHB_AREA_MASKL);
+
+		val = (param->awhb_sq_sw[0] << 7U) | (param->awhb_sq_pol[0] << 6U) |
+		      (param->awhb_sq_sw[1] << 5U) | (param->awhb_sq_pol[1] << 4U) |
+		      (param->awhb_sq_sw[2] << 3U) | (param->awhb_sq_pol[2] << 2U);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_SQ_CONF);
+
+		writel((u32)param->awhb_ygateh, &res->capture_reg->l1isp.L1_AWHB_YGATEH);
+		writel((u32)param->awhb_ygatel, &res->capture_reg->l1isp.L1_AWHB_YGATEL);
+
+		writel(param->awhb_bycut0p, &res->capture_reg->l1isp.L1_AWHB_BYCUT0P);
+		writel(param->awhb_bycut0n, &res->capture_reg->l1isp.L1_AWHB_BYCUT0N);
+		writel(param->awhb_rycut0p, &res->capture_reg->l1isp.L1_AWHB_RYCUT0P);
+		writel(param->awhb_rycut0n, &res->capture_reg->l1isp.L1_AWHB_RYCUT0N);
+
+		val = (u32)param->awhb_rbcut0h & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RBCUT0H);
+		val = (u32)param->awhb_rbcut0l & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RBCUT0L);
+
+		val = (u32)param->awhb_bycut_h[0] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_BYCUT1H);
+		writel(param->awhb_bycut_l[0], &res->capture_reg->l1isp.L1_AWHB_BYCUT1L);
+		val = (u32)param->awhb_bycut_h[1] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_BYCUT2H);
+		writel(param->awhb_bycut_l[1], &res->capture_reg->l1isp.L1_AWHB_BYCUT2L);
+		val = (u32)param->awhb_bycut_h[2] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_BYCUT3H);
+		writel(param->awhb_bycut_l[2], &res->capture_reg->l1isp.L1_AWHB_BYCUT3L);
+
+		val = (u32)param->awhb_rycut_h[0] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RYCUT1H);
+		writel(param->awhb_rycut_l[0], &res->capture_reg->l1isp.L1_AWHB_RYCUT1L);
+		val = (u32)param->awhb_rycut_h[1] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RYCUT2H);
+		writel(param->awhb_rycut_l[1], &res->capture_reg->l1isp.L1_AWHB_RYCUT2L);
+		val = (u32)param->awhb_rycut_h[2] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RYCUT3H);
+		writel(param->awhb_rycut_l[2], &res->capture_reg->l1isp.L1_AWHB_RYCUT3L);
+
+		val = (u32)param->awhb_awbsftu & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_AWBSFTU);
+		val = (u32)param->awhb_awbsftv & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_AWBSFTV);
+
+		val = (param->awhb_awbhuecor << 4U) | (param->awhb_awbspd);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_AWBSPD);
+
+		writel(param->awhb_awbulv, &res->capture_reg->l1isp.L1_AWHB_AWBULV);
+		writel(param->awhb_awbvlv, &res->capture_reg->l1isp.L1_AWHB_AWBVLV);
+		writel((u32)param->awhb_awbwait, &res->capture_reg->l1isp.L1_AWHB_AWBWAIT);
+
+		writel(param->awhb_awbondot, &res->capture_reg->l1isp.L1_AWHB_AWBONDOT);
+		writel(param->awhb_awbfztim, &res->capture_reg->l1isp.L1_AWHB_AWBFZTIM);
+
+		writel((u32)param->awhb_wbgrmax, &res->capture_reg->l1isp.L1_AWHB_WBGRMAX);
+		writel((u32)param->awhb_wbgbmax, &res->capture_reg->l1isp.L1_AWHB_WBGBMAX);
+		writel((u32)param->awhb_wbgrmin, &res->capture_reg->l1isp.L1_AWHB_WBGRMIN);
+		writel((u32)param->awhb_wbgbmin, &res->capture_reg->l1isp.L1_AWHB_WBGBMIN);
+
+	} else {
+		/* disable awb */
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_SW);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_lock_awb_gain() - Configure L1ISP lock auto white balance gain.
+ *
+ * @enable: enable/disable lock AWB gain
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is neither HWD_VIIF_ENABLE nor HWD_VIIF_DISABLE
+ */
+s32 hwd_viif_l1_lock_awb_gain(struct hwd_viif_res *res, u32 enable)
+{
+	u32 val;
+
+	if (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l1isp.L1_AWHB_SW) & 0xffffffdfU;
+	val |= (enable << 5U);
+	writel(val, &res->capture_reg->l1isp.L1_AWHB_SW);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdrc() - Configure L1ISP HDR compression parameters.
+ *
+ * @param: pointer to HDR compression parameters
+ * @hdrc_thr_sft_amt: shift value in case of through mode [0..8]
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ * - hdrc_thr_sft_amt is out of range when param is NULL
+ * - hdrc_thr_sft_amt is not 0 when param is not NULL
+ */
+s32 hwd_viif_l1_set_hdrc(struct hwd_viif_res *res, const struct viif_l1_hdrc *param,
+			 u32 hdrc_thr_sft_amt)
+{
+	u32 val, sw_delay1;
+
+	if (!param) {
+		if (hdrc_thr_sft_amt > HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL)
+			return -EINVAL;
+
+		writel(hdrc_thr_sft_amt, &res->capture_reg->l1isp.L1_HDRC_THR_SFT_AMT);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_HDRC_EN);
+
+		return 0;
+	}
+
+	if (hdrc_thr_sft_amt != 0U || param->hdrc_ratio < HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH ||
+	    param->hdrc_ratio > HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH ||
+	    param->hdrc_pt_ratio > HWD_VIIF_L1_HDRC_MAX_PT_SLOPE ||
+	    param->hdrc_pt_blend > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO ||
+	    param->hdrc_pt_blend2 > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO ||
+	    (param->hdrc_pt_blend + param->hdrc_pt_blend2) > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO ||
+	    (param->hdrc_tn_type != HWD_VIIF_L1_HDRC_TONE_USER &&
+	     param->hdrc_tn_type != HWD_VIIF_L1_HDRC_TONE_PRESET) ||
+	    param->hdrc_flr_val > HWD_VIIF_L1_HDRC_MAX_FLARE_VAL ||
+	    (param->hdrc_flr_adp != HWD_VIIF_ENABLE && param->hdrc_flr_adp != HWD_VIIF_DISABLE) ||
+	    (param->hdrc_ybr_off != HWD_VIIF_ENABLE && param->hdrc_ybr_off != HWD_VIIF_DISABLE) ||
+	    param->hdrc_orgy_blend > HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA) {
+		return -EINVAL;
+	}
+
+	writel((param->hdrc_ratio - HWD_VIIF_L1_HDRC_RATIO_OFFSET),
+	       &res->capture_reg->l1isp.L1_HDRC_RATIO);
+	writel(param->hdrc_pt_ratio, &res->capture_reg->l1isp.L1_HDRC_PT_RATIO);
+
+	writel(param->hdrc_pt_blend, &res->capture_reg->l1isp.L1_HDRC_PT_BLEND);
+	writel(param->hdrc_pt_blend2, &res->capture_reg->l1isp.L1_HDRC_PT_BLEND2);
+
+	writel(param->hdrc_pt_sat, &res->capture_reg->l1isp.L1_HDRC_PT_SAT);
+	writel(param->hdrc_tn_type, &res->capture_reg->l1isp.L1_HDRC_TN_TYPE);
+
+	writel(param->hdrc_utn_tbl[0], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL0);
+	writel(param->hdrc_utn_tbl[1], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL1);
+	writel(param->hdrc_utn_tbl[2], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL2);
+	writel(param->hdrc_utn_tbl[3], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL3);
+	writel(param->hdrc_utn_tbl[4], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL4);
+	writel(param->hdrc_utn_tbl[5], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL5);
+	writel(param->hdrc_utn_tbl[6], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL6);
+	writel(param->hdrc_utn_tbl[7], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL7);
+	writel(param->hdrc_utn_tbl[8], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL8);
+	writel(param->hdrc_utn_tbl[9], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL9);
+	writel(param->hdrc_utn_tbl[10], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL10);
+	writel(param->hdrc_utn_tbl[11], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL11);
+	writel(param->hdrc_utn_tbl[12], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL12);
+	writel(param->hdrc_utn_tbl[13], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL13);
+	writel(param->hdrc_utn_tbl[14], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL14);
+	writel(param->hdrc_utn_tbl[15], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL15);
+	writel(param->hdrc_utn_tbl[16], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL16);
+	writel(param->hdrc_utn_tbl[17], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL17);
+	writel(param->hdrc_utn_tbl[18], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL18);
+	writel(param->hdrc_utn_tbl[19], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL19);
+
+	writel(param->hdrc_flr_val, &res->capture_reg->l1isp.L1_HDRC_FLR_VAL);
+	writel(param->hdrc_flr_adp, &res->capture_reg->l1isp.L1_HDRC_FLR_ADP);
+
+	writel(param->hdrc_ybr_off, &res->capture_reg->l1isp.L1_HDRC_YBR_OFF);
+	writel(param->hdrc_orgy_blend, &res->capture_reg->l1isp.L1_HDRC_ORGY_BLEND);
+
+	val = ((readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT)) % 64U) / 2U;
+	writel(val, &res->capture_reg->l1isp.L1_HDRC_MAR_TOP);
+	val = ((readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH)) % 64U) / 2U;
+	writel(val, &res->capture_reg->l1isp.L1_HDRC_MAR_LEFT);
+
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_HDRC_EN);
+
+	/* update of sw_delay1 must be done when MAIN unit is NOT running. */
+	if (!res->run_flag_main) {
+		sw_delay1 = (u32)((HWD_VIIF_REGBUF_ACCESS_TIME * (u64)res->pixel_clock) /
+				  ((u64)res->htotal_size * HWD_VIIF_SYS_CLK)) +
+			    HWD_VIIF_L1_DELAY_W_HDRC + 1U;
+		val = readl(&res->capture_reg->sys.INT_M1_LINE) & 0xffffU;
+		val |= (sw_delay1 << 16U);
+		writel(val, &res->capture_reg->sys.INT_M1_LINE);
+		/* M2_LINE is the same condition as M1_LINE */
+		writel(val, &res->capture_reg->sys.INT_M2_LINE);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdrc_ltm() - Configure L1ISP HDR compression local tone mapping parameters.
+ *
+ * @param: pointer to HDR compression local tone mapping parameters
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_hdrc_ltm(struct hwd_viif_res *res, const struct viif_l1_hdrc_ltm_config *param)
+{
+	u32 val;
+	u32 idx;
+
+	if (!param || param->tnp_max >= HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO ||
+	    param->tnp_mag >= HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION) {
+		return -EINVAL;
+	}
+
+	val = (u32)param->tnp_fil[0];
+	for (idx = 1; idx < 5U; idx++)
+		val += (u32)param->tnp_fil[idx] * 2U;
+
+	if (val != 1024U)
+		return -EINVAL;
+
+	writel(param->tnp_max, &res->capture_reg->l1isp.L1_HDRC_TNP_MAX);
+
+	writel(param->tnp_mag, &res->capture_reg->l1isp.L1_HDRC_TNP_MAG);
+
+	writel((u32)param->tnp_fil[0], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL0);
+	writel((u32)param->tnp_fil[1], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL1);
+	writel((u32)param->tnp_fil[2], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL2);
+	writel((u32)param->tnp_fil[3], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL3);
+	writel((u32)param->tnp_fil[4], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL4);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_gamma() - Configure L1ISP gamma correction parameters.
+ *
+ * @param: pointer to gamma correction parameters
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_gamma(struct hwd_viif_res *res, const struct viif_l1_gamma *param)
+{
+	u32 idx;
+
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_PGC_SW);
+		return 0;
+	}
+
+	for (idx = 0; idx < 44U; idx++) {
+		if (param->gam_p[idx] > HWD_VIIF_L1_GAMMA_MAX_VAL)
+			return -EINVAL;
+	}
+
+	writel(param->gam_p[0], &res->capture_reg->l1isp.L1_VPRO_GAM01P);
+	writel(param->gam_p[1], &res->capture_reg->l1isp.L1_VPRO_GAM02P);
+	writel(param->gam_p[2], &res->capture_reg->l1isp.L1_VPRO_GAM03P);
+	writel(param->gam_p[3], &res->capture_reg->l1isp.L1_VPRO_GAM04P);
+	writel(param->gam_p[4], &res->capture_reg->l1isp.L1_VPRO_GAM05P);
+	writel(param->gam_p[5], &res->capture_reg->l1isp.L1_VPRO_GAM06P);
+	writel(param->gam_p[6], &res->capture_reg->l1isp.L1_VPRO_GAM07P);
+	writel(param->gam_p[7], &res->capture_reg->l1isp.L1_VPRO_GAM08P);
+	writel(param->gam_p[8], &res->capture_reg->l1isp.L1_VPRO_GAM09P);
+	writel(param->gam_p[9], &res->capture_reg->l1isp.L1_VPRO_GAM10P);
+	writel(param->gam_p[10], &res->capture_reg->l1isp.L1_VPRO_GAM11P);
+	writel(param->gam_p[11], &res->capture_reg->l1isp.L1_VPRO_GAM12P);
+	writel(param->gam_p[12], &res->capture_reg->l1isp.L1_VPRO_GAM13P);
+	writel(param->gam_p[13], &res->capture_reg->l1isp.L1_VPRO_GAM14P);
+	writel(param->gam_p[14], &res->capture_reg->l1isp.L1_VPRO_GAM15P);
+	writel(param->gam_p[15], &res->capture_reg->l1isp.L1_VPRO_GAM16P);
+	writel(param->gam_p[16], &res->capture_reg->l1isp.L1_VPRO_GAM17P);
+	writel(param->gam_p[17], &res->capture_reg->l1isp.L1_VPRO_GAM18P);
+	writel(param->gam_p[18], &res->capture_reg->l1isp.L1_VPRO_GAM19P);
+	writel(param->gam_p[19], &res->capture_reg->l1isp.L1_VPRO_GAM20P);
+	writel(param->gam_p[20], &res->capture_reg->l1isp.L1_VPRO_GAM21P);
+	writel(param->gam_p[21], &res->capture_reg->l1isp.L1_VPRO_GAM22P);
+	writel(param->gam_p[22], &res->capture_reg->l1isp.L1_VPRO_GAM23P);
+	writel(param->gam_p[23], &res->capture_reg->l1isp.L1_VPRO_GAM24P);
+	writel(param->gam_p[24], &res->capture_reg->l1isp.L1_VPRO_GAM25P);
+	writel(param->gam_p[25], &res->capture_reg->l1isp.L1_VPRO_GAM26P);
+	writel(param->gam_p[26], &res->capture_reg->l1isp.L1_VPRO_GAM27P);
+	writel(param->gam_p[27], &res->capture_reg->l1isp.L1_VPRO_GAM28P);
+	writel(param->gam_p[28], &res->capture_reg->l1isp.L1_VPRO_GAM29P);
+	writel(param->gam_p[29], &res->capture_reg->l1isp.L1_VPRO_GAM30P);
+	writel(param->gam_p[30], &res->capture_reg->l1isp.L1_VPRO_GAM31P);
+	writel(param->gam_p[31], &res->capture_reg->l1isp.L1_VPRO_GAM32P);
+	writel(param->gam_p[32], &res->capture_reg->l1isp.L1_VPRO_GAM33P);
+	writel(param->gam_p[33], &res->capture_reg->l1isp.L1_VPRO_GAM34P);
+	writel(param->gam_p[34], &res->capture_reg->l1isp.L1_VPRO_GAM35P);
+	writel(param->gam_p[35], &res->capture_reg->l1isp.L1_VPRO_GAM36P);
+	writel(param->gam_p[36], &res->capture_reg->l1isp.L1_VPRO_GAM37P);
+	writel(param->gam_p[37], &res->capture_reg->l1isp.L1_VPRO_GAM38P);
+	writel(param->gam_p[38], &res->capture_reg->l1isp.L1_VPRO_GAM39P);
+	writel(param->gam_p[39], &res->capture_reg->l1isp.L1_VPRO_GAM40P);
+	writel(param->gam_p[40], &res->capture_reg->l1isp.L1_VPRO_GAM41P);
+	writel(param->gam_p[41], &res->capture_reg->l1isp.L1_VPRO_GAM42P);
+	writel(param->gam_p[42], &res->capture_reg->l1isp.L1_VPRO_GAM43P);
+	writel(param->gam_p[43], &res->capture_reg->l1isp.L1_VPRO_GAM44P);
+	writel(param->blkadj, &res->capture_reg->l1isp.L1_VPRO_BLKADJ);
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_PGC_SW);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_img_quality_adjustment() - Configure L1ISP image quality adjustment.
+ *
+ * @param: pointer to image quality adjustment parameters; NULL means disabling
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_img_quality_adjustment(struct hwd_viif_res *res,
+					   const struct hwd_viif_l1_img_quality_adjustment *param)
+{
+	u32 val;
+
+	if (!param) {
+		/* disable all features when param is absent */
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_YUVC_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_LCNT_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_NLCNT_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_YNR_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_ETE_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CB_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CR_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CBR_MGAIN_MIN);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_M_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_M_GAIN_MAX);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CNR_SW);
+
+		return 0;
+	}
+
+	if (param->lum_noise_reduction) {
+		if (param->lum_noise_reduction->gain_min > param->lum_noise_reduction->gain_max ||
+		    param->lum_noise_reduction->lim_min > param->lum_noise_reduction->lim_max) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->edge_enhancement) {
+		if (param->edge_enhancement->gain_min > param->edge_enhancement->gain_max ||
+		    param->edge_enhancement->lim_min > param->edge_enhancement->lim_max ||
+		    param->edge_enhancement->coring_min > param->edge_enhancement->coring_max) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->uv_suppression) {
+		if (param->uv_suppression->bk_mp >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->black >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->wh_mp >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->white >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->bk_slv >= param->uv_suppression->wh_slv)
+			return -EINVAL;
+	}
+
+	if (param->coring_suppression) {
+		if (param->coring_suppression->gain_min > param->coring_suppression->gain_max ||
+		    param->coring_suppression->lv_min > param->coring_suppression->lv_max)
+			return -EINVAL;
+	}
+
+	if (param->edge_suppression) {
+		if (param->edge_suppression->lim > HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT)
+			return -EINVAL;
+	}
+
+	if (param->color_level) {
+		if (param->color_level->cb_gain >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cr_gain >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cbr_mgain_min >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cbp_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cbm_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->crp_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->crm_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->color_noise_reduction_enable != HWD_VIIF_ENABLE &&
+	    param->color_noise_reduction_enable != HWD_VIIF_DISABLE) {
+		return -EINVAL;
+	}
+
+	/* RGB to YUV */
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_YUVC_SW);
+	writel((u32)param->coef_cb, &res->capture_reg->l1isp.L1_VPRO_CB_MAT);
+	writel((u32)param->coef_cr, &res->capture_reg->l1isp.L1_VPRO_CR_MAT);
+
+	/* brightness */
+	val = (u32)param->brightness & 0xffffU;
+	if (val != 0U) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW);
+		writel(val, &res->capture_reg->l1isp.L1_VPRO_BRIGHT);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW);
+	}
+
+	/* linear contrast */
+	if ((u32)param->linear_contrast != 128U) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_LCNT_SW);
+		writel((u32)param->linear_contrast, &res->capture_reg->l1isp.L1_VPRO_LCONT_LEV);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_LCNT_SW);
+	}
+
+	/* nonlinear contrast */
+	if (param->nonlinear_contrast) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_NLCNT_SW);
+		writel((u32)param->nonlinear_contrast->blk_knee,
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_KNEE);
+		writel((u32)param->nonlinear_contrast->wht_knee,
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_KNEE);
+
+		writel((u32)param->nonlinear_contrast->blk_cont[0],
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_CONT0);
+		writel((u32)param->nonlinear_contrast->blk_cont[1],
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_CONT1);
+		writel((u32)param->nonlinear_contrast->blk_cont[2],
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_CONT2);
+
+		writel((u32)param->nonlinear_contrast->wht_cont[0],
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_CONT0);
+		writel((u32)param->nonlinear_contrast->wht_cont[1],
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_CONT1);
+		writel((u32)param->nonlinear_contrast->wht_cont[2],
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_CONT2);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_NLCNT_SW);
+	}
+
+	/* luminance noise reduction */
+	if (param->lum_noise_reduction) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_YNR_SW);
+		writel((u32)param->lum_noise_reduction->gain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_GAIN_MIN);
+		writel((u32)param->lum_noise_reduction->gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_GAIN_MAX);
+		writel((u32)param->lum_noise_reduction->lim_min,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_LIM_MIN);
+		writel((u32)param->lum_noise_reduction->lim_max,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_LIM_MAX);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_YNR_SW);
+	}
+
+	/* edge enhancement */
+	if (param->edge_enhancement) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_ETE_SW);
+		writel((u32)param->edge_enhancement->gain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_GAIN_MIN);
+		writel((u32)param->edge_enhancement->gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_GAIN_MAX);
+		writel((u32)param->edge_enhancement->lim_min,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_LIM_MIN);
+		writel((u32)param->edge_enhancement->lim_max,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_LIM_MAX);
+		writel((u32)param->edge_enhancement->coring_min,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_CORING_MIN);
+		writel((u32)param->edge_enhancement->coring_max,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_CORING_MAX);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_ETE_SW);
+	}
+
+	/* UV suppression */
+	if (param->uv_suppression) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW);
+		writel((u32)param->uv_suppression->bk_slv,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_BK_SLV);
+		writel(param->uv_suppression->bk_mp, &res->capture_reg->l1isp.L1_VPRO_CSUP_BK_MP);
+		writel(param->uv_suppression->black, &res->capture_reg->l1isp.L1_VPRO_CSUP_BLACK);
+
+		writel((u32)param->uv_suppression->wh_slv,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_WH_SLV);
+		writel(param->uv_suppression->wh_mp, &res->capture_reg->l1isp.L1_VPRO_CSUP_WH_MP);
+		writel(param->uv_suppression->white, &res->capture_reg->l1isp.L1_VPRO_CSUP_WHITE);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW);
+	}
+
+	/* coring suppression */
+	if (param->coring_suppression) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW);
+		writel((u32)param->coring_suppression->lv_min,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_LV_MIN);
+		writel((u32)param->coring_suppression->lv_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_LV_MAX);
+		writel((u32)param->coring_suppression->gain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_GAIN_MIN);
+		writel((u32)param->coring_suppression->gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_GAIN_MAX);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW);
+	}
+
+	/* edge suppression */
+	if (param->edge_suppression) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW);
+		writel((u32)param->edge_suppression->gain,
+		       &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_GAIN);
+		writel((u32)param->edge_suppression->lim,
+		       &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_LIM);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW);
+	}
+
+	/* color level */
+	if (param->color_level) {
+		writel(param->color_level->cb_gain, &res->capture_reg->l1isp.L1_VPRO_CB_GAIN);
+		writel(param->color_level->cr_gain, &res->capture_reg->l1isp.L1_VPRO_CR_GAIN);
+		writel(param->color_level->cbr_mgain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_CBR_MGAIN_MIN);
+		writel(param->color_level->cbp_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CB_P_GAIN_MAX);
+		writel(param->color_level->cbm_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CB_M_GAIN_MAX);
+		writel(param->color_level->crp_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CR_P_GAIN_MAX);
+		writel(param->color_level->crm_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CR_M_GAIN_MAX);
+	} else {
+		/* disable */
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CB_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CR_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CBR_MGAIN_MIN);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_M_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_M_GAIN_MAX);
+	}
+
+	/* color noise reduction */
+	writel(param->color_noise_reduction_enable, &res->capture_reg->l1isp.L1_VPRO_CNR_SW);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_avg_lum_generation() - Configure L1ISP average luminance generation parameters.
+ *
+ * @param: pointer to auto exposure parameters
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_avg_lum_generation(struct hwd_viif_res *res,
+				       const struct viif_l1_avg_lum_generation_config *param)
+{
+	u32 idx, j;
+	u32 val;
+
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_AEXP_ON);
+		return 0;
+	}
+
+	val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+	if (param->aexp_start_x > (val - 1U))
+		return -EINVAL;
+
+	if (param->aexp_block_width < HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH ||
+	    param->aexp_block_width > val) {
+		return -EINVAL;
+	}
+	if (param->aexp_block_width % 64U)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+	if (param->aexp_start_y > (val - 1U))
+		return -EINVAL;
+
+	if (param->aexp_block_height < HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT ||
+	    param->aexp_block_height > val) {
+		return -EINVAL;
+	}
+	if (param->aexp_block_height % 64U)
+		return -EINVAL;
+
+	for (idx = 0; idx < 8U; idx++) {
+		for (j = 0; j < 8U; j++) {
+			if (param->aexp_weight[idx][j] > HWD_VIIF_L1_AEXP_MAX_WEIGHT)
+				return -EINVAL;
+		}
+	}
+
+	if (param->aexp_satur_ratio > HWD_VIIF_L1_AEXP_MAX_BLOCK_TH ||
+	    param->aexp_black_ratio > HWD_VIIF_L1_AEXP_MAX_BLOCK_TH ||
+	    param->aexp_satur_level > HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH) {
+		return -EINVAL;
+	}
+
+	for (idx = 0; idx < 4U; idx++) {
+		if (param->aexp_ave4linesy[idx] > (val - 4U))
+			return -EINVAL;
+	}
+
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_AEXP_ON);
+	writel(param->aexp_start_x, &res->capture_reg->l1isp.L1_AEXP_START_X);
+	writel(param->aexp_start_y, &res->capture_reg->l1isp.L1_AEXP_START_Y);
+	writel(param->aexp_block_width, &res->capture_reg->l1isp.L1_AEXP_BLOCK_WIDTH);
+	writel(param->aexp_block_height, &res->capture_reg->l1isp.L1_AEXP_BLOCK_HEIGHT);
+
+	val = (param->aexp_weight[0][0] << 14U) | (param->aexp_weight[0][1] << 12U) |
+	      (param->aexp_weight[0][2] << 10U) | (param->aexp_weight[0][3] << 8U) |
+	      (param->aexp_weight[0][4] << 6U) | (param->aexp_weight[0][5] << 4U) |
+	      (param->aexp_weight[0][6] << 2U) | (param->aexp_weight[0][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_0);
+
+	val = (param->aexp_weight[1][0] << 14U) | (param->aexp_weight[1][1] << 12U) |
+	      (param->aexp_weight[1][2] << 10U) | (param->aexp_weight[1][3] << 8U) |
+	      (param->aexp_weight[1][4] << 6U) | (param->aexp_weight[1][5] << 4U) |
+	      (param->aexp_weight[1][6] << 2U) | (param->aexp_weight[1][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_1);
+
+	val = (param->aexp_weight[2][0] << 14U) | (param->aexp_weight[2][1] << 12U) |
+	      (param->aexp_weight[2][2] << 10U) | (param->aexp_weight[2][3] << 8U) |
+	      (param->aexp_weight[2][4] << 6U) | (param->aexp_weight[2][5] << 4U) |
+	      (param->aexp_weight[2][6] << 2U) | (param->aexp_weight[2][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_2);
+
+	val = (param->aexp_weight[3][0] << 14U) | (param->aexp_weight[3][1] << 12U) |
+	      (param->aexp_weight[3][2] << 10U) | (param->aexp_weight[3][3] << 8U) |
+	      (param->aexp_weight[3][4] << 6U) | (param->aexp_weight[3][5] << 4U) |
+	      (param->aexp_weight[3][6] << 2U) | (param->aexp_weight[3][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_3);
+
+	val = (param->aexp_weight[4][0] << 14U) | (param->aexp_weight[4][1] << 12U) |
+	      (param->aexp_weight[4][2] << 10U) | (param->aexp_weight[4][3] << 8U) |
+	      (param->aexp_weight[4][4] << 6U) | (param->aexp_weight[4][5] << 4U) |
+	      (param->aexp_weight[4][6] << 2U) | (param->aexp_weight[4][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_4);
+
+	val = (param->aexp_weight[5][0] << 14U) | (param->aexp_weight[5][1] << 12U) |
+	      (param->aexp_weight[5][2] << 10U) | (param->aexp_weight[5][3] << 8U) |
+	      (param->aexp_weight[5][4] << 6U) | (param->aexp_weight[5][5] << 4U) |
+	      (param->aexp_weight[5][6] << 2U) | (param->aexp_weight[5][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_5);
+
+	val = (param->aexp_weight[6][0] << 14U) | (param->aexp_weight[6][1] << 12U) |
+	      (param->aexp_weight[6][2] << 10U) | (param->aexp_weight[6][3] << 8U) |
+	      (param->aexp_weight[6][4] << 6U) | (param->aexp_weight[6][5] << 4U) |
+	      (param->aexp_weight[6][6] << 2U) | (param->aexp_weight[6][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_6);
+
+	val = (param->aexp_weight[7][0] << 14U) | (param->aexp_weight[7][1] << 12U) |
+	      (param->aexp_weight[7][2] << 10U) | (param->aexp_weight[7][3] << 8U) |
+	      (param->aexp_weight[7][4] << 6U) | (param->aexp_weight[7][5] << 4U) |
+	      (param->aexp_weight[7][6] << 2U) | (param->aexp_weight[7][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_7);
+
+	writel(param->aexp_satur_ratio, &res->capture_reg->l1isp.L1_AEXP_SATUR_RATIO);
+	writel(param->aexp_black_ratio, &res->capture_reg->l1isp.L1_AEXP_BLACK_RATIO);
+	writel(param->aexp_satur_level, &res->capture_reg->l1isp.L1_AEXP_SATUR_LEVEL);
+
+	writel(param->aexp_ave4linesy[0], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY0);
+	writel(param->aexp_ave4linesy[1], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY1);
+	writel(param->aexp_ave4linesy[2], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY2);
+	writel(param->aexp_ave4linesy[3], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY3);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_irq_mask() - Set L1ISP interruption mask.
+ *
+ * @mask: mask setting
+ * Return: None
+ */
+void hwd_viif_l1_set_irq_mask(struct hwd_viif_res *res, u32 mask)
+{
+	writel(mask, &res->capture_reg->l1isp.L1_CRGBF_ISP_INT_MASK);
+}
diff --git a/drivers/media/platform/visconti/viif_controls.c b/drivers/media/platform/visconti/viif_controls.c
new file mode 100644
index 00000000000..2793fb0a807
--- /dev/null
+++ b/drivers/media/platform/visconti/viif_controls.c
@@ -0,0 +1,1153 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+
+static int viif_main_set_rawpack_mode(struct viif_device *viif_dev, u32 *rawpack)
+{
+	if (vb2_is_streaming(&viif_dev->cap_dev0.vb2_vq))
+		return -EBUSY;
+
+	if (*rawpack == VIIF_RAWPACK_DISABLE) {
+		viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_DISABLE;
+		return 0;
+	}
+	if (*rawpack == VIIF_RAWPACK_MSBFIRST) {
+		viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_MSBFIRST;
+		return 0;
+	}
+	if (*rawpack == VIIF_RAWPACK_LSBFIRST) {
+		viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_LSBFIRST;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int viif_l1_set_input_mode(struct viif_device *viif_dev,
+				  struct viif_l1_input_mode_config *input_mode)
+{
+	u32 mode, raw_color_filter;
+	unsigned long irqflags;
+	int ret;
+
+	/* SDR input is not supported */
+	if (input_mode->mode == VIIF_L1_INPUT_HDR)
+		mode = HWD_VIIF_L1_INPUT_HDR;
+	else if (input_mode->mode == VIIF_L1_INPUT_PWL)
+		mode = HWD_VIIF_L1_INPUT_PWL;
+	else if (input_mode->mode == VIIF_L1_INPUT_HDR_IMG_CORRECT)
+		mode = HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT;
+	else if (input_mode->mode == VIIF_L1_INPUT_PWL_IMG_CORRECT)
+		mode = HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT;
+	else
+		return -EINVAL;
+
+	if (input_mode->raw_color_filter == VIIF_L1_RAW_GR_R_B_GB)
+		raw_color_filter = HWD_VIIF_L1_RAW_GR_R_B_GB;
+	else if (input_mode->raw_color_filter == VIIF_L1_RAW_R_GR_GB_B)
+		raw_color_filter = HWD_VIIF_L1_RAW_R_GR_GB_B;
+	else if (input_mode->raw_color_filter == VIIF_L1_RAW_B_GB_GR_R)
+		raw_color_filter = HWD_VIIF_L1_RAW_B_GB_GR_R;
+	else if (input_mode->raw_color_filter == VIIF_L1_RAW_GB_B_R_GR)
+		raw_color_filter = HWD_VIIF_L1_RAW_GB_B_R_GR;
+	else
+		return -EINVAL;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_input_mode(viif_dev->hwd_res, mode, input_mode->depth,
+					 raw_color_filter);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_rgb_to_y_coef(struct viif_device *viif_dev,
+				     struct viif_l1_rgb_to_y_coef_config *l1_rgb_to_y_coef)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_rgb_to_y_coef(viif_dev->hwd_res, l1_rgb_to_y_coef->coef_r,
+					    l1_rgb_to_y_coef->coef_g, l1_rgb_to_y_coef->coef_b);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_ag_mode(struct viif_device *viif_dev,
+			       struct viif_l1_ag_mode_config *l1_ag_mode)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_ag_mode(viif_dev->hwd_res, l1_ag_mode);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_ag(struct viif_device *viif_dev, struct viif_l1_ag_config *l1_ag)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_ag(viif_dev->hwd_res, l1_ag->gain_h, l1_ag->gain_m, l1_ag->gain_l);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdre(struct viif_device *viif_dev, struct viif_l1_hdre_config *l1_hdre)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_hdre(viif_dev->hwd_res, l1_hdre);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_img_extraction(struct viif_device *viif_dev,
+				      struct viif_l1_img_extraction_config *img_extract)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_img_extraction(viif_dev->hwd_res, img_extract->input_black_gr,
+					     img_extract->input_black_r, img_extract->input_black_b,
+					     img_extract->input_black_gb);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_DPC_TABLE_SIZE 8192
+static int viif_l1_set_dpc(struct viif_device *viif_dev, struct viif_l1_dpc_config *l1_dpc)
+{
+	uintptr_t table_h_paddr = 0;
+	uintptr_t table_m_paddr = 0;
+	uintptr_t table_l_paddr = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if (l1_dpc->table_h_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_h,
+				   u64_to_user_ptr(l1_dpc->table_h_addr),
+				   VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_h_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_h;
+	}
+	if (l1_dpc->table_m_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_m,
+				   u64_to_user_ptr(l1_dpc->table_m_addr),
+				   VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_m_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_m;
+	}
+	if (l1_dpc->table_l_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_l,
+				   u64_to_user_ptr(l1_dpc->table_l_addr),
+				   VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_l_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_l;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_dpc_table_transmission(viif_dev->hwd_res, table_h_paddr,
+						     table_m_paddr, table_l_paddr);
+	if (ret)
+		goto err;
+
+	ret = hwd_viif_l1_set_dpc(viif_dev->hwd_res, &l1_dpc->param_h, &l1_dpc->param_m,
+				  &l1_dpc->param_l);
+
+err:
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int
+viif_l1_set_preset_white_balance(struct viif_device *viif_dev,
+				 struct viif_l1_preset_white_balance_config *l1_preset_wb)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_preset_white_balance(viif_dev->hwd_res, l1_preset_wb->dstmaxval,
+						   &l1_preset_wb->param_h, &l1_preset_wb->param_m,
+						   &l1_preset_wb->param_l);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int
+viif_l1_set_raw_color_noise_reduction(struct viif_device *viif_dev,
+				      struct viif_l1_raw_color_noise_reduction_config *raw_color)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_raw_color_noise_reduction(viif_dev->hwd_res, &raw_color->param_h,
+							&raw_color->param_m, &raw_color->param_l);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrs(struct viif_device *viif_dev, struct viif_l1_hdrs_config *hdrs)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_hdrs(viif_dev->hwd_res, hdrs);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_black_level_correction(struct viif_device *viif_dev,
+					      struct viif_l1_black_level_correction_config *blc)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_black_level_correction(viif_dev->hwd_res, blc);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_LSC_TABLE_BYTES 1536
+
+static int viif_l1_set_lsc(struct viif_device *viif_dev, struct viif_l1_lsc_config *l1_lsc)
+{
+	struct viif_l1_lsc_parabola_param lsc_para;
+	struct viif_l1_lsc_grid_param lsc_grid;
+	struct hwd_viif_l1_lsc hwd_params;
+	struct viif_l1_lsc lsc_params;
+	uintptr_t table_gr_paddr = 0;
+	uintptr_t table_gb_paddr = 0;
+	uintptr_t table_r_paddr = 0;
+	uintptr_t table_b_paddr = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if (!l1_lsc->param_addr) {
+		spin_lock_irqsave(&viif_dev->lock, irqflags);
+		hwd_viif_isp_guard_start(viif_dev->hwd_res);
+		ret = hwd_viif_l1_set_lsc(viif_dev->hwd_res, NULL);
+		hwd_viif_isp_guard_end(viif_dev->hwd_res);
+		spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+		return ret;
+	}
+
+	if (l1_lsc->table_gr_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_gr,
+				   u64_to_user_ptr(l1_lsc->table_gr_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_gr_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_gr;
+	}
+	if (l1_lsc->table_r_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_r,
+				   u64_to_user_ptr(l1_lsc->table_r_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_r_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_r;
+	}
+	if (l1_lsc->table_b_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_b,
+				   u64_to_user_ptr(l1_lsc->table_b_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_b_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_b;
+	}
+	if (l1_lsc->table_gb_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_gb,
+				   u64_to_user_ptr(l1_lsc->table_gb_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_gb_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_gb;
+	}
+
+	if (copy_from_user(&lsc_params, u64_to_user_ptr(l1_lsc->param_addr),
+			   sizeof(struct viif_l1_lsc)))
+		return -EFAULT;
+
+	hwd_params.lssc_parabola_param = NULL;
+	hwd_params.lssc_grid_param = NULL;
+
+	if (lsc_params.lssc_parabola_param_addr) {
+		if (copy_from_user(&lsc_para, u64_to_user_ptr(lsc_params.lssc_parabola_param_addr),
+				   sizeof(struct viif_l1_lsc_parabola_param)))
+			return -EFAULT;
+		hwd_params.lssc_parabola_param = &lsc_para;
+	}
+
+	if (lsc_params.lssc_grid_param_addr) {
+		if (copy_from_user(&lsc_grid, u64_to_user_ptr(lsc_params.lssc_grid_param_addr),
+				   sizeof(struct viif_l1_lsc_grid_param)))
+			return -EFAULT;
+		hwd_params.lssc_grid_param = &lsc_grid;
+	}
+
+	hwd_params.lssc_pwhb_r_gain_max = lsc_params.lssc_pwhb_r_gain_max;
+	hwd_params.lssc_pwhb_r_gain_min = lsc_params.lssc_pwhb_r_gain_min;
+	hwd_params.lssc_pwhb_gr_gain_max = lsc_params.lssc_pwhb_gr_gain_max;
+	hwd_params.lssc_pwhb_gr_gain_min = lsc_params.lssc_pwhb_gr_gain_min;
+	hwd_params.lssc_pwhb_gb_gain_max = lsc_params.lssc_pwhb_gb_gain_max;
+	hwd_params.lssc_pwhb_gb_gain_min = lsc_params.lssc_pwhb_gb_gain_min;
+	hwd_params.lssc_pwhb_b_gain_max = lsc_params.lssc_pwhb_b_gain_max;
+	hwd_params.lssc_pwhb_b_gain_min = lsc_params.lssc_pwhb_b_gain_min;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_lsc_table_transmission(viif_dev->hwd_res, table_gr_paddr,
+						     table_r_paddr, table_b_paddr, table_gb_paddr);
+	if (ret)
+		goto err;
+
+	ret = hwd_viif_l1_set_lsc(viif_dev->hwd_res, &hwd_params);
+err:
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_main_process(struct viif_device *viif_dev,
+				    struct viif_l1_main_process_config *mpro)
+{
+	struct viif_l1_color_matrix_correction color_matrix;
+	unsigned long irqflags;
+	int ret;
+
+	if (mpro->param_addr) {
+		if (copy_from_user(&color_matrix, u64_to_user_ptr(mpro->param_addr),
+				   sizeof(struct viif_l1_color_matrix_correction)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_main_process(viif_dev->hwd_res, mpro->demosaic_mode,
+					   mpro->damp_lsbsel,
+					   mpro->param_addr ? &color_matrix : NULL,
+					   mpro->dst_maxval);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_awb(struct viif_device *viif_dev, struct viif_l1_awb_config *l1_awb)
+{
+	struct viif_l1_awb param;
+	unsigned long irqflags;
+	int ret;
+
+	if (l1_awb->param_addr) {
+		if (copy_from_user(&param, u64_to_user_ptr(l1_awb->param_addr),
+				   sizeof(struct viif_l1_awb)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_awb(viif_dev->hwd_res, l1_awb->param_addr ? &param : NULL,
+				  l1_awb->awhb_wbmrg, l1_awb->awhb_wbmgg, l1_awb->awhb_wbmbg);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_lock_awb_gain(struct viif_device *viif_dev, u32 *enable)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_lock_awb_gain(viif_dev->hwd_res, *enable);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrc(struct viif_device *viif_dev, struct viif_l1_hdrc_config *hdrc)
+{
+	struct viif_l1_hdrc param;
+	unsigned long irqflags;
+	int ret;
+
+	if (hdrc->param_addr) {
+		if (copy_from_user(&param, u64_to_user_ptr(hdrc->param_addr),
+				   sizeof(struct viif_l1_hdrc)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_hdrc(viif_dev->hwd_res, hdrc->param_addr ? &param : NULL,
+				   hdrc->hdrc_thr_sft_amt);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrc_ltm(struct viif_device *viif_dev,
+				struct viif_l1_hdrc_ltm_config *l1_hdrc_ltm)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_hdrc_ltm(viif_dev->hwd_res, l1_hdrc_ltm);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_gamma(struct viif_device *viif_dev, struct viif_l1_gamma_config *l1_gamma)
+{
+	struct viif_l1_gamma param;
+	unsigned long irqflags;
+	int ret;
+
+	if (l1_gamma->param_addr) {
+		if (copy_from_user(&param, u64_to_user_ptr(l1_gamma->param_addr),
+				   sizeof(struct viif_l1_gamma)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_gamma(viif_dev->hwd_res, l1_gamma->param_addr ? &param : NULL);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int
+viif_l1_set_img_quality_adjustment(struct viif_device *viif_dev,
+				   struct viif_l1_img_quality_adjustment_config *img_quality)
+{
+	struct hwd_viif_l1_img_quality_adjustment hwd_img_quality;
+	struct viif_l1_lum_noise_reduction lum_noise;
+	struct viif_l1_nonlinear_contrast nonlinear;
+	struct viif_l1_coring_suppression coring;
+	struct viif_l1_edge_enhancement edge_enh;
+	struct viif_l1_edge_suppression edge_sup;
+	struct viif_l1_uv_suppression uv;
+	struct viif_l1_color_level color;
+	unsigned long irqflags;
+	int ret;
+
+	hwd_img_quality.coef_cb = img_quality->coef_cb;
+	hwd_img_quality.coef_cr = img_quality->coef_cr;
+	hwd_img_quality.brightness = img_quality->brightness;
+	hwd_img_quality.linear_contrast = img_quality->linear_contrast;
+	hwd_img_quality.color_noise_reduction_enable = img_quality->color_noise_reduction_enable;
+
+	if (img_quality->nonlinear_contrast_addr) {
+		if (copy_from_user(&nonlinear,
+				   u64_to_user_ptr(img_quality->nonlinear_contrast_addr),
+				   sizeof(struct viif_l1_nonlinear_contrast)))
+			return -EFAULT;
+		hwd_img_quality.nonlinear_contrast = &nonlinear;
+	} else {
+		hwd_img_quality.nonlinear_contrast = NULL;
+	}
+	if (img_quality->lum_noise_reduction_addr) {
+		if (copy_from_user(&lum_noise,
+				   u64_to_user_ptr(img_quality->lum_noise_reduction_addr),
+				   sizeof(struct viif_l1_lum_noise_reduction)))
+			return -EFAULT;
+		hwd_img_quality.lum_noise_reduction = &lum_noise;
+	} else {
+		hwd_img_quality.lum_noise_reduction = NULL;
+	}
+	if (img_quality->edge_enhancement_addr) {
+		if (copy_from_user(&edge_enh, u64_to_user_ptr(img_quality->edge_enhancement_addr),
+				   sizeof(struct viif_l1_edge_enhancement)))
+			return -EFAULT;
+		hwd_img_quality.edge_enhancement = &edge_enh;
+	} else {
+		hwd_img_quality.edge_enhancement = NULL;
+	}
+	if (img_quality->uv_suppression_addr) {
+		if (copy_from_user(&uv, u64_to_user_ptr(img_quality->uv_suppression_addr),
+				   sizeof(struct viif_l1_uv_suppression)))
+			return -EFAULT;
+		hwd_img_quality.uv_suppression = &uv;
+	} else {
+		hwd_img_quality.uv_suppression = NULL;
+	}
+	if (img_quality->coring_suppression_addr) {
+		if (copy_from_user(&coring, u64_to_user_ptr(img_quality->coring_suppression_addr),
+				   sizeof(struct viif_l1_coring_suppression)))
+			return -EFAULT;
+		hwd_img_quality.coring_suppression = &coring;
+	} else {
+		hwd_img_quality.coring_suppression = NULL;
+	}
+	if (img_quality->edge_suppression_addr) {
+		if (copy_from_user(&edge_sup, u64_to_user_ptr(img_quality->edge_suppression_addr),
+				   sizeof(struct viif_l1_edge_suppression)))
+			return -EFAULT;
+		hwd_img_quality.edge_suppression = &edge_sup;
+	} else {
+		hwd_img_quality.edge_suppression = NULL;
+	}
+	if (img_quality->color_level_addr) {
+		if (copy_from_user(&color, u64_to_user_ptr(img_quality->color_level_addr),
+				   sizeof(struct viif_l1_color_level)))
+			return -EFAULT;
+		hwd_img_quality.color_level = &color;
+	} else {
+		hwd_img_quality.color_level = NULL;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_img_quality_adjustment(viif_dev->hwd_res, &hwd_img_quality);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_avg_lum_generation(struct viif_device *viif_dev,
+					  struct viif_l1_avg_lum_generation_config *l1_avg_lum)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l1_set_avg_lum_generation(viif_dev->hwd_res, l1_avg_lum);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_DPC_TABLE_SIZE_MIN 1024
+#define VISCONTI_VIIF_DPC_TABLE_SIZE_MAX 8192
+static int viif_l2_set_undist(struct viif_device *viif_dev, struct viif_l2_undist_config *undist)
+{
+	uintptr_t table_write_g_paddr = 0;
+	uintptr_t table_read_b_paddr = 0;
+	uintptr_t table_read_g_paddr = 0;
+	uintptr_t table_read_r_paddr = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if ((undist->size && undist->size < VISCONTI_VIIF_DPC_TABLE_SIZE_MIN) ||
+	    undist->size > VISCONTI_VIIF_DPC_TABLE_SIZE_MAX)
+		return -EINVAL;
+
+	if (undist->write_g_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_write_g,
+				   u64_to_user_ptr(undist->write_g_addr), undist->size))
+			return -EFAULT;
+		table_write_g_paddr = (uintptr_t)viif_dev->table_paddr->undist_write_g;
+	}
+	if (undist->read_b_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_b,
+				   u64_to_user_ptr(undist->read_b_addr), undist->size))
+			return -EFAULT;
+		table_read_b_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_b;
+	}
+	if (undist->read_g_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_g,
+				   u64_to_user_ptr(undist->read_g_addr), undist->size))
+			return -EFAULT;
+		table_read_g_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_g;
+	}
+	if (undist->read_r_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_r,
+				   u64_to_user_ptr(undist->read_r_addr), undist->size))
+			return -EFAULT;
+		table_read_r_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_r;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l2_set_undist_table_transmission(viif_dev->hwd_res, table_write_g_paddr,
+							table_read_b_paddr, table_read_g_paddr,
+							table_read_r_paddr, undist->size);
+	if (ret) {
+		dev_err(viif_dev->dev, "l2_set_undist_table_transmission error. %d\n", ret);
+		goto err;
+	}
+
+	ret = hwd_viif_l2_set_undist(viif_dev->hwd_res, &undist->param);
+
+err:
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l2_set_roi(struct viif_device *viif_dev, struct viif_l2_roi_config *roi)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l2_set_roi(viif_dev->hwd_res, roi);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l2_set_roi_wrap(struct viif_device *viif_dev, struct viif_l2_roi_config *roi)
+{
+	int ret;
+
+	ret = viif_l2_set_roi(viif_dev, roi);
+	if (!ret)
+		visconti_viif_isp_set_compose_rect(viif_dev, roi);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_GANMMA_TABLE_SIZE 512
+static int viif_l2_set_gamma(struct viif_device *viif_dev, struct viif_l2_gamma_config *l2_gamma)
+{
+	struct hwd_viif_l2_gamma_table hwd_table = { 0 };
+	int pathid = l2_gamma->pathid;
+	unsigned long irqflags;
+	int postid;
+	int ret;
+	u32 i;
+
+	if (pathid == CAPTURE_PATH_MAIN_POST0)
+		postid = VIIF_L2ISP_POST_0;
+	else if (pathid == CAPTURE_PATH_MAIN_POST1)
+		postid = VIIF_L2ISP_POST_1;
+	else
+		return -EINVAL;
+
+	for (i = 0; i < 6; i++) {
+		if (l2_gamma->table_addr[i]) {
+			if (copy_from_user(viif_dev->table_vaddr->l2_gamma_table[pathid][i],
+					   u64_to_user_ptr(l2_gamma->table_addr[i]),
+					   VISCONTI_VIIF_GANMMA_TABLE_SIZE))
+				return -EFAULT;
+			hwd_table.table[i] =
+				(uintptr_t)viif_dev->table_paddr->l2_gamma_table[pathid][i];
+		}
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	ret = hwd_viif_l2_set_gamma_table_transmission(viif_dev->hwd_res, postid, &hwd_table);
+	if (ret)
+		goto err;
+
+	ret = hwd_viif_l2_set_gamma(viif_dev->hwd_res, postid, l2_gamma->enable, l2_gamma->vsplit,
+				    l2_gamma->mode);
+err:
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int
+viif_csi2rx_get_calibration_status(struct viif_device *viif_dev,
+				   struct viif_csi2rx_dphy_calibration_status *calibration_status)
+{
+	int ret;
+
+	if (!vb2_is_streaming(&viif_dev->cap_dev0.vb2_vq))
+		return -EIO;
+
+	ret = hwd_viif_csi2rx_get_calibration_status(viif_dev->hwd_res, calibration_status);
+
+	return ret;
+}
+
+static int viif_csi2rx_get_err_status(struct viif_device *viif_dev,
+				      struct viif_csi2rx_err_status *csi_err)
+{
+	int ret;
+
+	if (!vb2_is_streaming(&viif_dev->cap_dev0.vb2_vq))
+		return -EIO;
+
+	ret = hwd_viif_csi2rx_get_err_status(viif_dev->hwd_res, &csi_err->err_phy_fatal,
+					     &csi_err->err_pkt_fatal, &csi_err->err_frame_fatal,
+					     &csi_err->err_phy, &csi_err->err_pkt,
+					     &csi_err->err_line);
+
+	return ret;
+}
+
+static int viif_isp_get_last_capture_status(struct viif_device *viif_dev,
+					    struct viif_isp_capture_status *status)
+{
+	struct hwd_viif_l1_info l1_info;
+	unsigned long irqflags;
+	int i, j;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->hwd_res);
+	hwd_viif_isp_get_info(viif_dev->hwd_res, &l1_info, NULL);
+	hwd_viif_isp_guard_end(viif_dev->hwd_res);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	status->l1_info.avg_lum_weight = l1_info.avg_lum_weight;
+	for (i = 0; i < 8; i++) {
+		for (j = 0; j < 8; j++)
+			status->l1_info.avg_lum_block[i][j] = l1_info.avg_lum_block[i][j];
+	}
+	for (i = 0; i < 4; i++)
+		status->l1_info.avg_lum_four_line_lum[i] = l1_info.avg_lum_four_line_lum[i];
+
+	status->l1_info.avg_satur_pixnum = l1_info.avg_satur_pixnum;
+	status->l1_info.avg_black_pixnum = l1_info.avg_black_pixnum;
+	status->l1_info.awb_ave_u = l1_info.awb_ave_u;
+	status->l1_info.awb_ave_v = l1_info.awb_ave_v;
+	status->l1_info.awb_accumulated_pixel = l1_info.awb_accumulated_pixel;
+	status->l1_info.awb_gain_r = l1_info.awb_gain_r;
+	status->l1_info.awb_gain_g = l1_info.awb_gain_g;
+	status->l1_info.awb_gain_b = l1_info.awb_gain_b;
+	status->l1_info.awb_status_u = l1_info.awb_status_u;
+	status->l1_info.awb_status_v = l1_info.awb_status_v;
+
+	return 0;
+}
+
+static int viif_isp_get_reported_errors(struct viif_device *viif_dev,
+					struct viif_reported_errors *status)
+{
+	status->main = viif_dev->reported_err_main;
+	status->sub = viif_dev->reported_err_sub;
+	status->csi2rx = viif_dev->reported_err_csi2rx;
+	viif_dev->reported_err_main = 0;
+	viif_dev->reported_err_sub = 0;
+	viif_dev->reported_err_csi2rx = 0;
+
+	return 0;
+}
+
+/* ===== v4l2 subdevice control handlers ===== */
+#define COMPOUND_TYPE_SAMPLE01 0x0280
+
+static int visconti_viif_isp_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct viif_device *viif_dev = ctrl->priv;
+
+	pr_info("isp_set_ctrl: %s", ctrl->name);
+	if (pm_runtime_status_suspended(viif_dev->dev)) {
+		pr_info("warning: visconti viif HW is not powered");
+		return 0;
+	}
+
+	switch (ctrl->id) {
+	case V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
+		return viif_main_set_rawpack_mode(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
+		return viif_l1_set_input_mode(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF:
+		return viif_l1_set_rgb_to_y_coef(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE:
+		return viif_l1_set_ag_mode(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG:
+		return viif_l1_set_ag(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE:
+		return viif_l1_set_hdre(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION:
+		return viif_l1_set_img_extraction(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC:
+		return viif_l1_set_dpc(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE:
+		return viif_l1_set_preset_white_balance(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION:
+		return viif_l1_set_raw_color_noise_reduction(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS:
+		return viif_l1_set_hdrs(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
+		return viif_l1_set_black_level_correction(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC:
+		return viif_l1_set_lsc(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
+		return viif_l1_set_main_process(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
+		return viif_l1_set_awb(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN:
+		return viif_l1_lock_awb_gain(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
+		return viif_l1_set_hdrc(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM:
+		return viif_l1_set_hdrc_ltm(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA:
+		return viif_l1_set_gamma(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
+		return viif_l1_set_img_quality_adjustment(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION:
+		return viif_l1_set_avg_lum_generation(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
+		return viif_l2_set_undist(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
+		return viif_l2_set_roi_wrap(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA:
+		return viif_l2_set_gamma(viif_dev, ctrl->p_new.p);
+	default:
+		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
+		break;
+	}
+	return 0;
+}
+
+static int visconti_viif_isp_get_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct viif_device *viif_dev = ctrl->priv;
+
+	pr_info("isp_get_ctrl: %s", ctrl->name);
+	if (pm_runtime_status_suspended(viif_dev->dev)) {
+		pr_info("warning: visconti viif HW is not powered");
+		return 0;
+	}
+
+	switch (ctrl->id) {
+	case V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
+		return viif_csi2rx_get_calibration_status(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS:
+		return viif_csi2rx_get_err_status(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
+		return viif_isp_get_last_capture_status(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS:
+		return viif_isp_get_reported_errors(viif_dev, ctrl->p_new.p);
+	default:
+		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
+		break;
+	}
+	return 0;
+}
+
+/* ===== register v4l2 subdevice controls ===== */
+static bool visconti_viif_isp_custom_ctrl_equal(const struct v4l2_ctrl *ctrl,
+						union v4l2_ctrl_ptr ptr1, union v4l2_ctrl_ptr ptr2)
+{
+	return !memcmp(ptr1.p_const, ptr2.p_const, ctrl->elem_size);
+}
+
+static void visconti_viif_isp_custom_ctrl_init(const struct v4l2_ctrl *ctrl, u32 idx,
+					       union v4l2_ctrl_ptr ptr)
+{
+	if (ctrl->p_def.p_const)
+		memcpy(ptr.p, ctrl->p_def.p_const, ctrl->elem_size);
+	else
+		memset(ptr.p, 0, ctrl->elem_size);
+}
+
+static void visconti_viif_isp_custom_ctrl_log(const struct v4l2_ctrl *ctrl)
+{
+}
+
+static int visconti_viif_isp_custom_ctrl_validate(const struct v4l2_ctrl *ctrl,
+						  union v4l2_ctrl_ptr ptr)
+{
+	pr_info("std_validate: %s", ctrl->name);
+	return 0;
+}
+
+static const struct v4l2_ctrl_type_ops custom_type_ops = {
+	.equal = visconti_viif_isp_custom_ctrl_equal,
+	.init = visconti_viif_isp_custom_ctrl_init,
+	.log = visconti_viif_isp_custom_ctrl_log,
+	.validate = visconti_viif_isp_custom_ctrl_validate,
+};
+
+static const struct v4l2_ctrl_ops visconti_viif_isp_ctrl_ops = {
+	.g_volatile_ctrl = visconti_viif_isp_get_ctrl,
+	.s_ctrl = visconti_viif_isp_set_ctrl,
+};
+
+/* ----- control handler ----- */
+#define CTRL_CONFIG_DEFAULT_ENTRY                                         \
+	.ops = &visconti_viif_isp_ctrl_ops, .type_ops = &custom_type_ops, \
+	.type = COMPOUND_TYPE_SAMPLE01, .flags = V4L2_CTRL_FLAG_EXECUTE_ON_WRITE
+
+#define CTRL_CONFIG_RDONLY_ENTRY                                          \
+	.ops = &visconti_viif_isp_ctrl_ops, .type_ops = &custom_type_ops, \
+	.type = COMPOUND_TYPE_SAMPLE01, .flags = V4L2_CTRL_FLAG_VOLATILE
+
+static const struct v4l2_ctrl_config visconti_viif_isp_ctrl_config[] = {
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE,
+		.name = "rawpack_mode",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(u32),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE,
+		.name = "l1_input_mode",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_input_mode_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF,
+		.name = "l1_rgb_to_y_coef",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_rgb_to_y_coef_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE,
+		.name = "l1_ag_mode",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_ag_mode_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG,
+		.name = "l1_ag",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_ag_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE,
+		.name = "l1_hdre",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdre_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION,
+		.name = "l1_img_extraction",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_img_extraction_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC,
+		.name = "l1_dpc",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_dpc_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE,
+		.name = "l1_preset_white_balance",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_preset_white_balance_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION,
+		.name = "l1_raw_color_noise_reduction",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_raw_color_noise_reduction_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS,
+		.name = "l1_set_hdrs",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdrs_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION,
+		.name = "l1_black_level_correction",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_black_level_correction_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC,
+		.name = "l1_lsc",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_lsc_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS,
+		.name = "l1_main_process",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_main_process_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB,
+		.name = "l1_awb",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_awb_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN,
+		.name = "l1_lock_awb_gain",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(u32),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC,
+		.name = "l1_hdrc",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdrc_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM,
+		.name = "l1_hdrc_ltm",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdrc_ltm_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA,
+		.name = "l1_gamma",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_gamma_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT,
+		.name = "l1_img_quality_adjustment",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_img_quality_adjustment_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION,
+		.name = "l1_avg_lum",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_avg_lum_generation_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST,
+		.name = "l2_undist",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l2_undist_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI,
+		.name = "l2_roi",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l2_roi_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA,
+		.name = "l2_gamma",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l2_gamma_config),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS,
+		.name = "csi2rx_calibration_status",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_csi2rx_dphy_calibration_status),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS,
+		.name = "csi2rx_err_status",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_csi2rx_err_status),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS,
+		.name = "last_capture_status",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_isp_capture_status),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS,
+		.name = "reported errors",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_reported_errors),
+	},
+};
+
+int visconti_viif_isp_init_controls(struct viif_device *viif_dev)
+{
+	struct v4l2_ctrl_handler *ctrl_handler = &viif_dev->isp_subdev.ctrl_handler;
+	int ret;
+	int i;
+
+	ret = v4l2_ctrl_handler_init(ctrl_handler, 10);
+	if (ret) {
+		dev_err(viif_dev->dev, "failed on v4l2_ctrl_handler_init");
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(visconti_viif_isp_ctrl_config); i++) {
+		struct v4l2_ctrl *ctrl;
+
+		ctrl = v4l2_ctrl_new_custom(ctrl_handler, &visconti_viif_isp_ctrl_config[i],
+					    viif_dev);
+		if (!ctrl) {
+			dev_err(viif_dev->dev, "failed to add ctrl crop: %d", ctrl_handler->error);
+			return ctrl_handler->error;
+		}
+	}
+
+	viif_dev->isp_subdev.sd.ctrl_handler = &viif_dev->isp_subdev.ctrl_handler;
+	return 0;
+}
diff --git a/drivers/media/platform/visconti/viif_isp.c b/drivers/media/platform/visconti/viif_isp.c
index 9314e6e8661..9aeb8bcab9b 100644
--- a/drivers/media/platform/visconti/viif_isp.c
+++ b/drivers/media/platform/visconti/viif_isp.c
@@ -818,6 +818,8 @@ int visconti_viif_isp_register(struct viif_device *viif_dev)
 
 	mutex_init(&viif_dev->isp_subdev.ops_lock);
 
+	visconti_viif_isp_init_controls(viif_dev);
+
 	ret = media_entity_pads_init(&sd->entity, 4, pads);
 	if (ret) {
 		dev_err(viif_dev->dev, "Failed on media_entity_pads_init\n");
-- 
2.25.1


