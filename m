Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BF5ECCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiI0TYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiI0TYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:24:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A6D8266
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:24:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso3914846pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=i6/ryNav83BQlaWulO74ztbMcRDBUJZlZHngMujmegM=;
        b=NONrf1KR/nzHmrKI5DWkeZqB59R4iEDFU1D0IGmauZjqD2ZyNZCxrMkssgkm1WsGt8
         3m6Fhmv/9ML5en6RB5ZZeV8TPhYstv7igjLsO+2f1OsRw5VBpF9Up+s3nJFCDoWUMDVa
         1AeXaovPZgWsoBTHu1z20szad7PtWu2Ot2sWJhJ6+LRlVoTGltp9QCzOfe9yH//nFn57
         Ghx4tDLFrwskiUdnex5CgYAE8y378EjXG9jWsMmaA8tUoIboilKOKv4xtQOd279M5oQ/
         Fgn0jOPCChZCFYlbGLveS778ejmn+e6VQbzBULrZVNshOZniz3Ndb4VHcJNdbSpEKuIl
         8VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=i6/ryNav83BQlaWulO74ztbMcRDBUJZlZHngMujmegM=;
        b=6pOVqP6zJrSffd7V3flw33wKlFV51r6B0BxqbJ47gK9b7EphRKdQYGr0XoZyOMlj+Y
         LZAt97Zy+FL6LmYz3n3dsZF89DgcWU9JNNQocW35FwbwU+sfCUZh1/9p6FpzLxS7snFV
         EW+dhR6AniD/RPf19VR8Dh+X/eol+tUdJ13se8/wYYmGF144vFcHvR0ei/txwQw8kJYu
         zrCfWKGmq0+Gdw/VcxlFxUTOFthPBp2Gef+/ioG2YbvkTODMsuaxVqZ7/PwpaiJhvsKl
         bmjNZJeCgJt71evvZ2jRHdO9lB5CA0rH3a0iedvkQeS3CUfqV7eeXUwnxopOd2xTbacg
         Pcnw==
X-Gm-Message-State: ACrzQf1rAWW9TBnXRFZMYpRPwIdohibCuxprteUctZlpsVSpuyMWajvB
        iKOk9ou/7ZMxqiM9622J8eIK5u/26X8=
X-Google-Smtp-Source: AMsMyM7qgLGVSKn+yO8jVbz6qI2lad7JC1P2l8liI0Kl9P7MSlfQ0+2h3qLWmfPx1KOYsSvklwzfSQ==
X-Received: by 2002:a17:902:d490:b0:177:fc1d:6b0c with SMTP id c16-20020a170902d49000b00177fc1d6b0cmr28626926plg.28.1664306641554;
        Tue, 27 Sep 2022 12:24:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id t6-20020a62d146000000b0053e8368ec34sm2144386pfl.32.2022.09.27.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:24:01 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:23:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liang He <windhl@126.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sgy_cts1000: convert to using gpiod API and facelift
Message-ID: <YzNNznewTyCJiGFz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the driver to newer gpiod API, and away from
OF-specific legacy gpio API that we want to stop using.

While at it, let's address a few more issues:

- switch to using dev_info()/pr_info() and friends
- cancel work when unbinding the driver

Note that the original code handled halt GPIO polarity incorrectly:
in halt callback, when line polarity is "low" it would set trigger to
"1" and drive halt line high, which is counter to the annotation.
gpiod API will drive such line low. However I do not see any DTSes
in mainline that have a DT node with "sgy,gpio-halt" compatible.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Cross-compiled with gcc-12.1.0, not tested on hardware.

 arch/powerpc/platforms/85xx/sgy_cts1000.c | 132 +++++++++-------------
 1 file changed, 53 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index e14d1b74d4e4..751395cbf022 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -7,10 +7,13 @@
  * Copyright 2012 by Servergy, Inc.
  */
 
+#define pr_fmt(fmt) "gpio-halt: " fmt
+
+#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/workqueue.h>
 #include <linux/reboot.h>
@@ -18,7 +21,8 @@
 
 #include <asm/machdep.h>
 
-static struct device_node *halt_node;
+static struct gpio_desc *halt_gpio;
+static int halt_irq;
 
 static const struct of_device_id child_match[] = {
 	{
@@ -36,23 +40,10 @@ static DECLARE_WORK(gpio_halt_wq, gpio_halt_wfn);
 
 static void __noreturn gpio_halt_cb(void)
 {
-	enum of_gpio_flags flags;
-	int trigger, gpio;
-
-	if (!halt_node)
-		panic("No reset GPIO information was provided in DT\n");
-
-	gpio = of_get_gpio_flags(halt_node, 0, &flags);
-
-	if (!gpio_is_valid(gpio))
-		panic("Provided GPIO is invalid\n");
-
-	trigger = (flags == OF_GPIO_ACTIVE_LOW);
-
-	printk(KERN_INFO "gpio-halt: triggering GPIO.\n");
+	pr_info("triggering GPIO.\n");
 
 	/* Probably wont return */
-	gpio_set_value(gpio, trigger);
+	gpiod_set_value(halt_gpio, 1);
 
 	panic("Halt failed\n");
 }
@@ -61,95 +52,78 @@ static void __noreturn gpio_halt_cb(void)
  * to handle the shutdown/poweroff. */
 static irqreturn_t gpio_halt_irq(int irq, void *__data)
 {
-	printk(KERN_INFO "gpio-halt: shutdown due to power button IRQ.\n");
+	struct platform_device *pdev = __data;
+
+	dev_info(&pdev->dev, "scheduling shutdown due to power button IRQ\n");
 	schedule_work(&gpio_halt_wq);
 
         return IRQ_HANDLED;
 };
 
-static int gpio_halt_probe(struct platform_device *pdev)
+static int __gpio_halt_probe(struct platform_device *pdev,
+			     struct device_node *halt_node)
 {
-	enum of_gpio_flags flags;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *child_node;
-	int gpio, err, irq;
-	int trigger;
-
-	if (!node)
-		return -ENODEV;
-
-	/* If there's no matching child, this isn't really an error */
-	child_node = of_find_matching_node(node, child_match);
-	if (!child_node)
-		return 0;
-
-	/* Technically we could just read the first one, but punish
-	 * DT writers for invalid form. */
-	if (of_gpio_count(child_node) != 1) {
-		err = -EINVAL;
-		goto err_put;
-	}
-
-	/* Get the gpio number relative to the dynamic base. */
-	gpio = of_get_gpio_flags(child_node, 0, &flags);
-	if (!gpio_is_valid(gpio)) {
-		err = -EINVAL;
-		goto err_put;
-	}
+	int err;
 
-	err = gpio_request(gpio, "gpio-halt");
+	halt_gpio = fwnode_gpiod_get_index(of_fwnode_handle(halt_node),
+					   NULL, 0, GPIOD_OUT_LOW, "gpio-halt");
+	err = PTR_ERR_OR_ZERO(halt_gpio);
 	if (err) {
-		printk(KERN_ERR "gpio-halt: error requesting GPIO %d.\n",
-		       gpio);
-		goto err_put;
+		dev_err(&pdev->dev, "failed to request halt GPIO: %d\n", err);
+		return err;
 	}
 
-	trigger = (flags == OF_GPIO_ACTIVE_LOW);
-
-	gpio_direction_output(gpio, !trigger);
-
 	/* Now get the IRQ which tells us when the power button is hit */
-	irq = irq_of_parse_and_map(child_node, 0);
-	err = request_irq(irq, gpio_halt_irq, IRQF_TRIGGER_RISING |
-			  IRQF_TRIGGER_FALLING, "gpio-halt", child_node);
+	halt_irq = irq_of_parse_and_map(halt_node, 0);
+	err = request_irq(halt_irq, gpio_halt_irq,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			  "gpio-halt", pdev);
 	if (err) {
-		printk(KERN_ERR "gpio-halt: error requesting IRQ %d for "
-		       "GPIO %d.\n", irq, gpio);
-		gpio_free(gpio);
-		goto err_put;
+		dev_err(&pdev->dev, "failed to request IRQ %d: %d\n",
+			halt_irq, err);
+		gpiod_put(halt_gpio);
+		halt_gpio = NULL;
+		return err;
 	}
 
 	/* Register our halt function */
 	ppc_md.halt = gpio_halt_cb;
 	pm_power_off = gpio_halt_cb;
 
-	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
-	       " irq).\n", gpio, trigger, irq);
+	dev_info(&pdev->dev, "registered halt GPIO, irq: %d\n", halt_irq);
 
-	halt_node = child_node;
 	return 0;
-
-err_put:
-	of_node_put(child_node);
-	return err;
 }
 
-static int gpio_halt_remove(struct platform_device *pdev)
+static int gpio_halt_probe(struct platform_device *pdev)
 {
-	if (halt_node) {
-		int gpio = of_get_gpio(halt_node, 0);
-		int irq = irq_of_parse_and_map(halt_node, 0);
+	struct device_node *halt_node;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	/* If there's no matching child, this isn't really an error */
+	halt_node = of_find_matching_node(pdev->dev.of_node, child_match);
+	if (!halt_node)
+		return -ENODEV;
+
+	ret = __gpio_halt_probe(pdev, halt_node);
+	of_node_put(halt_node);
 
-		free_irq(irq, halt_node);
+	return ret;
+}
 
-		ppc_md.halt = NULL;
-		pm_power_off = NULL;
+static int gpio_halt_remove(struct platform_device *pdev)
+{
+	free_irq(halt_irq, pdev);
+	cancel_work_sync(&gpio_halt_wq);
 
-		gpio_free(gpio);
+	ppc_md.halt = NULL;
+	pm_power_off = NULL;
 
-		of_node_put(halt_node);
-		halt_node = NULL;
-	}
+	gpiod_put(halt_gpio);
+	halt_gpio = NULL;
 
 	return 0;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
