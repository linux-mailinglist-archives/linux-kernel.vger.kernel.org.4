Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA160CCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiJYNDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiJYNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA7AD990
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 528B66191A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C03C433C1;
        Tue, 25 Oct 2022 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666702845;
        bh=KhfkP0xR84/dzf2NvhTWcPkuAMJo1cX8z0qcwE+FPKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CInZzUJizUhh6Avxm6bdTnRT1902/4MgQKPtPaQkFEVAWQgKlhJ7CX16KSQZEWd/c
         716wL/jn2mlnjrg2Wqoc0x4JOn3C7vV7tl5ia/8bqJI9Y2OlNe55JwwH+PeRiPNLUD
         4xmadpbs9RprOppjDcrg0Zrju9h200jUDUQ9vPAU=
Date:   Tue, 25 Oct 2022 15:00:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v9 1/3] uacce: supports device isolation feature
Message-ID: <Y1fd+1CrlCBYCoz0@kroah.com>
References: <20221025123931.42161-1-yekai13@huawei.com>
 <20221025123931.42161-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025123931.42161-2-yekai13@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:39:29PM +0000, Kai Ye wrote:
> UACCE adds the hardware error isolation API. Users can configure
> the isolation frequency by this sysfs node. UACCE reports the device
> isolate state to the user space. If the AER error frequency exceeds
> the set value in one hour, the device will be isolated.
> 

You are trying to "reach across" to different types of devices here,
why?  That feels backwards.  Why isn't the device that needs to use this
api just create a child class device of this type?



> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/misc/uacce/uacce.c | 145 +++++++++++++++++++++++++++++++++++++
>  include/linux/uacce.h      |  43 ++++++++++-
>  2 files changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index b70a013139c7..f293fcdcf44f 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -7,10 +7,100 @@
>  #include <linux/slab.h>
>  #include <linux/uacce.h>
>  
> +#define MAX_ERR_ISOLATE_COUNT	65535
> +
>  static struct class *uacce_class;
>  static dev_t uacce_devt;
>  static DEFINE_XARRAY_ALLOC(uacce_xa);
>  
> +static int cdev_get(struct device *dev, void *data)

That's a very odd function, considering it does not "get" anything.

And it does not work on cdev structures.

> +{
> +	struct uacce_device *uacce;
> +	struct device **t_dev = data;

Why are you having to cast this?  Why not make it a real pointer?

> +
> +	uacce = container_of(dev, struct uacce_device, dev);
> +	if (uacce->parent == *t_dev) {
> +		*t_dev = dev;
> +		return 1;

bool?

And what happened to the reference count here?

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * dev_to_uacce - Get structure uacce device from its parent device
> + * @dev the device
> + */
> +struct uacce_device *dev_to_uacce(struct device *dev)
> +{
> +	struct device **tdev = &dev;
> +	int ret;
> +
> +	ret = class_for_each_device(uacce_class, NULL, tdev, cdev_get);

Ah, you use it here.

No, sorry, you can not just walk all devices in the tree and assume this
will work.

Why do you not already know the device already?

> +	if (ret) {
> +		dev = *tdev;
> +		return container_of(dev, struct uacce_device, dev);
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dev_to_uacce);

Where is the reference counting here?

And again, horrible global function name :(

> +
> +/**
> + * uacce_hw_err_isolate - Try to set the isolation status of the uacce device
> + * according to user's configuration of isolation strategy.
> + * @uacce the uacce device
> + */
> +int uacce_hw_err_isolate(struct uacce_device *uacce)
> +{
> +	struct uacce_hw_err *err, *tmp, *hw_err;
> +	struct uacce_err_isolate *isolate_ctx;
> +	u32 count = 0;
> +
> +	if (!uacce)
> +		return -EINVAL;

How can this happen?

> +
> +	isolate_ctx = uacce->isolate_ctx;
> +
> +#define SECONDS_PER_HOUR	3600

We don't already have this in a header file?

> +
> +	/* All the hw errs are processed by PF driver */
> +	if (uacce->is_vf || isolate_ctx->is_isolate ||
> +		!isolate_ctx->hw_err_isolate_hz)
> +		return 0;
> +
> +	hw_err = kzalloc(sizeof(*hw_err), GFP_KERNEL);
> +	if (!hw_err)
> +		return -ENOMEM;
> +
> +	hw_err->timestamp = jiffies;
> +	list_for_each_entry_safe(err, tmp, &isolate_ctx->hw_errs, list) {
> +		if ((hw_err->timestamp - err->timestamp) / HZ >
> +		    SECONDS_PER_HOUR) {
> +			list_del(&err->list);
> +			kfree(err);
> +		} else {
> +			count++;
> +		}
> +	}
> +	list_add(&hw_err->list, &isolate_ctx->hw_errs);
> +
> +	if (count >= isolate_ctx->hw_err_isolate_hz)
> +		isolate_ctx->is_isolate = true;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(uacce_hw_err_isolate);
> +
> +static void uacce_hw_err_destroy(struct uacce_device *uacce)
> +{
> +	struct uacce_hw_err *err, *tmp;
> +
> +	list_for_each_entry_safe(err, tmp, &uacce->isolate_data.hw_errs, list) {
> +		list_del(&err->list);
> +		kfree(err);

No reference counting at all?

> +	}
> +}
> +
>  /*
>   * If the parent driver or the device disappears, the queue state is invalid and
>   * ops are not usable anymore.
> @@ -363,12 +453,59 @@ static ssize_t region_dus_size_show(struct device *dev,
>  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>  }
>  
> +static ssize_t isolate_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	int ret = UACCE_DEV_NORMAL;
> +
> +	if (uacce->isolate_ctx->is_isolate)
> +		ret = UACCE_DEV_ISOLATE;
> +
> +	return sysfs_emit(buf, "%d\n", ret);
> +}
> +
> +static ssize_t isolate_strategy_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	return sysfs_emit(buf, "%u\n", uacce->isolate_ctx->hw_err_isolate_hz);
> +}
> +
> +static ssize_t isolate_strategy_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	unsigned long val;
> +
> +	/* must be set by PF */
> +	if (uacce->is_vf)
> +		return -EPERM;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val > MAX_ERR_ISOLATE_COUNT)
> +		return -EINVAL;
> +
> +	uacce->isolate_ctx->hw_err_isolate_hz = val;
> +
> +	/* After the policy is updated, need to reset the hardware err list */
> +	uacce_hw_err_destroy(uacce);
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RO(api);
>  static DEVICE_ATTR_RO(flags);
>  static DEVICE_ATTR_RO(available_instances);
>  static DEVICE_ATTR_RO(algorithms);
>  static DEVICE_ATTR_RO(region_mmio_size);
>  static DEVICE_ATTR_RO(region_dus_size);
> +static DEVICE_ATTR_RO(isolate);
> +static DEVICE_ATTR_RW(isolate_strategy);

No documentation for these new sysfs files?

thanks,

greg k-h
