Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF969AEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBQO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjBQO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:58:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C0718CB;
        Fri, 17 Feb 2023 06:57:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u2so807294wrs.0;
        Fri, 17 Feb 2023 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDapuQAF/HKUxmWrB1WsQ7ex886RBlZc7UbLwW++3rQ=;
        b=hpv/fL9BO5baix6KemnwnUmPE8WlGiKClLGNZUEY900luxZ3jfRsFb8tlNO2Wchlvt
         y7WUP/m5hFbK/Az6VEE4tk6pXnLOBfD1Whw86fbZJ3Fa6WsuS9GmDYKRnhx+WXK+uewV
         HFWiWWnfqf4m+IbyiCLRbE+GsHbr4i/kPqTpAClZa4VxJgKby6mRwdMy0v0i4eiEd3xm
         QftNCKDXsKiJFdIum0zxzxkYvm9MPxLtl4+sbuFLl3prLxW0WRVIW6c1B3JstKrbzfD8
         FOlJQTeRdHSmsGDzZbxCqNmFS8fClDlkF8vzcP9GV+AyywXoocw88wvZtfn30OI7LAi3
         yJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDapuQAF/HKUxmWrB1WsQ7ex886RBlZc7UbLwW++3rQ=;
        b=Mc9GB57SBwpX+infJF003lAvWnTX83PgqBq0chfaeptPqCTSRIQKEd91/lS4OnMBnn
         Je87+ducQ1pvJddcuNgELWXaHnx/RnKSpgQyqTeM8tzqPU2G9vw0jIwphO90A5NUi/bd
         7z5Cx9q2VGDlJN+0qhszhZZtn3ugp/zrn1TRZkC9B02MzBA9dHlE3K/08wdD19Q6bz0h
         I7j1JdpMu2qqBvVXiqTUldR2pOfhSZv32b7dNjtjZbKPNLkssCPLkEFLj/lfyBQnQOIQ
         soSM8A3+pIU6AIepGrvOvQxVws4XJsk7J2htifg72aCg/cAj+JRS5vwyNe+9eXmu8K3V
         xZuQ==
X-Gm-Message-State: AO0yUKVoyc2F2Oo3EaOz9W8OO2XGUGQE4jtkuBYYWnLoTkebR5JjMTyn
        H00kMNAIA6WAny9Sp28zxWA=
X-Google-Smtp-Source: AK7set9T+JYNMinkq2u7C8D0C0UNzvfWoRREVGQlAMdyLnH8iJ9Z9I2WOYBXeoPAWafA7F95Prkbcg==
X-Received: by 2002:a5d:6985:0:b0:2c5:4f06:5fe with SMTP id g5-20020a5d6985000000b002c54f0605femr998412wru.57.1676645855053;
        Fri, 17 Feb 2023 06:57:35 -0800 (PST)
Received: from angelo-ThinkPad-X270.. (host085115199111.static.fidoka.tech. [85.115.199.111])
        by smtp.gmail.com with ESMTPSA id a17-20020adff7d1000000b002c3d29d83d2sm4434221wrq.63.2023.02.17.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:57:34 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Angelo Compagnucci <angelo@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 1/3] misc: servo-pwm: driver for controlling servo motors via PWM
Date:   Fri, 17 Feb 2023 15:57:28 +0100
Message-Id: <20230217145731.3018148-1-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a simple driver to control servo motor position via
PWM signal.
The driver allows to set the angle from userspace, while min/max
positions duty cycle and the motor degrees aperture are defined in
the dts.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 MAINTAINERS              |   6 ++
 drivers/misc/Kconfig     |  11 +++
 drivers/misc/Makefile    |   1 +
 drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+)
 create mode 100644 drivers/misc/servo-pwm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 39ff1a717625..8f4af64deb1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8737,6 +8737,12 @@ F:	Documentation/devicetree/bindings/power/power?domain*
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 
+GENERIC PWM SERVO DRIVER
+M:	"Angelo Compagnucci" <angelo@amarulasolutions.com>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/servo-pwm.c
+
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 9947b7892bd5..8a74087149ac 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -518,6 +518,17 @@ config VCPU_STALL_DETECTOR
 
 	  If you do not intend to run this kernel as a guest, say N.
 
+config SERVO_PWM
+	tristate "Servo motor positioning"
+	depends on PWM
+	help
+	  Driver to control generic servo motor positioning.
+	  Writing to the "angle" device attribute, the motor will move to
+	  the angle position.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called servo-pwm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 87b54a4a4422..936629b648a9 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -64,3 +64,4 @@ obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
+obj-$(CONFIG_SERVO_PWM)	+= servo-pwm.o
diff --git a/drivers/misc/servo-pwm.c b/drivers/misc/servo-pwm.c
new file mode 100644
index 000000000000..d5c2768238f4
--- /dev/null
+++ b/drivers/misc/servo-pwm.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Angelo Compagnucci <angelo@amarulasolutions.com>
+ * servo-pwm.c - driver for controlling servo motors via pwm.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/pwm.h>
+
+#define DEFAULT_DUTY_MIN	500000
+#define DEFAULT_DUTY_MAX	2500000
+#define DEFAULT_DEGREES		175
+#define DEFAULT_ANGLE		0
+
+struct servo_pwm_data {
+	u32 duty_min;
+	u32 duty_max;
+	u32 degrees;
+	u32 angle;
+
+	struct mutex lock;
+	struct pwm_device *pwm;
+	struct pwm_state pwmstate;
+};
+
+static int servo_pwm_set(struct servo_pwm_data *data, int val)
+{
+	u64 new_duty = (((data->duty_max - data->duty_min) /
+			data->degrees) * val) + data->duty_min;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	data->pwmstate.duty_cycle = new_duty;
+	data->pwmstate.enabled = 1;
+	ret = pwm_apply_state(data->pwm, &data->pwmstate);
+
+	if (!ret)
+		data->angle = val;
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static ssize_t angle_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct servo_pwm_data *data = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", data->angle);
+}
+
+static ssize_t angle_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct servo_pwm_data *data = dev_get_drvdata(dev);
+	int ret, val = 0;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (val < 0 || val > data->degrees)
+		return -EINVAL;
+
+	ret = servo_pwm_set(data, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(angle);
+
+static ssize_t degrees_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct servo_pwm_data *data = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", data->degrees);
+}
+
+static DEVICE_ATTR_RO(degrees);
+
+static struct attribute *servo_pwm_attrs[] = {
+	&dev_attr_angle.attr,
+	&dev_attr_degrees.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(servo_pwm);
+
+static int servo_pwm_probe(struct platform_device *pdev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
+	struct servo_pwm_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+
+	if (!fwnode_property_read_u32(fwnode, "duty-min", &data->duty_min) == 0)
+		data->duty_min = DEFAULT_DUTY_MIN;
+
+	if (!fwnode_property_read_u32(fwnode, "duty-max", &data->duty_max) == 0)
+		data->duty_max = DEFAULT_DUTY_MAX;
+
+	if (!fwnode_property_read_u32(fwnode, "degrees", &data->degrees) == 0)
+		data->degrees = DEFAULT_DEGREES;
+
+	data->pwm = devm_fwnode_pwm_get(&pdev->dev, fwnode, NULL);
+	if (IS_ERR(data->pwm)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->pwm),
+				     "unable to request PWM\n");
+	}
+
+	pwm_init_state(data->pwm, &data->pwmstate);
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static const struct of_device_id of_servo_pwm_match[] = {
+	{ .compatible = "servo-pwm", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_servo_pwm_match);
+
+static struct platform_driver servo_pwm_driver = {
+	.probe		= servo_pwm_probe,
+	.driver		= {
+		.name			= "servo-pwm",
+		.of_match_table		= of_servo_pwm_match,
+		.dev_groups		= servo_pwm_groups,
+	},
+};
+
+module_platform_driver(servo_pwm_driver);
+
+MODULE_AUTHOR("Angelo Compagnucci <angelo@amarulasolutions.com>");
+MODULE_DESCRIPTION("generic PWM servo motor driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

