Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303136AA3F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjCCWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjCCWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885A691895;
        Fri,  3 Mar 2023 14:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56A8F618F1;
        Fri,  3 Mar 2023 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32BCC433EF;
        Fri,  3 Mar 2023 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677880854;
        bh=8Tx/4zW6qLMV49U7TVBUoizFmTU9zv1Tov2IzIHxtt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q48LbH0jdWDYuskXO5iWnl+BhMgt3rJ6B4LjMz/kPJ4V3yXED0LmEsBwaAkV4POQj
         cOdh0BcpS+NLDJo1rtr8rlwDikhPyAyPGVNjFG6pzLNrcU7BJEaqfNGjFMHmzjD0iL
         auDUaAqi0mseM7fUFcH9FXbIYsdnjqGjtrF/0oJO4uyWGcMXZjOHBLqlcUKS0koux7
         kUTWGosRpSvWuniQFQnJoLrBPV2+ci9Ja23CrSURlDZYF01NQ84QwaSqvhWz1PYXYg
         CLjyERr8hdGtvVgbywPQBBfU25Rxb9DZdSKur9PKbfMn2kGkRShUXKMCcbzo//qF9x
         A4ipr16c5KlDg==
Date:   Fri, 3 Mar 2023 22:00:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, hdegoede@redhat.com, eric.auger@redhat.com,
        jgg@ziepe.ca, razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: Re: [PATCH v1 4/4] mfd: tps6594-pfsm: Add driver for TI TPS6594 PFSM
Message-ID: <20230303220047.GT2420672@google.com>
References: <20230216114410.183489-1-jpanis@baylibre.com>
 <20230216114410.183489-5-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216114410.183489-5-jpanis@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Julien Panis wrote:

> This patch adds support for TPS6594 PFSM (Pre-configurable Finite
> State Machine).
> 
> This PFSM controls the operational modes of the PMIC:
> - STANDBY and LP_STANDBY,
> - ACTIVE state,
> - MCU_ONLY state,
> - RETENTION state, with or without DDR and/or GPIO retention.
> Depending on the current operational mode, some voltage domains
> remain energized while others can be off.
> 
> This PFSM is also used to trigger a firmware update, and provides
> R/W access to device registers.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/mfd/Kconfig                           |  11 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/tps6594-pfsm.c                    | 304 ++++++++++++++++++
>  include/uapi/linux/tps6594_pfsm.h             |  45 +++
>  5 files changed, 362 insertions(+)
>  create mode 100644 drivers/mfd/tps6594-pfsm.c
>  create mode 100644 include/uapi/linux/tps6594_pfsm.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index eb045fc495a4..f3098d3800a5 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -180,6 +180,7 @@ Code  Seq#    Include File                                           Comments
>  'P'   00-0F  drivers/usb/class/usblp.c                               conflict!
>  'P'   01-09  drivers/misc/pci_endpoint_test.c                        conflict!
>  'P'   00-0F  xen/privcmd.h                                           conflict!
> +'P'   00-03  linux/tps6594_pfsm.h                                    conflict!
>  'Q'   all    linux/soundcard.h
>  'R'   00-1F  linux/random.h                                          conflict!
>  'R'   01     linux/rfkill.h                                          conflict!
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index cbf7cfb70879..188c949e4eb0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1732,6 +1732,17 @@ config MFD_TPS6594_ESM
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-esm.
>  
> +config MFD_TPS6594_PFSM
> +	tristate "TI TPS6594 Pre-configurable Finite State Machine support"
> +	depends on MFD_TPS6594
> +	help
> +	  Support PFSM (Pre-configurable Finite State Machine) on TPS6594 PMIC devices.
> +	  These devices integrate a finite state machine engine, which manages the state
> +	  of the device during operating state transition.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tps6594-pfsm.
> +
>  config TWL4030_CORE
>  	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index ae2d404cd6b8..c201c186ae38 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_MFD_TPS6594)	+= tps6594-core.o
>  obj-$(CONFIG_MFD_TPS6594_I2C)	+= tps6594-i2c.o
>  obj-$(CONFIG_MFD_TPS6594_SPI)	+= tps6594-spi.o
>  obj-$(CONFIG_MFD_TPS6594_ESM)	+= tps6594-esm.o
> +obj-$(CONFIG_MFD_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
>  
>  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> diff --git a/drivers/mfd/tps6594-pfsm.c b/drivers/mfd/tps6594-pfsm.c
> new file mode 100644
> index 000000000000..ce7859ac82ab
> --- /dev/null
> +++ b/drivers/mfd/tps6594-pfsm.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * PFSM (Pre-configurable Finite State Machine) driver for TI TPS6594/TPS6593/LP8764X PMICs
> + *
> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioctl.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/tps6594.h>
> +
> +#include <linux/tps6594_pfsm.h>
> +
> +#define TPS6594_STARTUP_DEST_MCU_ONLY_VAL 2
> +#define TPS6594_STARTUP_DEST_ACTIVE_VAL   3
> +#define TPS6594_STARTUP_DEST_SHIFT	  5
> +#define TPS6594_STARTUP_DEST_MCU_ONLY	  (TPS6594_STARTUP_DEST_MCU_ONLY_VAL \
> +					   << TPS6594_STARTUP_DEST_SHIFT)
> +#define TPS6594_STARTUP_DEST_ACTIVE	  (TPS6594_STARTUP_DEST_ACTIVE_VAL \
> +					   << TPS6594_STARTUP_DEST_SHIFT)
> +
> +/*
> + * To update the PMIC firmware, the user must be able to access
> + * page 0 (user registers) and page 1 (NVM control and configuration).
> + */
> +#define TPS6594_PMIC_MAX_POS 0x200
> +
> +#define TPS6594_FILE_TO_PFSM(f) container_of((f)->private_data, struct tps6594_pfsm, miscdev)
> +
> +/**
> + * struct tps6594_pfsm - device private data structure
> + *
> + * @miscdev: misc device infos
> + * @regmap:  regmap for accessing the device registers
> + */
> +struct tps6594_pfsm {
> +	struct miscdevice miscdev;
> +	struct regmap *regmap;
> +};
> +
> +static ssize_t tps6594_pfsm_read(struct file *f, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
> +	loff_t pos = *ppos;
> +	unsigned int val;
> +	int ret;
> +	int i;
> +
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= TPS6594_PMIC_MAX_POS)
> +		return 0;
> +	if (count > TPS6594_PMIC_MAX_POS - pos)
> +		count = TPS6594_PMIC_MAX_POS - pos;
> +
> +	for (i = 0 ; i < count ; i++) {
> +		ret = regmap_read(pfsm->regmap, pos + i, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (put_user(val, buf + i))
> +			return -EFAULT;
> +	}
> +
> +	*ppos = pos + count;
> +
> +	return count;
> +}
> +
> +static ssize_t tps6594_pfsm_write(struct file *f, const char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
> +	loff_t pos = *ppos;
> +	char val;
> +	int ret;
> +	int i;
> +
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= TPS6594_PMIC_MAX_POS || !count)
> +		return 0;
> +	if (count > TPS6594_PMIC_MAX_POS - pos)
> +		count = TPS6594_PMIC_MAX_POS - pos;
> +
> +	for (i = 0 ; i < count ; i++) {
> +		if (get_user(val, buf + i))
> +			return -EFAULT;
> +
> +		ret = regmap_write(pfsm->regmap, pos + i, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*ppos = pos + count;
> +
> +	return count;
> +}
> +
> +static int tps6594_pfsm_configure_ret_trig(struct regmap *regmap, u8 options)
> +{
> +	int ret;
> +
> +	if (options & PMIC_GPIO_RETENTION)
> +		ret = regmap_set_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +				      TPS6594_BIT_TRIGGER_I2C(5) | TPS6594_BIT_TRIGGER_I2C(6));
> +	else
> +		ret = regmap_clear_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +					TPS6594_BIT_TRIGGER_I2C(5) | TPS6594_BIT_TRIGGER_I2C(6));
> +	if (ret)
> +		return ret;
> +
> +	if (options & PMIC_DDR_RETENTION)
> +		ret = regmap_set_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +				      TPS6594_BIT_TRIGGER_I2C(7));
> +	else
> +		ret = regmap_clear_bits(regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +					TPS6594_BIT_TRIGGER_I2C(7));
> +
> +	return ret;
> +}
> +
> +static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
> +	struct pmic_state pfsm_state;
> +	void __user *argp = (void __user *)arg;
> +	int ret = -EINVAL;
> +
> +	switch (cmd) {
> +	case PMIC_GOTO_STANDBY:
> +		/* Disable LP mode */
> +		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
> +					TPS6594_BIT_LP_STANDBY_SEL);
> +		if (ret)
> +			return ret;
> +
> +		/* Force trigger */
> +		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +					TPS6594_BIT_TRIGGER_I2C(0), TPS6594_BIT_TRIGGER_I2C(0));
> +		break;
> +	case PMIC_GOTO_LP_STANDBY:
> +		/* Enable LP mode */
> +		ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
> +				      TPS6594_BIT_LP_STANDBY_SEL);
> +		if (ret)
> +			return ret;
> +
> +		/* Force trigger */
> +		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +					TPS6594_BIT_TRIGGER_I2C(0), TPS6594_BIT_TRIGGER_I2C(0));
> +		break;
> +	case PMIC_UPDATE_PGM:
> +		/* Force trigger */
> +		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
> +					TPS6594_BIT_TRIGGER_I2C(3), TPS6594_BIT_TRIGGER_I2C(3));
> +		break;
> +	case PMIC_SET_STATE:
> +		if (copy_from_user(&pfsm_state, argp, sizeof(pfsm_state)))
> +			return -EFAULT;
> +
> +		switch (pfsm_state.state) {
> +		case PMIC_ACTIVE_STATE:
> +			/* Modify NSLEEP1-2 bits */
> +			ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> +					      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
> +			break;
> +		case PMIC_MCU_ONLY_STATE:
> +			/* Configure retention triggers */
> +			ret = tps6594_pfsm_configure_ret_trig(pfsm->regmap, pfsm_state.options);
> +			if (ret)
> +				return ret;
> +
> +			/* Modify NSLEEP1-2 bits */
> +			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> +						TPS6594_BIT_NSLEEP1B);
> +			if (ret)
> +				return ret;
> +
> +			ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> +					      TPS6594_BIT_NSLEEP2B);
> +			break;
> +		case PMIC_RETENTION_STATE:
> +			/* Configure wake-up destination */
> +			if (pfsm_state.options & PMIC_MCU_ONLY_STARTUP_DEST)
> +				ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
> +							TPS6594_MASK_STARTUP_DEST,
> +							TPS6594_STARTUP_DEST_MCU_ONLY);
> +			else
> +				ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
> +							TPS6594_MASK_STARTUP_DEST,
> +							TPS6594_STARTUP_DEST_ACTIVE);
> +			if (ret)
> +				return ret;
> +
> +			/* Configure retention triggers */
> +			ret = tps6594_pfsm_configure_ret_trig(pfsm->regmap, pfsm_state.options);
> +			if (ret)
> +				return ret;
> +
> +			/* Modify NSLEEP1-2 bits */
> +			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
> +						TPS6594_BIT_NSLEEP2B);
> +			break;
> +		}
> +
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations tps6594_pfsm_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= generic_file_llseek,
> +	.read		= tps6594_pfsm_read,
> +	.write		= tps6594_pfsm_write,
> +	.unlocked_ioctl	= tps6594_pfsm_ioctl,
> +};
> +
> +static irqreturn_t tps6594_pfsm_isr(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	int i;
> +
> +	for (i = 0 ; i < pdev->num_resources ; i++) {
> +		if (irq == platform_get_irq_byname(pdev, pdev->resource[i].name)) {
> +			dev_err(pdev->dev.parent, "%s event detected\n", pdev->resource[i].name);
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int tps6594_pfsm_probe(struct platform_device *pdev)
> +{
> +	struct tps6594_pfsm *pfsm;
> +	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +	int i;
> +
> +	pfsm = devm_kzalloc(dev, sizeof(struct tps6594_pfsm), GFP_KERNEL);
> +	if (!pfsm)
> +		return -ENOMEM;
> +
> +	pfsm->regmap = tps->regmap;
> +
> +	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
> +					    tps->chip_id, tps->reg);
> +	pfsm->miscdev.fops = &tps6594_pfsm_fops;
> +	pfsm->miscdev.parent = dev->parent;
> +
> +	for (i = 0 ; i < pdev->num_resources ; i++) {
> +		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
> +					     pdev->resource[i].name);
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						tps6594_pfsm_isr, IRQF_ONESHOT,
> +						pdev->resource[i].name, pdev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request irq\n");
> +	}
> +
> +	platform_set_drvdata(pdev, pfsm);
> +
> +	return misc_register(&pfsm->miscdev);

`mv <this> drivers/misc` ?

> +}
> +
> +static int tps6594_pfsm_remove(struct platform_device *pdev)
> +{
> +	struct tps6594_pfsm *pfsm = platform_get_drvdata(pdev);
> +
> +	misc_deregister(&pfsm->miscdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tps6594_pfsm_driver = {
> +	.driver	= {
> +		.name = "tps6594-pfsm",
> +	},
> +	.probe = tps6594_pfsm_probe,
> +	.remove = tps6594_pfsm_remove,
> +};
> +
> +module_platform_driver(tps6594_pfsm_driver);
> +
> +MODULE_ALIAS("platform:tps6594-pfsm");
> +MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
> +MODULE_DESCRIPTION("TPS6594 Pre-configurable Finite State Machine Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/tps6594_pfsm.h b/include/uapi/linux/tps6594_pfsm.h
> new file mode 100644
> index 000000000000..e5264af71d2e
> --- /dev/null
> +++ b/include/uapi/linux/tps6594_pfsm.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace ABI for TPS6594 PMIC Pre-configurable Finite State Machine
> + *
> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> + */
> +
> +#ifndef __TPS6594_PFSM_H
> +#define __TPS6594_PFSM_H
> +
> +#include <linux/const.h>
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* PFSM state definitions */
> +enum pfsm_state {
> +	PMIC_ACTIVE_STATE,
> +	PMIC_MCU_ONLY_STATE,
> +	PMIC_RETENTION_STATE
> +};
> +
> +/**
> + * struct pmic_state - PMIC state identification
> + * @state:   PFSM destination state
> + * @options: options for destination state
> + */
> +struct pmic_state {
> +	enum pfsm_state state;
> +	__u8 options;
> +};
> +
> +/* Commands */
> +#define	PMIC_BASE			'P'
> +
> +#define	PMIC_GOTO_STANDBY		_IO(PMIC_BASE, 0)
> +#define	PMIC_GOTO_LP_STANDBY		_IO(PMIC_BASE, 1)
> +#define	PMIC_UPDATE_PGM			_IO(PMIC_BASE, 2)
> +#define	PMIC_SET_STATE			_IOW(PMIC_BASE, 3, struct pmic_state)
> +
> +/* Options for destination state */
> +#define PMIC_GPIO_RETENTION		_BITUL(0)
> +#define PMIC_DDR_RETENTION		_BITUL(1)
> +#define PMIC_MCU_ONLY_STARTUP_DEST	_BITUL(2)
> +
> +#endif /*  __TPS6594_PFSM_H */
> -- 
> 2.37.3
> 

-- 
Lee Jones [李琼斯]
