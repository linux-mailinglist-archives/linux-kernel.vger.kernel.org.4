Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1E6AE6A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCGQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCGQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:35 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA32B85B37
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=tgR8Ib7gK0xta9
        gDLehMBy5oVmognDSKS3+BEb2nqRg=; b=OtSAgJqkwCb6Mk0PQ1uS5dTxmbrriB
        z12jHlsAq1QaKoaNz3LyOZvaAsGJNQLOxSB+vDtlbV++blTyISQXyUCNW180CXnG
        LGv5vGJr+bfv0IklUrgYAUh0R4z/LAkOdX2gqKzJ6GGhMXLYSk86uRJHWUFhPfMh
        /zVCxFrB7G4aA=
Received: (qmail 752141 invoked from network); 7 Mar 2023 17:31:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:08 +0100
X-UD-Smtp-Session: l3s3148p1@VDhQ8FH2hI0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] usb: host: xhci-rcar: remove leftover quirk handling
Date:   Tue,  7 Mar 2023 17:30:37 +0100
Message-Id: <20230307163041.3815-10-wsa+renesas@sang-engineering.com>
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

Loading V3 firmware does not need a quirk anymore, remove the leftover
code.

Fixes: ed8603e11124 ("usb: host: xhci-rcar: Simplify getting the firmware name for R-Car Gen3")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. This is in preparation for
R-Car H3 ES1 removal. There are no dependencies.


 drivers/usb/host/xhci-rcar.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 7f18509a1d39..567b096a24e9 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -80,7 +80,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
 /* For soc_device_attribute */
 #define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
-#define RCAR_XHCI_FIRMWARE_V3   BIT(1) /* FIRMWARE V3 */
 
 static const struct soc_device_attribute rcar_quirks_match[]  = {
 	{
@@ -152,8 +151,6 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 
 	if (quirks & RCAR_XHCI_FIRMWARE_V2)
 		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2;
-	else if (quirks & RCAR_XHCI_FIRMWARE_V3)
-		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V3;
 	else
 		firmware_name = priv->firmware_name;
 
-- 
2.35.1

