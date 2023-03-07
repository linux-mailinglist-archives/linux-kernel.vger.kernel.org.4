Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202F26AE6A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCGQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCGQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:35 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E687DB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=juPKvg3mXsPI+d
        KK+OfMfbvis/2IhqLMDrHF/YQ7PsQ=; b=3lkWw1PH2ESzdu3ChWiC3w9aDSEBH7
        pQir+nKMoHWKsaU1AarnaMTWjb3cU52GhXObeKKQevM/KoLNJhAoUdBBieIvEesl
        33+0VqNGSJz7gJ+IsWZqbiJs+XsMzHzjhdtUm47IebC9fvhS0cXn+arvU2qdUuie
        MJJYshY1vj544=
Received: (qmail 752176 invoked from network); 7 Mar 2023 17:31:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:09 +0100
X-UD-Smtp-Session: l3s3148p1@QeZb8FH2iI0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] usb: host: xhci-rcar: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:38 +0100
Message-Id: <20230307163041.3815-11-wsa+renesas@sang-engineering.com>
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

 drivers/usb/host/xhci-rcar.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 567b096a24e9..c4925f8d6b06 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -12,26 +12,22 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/usb/phy.h>
-#include <linux/sys_soc.h>
 
 #include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-rzv2m.h"
 
 #define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
-#define XHCI_RCAR_FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
 #define XHCI_RCAR_FIRMWARE_NAME_V3	"r8a779x_usb3_v3.dlmem"
 
 /*
-* - The V3 firmware is for almost all R-Car Gen3 (except r8a7795 ES1.x)
-* - The V2 firmware is for r8a7795 ES1.x.
+* - The V3 firmware is for all R-Car Gen3
 * - The V2 firmware is possible to use on R-Car Gen2. However, the V2 causes
 *   performance degradation. So, this driver continues to use the V1 if R-Car
 *   Gen2.
 * - The V1 firmware is impossible to use on R-Car Gen3.
 */
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V1);
-MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V2);
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
 /*** Register Offset ***/
@@ -78,17 +74,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 #define RCAR_USB3_RX_POL_VAL	BIT(21)
 #define RCAR_USB3_TX_POL_VAL	BIT(4)
 
-/* For soc_device_attribute */
-#define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
-
-static const struct soc_device_attribute rcar_quirks_match[]  = {
-	{
-		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = (void *)RCAR_XHCI_FIRMWARE_V2,
-	},
-	{ /* sentinel */ }
-};
-
 static void xhci_rcar_start_gen2(struct usb_hcd *hcd)
 {
 	/* LCLK Select */
@@ -134,9 +119,6 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 	const struct firmware *fw;
 	int retval, index, j;
 	u32 data, val, temp;
-	u32 quirks = 0;
-	const struct soc_device_attribute *attr;
-	const char *firmware_name;
 
 	/*
 	 * According to the datasheet, "Upon the completion of FW Download,
@@ -145,17 +127,8 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 	if (readl(regs + RCAR_USB3_DL_CTRL) & RCAR_USB3_DL_CTRL_FW_SUCCESS)
 		return 0;
 
-	attr = soc_device_match(rcar_quirks_match);
-	if (attr)
-		quirks = (uintptr_t)attr->data;
-
-	if (quirks & RCAR_XHCI_FIRMWARE_V2)
-		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2;
-	else
-		firmware_name = priv->firmware_name;
-
 	/* request R-Car USB3.0 firmware */
-	retval = request_firmware(&fw, firmware_name, dev);
+	retval = request_firmware(&fw, priv->firmware_name, dev);
 	if (retval)
 		return retval;
 
-- 
2.35.1

