Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E094604E30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJSRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJSRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35919165CB3;
        Wed, 19 Oct 2022 10:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4C961940;
        Wed, 19 Oct 2022 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFA5C433D7;
        Wed, 19 Oct 2022 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199260;
        bh=Gcpvztv6565Yasf4olb+R+dPl9mCbV3+3Cwfb8rNixc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d95vUTD+osxVR14lWNseq3BJD1x0abDrYME13HolUF5H01Be2TPfO1x4ChDXunueQ
         5cemO/QANilVmFtJ6PpeCgLmiiJLd2hCy8pC14dLAxBz3j6cItn0fpy7BWe/1gezEe
         ULpmlYxG7N3BA80Exbknn2zJvlvs9JUOL136ZtLeCQXgXsS4L9hdYOvbhDcJuMWUnk
         H9yCZM7h0Hw5eMXOEq0uMBSQ21P8X7a5/d0V1peHEdvd52Xjt9VTJk91QnW6DzCINa
         gmHPxw4YebPeFF7/xnRJjHaPqnuBJikWrXe2QxYwuYhTEWdS7kaa9j38lp6SmkJgS8
         5oqoUE+/YXp9Q==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv5 4/6] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
Date:   Wed, 19 Oct 2022 12:06:55 -0500
Message-Id: <20221019170657.68014-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019170657.68014-1-dinguyen@kernel.org>
References: <20221019170657.68014-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-phase settings for the SDMMC controller in the SoCFPGA
platforms reside in a register in the System Manager. Add a method
to access that register through the syscon interface.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v5: change error handling from of_property_read_variable_u32_array()
    support arm32 by reading the reg_shift
v4: no change
v3: add space before &socfpga_drv_data
v2: simplify clk-phase calculations
---
 drivers/mmc/host/dw_mmc-pltfm.c | 43 ++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 9901208be797..74421d13f466 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -17,10 +17,16 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
+#include <linux/mfd/altera-sysmgr.h>
+#include <linux/regmap.h>
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
+#define SOCFPGA_DW_MMC_CLK_PHASE_STEP	45
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel, reg_shift) \
+	((((smplsel) & 0x7) << reg_shift) | (((drvsel) & 0x7) << 0))
+
 int dw_mci_pltfm_register(struct platform_device *pdev,
 			  const struct dw_mci_drv_data *drv_data)
 {
@@ -62,9 +68,44 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
 };
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
+static int dw_mci_socfpga_priv_init(struct dw_mci *host)
+{
+	struct device_node *np = host->dev->of_node;
+	struct regmap *sys_mgr_base_addr;
+	u32 clk_phase[2] = {0}, reg_offset, reg_shift;
+	int i, rc, hs_timing;
+
+	rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
+	if (rc < 0) {
+		dev_err(host->dev, "clk-phase-sd-hs not found!\n");
+		return rc;
+	}
+
+	sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+	if (IS_ERR(sys_mgr_base_addr)) {
+		dev_err(host->dev, "failed to find altr,sys-mgr regmap!\n");
+		return -ENODEV;
+	}
+
+	of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
+	of_property_read_u32_index(np, "altr,sysmgr-syscon", 2, &reg_shift);
+
+	for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
+		clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
+
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1], reg_shift);
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

