Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3380655249
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiLWPjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiLWPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:38:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281BA4497E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n3so4155151wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYPgkS5TNjhvp4tfDqVp6B+H3UH3jOlelljtWTWQGMk=;
        b=S13x7qnLXiB546nUJz2FpMQJKM8bQq6PIZFE7RO/mIEYpd5EIF4k6rZAct+OpezTsH
         31wmq5ppMs/Qmek2AH2R8r+ek1Wg942eHG8wCRKd5vR3Pw+iekeBDw3LiNu4h1nmxGsa
         AWAcfgQChauu4lK3BDGO793UsNps4P0s9kaZIu140VXE1UMBUQJ+lf0pkYnWzNcboM6h
         gq7WpFTpkr3E+/4d68Ijdj6EoJxDzCHTtGQy3H+w3o4QsF52Gz0IyJA0WFD0KWV3Uu6u
         QY73ACeayH+glUsUN4vgNC/gIfhyJsNSHU/V+8TAnjfHdATQ/LrR5wiDa+PA1a32R+nW
         atyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYPgkS5TNjhvp4tfDqVp6B+H3UH3jOlelljtWTWQGMk=;
        b=DWcKm2PecgOw8VUN3vp4YeMkMmsczT04bgjHDCFcTN1izLgdkZM5qZ1RW5yGXakJrT
         zm5cOXpRU178mblR7lzvau+340HVQYYQOakqQ/RiV9lhj+oea7Hkhi4rphqtCDW+29AD
         W+hHioWYMeNGLcH3PD0E+clRe4WtFiBFL09lc5dSJZhhJhpW8d2wLGlvc5a+arFPI0fF
         8W5J7aZgQtiZlEVfJnN00KbXjpRzBsHuiOBnfxGlwPHQXYuBtxOQWdISTYNPjK/DWQFD
         hiCi1Zl/YJ/CbsKSBJol5e5emtBAN2uzdx2pGT442YvKG17X502Oxafj70lDllmLsXCu
         lCxg==
X-Gm-Message-State: AFqh2kpZl3Z7gT3tmMk8leTDyExCPD+JY1VE869oCoGdA9di5ipUA5B6
        PRNe3B3093H6a+r/oFKdUPOXxw==
X-Google-Smtp-Source: AMrXdXsdGyGSSfYzj0B5uPniTJ8Pvwgk0XVegLfRPmty1ZXPRC1KRaJvWYhnuR/6OobJHzXlhQ45ew==
X-Received: by 2002:a5d:488b:0:b0:242:5ae0:5b41 with SMTP id g11-20020a5d488b000000b002425ae05b41mr6341840wrq.33.1671809910725;
        Fri, 23 Dec 2022 07:38:30 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:30 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v7 08/10] pwm: dwc: add of/platform support
Date:   Fri, 23 Dec 2022 15:38:18 +0000
Message-Id: <20221223153820.404565-9-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v7:
 - fixup kconfig from previous pcie changes
v5:
 - fix missing " in kconfig
 - remove .remove method, devm already sorts this.
 - merge pwm-number code
 - split the of code out of the core
 - get bus clock
v4:
 - moved the compile test code earlier
 - fixed review comments
  - used NS_PER_SEC
  - use devm_clk_get_enabled
  - ensure we get the bus clock
v3:
 - changed compatible name

fixup add pwm/Kconfig

fixup: kconfig change for of addition
---
 drivers/pwm/Kconfig       | 10 ++++++
 drivers/pwm/Makefile      |  1 +
 drivers/pwm/pwm-dwc-of.c  | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc-pci.c |  1 +
 drivers/pwm/pwm-dwc.c     |  1 +
 drivers/pwm/pwm-dwc.h     |  1 +
 6 files changed, 90 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8c5ef388a981..74ab526e8b8c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -193,6 +193,16 @@ config PWM_DWC
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc-pci.
 
+config PWM_DWC_OF
+	tristate "DesignWare PWM Controller (OF bus)"
+	depends on HAS_IOMEM && OF
+	select PWM_DWC_CORE
+	help
+	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-of.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a70d36623129..d1fd1641f077 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_DWC_OF)	+= pwm-dwc-of.o
 obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
new file mode 100644
index 000000000000..c5b4351cc7b0
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver OF
+ *
+ * Copyright (C) 2022 SiFive, Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+
+#include "pwm-dwc.h"
+
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm *dwc;
+	struct clk *bus;
+	u32 nr_pwm;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
+		if (nr_pwm > DWC_TIMERS_TOTAL)
+			dev_err(dev, "too many PWMs (%d) specified, capping at %d\n",
+				nr_pwm, dwc->chip.npwm);
+		else
+			dwc->chip.npwm = nr_pwm;
+	}
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return PTR_ERR(dwc->base);
+
+	bus = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(bus))
+		return dev_err_probe(dev, PTR_ERR(bus),
+				     "failed to get clock\n");
+
+	dwc->clk = devm_clk_get_enabled(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
+	return devm_pwmchip_add(dev, &dwc->chip);
+}
+
+static const struct of_device_id dwc_pwm_dt_ids[] = {
+	{ .compatible = "snps,dw-apb-timers-pwm2" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
+
+static struct platform_driver dwc_pwm_plat_driver = {
+	.driver = {
+		.name		= "dwc-pwm",
+		.of_match_table  = dwc_pwm_dt_ids,
+	},
+	.probe	= dwc_pwm_plat_probe,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm-of");
+MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
index 2213d0e7f3c8..949423e368f9 100644
--- a/drivers/pwm/pwm-dwc-pci.c
+++ b/drivers/pwm/pwm-dwc-pci.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
+#include <linux/clk.h>
 
 #include "pwm-dwc.h"
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 0c6beafa8c41..1251620ab771 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index b29d8cd21208..dc451cb2eff5 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -40,6 +40,7 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
 	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
-- 
2.35.1

