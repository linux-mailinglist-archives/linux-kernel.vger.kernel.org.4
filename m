Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C691A6ADBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCGKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCGKU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:20:26 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18B9C56527
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:20:20 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 9F15E5F362;
        Tue,  7 Mar 2023 11:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1678184377;
        bh=A18Uktj6TlU/FFJpxJgWtpkpi7Flm/POU7gDoOyy828=;
        h=From:To:CC:Subject:Date:From;
        b=w+ab3XZsVx1wA+9W+Ez7IbsCXgZxr+RLOqjrQLxFh6UdfOAAH/XnL9xRgMULblH2R
         CqKAlr/IW7AgpdcWO3Uy65SAWNgcpxKJANF/67NrDtqoujhCmQFoTzSXxujp+po23D
         u0F4431Wln2jLZrN8pdStK+x0A+AuQu50dEGWlv7zD4Haw1WQ5IFfhanH3S7IZNcPQ
         PLXuY1v7+5w+Rv86SUZ0eb/epKaUPHnaXSrho/LAmmj+ez6V1cF4hoZO0WZ83ga58Y
         GL57UvMDEFgPP+720vvW8/gMUsReURWfp9d4H3K2S6Isb/1Smx/d6ZeazdR+rNFgSG
         zU+9rfEHEBguw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 11:19:24 +0100
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 11:19:24 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        "Adam Thomson" <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 1/3] mfd: da9062: Use MFD_CELL_OF macro
Date:   Tue, 7 Mar 2023 11:18:11 +0100
Message-ID: <20230307101813.77267-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MFD_CELL_OF macro helper instead of plain struct properties, which makes
the code a bit shorter and to have commonly defined MFD cell attributes.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V3: - Add this patch to the series
---
 drivers/mfd/da9062-core.c | 92 +++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 68 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 40cde51e5719..9418c58c2b06 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -182,34 +182,16 @@ static const struct resource da9061_onkey_resources[] = {
 };
 
 static const struct mfd_cell da9061_devs[] = {
-	{
-		.name		= "da9061-core",
-		.num_resources	= ARRAY_SIZE(da9061_core_resources),
-		.resources	= da9061_core_resources,
-	},
-	{
-		.name		= "da9062-regulators",
-		.num_resources	= ARRAY_SIZE(da9061_regulators_resources),
-		.resources	= da9061_regulators_resources,
-	},
-	{
-		.name		= "da9061-watchdog",
-		.num_resources	= ARRAY_SIZE(da9061_wdt_resources),
-		.resources	= da9061_wdt_resources,
-		.of_compatible  = "dlg,da9061-watchdog",
-	},
-	{
-		.name		= "da9061-thermal",
-		.num_resources	= ARRAY_SIZE(da9061_thermal_resources),
-		.resources	= da9061_thermal_resources,
-		.of_compatible  = "dlg,da9061-thermal",
-	},
-	{
-		.name		= "da9061-onkey",
-		.num_resources	= ARRAY_SIZE(da9061_onkey_resources),
-		.resources	= da9061_onkey_resources,
-		.of_compatible = "dlg,da9061-onkey",
-	},
+	MFD_CELL_OF("da9061-core", da9061_core_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9062-regulators", da9061_regulators_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9061-watchdog", da9061_wdt_resources, NULL, 0, 0,
+		    "dlg,da9061-watchdog"),
+	MFD_CELL_OF("da9061-thermal", da9061_thermal_resources, NULL, 0, 0,
+		    "dlg,da9061-thermal"),
+	MFD_CELL_OF("da9061-onkey", da9061_onkey_resources, NULL, 0, 0,
+		    "dlg,da9061-onkey"),
 };
 
 static const struct resource da9062_core_resources[] = {
@@ -246,46 +228,20 @@ static const struct resource da9062_gpio_resources[] = {
 };
 
 static const struct mfd_cell da9062_devs[] = {
-	{
-		.name		= "da9062-core",
-		.num_resources	= ARRAY_SIZE(da9062_core_resources),
-		.resources	= da9062_core_resources,
-	},
-	{
-		.name		= "da9062-regulators",
-		.num_resources	= ARRAY_SIZE(da9062_regulators_resources),
-		.resources	= da9062_regulators_resources,
-	},
-	{
-		.name		= "da9062-watchdog",
-		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
-		.resources	= da9062_wdt_resources,
-		.of_compatible  = "dlg,da9062-watchdog",
-	},
-	{
-		.name		= "da9062-thermal",
-		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
-		.resources	= da9062_thermal_resources,
-		.of_compatible  = "dlg,da9062-thermal",
-	},
-	{
-		.name		= "da9062-rtc",
-		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
-		.resources	= da9062_rtc_resources,
-		.of_compatible  = "dlg,da9062-rtc",
-	},
-	{
-		.name		= "da9062-onkey",
-		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
-		.resources	= da9062_onkey_resources,
-		.of_compatible	= "dlg,da9062-onkey",
-	},
-	{
-		.name		= "da9062-gpio",
-		.num_resources	= ARRAY_SIZE(da9062_gpio_resources),
-		.resources	= da9062_gpio_resources,
-		.of_compatible	= "dlg,da9062-gpio",
-	},
+	MFD_CELL_OF("da9062-core", da9062_core_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9062-regulators", da9062_regulators_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9062-watchdog", da9062_wdt_resources, NULL, 0, 0,
+		    "dlg,da9062-watchdog"),
+	MFD_CELL_OF("da9062-thermal", da9062_thermal_resources, NULL, 0, 0,
+		    "dlg,da9062-thermal"),
+	MFD_CELL_OF("da9062-rtc", da9062_rtc_resources, NULL, 0, 0,
+		    "dlg,da9062-rtc"),
+	MFD_CELL_OF("da9062-onkey", da9062_onkey_resources, NULL, 0, 0,
+		    "dlg,da9062-onkey"),
+	MFD_CELL_OF("da9062-gpio", da9062_gpio_resources, NULL, 0, 0,
+		    "dlg,da9062-gpio"),
 };
 
 static int da9062_clear_fault_log(struct da9062 *chip)
-- 
2.11.0

