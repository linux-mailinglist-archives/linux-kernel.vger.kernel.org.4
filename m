Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696DE6DD9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDKLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDKLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:45:01 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46E3146AB;
        Tue, 11 Apr 2023 04:44:39 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; 
   d="scan'208";a="155597425"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2023 20:44:03 +0900
Received: from localhost.localdomain (unknown [10.226.93.123])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D7C51400195D;
        Tue, 11 Apr 2023 20:43:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 16/17] drm: rcar-du: Move rcar_du_properties_init()
Date:   Tue, 11 Apr 2023 12:42:34 +0100
Message-Id: <20230411114235.366042-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
References: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rcar_du_properties_init() to RCar DU kms lib, so that it can be
shared by both RCar and RZ/G2L kms drivers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Rebased to drm-tip.
v1->v6:
 * Rebased on drm-misc-next and DU-next.
v1:
 * Created the lib suggested by Laurent.
Ref:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220316131100.30685-6-biju.das.jz@bp.renesas.com/
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 16 ----------------
 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c | 16 ++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h |  2 ++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 94f1602ea707..01ffe36f9d44 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -69,22 +69,6 @@ static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-static int rcar_du_properties_init(struct rcar_du_device *rcdu)
-{
-	/*
-	 * The color key is expressed as an RGB888 triplet stored in a 32-bit
-	 * integer in XRGB8888 format. Bit 24 is used as a flag to disable (0)
-	 * or enable source color keying (1).
-	 */
-	rcdu->props.colorkey =
-		drm_property_create_range(&rcdu->ddev, 0, "colorkey",
-					  0, 0x01ffffff);
-	if (rcdu->props.colorkey == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
 {
 	const struct device_node *np = rcdu->dev->of_node;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
index 781e666a45a8..438a56c550f2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
@@ -637,3 +637,19 @@ int rcar_du_encoders_init(struct rcar_du_device *rcdu,
 
 	return num_encoders;
 }
+
+int rcar_du_properties_init(struct rcar_du_device *rcdu)
+{
+	/*
+	 * The color key is expressed as an RGB888 triplet stored in a 32-bit
+	 * integer in XRGB8888 format. Bit 24 is used as a flag to disable (0)
+	 * or enable source color keying (1).
+	 */
+	rcdu->props.colorkey =
+		drm_property_create_range(&rcdu->ddev, 0, "colorkey",
+					  0, 0x01ffffff);
+	if (rcdu->props.colorkey == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
index ace973b80fe6..50e92a19d98c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
@@ -51,4 +51,6 @@ int rcar_du_encoders_init(struct rcar_du_device *rcdu,
 						 enum rcar_du_output output,
 						 struct device_node *enc_node));
 
+int rcar_du_properties_init(struct rcar_du_device *rcdu);
+
 #endif /* __RCAR_DU_KMS_LIB_H__ */
-- 
2.25.1

