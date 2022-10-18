Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7D602782
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJRIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiJRIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:49:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D82DF81;
        Tue, 18 Oct 2022 01:49:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m23so17025745lji.2;
        Tue, 18 Oct 2022 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ittdb6vpPq1cRywgTUHTYSBDHDcOaOE6DaEoaGh8YM=;
        b=krCqaYYSLmJYdJvQYwjptmDh1lS+zQ78QhKT3hTwbL799UkyWti9qu7P7B1G4pwhf1
         IfHeyy+6RMdvVR3eoKxS01QsFdm33buS4EU2sO3+1VxSnAFjBrmtUMMMJvNb2X+ey84y
         FJ1ZXzP7McqJbwhp1RSSFPwOieRid9X5YGWdQ73OiMumXxth449mIyWy4wHo+K+tYcYL
         PThV/KTHciQHKK8f/pjDtG5T33ZXB9i9z3qcZOV0qLOrVMu8VPdKVb+hECO7Gijz/UIZ
         GNfHhEk/dGzoYYs1DEIkv83UrqPGGlzFJCdcf4D+LkVxDTru0xVmy9Qi/na2fh0oOdQm
         6UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ittdb6vpPq1cRywgTUHTYSBDHDcOaOE6DaEoaGh8YM=;
        b=2DTWYlyH9rdRN3rjn5bkajPDsgsXYBAbvAurZPoQh9va6i0TrthqYTWUQz0aVRhZPu
         Abhunh7UwMOUxswybwnjBne9zHeZxS0nAGK9lCXo3wZTuWywRFS2JXwQYcWR0fSElPy1
         jIvwYQnzhGh3FLFGQMuDBIoq08ONm042rCymt8LizsaMywh7jBaySgjaw6/VIItvw58h
         OEEBInWnYbNNPlfifJHTwKPnu/58jbD3X6uMwl0bWNu0mqODrOTlKSzuerC96A8/+iSl
         hs/dy1a+bcYc77Q3mWpPijVEjU+tih04rn2Ajh05P5cpasokZDymuMVyOER+Eet9yU93
         YHPg==
X-Gm-Message-State: ACrzQf1QhUE9Z3lw7QWKhf6UVSmc++ap6qjGzB0DodncmPVoTdNv8foD
        wVucU3dm3DyANZZMSeaNtPU=
X-Google-Smtp-Source: AMsMyM6nI82WaGnIRN7vQ8B9NpOCEchM5Jz5QPjG0jHlhCqTwAzHr4pcUpynZbRYzC3Rcl6UUKkO8g==
X-Received: by 2002:a2e:3801:0:b0:26f:f8da:5da9 with SMTP id f1-20020a2e3801000000b0026ff8da5da9mr213877lja.238.1666082967164;
        Tue, 18 Oct 2022 01:49:27 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651236ca00b004949f7cbb6esm1771890lfs.79.2022.10.18.01.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:49:26 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] gpio: tegra: Convert to immutable irq chip
Date:   Tue, 18 Oct 2022 11:49:04 +0300
Message-Id: <20221018084905.21717-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018084905.21717-1-clamor95@gmail.com>
References: <20221018084905.21717-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the driver to use an immutable IRQ chip to fix this warning:

    "not an immutable chip, please consider fixing it!"

Preserve per-chip labels by adding an ->irq_print_chip() callback.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # TF201 T30
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # TF101 T20
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---
Changes since V2:
- use CONFIG_PM_SLEEP ifdefs

Changes since V1:
- Added tested-by info from testers
- Patch itself is same, it had no review for 3 weeks
- Test robot is triggering for pm_sleep_ptr, should not it be used to omit CONFIG_PM_SLEEP ifdefs?

 drivers/gpio/gpio-tegra.c | 60 ++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index e4fb4cb38a0f..5b265a6fd3c1 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/seq_file.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/pinctrl/consumer.h>
@@ -94,7 +95,6 @@ struct tegra_gpio_info {
 	struct tegra_gpio_bank			*bank_info;
 	const struct tegra_gpio_soc_config	*soc;
 	struct gpio_chip			gc;
-	struct irq_chip				ic;
 	u32					bank_count;
 	unsigned int				*irqs;
 };
@@ -288,6 +288,7 @@ static void tegra_gpio_irq_mask(struct irq_data *d)
 	unsigned int gpio = d->hwirq;
 
 	tegra_gpio_mask_write(tgi, GPIO_MSK_INT_ENB(tgi, gpio), gpio, 0);
+	gpiochip_disable_irq(chip, gpio);
 }
 
 static void tegra_gpio_irq_unmask(struct irq_data *d)
@@ -296,6 +297,7 @@ static void tegra_gpio_irq_unmask(struct irq_data *d)
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
 	unsigned int gpio = d->hwirq;
 
+	gpiochip_enable_irq(chip, gpio);
 	tegra_gpio_mask_write(tgi, GPIO_MSK_INT_ENB(tgi, gpio), gpio, 1);
 }
 
@@ -598,10 +600,47 @@ static void tegra_gpio_irq_release_resources(struct irq_data *d)
 	tegra_gpio_enable(tgi, d->hwirq);
 }
 
+static void tegra_gpio_irq_print_chip(struct irq_data *d, struct seq_file *s)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+
+	seq_printf(s, dev_name(chip->parent));
+}
+
+static const struct irq_chip tegra_gpio_irq_chip = {
+	.irq_shutdown		= tegra_gpio_irq_shutdown,
+	.irq_ack		= tegra_gpio_irq_ack,
+	.irq_mask		= tegra_gpio_irq_mask,
+	.irq_unmask		= tegra_gpio_irq_unmask,
+	.irq_set_type		= tegra_gpio_irq_set_type,
+#ifdef CONFIG_PM_SLEEP
+	.irq_set_wake		= tegra_gpio_irq_set_wake,
+#endif
+	.irq_print_chip		= tegra_gpio_irq_print_chip,
+	.irq_request_resources	= tegra_gpio_irq_request_resources,
+	.irq_release_resources	= tegra_gpio_irq_release_resources,
+	.flags			= IRQCHIP_IMMUTABLE,
+};
+
+static const struct irq_chip tegra210_gpio_irq_chip = {
+	.irq_shutdown		= tegra_gpio_irq_shutdown,
+	.irq_ack		= tegra_gpio_irq_ack,
+	.irq_mask		= tegra_gpio_irq_mask,
+	.irq_unmask		= tegra_gpio_irq_unmask,
+	.irq_set_affinity	= tegra_gpio_irq_set_affinity,
+	.irq_set_type		= tegra_gpio_irq_set_type,
+#ifdef CONFIG_PM_SLEEP
+	.irq_set_wake		= tegra_gpio_irq_set_wake,
+#endif
+	.irq_print_chip		= tegra_gpio_irq_print_chip,
+	.irq_request_resources	= tegra_gpio_irq_request_resources,
+	.irq_release_resources	= tegra_gpio_irq_release_resources,
+	.flags			= IRQCHIP_IMMUTABLE,
+};
+
 #ifdef	CONFIG_DEBUG_FS
 
 #include <linux/debugfs.h>
-#include <linux/seq_file.h>
 
 static int tegra_dbg_gpio_show(struct seq_file *s, void *unused)
 {
@@ -689,18 +728,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	tgi->gc.ngpio			= tgi->bank_count * 32;
 	tgi->gc.parent			= &pdev->dev;
 
-	tgi->ic.name			= "GPIO";
-	tgi->ic.irq_ack			= tegra_gpio_irq_ack;
-	tgi->ic.irq_mask		= tegra_gpio_irq_mask;
-	tgi->ic.irq_unmask		= tegra_gpio_irq_unmask;
-	tgi->ic.irq_set_type		= tegra_gpio_irq_set_type;
-	tgi->ic.irq_shutdown		= tegra_gpio_irq_shutdown;
-#ifdef CONFIG_PM_SLEEP
-	tgi->ic.irq_set_wake		= tegra_gpio_irq_set_wake;
-#endif
-	tgi->ic.irq_request_resources	= tegra_gpio_irq_request_resources;
-	tgi->ic.irq_release_resources	= tegra_gpio_irq_release_resources;
-
 	platform_set_drvdata(pdev, tgi);
 
 	if (tgi->soc->debounce_supported)
@@ -733,7 +760,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	}
 
 	irq = &tgi->gc.irq;
-	irq->chip = &tgi->ic;
 	irq->fwnode = of_node_to_fwnode(pdev->dev.of_node);
 	irq->child_to_parent_hwirq = tegra_gpio_child_to_parent_hwirq;
 	irq->populate_parent_alloc_arg = tegra_gpio_populate_parent_fwspec;
@@ -752,7 +778,9 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 		if (!irq->parent_domain)
 			return -EPROBE_DEFER;
 
-		tgi->ic.irq_set_affinity = tegra_gpio_irq_set_affinity;
+		gpio_irq_chip_set_chip(irq, &tegra210_gpio_irq_chip);
+	} else {
+		gpio_irq_chip_set_chip(irq, &tegra_gpio_irq_chip);
 	}
 
 	tgi->regs = devm_platform_ioremap_resource(pdev, 0);
-- 
2.34.1

