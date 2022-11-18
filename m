Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8962F19B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiKRJmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbiKRJl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:41:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB997089;
        Fri, 18 Nov 2022 01:40:40 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B79A8CE1;
        Fri, 18 Nov 2022 10:40:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764439;
        bh=rsTVUhZ7ZI6UsQMfahLSuxDlhDEF5B7vCEr3t98B15M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPWRwwZkjC9FzC+D3DSeZl54u6MeB1z2XeCJFsY2ndTK8H+9+X2beUZESLC/LkFiT
         z+G0NshynQOO6YZZQKpi6YgMG51M6YnN9ac94/xCHe3t5dmmnhhra/nsrDBrwxpHDd
         SX+nixP1/dIw/u9vGWRhmz7zlsyaaMXsK6+kVFKA=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] media: rkisp1: Add UYVY as an output format
Date:   Fri, 18 Nov 2022 18:39:31 +0900
Message-Id: <20221118093931.1284465-15-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UYVY as an output format. The uv_swap bit in the
MI_XTD_FORMAT_CTRL register that is used for the NV formats does not
work for packed YUV formats. Thus, UYVY support is implemented via
byte-swapping. This method clearly does not work for implementing
support for YVYU and VYUY.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 29565440b6e7..8a6a5d25a3b8 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -97,6 +97,12 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
 		.uv_swap = 0,
 		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
 		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.uv_swap = 0,
+		.yc_swap = 1,
+		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YUV422P,
 		.uv_swap = 0,
@@ -221,6 +227,13 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
 		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
 		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
 		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.uv_swap = 0,
+		.yc_swap = 1,
+		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
+		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YUV422P,
 		.uv_swap = 0,
@@ -442,6 +455,20 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
 		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
 	}
 
+	/*
+	 * U/V swapping with the MI_XTD_FORMAT_CTRL register only works for
+	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
+	 * YVYU and VYUY cannot be supported with this method.
+	 */
+	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
+		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
+		if (cap->pix.cfg->yc_swap)
+			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
+		else
+			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
+	}
+
 	rkisp1_mi_config_ctrl(cap);
 
 	reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
@@ -483,6 +510,20 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
 		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
 	}
 
+	/*
+	 * U/V swapping with the MI_XTD_FORMAT_CTRL register only works for
+	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
+	 * YVYU and VYUY cannot be supported with this method.
+	 */
+	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
+		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
+		if (cap->pix.cfg->yc_swap)
+			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
+		else
+			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
+		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
+	}
+
 	rkisp1_mi_config_ctrl(cap);
 
 	mi_ctrl = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
-- 
2.35.1

