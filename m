Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7A5B37F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiIIMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiIIMcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:32:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF4B7296;
        Fri,  9 Sep 2022 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662726741; x=1694262741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+OSH553B+7DD1EalJumCdX6Jr9V3HOUdK+hUy2pDW4=;
  b=nfxzUzO5RSDPJVC7Etn7RNJJiQmwocQbOkAxX/QHsrvYsiKIYmPEuav0
   NGgL5EgRK/tK7vGG3yzWDqxy20e/KvQsRb4H6uC+PNca5eQY6IV2f4cB/
   ORJJtI0cT/FDSHTygCr+nzdb6QlsYSGZ01CYjdalhfHcSkfmMHo9eFq9F
   xzYy/IFLkebWKN/SZAr853/2yoRe3fvuT387FJTGZTFCZmvMJwZIvm7Ff
   S91lcE3/ep29MNhybZfzb1DC+tVTK/KdW6MXZ+ASu1AIKOnqIspJcqJea
   tBY70qylfMfvVF9vOGR8/g6ixUVp7Qm658hZ1STT1/OL6DJBTzsBUSlnZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="176399329"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 05:32:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 05:32:14 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 9 Sep 2022 05:32:12 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 10/14] clk: microchip: mpfs: simplify control reg access
Date:   Fri, 9 Sep 2022 13:31:19 +0100
Message-ID: <20220909123123.2699583-11-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220909123123.2699583-1-conor.dooley@microchip.com>
References: <20220909123123.2699583-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control reg addresses are known when the clocks are registered, so
we can, instead of assigning a base pointer to the structs, assign the
control reg addresses directly. Accordingly, remove the interim
variables used during reads/writes to those registers.

Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 42 +++++++++++++-------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 9250fab88ebf..4ee894d58ea9 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -50,6 +50,7 @@ struct mpfs_msspll_hw_clock {
 #define to_mpfs_msspll_clk(_hw) container_of(_hw, struct mpfs_msspll_hw_clock, hw)
 
 struct mpfs_cfg_clock {
+	void __iomem *reg;
 	const struct clk_div_table *table;
 	u8 shift;
 	u8 width;
@@ -58,7 +59,6 @@ struct mpfs_cfg_clock {
 
 struct mpfs_cfg_hw_clock {
 	struct mpfs_cfg_clock cfg;
-	void __iomem *sys_base;
 	struct clk_hw hw;
 	struct clk_init_data init;
 	unsigned int id;
@@ -68,12 +68,12 @@ struct mpfs_cfg_hw_clock {
 #define to_mpfs_cfg_clk(_hw) container_of(_hw, struct mpfs_cfg_hw_clock, hw)
 
 struct mpfs_periph_clock {
+	void __iomem *reg;
 	u8 shift;
 };
 
 struct mpfs_periph_hw_clock {
 	struct mpfs_periph_clock periph;
-	void __iomem *sys_base;
 	struct clk_hw hw;
 	unsigned int id;
 };
@@ -212,14 +212,13 @@ static int mpfs_clk_register_msspll(struct device *dev, struct mpfs_msspll_hw_cl
 static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_clock *msspll_hws,
 				     unsigned int num_clks, struct mpfs_clock_data *data)
 {
-	void __iomem *base = data->msspll_base;
 	unsigned int i;
 	int ret;
 
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_msspll_hw_clock *msspll_hw = &msspll_hws[i];
 
-		ret = mpfs_clk_register_msspll(dev, msspll_hw, base);
+		ret = mpfs_clk_register_msspll(dev, msspll_hw, data->msspll_base);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register msspll id: %d\n",
 					     CLK_MSSPLL);
@@ -238,10 +237,9 @@ static unsigned long mpfs_cfg_clk_recalc_rate(struct clk_hw *hw, unsigned long p
 {
 	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
 	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-	void __iomem *base_addr = cfg_hw->sys_base;
 	u32 val;
 
-	val = readl_relaxed(base_addr + cfg_hw->reg_offset) >> cfg->shift;
+	val = readl_relaxed(cfg->reg) >> cfg->shift;
 	val &= clk_div_mask(cfg->width);
 
 	return divider_recalc_rate(hw, prate, val, cfg->table, cfg->flags, cfg->width);
@@ -259,7 +257,6 @@ static int mpfs_cfg_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned
 {
 	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
 	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-	void __iomem *base_addr = cfg_hw->sys_base;
 	unsigned long flags;
 	u32 val;
 	int divider_setting;
@@ -270,10 +267,10 @@ static int mpfs_cfg_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned
 		return divider_setting;
 
 	spin_lock_irqsave(&mpfs_clk_lock, flags);
-	val = readl_relaxed(base_addr + cfg_hw->reg_offset);
+	val = readl_relaxed(cfg->reg);
 	val &= ~(clk_div_mask(cfg->width) << cfg_hw->cfg.shift);
 	val |= divider_setting << cfg->shift;
-	writel_relaxed(val, base_addr + cfg_hw->reg_offset);
+	writel_relaxed(val, cfg->reg);
 
 	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
 
@@ -321,9 +318,9 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 };
 
 static int mpfs_clk_register_cfg(struct device *dev, struct mpfs_cfg_hw_clock *cfg_hw,
-				 void __iomem *sys_base)
+				 void __iomem *base)
 {
-	cfg_hw->sys_base = sys_base;
+	cfg_hw->cfg.reg = base + cfg_hw->reg_offset;
 
 	return devm_clk_hw_register(dev, &cfg_hw->hw);
 }
@@ -331,14 +328,13 @@ static int mpfs_clk_register_cfg(struct device *dev, struct mpfs_cfg_hw_clock *c
 static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *cfg_hws,
 				  unsigned int num_clks, struct mpfs_clock_data *data)
 {
-	void __iomem *sys_base = data->base;
 	unsigned int i, id;
 	int ret;
 
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
-		ret = mpfs_clk_register_cfg(dev, cfg_hw, sys_base);
+		ret = mpfs_clk_register_cfg(dev, cfg_hw, data->base);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
@@ -358,15 +354,14 @@ static int mpfs_periph_clk_enable(struct clk_hw *hw)
 {
 	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
 	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	void __iomem *base_addr = periph_hw->sys_base;
 	u32 reg, val;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpfs_clk_lock, flags);
 
-	reg = readl_relaxed(base_addr + REG_SUBBLK_CLOCK_CR);
+	reg = readl_relaxed(periph->reg);
 	val = reg | (1u << periph->shift);
-	writel_relaxed(val, base_addr + REG_SUBBLK_CLOCK_CR);
+	writel_relaxed(val, periph->reg);
 
 	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
 
@@ -377,15 +372,14 @@ static void mpfs_periph_clk_disable(struct clk_hw *hw)
 {
 	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
 	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	void __iomem *base_addr = periph_hw->sys_base;
 	u32 reg, val;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpfs_clk_lock, flags);
 
-	reg = readl_relaxed(base_addr + REG_SUBBLK_CLOCK_CR);
+	reg = readl_relaxed(periph->reg);
 	val = reg & ~(1u << periph->shift);
-	writel_relaxed(val, base_addr + REG_SUBBLK_CLOCK_CR);
+	writel_relaxed(val, periph->reg);
 
 	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
 }
@@ -394,10 +388,9 @@ static int mpfs_periph_clk_is_enabled(struct clk_hw *hw)
 {
 	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
 	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	void __iomem *base_addr = periph_hw->sys_base;
 	u32 reg;
 
-	reg = readl_relaxed(base_addr + REG_SUBBLK_CLOCK_CR);
+	reg = readl_relaxed(periph->reg);
 	if (reg & (1u << periph->shift))
 		return 1;
 
@@ -466,9 +459,9 @@ static struct mpfs_periph_hw_clock mpfs_periph_clks[] = {
 };
 
 static int mpfs_clk_register_periph(struct device *dev, struct mpfs_periph_hw_clock *periph_hw,
-				    void __iomem *sys_base)
+				    void __iomem *base)
 {
-	periph_hw->sys_base = sys_base;
+	periph_hw->periph.reg = base + REG_SUBBLK_CLOCK_CR;
 
 	return devm_clk_hw_register(dev, &periph_hw->hw);
 }
@@ -476,14 +469,13 @@ static int mpfs_clk_register_periph(struct device *dev, struct mpfs_periph_hw_cl
 static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_clock *periph_hws,
 				     int num_clks, struct mpfs_clock_data *data)
 {
-	void __iomem *sys_base = data->base;
 	unsigned int i, id;
 	int ret;
 
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
-		ret = mpfs_clk_register_periph(dev, periph_hw, sys_base);
+		ret = mpfs_clk_register_periph(dev, periph_hw, data->base);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
-- 
2.36.1

