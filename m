Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62891732D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbjFPKP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbjFPKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:15:51 -0400
Received: from 8.mo563.mail-out.ovh.net (8.mo563.mail-out.ovh.net [46.105.60.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6C195
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:15:48 -0700 (PDT)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
        by mo563.mail-out.ovh.net (Postfix) with ESMTPS id 9A34F23949;
        Fri, 16 Jun 2023 09:57:56 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <conor+dt@kernel.org>; Fri, 16 Jun 2023 09:57:56 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.109.146.141])
        by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4314B2011E1;
        Fri, 16 Jun 2023 09:57:56 +0000 (UTC)
Received: from traphandler.com (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Jun
 2023 11:57:55 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v9 5/5] leds: Add a multicolor LED driver to group monochromatic LEDs
Date:   Fri, 16 Jun 2023 11:57:46 +0200
Message-ID: <20230616095746.872220-6-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616095746.872220-1-jjhiblot@traphandler.com>
References: <20230616095746.872220-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS3.emp2.local (172.16.1.3) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 3613012803010902491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvgedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhruddruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehieef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grouping multiple monochrome LEDs into a multicolor LED device has a few
benefits over handling the group in user-space:
- The state of the LEDs relative to each other is consistent. In other
  words, if 2 threads competes to set the LED to green and red, the
  end-result cannot be black or yellow.
- The multicolor LED as a whole can be driven through the sysfs LED
  interface.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/leds/rgb/Kconfig                 |  13 ++
 drivers/leds/rgb/Makefile                |   1 +
 drivers/leds/rgb/leds-group-multicolor.c | 164 +++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 360c8679c6e2..fae9aeaf2ce1 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -2,6 +2,19 @@
 
 if LEDS_CLASS_MULTICOLOR
 
+config LEDS_GROUP_MULTICOLOR
+	tristate "LEDs group multi-color support"
+	depends on OF || COMPILE_TEST
+	help
+	  This option enables support for monochrome LEDs that are
+	  grouped into multicolor LEDs.
+	  This useful in the case where LEDs of different colors are
+	  physically grouped in a single multi-color LED and driven
+	  by a controller that doesn't have multi-color support.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-group-multicolor.
+
 config LEDS_PWM_MULTICOLOR
 	tristate "PWM driven multi-color LED Support"
 	depends on PWM
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index 8c01daf63f61..c11cc56384e7 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_LEDS_GROUP_MULTICOLOR)	+= leds-group-multicolor.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
 obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
new file mode 100644
index 000000000000..27c80c84de88
--- /dev/null
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * multi-color LED built with monochromatic LED devices
+ *
+ * This driver groups several monochromatic LED devices in a single multicolor LED device.
+ * Compared to handling this grouping in the user-space, the benefits are:
+ * - The state of the monochromatic LED relative to each other is always consistent.
+ * - the sysfs interface of the LEDs can be used for the group as a whole.
+ *
+ * Copyright 2023 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+ */
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct leds_multicolor {
+	struct led_classdev_mc mc_cdev;
+	struct led_classdev **monochromatics;
+};
+
+static int led_mcg_set(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct leds_multicolor *priv = container_of(mc_cdev, struct leds_multicolor, mc_cdev);
+	const unsigned int group_max_brightness = mc_cdev->led_cdev.max_brightness;
+	int i;
+
+	for (i = 0; i < mc_cdev->num_colors; i++) {
+		struct led_classdev *mono = priv->monochromatics[i];
+		const unsigned int mono_max_brightness = mono->max_brightness;
+		unsigned int intensity = mc_cdev->subled_info[i].intensity;
+		int mono_brightness;
+
+		/*
+		 * Scale the brightness according to relative intensity of the
+		 * color AND the max brightness of the monochromatic LED.
+		 */
+		mono_brightness = DIV_ROUND_CLOSEST(brightness * intensity * mono_max_brightness,
+						    group_max_brightness * group_max_brightness);
+
+		led_set_brightness(mono, mono_brightness);
+	}
+
+	return 0;
+}
+
+static void restore_sysfs_access(void *data)
+{
+	struct led_classdev *led_cdev = data;
+
+	mutex_lock(&led_cdev->led_access);
+	led_sysfs_enable(led_cdev);
+	mutex_unlock(&led_cdev->led_access);
+}
+
+static int led_mcg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct mc_subled *subled;
+	struct leds_multicolor *priv;
+	unsigned int max_brightness = 0;
+	int i, ret, count = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	for (;;) {
+		struct led_classdev *led_cdev;
+
+		led_cdev = devm_of_led_get_optional(dev, count);
+		if (IS_ERR(led_cdev))
+			return dev_err_probe(dev, PTR_ERR(led_cdev), "Unable to get LED #%d",
+					     count);
+		if (!led_cdev)
+			break;
+
+		priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
+					count + 1, sizeof(*priv->monochromatics),
+					GFP_KERNEL);
+		if (!priv->monochromatics)
+			return -ENOMEM;
+
+		priv->monochromatics[count] = led_cdev;
+
+		max_brightness = max(max_brightness, led_cdev->max_brightness);
+
+		count++;
+	}
+
+	subled = devm_kcalloc(dev, count, sizeof(*subled), GFP_KERNEL);
+	if (!subled)
+		return -ENOMEM;
+	priv->mc_cdev.subled_info = subled;
+
+	for (i = 0; i < count; i++) {
+		struct led_classdev *led_cdev = priv->monochromatics[i];
+
+		subled[i].color_index = led_cdev->color;
+
+		/* Configure the LED intensity to its maximum */
+		subled[i].intensity = max_brightness;
+	}
+
+	/* Initialise the multicolor's LED class device */
+	cdev = &priv->mc_cdev.led_cdev;
+	cdev->flags = LED_CORE_SUSPENDRESUME;
+	cdev->brightness_set_blocking = led_mcg_set;
+	cdev->max_brightness = max_brightness;
+	cdev->color = LED_COLOR_ID_MULTI;
+	priv->mc_cdev.num_colors = count;
+
+	init_data.fwnode = dev_fwnode(dev);
+	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev, &init_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register multicolor LED for %s.\n",
+				     cdev->name);
+
+	ret = led_mcg_set(cdev, cdev->brightness);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set LED value for %s.", cdev->name);
+
+	for (i = 0; i < count; i++) {
+		struct led_classdev *led_cdev = priv->monochromatics[i];
+
+		/* Make the sysfs of the monochromatic LED read-only */
+		mutex_lock(&led_cdev->led_access);
+		led_sysfs_disable(led_cdev);
+		mutex_unlock(&led_cdev->led_access);
+
+		/* Restore sysfs access when the multicolor LED is released */
+		devm_add_action_or_reset(dev, restore_sysfs_access, led_cdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_led_group_multicolor_match[] = {
+	{ .compatible = "leds-group-multicolor" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_led_group_multicolor_match);
+
+static struct platform_driver led_group_multicolor_driver = {
+	.probe		= led_mcg_probe,
+	.driver		= {
+		.name	= "leds_group_multicolor",
+		.of_match_table = of_led_group_multicolor_match,
+	}
+};
+module_platform_driver(led_group_multicolor_driver);
+
+MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
+MODULE_DESCRIPTION("LEDs group multicolor driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-group-multicolor");
-- 
2.34.1

