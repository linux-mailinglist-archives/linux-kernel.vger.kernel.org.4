Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E444062F18E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiKRJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiKRJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:41:04 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B686AF0B5;
        Fri, 18 Nov 2022 01:40:28 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61CC2AF4;
        Fri, 18 Nov 2022 10:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764426;
        bh=vlEilDeP7g2oe4aEgGhDQ1m7gktQ5G5WmhU4D0o/ZZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHcMnQwcYOPjqNZBAI4J5h+rOLFK64/beAnKmkc1cjGUVp5x7RjtOabSkYUgsKCEZ
         0pI7HICfgST8A/JdQbyvt69ijNWxi9I4FGbghQmvUyj++JKL+8ddGLFRo0U2gHbbfR
         04e6qigu/TtixoBKcTiVU3VDuCqbF480dKK/mXKo=
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
Subject: [PATCH v3 11/14] media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
Date:   Fri, 18 Nov 2022 18:39:28 +0900
Message-Id: <20221118093931.1284465-12-paul.elder@ideasonboard.com>
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

The ISP that is integrated in the i.MX8MP supports cropping, which
results in a different RSZ_CTRL register layout compared to the RK3399.
Add new definitions for these bits, and use them when the
RKISP1_FEATURE_RSZ_CROP feature is set.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Changes since v2:

- Condition on RKISP1_FEATURE_RSZ_CROP feature
- Rename bits
- Use the rkisp1_has_feature() macro
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h   |  5 +++++
 .../media/platform/rockchip/rkisp1/rkisp1-resizer.c    | 10 ++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
index 3dd1bfec288f..39b2ac58196e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
@@ -168,6 +168,11 @@
 #define RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO		BIT(9)
 #define RKISP1_CIF_RSZ_SCALER_FACTOR			BIT(16)
 
+/* For resizer instances that support cropping */
+#define RKISP1_CIF_RSZ_CTRL_CROP_ENABLE			BIT(8)
+#define RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD		BIT(9)
+#define RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD_AUTO		BIT(10)
+
 /* RSZ_CROP_[XY]_DIR */
 #define RKISP1_CIF_RSZ_CROP_XY_DIR(start, end)		((end) << 16 | (start) << 0)
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index cefc3cfb733c..7ff7b608fc3f 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -209,9 +209,15 @@ static void rkisp1_rsz_update_shadow(struct rkisp1_resizer *rsz,
 	u32 ctrl_cfg = rkisp1_rsz_read(rsz, RKISP1_CIF_RSZ_CTRL);
 
 	if (when == RKISP1_SHADOW_REGS_ASYNC)
-		ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO;
+		if (rkisp1_has_feature(rsz->rkisp1, RSZ_CROP))
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD_AUTO;
+		else
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO;
 	else
-		ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD;
+		if (rkisp1_has_feature(rsz->rkisp1, RSZ_CROP))
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD;
+		else
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD;
 
 	rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_CTRL, ctrl_cfg);
 }
-- 
2.35.1

