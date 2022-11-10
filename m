Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC9623D38
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiKJIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiKJIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:17:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251C1E3ED;
        Thu, 10 Nov 2022 00:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806C261DAC;
        Thu, 10 Nov 2022 08:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D934C433C1;
        Thu, 10 Nov 2022 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668068229;
        bh=3t+Q13FsA8tsZ4ZDqHHsAoIi2Lwy/wNBVaSft7+1wO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSorc7iftoAVXvzRm2ouSe0yHQN3w/rLb8roLlrV1+I4e0J0JQd8BKgvC1NBlnhbg
         06Jaq2VFcKWrF6TOIufT9dsLmOv2VvomS1RiGlqnViEG3PaO1pH3KitqvZS4dSZe7A
         tSj77MMle2enlbo6y4DHQ3QnIObfnUc9n4z6uBAQ=
Date:   Thu, 10 Nov 2022 09:17:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: host: add the xhci offload hooks
 implementations
Message-ID: <Y2yzg2v2AL6MsKvy@kroah.com>
References: <20221110080006.3563429-1-albertccwang@google.com>
 <20221110080006.3563429-4-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110080006.3563429-4-albertccwang@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:00:06PM +0800, Albert Wang wrote:
> Add the offload hooks implementations which are used in the xHCI driver
> for vendor offload function, and some functions will call to
> co-processor driver for further offload operations.

Where is the users for these hooks?  We can't add code that doesn't have
users as stated before.

> Signed-off-by: Albert Wang <albertccwang@google.com>
> Signed-off-by: Howard Yen <howardyen@google.com>
> ---
> Changes in v2:
> - New in v2
> 
>  drivers/usb/host/xhci-offload-impl.c | 492 +++++++++++++++++++++++++++
>  1 file changed, 492 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-offload-impl.c
> 
> diff --git a/drivers/usb/host/xhci-offload-impl.c b/drivers/usb/host/xhci-offload-impl.c
> new file mode 100644
> index 000000000000..90e546d63fbe
> --- /dev/null
> +++ b/drivers/usb/host/xhci-offload-impl.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Google Corp.

I don't think it's 2020 anymore :)

> + *
> + * Author:
> + *  Howard.Yen <howardyen@google.com>
> + */
> +
> +#include <linux/dmapool.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/workqueue.h>
> +#include <linux/usb/hcd.h>
> +
> +#include "xhci.h"
> +#include "xhci-plat.h"
> +
> +enum usb_offload_op_mode {
> +	USB_OFFLOAD_STOP,
> +	USB_OFFLOAD_DRAM
> +};
> +
> +enum usb_state {
> +	USB_DISCONNECTED,
> +	USB_CONNECTED
> +};
> +
> +enum usb_offload_msg {
> +	SET_DCBAA_PTR,
> +	SETUP_DONE,
> +	SET_ISOC_TR_INFO,
> +	SYNC_CONN_STAT,
> +	SET_OFFLOAD_STATE
> +};
> +
> +struct conn_stat_args {
> +	u16 bus_id;
> +	u16 dev_num;
> +	u16 slot_id;
> +	u32 conn_stat;
> +};
> +
> +struct get_isoc_tr_info_args {
> +	u16 ep_id;
> +	u16 dir;
> +	u32 type;
> +	u32 num_segs;
> +	u32 seg_ptr;
> +	u32 max_packet;
> +	u32 deq_ptr;
> +	u32 enq_ptr;
> +	u32 cycle_state;
> +	u32 num_trbs_free;
> +};
> +
> +struct xhci_offload_data {
> +	struct xhci_hcd *xhci;
> +
> +	bool usb_accessory_enabled;
> +	bool usb_audio_offload;
> +	bool dt_direct_usb_access;
> +	bool offload_state;
> +
> +	enum usb_offload_op_mode op_mode;
> +};
> +
> +static struct xhci_offload_data *offload_data;
> +struct xhci_offload_data *xhci_get_offload_data(void)
> +{
> +	return offload_data;
> +}
> +
> +/*
> + * Determine if an USB device is a compatible devices:
> + *     True: Devices are audio class and they contain ISOC endpoint
> + *    False: Devices are not audio class or they're audio class but no ISOC endpoint or
> + *           they have at least one interface is video class
> + */
> +static bool is_compatible_with_usb_audio_offload(struct usb_device *udev)
> +{
> +	struct usb_endpoint_descriptor *epd;
> +	struct usb_host_config *config;
> +	struct usb_host_interface *alt;
> +	struct usb_interface_cache *intfc;
> +	int i, j, k;
> +	bool is_audio = false;
> +
> +	config = udev->config;
> +	for (i = 0; i < config->desc.bNumInterfaces; i++) {
> +		intfc = config->intf_cache[i];
> +		for (j = 0; j < intfc->num_altsetting; j++) {
> +			alt = &intfc->altsetting[j];
> +
> +			if (alt->desc.bInterfaceClass == USB_CLASS_VIDEO) {
> +				is_audio = false;
> +				goto out;
> +			}
> +
> +			if (alt->desc.bInterfaceClass == USB_CLASS_AUDIO) {
> +				for (k = 0; k < alt->desc.bNumEndpoints; k++) {
> +					epd = &alt->endpoint[k].desc;
> +					if (usb_endpoint_xfer_isoc(epd)) {
> +						is_audio = true;
> +						break;
> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +out:
> +	return is_audio;
> +}
> +
> +/*
> + * check the usb device including the video class:
> + *     True: Devices contain video class
> + *    False: Device doesn't contain video class
> + */
> +static bool is_usb_video_device(struct usb_device *udev)
> +{
> +	struct usb_host_config *config;
> +	struct usb_host_interface *alt;
> +	struct usb_interface_cache *intfc;
> +	int i, j;
> +	bool is_video = false;
> +
> +	if (!udev || !udev->config)
> +		return is_video;
> +
> +	config = udev->config;
> +
> +	for (i = 0; i < config->desc.bNumInterfaces; i++) {
> +		intfc = config->intf_cache[i];
> +		for (j = 0; j < intfc->num_altsetting; j++) {
> +			alt = &intfc->altsetting[j];
> +
> +			if (alt->desc.bInterfaceClass == USB_CLASS_VIDEO) {
> +				is_video = true;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +out:
> +	return is_video;
> +}
> +
> +/*
> + * This is the driver call to co-processor for offload operations.
> + */
> +int offload_driver_call(enum usb_offload_msg msg, void *ptr)
> +{
> +	enum usb_offload_msg offload_msg;
> +	void *argptr;
> +
> +	offload_msg = msg;
> +	argptr = ptr;

Don't just silence compiler warnings for no reason.

Again, this does not actually do anything at all.  So how can we accept
this code?

> +
> +	return 0;
> +}
> +
> +static int xhci_sync_conn_stat(unsigned int bus_id, unsigned int dev_num, unsigned int slot_id,
> +				unsigned int conn_stat)
> +{
> +	struct conn_stat_args conn_args;
> +
> +	conn_args.bus_id = bus_id;
> +	conn_args.dev_num = dev_num;
> +	conn_args.slot_id = slot_id;
> +	conn_args.conn_stat = conn_stat;
> +
> +	return offload_driver_call(SYNC_CONN_STAT, &conn_args);
> +}
> +
> +static int usb_host_mode_state_notify(enum usb_state usb_state)
> +{
> +	return xhci_sync_conn_stat(0, 0, 0, usb_state);
> +}
> +
> +static int xhci_udev_notify(struct notifier_block *self, unsigned long action,
> +				void *dev)
> +{
> +	struct usb_device *udev = dev;
> +	struct xhci_offload_data *offload_data = xhci_get_offload_data();
> +
> +	switch (action) {
> +	case USB_DEVICE_ADD:
> +		if (is_compatible_with_usb_audio_offload(udev)) {
> +			dev_dbg(&udev->dev, "Compatible with usb audio offload\n");
> +			if (offload_data->op_mode == USB_OFFLOAD_DRAM) {
> +				xhci_sync_conn_stat(udev->bus->busnum, udev->devnum, udev->slot_id,
> +						    USB_CONNECTED);
> +			}
> +		}
> +		offload_data->usb_accessory_enabled = false;
> +		break;
> +	case USB_DEVICE_REMOVE:
> +		if (is_compatible_with_usb_audio_offload(udev) &&
> +		    (offload_data->op_mode == USB_OFFLOAD_DRAM)) {
> +			xhci_sync_conn_stat(udev->bus->busnum, udev->devnum, udev->slot_id,
> +					    USB_DISCONNECTED);
> +		}
> +		offload_data->usb_accessory_enabled = false;
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block xhci_udev_nb = {
> +	.notifier_call = xhci_udev_notify,
> +};
> +
> +static int usb_audio_offload_init(struct xhci_hcd *xhci)
> +{
> +	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> +	struct xhci_offload_data *offload_data = xhci_get_offload_data();
> +	int ret;
> +	u32 out_val;
> +
> +	offload_data = kzalloc(sizeof(struct xhci_offload_data), GFP_KERNEL);
> +	if (!offload_data)
> +		return -ENOMEM;
> +
> +	if (!of_property_read_u32(dev->of_node, "offload", &out_val))
> +		offload_data->usb_audio_offload = (out_val == 1) ? true : false;
> +
> +	ret = of_reserved_mem_device_init(dev);
> +	if (ret) {
> +		dev_err(dev, "Could not get reserved memory\n");
> +		kfree(offload_data);
> +		return ret;
> +	}
> +
> +	offload_data->dt_direct_usb_access =
> +		of_property_read_bool(dev->of_node, "direct-usb-access") ? true : false;
> +	if (!offload_data->dt_direct_usb_access)
> +		dev_warn(dev, "Direct USB access is not supported\n");
> +
> +	offload_data->offload_state = true;
> +
> +	usb_register_notify(&xhci_udev_nb);
> +	offload_data->op_mode = USB_OFFLOAD_DRAM;
> +	offload_data->xhci = xhci;
> +
> +	return 0;
> +}
> +
> +static void usb_audio_offload_cleanup(struct xhci_hcd *xhci)
> +{
> +	struct xhci_offload_data *offload_data = xhci_get_offload_data();
> +
> +	offload_data->usb_audio_offload = false;
> +	offload_data->op_mode = USB_OFFLOAD_STOP;
> +	offload_data->xhci = NULL;
> +
> +	usb_unregister_notify(&xhci_udev_nb);
> +
> +	/* Notification for xhci driver removing */
> +	usb_host_mode_state_notify(USB_DISCONNECTED);
> +
> +	kfree(offload_data);
> +	offload_data = NULL;

Why are you setting a stack variable to NULL?

Anyway, this looks much better overall than the previous submissions,
but we need a real user of this code otherwise it can not be accepted.
Please submit the driver that uses this api as part of your next
submission.

thanks,

greg k-h
