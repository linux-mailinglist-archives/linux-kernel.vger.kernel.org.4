Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2526A7BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCBHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCBHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:21:40 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDFE23D98
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:21:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z42so16598788ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SbwyaTUhRFFkR5W3MkeaNXpKy7rQS9sahOylLJtXPo=;
        b=B0Y9pEUC4la/OMDA2aCD5zt72F/UBm2s+7zXkXnq+HDv3UX5Qv1Xk5NlK7cY09Rd9f
         w96TA9fqQjVC+YfHHVLvXEW3yU9EAJDHCeqG9BKLXbsEcO2mN5qcuoSU4UnK1Ptw7Zd+
         PHnJGlmTlSwmi4ytaTmkgCJlk+7jS9neByE00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SbwyaTUhRFFkR5W3MkeaNXpKy7rQS9sahOylLJtXPo=;
        b=ShM5QxhyEZK69hlodss0ZQKxzAjK8pCKsLUjc+yrzAsjZIWrDwWxvfMN1KRaZ12+qc
         VErRi/Cs5l/1xtxzhXnBw0xkxzkDOt0hJ5FOe81F7lOQG5mwOdmlYK9PQpE9IGayu87U
         wOczkg8Dot9GIGRBSW0f1FAT6E6kQYlFCYsEpQ61VAo5LDzKSQR/sGY+TfLNZ/dOLWd/
         MQTLN3MyQlVABf1asXupZwTk7LDWrulbjA07x/QvM/7VrYJFm4nG+J2PYt/3+RLld7U+
         4FwxbeLYOBDba8nQ0DS2V1c1AVZDsTYZ2s0ZcN32kVSLJSmK9o3azdLWE0iLBOHVq/7/
         weGg==
X-Gm-Message-State: AO0yUKV5pj2xucvUnqQieHcdrypjA/TeLbhtPws5ETGRGkWPsScosJG2
        4GMgnOOpbJxgtLZNCXUsN0aVDiR68r/wmiD2tcE=
X-Google-Smtp-Source: AK7set/PbDMi51VZWaCXp9fyye4UKVxz8prgIbI0/8QPgJA0ZsVDT+ZZ8eC52tKodckAedLozPqNsg==
X-Received: by 2002:a2e:2c12:0:b0:293:5002:80ef with SMTP id s18-20020a2e2c12000000b00293500280efmr2872343ljs.20.1677741695398;
        Wed, 01 Mar 2023 23:21:35 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s8-20020a05651c048800b00290679ebac1sm1988821ljc.9.2023.03.01.23.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:21:35 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: freescale: remove generic pin config core support
Date:   Thu,  2 Mar 2023 08:21:31 +0100
Message-Id: <20230302072132.1051590-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
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

No instance of "struct imx_pinctrl_soc_info" sets '.generic_pinconf =
true', so all of this is effectively dead code.

To make it easier to understand the actual code, remove all the unused
cruft. This effectively reverts a5cadbbb081c ("pinctrl: imx: add
generic pin config core support").

It was only in use by a single SOC (imx7ulp) for a few releases, and
the commit message of dbffda08f0e9 ("pinctrl: fsl: imx7ulp: change to
use imx legacy binding") suggests that it won't be used in the
future. Certainly no new user has appeared in 20+ releases, and should
the need arise, this can be dug out of git history again.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pinctrl/freescale/Kconfig       |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx.c | 80 ++-----------------------
 drivers/pinctrl/freescale/pinctrl-imx.h | 24 --------
 3 files changed, 6 insertions(+), 100 deletions(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 7a32f77792d9..27bdc548f3a7 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -4,7 +4,7 @@ config PINCTRL_IMX
 	depends on OF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
-	select GENERIC_PINCONF
+	select PINCONF
 	select REGMAP
 
 config PINCTRL_IMX_SCU
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index e9aef764138f..93ffb5fc04e7 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -292,62 +292,6 @@ struct pinmux_ops imx_pmx_ops = {
 	.set_mux = imx_pmx_set,
 };
 
-/* decode generic config into raw register values */
-static u32 imx_pinconf_decode_generic_config(struct imx_pinctrl *ipctl,
-					      unsigned long *configs,
-					      unsigned int num_configs)
-{
-	const struct imx_pinctrl_soc_info *info = ipctl->info;
-	const struct imx_cfg_params_decode *decode;
-	enum pin_config_param param;
-	u32 raw_config = 0;
-	u32 param_val;
-	int i, j;
-
-	WARN_ON(num_configs > info->num_decodes);
-
-	for (i = 0; i < num_configs; i++) {
-		param = pinconf_to_config_param(configs[i]);
-		param_val = pinconf_to_config_argument(configs[i]);
-		decode = info->decodes;
-		for (j = 0; j < info->num_decodes; j++) {
-			if (param == decode->param) {
-				if (decode->invert)
-					param_val = !param_val;
-				raw_config |= (param_val << decode->shift)
-					      & decode->mask;
-				break;
-			}
-			decode++;
-		}
-	}
-
-	if (info->fixup)
-		info->fixup(configs, num_configs, &raw_config);
-
-	return raw_config;
-}
-
-static u32 imx_pinconf_parse_generic_config(struct device_node *np,
-					    struct imx_pinctrl *ipctl)
-{
-	const struct imx_pinctrl_soc_info *info = ipctl->info;
-	struct pinctrl_dev *pctl = ipctl->pctl;
-	unsigned int num_configs;
-	unsigned long *configs;
-	int ret;
-
-	if (!info->generic_pinconf)
-		return 0;
-
-	ret = pinconf_generic_parse_dt_config(np, pctl, &configs,
-					      &num_configs);
-	if (ret)
-		return 0;
-
-	return imx_pinconf_decode_generic_config(ipctl, configs, num_configs);
-}
-
 static int imx_pinconf_get_mmio(struct pinctrl_dev *pctldev, unsigned pin_id,
 				unsigned long *config)
 {
@@ -500,7 +444,6 @@ static const struct pinconf_ops imx_pinconf_ops = {
 /*
  * Each pin represented in fsl,pins consists of a number of u32 PIN_FUNC_ID
  * and 1 u32 CONFIG, the total size is PIN_FUNC_ID + CONFIG for each pin.
- * For generic_pinconf case, there's no extra u32 CONFIG.
  *
  * PIN_FUNC_ID format:
  * Default:
@@ -548,18 +491,12 @@ static void imx_pinctrl_parse_pin_mmio(struct imx_pinctrl *ipctl,
 	pin_mmio->mux_mode = be32_to_cpu(*list++);
 	pin_mmio->input_val = be32_to_cpu(*list++);
 
-	if (info->generic_pinconf) {
-		/* generic pin config decoded */
-		pin_mmio->config = imx_pinconf_parse_generic_config(np, ipctl);
-	} else {
-		/* legacy pin config read from devicetree */
-		config = be32_to_cpu(*list++);
+	config = be32_to_cpu(*list++);
 
-		/* SION bit is in mux register */
-		if (config & IMX_PAD_SION)
-			pin_mmio->mux_mode |= IOMUXC_CONFIG_SION;
-		pin_mmio->config = config & ~IMX_PAD_SION;
-	}
+	/* SION bit is in mux register */
+	if (config & IMX_PAD_SION)
+		pin_mmio->mux_mode |= IOMUXC_CONFIG_SION;
+	pin_mmio->config = config & ~IMX_PAD_SION;
 
 	*list_p = list;
 
@@ -587,9 +524,6 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	else
 		pin_size = FSL_PIN_SIZE;
 
-	if (info->generic_pinconf)
-		pin_size -= 4;
-
 	/* Initialise group */
 	grp->name = np->name;
 
@@ -855,10 +789,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	imx_pinctrl_desc->confops = &imx_pinconf_ops;
 	imx_pinctrl_desc->owner = THIS_MODULE;
 
-	/* for generic pinconf */
-	imx_pinctrl_desc->custom_params = info->custom_params;
-	imx_pinctrl_desc->num_custom_params = info->num_custom_params;
-
 	/* platform specific callback */
 	imx_pmx_ops.gpio_set_direction = info->gpio_set_direction;
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index fd8c4b6b3e36..f65ff45b4003 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -11,7 +11,6 @@
 #ifndef __DRIVERS_PINCTRL_IMX_H
 #define __DRIVERS_PINCTRL_IMX_H
 
-#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 
 struct platform_device;
@@ -67,14 +66,6 @@ struct imx_pin_reg {
 	s16 conf_reg;
 };
 
-/* decode a generic config into raw register value */
-struct imx_cfg_params_decode {
-	enum pin_config_param param;
-	u32 mask;
-	u8 shift;
-	bool invert;
-};
-
 /**
  * @dev: a pointer back to containing device
  * @base: the offset to the controller in virtual memory
@@ -100,15 +91,6 @@ struct imx_pinctrl_soc_info {
 	unsigned int mux_mask;
 	u8 mux_shift;
 
-	/* generic pinconf */
-	bool generic_pinconf;
-	const struct pinconf_generic_params *custom_params;
-	unsigned int num_custom_params;
-	const struct imx_cfg_params_decode *decodes;
-	unsigned int num_decodes;
-	void (*fixup)(unsigned long *configs, unsigned int num_configs,
-		      u32 *raw_config);
-
 	int (*gpio_set_direction)(struct pinctrl_dev *pctldev,
 				  struct pinctrl_gpio_range *range,
 				  unsigned offset,
@@ -122,12 +104,6 @@ struct imx_pinctrl_soc_info {
 				      const __be32 **list_p);
 };
 
-#define IMX_CFG_PARAMS_DECODE(p, m, o) \
-	{ .param = p, .mask = m, .shift = o, .invert = false, }
-
-#define IMX_CFG_PARAMS_DECODE_INVERT(p, m, o) \
-	{ .param = p, .mask = m, .shift = o, .invert = true, }
-
 #define SHARE_MUX_CONF_REG	BIT(0)
 #define ZERO_OFFSET_VALID	BIT(1)
 #define IMX_USE_SCU		BIT(2)
-- 
2.37.2

