Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7191C5FBE50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJKXSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJKXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:19 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C1606A5;
        Tue, 11 Oct 2022 16:18:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI1Xi086173;
        Tue, 11 Oct 2022 18:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530281;
        bh=V43nL9p2UXliVj8OWhyDT5EBScWJAlDR6URDW1S2FuU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bFyUefptAE15OpqqDUVolVxhlYQrGV7i2Rj2FGiRRcKnNzZNCsI9kdt5VbgfFw+gB
         5rzkyIWfsUXHxvuLhd9tVga2518LSV0+Jn2rAmW02G2BOH0eI6uZSxGNAzG32Fy0ao
         kQXeJC+SHGxxyl5h4pF+pFK/oKkB3dmwKoilcDBs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNI18M029446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:01 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:18:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:18:00 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI01g021930;
        Tue, 11 Oct 2022 18:18:00 -0500
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
Subject: [PATCH 04/11] thermal: k3_j72xx_bandgap: map fuse_base only for erratum workaround
Date:   Tue, 11 Oct 2022 18:17:20 -0500
Message-ID: <20221011231727.8090-5-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; h=from:subject; bh=cOO7JFWo8MUylBuZzGjwW1oumWVy8SSUhUCR4NTdink=; b=owNCWmg5MUFZJlNZr31NEgAAaX///v5df237vP/LfznzPfd/adz3Wy952+uT/3+76/3f72+wARrN hD1ADQAAZBoBoAAaGho0ADQBoDI0aAaA9QNDQGg0AaDQAZMjIYRppvVPNUOhoZBpkA0NDRoNGgNGmE aeoGjQDTQNNA9QMg0xMjQNqDTRoaaaDRoDQDI0GmgDIA4MUNNNGgeoNMRoGg9QZDEZADQAZAAAxNGJ oaA0BoBoMmhoAaZNNAAAAAALQfPrwkgDqiIEossClECe7gmIQyXd6JChFvEKbRg28WkWL9Ar20u3Fx AWZIwrEgVMqOLo4WRPGKBUwaFUbQCqCvmRxw/HkfMnS8x0itdOS5SaOLImsBpt+C4PhUoGkBe2zcUm GmNpzO1w09mrQHKkMxVhJKtffPqh2z/4uFTr0Ddkw7iXUsoce5LeBlAoSpDglqwUij2Aq0SQ5YDxdB aE/USOyOI00TKtgdUXChmvofVA7vL2RXLAc7cJcqhfnxIhzbB2ZuPpx+TEc0BAPMCgy1GB0lVvzX6L DLURSyHwS5FcpAAWskCb31zzqVLn104efkilKq0YhMSOpk7peJ1JhYxbXK1IGHBivEu6k2L6HRFbAp 8pTU8tHAyNHBIrFoFawdDz4NCH6GXPX4BqYeMyvOARhRDCVowGYEcAe2ToghD/i7kinChIV76miQA=
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

Some of TI's J721E SoCs require a software trimming procedure for the
temperature monitors to function properly. To determine if a particular
J721E is not affected by this erratum, both bits in the WKUP_SPARE_FUSE0
region must be set. Other SoCs, not affected by this erratum, will not
need this region.

Map the 'fuse_base' region only when the erratum fix is needed.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 99df62295a11f..fdba116f7fe7b 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -386,15 +386,32 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	if (IS_ERR(bgp->cfg2_base))
 		return PTR_ERR(bgp->cfg2_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	fuse_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(fuse_base))
-		return PTR_ERR(fuse_base);
-
 	driver_data = of_device_get_match_data(dev);
 	if (driver_data)
 		workaround_needed = driver_data->has_errata_i2128;
 
+	/*
+	 * Some of TI's J721E SoCs require a software trimming procedure
+	 * for the temperature monitors to function properly. To determine
+	 * if this particular SoC is NOT affected, both bits in the
+	 * WKUP_SPARE_FUSE0[31:30] will be set (0xC0000000) indicating
+	 * when software trimming should NOT be applied.
+	 *
+	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
+	 */
+	if (workaround_needed) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		fuse_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(fuse_base))
+			return PTR_ERR(fuse_base);
+
+		if ((readl(fuse_base) & 0xc0000000) == 0xc0000000)
+			workaround_needed = false;
+	}
+
+	dev_dbg(bgp->dev, "Work around %sneeded\n",
+		workaround_needed ? "" : "not ");
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -427,13 +444,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		goto err_free_ref_table;
 	}
 
-	/* Workaround not needed if bit30/bit31 is set even for J721e */
-	if (workaround_needed && (readl(fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
-		workaround_needed = false;
-
-	dev_dbg(bgp->dev, "Work around %sneeded\n",
-		workaround_needed ? "" : "not ");
-
 	if (!workaround_needed)
 		init_table(5, ref_table, golden_factors);
 	else
-- 
2.38.0

