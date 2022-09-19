Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC66B5BD49B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiISSNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiISSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:13:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA2111829;
        Mon, 19 Sep 2022 11:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E82F2B81AF4;
        Mon, 19 Sep 2022 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1751C43470;
        Mon, 19 Sep 2022 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663611209;
        bh=efA1CI5eOVyKy7cjXgpsD9blr8sPtb3UFq3HG0Pc0+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X//UfQHzk5E0JvfMhDcQzujwBePorEFPZIFZe94xkAnBPdVNUsGCL4/mTQRdqwYyO
         vuxSzUzzpl/1LZGUXpozoxbhEMrBrcYXHex8UI4hKNFBoiw106TGwT6U7fC48as71B
         ysWjORPHuLXU3EtvPz6bKdD4KvCWon6GE5UN9ARVD0JSitJIzTeJRWgJS4WhFwFkeC
         g7Z9FzMjXpr0QxaP6hgekTYpFkzDvR/uOfWv26P5S2A3llgw1l7WvInXFH/o1ogi8M
         YQpIJq+DwUBUFwHeFuuz/bU05gacGp26iEPOD7KOz/YycyWId/k7s76YW1XVEw3IdK
         yUmMIKmXwdTJA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
Date:   Mon, 19 Sep 2022 13:13:09 -0500
Message-Id: <20220919181309.286611-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919181309.286611-1-dinguyen@kernel.org>
References: <20220919181309.286611-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-phase settings for the SDMMC controller in the SoCFPGA
Strarix10/Agilex/N5X platforms reside in a register in the System
Manager. Add a method to access that register through the syscon
interface.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c | 68 ++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 9901208be797..9e3237c18a9d 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -17,10 +17,15 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
+#include <linux/mfd/altera-sysmgr.h>
+#include <linux/regmap.h>
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
+	((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
+
 int dw_mci_pltfm_register(struct platform_device *pdev,
 			  const struct dw_mci_drv_data *drv_data)
 {
@@ -62,9 +67,70 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
 };
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
+static int dw_mci_socfpga_priv_init(struct dw_mci *host)
+{
+	struct device_node *np = host->dev->of_node;
+	struct regmap *sys_mgr_base_addr;
+	u32 clk_phase[2] = {0}, reg_offset;
+	int i, rc, hs_timing;
+
+	rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
+	if (rc) {
+		sys_mgr_base_addr =
+			altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+		if (IS_ERR(sys_mgr_base_addr)) {
+			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
+			return 1;
+		}
+	} else
+		return 1;
+
+	of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
+
+	for (i = 0; i < ARRAY_SIZE(clk_phase); i++) {
+		switch (clk_phase[i]) {
+		case 0:
+			clk_phase[i] = 0;
+			break;
+		case 45:
+			clk_phase[i] = 1;
+			break;
+		case 90:
+			clk_phase[i] = 2;
+			break;
+		case 135:
+			clk_phase[i] = 3;
+			break;
+		case 180:
+			clk_phase[i] = 4;
+			break;
+		case 225:
+			clk_phase[i] = 5;
+			break;
+		case 270:
+			clk_phase[i] = 6;
+			break;
+		case 315:
+			clk_phase[i] = 7;
+			break;
+		default:
+			clk_phase[i] = 0;
+			break;
+		}
+	}
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
+	regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
+
+	return 0;
+}
+
+static const struct dw_mci_drv_data socfpga_drv_data = {
+	.init		= dw_mci_socfpga_priv_init,
+};
+
 static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
-	{ .compatible = "altr,socfpga-dw-mshc", },
+	{ .compatible = "altr,socfpga-dw-mshc", .data = &socfpga_drv_data, },
 	{ .compatible = "img,pistachio-dw-mshc", },
 	{},
 };
-- 
2.25.1

