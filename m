Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7155FBE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJKXT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJKXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:19:03 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE3A346A;
        Tue, 11 Oct 2022 16:18:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI0HB038190;
        Tue, 11 Oct 2022 18:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530280;
        bh=tm3z2ruXgbRd25DHbTSqLokW/IIzhIxMr7pZxOkJ4kM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nMwx00Y9f+7VzCZH0yS0osyjXQ2uUnk+phyExdkTB3rkkOBw1YosH8CGlCwMeL/8z
         on3zitfsqP6QNWKFbmH2w5ZZsPEmzVa+pz/rsKpi82bI95sd6JmUS4U9Y7JsFxZrEC
         dE4hL7qrnselRT6HPEiIw5B036nAJPuTgGk+1b+Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNI0Ym130127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:17:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:17:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHxjc088353;
        Tue, 11 Oct 2022 18:17:59 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 03/11] thermal: k3_j72xx_bandgap: remove fuse_base from structure
Date:   Tue, 11 Oct 2022 18:17:19 -0500
Message-ID: <20221011231727.8090-4-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3420; h=from:subject; bh=STl+ZBG+9rtQI0+MEWUEPVK+EEoCmb9xPWHIkya++N4=; b=owNCWmg5MUFZJlNZdBYa3QAAX////vf7wz+wv7rirXcqv776Fak+6+7nr+/fYkzr/bdbzf6wARkU OIeo09Q00PSAGmg0NAA0xGTTQD0gaAAAAyAaaNAMjQZPUG0jRoPSaZPIaZRBhNDJiGCNMQ0DAjQNMj CGjQyaMjQ0whiaMjEwjRhMho0GQBpoGmQNAyEPUPIjTTRtQeo09QDQeoNANGmQNHpDRo2kNGgB5Q0A AA0AaDaIeoDIPUGjJtRoBBYoFdSeZAoppCccHOL5IuWQMVxO8y2I4PQGkBIDrAaM0WsOv+jbzzG3yl jX0AP5yjHMocMRxkp6pvpoQZGbJJLMGrlrVtiHqAXSnXDB4Q5wIq/KxaZMK9vWEWYUnp+t1z8uDsD/ r8B6o+Ggp8Us03L4gZ1suTJXfevmgGwuBmvHZ3EN7nWkDKRqBIAK32pEPo1y3pLAcIiGXGA0dRyDBN Unk5zHV8IqWnsdmzxmBpkM1dHDaGCOiRL2Lx0MIOgIC/HHvGslZRn+K55UNxqE81c3WN4XD99WKdqr PeVs1A5+rSZv2LYhsGjl+E+C2jhahd0hPi36fP23hCxMVHgQMwar/PUB6I24kjndooL62UvpipS7Rk pU/X0cgXQM3ZHRByiUuhAAAJm9nteOFKbRLWfJli0hGEBBUIuRzjn+LuSKcKEg6Cw1ug==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fuse_base' is only needed during the initial probe function to provide
a software trimming method for some devices effected by TI's i2128
erratum. Not all devices that use this hardware device will need to map
this eFuse region.

Remove fuse_base from the main k3_j72xx_bandgap structure

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index b9d20026771a5..99df62295a11f 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -177,7 +177,6 @@ struct k3_j72xx_bandgap {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *cfg2_base;
-	void __iomem *fuse_base;
 	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
 };
 
@@ -276,7 +275,7 @@ static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
 }
 
 static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
-			     struct k3_j72xx_bandgap *bgp)
+			     void __iomem *fuse_base)
 {
 	int i, tmp, pow;
 	int ct_offsets[5][K3_VTM_CORRECTION_TEMP_CNT] = {
@@ -298,16 +297,16 @@ static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
 		/* Extract the offset value using bit-mask */
 		if (ct_offsets[id][i] == -1 && i == 1) {
 			/* 25C offset Case of Sensor 2 split between 2 regs */
-			tmp = (readl(bgp->fuse_base + 0x8) & 0xE0000000) >> (29);
-			tmp |= ((readl(bgp->fuse_base + 0xC) & 0x1F) << 3);
+			tmp = (readl(fuse_base + 0x8) & 0xE0000000) >> (29);
+			tmp |= ((readl(fuse_base + 0xC) & 0x1F) << 3);
 			pow = tmp & 0x80;
 		} else if (ct_offsets[id][i] == -1 && i == 2) {
 			/* 125C Case of Sensor 3 split between 2 regs */
-			tmp = (readl(bgp->fuse_base + 0x4) & 0xF8000000) >> (27);
-			tmp |= ((readl(bgp->fuse_base + 0x8) & 0xF) << 5);
+			tmp = (readl(fuse_base + 0x4) & 0xF8000000) >> (27);
+			tmp |= ((readl(fuse_base + 0x8) & 0xF) << 5);
 			pow = tmp & 0x100;
 		} else {
-			tmp = readl(bgp->fuse_base + ct_offsets[id][i]);
+			tmp = readl(fuse_base + ct_offsets[id][i]);
 			tmp &= ct_bm[id][i];
 			tmp = tmp >> __ffs(ct_bm[id][i]);
 
@@ -356,6 +355,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	struct thermal_zone_device *ti_thermal;
 	int *ref_table;
 	struct err_values err_vals;
+	void __iomem *fuse_base;
 
 	const s64 golden_factors[] = {
 		-490019999999999936,
@@ -387,9 +387,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		return PTR_ERR(bgp->cfg2_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	bgp->fuse_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(bgp->fuse_base))
-		return PTR_ERR(bgp->fuse_base);
+	fuse_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(fuse_base))
+		return PTR_ERR(fuse_base);
 
 	driver_data = of_device_get_match_data(dev);
 	if (driver_data)
@@ -428,7 +428,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	}
 
 	/* Workaround not needed if bit30/bit31 is set even for J721e */
-	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
+	if (workaround_needed && (readl(fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
 		workaround_needed = false;
 
 	dev_dbg(bgp->dev, "Work around %sneeded\n",
-- 
2.38.0

