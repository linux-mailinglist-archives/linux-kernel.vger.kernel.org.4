Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4C5E6F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiIVWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIVWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:03:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275DC10AB03;
        Thu, 22 Sep 2022 15:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EF45B837FA;
        Thu, 22 Sep 2022 22:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186CCC433B5;
        Thu, 22 Sep 2022 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663884198;
        bh=U7AngiUw9pi/okWYNcJU5584IsfUO2S3/dFVGK48Q4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2iHofqL+W7ktB6MheLW/p3dPrdZRVb8UkiARt0rIvt4u2fJevcl1NaiW3sJNrz8+
         BzKh6L/5QishNoYOfxY+2uYysB3NyViz/b16ClGLH0dcVK0FL1O92IqpDesgS1VIWU
         jbBj3Vj/Myq/+RNwvs3AFCIIo73v9ItXLafUA1lmEfkNuZ1vIjsJVnXEX9GhATTacr
         j2UgKyEJN5hi1UTvBkI41PIG9Aiy0IJu7/pqjlgeXVe6EZIjZZ1LW9wmEOy/bmu3+4
         q23J1yqY4yZ+TT/vsJC5C1siYAM/DucDQtDNgL9HKXKqipGzcrPBvCgsfzOjknQVnS
         0RhBbif3DPlkA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCHv2 3/3] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
Date:   Thu, 22 Sep 2022 17:03:08 -0500
Message-Id: <20220922220308.609422-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922220308.609422-1-dinguyen@kernel.org>
References: <20220922220308.609422-1-dinguyen@kernel.org>
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
v2: simplify clk-phase calculations
---
 drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 9901208be797..5d64984d382f 100644
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
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
+	((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
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
+	for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
+		clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
+
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
+	{ .compatible = "altr,socfpga-dw-mshc", .data =&socfpga_drv_data, },
 	{ .compatible = "img,pistachio-dw-mshc", },
 	{},
 };
-- 
2.25.1

