Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4220688FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBCGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:32:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E26BBFA;
        Thu,  2 Feb 2023 22:32:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507F5B82964;
        Fri,  3 Feb 2023 06:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FE9C433EF;
        Fri,  3 Feb 2023 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675405931;
        bh=1tYlbUrmIWItWfrG1mC0cbT7GICarj0egTeSB9YxrKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqzyy0FDpYBjyiC83XXSs4B+uFht0O/gB+Pbn42FZnHhmRF06tmuywzSyh3WGkZu2
         DAOy4Ivm/nUrBCpD7exH84+fYoFJQpjz8a5o7VdRYro9msv/CK3DKuP9PhAYtYz0X/
         vFnfYH6uIjKP7ty/zwZj3jqzdt4QPtmtWiecVJsg=
Date:   Fri, 3 Feb 2023 07:19:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCHv2 2/4] wiegand: add Wiegand bus driver
Message-ID: <Y9ynYmIhygqp3U5u@kroah.com>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202143305.21789-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:33:03PM +0100, Martin Zaťovič wrote:
> Add a bus driver for Wiegand protocol. The bus driver handles
> Wiegand controller and Wiegand device managemement and driver
> matching. The bus driver defines the structures for Wiegand
> controllers and Wiegand devices.
> 
> Wiegand controller structure represents a master and contains
> attributes such as the payload_len for configuring the size
> of a single Wiegand message in bits. It also stores the
> controller attributes defined in the devicetree.
> 
> Each Wiegand controller should be associated with one Wiegand
> device, as Wiegand is typically a point-to-point bus.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>

Looking better, some comments below:

> --- /dev/null
> +++ b/drivers/wiegand/Kconfig
> @@ -0,0 +1,20 @@
> +config WIEGAND
> +        tristate "Wiegand Bus driver"
> +        help
> +	  The "Wiegand Interface" is an asynchronous low-level protocol

Mix of tabs and spaces, please use tabs for the other lines as well.

> --- /dev/null
> +++ b/drivers/wiegand/wiegand.c
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: GPL-2.0-only

No copyright line?  It's not required, but usually a nice idea.

> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>
> +#include <linux/wiegand.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/property.h>
> +
> +static struct bus_type wiegand_bus_type;
> +static DEFINE_IDR(wiegand_controller_idr);
> +
> +static void devm_wiegand_release_controller(struct device *dev, void *ctlr)
> +{
> +	wiegand_controller_put(*(struct wiegand_controller **)ctlr);
> +}
> +
> +static void wiegand_controller_release(struct device *dev)
> +{
> +	struct wiegand_controller *ctlr;
> +
> +	ctlr = container_of(dev, struct wiegand_controller, dev);
> +	kfree(ctlr);
> +}
> +
> +static struct class wiegand_controller_class = {
> +	.name = "wiegand_master",
> +	.owner = THIS_MODULE,
> +	.dev_release = wiegand_controller_release,
> +};

You have a class and a bus.  Why?  What is the class for?  What's the
difference between devices on the bus and devices in the class?  Usually
it is either one or the other, not both.


> +
> +static DEFINE_MUTEX(board_lock);
> +
> +struct wiegand_controller *__wiegand_alloc_controller(struct device *dev,
> +						unsigned int size, bool slave)
> +{
> +	struct wiegand_controller *ctlr;
> +	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
> +
> +	if (!dev)
> +		return NULL;
> +
> +	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);
> +	if (!ctlr)
> +		return NULL;
> +
> +	device_initialize(&ctlr->dev);
> +	ctlr->bus_num = -1;
> +	ctlr->slave = slave;
> +	ctlr->dev.class = &wiegand_controller_class;
> +	ctlr->dev.parent = dev;
> +	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
> +
> +	return ctlr;
> +}
> +EXPORT_SYMBOL_GPL(__wiegand_alloc_controller);

Why are you exporting functions with "__" as a prefix?  You do that in a
few places here, that's not normal.

> +/*
> + * Controllers that do not have a devicetree entry need to initialize the
> + * following struct wiegand_controller attributes: pulse_len, interval_len and
> + * frame_gap.
> + */
> +int wiegand_register_controller(struct wiegand_controller *ctlr)

Use real kerneldoc comment style for your public functions?

> +{
> +	struct device *dev = ctlr->dev.parent;
> +	int status, id, first_dynamic;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	status = wiegand_controller_check_ops(ctlr);
> +	if (status)
> +		return status;
> +
> +	if (ctlr->dev.of_node) {
> +		id = of_alias_get_id(ctlr->dev.of_node, "wiegand");
> +		if (id > 0) {
> +			ctlr->bus_num = id;
> +			mutex_lock(&board_lock);
> +			id = idr_alloc(&wiegand_controller_idr, ctlr,
> +							ctlr->bus_num,
> +							ctlr->bus_num + 1,
> +							GFP_KERNEL);
> +			mutex_unlock(&board_lock);
> +			if (WARN(id < 0, "couldn't get idr"))
> +				return id == -ENOSPC ? -EBUSY : id;
> +		}
> +		device_property_read_u32(&ctlr->dev, "pulse-len-us",
> +							&ctlr->pulse_len);

You have an odd "continued line" style throughouut the .c and .h files.
It doesn't need to look like this, you have 100 columns to play with,
this can all be on one line.

> +		device_property_read_u32(&ctlr->dev, "interval-len-us",
> +							&ctlr->interval_len);
> +		device_property_read_u32(&ctlr->dev, "frame-gap-us",
> +							&ctlr->frame_gap);
> +	}
> +	if (ctlr->bus_num < 0) {
> +		first_dynamic = of_alias_get_highest_id("wiegand");
> +		if (first_dynamic < 0)
> +			first_dynamic = 0;
> +		else
> +			first_dynamic++;
> +
> +		mutex_lock(&board_lock);
> +		id = idr_alloc(&wiegand_controller_idr, ctlr, first_dynamic,
> +								0, GFP_KERNEL);

But when you can't put it on one line, indendent the next line to line
up with the "(" character.  So these 2 lines should be:

		id = idr_alloc(&wiegand_controller_idr, ctlr, first_dynamic,
			       0, GFP_KERNEL);

But again, you have 100 columns, this all could have been on oneline.

> +		mutex_unlock(&board_lock);
> +		if (WARN(id < 0, "couldn't get idr\n"))
> +			return id;
> +		ctlr->bus_num = id;
> +	}
> +
> +	if (ctlr->pulse_len == 0)
> +		dev_warn(&ctlr->dev, "pulse_len is not initialized\n");
> +	if (ctlr->interval_len == 0)
> +		dev_warn(&ctlr->dev, "interval_len is not initialized\n");
> +	if (ctlr->frame_gap == 0)
> +		dev_warn(&ctlr->dev, "frame_gap is not initialized\n");

You warn, but then do nothing about it?  What are these messages for?

> --- /dev/null
> +++ b/include/linux/wiegand.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
> +#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/mod_devicetable.h>
> +
> +#define WIEGAND_NAME_SIZE 32
> +
> +extern struct bus_type wiegand_type;
> +
> +/**
> + * struct wiegand_device - Wiegand listener device
> + * @dev - drivers structure of the device
> + * @id - unique device id
> + * @controller - Wiegand controller associated with the device
> + * @modalias - Name of the driver to use with this device, or its alias.
> + */
> +struct wiegand_device {
> +	struct device dev;
> +	u8 id;
> +	struct wiegand_controller *controller;
> +	char modalias[WIEGAND_NAME_SIZE];

Why is the modalias in the device structure?  That should be able to be
computed by the id or something like that, not a fixed string in here.


> +};
> +
> +/**
> + * struct wiegand_controller - Wiegand master or slave interface
> + * @dev - Device interface of the controller
> + * @list - Link with the global wiegand_controller list
> + * @bus_num - Board-specific identifier for Wiegand controller
> + * @pulse_len: length of the low pulse in usec; defaults to 50us
> + * @interval_len: length of a whole bit (both the pulse and the high phase) in
> + *	usec; defaults to 2000us
> + * @frame_gap: length of the last bit of a frame (both the pulse and the high
> + *	phase) in usec; defaults to interval_len
> + * device_count - Counter of devices connected to the same Wiegand
> + *	bus(controller).
> + * devm_allocated - Whether the allocation of this struct is devres-managed
> + * slave - Whether the controller is a slave(receives data).
> + * transfer_message - Send a message on the bus.
> + * setup - Setup a device.
> + * cleanup - Cleanup after a device.
> + */
> +struct wiegand_controller {
> +	struct device dev;
> +	struct list_head list;

Why do you need a separate list for this, why not use the list in the
device structure that you already have?


> +
> +	s16 bus_num;
> +
> +	u32 pulse_len;
> +	u32 interval_len;
> +	u32 frame_gap;
> +
> +	u32 payload_len;
> +
> +	u8 device_count;
> +
> +	bool devm_allocated;
> +	bool slave;
> +
> +	int (*transfer_message)(struct wiegand_device *dev, u8 *message,
> +								u8 bitlen);

One line please.

> +
> +	int (*setup)(struct wiegand_device *wiegand);
> +	void (*cleanup)(struct wiegand_device *wiegand);

Try using the tool 'pahole' and see how much wasted space is in this
structure and then move things around a bit.  No need for holes in the
structure for no good reason.

> +};
> +
> +struct wiegand_driver {
> +	const struct wiegand_device_id *id_table;
> +	int (*probe)(struct wiegand_device *wiegand);
> +	void (*remove)(struct wiegand_device *wiegand);
> +	struct device_driver driver;
> +};
> +
> +/* Wiegand controller section */
> +
> +#define wiegand_master wiegand_controller
> +extern struct wiegand_controller *__wiegand_alloc_controller(
> +							struct device *host,
> +							unsigned int size,
> +							bool slave);

No need for "extern".

> +
> +struct wiegand_controller *__devm_wiegand_alloc_controller(struct device *dev,
> +						   unsigned int size,
> +						   bool slave);
> +struct wiegand_controller *__wiegand_alloc_controller(struct device *dev,
> +							unsigned int size,
> +							bool slave);
> +static inline struct wiegand_controller *devm_wiegand_alloc_master(
> +							struct device *dev,
> +							unsigned int size)
> +{
> +	return __devm_wiegand_alloc_controller(dev, size, false);
> +}
> +extern int wiegand_register_controller(struct wiegand_controller *ctlr);
> +extern int devm_wiegand_register_controller(struct device *dev,
> +					struct wiegand_controller *ctlr);
> +#define wiegand_register_master(_ctlr) wiegand_register_controller(_ctlr)
> +#define devm_wiegand_register_master(_dev, _ctlr) \
> +	devm_wiegand_register_controller(_dev, _ctlr)
> +extern void wiegand_unregister_controller(struct wiegand_controller *ctlr);
> +#define wiegand_unregister_master(_ctlr) wiegand_unregister_controller(_ctlr)
> +extern struct wiegand_master *wiegand_busnum_to_master(u16 bus_num);
> +
> +static inline void *wiegand_controller_get_devdata(
> +						struct wiegand_controller *ctlr)

Odd alignment, all on one line please.

thanks,

greg k-h
