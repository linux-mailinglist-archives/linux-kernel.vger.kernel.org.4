Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416B95F76DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJGKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJGKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:32:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F04621D;
        Fri,  7 Oct 2022 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665138725; x=1696674725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ac6AHsOE6dZL3l/DfS7Ts/FIiLLL6h51dgJUs7a8FPo=;
  b=Z/1K4UT0WYnL32pgI3bwNlpN+HeUPHsROg8W3/ugXkcyQ7nc09NkENrA
   yvNgkwjj6+aOZgl5g6nIs6tMu1Mtefe6KcNkEZdBdr9Uo63IoN6XyPzM5
   k86vq3V1Z3u7k93qOhqGQcFZ2h3dEntqdcI45qUc/2ZmlktV45hdDa+So
   VHfP5MxfbZE6/vibhtnwnfHpp42DllpPoccza5fWorqCkLU9l0FUEftp4
   N1sxLC5tAxAIU3NFxVZIxdzUMiPoTdtLNIJOxE4e3PHStp+Ppi+WlEYcA
   eUeoADFunWDqOVN4RyS4RJGWllWL5jD+BvTiIV9IwvPjPSa+LVLkNfN6O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="303684514"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="303684514"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 03:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="954025062"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="954025062"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 07 Oct 2022 03:32:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7002A199; Fri,  7 Oct 2022 13:32:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [rft, PATCH v1 1/1] pinctrl: Clean up headers
Date:   Fri,  7 Oct 2022 13:32:21 +0300
Message-Id: <20221007103221.57733-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

Very well expected to fail broadly due to missed headers in tons of the pin
control drivers.

Comments are welcome anyway!

 drivers/pinctrl/core.c                  | 19 ++++++++-------
 include/linux/pinctrl/consumer.h        | 31 +++++++++++--------------
 include/linux/pinctrl/devinfo.h         |  6 +++--
 include/linux/pinctrl/machine.h         |  8 ++++---
 include/linux/pinctrl/pinconf-generic.h | 23 ++++++++++--------
 include/linux/pinctrl/pinctrl.h         | 16 ++++++-------
 include/linux/pinctrl/pinmux.h          |  5 ++--
 7 files changed, 56 insertions(+), 52 deletions(-)

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
index 487117ccb1bc..01ac6ff5bec4 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -11,20 +11,20 @@
 #ifndef __LINUX_PINCTRL_PINCTRL_H
 #define __LINUX_PINCTRL_PINCTRL_H
 
-#include <linux/radix-tree.h>
 #include <linux/list.h>
-#include <linux/seq_file.h>
-#include <linux/pinctrl/pinctrl-state.h>
-#include <linux/pinctrl/devinfo.h>
+#include <linux/types.h>
 
 struct device;
+struct device_node;
+struct gpio_chip;
+struct module;
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

