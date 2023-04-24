Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B998A6D90E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjDFH4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjDFH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:56:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302A7ED6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:56:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o32so22122951wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680767796; x=1683359796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoBCKTiAdyC/opY0HXa8GW2HnI0l/XGenX5J0kipDQs=;
        b=0IXP2RD/yIQwSTNX2Yfp7k1VFlSL0drlKKQEZUpfz3nHwvuKr27QrMniu79tFl0+0m
         ifUjDrwO4d58x2ZpjDUKEgll4P1rl/F3PMGlH0NVG0U6siEDxCp2N7cLIY/CYJ0d9RaT
         SuwVNe53MoT9Jbjg3FiYT63FydqDAL3S//StZipXqW6ElFg+xur4d6y3waMaPdCig83x
         9VjVRv2ezIYrOiWy72mIsapJC8Q3ZR31Tw0Liek9n0n8Xw7CsKNMdtLk7dzrz61YqaV5
         CHNcEhb/Jv+3UnRMKtHg10qVU8dVhSJg73XfoQ2cJnBBgGPFLbi5PjP56+RO6JZuZmbK
         Lvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767796; x=1683359796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoBCKTiAdyC/opY0HXa8GW2HnI0l/XGenX5J0kipDQs=;
        b=CHznJwXICcLcSTuERzUHxqBThtFiaHwWhBKprEtVAd97zHjfk+onbye5Lm2IglZutJ
         VPULyz6ZzEznwFhRd1l8QQrSib1R7h6638UMoGDnfIxwEPuvnZIfx6n98XujL4n8fIWJ
         q5iCMuHp7Do6USudyc7RS6K28u5fd54F4eBcqpAZGGDS3pMCCLByB/DVtxAJXVBgtwAA
         Uxbq+u99flMDAi5SeYEFWMSkkO2o/NaEdRLI/flcMu4PG6rMRT5UFm0wK971gJMsZQyd
         TPyjVvOjp53/Xfc7hn0oZx1CQD3TZ0frxDY4SG1zdA0mJOuGGBxXb1Vxr/XrGmkoNs9N
         UPdA==
X-Gm-Message-State: AAQBX9dm75N1h5jrupVZ8AMEb9zKR914IwtmUZFABmnKM1r/zgEvD/Kx
        mJMnaHbFDVZM+O31H8Wma/rEUg==
X-Google-Smtp-Source: AKy350bMz6yf5WEW4GwkTuECIkmHJ0c4mV5apogPWiCootfybCZm3NQfakhj3MCLyFcOcSY16Lb+8A==
X-Received: by 2002:a7b:cd85:0:b0:3ee:3f7:35aa with SMTP id y5-20020a7bcd85000000b003ee03f735aamr6653250wmj.19.1680767796027;
        Thu, 06 Apr 2023 00:56:36 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm4572651wmo.44.2023.04.06.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 00:56:35 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, macro@orcam.me.uk, dsahern@kernel.org,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        keescook@chromium.org, me@kloenk.de, mhiramat@kernel.org,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v6 4/6] misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM
Date:   Thu,  6 Apr 2023 09:56:20 +0200
Message-Id: <20230406075622.8990-5-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230406075622.8990-1-jpanis@baylibre.com>
References: <20230406075622.8990-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This PFSM controls the operational modes of the PMIC:
- STANDBY and LP_STANDBY,
- ACTIVE state,
- MCU_ONLY state,
- RETENTION state, with or without DDR and/or GPIO retention.
Depending on the current operational mode, some voltage domains
remain energized while others can be off.

This PFSM is also used to trigger a firmware update, and provides
R/W access to device registers.

See Documentation/misc-devices/tps6594-pfsm.rst for more
information.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/misc/Kconfig              |  12 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/tps6594-pfsm.c       | 306 ++++++++++++++++++++++++++++++
 include/uapi/linux/tps6594_pfsm.h |  37 ++++
 4 files changed, 356 insertions(+)
 create mode 100644 drivers/misc/tps6594-pfsm.c
 create mode 100644 include/uapi/linux/tps6594_pfsm.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c73c02801330..75e427f124b2 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -549,6 +549,18 @@ config TPS6594_ESM
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps6594-esm.
 
+config TPS6594_PFSM
+	tristate "TI TPS6594 Pre-configurable Finite State Machine support"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	help
+	  Support PFSM (Pre-configurable Finite State Machine) on TPS6594 PMIC devices.
+	  These devices integrate a finite state machine engine, which manages the state
+	  of the device during operating state transition.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tps6594-pfsm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3dc69ec69912..f2a4d1ff65d4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,3 +66,4 @@ obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
 obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
 obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
+obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
new file mode 100644
index 000000000000..5223d1580807
--- /dev/null
+++ b/drivers/misc/tps6594-pfsm.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PFSM (Pre-configurable Finite State Machine) driver for TI TPS6594/TPS6593/LP8764 PMICs
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/tps6594.h>
+
+#include <linux/tps6594_pfsm.h>
+
+#define TPS6594_STARTUP_DEST_MCU_ONLY_VAL 2
+#define TPS6594_STARTUP_DEST_ACTIVE_VAL   3
+#define TPS6594_STARTUP_DEST_SHIFT	  5
+#define TPS6594_STARTUP_DEST_MCU_ONLY	  (TPS6594_STARTUP_DEST_MCU_ONLY_VAL \
+					   << TPS6594_STARTUP_DEST_SHIFT)
+#define TPS6594_STARTUP_DEST_ACTIVE	  (TPS6594_STARTUP_DEST_ACTIVE_VAL \
+					   << TPS6594_STARTUP_DEST_SHIFT)
+
+/*
+ * To update the PMIC firmware, the user must be able to access
+ * page 0 (user registers) and page 1 (NVM control and configuration).
+ */
+#define TPS6594_PMIC_MAX_POS 0x200
+
+#define TPS6594_FILE_TO_PFSM(f) container_of((f)->private_data, struct tps6594_pfsm, miscdev)
+
+/**
+ * struct tps6594_pfsm - device private data structure
+ *
+ * @miscdev: misc device infos
+ * @regmap:  regmap for accessing the device registers
+ */
+struct tps6594_pfsm {
+	struct miscdevice miscdev;
+	struct regmap *regmap;
+};
+
+static ssize_t tps6594_pfsm_read(struct file *f, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
+	loff_t pos = *ppos;
+	unsigned int val;
+	int ret;
+	int i;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= TPS6594_PMIC_MAX_POS)
+		return 0;
+	if (count > TPS6594_PMIC_MAX_POS - pos)
+		count = TPS6594_PMIC_MAX_POS - pos;
+
+	for (i = 0 ; i < count ; i++) {
+		ret = regmap_read(pfsm->regmap, pos + i, &val);
+		if (ret)
+			return ret;
+
+		if (put_user(val, buf + i))
+			return -EFAULT;
+	}
+
+	*ppos = pos + count;
+
+	return count;
+}
+
+static ssize_t tps6594_pfsm_write(struct file *f, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
+	loff_t pos = *ppos;
+	char val;
+	int ret;
+	int i;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= TPS6594_PMIC_MAX_POS || !count)
+		return 0;
+	if (count > TPS6594_PMIC_MAX_POS - pos)
+		count = TPS6594_PMIC_MAX_POS - pos;
+
+	for (i = 0 ; i < count ; i++) {
+		if (get_user(val, buf + i))
+			return -EFAULT;
+
+		ret = regmap_write(pfsm->regmap, pos + i, val);
+		if (ret)
+			return ret;
+	}
+
+	*ppos = pos + count;
+
+	return count;
+}
+
+static int tps6594_pfsm_configure_ret_trig(struct regmap *regmap, u8 gpio_ret, u8 ddr_ret)
+{
+	int ret;
+
+	if (gpio_ret)
+		ret = regmap_set_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+				      TPS6594_BIT_TRIGGER_I2C(5) | TPS6594_BIT_TRIGGER_I2C(6));
+	else
+		ret = regmap_clear_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(5) | TPS6594_BIT_TRIGGER_I2C(6));
+	if (ret)
+		return ret;
+
+	if (ddr_ret)
+		ret = regmap_set_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+				      TPS6594_BIT_TRIGGER_I2C(7));
+	else
+		ret = regmap_clear_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(7));
+
+	return ret;
+}
+
+static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
+	struct pmic_state_opt state_opt;
+	void __user *argp = (void __user *)arg;
+	int ret = -ENOIOCTLCMD;
+
+	switch (cmd) {
+	case PMIC_GOTO_STANDBY:
+		/* Disable LP mode */
+		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+					TPS6594_BIT_LP_STANDBY_SEL);
+		if (ret)
+			return ret;
+
+		/* Force trigger */
+		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(0), TPS6594_BIT_TRIGGER_I2C(0));
+		break;
+	case PMIC_GOTO_LP_STANDBY:
+		/* Enable LP mode */
+		ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+				      TPS6594_BIT_LP_STANDBY_SEL);
+		if (ret)
+			return ret;
+
+		/* Force trigger */
+		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(0), TPS6594_BIT_TRIGGER_I2C(0));
+		break;
+	case PMIC_UPDATE_PGM:
+		/* Force trigger */
+		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(3), TPS6594_BIT_TRIGGER_I2C(3));
+		break;
+	case PMIC_SET_ACTIVE_STATE:
+		/* Modify NSLEEP1-2 bits */
+		ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+				      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
+		break;
+	case PMIC_SET_MCU_ONLY_STATE:
+		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
+			return -EFAULT;
+
+		/* Configure retention triggers */
+		ret = tps6594_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
+						      state_opt.ddr_retention);
+		if (ret)
+			return ret;
+
+		/* Modify NSLEEP1-2 bits */
+		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+					TPS6594_BIT_NSLEEP1B);
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+				      TPS6594_BIT_NSLEEP2B);
+		break;
+	case PMIC_SET_RETENTION_STATE:
+		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
+			return -EFAULT;
+
+		/* Configure wake-up destination */
+		if (state_opt.mcu_only_startup_dest)
+			ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+						TPS6594_MASK_STARTUP_DEST,
+						TPS6594_STARTUP_DEST_MCU_ONLY);
+		else
+			ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+						TPS6594_MASK_STARTUP_DEST,
+						TPS6594_STARTUP_DEST_ACTIVE);
+		if (ret)
+			return ret;
+
+		/* Configure retention triggers */
+		ret = tps6594_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
+						      state_opt.ddr_retention);
+		if (ret)
+			return ret;
+
+		/* Modify NSLEEP1-2 bits */
+		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+					TPS6594_BIT_NSLEEP2B);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations tps6594_pfsm_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= generic_file_llseek,
+	.read		= tps6594_pfsm_read,
+	.write		= tps6594_pfsm_write,
+	.unlocked_ioctl	= tps6594_pfsm_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
+};
+
+static irqreturn_t tps6594_pfsm_isr(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	int i;
+
+	for (i = 0 ; i < pdev->num_resources ; i++) {
+		if (irq == platform_get_irq_byname(pdev, pdev->resource[i].name)) {
+			dev_err(pdev->dev.parent, "%s event detected\n", pdev->resource[i].name);
+			return IRQ_HANDLED;
+		}
+	}
+
+	return IRQ_NONE;
+}
+
+static int tps6594_pfsm_probe(struct platform_device *pdev)
+{
+	struct tps6594_pfsm *pfsm;
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	int irq;
+	int ret;
+	int i;
+
+	pfsm = devm_kzalloc(dev, sizeof(struct tps6594_pfsm), GFP_KERNEL);
+	if (!pfsm)
+		return -ENOMEM;
+
+	pfsm->regmap = tps->regmap;
+
+	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
+					    tps->chip_id, tps->reg);
+	pfsm->miscdev.fops = &tps6594_pfsm_fops;
+	pfsm->miscdev.parent = dev->parent;
+
+	for (i = 0 ; i < pdev->num_resources ; i++) {
+		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
+					     pdev->resource[i].name);
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						tps6594_pfsm_isr, IRQF_ONESHOT,
+						pdev->resource[i].name, pdev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request irq\n");
+	}
+
+	platform_set_drvdata(pdev, pfsm);
+
+	return misc_register(&pfsm->miscdev);
+}
+
+static int tps6594_pfsm_remove(struct platform_device *pdev)
+{
+	struct tps6594_pfsm *pfsm = platform_get_drvdata(pdev);
+
+	misc_deregister(&pfsm->miscdev);
+
+	return 0;
+}
+
+static struct platform_driver tps6594_pfsm_driver = {
+	.driver	= {
+		.name = "tps6594-pfsm",
+	},
+	.probe = tps6594_pfsm_probe,
+	.remove = tps6594_pfsm_remove,
+};
+
+module_platform_driver(tps6594_pfsm_driver);
+
+MODULE_ALIAS("platform:tps6594-pfsm");
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 Pre-configurable Finite State Machine Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/tps6594_pfsm.h b/include/uapi/linux/tps6594_pfsm.h
new file mode 100644
index 000000000000..c69569e0a7a2
--- /dev/null
+++ b/include/uapi/linux/tps6594_pfsm.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for TPS6594 PMIC Pre-configurable Finite State Machine
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#ifndef __TPS6594_PFSM_H
+#define __TPS6594_PFSM_H
+
+#include <linux/const.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct pmic_state_opt - PMIC state options
+ * @gpio_retention: if enabled, power rails associated with GPIO retention remain active
+ * @ddr_retention: if enabled, power rails associated with DDR retention remain active
+ * @mcu_only_startup_dest: if enabled, startup destination state is MCU_ONLY
+ */
+struct pmic_state_opt {
+	__u8 gpio_retention;
+	__u8 ddr_retention;
+	__u8 mcu_only_startup_dest;
+};
+
+/* Commands */
+#define PMIC_BASE			'P'
+
+#define PMIC_GOTO_STANDBY		_IO(PMIC_BASE, 0)
+#define PMIC_GOTO_LP_STANDBY		_IO(PMIC_BASE, 1)
+#define PMIC_UPDATE_PGM			_IO(PMIC_BASE, 2)
+#define PMIC_SET_ACTIVE_STATE		_IO(PMIC_BASE, 3)
+#define PMIC_SET_MCU_ONLY_STATE		_IOW(PMIC_BASE, 4, struct pmic_state_opt)
+#define PMIC_SET_RETENTION_STATE	_IOW(PMIC_BASE, 5, struct pmic_state_opt)
+
+#endif /*  __TPS6594_PFSM_H */
-- 
2.37.3

