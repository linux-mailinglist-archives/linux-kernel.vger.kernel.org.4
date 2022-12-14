Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488F664C17E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiLNAt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiLNAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:49:19 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 727F5DF50
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:49:18 -0800 (PST)
Received: (qmail 908379 invoked by uid 1000); 13 Dec 2022 19:49:17 -0500
Date:   Tue, 13 Dec 2022 19:49:17 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linhaoguo86@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for each
 configfs driver
Message-ID: <Y5kdjffhU2ply//V@rowland.harvard.edu>
References: <20221213220354.628013-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213220354.628013-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:03:54PM -0500, Frank Li wrote:
> From: Rondreis <linhaoguo86@gmail.com>
> 
> When use configfs to attach more than one gadget.
> 
> Error: Driver 'configfs-gadget' is already registered, aborting...
> 
> 	UDC core: g1: driver registration failed: -16
> 
> The problem is that when creating multiple gadgets with configfs and
> binding them to different UDCs, the UDC drivers have the same name
> "configfs-gadget". Because of the addition of the "gadget" bus, naming
> conflicts will occur when more than one UDC drivers registered to the
> bus.
> 
> It's not an isolated case, this patch refers to the commit f2d8c2606825
> ("usb: gadget: Fix non-unique driver names in raw-gadget driver").
> Each configfs-gadget driver will be assigned a unique name
> "configfs-gadget.N", with a different value of N for each driver
> instance.
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> 
> Signed-off-by: Rondreis <linhaoguo86@gmail.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> This patch is based on https://lore.kernel.org/lkml/20220907112210.11949-1-linhaoguo86@gmail.com/
> fixed the all greg's comments.
> 
> I met the same issue.  Look likes Rodrieis have not continue to work this
> patch since Sep, 2022.
> 
> I don't know full name of Rondreis.
> 
>  drivers/usb/gadget/configfs.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 3a6b4926193e..785be6aea720 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -4,12 +4,17 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/nls.h>
> +#include <linux/idr.h>
>  #include <linux/usb/composite.h>
>  #include <linux/usb/gadget_configfs.h>
>  #include "configfs.h"
>  #include "u_f.h"
>  #include "u_os_desc.h"
>  
> +#define DRIVER_NAME "configfs-gadget"
> +
> +static DEFINE_IDA(driver_id_numbers);
> +
>  int check_user_usb_string(const char *name,
>  		struct usb_gadget_strings *stringtab_dev)
>  {
> @@ -46,6 +51,7 @@ struct gadget_info {
>  
>  	struct usb_composite_driver composite;
>  	struct usb_composite_dev cdev;
> +	int driver_id_number;
>  	bool use_os_desc;
>  	char b_vendor_code;
>  	char qw_sign[OS_STRING_QW_SIGN_LEN];
> @@ -392,6 +398,8 @@ static void gadget_info_attr_release(struct config_item *item)
>  	WARN_ON(!list_empty(&gi->string_list));
>  	WARN_ON(!list_empty(&gi->available_func));
>  	kfree(gi->composite.gadget_driver.function);
> +	kfree(gi->composite.gadget_driver.driver.name);
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>  	kfree(gi);
>  }
>  
> @@ -1571,7 +1579,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
>  	.max_speed	= USB_SPEED_SUPER_PLUS,
>  	.driver = {
>  		.owner          = THIS_MODULE,
> -		.name		= "configfs-gadget",
>  	},
>  	.match_existing_only = 1,
>  };
> @@ -1581,6 +1588,7 @@ static struct config_group *gadgets_make(
>  		const char *name)
>  {
>  	struct gadget_info *gi;
> +	int ret = 0;
>  
>  	gi = kzalloc(sizeof(*gi), GFP_KERNEL);
>  	if (!gi)
> @@ -1622,16 +1630,30 @@ static struct config_group *gadgets_make(
>  
>  	gi->composite.gadget_driver = configfs_driver_template;
>  
> +	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err;
> +	gi->driver_id_number = ret;
> +
> +	gi->composite.gadget_driver.driver.name =
> +		kasprintf(GFP_KERNEL, DRIVER_NAME ".%d", gi->driver_id_number);

Here you forgot to put:

	if (!gi->composite.gadget_driver.driver.name) {
		ret = -ENOMEM;
		goto err_func;
	}

Or if you prefer, combine this test with the one below.

Alan Stern

> +
>  	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>  	gi->composite.name = gi->composite.gadget_driver.function;
>  
> -	if (!gi->composite.gadget_driver.function)
> -		goto err;
> +	if (!gi->composite.gadget_driver.function) {
> +		ret = -ENOMEM;
> +		goto err_func;
> +	}
>  
>  	return &gi->group;
> +
> +err_func:
> +	kfree(gi->composite.gadget_driver.driver.name);
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>  err:
>  	kfree(gi);
> -	return ERR_PTR(-ENOMEM);
> +	return ERR_PTR(ret);
>  }
>  
>  static void gadgets_drop(struct config_group *group, struct config_item *item)
> -- 
> 2.34.1
> 
