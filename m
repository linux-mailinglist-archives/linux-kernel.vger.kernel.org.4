Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF19D6141AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJaX1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJaX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C311C2E;
        Mon, 31 Oct 2022 16:27:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRG30106690;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=DlAiLs5Ku3VbelFDsEYPq0YQ/PIXlM05Is7Om0VplhQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XHq32o/ajyBUMTsY3f5iRkiubGgm6ovQqZb/gPmeUEtLi6MaP9M/+R/5mG4LB1KHe
         peMA8Sh5H5ofTw8EP2x6oINUJhc70TfDPt0cZ6xBtv1EgtZvPqeoexs/E1nfcZtEHt
         jI02fsc7z8d9hwksvsaU0VvuIdXEg+dEISgng1s0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGtJ023424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFG5037168;
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
Subject: [PATCH v3 04/11] thermal: k3_j72xx_bandgap: map fuse_base only for erratum workaround
Date:   Mon, 31 Oct 2022 18:26:55 -0500
Message-ID: <20221031232702.10339-5-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; h=from:subject; bh=UJw18bTWhZzEYgN7X9MypDXipXRn727Xr/6BWs3NM9w=; b=owNCWmg5MUFZJlNZSuIudgAAX////v7/x62sf+rzdf57/9XntRuiWP/D637nWx/+7v/f/3ewARtp B2pp6g9QNDQAAA0yAAAyAAANBpoAB6gBp6jQBppoAGgNNB6QPUZD1D0am1P1RA0BoAAeoMgAA0PUBo 0APSAAAaAep6jQDT1B6h6QA9QaAaNDaj9U0A9QHoh6mgcJk0Yh6mhiNAaMgMAjENAADQABgmmmCDI0 ZMmgA0NDRoDIYIaAAAAMGaia8rBlMEOALqBiPIKgGyULEuOaearQLypXww0EWkfx0CPBFtjbEt8zvP wYSK7fCJXBCJtEb2lUI36A+leBsqNuBTrVJAJs6ZcxaVuaQBLgX4oINdUKVre/0fLsMsU1aD3w9+Dn RrPkNlqE7Tv0Ke6FScOUgIMl1JpFbrzpQ/YcE3TTgmFHwksVo6+bjlJtBivVl9ZqI0MoYSz5NU39Ii JO+iythUIXkn1/3vsFR/aWbgxZnCJbkzyC1ZxWJJ5ttk/cA4NlGa2EoXGjUBiYPqajjKkmqEWeclSP 6A8Oat34fDMFGVCLvUgQqP+KcggslCG1LPsJgKNCTwWMntuYZitO1y8YxQWBcnSoQh2JwkmmS7bIzC PCFKy3UDBmHUm0VUzkkHEfPGz8GAQK6UATGN/4qAkB+zHV5qxkft/i7kinChIJXEXOwA==
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
index 395a73cb37425..031ea1091909a 100644
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
2.38.1

