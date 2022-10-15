Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C15FFB73
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJOR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJOR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:26:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BEA4E1AB;
        Sat, 15 Oct 2022 10:26:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g1so11666191lfu.12;
        Sat, 15 Oct 2022 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofI77/STIqcgCTX1UfSBDtJXg6xnDwj4qtGg8HWhc6c=;
        b=PggJZTpO5oBLldNOFuPDX2BEIEiTvD4Lgy1RkrzkdvbocbKaDR+JR4kKhtT043Klvp
         bVqBnxvKsxmmkhxo3Cp4YGa0/yQZfy2Ev4L6v+wta/pmBYjjrqZrrGJfVr3HW38EDzes
         G3X17+Ez/zFezT5RiPQwlQCEQcGp5qDY8AFTSMir2110BxEdio59pLGQlTUpoqwCSbdI
         +5QShMOFDJwl4dg885MTmF+poB0qbnb5gdBwurdqIuBca2abrOjuOHrhdgIMgg1VktVM
         KkqOq+CBemHPF2CFHgq8lxrQ6u8edA9ShViVb6dB7abKFl42yZnNMnpZ5Uh4aL8agM+7
         oSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofI77/STIqcgCTX1UfSBDtJXg6xnDwj4qtGg8HWhc6c=;
        b=0MCs63NRMlAPQDUVk2hdlu1AY9nhmY0Elprm3YxFRlTHo7TNyX1YQEoSe3GfZUaikl
         fLLkaK8Phy0tZyIU0zaBrgVRlLko0JxIJcHL620BPny4sbbJLXZnukx92tofQ9OUt/Op
         o7wWhLn6fUVKXCLiSDMWdyxFguAz7wxk9x8/mmtvQ2OPcnUiGNHZEMTpzsT/Zm/9bzSY
         Q7bgXyFDfCV3Cd+3yQFUMrL5IVO7QceaxAkH6CXIVrbyPGuaqf4Eb3qG3qj3yLnaV6HT
         EppmMa/bM7NyMYr21PWTF3D58+tkDgK11JzHU9PwTS0R9TE/yidlD+yRRNfnvsi6e7xS
         YO4g==
X-Gm-Message-State: ACrzQf1bKGp/bmpV+F2sfHMj8q3XcI8EETFHjnBB1DGDqvQL8bAnpSYe
        Iu3oPXULz1a2NCF295NeEl8=
X-Google-Smtp-Source: AMsMyM4Ud9YkinMU/TQXE2oDxe4QsmjNs4NZuxikP+Lp2p9NOscgfX6dwk63T43yb2JSKutkyc0Elg==
X-Received: by 2002:a05:6512:3702:b0:4a2:6bd3:78ce with SMTP id z2-20020a056512370200b004a26bd378cemr1312889lfr.674.1665854778112;
        Sat, 15 Oct 2022 10:26:18 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a9-20020a056512200900b00494747ba5f7sm790308lfb.272.2022.10.15.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 10:26:17 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] gpio: tegra: Convert to immutable irq chip
Date:   Sat, 15 Oct 2022 20:26:02 +0300
Message-Id: <20221015172602.84855-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015172602.84855-1-clamor95@gmail.com>
References: <20221015172602.84855-1-clamor95@gmail.com>
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
Changes since V1:
- Added tested-by info from testers
- Patch itself is same, it had no review for 3 weeks
- Test robot is triggering for pm_sleep_ptr, should not it be used to omit CONFIG_PM_SLEEP ifdefs?

 drivers/gpio/gpio-tegra.c | 56 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index e4fb4cb38a0f..6b469253fad8 100644
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
 
@@ -598,10 +600,43 @@ static void tegra_gpio_irq_release_resources(struct irq_data *d)
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
+	.irq_set_wake		= pm_sleep_ptr(tegra_gpio_irq_set_wake),
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
+	.irq_set_wake		= pm_sleep_ptr(tegra_gpio_irq_set_wake),
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
@@ -689,18 +724,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
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
@@ -733,7 +756,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	}
 
 	irq = &tgi->gc.irq;
-	irq->chip = &tgi->ic;
 	irq->fwnode = of_node_to_fwnode(pdev->dev.of_node);
 	irq->child_to_parent_hwirq = tegra_gpio_child_to_parent_hwirq;
 	irq->populate_parent_alloc_arg = tegra_gpio_populate_parent_fwspec;
@@ -752,7 +774,9 @@ static int tegra_gpio_probe(struct platform_device *pdev)
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

