Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A90666149
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjAKRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjAKQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:59:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92FFE8E;
        Wed, 11 Jan 2023 08:59:46 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:1ee3:efce:e4f6:17a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 39B996602DBF;
        Wed, 11 Jan 2023 16:59:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673456385;
        bh=NvjZMgRqIUAaayL7Y33wckgsoiGZkNhxprdn41Lwe1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJa4oGkvHxfyZPB9S6KuQfSWwoQvG+K9WPmo1oY4rsmFAvTrTxfyD4XmZicG+ARR4
         5eT+jMMFoB/lfxnIUleauWtCTDc1S4yvZUsc8vFtkj5eq4C23omBs4drgd6dy34mIb
         SY9SyoeXPDooM6HNsuACREFnCuNuARR3ZSCs2aRqEL9njI3wXjnqli6ApK8V+l8a84
         MWHIVI85+08URO3y1749DkLd0E1vI6DhxFCYyhh1ZvfCzpZomp8A7cc7PQBfVZY24U
         Kpeb9YX6lSR6w8WVB3lMiuqcZzNkBDI1WNH5mVRs/JhkNNu/G5BipPpq/LONR46uzV
         tY+TzNUfywC/Q==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 12/13] media: verisilicon: Enable AV1 decoder on rk3588
Date:   Wed, 11 Jan 2023 17:59:30 +0100
Message-Id: <20230111165931.753763-13-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rk3588 AV1 decoder to Hantro variant.
The hardware support image from 64x64 up to 7680x4320
by steps of 16 pixels.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
v3:
- Enable post-processor P010 support
 .../media/platform/verisilicon/hantro_drv.c   |   1 +
 .../media/platform/verisilicon/hantro_hw.h    |   6 +
 .../platform/verisilicon/rockchip_vpu_hw.c    | 134 ++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 16539e89935c..4fc6dea16ae6 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -688,6 +688,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
 	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
 	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
+	{ .compatible = "rockchip,rk3588-av1-vpu", .data = &rk3588_vpu981_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
 	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index bcd00dd71060..e8a584415d75 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -403,11 +403,13 @@ extern const struct hantro_variant rk3328_vpu_variant;
 extern const struct hantro_variant rk3399_vpu_variant;
 extern const struct hantro_variant rk3568_vepu_variant;
 extern const struct hantro_variant rk3568_vpu_variant;
+extern const struct hantro_variant rk3588_vpu981_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
 
 extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
 extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
+extern const struct hantro_postproc_ops rockchip_vpu981_postproc_ops;
 
 extern const u32 hantro_vp8_dec_mc_filter[8][6];
 
@@ -444,6 +446,10 @@ void hantro_hevc_ref_init(struct hantro_ctx *ctx);
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
 int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
 
+int rockchip_vpu981_av1_dec_init(struct hantro_ctx *ctx);
+void rockchip_vpu981_av1_dec_exit(struct hantro_ctx *ctx);
+int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx);
+void rockchip_vpu981_av1_dec_done(struct hantro_ctx *ctx);
 
 static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
 {
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 8de6fd2e8eef..fd05e3e2080e 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -13,9 +13,13 @@
 #include "hantro_g1_regs.h"
 #include "hantro_h1_regs.h"
 #include "rockchip_vpu2_regs.h"
+#include "rockchip_vpu981_regs.h"
 
 #define RK3066_ACLK_MAX_FREQ (300 * 1000 * 1000)
 #define RK3288_ACLK_MAX_FREQ (400 * 1000 * 1000)
+#define RK3588_ACLK_MAX_FREQ (300 * 1000 * 1000)
+
+#define ROCKCHIP_VPU981_MIN_SIZE 64
 
 /*
  * Supported formats.
@@ -74,6 +78,37 @@ static const struct hantro_fmt rockchip_vpu1_postproc_fmts[] = {
 	},
 };
 
+static const struct hantro_fmt rockchip_vpu981_postproc_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+		.postprocessed = true,
+		.frmsize = {
+			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+		.postprocessed = true,
+		.frmsize = {
+			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+};
+
 static const struct hantro_fmt rk3066_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
@@ -277,6 +312,48 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[] = {
 	},
 };
 
+static const struct hantro_fmt rockchip_vpu981_dec_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12_4L4,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+		.frmsize = {
+			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV12_10LE40_4L4,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+		.frmsize = {
+			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_AV1_FRAME,
+		.codec_mode = HANTRO_MODE_AV1_DEC,
+		.max_depth = 2,
+		.frmsize = {
+			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+};
+
 static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
 {
 	struct hantro_dev *vpu = dev_id;
@@ -331,6 +408,24 @@ static irqreturn_t rockchip_vpu2_vepu_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
+{
+	struct hantro_dev *vpu = dev_id;
+	enum vb2_buffer_state state;
+	u32 status;
+
+	status = vdpu_read(vpu, AV1_REG_INTERRUPT);
+	state = (status & AV1_REG_INTERRUPT_DEC_RDY_INT) ?
+		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
+
+	vdpu_write(vpu, 0, AV1_REG_INTERRUPT);
+	vdpu_write(vpu, AV1_REG_CONFIG_DEC_CLK_GATE_E, AV1_REG_CONFIG);
+
+	hantro_irq_done(vpu, state);
+
+	return IRQ_HANDLED;
+}
+
 static int rk3036_vpu_hw_init(struct hantro_dev *vpu)
 {
 	/* Bump ACLK to max. possible freq. to improve performance. */
@@ -346,6 +441,13 @@ static int rk3066_vpu_hw_init(struct hantro_dev *vpu)
 	return 0;
 }
 
+static int rk3588_vpu981_hw_init(struct hantro_dev *vpu)
+{
+	/* Bump ACLKs to max. possible freq. to improve performance. */
+	clk_set_rate(vpu->clocks[0].clk, RK3588_ACLK_MAX_FREQ);
+	return 0;
+}
+
 static int rockchip_vpu_hw_init(struct hantro_dev *vpu)
 {
 	/* Bump ACLK to max. possible freq. to improve performance. */
@@ -498,6 +600,14 @@ static const struct hantro_codec_ops rk3568_vepu_codec_ops[] = {
 	},
 };
 
+static const struct hantro_codec_ops rk3588_vpu981_codec_ops[] = {
+	[HANTRO_MODE_AV1_DEC] = {
+		.run = rockchip_vpu981_av1_dec_run,
+		.init = rockchip_vpu981_av1_dec_init,
+		.exit = rockchip_vpu981_av1_dec_exit,
+		.done = rockchip_vpu981_av1_dec_done,
+	},
+};
 /*
  * VPU variant.
  */
@@ -529,10 +639,18 @@ static const char * const rk3066_vpu_clk_names[] = {
 	"aclk_vepu", "hclk_vepu"
 };
 
+static const struct hantro_irq rk3588_vpu981_irqs[] = {
+	{ "vdpu", rk3588_vpu981_irq },
+};
+
 static const char * const rockchip_vpu_clk_names[] = {
 	"aclk", "hclk"
 };
 
+static const char * const rk3588_vpu981_vpu_clk_names[] = {
+	"aclk", "hclk", "aclk_vdpu_root", "hclk_vdpu_root"
+};
+
 /* VDPU1/VEPU1 */
 
 const struct hantro_variant rk3036_vpu_variant = {
@@ -678,3 +796,19 @@ const struct hantro_variant px30_vpu_variant = {
 	.clk_names = rockchip_vpu_clk_names,
 	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
 };
+
+const struct hantro_variant rk3588_vpu981_variant = {
+	.dec_offset = 0x0,
+	.dec_fmts = rockchip_vpu981_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(rockchip_vpu981_dec_fmts),
+	.postproc_fmts = rockchip_vpu981_postproc_fmts,
+	.num_postproc_fmts = ARRAY_SIZE(rockchip_vpu981_postproc_fmts),
+	.postproc_ops = &rockchip_vpu981_postproc_ops,
+	.codec = HANTRO_AV1_DECODER,
+	.codec_ops = rk3588_vpu981_codec_ops,
+	.irqs = rk3588_vpu981_irqs,
+	.num_irqs = ARRAY_SIZE(rk3588_vpu981_irqs),
+	.init = rk3588_vpu981_hw_init,
+	.clk_names = rk3588_vpu981_vpu_clk_names,
+	.num_clocks = ARRAY_SIZE(rk3588_vpu981_vpu_clk_names)
+};
-- 
2.34.1

