Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9816C6AE68E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCGQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCGQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:10 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DC81CD9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=K
        SmFdOPKLYCNJfgM7xNMVh9zw+j6Ry9MBKk15S61PCk=; b=QoFqkIOdij8DrVq4M
        B12B1L6LVsd0RXz4z9JgR8m9f8RPeKHcwpu+ILuQdUzWBgEwpR2wQPBPMGh62OVn
        csP6BIRhBcdYCH78xmZf5vba1Dh0JnU9I0aFQ3h8LA1HjWjY0TnVER2u5chWm5JR
        v+2Q5G+uIAnx5gpZaOY2euP8dk=
Received: (qmail 751963 invoked from network); 7 Mar 2023 17:31:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:03 +0100
X-UD-Smtp-Session: l3s3148p1@wTYM8FH2To0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] media: rcar-vin: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:31 +0100
Message-Id: <20230307163041.3815-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 .../platform/renesas/rcar-vin/rcar-core.c     | 36 -------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-core.c b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
index 5e53d6b7036c..ac8f2126540b 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/sys_soc.h>
 
 #include <media/v4l2-async.h>
 #include <media/v4l2-fwnode.h>
@@ -1183,24 +1182,6 @@ static const struct rvin_info rcar_info_r8a7795 = {
 	.scaler = rvin_scaler_gen3,
 };
 
-static const struct rvin_group_route rcar_info_r8a7795es1_routes[] = {
-	{ .master = 0, .csi = RVIN_CSI20, .chsel = 0x04 },
-	{ .master = 0, .csi = RVIN_CSI21, .chsel = 0x05 },
-	{ .master = 0, .csi = RVIN_CSI40, .chsel = 0x03 },
-	{ .master = 4, .csi = RVIN_CSI20, .chsel = 0x04 },
-	{ .master = 4, .csi = RVIN_CSI21, .chsel = 0x05 },
-	{ .master = 4, .csi = RVIN_CSI41, .chsel = 0x03 },
-	{ /* Sentinel */ }
-};
-
-static const struct rvin_info rcar_info_r8a7795es1 = {
-	.model = RCAR_GEN3,
-	.use_mc = true,
-	.max_width = 4096,
-	.max_height = 4096,
-	.routes = rcar_info_r8a7795es1_routes,
-};
-
 static const struct rvin_group_route rcar_info_r8a7796_routes[] = {
 	{ .master = 0, .csi = RVIN_CSI20, .chsel = 0x04 },
 	{ .master = 0, .csi = RVIN_CSI40, .chsel = 0x03 },
@@ -1372,17 +1353,8 @@ static const struct of_device_id rvin_of_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, rvin_of_id_table);
 
-static const struct soc_device_attribute r8a7795es1[] = {
-	{
-		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = &rcar_info_r8a7795es1,
-	},
-	{ /* Sentinel */ }
-};
-
 static int rcar_vin_probe(struct platform_device *pdev)
 {
-	const struct soc_device_attribute *attr;
 	struct rvin_dev *vin;
 	int irq, ret;
 
@@ -1394,14 +1366,6 @@ static int rcar_vin_probe(struct platform_device *pdev)
 	vin->info = of_device_get_match_data(&pdev->dev);
 	vin->alpha = 0xff;
 
-	/*
-	 * Special care is needed on r8a7795 ES1.x since it
-	 * uses different routing than r8a7795 ES2.0.
-	 */
-	attr = soc_device_match(r8a7795es1);
-	if (attr)
-		vin->info = attr->data;
-
 	vin->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vin->base))
 		return PTR_ERR(vin->base);
-- 
2.35.1

