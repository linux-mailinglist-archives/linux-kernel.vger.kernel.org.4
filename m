Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE95F7A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJGPQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJGPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:16:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BFA95E51;
        Fri,  7 Oct 2022 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665155785; x=1696691785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MftuM8BEvNJXATFrd61V1+1XsawZc1H6WdLWix2XKxk=;
  b=MPWQtEPEm4atqrJLAnzOrhOIuvhlJZpCZ8I+ukbBfQKpNDMRQNrtkCDE
   3HIt1LMgQx8G+pkfA6pSg/VyP1sSLkEFvfBc9MTH2IJBF0m25hp40rGic
   E/kzZlGww/NZA+1HK/PEVbk6s5vjUekc8dcr1/XdphdN+uVRAvwXH+uek
   ceTJJbObCtc7mJAdNZeD+AyeRQCMLAmJcwqh+lN4Egr5yfjMiqklfL8xc
   xsmtXWUQxjtoAJHOb/0FW+A+ypiyDCGV1RoC/6BqhB4zgf7QIa4h2fQkt
   F/tRDYXMjnVzfplKbNVgCBXjmAFB3qXzHSUZwICfFf+x/aM+2GqVzYaiJ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="194275889"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2022 08:16:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 7 Oct 2022 08:16:23 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 7 Oct 2022 08:16:23 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 1/2] pinctrl: at91-pio4: Add configuration to userspace
Date:   Fri, 7 Oct 2022 08:16:46 -0700
Message-ID: <20221007151647.98222-2-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
References: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Adding support for line bias flags that have been implented in gpio API.
There are functions in the gpiod library that can control line bias from
userspace this adds that functionality to this driver.

Adding .pin_config_set allows the driver's pin configuration to be
accessed from userspace. The general idea for this as been taken from
stm32, intel, and rockchip drivers that have userspace access for bias
flags.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 517f2a6330ad..13b77f1eb6e2 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -902,6 +902,25 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int atmel_conf_pin_config_set(struct pinctrl_dev *pctldev,
+				     unsigned pin,
+				     unsigned long *configs,
+				     unsigned num_configs)
+{
+	struct atmel_group *grp = atmel_pctl_find_group_by_pin(pctldev, pin);
+
+	return atmel_conf_pin_config_group_set(pctldev, grp->pin, configs, num_configs);
+}
+
+static int atmel_conf_pin_config_get(struct pinctrl_dev *pctldev,
+				     unsigned pin,
+				     unsigned long *configs)
+{
+	struct atmel_group *grp = atmel_pctl_find_group_by_pin(pctldev, pin);
+
+	return atmel_conf_pin_config_group_get(pctldev, grp->pin, configs);
+}
+
 static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 					   struct seq_file *s,
 					   unsigned int pin_id)
@@ -949,6 +968,8 @@ static const struct pinconf_ops atmel_confops = {
 	.pin_config_group_get	= atmel_conf_pin_config_group_get,
 	.pin_config_group_set	= atmel_conf_pin_config_group_set,
 	.pin_config_dbg_show	= atmel_conf_pin_config_dbg_show,
+	.pin_config_set	        = atmel_conf_pin_config_set,
+	.pin_config_get	        = atmel_conf_pin_config_get,
 };
 
 static struct pinctrl_desc atmel_pinctrl_desc = {
@@ -1139,6 +1160,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	atmel_pioctrl->gpio_chip->label = dev_name(dev);
 	atmel_pioctrl->gpio_chip->parent = dev;
 	atmel_pioctrl->gpio_chip->names = atmel_pioctrl->group_names;
+	atmel_pioctrl->gpio_chip->set_config = gpiochip_generic_config;
 
 	atmel_pioctrl->pm_wakeup_sources = devm_kcalloc(dev,
 			atmel_pioctrl->nbanks,
-- 
2.34.1

