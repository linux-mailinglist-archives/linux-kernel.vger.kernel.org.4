Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3548262F19A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiKRJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbiKRJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:41:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D2B49C;
        Fri, 18 Nov 2022 01:40:38 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E29DD86;
        Fri, 18 Nov 2022 10:40:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764435;
        bh=zt5qnK9bau8az+DBE5Sylb/XdI1YajQxUEguWdncCf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxWm/2h+rmHun4jMuqyWuN+0YL6qMo2CsoOpgzk0oPYTxo0IH5aW4fce5Bsh8QQT4
         zOwQn1KsLNI6intqQ40yZj8MX/kmPoDvBEd/nGeMAHb3UNwwZXiVnBVC6Ijua9zt7b
         jVJiRc+REFc/hCQRtlg5m5ji37AW1RMUj9vy/gPw=
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
Subject: [PATCH v3 13/14] media: rkisp1: Add YC swap capability
Date:   Fri, 18 Nov 2022 18:39:30 +0900
Message-Id: <20221118093931.1284465-14-paul.elder@ideasonboard.com>
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

The ISP version in the i.MX8MP has an MI_OUTPUT_ALIGN_FORMAT register
that the rk3399 does not have. This register allows swapping bytes,
which can be used to implement UYVY from YUYV.

Add a feature flag to signify the presence of this feature, and add it
to the i.MX8MP match data. Also add it as a flag to the format info in
the list of supported formats by the capture v4l2 devices, and update
enum_fmt and s_fmt to take it into account.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 26 ++++++++++++++-----
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  2 ++
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  3 ++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 94e173706eb4..29565440b6e7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -47,13 +47,15 @@ enum rkisp1_plane {
  * @fourcc: pixel format
  * @fmt_type: helper filed for pixel format
  * @uv_swap: if cb cr swapped, for yuv
+ * @yc_swap: if y and cb/cr swapped, for yuv
  * @write_format: defines how YCbCr self picture data is written to memory
  * @output_format: defines sp output format
  * @mbus: the mbus code on the src resizer pad that matches the pixel format
  */
 struct rkisp1_capture_fmt_cfg {
 	u32 fourcc;
-	u8 uv_swap;
+	u32 uv_swap : 1;
+	u32 yc_swap : 1;
 	u32 write_format;
 	u32 output_format;
 	u32 mbus;
@@ -1126,10 +1128,14 @@ rkisp1_fill_pixfmt(struct v4l2_pix_format_mplane *pixm,
 static const struct rkisp1_capture_fmt_cfg *
 rkisp1_find_fmt_cfg(const struct rkisp1_capture *cap, const u32 pixelfmt)
 {
+	bool yc_swap_support = rkisp1_has_feature(cap->rkisp1, MI_OUTPUT_ALIGN);
 	unsigned int i;
 
 	for (i = 0; i < cap->config->fmt_size; i++) {
-		if (cap->config->fmts[i].fourcc == pixelfmt)
+		const struct rkisp1_capture_fmt_cfg *fmt = &cap->config->fmts[i];
+
+		if (fmt->fourcc == pixelfmt &&
+		    (!fmt->yc_swap || yc_swap_support))
 			return &cap->config->fmts[i];
 	}
 	return NULL;
@@ -1199,23 +1205,29 @@ static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
 {
 	struct rkisp1_capture *cap = video_drvdata(file);
 	const struct rkisp1_capture_fmt_cfg *fmt = NULL;
+	bool yc_swap_support = rkisp1_has_feature(cap->rkisp1, MI_OUTPUT_ALIGN);
 	unsigned int i, n = 0;
 
-	if (!f->mbus_code) {
-		if (f->index >= cap->config->fmt_size)
-			return -EINVAL;
+	if (f->index >= cap->config->fmt_size)
+		return -EINVAL;
 
+	if (!f->mbus_code && yc_swap_support) {
 		fmt = &cap->config->fmts[f->index];
 		f->pixelformat = fmt->fourcc;
 		return 0;
 	}
 
 	for (i = 0; i < cap->config->fmt_size; i++) {
-		if (cap->config->fmts[i].mbus != f->mbus_code)
+		fmt = &cap->config->fmts[i];
+
+		if (f->mbus_code && fmt->mbus != f->mbus_code)
+			continue;
+
+		if (!yc_swap_support && fmt->yc_swap)
 			continue;
 
 		if (n++ == f->index) {
-			f->pixelformat = cap->config->fmts[i].fourcc;
+			f->pixelformat = fmt->fourcc;
 			return 0;
 		}
 	}
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 8b6c0977ee91..8b317060ab97 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -107,6 +107,7 @@ enum rkisp1_isp_pad {
  * @RKISP1_FEATURE_RSZ_CROP: The ISP supports cropping in the resizer
  * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
  * @RKISP1_FEATURE_DMA_34BIT: The ISP uses 34-bit DMA addresses
+ * @RKISP1_FEATURE_MI_OUTPUT_ALIGN: The ISP has the MI_OUTPUT_ALIGN_FORMAT register
  *
  * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
  * the driver to implement support for features present in some ISP versions
@@ -119,6 +120,7 @@ enum rkisp1_feature {
 	RKISP1_FEATURE_MAIN_STRIDE = BIT(3),
 	RKISP1_FEATURE_DMA_34BIT = BIT(4),
 	RKISP1_FEATURE_SELF_PATH = BIT(5),
+	RKISP1_FEATURE_MI_OUTPUT_ALIGN = BIT(6),
 };
 
 #define rkisp1_has_feature(rkisp1, feature) \
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 8f3001bf7562..35fc1479f9cd 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -520,7 +520,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
 	.isp_ver = IMX8MP_V10,
 	.features = RKISP1_FEATURE_RSZ_CROP
 		  | RKISP1_FEATURE_MAIN_STRIDE
-		  | RKISP1_FEATURE_DMA_34BIT,
+		  | RKISP1_FEATURE_DMA_34BIT
+		  | RKISP1_FEATURE_MI_OUTPUT_ALIGN,
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
-- 
2.35.1

