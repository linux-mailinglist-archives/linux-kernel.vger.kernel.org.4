Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FEF604E33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJSRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiJSRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAD1C2098;
        Wed, 19 Oct 2022 10:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC7E61967;
        Wed, 19 Oct 2022 17:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28118C433C1;
        Wed, 19 Oct 2022 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199262;
        bh=uEKjbDD+8urYCHBuvyX9+nK0j+GP1bQnusGWwlLB/YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=py2INVJXiCRFE23ZGAwBFqN956OtZ8nMCnBUsLZmUpX6LjeBFIdqUfe2q/SZCJOI4
         60SXgFqY1+KlCjWGqCACf1EC+pVQJE84edsyVH3HkbnGY6H3+QHm6AuUZGBnuih3oC
         Frj9QQd37d6MgAWW/Mbzsl46csWmCZ5HF6JbobcGSfitbnbKCblH+2WQuoY10sMwbx
         46uC6CN9s1WSf5JhprGSyw8YVCuqgsLuPMNhEfZQzyV39TxvFYSwHnwLheZen/tv5y
         1QwunCZPOaiofwtqOcKPsVarzYF8zehKPbzSkhwMXm+74YzXKg7nLiRHvxe+U+a8Bc
         Hv3nMSkzfKGWw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv5 5/6] clk: socfpga: remove the setting of clk-phase for sdmmc_clk
Date:   Wed, 19 Oct 2022 12:06:56 -0500
Message-Id: <20221019170657.68014-6-dinguyen@kernel.org>
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

Now that the SDMMC driver supports setting the clk-phase, we can remove
the need to do it in the clock driver.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v5: new
---
 drivers/clk/socfpga/clk-gate-a10.c | 68 ------------------------------
 drivers/clk/socfpga/clk-gate.c     | 60 --------------------------
 drivers/clk/socfpga/clk.h          |  1 -
 3 files changed, 129 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-gate-a10.c
index 738c53391e39..7cdf2f07c79b 100644
--- a/drivers/clk/socfpga/clk-gate-a10.c
+++ b/drivers/clk/socfpga/clk-gate-a10.c
@@ -35,59 +35,7 @@ static unsigned long socfpga_gate_clk_recalc_rate(struct clk_hw *hwclk,
 	return parent_rate / div;
 }
 
-static int socfpga_clk_prepare(struct clk_hw *hwclk)
-{
-	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
-	int i;
-	u32 hs_timing;
-	u32 clk_phase[2];
-
-	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
-		for (i = 0; i < ARRAY_SIZE(clk_phase); i++) {
-			switch (socfpgaclk->clk_phase[i]) {
-			case 0:
-				clk_phase[i] = 0;
-				break;
-			case 45:
-				clk_phase[i] = 1;
-				break;
-			case 90:
-				clk_phase[i] = 2;
-				break;
-			case 135:
-				clk_phase[i] = 3;
-				break;
-			case 180:
-				clk_phase[i] = 4;
-				break;
-			case 225:
-				clk_phase[i] = 5;
-				break;
-			case 270:
-				clk_phase[i] = 6;
-				break;
-			case 315:
-				clk_phase[i] = 7;
-				break;
-			default:
-				clk_phase[i] = 0;
-				break;
-			}
-		}
-
-		hs_timing = SYSMGR_SDMMC_CTRL_SET_AS10(clk_phase[0], clk_phase[1]);
-		if (!IS_ERR(socfpgaclk->sys_mgr_base_addr))
-			regmap_write(socfpgaclk->sys_mgr_base_addr,
-				     SYSMGR_SDMMCGRP_CTRL_OFFSET, hs_timing);
-		else
-			pr_err("%s: cannot set clk_phase because sys_mgr_base_addr is not available!\n",
-					__func__);
-	}
-	return 0;
-}
-
 static struct clk_ops gateclk_ops = {
-	.prepare = socfpga_clk_prepare,
 	.recalc_rate = socfpga_gate_clk_recalc_rate,
 };
 
@@ -96,7 +44,6 @@ static void __init __socfpga_gate_init(struct device_node *node,
 {
 	u32 clk_gate[2];
 	u32 div_reg[3];
-	u32 clk_phase[2];
 	u32 fixed_div;
 	struct clk_hw *hw_clk;
 	struct socfpga_gate_clk *socfpga_clk;
@@ -136,21 +83,6 @@ static void __init __socfpga_gate_init(struct device_node *node,
 		socfpga_clk->div_reg = NULL;
 	}
 
-	rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
-	if (!rc) {
-		socfpga_clk->clk_phase[0] = clk_phase[0];
-		socfpga_clk->clk_phase[1] = clk_phase[1];
-
-		socfpga_clk->sys_mgr_base_addr =
-			syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-		if (IS_ERR(socfpga_clk->sys_mgr_base_addr)) {
-			pr_err("%s: failed to find altr,sys-mgr regmap!\n",
-					__func__);
-			kfree(socfpga_clk);
-			return;
-		}
-	}
-
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	init.name = clk_name;
diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 53d6e3ec4309..7ea1c00a14dd 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -108,61 +108,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 	return parent_rate / div;
 }
 
-static int socfpga_clk_prepare(struct clk_hw *hwclk)
-{
-	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
-	struct regmap *sys_mgr_base_addr;
-	int i;
-	u32 hs_timing;
-	u32 clk_phase[2];
-
-	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
-		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-		if (IS_ERR(sys_mgr_base_addr)) {
-			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
-			return -EINVAL;
-		}
-
-		for (i = 0; i < 2; i++) {
-			switch (socfpgaclk->clk_phase[i]) {
-			case 0:
-				clk_phase[i] = 0;
-				break;
-			case 45:
-				clk_phase[i] = 1;
-				break;
-			case 90:
-				clk_phase[i] = 2;
-				break;
-			case 135:
-				clk_phase[i] = 3;
-				break;
-			case 180:
-				clk_phase[i] = 4;
-				break;
-			case 225:
-				clk_phase[i] = 5;
-				break;
-			case 270:
-				clk_phase[i] = 6;
-				break;
-			case 315:
-				clk_phase[i] = 7;
-				break;
-			default:
-				clk_phase[i] = 0;
-				break;
-			}
-		}
-		hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
-		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-			hs_timing);
-	}
-	return 0;
-}
-
 static struct clk_ops gateclk_ops = {
-	.prepare = socfpga_clk_prepare,
 	.recalc_rate = socfpga_clk_recalc_rate,
 	.get_parent = socfpga_clk_get_parent,
 	.set_parent = socfpga_clk_set_parent,
@@ -218,12 +164,6 @@ void __init socfpga_gate_init(struct device_node *node)
 		socfpga_clk->div_reg = NULL;
 	}
 
-	rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
-	if (!rc) {
-		socfpga_clk->clk_phase[0] = clk_phase[0];
-		socfpga_clk->clk_phase[1] = clk_phase[1];
-	}
-
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	init.name = clk_name;
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d80115fbdd6a..9a2fb2dde5b8 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -50,7 +50,6 @@ struct socfpga_gate_clk {
 	u32 width;	/* only valid if div_reg != 0 */
 	u32 shift;	/* only valid if div_reg != 0 */
 	u32 bypass_shift;      /* only valid if bypass_reg != 0 */
-	u32 clk_phase[2];
 };
 
 struct socfpga_periph_clk {
-- 
2.25.1

