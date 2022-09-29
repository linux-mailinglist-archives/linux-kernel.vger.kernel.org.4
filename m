Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A35F16CF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiI3Xoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiI3XoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:44:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F7315C1CE;
        Fri, 30 Sep 2022 16:44:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C317CE0EBE;
        Fri, 30 Sep 2022 01:54:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=0JdYDi05csUuLieFd6cS5KHfkLGdIc860jjEW4zLpM0=; b=bRhi+Xe8Ts48
        OVOYQaugA6FIMn+S2PiYuB+7Gk1KaPgEyzzICSWrFd9cgtUbLv1SMK4MfkeDg1u6
        b7F4Hri/YEOWD6KYOGVS6bSnfp8a0myPuES4Sef2So/Mgut6Ng3+3lun4UwBrsT+
        u7+c81+T6o6wNuGIDWySh0lLFQgBySU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B6D23E0EBB;
        Fri, 30 Sep 2022 01:54:14 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:54:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v12 7/8] clk: baikal-t1: Add DDR/PCIe directly controlled resets support
Date:   Fri, 30 Sep 2022 01:54:01 +0300
Message-ID: <20220929225402.9696-8-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside with a set of the trigger-like resets Baikal-T1 CCU provides two
additional blocks with directly controlled reset signals. In particular it
concerns DDR full and initial resets and various PCIe sub-domains resets.
Let's add the direct reset assertion/de-assertion of the corresponding
flags support into the Baikal-T1 CCU driver then. It will be required at
least for the PCIe platform driver. Obviously the DDR controller isn't
supposed to be fully reset in the kernel, so the corresponding controls
are added just for the sake of the interface implementation completeness.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

---

Changelog v6:
- Refactor the code to support the linear reset IDs only. (@Philipp)

Changelog v7:
- Drop empty line from the sys_rst_info structure initialization block.
  (@Philipp)
---
 drivers/clk/baikal-t1/ccu-rst.c | 66 +++++++++++++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-rst.h | 10 +++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
index 7db52633270f..40023ea67463 100644
--- a/drivers/clk/baikal-t1/ccu-rst.c
+++ b/drivers/clk/baikal-t1/ccu-rst.c
@@ -35,18 +35,29 @@
 #define CCU_AXI_HWA_BASE		0x054
 #define CCU_AXI_SRAM_BASE		0x058
 
+#define CCU_SYS_DDR_BASE		0x02c
 #define CCU_SYS_SATA_REF_BASE		0x060
 #define CCU_SYS_APB_BASE		0x064
+#define CCU_SYS_PCIE_BASE		0x144
 
 #define CCU_RST_DELAY_US		1
 
 #define CCU_RST_TRIG(_base, _ofs)		\
 	{					\
+		.type = CCU_RST_TRIG,		\
+		.base = _base,			\
+		.mask = BIT(_ofs),		\
+	}
+
+#define CCU_RST_DIR(_base, _ofs)		\
+	{					\
+		.type = CCU_RST_DIR,		\
 		.base = _base,			\
 		.mask = BIT(_ofs),		\
 	}
 
 struct ccu_rst_info {
+	enum ccu_rst_type type;
 	unsigned int base;
 	unsigned int mask;
 };
@@ -79,6 +90,15 @@ static const struct ccu_rst_info axi_rst_info[] = {
 static const struct ccu_rst_info sys_rst_info[] = {
 	[CCU_SYS_SATA_REF_RST] = CCU_RST_TRIG(CCU_SYS_SATA_REF_BASE, 1),
 	[CCU_SYS_APB_RST] = CCU_RST_TRIG(CCU_SYS_APB_BASE, 1),
+	[CCU_SYS_DDR_FULL_RST] = CCU_RST_DIR(CCU_SYS_DDR_BASE, 1),
+	[CCU_SYS_DDR_INIT_RST] = CCU_RST_DIR(CCU_SYS_DDR_BASE, 2),
+	[CCU_SYS_PCIE_PCS_PHY_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 0),
+	[CCU_SYS_PCIE_PIPE0_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 4),
+	[CCU_SYS_PCIE_CORE_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 8),
+	[CCU_SYS_PCIE_PWR_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 9),
+	[CCU_SYS_PCIE_STICKY_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 10),
+	[CCU_SYS_PCIE_NSTICKY_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 11),
+	[CCU_SYS_PCIE_HOT_RST] = CCU_RST_DIR(CCU_SYS_PCIE_BASE, 12),
 };
 
 static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
@@ -86,6 +106,9 @@ static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
 	struct ccu_rst *rst = to_ccu_rst(rcdev);
 	const struct ccu_rst_info *info = &rst->rsts_info[idx];
 
+	if (info->type != CCU_RST_TRIG)
+		return -EOPNOTSUPP;
+
 	regmap_update_bits(rst->sys_regs, info->base, info->mask, info->mask);
 
 	/* The next delay must be enough to cover all the resets. */
@@ -94,8 +117,51 @@ static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
 	return 0;
 }
 
+static int ccu_rst_set(struct reset_controller_dev *rcdev,
+		       unsigned long idx, bool high)
+{
+	struct ccu_rst *rst = to_ccu_rst(rcdev);
+	const struct ccu_rst_info *info = &rst->rsts_info[idx];
+
+	if (info->type != CCU_RST_DIR)
+		return high ? -EOPNOTSUPP : 0;
+
+	return regmap_update_bits(rst->sys_regs, info->base,
+				  info->mask, high ? info->mask : 0);
+}
+
+static int ccu_rst_assert(struct reset_controller_dev *rcdev,
+			  unsigned long idx)
+{
+	return ccu_rst_set(rcdev, idx, true);
+}
+
+static int ccu_rst_deassert(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	return ccu_rst_set(rcdev, idx, false);
+}
+
+static int ccu_rst_status(struct reset_controller_dev *rcdev,
+			  unsigned long idx)
+{
+	struct ccu_rst *rst = to_ccu_rst(rcdev);
+	const struct ccu_rst_info *info = &rst->rsts_info[idx];
+	u32 val;
+
+	if (info->type != CCU_RST_DIR)
+		return -EOPNOTSUPP;
+
+	regmap_read(rst->sys_regs, info->base, &val);
+
+	return !!(val & info->mask);
+}
+
 static const struct reset_control_ops ccu_rst_ops = {
 	.reset = ccu_rst_reset,
+	.assert = ccu_rst_assert,
+	.deassert = ccu_rst_deassert,
+	.status = ccu_rst_status,
 };
 
 struct ccu_rst *ccu_rst_hw_register(const struct ccu_rst_init_data *rst_init)
diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
index 68214d777465..d6e8b2f671f4 100644
--- a/drivers/clk/baikal-t1/ccu-rst.h
+++ b/drivers/clk/baikal-t1/ccu-rst.h
@@ -13,6 +13,16 @@
 
 struct ccu_rst_info;
 
+/*
+ * enum ccu_rst_type - CCU Reset types
+ * @CCU_RST_TRIG: Self-deasserted reset signal.
+ * @CCU_RST_DIR: Directly controlled reset signal.
+ */
+enum ccu_rst_type {
+	CCU_RST_TRIG,
+	CCU_RST_DIR,
+};
+
 /*
  * struct ccu_rst_init_data - CCU Resets initialization data
  * @sys_regs: Baikal-T1 System Controller registers map.
-- 
2.37.3


