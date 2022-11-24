Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3773F637283
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKXGrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXGri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:47:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA1A1A9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:47:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z4so1064520wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9OpLtyqaKw0PiXHfT9TO7nzY/mrkfiHmJbe9t7lG2TU=;
        b=slcMXzM2eFsb1+WW3lVs6FnT04sthMKtC1DA9B0yblssO67LqbRgwCxjX3WedNZ3P3
         k9jLJOUKH4tRQR3TF4K9gEUUcWO6Z0KjyOdB14oN2e/A3ruvB4vMFesFFjHnavRtV8aq
         7PYKoHJybvUia0HaUoPedaOi/L35T2IXIF+nn5xNETlpfmqUu+qAay+2ISVYNYOfP/9y
         v4JJKSzrrWKI/YkVdDXR5awTriL2aOusPsQ/jFKw4861QxZsmi/S7lhPvD5mcx+DQkVA
         xR6RfPUH8dk2VGqfw5gn4OPAUfTajC/jqnCuVlM/UXeJPerfcZR/+VeAD9MLOeAMdL5e
         +H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OpLtyqaKw0PiXHfT9TO7nzY/mrkfiHmJbe9t7lG2TU=;
        b=CvRSEsgE/nUhrRmg41kUCv6RC1fXeB2gD5vGPLcvGX/Qd/Ag1eXS1UJRZIKtvZcTu0
         P1HtBwswif2rrFeprlInjEUqg/VmMaG+N5yTTEi1+kYVwzJjRphOWjPQzjOYOupWwZrt
         kXRpNC5Y/jB0aS7RoU4/Kv0DoFWWyWhYI5Dfgw+K5YZz1rzYHxuWaaQQG9CmMjey8si4
         IrdVUDKNds9hm0X8IO9k+yJ4v9zhlWo7nFGUPM5LVqT4Ok68MRFsmNxxwGV1ruNKOT/v
         GY8T1dDWMHta/Hn+sEHJaGi6lllio21KctH7LX9lLDndgMnMB7ZHwu7d2jCqxR3C7tSj
         KAEw==
X-Gm-Message-State: ANoB5pkHYnKnuVixhjXyFpa2uZi21bf2HVn6PRvYsLHkducom+b3g5Lm
        T7FtpMU3d6SuQOh6zeEB9x/TOv5egq+nJt51OBtKWg==
X-Google-Smtp-Source: AA0mqf4AA3dYoa3sr7kuejsPvIsdvKpvKPOZ5IRyLkPOGwfcVVTDInuvER46HKYy7WEBVl4DaNNIr4/ugxcmUxh3fTI=
X-Received: by 2002:adf:b649:0:b0:241:cefe:239b with SMTP id
 i9-20020adfb649000000b00241cefe239bmr13014447wre.531.1669272454408; Wed, 23
 Nov 2022 22:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20221110080006.3563429-1-albertccwang@google.com>
 <20221110080006.3563429-4-albertccwang@google.com> <Y2yzg2v2AL6MsKvy@kroah.com>
In-Reply-To: <Y2yzg2v2AL6MsKvy@kroah.com>
From:   Albert Wang <albertccwang@google.com>
Date:   Thu, 24 Nov 2022 14:47:22 +0800
Message-ID: <CANqn-rj++p_rSkZxa5rpRXQ-9or-_18VzaE_M1vjq4aVNsrAKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] usb: host: add the xhci offload hooks implementations
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 4:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 10, 2022 at 04:00:06PM +0800, Albert Wang wrote:
> > Add the offload hooks implementations which are used in the xHCI driver
> > for vendor offload function, and some functions will call to
> > co-processor driver for further offload operations.
>
> Where is the users for these hooks?  We can't add code that doesn't have
> users as stated before.
>
> > Signed-off-by: Albert Wang <albertccwang@google.com>
> > Signed-off-by: Howard Yen <howardyen@google.com>
> > ---
> > Changes in v2:
> > - New in v2
> >
> >  drivers/usb/host/xhci-offload-impl.c | 492 +++++++++++++++++++++++++++
> >  1 file changed, 492 insertions(+)
> >  create mode 100644 drivers/usb/host/xhci-offload-impl.c
> >
> > diff --git a/drivers/usb/host/xhci-offload-impl.c b/drivers/usb/host/xhci-offload-impl.c
> > new file mode 100644
> > index 000000000000..90e546d63fbe
> > --- /dev/null
> > +++ b/drivers/usb/host/xhci-offload-impl.c
> > @@ -0,0 +1,492 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Google Corp.
>
> I don't think it's 2020 anymore :)

Thanks, I will correct it.

>
> > + *
> > + * Author:
> > + *  Howard.Yen <howardyen@google.com>
> > + */
> > +
> > +#include <linux/dmapool.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/of.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/pm_wakeup.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/usb/hcd.h>
> > +
> > +#include "xhci.h"
> > +#include "xhci-plat.h"
> > +
> > +enum usb_offload_op_mode {
> > +     USB_OFFLOAD_STOP,
> > +     USB_OFFLOAD_DRAM
> > +};
> > +
> > +enum usb_state {
> > +     USB_DISCONNECTED,
> > +     USB_CONNECTED
> > +};
> > +
> > +enum usb_offload_msg {
> > +     SET_DCBAA_PTR,
> > +     SETUP_DONE,
> > +     SET_ISOC_TR_INFO,
> > +     SYNC_CONN_STAT,
> > +     SET_OFFLOAD_STATE
> > +};
> > +
> > +struct conn_stat_args {
> > +     u16 bus_id;
> > +     u16 dev_num;
> > +     u16 slot_id;
> > +     u32 conn_stat;
> > +};
> > +
> > +struct get_isoc_tr_info_args {
> > +     u16 ep_id;
> > +     u16 dir;
> > +     u32 type;
> > +     u32 num_segs;
> > +     u32 seg_ptr;
> > +     u32 max_packet;
> > +     u32 deq_ptr;
> > +     u32 enq_ptr;
> > +     u32 cycle_state;
> > +     u32 num_trbs_free;
> > +};
> > +
> > +struct xhci_offload_data {
> > +     struct xhci_hcd *xhci;
> > +
> > +     bool usb_accessory_enabled;
> > +     bool usb_audio_offload;
> > +     bool dt_direct_usb_access;
> > +     bool offload_state;
> > +
> > +     enum usb_offload_op_mode op_mode;
> > +};
> > +
> > +static struct xhci_offload_data *offload_data;
> > +struct xhci_offload_data *xhci_get_offload_data(void)
> > +{
> > +     return offload_data;
> > +}
> > +
> > +/*
> > + * Determine if an USB device is a compatible devices:
> > + *     True: Devices are audio class and they contain ISOC endpoint
> > + *    False: Devices are not audio class or they're audio class but no ISOC endpoint or
> > + *           they have at least one interface is video class
> > + */
> > +static bool is_compatible_with_usb_audio_offload(struct usb_device *udev)
> > +{
> > +     struct usb_endpoint_descriptor *epd;
> > +     struct usb_host_config *config;
> > +     struct usb_host_interface *alt;
> > +     struct usb_interface_cache *intfc;
> > +     int i, j, k;
> > +     bool is_audio = false;
> > +
> > +     config = udev->config;
> > +     for (i = 0; i < config->desc.bNumInterfaces; i++) {
> > +             intfc = config->intf_cache[i];
> > +             for (j = 0; j < intfc->num_altsetting; j++) {
> > +                     alt = &intfc->altsetting[j];
> > +
> > +                     if (alt->desc.bInterfaceClass == USB_CLASS_VIDEO) {
> > +                             is_audio = false;
> > +                             goto out;
> > +                     }
> > +
> > +                     if (alt->desc.bInterfaceClass == USB_CLASS_AUDIO) {
> > +                             for (k = 0; k < alt->desc.bNumEndpoints; k++) {
> > +                                     epd = &alt->endpoint[k].desc;
> > +                                     if (usb_endpoint_xfer_isoc(epd)) {
> > +                                             is_audio = true;
> > +                                             break;
> > +                                     }
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +out:
> > +     return is_audio;
> > +}
> > +
> > +/*
> > + * check the usb device including the video class:
> > + *     True: Devices contain video class
> > + *    False: Device doesn't contain video class
> > + */
> > +static bool is_usb_video_device(struct usb_device *udev)
> > +{
> > +     struct usb_host_config *config;
> > +     struct usb_host_interface *alt;
> > +     struct usb_interface_cache *intfc;
> > +     int i, j;
> > +     bool is_video = false;
> > +
> > +     if (!udev || !udev->config)
> > +             return is_video;
> > +
> > +     config = udev->config;
> > +
> > +     for (i = 0; i < config->desc.bNumInterfaces; i++) {
> > +             intfc = config->intf_cache[i];
> > +             for (j = 0; j < intfc->num_altsetting; j++) {
> > +                     alt = &intfc->altsetting[j];
> > +
> > +                     if (alt->desc.bInterfaceClass == USB_CLASS_VIDEO) {
> > +                             is_video = true;
> > +                             goto out;
> > +                     }
> > +             }
> > +     }
> > +
> > +out:
> > +     return is_video;
> > +}
> > +
> > +/*
> > + * This is the driver call to co-processor for offload operations.
> > + */
> > +int offload_driver_call(enum usb_offload_msg msg, void *ptr)
> > +{
> > +     enum usb_offload_msg offload_msg;
> > +     void *argptr;
> > +
> > +     offload_msg = msg;
> > +     argptr = ptr;
>
> Don't just silence compiler warnings for no reason.
>
> Again, this does not actually do anything at all.  So how can we accept
> this code?
>

This is the driver call to our co-processor which is a specific
hardware, so I don't submit it
and make it silent here.

> > +
> > +     return 0;
> > +}
> > +
> > +static int xhci_sync_conn_stat(unsigned int bus_id, unsigned int dev_num, unsigned int slot_id,
> > +                             unsigned int conn_stat)
> > +{
> > +     struct conn_stat_args conn_args;
> > +
> > +     conn_args.bus_id = bus_id;
> > +     conn_args.dev_num = dev_num;
> > +     conn_args.slot_id = slot_id;
> > +     conn_args.conn_stat = conn_stat;
> > +
> > +     return offload_driver_call(SYNC_CONN_STAT, &conn_args);
> > +}
> > +
> > +static int usb_host_mode_state_notify(enum usb_state usb_state)
> > +{
> > +     return xhci_sync_conn_stat(0, 0, 0, usb_state);
> > +}
> > +
> > +static int xhci_udev_notify(struct notifier_block *self, unsigned long action,
> > +                             void *dev)
> > +{
> > +     struct usb_device *udev = dev;
> > +     struct xhci_offload_data *offload_data = xhci_get_offload_data();
> > +
> > +     switch (action) {
> > +     case USB_DEVICE_ADD:
> > +             if (is_compatible_with_usb_audio_offload(udev)) {
> > +                     dev_dbg(&udev->dev, "Compatible with usb audio offload\n");
> > +                     if (offload_data->op_mode == USB_OFFLOAD_DRAM) {
> > +                             xhci_sync_conn_stat(udev->bus->busnum, udev->devnum, udev->slot_id,
> > +                                                 USB_CONNECTED);
> > +                     }
> > +             }
> > +             offload_data->usb_accessory_enabled = false;
> > +             break;
> > +     case USB_DEVICE_REMOVE:
> > +             if (is_compatible_with_usb_audio_offload(udev) &&
> > +                 (offload_data->op_mode == USB_OFFLOAD_DRAM)) {
> > +                     xhci_sync_conn_stat(udev->bus->busnum, udev->devnum, udev->slot_id,
> > +                                         USB_DISCONNECTED);
> > +             }
> > +             offload_data->usb_accessory_enabled = false;
> > +             break;
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block xhci_udev_nb = {
> > +     .notifier_call = xhci_udev_notify,
> > +};
> > +
> > +static int usb_audio_offload_init(struct xhci_hcd *xhci)
> > +{
> > +     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> > +     struct xhci_offload_data *offload_data = xhci_get_offload_data();
> > +     int ret;
> > +     u32 out_val;
> > +
> > +     offload_data = kzalloc(sizeof(struct xhci_offload_data), GFP_KERNEL);
> > +     if (!offload_data)
> > +             return -ENOMEM;
> > +
> > +     if (!of_property_read_u32(dev->of_node, "offload", &out_val))
> > +             offload_data->usb_audio_offload = (out_val == 1) ? true : false;
> > +
> > +     ret = of_reserved_mem_device_init(dev);
> > +     if (ret) {
> > +             dev_err(dev, "Could not get reserved memory\n");
> > +             kfree(offload_data);
> > +             return ret;
> > +     }
> > +
> > +     offload_data->dt_direct_usb_access =
> > +             of_property_read_bool(dev->of_node, "direct-usb-access") ? true : false;
> > +     if (!offload_data->dt_direct_usb_access)
> > +             dev_warn(dev, "Direct USB accesconfirm ifs is not supported\n");
> > +
> > +     offload_data->offload_state = true;
> > +
> > +     usb_register_notify(&xhci_udev_nb);
> > +     offload_data->op_mode = USB_OFFLOAD_DRAM;
> > +     offload_data->xhci = xhci;
> > +
> > +     return 0;
> > +}
> > +
> > +static void usb_audio_offload_cleanup(struct xhci_hcd *xhci)
> > +{
> > +     struct xhci_offload_data *offload_data = xhci_get_offload_data();
> > +
> > +     offload_data->usb_audio_offload = false;
> > +     offload_data->op_mode = USB_OFFLOAD_STOP;
> > +     offload_data->xhci = NULL;
> > +
> > +     usb_unregister_notify(&xhci_udev_nb);
> > +
> > +     /* Notification for xhci driver removing */
> > +     usb_host_mode_state_notify(USB_DISCONNECTED);
> > +
> > +     kfree(offload_data);
> > +     offload_data = NULL;
>
> Why are you setting a stack variable to NULL?
Thanks, I will remove it.

>
> Anyway, this looks much better overall than the previous submissions,
> but we need a real user of this code otherwise it can not be accepted.
> Please submit the driver that uses this api as part of your next
> submission.
>

We define and use those hook apis in the common xhci driver to offload
some memory
manipulation to a co-processor. So these apis will be executed to
allocate or free memory,
like dcbaa, transfer ring, in the co-processor memory space when
offlooffload_driver_callad enabled. The file,
xhci-offload-impl.c, shows how we use those xHCI hook apis for the
offload implementation.

Here is the flow diagram:
xHCI common driver        xHCI offload implement driver
co-processor driver
hooks
                    offload_driver_call()
----------------------------
----------------------------------------
--------------------------------------------------------------
offload_init                         usb_audio_offload_init
offload_cleanup                 usb_audio_offload_cleanup
is_offload_enabled             is_offload_enabled
alloc_dcbaa                        alloc_dcbaa
       offload_driver_call(SET_DCBAA_PTR, &dcbaa_ptr);

                       offload_driver_call(SETUP_DONE, NULL);
free_dcbaa                         free_dcbaa
alloc_transfer_ring             alloc_transfer_ring
   offload_driver_call(SET_ISOC_TR_INFO, &tr_info);
free_transfer_ring              free_transfer_ring
usb_offload_skip_urb        offload_skip_urb

Thanks!

> thanks,
>
> greg k-h
