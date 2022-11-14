Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9E8628CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiKNXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiKNXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5091B7A2;
        Mon, 14 Nov 2022 15:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC52EB815BD;
        Mon, 14 Nov 2022 23:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6900CC43140;
        Mon, 14 Nov 2022 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466946;
        bh=mP1glOMgwwjtxxD/5YyQGpy9Kmwl+tbpsLXysXmem+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X88qJahLWjU6ipVHtqUEc2mvYoJbNkgZHmy3j0WyJZi4p5bH7nFWT70KpFbBbASgI
         ugMuU270WgpeAi6aXl/dD6joIQRx0iqTyi0MM/7nyDGifmXkPWlU0Rj7dlmqKH3Ov1
         4HleICOIGJJ8Hk7FupQpyhxiTmtPhPYP+YPFG35w0cHMxJRBZ8anYsstT81Fz8iFGK
         vGEwboFb5YlYtTluHS+2s613TXX0shIu56wOoJm28pkjY79U9+gx4uRFjrieZUhoaB
         NEtV6mEQpB5NfwT8ep0gZ8p+j+BL83DsD3OY6+WreLqBbJuot7xRLIV10rRMbVUTVB
         Y+XHRn9Tp+1ng==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv9 4/6] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
Date:   Mon, 14 Nov 2022 17:02:15 -0600
Message-Id: <20221114230217.202634-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114230217.202634-1-dinguyen@kernel.org>
References: <20221114230217.202634-1-dinguyen@kernel.org>
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
platforms reside in a register in the System Manager. Add a method
to access that register through the syscon interface.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v9: no changes
v8: no changes
v7: use dev_warn if clk-phase-sd-hs is specified, but "altr,sysmgr-syscon"
    is not found
v6: not getting the clk-phase-sd-hs is not a hard failure
v5: change error handling from of_property_read_variable_u32_array()
    support arm32 by reading the reg_shift
v4: no change
v3: add space before &socfpga_drv_data
v2: simplify clk-phase calculations
---
 drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 9901208be797..13e55cff8237 100644
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
@@ -62,9 +68,42 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
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
+	if (rc < 0)
+		return 0;
+
+	sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+	if (IS_ERR(sys_mgr_base_addr)) {
+		dev_warn(host->dev, "clk-phase-sd-hs was specified, but failed to find altr,sys-mgr regmap!\n");
+		return 0;
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

