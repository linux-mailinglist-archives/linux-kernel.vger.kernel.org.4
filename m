Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E962F188
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbiKRJl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbiKRJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:40:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAFEAF083;
        Fri, 18 Nov 2022 01:40:19 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29F56CCA;
        Fri, 18 Nov 2022 10:40:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764418;
        bh=OZe8UzP1r/amDLtuf66g7oEGb1GwTcdAztGXNR0jAS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWbzAD1rNrp930cOMVq6fDRgkLBQT7pXm8hMF9nzZUVIoF+Knoyq/UO8xy/96qFbW
         A6E7QP6IfZ4vOuc/o+YRv2FCAo7T1kmamQ8C5X1+sfQ7Yi5y98ddgFpgwLPDyVx8wG
         sOfYgMqPcQNjCv9tehnZzmhA3D6argoi41u2qo3A=
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
Subject: [PATCH v3 09/14] media: rkisp1: Shift DMA buffer addresses on i.MX8MP
Date:   Fri, 18 Nov 2022 18:39:26 +0900
Message-Id: <20221118093931.1284465-10-paul.elder@ideasonboard.com>
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

On the ISP that is integrated in the i.MX8MP, DMA addresses have been
extended to 34 bits, with the 32 MSBs stored in the DMA address
registers and the 2 LSBs set to 0. Shift the buffer addresses right by 2
on that platform.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v2:

- Document the RKISP1_FEATURE_DMA_34BIT bit
- Use the rkisp1_has_feature() macro
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c  | 18 ++++++++++--------
 .../platform/rockchip/rkisp1/rkisp1-common.h   |  2 ++
 .../platform/rockchip/rkisp1/rkisp1-dev.c      |  3 ++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 5c6299ab0f78..55e863b762e6 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -624,6 +624,8 @@ static void rkisp1_dummy_buf_destroy(struct rkisp1_capture *cap)
 
 static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 {
+	u8 shift = rkisp1_has_feature(cap->rkisp1, DMA_34BIT) ? 2 : 0;
+
 	cap->buf.curr = cap->buf.next;
 	cap->buf.next = NULL;
 
@@ -636,7 +638,7 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 		buff_addr = cap->buf.next->buff_addr;
 
 		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
-			     buff_addr[RKISP1_PLANE_Y]);
+			     buff_addr[RKISP1_PLANE_Y] >> shift);
 		/*
 		 * In order to support grey format we capture
 		 * YUV422 planar format from the camera and
@@ -645,17 +647,17 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 		if (cap->pix.cfg->fourcc == V4L2_PIX_FMT_GREY) {
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cb_base_ad_init,
-				     cap->buf.dummy.dma_addr);
+				     cap->buf.dummy.dma_addr >> shift);
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cr_base_ad_init,
-				     cap->buf.dummy.dma_addr);
+				     cap->buf.dummy.dma_addr >> shift);
 		} else {
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cb_base_ad_init,
-				     buff_addr[RKISP1_PLANE_CB]);
+				     buff_addr[RKISP1_PLANE_CB] >> shift);
 			rkisp1_write(cap->rkisp1,
 				     cap->config->mi.cr_base_ad_init,
-				     buff_addr[RKISP1_PLANE_CR]);
+				     buff_addr[RKISP1_PLANE_CR] >> shift);
 		}
 	} else {
 		/*
@@ -663,11 +665,11 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 		 * throw data if there is no available buffer.
 		 */
 		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
-			     cap->buf.dummy.dma_addr);
+			     cap->buf.dummy.dma_addr >> shift);
 		rkisp1_write(cap->rkisp1, cap->config->mi.cb_base_ad_init,
-			     cap->buf.dummy.dma_addr);
+			     cap->buf.dummy.dma_addr >> shift);
 		rkisp1_write(cap->rkisp1, cap->config->mi.cr_base_ad_init,
-			     cap->buf.dummy.dma_addr);
+			     cap->buf.dummy.dma_addr >> shift);
 	}
 
 	/* Set plane offsets */
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 047c670b2310..fff5f5264386 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -106,6 +106,7 @@ enum rkisp1_isp_pad {
  * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
  * @RKISP1_FEATURE_RSZ_CROP: The ISP supports cropping in the resizer
  * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
+ * @RKISP1_FEATURE_DMA_34BIT: The ISP uses 34-bit DMA addresses
  *
  * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
  * the driver to implement support for features present in some ISP versions
@@ -116,6 +117,7 @@ enum rkisp1_feature {
 	RKISP1_FEATURE_DUAL_CROP = BIT(1),
 	RKISP1_FEATURE_RSZ_CROP = BIT(2),
 	RKISP1_FEATURE_MAIN_STRIDE = BIT(3),
+	RKISP1_FEATURE_DMA_34BIT = BIT(4),
 };
 
 #define rkisp1_has_feature(rkisp1, feature) \
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 1a3ea5a4af05..2b13962c5c32 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -516,7 +516,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
 	.isr_size = ARRAY_SIZE(imx8mp_isp_isrs),
 	.isp_ver = IMX8MP_V10,
 	.features = RKISP1_FEATURE_RSZ_CROP
-		  | RKISP1_FEATURE_MAIN_STRIDE,
+		  | RKISP1_FEATURE_MAIN_STRIDE
+		  | RKISP1_FEATURE_DMA_34BIT,
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
-- 
2.35.1

