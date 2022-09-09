Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAE5B31B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIIIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIIIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF03D99DE;
        Fri,  9 Sep 2022 01:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A2DB61F11;
        Fri,  9 Sep 2022 08:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF8AC433D7;
        Fri,  9 Sep 2022 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662712217;
        bh=QYV3AcvV07yDjEzSbdbsIiWRINYDtPK3crfCXheJR7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C80BlFY6oDU8kaqApH5MbPeVzf7QLXJooo/1lTNZY4XdqgxGygh5gND9mo2L9I8mz
         rOXZoX45CUeI0ZorAicDj2qROzvz0XpLTquP59YkIHZlZqyrGFRJkm/Ma+YQEQkG72
         ApKHzK7kia58rU5nJStl3zte8rsq5HKATTpFUusM=
Date:   Fri, 9 Sep 2022 10:30:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH v8 1/3] uacce: supports device isolation feature
Message-ID: <Yxr5lvnbYGk7SCy7@kroah.com>
References: <20220902031304.37516-1-yekai13@huawei.com>
 <20220902031304.37516-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902031304.37516-2-yekai13@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:13:02AM +0000, Kai Ye wrote:
> UACCE adds the hardware error isolation API. Users can configure
> the isolation frequency by this sysfs node. UACCE reports the device
> isolate state to the user space. If the AER error frequency exceeds
> the value of setting for a certain period of time, the device will be
> isolated.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/misc/uacce/uacce.c | 58 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uacce.h      | 11 ++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..41f454c89cd1 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -7,6 +7,8 @@
>  #include <linux/slab.h>
>  #include <linux/uacce.h>
>  
> +#define MAX_ERR_ISOLATE_COUNT		65535

What units is this in?  Shouldn't this be in a .h file somewhere as it
is a limit you impose on a driver implementing this API.

> +
>  static struct class *uacce_class;
>  static dev_t uacce_devt;
>  static DEFINE_MUTEX(uacce_mutex);
> @@ -339,12 +341,57 @@ static ssize_t region_dus_size_show(struct device *dev,
>  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>  }
>  
> +static ssize_t isolate_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	if (!uacce->ops->get_isolate_state)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
> +}
> +
> +static ssize_t isolate_strategy_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	u32 val;
> +
> +	val = uacce->ops->isolate_strategy_read(uacce);
> +	if (val > MAX_ERR_ISOLATE_COUNT)
> +		return -EINVAL;

How can a driver return a higher number here?

> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t isolate_strategy_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val > MAX_ERR_ISOLATE_COUNT)
> +		return -EINVAL;
> +
> +	ret = uacce->ops->isolate_strategy_write(uacce, val);
> +
> +	return ret ? ret : count;

Please write out if statements.

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
>  
>  static struct attribute *uacce_dev_attrs[] = {
>  	&dev_attr_api.attr,
> @@ -353,6 +400,8 @@ static struct attribute *uacce_dev_attrs[] = {
>  	&dev_attr_algorithms.attr,
>  	&dev_attr_region_mmio_size.attr,
>  	&dev_attr_region_dus_size.attr,
> +	&dev_attr_isolate.attr,
> +	&dev_attr_isolate_strategy.attr,
>  	NULL,
>  };
>  
> @@ -368,6 +417,15 @@ static umode_t uacce_dev_is_visible(struct kobject *kobj,
>  	    (!uacce->qf_pg_num[UACCE_QFRT_DUS])))
>  		return 0;
>  
> +	if (attr == &dev_attr_isolate_strategy.attr &&
> +	    (!uacce->ops->isolate_strategy_read ||
> +	     !uacce->ops->isolate_strategy_write))

So you need either a read or write?  Why not both?

thanks,

greg k-h
