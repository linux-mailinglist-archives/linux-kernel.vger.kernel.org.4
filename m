Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B34642C48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLEPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiLEPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862013D2D;
        Mon,  5 Dec 2022 07:51:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1571F611CE;
        Mon,  5 Dec 2022 15:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D66C433D6;
        Mon,  5 Dec 2022 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670255516;
        bh=TIJkd0rSmX9iC+wm2mA4Xqjkc0qvKfNqYIpazcM5Ey4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4bele/izSbc1ZYMongxZ5qZCbaFseFMUiuoEXvFaMs04IEejlP9ZfaqPihgi24b3
         JtSPuri1ZDJJ5fdL/VgSJIDnXRL6VFoStavalWcIDGmhgDvPye09p0vm/cVPmUW4bQ
         t53c+l2HVDEfk7uU/waz7Hb9lCnVbleltXnsVDtU=
Date:   Mon, 5 Dec 2022 16:51:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 3/5] Implement modalias sysfs attribute for modules
Message-ID: <Y44TmanpxDjrwax9@kroah.com>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
 <20221202224744.1447448-3-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202224744.1447448-3-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:47:42PM -0600, Allen Webb wrote:
> When the modalias attribute is read, invoke a subsystem-specific
> callback for each driver registered by the specific module.
> 
> The intent of the new modalias attribute is to expose the
> match-id-based modaliases to userspace for builtin and loaded kernel
> modules.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  include/linux/device/bus.h |  7 +++++
>  kernel/module/sysfs.c      | 57 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 82a5583437099..cce0bedec63d9 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -61,6 +61,10 @@ struct fwnode_handle;
>   *			this bus.
>   * @dma_cleanup:	Called to cleanup DMA configuration on a device on
>   *			this bus.
> + * @drv_to_modalias:    Called to convert the matching IDs in a
> + *                      struct device_driver to their corresponding modaliases.
> + *                      Note that the struct device_driver is expected to belong
> + *                      to this bus.

If the driver was not part of this bus, that just wouldn't work at all
so I don't think you need to say this.

And what is the format here?  New lines?  structures?


>   * @pm:		Power management operations of this bus, callback the specific
>   *		device driver's pm-ops.
>   * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
> @@ -107,6 +111,9 @@ struct bus_type {
>  	int (*dma_configure)(struct device *dev);
>  	void (*dma_cleanup)(struct device *dev);
>  
> +	ssize_t (*drv_to_modalias)(struct device_driver *drv, char *buf,
> +				   size_t count);
> +
>  	const struct dev_pm_ops *pm;
>  
>  	const struct iommu_ops *iommu_ops;
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index 8dafec7455fbe..651c677c4ab96 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2008 Rusty Russell
>   */
>  
> +#include <linux/device/bus.h>
> +#include <linux/device/driver.h>

That feels wrong, modules shouldn't care about busses or drivers.

Why can't this all be in the driver core instead?

>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/fs.h>
> @@ -240,11 +242,64 @@ static inline void add_notes_attrs(struct module *mod, const struct load_info *i
>  static inline void remove_notes_attrs(struct module *mod) { }
>  #endif /* CONFIG_KALLSYMS */
>  
> +/* Track of the buffer and module identity in callbacks when walking the list of
> + * drivers for each bus.
> + */
> +struct modalias_bus_print_state {
> +	struct module_kobject *mk;
> +	char *buf;
> +	size_t count;
> +	ssize_t len;
> +};
> +
> +static int print_modalias_for_drv(struct device_driver *drv, void *p)
> +{
> +	struct modalias_bus_print_state *s = p;
> +	struct module_kobject *mk = s->mk;
> +	ssize_t len;
> +	/* Skip drivers that do not match this module. */

Always use checkpatch.pl on your changes before sening them out :(

> +	if (mk->mod) {
> +		if (mk->mod != drv->owner)
> +			return 0;
> +	} else if (!mk->kobj.name || !drv->mod_name ||
> +		   strcmp(mk->kobj.name, drv->mod_name))
> +		return 0;
> +
> +	if (drv->bus && drv->bus->drv_to_modalias) {
> +		len = drv->bus->drv_to_modalias(drv, s->buf + s->len,
> +						s->count - s->len);
> +		if (len < 0)
> +			return len;
> +		s->len += len;
> +	}
> +	return 0;
> +}
> +
> +static int print_modalias_for_bus(struct bus_type *type, void *p)
> +{
> +	return bus_for_each_drv(type, NULL, p, print_modalias_for_drv);
> +}
> +
>  static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
>  				    struct bin_attribute *bin_attr,
>  				    char *buf, loff_t pos, size_t count)
>  {
> -	return 0;
> +	struct module_kobject *mk = container_of(kobj, struct module_kobject,
> +						 kobj);
> +	struct modalias_bus_print_state state = {mk, buf, count, 0};

You allocate this on the stack?

> +	int error = 0;

No need to initialize this.

> +
> +	if (pos != 0)
> +		return -EINVAL;

Why?

> +
> +	error = bus_for_each(&state, print_modalias_for_bus);

So for every module attribute, we walk all busses in the system?  Why
not the bus that this module has a driver for instead?

thanks,

greg k-h
