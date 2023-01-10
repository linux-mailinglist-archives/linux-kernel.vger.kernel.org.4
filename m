Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B66640FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjAJM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjAJM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:56:07 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF6A200F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:56:04 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id v6so17360466edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkVsfeziaSUCY5VZ/4OpE4ktn6TSP6dNu/AZFlqYhJo=;
        b=4GZJPqN6SZWoZomTo+AfkMoh1LZHpWTzMNrlDx+FRCaRj/XGdkQq6bkutZZhQ7Bb7X
         vkvlP39cKCtSpP7gXu9MgN0jsHEERi0Fura79nUnetzKD4F7dUjVDVKMH5jLfFv6FD64
         goKcjLdI0xfxUO9xnU0M3ecA4uSd2mgcGGsNDlMx7T3zvDudksJzS5vJuMH7B6FA37KU
         HhpJS9yGyMcIpyKa14fG5uDIPEFBut+urrGy3JAWaHaVwVcyx7Cu1QkJvvPKdva319tY
         lMAM7OoT6hZs77ky48+spOiWgmVafWjSwYPE0+c4UAefjMZCoJv+pDqoanyStkghzzGn
         Z1iQ==
X-Gm-Message-State: AFqh2kp4Gdk1CDVQygJ0W0lHbI221EkFwEit9ve0gcZA77IKZR54E4aX
        gUJT+8DrGQ7Tgu7N0mIiRNpwlvyiPTvM04KR8r5E+GKz9sg=
X-Google-Smtp-Source: AMrXdXsdXqTK/rLX14DtrrClz3IzMDc8plTQw7CBpYDis0DOXh0L0BLxrUssd4JpB5/6X2bWLD7VQS28JJLO7HvdAzY=
X-Received: by 2002:a05:6402:298b:b0:47f:7465:6e76 with SMTP id
 eq11-20020a056402298b00b0047f74656e76mr6415964edb.181.1673355362697; Tue, 10
 Jan 2023 04:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20230110124256.1663859-1-gregkh@linuxfoundation.org> <20230110124256.1663859-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230110124256.1663859-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:55:51 +0100
Message-ID: <CAJZ5v0gmG98awEVCU_TDK1kkuM6z6DQfRtGZGuKfj3oWpomgEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: bus: move bus notifier logic into bus.c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 1:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The logic to touch the bus notifier was open-coded in numberous places
> in the driver core.  Clean that up by creating a local bus_notify()
> function and have everyone call this function instead, making the
> reading of the caller code simpler and easier to maintain over time.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/base.h |  1 +
>  drivers/base/bus.c  |  8 ++++++++
>  drivers/base/core.c | 13 +++----------
>  drivers/base/dd.c   | 28 +++++++---------------------
>  4 files changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7d4803c03d3e..2e08258ce82e 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -130,6 +130,7 @@ struct kobject *virtual_device_parent(struct device *dev);
>  extern int bus_add_device(struct device *dev);
>  extern void bus_probe_device(struct device *dev);
>  extern void bus_remove_device(struct device *dev);
> +void bus_notify(struct device *dev, enum bus_notifier_event value);
>
>  extern int bus_add_driver(struct device_driver *drv);
>  extern void bus_remove_driver(struct device_driver *drv);
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 428c26c6b615..cf1b8f00b4c0 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -850,6 +850,14 @@ int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(bus_unregister_notifier);
>
> +void bus_notify(struct device *dev, enum bus_notifier_event value)
> +{
> +       struct bus_type *bus = dev->bus;
> +
> +       if (bus)
> +               blocking_notifier_call_chain(&bus->p->bus_notifier, value, dev);

I'm not sure if the local var is really helpful.  Personally, I
wouldn't use it, but anyway

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> +}
> +
>  struct kset *bus_get_kset(struct bus_type *bus)
>  {
>         return &bus->p->subsys;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a3e14143ec0c..af6a2761b31d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3453,10 +3453,7 @@ int device_add(struct device *dev)
>         /* Notify clients of device addition.  This call must come
>          * after dpm_sysfs_add() and before kobject_uevent().
>          */
> -       if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_ADD_DEVICE, dev);
> -
> +       bus_notify(dev, BUS_NOTIFY_ADD_DEVICE);
>         kobject_uevent(&dev->kobj, KOBJ_ADD);
>
>         /*
> @@ -3636,9 +3633,7 @@ void device_del(struct device *dev)
>          * before dpm_sysfs_remove().
>          */
>         noio_flag = memalloc_noio_save();
> -       if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_DEL_DEVICE, dev);
> +       bus_notify(dev, BUS_NOTIFY_DEL_DEVICE);
>
>         dpm_sysfs_remove(dev);
>         if (parent)
> @@ -3669,9 +3664,7 @@ void device_del(struct device *dev)
>         device_platform_notify_remove(dev);
>         device_links_purge(dev);
>
> -       if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_REMOVED_DEVICE, dev);
> +       bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
>         kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>         glue_dir = get_glue_dir(dev);
>         kobject_del(&dev->kobj);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e9b2f9c25efe..a519eaf1990c 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -413,10 +413,7 @@ static void driver_bound(struct device *dev)
>         driver_deferred_probe_del(dev);
>         driver_deferred_probe_trigger();
>
> -       if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_BOUND_DRIVER, dev);
> -
> +       bus_notify(dev, BUS_NOTIFY_BOUND_DRIVER);
>         kobject_uevent(&dev->kobj, KOBJ_BIND);
>  }
>
> @@ -435,9 +432,7 @@ static int driver_sysfs_add(struct device *dev)
>  {
>         int ret;
>
> -       if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_BIND_DRIVER, dev);
> +       bus_notify(dev, BUS_NOTIFY_BIND_DRIVER);
>
>         ret = sysfs_create_link(&dev->driver->p->kobj, &dev->kobj,
>                                 kobject_name(&dev->kobj));
> @@ -502,9 +497,8 @@ int device_bind_driver(struct device *dev)
>                 device_links_force_bind(dev);
>                 driver_bound(dev);
>         }
> -       else if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> +       else
> +               bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(device_bind_driver);
> @@ -695,9 +689,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  probe_failed:
>         driver_sysfs_remove(dev);
>  sysfs_failed:
> -       if (dev->bus)
> -               blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                            BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> +       bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
>         if (dev->bus && dev->bus->dma_cleanup)
>                 dev->bus->dma_cleanup(dev);
>  pinctrl_bind_failed:
> @@ -1243,10 +1235,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>
>                 driver_sysfs_remove(dev);
>
> -               if (dev->bus)
> -                       blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                                    BUS_NOTIFY_UNBIND_DRIVER,
> -                                                    dev);
> +               bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
>
>                 pm_runtime_put_sync(dev);
>
> @@ -1260,11 +1249,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>
>                 klist_remove(&dev->p->knode_driver);
>                 device_pm_check_callbacks(dev);
> -               if (dev->bus)
> -                       blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -                                                    BUS_NOTIFY_UNBOUND_DRIVER,
> -                                                    dev);
>
> +               bus_notify(dev, BUS_NOTIFY_UNBOUND_DRIVER);
>                 kobject_uevent(&dev->kobj, KOBJ_UNBIND);
>         }
>  }
> --
> 2.39.0
>
