Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6452D5BE33E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiITKb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiITKbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:21 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5CC6F264
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 3A561280BAF;
        Tue, 20 Sep 2022 18:31:17 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 10/20] gpio/rockchip: revert deferred output settings on probe
Date:   Tue, 20 Sep 2022 18:30:58 +0800
Message-Id: <20220920103108.23074-11-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0pIVkIaTxpIH0odSktDGFUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6Lzo5Tj0sLhw2FwkoLxka
        CA4aCj1VSlVKTU1ITU1CQ0xMQkNCVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUNPTEg3Bg++
X-HM-Tid: 0a835a73baf02eb1kusn3a561280baf
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch revert 3 patches:
  Revert "gpio/rockchip: handle deferring input-enable pinconfs"
  This reverts commit 7ff11357810fd124825fdd9aaf0df90262b77844.

  Revert "pinctrl/rockchip: support deferring other gpio params"
  This reverts commit 8ce5ef64546850294b021497046588a7abcebe96.

  Revert "gpio/rockchip: fetch deferred output settings on probe"
  This reverts commit 59dd178e1d7cb6cac03b32aba7ed9bbce6761b6f.

A patch for pinctrl-rockchip must be applied to make sure the gpiochips
have been registered before the pinctrl to register.
---
 drivers/gpio/gpio-rockchip.c       | 35 -------------------
 drivers/pinctrl/pinctrl-rockchip.c | 54 ++++++++++++++----------------
 drivers/pinctrl/pinctrl-rockchip.h |  7 ++--
 3 files changed, 27 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index dafcc8be1687..b294ef009daf 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -19,7 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/regmap.h>
 
 #include "../pinctrl/core.h"
@@ -708,7 +707,6 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	struct device_node *pctlnp = of_get_parent(np);
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
-	struct rockchip_pin_deferred *cfg;
 	static int gpio;
 	int id, ret;
 
@@ -736,45 +734,12 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Prevent clashes with a deferred output setting
-	 * being added right at this moment.
-	 */
-	mutex_lock(&bank->deferred_lock);
-
 	ret = rockchip_gpiolib_register(bank);
 	if (ret) {
 		clk_disable_unprepare(bank->clk);
-		mutex_unlock(&bank->deferred_lock);
 		return ret;
 	}
 
-	while (!list_empty(&bank->deferred_pins)) {
-		cfg = list_first_entry(&bank->deferred_pins,
-				       struct rockchip_pin_deferred, head);
-		list_del(&cfg->head);
-
-		switch (cfg->param) {
-		case PIN_CONFIG_OUTPUT:
-			ret = rockchip_gpio_direction_output(&bank->gpio_chip, cfg->pin, cfg->arg);
-			if (ret)
-				dev_warn(dev, "setting output pin %u to %u failed\n", cfg->pin,
-					 cfg->arg);
-			break;
-		case PIN_CONFIG_INPUT_ENABLE:
-			ret = rockchip_gpio_direction_input(&bank->gpio_chip, cfg->pin);
-			if (ret)
-				dev_warn(dev, "setting input pin %u failed\n", cfg->pin);
-			break;
-		default:
-			dev_warn(dev, "unknown deferred config param %d\n", cfg->param);
-			break;
-		}
-		kfree(cfg);
-	}
-
-	mutex_unlock(&bank->deferred_lock);
-
 	platform_set_drvdata(pdev, bank);
 	dev_info(dev, "probed %pOF\n", np);
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 801a1f6ca4db..97af52bb5481 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2702,20 +2702,19 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	return false;
 }
 
-static int rockchip_pinconf_defer_pin(struct rockchip_pin_bank *bank,
-					 unsigned int pin, u32 param, u32 arg)
+static int rockchip_pinconf_defer_output(struct rockchip_pin_bank *bank,
+					 unsigned int pin, u32 arg)
 {
-	struct rockchip_pin_deferred *cfg;
+	struct rockchip_pin_output_deferred *cfg;
 
 	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return -ENOMEM;
 
 	cfg->pin = pin;
-	cfg->param = param;
 	cfg->arg = arg;
 
-	list_add_tail(&cfg->head, &bank->deferred_pins);
+	list_add_tail(&cfg->head, &bank->deferred_output);
 
 	return 0;
 }
@@ -2736,25 +2735,6 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		if (param == PIN_CONFIG_OUTPUT || param == PIN_CONFIG_INPUT_ENABLE) {
-			/*
-			 * Check for gpio driver not being probed yet.
-			 * The lock makes sure that either gpio-probe has completed
-			 * or the gpio driver hasn't probed yet.
-			 */
-			mutex_lock(&bank->deferred_lock);
-			if (!gpio || !gpio->direction_output) {
-				rc = rockchip_pinconf_defer_pin(bank, pin - bank->pin_base, param,
-								arg);
-				mutex_unlock(&bank->deferred_lock);
-				if (rc)
-					return rc;
-
-				break;
-			}
-			mutex_unlock(&bank->deferred_lock);
-		}
-
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
 			rc =  rockchip_set_pull(bank, pin - bank->pin_base,
@@ -2783,6 +2763,22 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (rc != RK_FUNC_GPIO)
 				return -EINVAL;
 
+			/*
+			 * Check for gpio driver not being probed yet.
+			 * The lock makes sure that either gpio-probe has completed
+			 * or the gpio driver hasn't probed yet.
+			 */
+			mutex_lock(&bank->deferred_lock);
+			if (!gpio || !gpio->direction_output) {
+				rc = rockchip_pinconf_defer_output(bank, pin - bank->pin_base, arg);
+				mutex_unlock(&bank->deferred_lock);
+				if (rc)
+					return rc;
+
+				break;
+			}
+			mutex_unlock(&bank->deferred_lock);
+
 			rc = gpio->direction_output(gpio, pin - bank->pin_base,
 						    arg);
 			if (rc)
@@ -3109,7 +3105,7 @@ static int rockchip_pinctrl_register(struct platform_device *pdev,
 			pdesc++;
 		}
 
-		INIT_LIST_HEAD(&pin_bank->deferred_pins);
+		INIT_LIST_HEAD(&pin_bank->deferred_output);
 		mutex_init(&pin_bank->deferred_lock);
 	}
 
@@ -3371,7 +3367,7 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
 {
 	struct rockchip_pinctrl *info = platform_get_drvdata(pdev);
 	struct rockchip_pin_bank *bank;
-	struct rockchip_pin_deferred *cfg;
+	struct rockchip_pin_output_deferred *cfg;
 	int i;
 
 	of_platform_depopulate(&pdev->dev);
@@ -3380,9 +3376,9 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
 		bank = &info->ctrl->pin_banks[i];
 
 		mutex_lock(&bank->deferred_lock);
-		while (!list_empty(&bank->deferred_pins)) {
-			cfg = list_first_entry(&bank->deferred_pins,
-					       struct rockchip_pin_deferred, head);
+		while (!list_empty(&bank->deferred_output)) {
+			cfg = list_first_entry(&bank->deferred_output,
+					       struct rockchip_pin_output_deferred, head);
 			list_del(&cfg->head);
 			kfree(cfg);
 		}
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4759f336941e..3531633c0397 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -338,7 +338,7 @@ struct rockchip_pin_bank {
 	u32				toggle_edge_mode;
 	u32				recalced_mask;
 	u32				route_mask;
-	struct list_head		deferred_pins;
+	struct list_head		deferred_output;
 	struct mutex			deferred_lock;
 };
 
@@ -414,12 +414,9 @@ struct rockchip_pin_config {
 	unsigned int		nconfigs;
 };
 
-enum pin_config_param;
-
-struct rockchip_pin_deferred {
+struct rockchip_pin_output_deferred {
 	struct list_head head;
 	unsigned int pin;
-	enum pin_config_param param;
 	u32 arg;
 };
 
-- 
2.25.1

