Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9167B191
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjAYLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjAYLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:36:45 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D08222D4;
        Wed, 25 Jan 2023 03:36:12 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30PBZcTj048421;
        Wed, 25 Jan 2023 05:35:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674646538;
        bh=xdh95E/zriEpwXRNgrK0urLgwz9fTz+KTg1FFi2xwbI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cUFD8L2gb3XRrRNVviOlKJ0FhWpmFNzAhR1dMSh64NjuM8QIP8kLdeP/wjHxN0W8Y
         4IeBp1d4LUXeDxteDIYMnzBUcZPXpjlT/xjCuq0gS1HjTHUkOiXIojX8wTYqZ6Oban
         BWmZwyWHepZelnyu4eLhBjWAQVH0Kf/dop0qRJrE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30PBZbwl013304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 05:35:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 05:35:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 05:35:37 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30PBZaQh021858;
        Wed, 25 Jan 2023 05:35:36 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v7 3/6] drm/tidss: Add support for AM625 DSS
Date:   Wed, 25 Jan 2023 17:05:26 +0530
Message-ID: <20230125113529.13952-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125113529.13952-1-a-bhatia1@ti.com>
References: <20230125113529.13952-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the DSS controller on TI's new AM625 SoC in the tidss
driver.

The first video port (VP0) in am625-dss can output OLDI signals through
2 OLDI TXes. A 3rd output port has been added with "DISPC_PORT_OLDI" bus
type.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 57 +++++++++++++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc.h |  2 +
 drivers/gpu/drm/tidss/tidss_drv.c   |  1 +
 3 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c1c4faccbddc..b55ccbcaa67f 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -140,6 +140,58 @@ static const u16 tidss_am65x_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 	[DISPC_SECURE_DISABLE_OFF] =		0xac,
 };
 
+const struct dispc_features dispc_am625_feats = {
+	.max_pclk_khz = {
+		[DISPC_PORT_DPI] = 165000,
+		[DISPC_PORT_OLDI] = 165000,
+	},
+
+	.scaling = {
+		.in_width_max_5tap_rgb = 1280,
+		.in_width_max_3tap_rgb = 2560,
+		.in_width_max_5tap_yuv = 2560,
+		.in_width_max_3tap_yuv = 4096,
+		.upscale_limit = 16,
+		.downscale_limit_5tap = 4,
+		.downscale_limit_3tap = 2,
+		/*
+		 * The max supported pixel inc value is 255. The value
+		 * of pixel inc is calculated like this: 1+(xinc-1)*bpp.
+		 * The maximum bpp of all formats supported by the HW
+		 * is 8. So the maximum supported xinc value is 32,
+		 * because 1+(32-1)*8 < 255 < 1+(33-1)*4.
+		 */
+		.xinc_max = 32,
+	},
+
+	.subrev = DISPC_AM625,
+
+	.common = "common",
+	.common_regs = tidss_am65x_common_regs,
+
+	.num_vps = 2,
+	.vp_name = { "vp1", "vp2" },
+	.ovr_name = { "ovr1", "ovr2" },
+	.vpclk_name =  { "vp1", "vp2" },
+
+	.vp_feat = { .color = {
+			.has_ctm = true,
+			.gamma_size = 256,
+			.gamma_type = TIDSS_GAMMA_8BIT,
+		},
+	},
+
+	.num_planes = 2,
+	/* note: vid is plane_id 0 and vidl1 is plane_id 1 */
+	.vid_name = { "vid", "vidl1" },
+	.vid_lite = { false, true, },
+	.vid_order = { 1, 0 },
+
+	/* 3rd output port is not representative of a 3rd pipeline */
+	.num_output_ports = 3,
+	.output_port_bus_type = { DISPC_PORT_OLDI, DISPC_PORT_DPI, DISPC_PORT_OLDI },
+};
+
 const struct dispc_features dispc_am65x_feats = {
 	.max_pclk_khz = {
 		[DISPC_PORT_DPI] = 165000,
@@ -783,6 +835,7 @@ dispc_irq_t dispc_read_and_clear_irqstatus(struct dispc_device *dispc)
 	switch (dispc->feat->subrev) {
 	case DISPC_K2G:
 		return dispc_k2g_read_and_clear_irqstatus(dispc);
+	case DISPC_AM625:
 	case DISPC_AM65X:
 	case DISPC_J721E:
 		return dispc_k3_read_and_clear_irqstatus(dispc);
@@ -798,6 +851,7 @@ void dispc_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 	case DISPC_K2G:
 		dispc_k2g_set_irqenable(dispc, mask);
 		break;
+	case DISPC_AM625:
 	case DISPC_AM65X:
 	case DISPC_J721E:
 		dispc_k3_set_irqenable(dispc, mask);
@@ -1288,6 +1342,7 @@ void dispc_ovr_set_plane(struct dispc_device *dispc, u32 hw_plane,
 		dispc_k2g_ovr_set_plane(dispc, hw_plane, hw_videoport,
 					x, y, layer);
 		break;
+	case DISPC_AM625:
 	case DISPC_AM65X:
 		dispc_am65x_ovr_set_plane(dispc, hw_plane, hw_videoport,
 					  x, y, layer);
@@ -2210,6 +2265,7 @@ static void dispc_plane_init(struct dispc_device *dispc)
 	case DISPC_K2G:
 		dispc_k2g_plane_init(dispc);
 		break;
+	case DISPC_AM625:
 	case DISPC_AM65X:
 	case DISPC_J721E:
 		dispc_k3_plane_init(dispc);
@@ -2316,6 +2372,7 @@ static void dispc_vp_write_gamma_table(struct dispc_device *dispc,
 	case DISPC_K2G:
 		dispc_k2g_vp_write_gamma_table(dispc, hw_videoport);
 		break;
+	case DISPC_AM625:
 	case DISPC_AM65X:
 		dispc_am65x_vp_write_gamma_table(dispc, hw_videoport);
 		break;
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 30fb44158347..971f2856f015 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -59,6 +59,7 @@ enum dispc_port_bus_type {
 
 enum dispc_dss_subrevision {
 	DISPC_K2G,
+	DISPC_AM625,
 	DISPC_AM65X,
 	DISPC_J721E,
 };
@@ -87,6 +88,7 @@ struct dispc_features {
 };
 
 extern const struct dispc_features dispc_k2g_feats;
+extern const struct dispc_features dispc_am625_feats;
 extern const struct dispc_features dispc_am65x_feats;
 extern const struct dispc_features dispc_j721e_feats;
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 2dac8727d2f4..8558dc6999d8 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -232,6 +232,7 @@ static void tidss_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id tidss_of_table[] = {
 	{ .compatible = "ti,k2g-dss", .data = &dispc_k2g_feats, },
+	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats, },
 	{ .compatible = "ti,am65x-dss", .data = &dispc_am65x_feats, },
 	{ .compatible = "ti,j721e-dss", .data = &dispc_j721e_feats, },
 	{ }
-- 
2.39.0

