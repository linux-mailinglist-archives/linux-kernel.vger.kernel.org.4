Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADF60593E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJTICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJTICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:02:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5617A007
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:02:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1716828wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1I7HPClo++ryFCKRfwPw8ozddog/umHncSW4ESr5eP4=;
        b=fhAygxp+omMuYNyu5P1GCCteIkMAXXLtfRA7l/M+G+wB0txe1qN3PAyFpPmFBtCmZz
         fEv5p257/eoNEXqO2HFasQuHhAdHtQbTQSyllFJuVKkL02JkfyCL/I/NoAPkBo6arBrU
         GTafTc6KctZmFBv4Z94Na7g4R+siUgbZ85UYPvZ+wQ9RY9wyJtZkY2iYkHoacdW3rN4Z
         C3/ZEEBuw5hfqmN1O6jA7B0bNfrQAt8rHay7oTTdwaVIl/Wd+D3v1mEa025jJNra5gvu
         0dAfiNW19XW3q6llbN7slRENMc6qar8QMWS/KEdd5E4yuTdKneQJUw8M1qrSYlXIf3s+
         iwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I7HPClo++ryFCKRfwPw8ozddog/umHncSW4ESr5eP4=;
        b=EP1kBTGjA9Y5bGLZjpZ5tXox3hK5XcV6UUZ5LxClsNZvkOaXlGslQKCPf796J2PBrj
         5DxQzG/wHz28YJkjYePAhZawBjpeZF7qd11dCkX4wTf1IeoX3OwpcGgcMr375ec/Q6PP
         zA6Rj5bmFymKkYHioLEfyQIMNWXTjUF/Upph0rqfDah6YNN0Nar50d3ds0fzotedfVFl
         s3w62/Pvn6NcPaYqtTrBfPW22pYeUtTe4Wtyzj2MJ7kG6eWVCzOhVf9Ol4gSg/wuQETz
         4bOE3f0f5oVeOCI7qi2wNS/qlpP7mv8sKFB177RNgwxZtvXYL23+Owx44B+N/MZRgi9y
         LrbQ==
X-Gm-Message-State: ACrzQf3xmCXoxLpJOKAPl5R2JFuF6IQwbQ46zP+wETeDvnMWWOAMwWGU
        pvs3V8sFlinpB0V5xrYxIAPeiA==
X-Google-Smtp-Source: AMsMyM4l8zmdg4uwv5qCympRojI5MUc/bxHtOBbKZLqoqjZIQyuOca/ZzQI86gU05jVOci6VpdMLzg==
X-Received: by 2002:a05:600c:1d86:b0:3c6:db0:cf55 with SMTP id p6-20020a05600c1d8600b003c60db0cf55mr8323516wms.97.1666252964670;
        Thu, 20 Oct 2022 01:02:44 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm15957763wrt.42.2022.10.20.01.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:02:44 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Arnd Bergmann <arnd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 07/14] input: remove davinci keyboard driver
In-Reply-To: <20221019152947.3857217-8-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-8-arnd@kernel.org>
Date:   Thu, 20 Oct 2022 10:02:43 +0200
Message-ID: <8735biapng.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 17:29, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The dm365evm board was removed, and no other users of this
> device exist.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/keyboard/Kconfig           |  10 -
>  drivers/input/keyboard/Makefile          |   1 -
>  drivers/input/keyboard/davinci_keyscan.c | 315 -----------------------
>  3 files changed, 326 deletions(-)
>  delete mode 100644 drivers/input/keyboard/davinci_keyscan.c
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 00292118b79b..957cc6728f4c 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -657,16 +657,6 @@ config KEYBOARD_SUN4I_LRADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sun4i-lradc-keys.
>  
> -config KEYBOARD_DAVINCI
> -	tristate "TI DaVinci Key Scan"
> -	depends on ARCH_DAVINCI_DM365
> -	help
> -	  Say Y to enable keypad module support for the TI DaVinci
> -	  platforms (DM365).
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called davinci_keyscan.
> -
>  config KEYBOARD_IPAQ_MICRO
>  	tristate "Buttons on Micro SoC (iPaq h3100,h3600,h3700)"
>  	depends on MFD_IPAQ_MICRO
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 5f67196bb2c1..5ccfdf5c0222 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_KEYBOARD_CAP11XX)		+= cap11xx.o
>  obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
>  obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
>  obj-$(CONFIG_KEYBOARD_CYPRESS_SF)	+= cypress-sf.o
> -obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
>  obj-$(CONFIG_KEYBOARD_DLINK_DIR685)	+= dlink-dir685-touchkeys.o
>  obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
>  obj-$(CONFIG_KEYBOARD_GOLDFISH_EVENTS)	+= goldfish_events.o
> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
> deleted file mode 100644
> index f489cd585b33..000000000000
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ /dev/null
> @@ -1,315 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * DaVinci Key Scan Driver for TI platforms
> - *
> - * Copyright (C) 2009 Texas Instruments, Inc
> - *
> - * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> - *
> - * Initial Code: Sandeep Paulraj <s-paulraj@ti.com>
> - */
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/types.h>
> -#include <linux/input.h>
> -#include <linux/kernel.h>
> -#include <linux/delay.h>
> -#include <linux/platform_device.h>
> -#include <linux/errno.h>
> -#include <linux/slab.h>
> -
> -#include <linux/platform_data/keyscan-davinci.h>
> -
> -/* Key scan registers */
> -#define DAVINCI_KEYSCAN_KEYCTRL		0x0000
> -#define DAVINCI_KEYSCAN_INTENA		0x0004
> -#define DAVINCI_KEYSCAN_INTFLAG		0x0008
> -#define DAVINCI_KEYSCAN_INTCLR		0x000c
> -#define DAVINCI_KEYSCAN_STRBWIDTH	0x0010
> -#define DAVINCI_KEYSCAN_INTERVAL	0x0014
> -#define DAVINCI_KEYSCAN_CONTTIME	0x0018
> -#define DAVINCI_KEYSCAN_CURRENTST	0x001c
> -#define DAVINCI_KEYSCAN_PREVSTATE	0x0020
> -#define DAVINCI_KEYSCAN_EMUCTRL		0x0024
> -#define DAVINCI_KEYSCAN_IODFTCTRL	0x002c
> -
> -/* Key Control Register (KEYCTRL) */
> -#define DAVINCI_KEYSCAN_KEYEN		0x00000001
> -#define DAVINCI_KEYSCAN_PREVMODE	0x00000002
> -#define DAVINCI_KEYSCAN_CHATOFF		0x00000004
> -#define DAVINCI_KEYSCAN_AUTODET		0x00000008
> -#define DAVINCI_KEYSCAN_SCANMODE	0x00000010
> -#define DAVINCI_KEYSCAN_OUTTYPE		0x00000020
> -
> -/* Masks for the interrupts */
> -#define DAVINCI_KEYSCAN_INT_CONT	0x00000008
> -#define DAVINCI_KEYSCAN_INT_OFF		0x00000004
> -#define DAVINCI_KEYSCAN_INT_ON		0x00000002
> -#define DAVINCI_KEYSCAN_INT_CHANGE	0x00000001
> -#define DAVINCI_KEYSCAN_INT_ALL		0x0000000f
> -
> -struct davinci_ks {
> -	struct input_dev		*input;
> -	struct davinci_ks_platform_data	*pdata;
> -	int				irq;
> -	void __iomem			*base;
> -	resource_size_t			pbase;
> -	size_t				base_size;
> -	unsigned short			keymap[];
> -};
> -
> -/* Initializing the kp Module */
> -static int __init davinci_ks_initialize(struct davinci_ks *davinci_ks)
> -{
> -	struct device *dev = &davinci_ks->input->dev;
> -	struct davinci_ks_platform_data *pdata = davinci_ks->pdata;
> -	u32 matrix_ctrl;
> -
> -	/* Enable all interrupts */
> -	__raw_writel(DAVINCI_KEYSCAN_INT_ALL,
> -		     davinci_ks->base + DAVINCI_KEYSCAN_INTENA);
> -
> -	/* Clear interrupts if any */
> -	__raw_writel(DAVINCI_KEYSCAN_INT_ALL,
> -		     davinci_ks->base + DAVINCI_KEYSCAN_INTCLR);
> -
> -	/* Setup the scan period = strobe + interval */
> -	__raw_writel(pdata->strobe,
> -		     davinci_ks->base + DAVINCI_KEYSCAN_STRBWIDTH);
> -	__raw_writel(pdata->interval,
> -		     davinci_ks->base + DAVINCI_KEYSCAN_INTERVAL);
> -	__raw_writel(0x01,
> -		     davinci_ks->base + DAVINCI_KEYSCAN_CONTTIME);
> -
> -	/* Define matrix type */
> -	switch (pdata->matrix_type) {
> -	case DAVINCI_KEYSCAN_MATRIX_4X4:
> -		matrix_ctrl = 0;
> -		break;
> -	case DAVINCI_KEYSCAN_MATRIX_5X3:
> -		matrix_ctrl = (1 << 6);
> -		break;
> -	default:
> -		dev_err(dev->parent, "wrong matrix type\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Enable key scan module and set matrix type */
> -	__raw_writel(DAVINCI_KEYSCAN_AUTODET | DAVINCI_KEYSCAN_KEYEN |
> -		     matrix_ctrl, davinci_ks->base + DAVINCI_KEYSCAN_KEYCTRL);
> -
> -	return 0;
> -}
> -
> -static irqreturn_t davinci_ks_interrupt(int irq, void *dev_id)
> -{
> -	struct davinci_ks *davinci_ks = dev_id;
> -	struct device *dev = &davinci_ks->input->dev;
> -	unsigned short *keymap = davinci_ks->keymap;
> -	int keymapsize = davinci_ks->pdata->keymapsize;
> -	u32 prev_status, new_status, changed;
> -	bool release;
> -	int keycode = KEY_UNKNOWN;
> -	int i;
> -
> -	/* Disable interrupt */
> -	__raw_writel(0x0, davinci_ks->base + DAVINCI_KEYSCAN_INTENA);
> -
> -	/* Reading previous and new status of the key scan */
> -	prev_status = __raw_readl(davinci_ks->base + DAVINCI_KEYSCAN_PREVSTATE);
> -	new_status = __raw_readl(davinci_ks->base + DAVINCI_KEYSCAN_CURRENTST);
> -
> -	changed = prev_status ^ new_status;
> -
> -	if (changed) {
> -		/*
> -		 * It goes through all bits in 'changed' to ensure
> -		 * that no key changes are being missed
> -		 */
> -		for (i = 0 ; i < keymapsize; i++) {
> -			if ((changed>>i) & 0x1) {
> -				keycode = keymap[i];
> -				release = (new_status >> i) & 0x1;
> -				dev_dbg(dev->parent, "key %d %s\n", keycode,
> -					release ? "released" : "pressed");
> -				input_report_key(davinci_ks->input, keycode,
> -						 !release);
> -				input_sync(davinci_ks->input);
> -			}
> -		}
> -		/* Clearing interrupt */
> -		__raw_writel(DAVINCI_KEYSCAN_INT_ALL,
> -			     davinci_ks->base + DAVINCI_KEYSCAN_INTCLR);
> -	}
> -
> -	/* Enable interrupts */
> -	__raw_writel(0x1, davinci_ks->base + DAVINCI_KEYSCAN_INTENA);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int __init davinci_ks_probe(struct platform_device *pdev)
> -{
> -	struct davinci_ks *davinci_ks;
> -	struct input_dev *key_dev;
> -	struct resource *res, *mem;
> -	struct device *dev = &pdev->dev;
> -	struct davinci_ks_platform_data *pdata = dev_get_platdata(dev);
> -	int error, i;
> -
> -	if (pdata->device_enable) {
> -		error = pdata->device_enable(dev);
> -		if (error < 0) {
> -			dev_dbg(dev, "device enable function failed\n");
> -			return error;
> -		}
> -	}
> -
> -	if (!pdata->keymap) {
> -		dev_dbg(dev, "no keymap from pdata\n");
> -		return -EINVAL;
> -	}
> -
> -	davinci_ks = kzalloc(sizeof(struct davinci_ks) +
> -		sizeof(unsigned short) * pdata->keymapsize, GFP_KERNEL);
> -	if (!davinci_ks) {
> -		dev_dbg(dev, "could not allocate memory for private data\n");
> -		return -ENOMEM;
> -	}
> -
> -	memcpy(davinci_ks->keymap, pdata->keymap,
> -		sizeof(unsigned short) * pdata->keymapsize);
> -
> -	key_dev = input_allocate_device();
> -	if (!key_dev) {
> -		dev_dbg(dev, "could not allocate input device\n");
> -		error = -ENOMEM;
> -		goto fail1;
> -	}
> -
> -	davinci_ks->input = key_dev;
> -
> -	davinci_ks->irq = platform_get_irq(pdev, 0);
> -	if (davinci_ks->irq < 0) {
> -		error = davinci_ks->irq;
> -		goto fail2;
> -	}
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "no mem resource\n");
> -		error = -EINVAL;
> -		goto fail2;
> -	}
> -
> -	davinci_ks->pbase = res->start;
> -	davinci_ks->base_size = resource_size(res);
> -
> -	mem = request_mem_region(davinci_ks->pbase, davinci_ks->base_size,
> -				 pdev->name);
> -	if (!mem) {
> -		dev_err(dev, "key scan registers at %08x are not free\n",
> -			davinci_ks->pbase);
> -		error = -EBUSY;
> -		goto fail2;
> -	}
> -
> -	davinci_ks->base = ioremap(davinci_ks->pbase, davinci_ks->base_size);
> -	if (!davinci_ks->base) {
> -		dev_err(dev, "can't ioremap MEM resource.\n");
> -		error = -ENOMEM;
> -		goto fail3;
> -	}
> -
> -	/* Enable auto repeat feature of Linux input subsystem */
> -	if (pdata->rep)
> -		__set_bit(EV_REP, key_dev->evbit);
> -
> -	/* Setup input device */
> -	__set_bit(EV_KEY, key_dev->evbit);
> -
> -	/* Setup the platform data */
> -	davinci_ks->pdata = pdata;
> -
> -	for (i = 0; i < davinci_ks->pdata->keymapsize; i++)
> -		__set_bit(davinci_ks->pdata->keymap[i], key_dev->keybit);
> -
> -	key_dev->name = "davinci_keyscan";
> -	key_dev->phys = "davinci_keyscan/input0";
> -	key_dev->dev.parent = dev;
> -	key_dev->id.bustype = BUS_HOST;
> -	key_dev->id.vendor = 0x0001;
> -	key_dev->id.product = 0x0001;
> -	key_dev->id.version = 0x0001;
> -	key_dev->keycode = davinci_ks->keymap;
> -	key_dev->keycodesize = sizeof(davinci_ks->keymap[0]);
> -	key_dev->keycodemax = davinci_ks->pdata->keymapsize;
> -
> -	error = input_register_device(davinci_ks->input);
> -	if (error < 0) {
> -		dev_err(dev, "unable to register davinci key scan device\n");
> -		goto fail4;
> -	}
> -
> -	error = request_irq(davinci_ks->irq, davinci_ks_interrupt,
> -			  0, pdev->name, davinci_ks);
> -	if (error < 0) {
> -		dev_err(dev, "unable to register davinci key scan interrupt\n");
> -		goto fail5;
> -	}
> -
> -	error = davinci_ks_initialize(davinci_ks);
> -	if (error < 0) {
> -		dev_err(dev, "unable to initialize davinci key scan device\n");
> -		goto fail6;
> -	}
> -
> -	platform_set_drvdata(pdev, davinci_ks);
> -	return 0;
> -
> -fail6:
> -	free_irq(davinci_ks->irq, davinci_ks);
> -fail5:
> -	input_unregister_device(davinci_ks->input);
> -	key_dev = NULL;
> -fail4:
> -	iounmap(davinci_ks->base);
> -fail3:
> -	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
> -fail2:
> -	input_free_device(key_dev);
> -fail1:
> -	kfree(davinci_ks);
> -
> -	return error;
> -}
> -
> -static int davinci_ks_remove(struct platform_device *pdev)
> -{
> -	struct davinci_ks *davinci_ks = platform_get_drvdata(pdev);
> -
> -	free_irq(davinci_ks->irq, davinci_ks);
> -
> -	input_unregister_device(davinci_ks->input);
> -
> -	iounmap(davinci_ks->base);
> -	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
> -
> -	kfree(davinci_ks);
> -
> -	return 0;
> -}
> -
> -static struct platform_driver davinci_ks_driver = {
> -	.driver	= {
> -		.name = "davinci_keyscan",
> -	},
> -	.remove	= davinci_ks_remove,
> -};
> -
> -module_platform_driver_probe(davinci_ks_driver, davinci_ks_probe);
> -
> -MODULE_AUTHOR("Miguel Aguilar");
> -MODULE_DESCRIPTION("Texas Instruments DaVinci Key Scan Driver");
> -MODULE_LICENSE("GPL");
> -- 
> 2.29.2
