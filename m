Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77606BAEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCOLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCOLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:10:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914518C0ED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:08:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o7so7538621wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ1hjs9DuAyNgBVCuhb//rMSdRm5f0sKUPREDFmhu6g=;
        b=V3fNxRXgRK/Wn1//iiTvK11UQb8xbCZ/C509tAm7wTorkaM8dDHZdR0yRYIfYYniFE
         FgYS8zP/UC4vATrXS+rBXCa84o+Yn2/iK5+jx4vCJZZuzuZYK9xw0xStNYrW7fHyXqia
         WXcqfsvdXXRviSRZ+BWJQuGRGYHaLvSm/gzuHLb175h83uThX5LzWKOoybHxAKOkGcDX
         uJ1UENsEVNwiV8IDOETBR4ihtpMDZtswP3DbQrf3QLnHW//C7lTy1gXNSv4qfIojj7nY
         DJ2MfB152pIBx6uJYYomQw1CGCpvKwrhPwY8C4bq0uRnQdjuRvmesEimNoxP4D9x9BaK
         pfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ1hjs9DuAyNgBVCuhb//rMSdRm5f0sKUPREDFmhu6g=;
        b=O8CM8+12fxqscKpFzAljCqMKY9BNqV/Xabqm3HrJpXW9XWvb0lyTlK+mzZw7gYjKjj
         +wqr4a2m8moGN0sMEqG28V0zrvyJ9AgLa48g5ExJbq3OaZpRfc0tIUa9Yxo6LAwZmncW
         NH6nsxpFr3IIGuoXPUowt4J7923vkjpaaUidExMxSpZc5SSagFz1Gi7Z1pjpAAAb4Vm5
         VvHq5mARu2blrnlSaEpNekCG9ZbghZid3rzut0RpvNrVdnXXKvsNzAQNXDcH6EidHWCC
         0ZaAflo20VoVYblgNcahiGfx+CbPfAWNoeo5EP/CXZmM5LdberpTYUyl4+9i6mtkaOxM
         SGeQ==
X-Gm-Message-State: AO0yUKVfnrFVkJqWcc0Tp0Pm2hXviI5tIhJxtuNsUCFrZI4PZAzQtn05
        hAa36/RjshIzuIQk5imorFzRTg==
X-Google-Smtp-Source: AK7set908PZJnpVn9VzU/oBz/tUejZ3qpGNtSm8mp0+GtZ2Q0hAde0vwUC+ACzrEUtv0RFjeO8MHUg==
X-Received: by 2002:adf:ef0e:0:b0:2cf:ee6b:36aa with SMTP id e14-20020adfef0e000000b002cfee6b36aamr1545664wro.64.1678878467641;
        Wed, 15 Mar 2023 04:07:47 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe785000000b002c7066a6f77sm4339745wrm.31.2023.03.15.04.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:47 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: [PATCH v2 4/4] misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM
Date:   Wed, 15 Mar 2023 12:07:36 +0100
Message-Id: <20230315110736.35506-5-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230315110736.35506-1-jpanis@baylibre.com>
References: <20230315110736.35506-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/misc/Kconfig                          |  12 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/tps6594-pfsm.c                   | 304 ++++++++++++++++++
 include/uapi/linux/tps6594_pfsm.h             |  45 +++
 5 files changed, 363 insertions(+)
 create mode 100644 drivers/misc/tps6594-pfsm.c
 create mode 100644 include/uapi/linux/tps6594_pfsm.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 0a1882e296ae..07ff4d619db4 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -180,6 +180,7 @@ Code  Seq#    Include File                                           Comments
 'P'   00-0F  drivers/usb/class/usblp.c                               conflict!
 'P'   01-09  drivers/misc/pci_endpoint_test.c                        conflict!
 'P'   00-0F  xen/privcmd.h                                           conflict!
+'P'   00-03  linux/tps6594_pfsm.h                                    conflict!
 'Q'   all    linux/soundcard.h
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
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
index 000000000000..ce7859ac82ab
--- /dev/null
+++ b/drivers/misc/tps6594-pfsm.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PFSM (Pre-configurable Finite State Machine) driver for TI TPS6594/TPS6593/LP8764X PMICs
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
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
+static int tps6594_pfsm_configure_ret_trig(struct regmap *regmap, u8 options)
+{
+	int ret;
+
+	if (options & PMIC_GPIO_RETENTION)
+		ret = regmap_set_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+				      TPS6594_BIT_TRIGGER_I2C(5) | TPS6594_BIT_TRIGGER_I2C(6));
+	else
+		ret = regmap_clear_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
+					TPS6594_BIT_TRIGGER_I2C(5) | TPS6594_BIT_TRIGGER_I2C(6));
+	if (ret)
+		return ret;
+
+	if (options & PMIC_DDR_RETENTION)
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
+	struct pmic_state pfsm_state;
+	void __user *argp = (void __user *)arg;
+	int ret = -EINVAL;
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
+	case PMIC_SET_STATE:
+		if (copy_from_user(&pfsm_state, argp, sizeof(pfsm_state)))
+			return -EFAULT;
+
+		switch (pfsm_state.state) {
+		case PMIC_ACTIVE_STATE:
+			/* Modify NSLEEP1-2 bits */
+			ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+					      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
+			break;
+		case PMIC_MCU_ONLY_STATE:
+			/* Configure retention triggers */
+			ret = tps6594_pfsm_configure_ret_trig(pfsm->regmap, pfsm_state.options);
+			if (ret)
+				return ret;
+
+			/* Modify NSLEEP1-2 bits */
+			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+						TPS6594_BIT_NSLEEP1B);
+			if (ret)
+				return ret;
+
+			ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+					      TPS6594_BIT_NSLEEP2B);
+			break;
+		case PMIC_RETENTION_STATE:
+			/* Configure wake-up destination */
+			if (pfsm_state.options & PMIC_MCU_ONLY_STARTUP_DEST)
+				ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+							TPS6594_MASK_STARTUP_DEST,
+							TPS6594_STARTUP_DEST_MCU_ONLY);
+			else
+				ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+							TPS6594_MASK_STARTUP_DEST,
+							TPS6594_STARTUP_DEST_ACTIVE);
+			if (ret)
+				return ret;
+
+			/* Configure retention triggers */
+			ret = tps6594_pfsm_configure_ret_trig(pfsm->regmap, pfsm_state.options);
+			if (ret)
+				return ret;
+
+			/* Modify NSLEEP1-2 bits */
+			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+						TPS6594_BIT_NSLEEP2B);
+			break;
+		}
+
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
index 000000000000..e5264af71d2e
--- /dev/null
+++ b/include/uapi/linux/tps6594_pfsm.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for TPS6594 PMIC Pre-configurable Finite State Machine
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#ifndef __TPS6594_PFSM_H
+#define __TPS6594_PFSM_H
+
+#include <linux/const.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* PFSM state definitions */
+enum pfsm_state {
+	PMIC_ACTIVE_STATE,
+	PMIC_MCU_ONLY_STATE,
+	PMIC_RETENTION_STATE
+};
+
+/**
+ * struct pmic_state - PMIC state identification
+ * @state:   PFSM destination state
+ * @options: options for destination state
+ */
+struct pmic_state {
+	enum pfsm_state state;
+	__u8 options;
+};
+
+/* Commands */
+#define	PMIC_BASE			'P'
+
+#define	PMIC_GOTO_STANDBY		_IO(PMIC_BASE, 0)
+#define	PMIC_GOTO_LP_STANDBY		_IO(PMIC_BASE, 1)
+#define	PMIC_UPDATE_PGM			_IO(PMIC_BASE, 2)
+#define	PMIC_SET_STATE			_IOW(PMIC_BASE, 3, struct pmic_state)
+
+/* Options for destination state */
+#define PMIC_GPIO_RETENTION		_BITUL(0)
+#define PMIC_DDR_RETENTION		_BITUL(1)
+#define PMIC_MCU_ONLY_STARTUP_DEST	_BITUL(2)
+
+#endif /*  __TPS6594_PFSM_H */
-- 
2.37.3

