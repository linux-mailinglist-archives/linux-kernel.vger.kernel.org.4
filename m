Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6D606420
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJTPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJTPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:16:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B801150FAA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so2546093wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZarqMDc/6hKea1bOExuvbbOHo7DHkLG1khhfpxmIGM=;
        b=kUl9Fn1q+aZsdRTOjhrkoXMDey98D5TOPUmDIZjP243GrvBNHcjvExeRw2qla6Dn2s
         wwPh2Jv10B99vtROzuhZWUc2Jvum1/rlaN5ljNHjq9a1a9C+vhmKLmT5jpEv9bSFw1kw
         31ABCbZeh997hyzZJt7Fvc9yldZH2/1LWpcxpOM3bNZv2M1D/KTjqMnnKfmRaMvcXn0e
         3ziF6yG+BoEH3C8rwcgHmhJpSFzSwEDzuDIeVrkhyb+Ba3vJtc/PzL/xiUBbhnmnq31U
         7w/pZRx84D978Bycu1mOY0VwFzX6q37OsMmdTzEbEk5D6sfr1yIq/gZkyVYlTmYEXFP2
         AScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZarqMDc/6hKea1bOExuvbbOHo7DHkLG1khhfpxmIGM=;
        b=f+CWYo0YIuJWlUHb6s9xUCXvmlPD3iMC3sctrU11aKuIdXLvgrJs+YFiQKfRLJkDcd
         nOfaYUMFl5NURxrFC5FrHhZxeUMAovQQhelDrvTON/FD6vC5OcmUzWHkQt6igcpv/vTU
         vWsXbJxtRTuLMKlBuYzUqNM3R54Vy687aIt57IJPL6adzi3zfXXvw3Z+EFFeSMKO6Bvx
         TVM29lDfY/8tZWhK2lFwlQ+FGQM4pDTvaR43U0VLNMLGbEY3mUH+waNWA8AYBR2yh/1f
         oEFKQxRBg9rgQdjQs5Y9fDQVEW3wGruLKu/inwf/pKj/3iuVN3UyuJu76/tpQnUSVBqv
         7ftA==
X-Gm-Message-State: ACrzQf0Bodj0S26Wzwnnyh0VxCWBqU0yglKa9OxdILNjZc/bFu5SIzM0
        hdeDPYvnXgdalbpY9lTjc4IQ3g==
X-Google-Smtp-Source: AMsMyM4Xm8eKo2xPrKbd8eTNCp68NN/TVIHDvU2fhqdyrg6aDFGVPEUg71PqFQxeT5LpFeKF1QiqIg==
X-Received: by 2002:a1c:4c03:0:b0:3c4:c76:9fe3 with SMTP id z3-20020a1c4c03000000b003c40c769fe3mr30380738wmf.13.1666278983410;
        Thu, 20 Oct 2022 08:16:23 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:22 -0700 (PDT)
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
Subject: [PATCH v6 08/10] pwm: dwc: add of/platform support
Date:   Thu, 20 Oct 2022 16:16:08 +0100
Message-Id: <20221020151610.59443-9-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
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
---
 drivers/pwm/Kconfig      |  9 +++++
 drivers/pwm/Makefile     |  1 +
 drivers/pwm/pwm-dwc-of.c | 76 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a9f1c554db2b..c734f58a8bfc 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -192,6 +192,15 @@ config PWM_DWC_PCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc-pci.
 
+config PWM_DWC_OF
+	tristate "DesignWare PWM Controller (OF bus)"
+	depends on PWM_DWC && OF
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
-- 
2.35.1

