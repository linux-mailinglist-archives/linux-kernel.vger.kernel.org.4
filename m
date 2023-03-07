Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78D6AE6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCGQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCGQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:37 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869B8ABFB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=FoqjTA8Za4V7Be
        7RYCx6I7pfuapKZ/gfbeqrJ+oZq7U=; b=lVTYO2h09AuGHmx0lS5IH2B2gRy/0H
        EZD0zooyaK8UpeBrlro8t4Tzzbzcz4t9pOD+XRaWvoigrKiZgaGBHxlTPDr7IlC8
        VzNsnewjdkjffMs9YN5AVi8287uiSh8D+GZn/VX/mx8ejokS/1pNbbDjHEUBQLKl
        jwU1HcVVWmawE=
Received: (qmail 752222 invoked from network); 7 Mar 2023 17:31:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:09 +0100
X-UD-Smtp-Session: l3s3148p1@ggVo8FH2io0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] usb: gadget: udc: renesas_usb3: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:39 +0100
Message-Id: <20230307163041.3815-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 drivers/usb/gadget/udc/renesas_usb3.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index bee6bceafc4f..f2ac6447b748 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -22,7 +22,6 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/sys_soc.h>
 #include <linux/uaccess.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -2781,13 +2780,6 @@ static void renesas_usb3_init_ram(struct renesas_usb3 *usb3, struct device *dev,
 	}
 }
 
-static const struct renesas_usb3_priv renesas_usb3_priv_r8a7795_es1 = {
-	.ramsize_per_ramif = SZ_16K,
-	.num_ramif = 2,
-	.ramsize_per_pipe = SZ_4K,
-	.workaround_for_vbus = true,
-};
-
 static const struct renesas_usb3_priv renesas_usb3_priv_gen3 = {
 	.ramsize_per_ramif = SZ_16K,
 	.num_ramif = 4,
@@ -2829,14 +2821,6 @@ static const struct of_device_id usb3_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, usb3_of_match);
 
-static const struct soc_device_attribute renesas_usb3_quirks_match[] = {
-	{
-		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = &renesas_usb3_priv_r8a7795_es1,
-	},
-	{ /* sentinel */ }
-};
-
 static const unsigned int renesas_usb3_cable[] = {
 	EXTCON_USB,
 	EXTCON_USB_HOST,
@@ -2854,13 +2838,8 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 	struct renesas_usb3 *usb3;
 	int irq, ret;
 	const struct renesas_usb3_priv *priv;
-	const struct soc_device_attribute *attr;
 
-	attr = soc_device_match(renesas_usb3_quirks_match);
-	if (attr)
-		priv = attr->data;
-	else
-		priv = of_device_get_match_data(&pdev->dev);
+	priv = of_device_get_match_data(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.35.1

