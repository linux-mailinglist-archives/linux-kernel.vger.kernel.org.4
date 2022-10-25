Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ADF60D47F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJYTPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiJYTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB47E018;
        Tue, 25 Oct 2022 12:15:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFKTV074682;
        Tue, 25 Oct 2022 14:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725320;
        bh=GDY2m1FVwVyz7kvfzVAQWW25+3Z4zZqO277aPfxWmww=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bBabcN/CRBsygW1vkQa0w98aZtOwLtU/X5TsRxTQxAsihgJd9YExyvym+kc0niWwL
         xMHUgvWKozkL0TixRLBFv3lZD8zCjLzeQk4JEdIY7xTgGjUB7NHumHQzxKfSE4J1Ey
         MjEneHatIvJ+bW0nlf9+3M6ycorgsK25Oe8K55YM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFK9Y058285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:20 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJge056994;
        Tue, 25 Oct 2022 14:15:19 -0500
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
Subject: [PATCH v2 04/11] thermal: k3_j72xx_bandgap: map fuse_base only for erratum workaround
Date:   Tue, 25 Oct 2022 14:15:08 -0500
Message-ID: <20221025191515.9151-5-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; h=from:subject; bh=3VK0DERXGogo+qPJUQ5h+7vzk2QFXgKHa6rxgwtgdIs=; b=owNCWmg5MUFZJlNZ6Nc6iQAAa/////f7/3d8+/OyG7r9f5vvxznjfk/Mvv4t8T+dl9fb3+6wARsW DtRpo0ANAyADTTQaBk0yGgAZGgAGjQ0DTQyBk0NAA0aAwgMjQaDI0G9NJDoDR6mjQDTTQAPUA000AM mh6gAeoaA0D1DINMmQeiHqeoeoDamRoPUDQ0GgGTRoGhDI9TQ2pkyBoNGg2kAGmgyHqNAyaZAAA00N DQDCANAaNND1MgBkxMmjRoyGmQwABYCgyRiQCIB64UiEXChMVW2+fXIEakCUVAMxQecoPn2CJwFGGj IfT/2s63dGyAJMvVtyrBLWeA8bOkMAnub0rXkJGwblmtN4polTJkvwMKxWLlQFHk0XZV5ZbOATj8S6 3FKYhI+X1SgEXzIZbbCHv4M4clfTdDi6pm0R7Jap1nkbu0HA8o7n2SqEE+bSlekmarDYfcDIlJAbvX /QlgjZuncNNiITHz2YT07xjtBirwXPI4B4g8syrC1KhPCzyLA53n6R3RnYz6FeNcd8f2kAxGlbwIdk Al8VehXE3TcH+FNiRKGYI4/VYsu/2D8GGuP6v23keI6fFJ+nm1JrM2XdNv3KgC5FFVjjYMOebIxIr7 nRNiI7DAUkJHB03AonRBF6xw3RfhVA7k2XPNgA6fAW4An1NoMLyLgjCZ6wZ3gUDSnSf4u5IpwoSHRr nUSA
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/thermal/k3_j72xx_bandgap.c | 37 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 71bf65e6afaed..031ea1091909a 100644
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
@@ -501,9 +511,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	 */
 	kfree(ref_table);
 
-	if (workaround_needed)
-		devm_iounmap(dev, fuse_base);
-
 	return 0;
 
 err_free_ref_table:
-- 
2.38.1

