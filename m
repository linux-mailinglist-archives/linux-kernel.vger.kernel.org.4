Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4D6D196B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCaIIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCaIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:08:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194A1BC;
        Fri, 31 Mar 2023 01:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8667DB82CDB;
        Fri, 31 Mar 2023 08:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308B3C433D2;
        Fri, 31 Mar 2023 08:08:45 +0000 (UTC)
Message-ID: <ee171553-c8e4-1128-2a5a-db2b450f8224@xs4all.nl>
Date:   Fri, 31 Mar 2023 10:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: pvrusb2: clean up unneeded complexity in pvrusb2
 class logic
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20230329060132.2688621-1-gregkh@linuxfoundation.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230329060132.2688621-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 08:01, Greg Kroah-Hartman wrote:
> The pvrusb2 driver struct class logic was dynamically creating a class
> that should have just been static as it did not do anything special and
> was only a wrapper around a stock "struct class" implementation.  Clean
> this all up by making a static struct class and modifying the code to
> correctly reference it.
> 
> By doing so, lots of unneeded lines of code were removed, and #ifdef
> logic was cleaned up so that the .c files are not cluttered up with
> extra complexity following the proper kernel coding style.
> 
> Cc: Mike Isely <isely@pobox.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

> ---
> Note: I would like to take this through the driver-core tree as I have
> later struct class cleanups that depend on this change being made to the
> tree if that's ok with the maintainer of this file.

That's fine!

Regards,

	Hans

> 
>  drivers/media/usb/pvrusb2/pvrusb2-main.c  | 18 ++-----
>  drivers/media/usb/pvrusb2/pvrusb2-sysfs.c | 59 +++++++----------------
>  drivers/media/usb/pvrusb2/pvrusb2-sysfs.h | 16 +++---
>  3 files changed, 29 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-main.c b/drivers/media/usb/pvrusb2/pvrusb2-main.c
> index ce4d566e4e5a..721dafd2c14b 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-main.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-main.c
> @@ -16,9 +16,7 @@
>  #include "pvrusb2-context.h"
>  #include "pvrusb2-debug.h"
>  #include "pvrusb2-v4l2.h"
> -#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
>  #include "pvrusb2-sysfs.h"
> -#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
>  
>  #define DRIVER_AUTHOR "Mike Isely <isely@pobox.com>"
>  #define DRIVER_DESC "Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner"
> @@ -36,10 +34,6 @@ int pvrusb2_debug = DEFAULT_DEBUG_MASK;
>  module_param_named(debug,pvrusb2_debug,int,S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(debug, "Debug trace mask");
>  
> -#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
> -static struct pvr2_sysfs_class *class_ptr = NULL;
> -#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
> -
>  static void pvr_setup_attach(struct pvr2_context *pvr)
>  {
>  	/* Create association with v4l layer */
> @@ -48,9 +42,7 @@ static void pvr_setup_attach(struct pvr2_context *pvr)
>  	/* Create association with dvb layer */
>  	pvr2_dvb_create(pvr);
>  #endif
> -#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
> -	pvr2_sysfs_create(pvr,class_ptr);
> -#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
> +	pvr2_sysfs_create(pvr);
>  }
>  
>  static int pvr_probe(struct usb_interface *intf,
> @@ -115,9 +107,7 @@ static int __init pvr_init(void)
>  		return ret;
>  	}
>  
> -#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
> -	class_ptr = pvr2_sysfs_class_create();
> -#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
> +	pvr2_sysfs_class_create();
>  
>  	ret = usb_register(&pvr_driver);
>  
> @@ -141,9 +131,7 @@ static void __exit pvr_exit(void)
>  
>  	pvr2_context_global_done();
>  
> -#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
> -	pvr2_sysfs_class_destroy(class_ptr);
> -#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
> +	pvr2_sysfs_class_destroy();
>  
>  	pvr2_trace(PVR2_TRACE_INIT,"pvr_exit complete");
>  }
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
> index 3e42e209be37..a8c0b513e58e 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
> @@ -66,10 +66,6 @@ struct pvr2_sysfs_ctl_item {
>  	char name[80];
>  };
>  
> -struct pvr2_sysfs_class {
> -	struct class class;
> -};
> -
>  static ssize_t show_name(struct device *class_dev,
>  			 struct device_attribute *attr,
>  			 char *buf)
> @@ -487,15 +483,6 @@ static void pvr2_sysfs_tear_down_controls(struct pvr2_sysfs *sfp)
>  }
>  
>  
> -static void pvr2_sysfs_class_release(struct class *class)
> -{
> -	struct pvr2_sysfs_class *clp;
> -	clp = container_of(class,struct pvr2_sysfs_class,class);
> -	pvr2_sysfs_trace("Destroying pvr2_sysfs_class id=%p",clp);
> -	kfree(clp);
> -}
> -
> -
>  static void pvr2_sysfs_release(struct device *class_dev)
>  {
>  	pvr2_sysfs_trace("Releasing class_dev id=%p",class_dev);
> @@ -503,6 +490,12 @@ static void pvr2_sysfs_release(struct device *class_dev)
>  }
>  
>  
> +static struct class pvr2_class = {
> +	.name		= "pvrusb2",
> +	.dev_release	= pvr2_sysfs_release,
> +};
> +
> +
>  static void class_dev_destroy(struct pvr2_sysfs *sfp)
>  {
>  	struct device *dev;
> @@ -614,8 +607,7 @@ static ssize_t unit_number_show(struct device *class_dev,
>  }
>  
>  
> -static void class_dev_create(struct pvr2_sysfs *sfp,
> -			     struct pvr2_sysfs_class *class_ptr)
> +static void class_dev_create(struct pvr2_sysfs *sfp)
>  {
>  	struct usb_device *usb_dev;
>  	struct device *class_dev;
> @@ -628,7 +620,7 @@ static void class_dev_create(struct pvr2_sysfs *sfp,
>  
>  	pvr2_sysfs_trace("Creating class_dev id=%p",class_dev);
>  
> -	class_dev->class = &class_ptr->class;
> +	class_dev->class = &pvr2_class;
>  
>  	dev_set_name(class_dev, "%s",
>  		     pvr2_hdw_get_device_identifier(sfp->channel.hdw));
> @@ -753,47 +745,30 @@ static void pvr2_sysfs_internal_check(struct pvr2_channel *chp)
>  }
>  
>  
> -struct pvr2_sysfs *pvr2_sysfs_create(struct pvr2_context *mp,
> -				     struct pvr2_sysfs_class *class_ptr)
> +void pvr2_sysfs_create(struct pvr2_context *mp)
>  {
>  	struct pvr2_sysfs *sfp;
>  	sfp = kzalloc(sizeof(*sfp),GFP_KERNEL);
> -	if (!sfp) return sfp;
> +	if (!sfp)
> +		return;
>  	pvr2_trace(PVR2_TRACE_STRUCT,"Creating pvr2_sysfs id=%p",sfp);
>  	pvr2_channel_init(&sfp->channel,mp);
>  	sfp->channel.check_func = pvr2_sysfs_internal_check;
>  
> -	class_dev_create(sfp,class_ptr);
> -	return sfp;
> +	class_dev_create(sfp);
>  }
>  
>  
> -
> -struct pvr2_sysfs_class *pvr2_sysfs_class_create(void)
> +void pvr2_sysfs_class_create(void)
>  {
> -	struct pvr2_sysfs_class *clp;
> -	clp = kzalloc(sizeof(*clp),GFP_KERNEL);
> -	if (!clp) return clp;
> -	pvr2_sysfs_trace("Creating and registering pvr2_sysfs_class id=%p",
> -			 clp);
> -	clp->class.name = "pvrusb2";
> -	clp->class.class_release = pvr2_sysfs_class_release;
> -	clp->class.dev_release = pvr2_sysfs_release;
> -	if (class_register(&clp->class)) {
> -		pvr2_sysfs_trace(
> -			"Registration failed for pvr2_sysfs_class id=%p",clp);
> -		kfree(clp);
> -		clp = NULL;
> -	}
> -	return clp;
> +	if (class_register(&pvr2_class))
> +		pvr2_sysfs_trace("Registration failed for pvr2_sysfs_class");
>  }
>  
>  
> -void pvr2_sysfs_class_destroy(struct pvr2_sysfs_class *clp)
> +void pvr2_sysfs_class_destroy(void)
>  {
> -	pvr2_sysfs_trace("Unregistering pvr2_sysfs_class id=%p", clp);
> -	if (clp)
> -		class_unregister(&clp->class);
> +	class_unregister(&pvr2_class);
>  }
>  
>  
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h
> index ac580ff39b5f..375a5372e95c 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h
> @@ -10,13 +10,15 @@
>  #include <linux/sysfs.h>
>  #include "pvrusb2-context.h"
>  
> -struct pvr2_sysfs;
> -struct pvr2_sysfs_class;
> +#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
> +void pvr2_sysfs_class_create(void);
> +void pvr2_sysfs_class_destroy(void);
> +void pvr2_sysfs_create(struct pvr2_context *mp);
> +#else
> +static inline void pvr2_sysfs_class_create(void) { }
> +static inline void pvr2_sysfs_class_destroy(void) { }
> +static inline void pvr2_sysfs_create(struct pvr2_context *mp) { }
> +#endif
>  
> -struct pvr2_sysfs_class *pvr2_sysfs_class_create(void);
> -void pvr2_sysfs_class_destroy(struct pvr2_sysfs_class *);
> -
> -struct pvr2_sysfs *pvr2_sysfs_create(struct pvr2_context *,
> -				     struct pvr2_sysfs_class *);
>  
>  #endif /* __PVRUSB2_SYSFS_H */

