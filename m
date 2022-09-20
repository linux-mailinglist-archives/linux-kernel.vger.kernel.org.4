Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB45BE34A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiITKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiITKb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:28 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33D6F254
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 05D0A280BDB;
        Tue, 20 Sep 2022 18:31:24 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 20/20] pinctrl/rockchip: find existed gpiochip by gpio label
Date:   Tue, 20 Sep 2022 18:31:08 +0800
Message-Id: <20220920103108.23074-21-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRhMVkMeTBgeGh1OGU4YSVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Ohw5HD0tSRwiPQoPLxRJ
        DxQwCRlVSlVKTU1ITU1CQ0NOQ0hOVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQU9PSUo3Bg++
X-HM-Tid: 0a835a73d9e42eb1kusn05d0a280bdb
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pinctrl device acts as parent for the GPIO devices for
Rockchip platform, the pinctrl driver creates the gpiochips and pass to
the GPIO driver.

This patch makes the member of pinctrl structure from gpiochip to
*gpiochip, switch to find existed gpiochips instead of creating them,
that requires the GPIO driver to create them and earlier than the
pinctrl driver.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 24 +++++++++++++++++++++---
 drivers/pinctrl/pinctrl-rockchip.h |  2 +-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 97af52bb5481..05e688cd8536 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2725,7 +2725,7 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 {
 	struct rockchip_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank = pin_to_bank(info, pin);
-	struct gpio_chip *gpio = &bank->gpio_chip;
+	struct gpio_chip *gpio = bank->gpio_chip;
 	enum pin_config_param param;
 	u32 arg;
 	int i;
@@ -2828,7 +2828,7 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 {
 	struct rockchip_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank = pin_to_bank(info, pin);
-	struct gpio_chip *gpio = &bank->gpio_chip;
+	struct gpio_chip *gpio = bank->gpio_chip;
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	u16 arg;
 	int rc;
@@ -3293,7 +3293,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	struct rockchip_pin_ctrl *ctrl;
 	struct resource *res;
 	void __iomem *base;
-	int ret;
+	int ret, i;
 
 	if (is_of_node(fwnode)) {
 		ret = of_platform_populate(np, NULL, NULL, dev);
@@ -3357,6 +3357,24 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < ctrl->nr_banks; i++) {
+		struct gpio_chip *gc;
+		struct rockchip_pin_bank *bank = &ctrl->pin_banks[i];
+
+		gc = gpiochip_find_by_name((void *)ctrl->pin_banks[i].name);
+		if (!gc) {
+			dev_err(dev, "fail to find gpiochip\n");
+			return ret;
+		}
+
+		ret = gpiochip_add_pin_range(gc, dev_name(dev), 0, gc->base, gc->ngpio);
+		if (ret) {
+			dev_err(dev, "fail to add pin range\n");
+			return ret;
+		}
+		bank->gpio_chip = gc;
+	}
+
 	platform_set_drvdata(pdev, info);
 	dev_info(dev, "probed %pfw\n", fwnode);
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 3531633c0397..8b44e02bce97 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -330,7 +330,7 @@ struct rockchip_pin_bank {
 	struct device_node		*of_node;
 	struct rockchip_pinctrl		*drvdata;
 	struct irq_domain		*domain;
-	struct gpio_chip		gpio_chip;
+	struct gpio_chip		*gpio_chip;
 	struct pinctrl_gpio_range	grange;
 	raw_spinlock_t			slock;
 	const struct rockchip_gpio_regs	*gpio_regs;
-- 
2.25.1

