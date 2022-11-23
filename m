Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8F6350D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiKWHAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiKWHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:00:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA1F5A06;
        Tue, 22 Nov 2022 23:00:33 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEC671373;
        Wed, 23 Nov 2022 08:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669186830;
        bh=3fphJVPxicGLurGTXvkQUE9p+5BG3KUJATq5hRVNQpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNoNLXji6WI7jRt6XJeAXNMFVzuCYtF+oveYW3Fn8gQNUEbI6D5xxZb9bnVfQPpWe
         cWLONf2Ej98LyTyH2UPgthUOo5/wdSEbc9c+BElcDJqqjB/d6gW+8ddRQqROta1y6Z
         eIxxQ0AQ/UB77phm8p/SryFNLoWwsvj9KGfHvLNA=
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v2 6/7] drm: rcar-du: Add r8a779g0 support
Date:   Wed, 23 Nov 2022 08:59:45 +0200
Message-Id: <20221123065946.40415-7-tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
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

Add support for DU on r8a779g0, which is identical to DU on r8a779a0.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 22 ++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_group.c |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index d003e8d9e7a2..46c60a2d710d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -524,6 +524,27 @@ static const struct rcar_du_device_info rcar_du_r8a779a0_info = {
 	.dsi_clk_mask =  BIT(1) | BIT(0),
 };
 
+static const struct rcar_du_device_info rcar_du_r8a779g0_info = {
+	.gen = 4,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_NO_BLENDING,
+	.channels_mask = BIT(1) | BIT(0),
+	.routes = {
+		/* R8A779G0 has two MIPI DSI outputs. */
+		[RCAR_DU_OUTPUT_DSI0] = {
+			.possible_crtcs = BIT(0),
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_DSI1] = {
+			.possible_crtcs = BIT(1),
+			.port = 1,
+		},
+	},
+	.num_rpf = 5,
+	.dsi_clk_mask =  BIT(1) | BIT(0),
+};
+
 static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7742", .data = &rcar_du_r8a7790_info },
 	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
@@ -549,6 +570,7 @@ static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a77990", .data = &rcar_du_r8a7799x_info },
 	{ .compatible = "renesas,du-r8a77995", .data = &rcar_du_r8a7799x_info },
 	{ .compatible = "renesas,du-r8a779a0", .data = &rcar_du_r8a779a0_info },
+	{ .compatible = "renesas,du-r8a779g0", .data = &rcar_du_r8a779g0_info },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 1fe8581577ed..6da01760ede5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -107,7 +107,7 @@ static void rcar_du_group_setup_didsr(struct rcar_du_group *rgrp)
 		 */
 		rcrtc = rcdu->crtcs;
 		num_crtcs = rcdu->num_crtcs;
-	} else if (rcdu->info->gen == 3 && rgrp->num_crtcs > 1) {
+	} else if (rcdu->info->gen >= 3 && rgrp->num_crtcs > 1) {
 		/*
 		 * On Gen3 dot clocks are setup through per-group registers,
 		 * only available when the group has two channels.
-- 
2.34.1

