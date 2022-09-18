Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD685BBD74
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIRKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A815FCE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 252EB6149A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ABBC433C1;
        Sun, 18 Sep 2022 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663497295;
        bh=q2yiIEG+o0Rwe/fWGcdzXDR5EdwiLhcA+m0XtZkjwK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrRNxgOBNKDbQWzWhnD55bJZVW7MWBOFbM6XHnm0vUULCUmQtkEjWRAGts4Da9Yj/
         FBZxP4r6ZMrJM3dNd7up++r65NoseRhuJpcNJKfBvVepT10zSlzMfhSWd4EspHe9XN
         kgIDBuALNFPGLU0bDZo+UXH7SXHHnoWrg8frCT6w=
Date:   Sun, 18 Sep 2022 12:35:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, ogabbay@kernel.org, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Message-ID: <Yyb0a96poEWZUe1y@kroah.com>
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
 <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
 <20220917072356.2255620-2-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917072356.2255620-2-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:23:44PM +0900, Jiho Chu wrote:
> It contains the base codes for trinity driver. Minimal codes to load and
> probe device is provided. The Trinity Family is controlled by the
> Memory-Mapped Registers, the register addresses and offsets are
> described. And user api interfaces are presented to control device under
> ioctl manner.

Where is the documentation for how the userspace api works?  And where
is a link to the userspace code that talks to these devices?  That
belongs here in this commit changelog text please.


> 
> Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
> Signed-off-by: yelini-jeong <yelini.jeong@samsung.com>
> Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
> Signed-off-by: Parichay Kapoor <pk.kapoor@samsung.com>
> Signed-off-by: Wook Song <wook16.song@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/misc/Kconfig                        |   1 +
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/trinity/Kconfig                |  25 +
>  drivers/misc/trinity/Makefile               |   7 +
>  drivers/misc/trinity/trinity.c              | 225 +++++++++
>  drivers/misc/trinity/trinity_common.h       | 437 ++++++++++++++++++
>  drivers/misc/trinity/trinity_vision2_drv.c  | 278 ++++++++++++
>  drivers/misc/trinity/trinity_vision2_regs.h | 210 +++++++++
>  include/uapi/misc/trinity.h                 | 476 ++++++++++++++++++++
>  9 files changed, 1660 insertions(+)
>  create mode 100644 drivers/misc/trinity/Kconfig
>  create mode 100644 drivers/misc/trinity/Makefile
>  create mode 100644 drivers/misc/trinity/trinity.c
>  create mode 100644 drivers/misc/trinity/trinity_common.h
>  create mode 100644 drivers/misc/trinity/trinity_vision2_drv.c
>  create mode 100644 drivers/misc/trinity/trinity_vision2_regs.h
>  create mode 100644 include/uapi/misc/trinity.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..ad0d5f6af291 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -500,4 +500,5 @@ source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
>  source "drivers/misc/pvpanic/Kconfig"
> +source "drivers/misc/trinity/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..c63f3fc89780 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_TRINITY)		+= trinity/
> diff --git a/drivers/misc/trinity/Kconfig b/drivers/misc/trinity/Kconfig
> new file mode 100644
> index 000000000000..02ad03c2ca0e
> --- /dev/null
> +++ b/drivers/misc/trinity/Kconfig
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TRINITY
> +	bool "Samsung Neural Processing Unit"
> +	depends on HAS_IOMEM
> +	depends on HAS_DMA
> +	help
> +	  Select this option to enable driver support for Samsung
> +	  Neural Processing Unit (NPU).
> +
> +	  This driver works as a base driver of the other drivers
> +	  for Trinity device family.
> +
> +	  This option should be enabled to support Trinity
> +	  Vision 2 (TRIV2), and Trinity Audio (TRIA).
> +
> +config TRINITY_VISION2
> +	tristate "Samsung NPU Trinity Vision 2"
> +	depends on TRINITY
> +	help
> +	  Select this option to enable driver support for a Samsung
> +	  Neural Processing Unit (NPU), Trinity Vision 2.
> +
> +	  This driver enables userspace system library to access the
> +	  device via /dev/triv2-N.

Why do you have 2 Kconfig entries for only a single driver?  Please just
make it one.

> diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
> new file mode 100644
> index 000000000000..a8e5697d6d85
> --- /dev/null
> +++ b/drivers/misc/trinity/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
> +
> +trinity-y := trinity.o
> +
> +trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
> diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
> new file mode 100644
> index 000000000000..1704eecfc439
> --- /dev/null
> +++ b/drivers/misc/trinity/trinity.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Base device driver for Samsung NPU Trinity device family
> + *
> + * Copyright (C) 2020-2022 Samsung Electronics
> + * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
> + * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
> + * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
> + * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
> + * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
> + */
> +
> +#include <linux/of_address.h>
> +
> +#include "trinity_common.h"
> +
> +#define TRINITY_PADDR_BASE (0x0)
> +
> +static DEFINE_IDA(dev_nrs);
> +static DEFINE_IDA(model_ids);
> +
> +/**
> + * trinity_release() - A common callback for close() in file_operations for a
> + *		Trinity	device node. If there are device-specific data to be
> + *		cleaned-up, it is required to clean them up before invoke this
> + *		callback.
> + *
> + * @inode: Inode to be closed
> + * @file: File to be closed
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_release(struct inode *inode, struct file *file)
> +{
> +	return 0;

If a callback does nothing, odds are it is not needed at all.  Please
just remove.

And why is this a global function?



> +}
> +
> +/**
> + * trinity_open() - A common callback for open() in file_operations for a Trinity
> + *		device node. If device-specific open() is required, this
> + *		callback should be invoked by that open().
> + *
> + * @inode: inode to be opened
> + * @f: file to be opened
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_open(struct inode *inode, struct file *f)
> +{
> +	struct miscdevice *miscdev;
> +	struct trinity_driver *drv;
> +
> +	miscdev = f->private_data;
> +	drv = container_of(miscdev, struct trinity_driver, mdev);
> +	f->private_data = drv;
> +
> +	return 0;
> +}
> +
> +/**
> + * trinity_create_node() - Create trinity node
> + *
> + * @drv: an instance of trinity driver
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_create_node(struct trinity_driver *drv)
> +{
> +	struct device *dev = drv_to_dev_ptr(drv);
> +	int err;
> +
> +	/** register as a misc device */
> +	drv->mdev.minor = MISC_DYNAMIC_MINOR;
> +	drv->mdev.parent = dev;
> +	drv->mdev.name = drv->name;
> +	drv->mdev.fops = drv->desc->fops;
> +
> +	err = misc_register(&drv->mdev);
> +	if (err < 0)
> +		dev_err(dev, "failed to register as a misc device");
> +
> +	return err;
> +}
> +
> +/**
> + * trinity_destroy_node() - Destroy trinity node
> + *
> + * @drv: an instance of trinity driver
> + */
> +void trinity_destroy_node(struct trinity_driver *drv)
> +{
> +	misc_deregister(&drv->mdev);
> +}
> +
> +/**
> + * trinity_probe() - Probes a new Trinity device. This is a standard interface to
> + * probe a Trinity family device.
> + *
> + * @pdev: Platform device structure to probe
> + * @desc: Device description to probe
> + *
> + * Returns 0 on success. Otherwise, returns negative error.
> + */
> +int trinity_probe(struct platform_device *pdev, const struct trinity_desc *desc)
> +{
> +	struct device_node *np;
> +	struct device *dev;
> +	struct trinity_driver *drv;
> +	int i, err;
> +
> +	dev = &pdev->dev;
> +	dev->id = ((desc->ver & TRINITY_MASK_DEV) >> TRINITY_SHIFT_DEV);
> +
> +	/* set private data */
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->dev_id = ida_alloc(&dev_nrs, GFP_KERNEL);
> +	if (drv->dev_id < 0) {
> +		devm_kfree(dev, drv);
> +		return drv->dev_id;
> +	}
> +	snprintf(drv->name, DEV_NAME_LEN, "%s-%u", desc->type, drv->dev_id);
> +
> +	platform_set_drvdata(pdev, drv);
> +	dev_set_drvdata(dev, drv);
> +
> +	drv->dev = dev;
> +	drv->desc = desc;
> +
> +	np = dev->of_node;
> +	if (of_property_match_string(np, "samsung,trinity-type", desc->type)) {
> +		err = -EPROBE_DEFER;
> +		goto err_cleanup;
> +	}
> +
> +	/* get reg info for MMREG_BASE */
> +	for (i = 0; i < TRINITY_MAX_MMREGS; i++) {
> +		struct resource mmreg;
> +
> +		err = of_address_to_resource(np, i, &mmreg);
> +		if (err < 0) {
> +			dev_err(dev, "failed to get %d-th mmreg info", i);
> +			goto err_cleanup;
> +		}
> +
> +		drv->mmreg_vaddr[i] = devm_ioremap_resource(dev, &mmreg);
> +		if (IS_ERR(drv->mmreg_vaddr[i])) {
> +			dev_err(dev,
> +				"failed to remap %d-th mmreg resource info", i);
> +			err = PTR_ERR(drv->mmreg_vaddr[i]);
> +			goto err_cleanup;
> +		}
> +		drv->mmreg_paddr[i] = mmreg.start;
> +	}
> +
> +	/** get a TOPS property */

Why the odd "**" in comments?

thanks,

greg k-h
