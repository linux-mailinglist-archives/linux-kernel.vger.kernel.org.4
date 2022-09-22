Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769FC5E5F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIVKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiIVKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:04:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E92E0E;
        Thu, 22 Sep 2022 03:04:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a3so13773873lfk.9;
        Thu, 22 Sep 2022 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=evujfB8szCvAQoPfUtJ+IBgdNByfOeQv4NypDHTWWZU=;
        b=hHKV/U3TUVybPKe766aPSonvYqTZF3KU7qCuuzIATbKug921nr0vUnkMfzzK7kSLd7
         sAQfqW8OX8/5x1DvC6lgyu48YFW9zAOfuNZtzKBlZkurUlp0hgkyXX8QhcqoJWqb3X+N
         JgMydTiS/ypQYDzi3vRQ0y8kow0bU27wm2VBCrnI1i/AD9eS/Iu9QQxb5itlr33Nzm4i
         BwZc8ZHvt2j2qikSCg2pDRBFUB5bsbg1KtCjM0l6eacOX72DltyG5PGgM1joz+glW5Pq
         pd3gc2mC838kSsCp0EHOJ7mTGPM+755hF14ux5reHCx3Vb+gZNHwpUtJskyfedR+trB2
         LP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=evujfB8szCvAQoPfUtJ+IBgdNByfOeQv4NypDHTWWZU=;
        b=qjXCyHoX70yPaB8rmL1zzRKT81zNsX+IkZMxSVfMZ7sS9g2lNLDXheHpOQ+UCoOrOW
         uBcjVImCB84530b6YfvBuatGhzX15DADNBxadSWkUE5xs+0t45nVvDgi1/f5NLNiqtNf
         vP6qo1NFMukK/2GC260alcoGjzdeXKuyLA74dVpHWAReg/UHa4V7hIkUaPGuaLk5y7Z9
         jV55zAnDpdbnDRcugwX1O8NhT9G6H1W6zWjItvXwllZwhhwYdagiNOtSLrV98Iu+u40p
         MpENQXztDxxXuO5PMHyshDRNbcOFRhgEo4psFLet3jVKREZ3EbmhPW5ew1PnuGh788vx
         991Q==
X-Gm-Message-State: ACrzQf3pOfAwSr30e940BzYYYTL+Ysz9suB2jk9S2aU2joIooiF5Ayso
        9f3Ea+JbenHIef6k2sg0XUk=
X-Google-Smtp-Source: AMsMyM6FgZy+3LzBOuDLcUHW7TR38QhMx6fRs0v8aJWpZCGZmx0he58E/lLlniNYXJL5qMLRj11HxQ==
X-Received: by 2002:a05:6512:159e:b0:498:f1eb:f7a with SMTP id bp30-20020a056512159e00b00498f1eb0f7amr856573lfb.425.1663841068486;
        Thu, 22 Sep 2022 03:04:28 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.59])
        by smtp.gmail.com with ESMTPSA id t13-20020ac24c0d000000b0048b064707ebsm864320lfq.103.2022.09.22.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:04:23 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] gpio: tegra: Convert to immutable irq chip
Date:   Thu, 22 Sep 2022 13:03:39 +0300
Message-Id: <20220922100339.12565-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922100339.12565-1-clamor95@gmail.com>
References: <20220922100339.12565-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---
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

