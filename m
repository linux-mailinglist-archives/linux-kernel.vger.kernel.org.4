Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70BF5FA606
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJJUUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJJUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:18:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA6792CE;
        Mon, 10 Oct 2022 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665432981; x=1696968981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luoMZRRcjkQSvkBnNU8VR0CMupannG8Ebnq+5mF9mSY=;
  b=atSktSFUmMS/4aYAPZl8/ww9oU8loukFIJmmzzjRXp8JCkTtlnpoDWwu
   UoXqby4xbMeoLpNN3bhnaplLpmkdAkQbdX6Elgu3e/FLtHtrBe0wIcJI1
   eaKWn3PRF9N9LO24kPI8E+Zw4EVgKodRkcMrLNshRdwcF1Toq06olf5C6
   dyTI6S2VnPZZXPqwbVAYJKDr+Dug6VFeJodi3Q+UH02Ww1xXErfg2DL7u
   jwANSQ7ii3FC62iu2O2CYDI0PWzIrsCEx5qWJu9z86QrQyjT/DOTCpoOw
   MB/3rFqg+/1kdYkTuhGNTsg1uT/5mLOcgA/PXERTE/wjFUSGETxPuXi/i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284706770"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284706770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 13:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628424336"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628424336"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2022 13:15:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D9E2C3F; Mon, 10 Oct 2022 23:15:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 36/36] pinctrl: Clean up headers
Date:   Mon, 10 Oct 2022 23:14:52 +0300
Message-Id: <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a few things done:
- include only the headers we are direct user of
- when pointer is in use, provide a forward declaration
- add missed headers
- group generic headers and subsystem headers
- sort each group alphabetically

While at it, fix some awkward indentations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c                  | 19 ++++++++-------
 drivers/pinctrl/core.h                  | 12 +++++++++-
 drivers/pinctrl/devicetree.h            |  6 +++++
 drivers/pinctrl/pinconf.h               | 10 ++++++++
 drivers/pinctrl/pinctrl-utils.h         |  5 ++++
 drivers/pinctrl/pinmux.c                | 17 ++++++++------
 drivers/pinctrl/pinmux.h                | 11 +++++++++
 include/linux/pinctrl/consumer.h        | 31 +++++++++++--------------
 include/linux/pinctrl/devinfo.h         |  6 +++--
 include/linux/pinctrl/machine.h         |  8 ++++---
 include/linux/pinctrl/pinconf-generic.h | 23 ++++++++++--------
 include/linux/pinctrl/pinctrl.h         | 18 +++++++-------
 include/linux/pinctrl/pinmux.h          |  5 ++--
 13 files changed, 110 insertions(+), 61 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9e57f4c62e60..655f9502e73f 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -12,19 +12,21 @@
  */
 #define pr_fmt(fmt) "pinctrl core: " fmt
 
-#include <linux/kernel.h>
-#include <linux/kref.h>
-#include <linux/export.h>
-#include <linux/init.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
+
 #include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
 
 #ifdef CONFIG_GPIOLIB
 #include "../gpio/gpiolib.h"
@@ -33,9 +35,8 @@
 
 #include "core.h"
 #include "devicetree.h"
-#include "pinmux.h"
 #include "pinconf.h"
-
+#include "pinmux.h"
 
 static bool pinctrl_dummy_state;
 
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 840103c40c14..4d0bdb9fb99b 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -9,12 +9,22 @@
  */
 
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
-#include <linux/pinctrl/pinconf.h>
+#include <linux/types.h>
+
 #include <linux/pinctrl/machine.h>
 
+struct dentry;
+struct device;
+struct device_node;
+struct module;
+
+struct pinctrl;
+struct pinctrl_desc;
 struct pinctrl_gpio_range;
+struct pinctrl_state;
 
 /**
  * struct pinctrl_dev - pin control class device
diff --git a/drivers/pinctrl/devicetree.h b/drivers/pinctrl/devicetree.h
index efa80779de4f..def76aba99d1 100644
--- a/drivers/pinctrl/devicetree.h
+++ b/drivers/pinctrl/devicetree.h
@@ -5,8 +5,14 @@
  * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
  */
 
+#include <linux/errno.h>
+
+struct device_node;
 struct of_phandle_args;
 
+struct pinctrl;
+struct pinctrl_dev;
+
 #ifdef CONFIG_OF
 
 void pinctrl_dt_free_maps(struct pinctrl *p);
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index be7311373299..694bfc9961fa 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -10,6 +10,16 @@
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 
+#include <linux/errno.h>
+
+struct dentry;
+struct device_node;
+struct seq_file;
+
+struct pinctrl_dev;
+struct pinctrl_map;
+struct pinctrl_setting;
+
 #ifdef CONFIG_PINCONF
 
 int pinconf_check_ops(struct pinctrl_dev *pctldev);
diff --git a/drivers/pinctrl/pinctrl-utils.h b/drivers/pinctrl/pinctrl-utils.h
index cec407a8cc4e..4108ee2dd6d0 100644
--- a/drivers/pinctrl/pinctrl-utils.h
+++ b/drivers/pinctrl/pinctrl-utils.h
@@ -9,6 +9,11 @@
 #ifndef __PINCTRL_UTILS_H__
 #define __PINCTRL_UTILS_H__
 
+#include <linux/pinctrl/machine.h>
+
+struct pinctrl_dev;
+struct pinctrl_map;
+
 int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
 		struct pinctrl_map **map, unsigned *reserved_maps,
 		unsigned *num_maps, unsigned reserve);
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index f94d43b082d9..6bd7ac37a0e0 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -13,19 +13,22 @@
 #define pr_fmt(fmt) "pinmux core: " fmt
 
 #include <linux/ctype.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/radix-tree.h>
 #include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/string.h>
-#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/radix-tree.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+
 #include "core.h"
 #include "pinmux.h"
 
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index 72fcf03eaa43..ea6f99c24aa5 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -9,6 +9,17 @@
  *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
+
+#include <linux/types.h>
+
+struct dentry;
+struct seq_file;
+
+struct pinctrl_dev;
+struct pinctrl_gpio_range;
+struct pinctrl_map;
+struct pinctrl_setting;
+
 #ifdef CONFIG_PINMUX
 
 int pinmux_check_ops(struct pinctrl_dev *pctldev);
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 019fecd75d0c..4729d54e8995 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -12,14 +12,15 @@
 #define __LINUX_PINCTRL_CONSUMER_H
 
 #include <linux/err.h>
-#include <linux/list.h>
-#include <linux/seq_file.h>
+#include <linux/types.h>
+
 #include <linux/pinctrl/pinctrl-state.h>
 
+struct device;
+
 /* This struct is private to the core and should be regarded as a cookie */
 struct pinctrl;
 struct pinctrl_state;
-struct device;
 
 #ifdef CONFIG_PINCTRL
 
@@ -33,9 +34,8 @@ extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 
 extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
 extern void pinctrl_put(struct pinctrl *p);
-extern struct pinctrl_state * __must_check pinctrl_lookup_state(
-							struct pinctrl *p,
-							const char *name);
+extern struct pinctrl_state * __must_check pinctrl_lookup_state(struct pinctrl *p,
+								const char *name);
 extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
 
 extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
@@ -101,9 +101,8 @@ static inline void pinctrl_put(struct pinctrl *p)
 {
 }
 
-static inline struct pinctrl_state * __must_check pinctrl_lookup_state(
-							struct pinctrl *p,
-							const char *name)
+static inline struct pinctrl_state * __must_check pinctrl_lookup_state(struct pinctrl *p,
+								       const char *name)
 {
 	return NULL;
 }
@@ -145,8 +144,8 @@ static inline int pinctrl_pm_select_idle_state(struct device *dev)
 
 #endif /* CONFIG_PINCTRL */
 
-static inline struct pinctrl * __must_check pinctrl_get_select(
-					struct device *dev, const char *name)
+static inline struct pinctrl * __must_check pinctrl_get_select(struct device *dev,
+							       const char *name)
 {
 	struct pinctrl *p;
 	struct pinctrl_state *s;
@@ -171,14 +170,13 @@ static inline struct pinctrl * __must_check pinctrl_get_select(
 	return p;
 }
 
-static inline struct pinctrl * __must_check pinctrl_get_select_default(
-					struct device *dev)
+static inline struct pinctrl * __must_check pinctrl_get_select_default(struct device *dev)
 {
 	return pinctrl_get_select(dev, PINCTRL_STATE_DEFAULT);
 }
 
-static inline struct pinctrl * __must_check devm_pinctrl_get_select(
-					struct device *dev, const char *name)
+static inline struct pinctrl * __must_check devm_pinctrl_get_select(struct device *dev,
+								    const char *name)
 {
 	struct pinctrl *p;
 	struct pinctrl_state *s;
@@ -203,8 +201,7 @@ static inline struct pinctrl * __must_check devm_pinctrl_get_select(
 	return p;
 }
 
-static inline struct pinctrl * __must_check devm_pinctrl_get_select_default(
-					struct device *dev)
+static inline struct pinctrl * __must_check devm_pinctrl_get_select_default(struct device *dev)
 {
 	return devm_pinctrl_get_select(dev, PINCTRL_STATE_DEFAULT);
 }
diff --git a/include/linux/pinctrl/devinfo.h b/include/linux/pinctrl/devinfo.h
index a48ff69acddd..9e8b559e1253 100644
--- a/include/linux/pinctrl/devinfo.h
+++ b/include/linux/pinctrl/devinfo.h
@@ -14,11 +14,15 @@
 #ifndef PINCTRL_DEVINFO_H
 #define PINCTRL_DEVINFO_H
 
+struct device;
+
 #ifdef CONFIG_PINCTRL
 
 /* The device core acts as a consumer toward pinctrl */
 #include <linux/pinctrl/consumer.h>
 
+struct pinctrl;
+
 /**
  * struct dev_pin_info - pin state container for devices
  * @p: pinctrl handle for the containing device
@@ -42,8 +46,6 @@ extern int pinctrl_init_done(struct device *dev);
 
 #else
 
-struct device;
-
 /* Stubs if we're not using pinctrl */
 
 static inline int pinctrl_bind_pins(struct device *dev)
diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index e987dc9fd2af..0639b36f43c5 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -11,7 +11,7 @@
 #ifndef __LINUX_PINCTRL_MACHINE_H
 #define __LINUX_PINCTRL_MACHINE_H
 
-#include <linux/bug.h>
+#include <linux/kernel.h>	/* ARRAY_SIZE() */
 
 #include <linux/pinctrl/pinctrl-state.h>
 
@@ -149,16 +149,18 @@ struct pinctrl_map {
 #define PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(dev, grp, cfgs)		\
 	PIN_MAP_CONFIGS_GROUP(dev, PINCTRL_STATE_DEFAULT, dev, grp, cfgs)
 
+struct pinctrl_map;
+
 #ifdef CONFIG_PINCTRL
 
 extern int pinctrl_register_mappings(const struct pinctrl_map *map,
-				unsigned num_maps);
+				     unsigned num_maps);
 extern void pinctrl_unregister_mappings(const struct pinctrl_map *map);
 extern void pinctrl_provide_dummies(void);
 #else
 
 static inline int pinctrl_register_mappings(const struct pinctrl_map *map,
-					   unsigned num_maps)
+					    unsigned num_maps)
 {
 	return 0;
 }
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 2422211d6a5a..940fc4e9e17c 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -11,9 +11,12 @@
 #ifndef __LINUX_PINCTRL_PINCONF_GENERIC_H
 #define __LINUX_PINCTRL_PINCONF_GENERIC_H
 
-#include <linux/device.h>
+#include <linux/types.h>
+
 #include <linux/pinctrl/machine.h>
 
+struct device_node;
+
 struct pinctrl_dev;
 struct pinctrl_map;
 
@@ -196,25 +199,25 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 void pinconf_generic_dt_free_map(struct pinctrl_dev *pctldev,
 		struct pinctrl_map *map, unsigned num_maps);
 
-static inline int pinconf_generic_dt_node_to_map_group(
-		struct pinctrl_dev *pctldev, struct device_node *np_config,
-		struct pinctrl_map **map, unsigned *num_maps)
+static inline int pinconf_generic_dt_node_to_map_group(struct pinctrl_dev *pctldev,
+		struct device_node *np_config, struct pinctrl_map **map,
+		unsigned *num_maps)
 {
 	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
 			PIN_MAP_TYPE_CONFIGS_GROUP);
 }
 
-static inline int pinconf_generic_dt_node_to_map_pin(
-		struct pinctrl_dev *pctldev, struct device_node *np_config,
-		struct pinctrl_map **map, unsigned *num_maps)
+static inline int pinconf_generic_dt_node_to_map_pin(struct pinctrl_dev *pctldev,
+		struct device_node *np_config, struct pinctrl_map **map,
+		unsigned *num_maps)
 {
 	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
 			PIN_MAP_TYPE_CONFIGS_PIN);
 }
 
-static inline int pinconf_generic_dt_node_to_map_all(
-		struct pinctrl_dev *pctldev, struct device_node *np_config,
-		struct pinctrl_map **map, unsigned *num_maps)
+static inline int pinconf_generic_dt_node_to_map_all(struct pinctrl_dev *pctldev,
+		struct device_node *np_config, struct pinctrl_map **map,
+		unsigned *num_maps)
 {
 	/*
 	 * passing the type as PIN_MAP_TYPE_INVALID causes the underlying parser
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 487117ccb1bc..31fe992412f0 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -11,20 +11,20 @@
 #ifndef __LINUX_PINCTRL_PINCTRL_H
 #define __LINUX_PINCTRL_PINCTRL_H
 
-#include <linux/radix-tree.h>
-#include <linux/list.h>
-#include <linux/seq_file.h>
-#include <linux/pinctrl/pinctrl-state.h>
-#include <linux/pinctrl/devinfo.h>
+#include <linux/types.h>
 
 struct device;
+struct device_node;
+struct gpio_chip;
+struct module;
+struct seq_file;
+
+struct pin_config_item;
+struct pinconf_generic_params;
+struct pinconf_ops;
 struct pinctrl_dev;
 struct pinctrl_map;
 struct pinmux_ops;
-struct pinconf_ops;
-struct pin_config_item;
-struct gpio_chip;
-struct device_node;
 
 /**
  * struct pingroup - provides information on pingroup
diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
index 9a647fa5c8f1..a7e370965c53 100644
--- a/include/linux/pinctrl/pinmux.h
+++ b/include/linux/pinctrl/pinmux.h
@@ -11,11 +11,10 @@
 #ifndef __LINUX_PINCTRL_PINMUX_H
 #define __LINUX_PINCTRL_PINMUX_H
 
-#include <linux/list.h>
-#include <linux/seq_file.h>
-#include <linux/pinctrl/pinctrl.h>
+#include <linux/types.h>
 
 struct pinctrl_dev;
+struct pinctrl_gpio_range;
 
 /**
  * struct pinmux_ops - pinmux operations, to be implemented by pin controller
-- 
2.35.1

