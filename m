Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA196141CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJaX2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJaX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF81115E;
        Mon, 31 Oct 2022 16:27:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGIY108478;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=Bo6Z5yfHkk40T+6aJRLO+9cLsvzAhGwkopLqU34dgWU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V6c8532lhTjWJvV2Vs8QsjdfwBRXnB705hg1i4AunCjYsJ0nWTezVMH+uI/aX0E8/
         38dir0XnL46rjFDXX49SHYlvyFlN/WYKrCfDwpmiQggWuE+H6RUOJF1YWdr5U9K7gJ
         b6rG1DiUoJ4GOw6uT+P0u1I6CjBAOHv7ST8hLrrk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGSp022959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFZ9080588;
        Mon, 31 Oct 2022 18:27:15 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 03/11] thermal: k3_j72xx_bandgap: remove fuse_base from structure
Date:   Mon, 31 Oct 2022 18:26:54 -0500
Message-ID: <20221031232702.10339-4-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3769; h=from:subject; bh=81mhoBw/caDjW+fuWuwTWQ+hhm0caOGRtdC9Z4ZIV/c=; b=owNCWmg5MUFZJlNZlpKgmgAAY3////9/h63u2svf5V3z/93n3fwuf9Wln+/X1f/9+9n918+wARmx o4gAAAAD1MgAAANAAAAAGgAZAAaHqAMgNAHonqek009T1ANHqZNo1PSeoOgAaaBoxDIBo0DTQDIyBo BoyZAyNBkaGgZNNDBAGjTRpkNNMmhk00DQxMQAA71RsoPUGhtRoAB6gyAABoDTajQAaNGgGgAA0MgA 9QB6gAAaD1ANGgBpkeoCCJZkQdkZNCNR6sdwyjJKJ+GWZTRsXSc4bMfZBQNHSwFV2mGYE7TOBKwCJo nshNafFRljixu7RkckjiZD3b7OT8c8v8hjG1Ss6LhDkoYyvKSnjA9bPYNwk5TKfmX7HbcEGsOYt4DS KF0PmZULjiBc3gtMAnxUCxEdm8/XAM7s94ZVrqXR/cMUwmcksh82oRQm5lAc7r4vDBYDG7KxQUpQlX qdPHiKNcU24RyPfXhkGBu0xc4ik4lJCPiFWCMLihXSU+dShFWu5/veggzZc1tErv0yNXCpDqtBqhlF JTp5kJI8gMIHDoLMb4cQvwBqJVZJqB3icw12X2jljsDzStVnG5MPWSD8hKXELzKqtxgSALz6VQuzfy xXSqBfRJDvQIB5m+9BbIXouYRl3hzfsFpJepSmrlbBt/9xrAZyKrLLTf32g/xdyRThQkJaSoJo
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fuse_base' is only needed during the initial probe function to provide
data for a software trimming method for some of TI's devices affected by
the i2128 erratum. The devices not affected will not use this region

Remove fuse_base from the main k3_j72xx_bandgap structure

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index b9d20026771a5..395a73cb37425 100644
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
@@ -452,7 +452,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 			err_vals.refs[1] = PLUS30CREF;
 			err_vals.refs[2] = PLUS125CREF;
 			err_vals.refs[3] = PLUS150CREF;
-			get_efuse_values(id, &data[id], err_vals.errs, bgp);
+			get_efuse_values(id, &data[id], err_vals.errs, fuse_base);
 		}
 
 		if (id == 0 && workaround_needed)
-- 
2.38.1

