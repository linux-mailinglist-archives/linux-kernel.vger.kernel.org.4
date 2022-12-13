Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A334764BF44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiLMWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiLMWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:20:44 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA31FFA7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:20:40 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 5DdapWVMLCoWh5Ddbpqpmv; Tue, 13 Dec 2022 23:20:38 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Dec 2022 23:20:38 +0100
X-ME-IP: 86.243.100.34
Message-ID: <67878b69-89af-6a0c-24c6-ff111dae6ce6@wanadoo.fr>
Date:   Tue, 13 Dec 2022 23:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for each
 configfs driver
To:     Frank Li <Frank.Li@nxp.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linhaoguo86@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        Chanh Nguyen <chanh@os.amperecomputing.com>
References: <20221213220354.628013-1-Frank.Li@nxp.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221213220354.628013-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/12/2022 à 23:03, Frank Li a écrit :
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

Hi,

Also, out of curiosity, any link with this patch:
 
https://lore.kernel.org/all/20221213041203.21080-1-chanh@os.amperecomputing.com/
?

Not exactly the same, but not very different.

(adding Chanh Nguyen in cc)

CJ

> 
>   drivers/usb/gadget/configfs.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 3a6b4926193e..785be6aea720 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -4,12 +4,17 @@
>   #include <linux/slab.h>
>   #include <linux/device.h>
>   #include <linux/nls.h>
> +#include <linux/idr.h>
>   #include <linux/usb/composite.h>
>   #include <linux/usb/gadget_configfs.h>
>   #include "configfs.h"
>   #include "u_f.h"
>   #include "u_os_desc.h"
>   
> +#define DRIVER_NAME "configfs-gadget"
> +
> +static DEFINE_IDA(driver_id_numbers);
> +
>   int check_user_usb_string(const char *name,
>   		struct usb_gadget_strings *stringtab_dev)
>   {
> @@ -46,6 +51,7 @@ struct gadget_info {
>   
>   	struct usb_composite_driver composite;
>   	struct usb_composite_dev cdev;
> +	int driver_id_number;
>   	bool use_os_desc;
>   	char b_vendor_code;
>   	char qw_sign[OS_STRING_QW_SIGN_LEN];
> @@ -392,6 +398,8 @@ static void gadget_info_attr_release(struct config_item *item)
>   	WARN_ON(!list_empty(&gi->string_list));
>   	WARN_ON(!list_empty(&gi->available_func));
>   	kfree(gi->composite.gadget_driver.function);
> +	kfree(gi->composite.gadget_driver.driver.name);
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>   	kfree(gi);
>   }
>   
> @@ -1571,7 +1579,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
>   	.max_speed	= USB_SPEED_SUPER_PLUS,
>   	.driver = {
>   		.owner          = THIS_MODULE,
> -		.name		= "configfs-gadget",
>   	},
>   	.match_existing_only = 1,
>   };
> @@ -1581,6 +1588,7 @@ static struct config_group *gadgets_make(
>   		const char *name)
>   {
>   	struct gadget_info *gi;
> +	int ret = 0;
>   
>   	gi = kzalloc(sizeof(*gi), GFP_KERNEL);
>   	if (!gi)
> @@ -1622,16 +1630,30 @@ static struct config_group *gadgets_make(
>   
>   	gi->composite.gadget_driver = configfs_driver_template;
>   
> +	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err;
> +	gi->driver_id_number = ret;
> +
> +	gi->composite.gadget_driver.driver.name =
> +		kasprintf(GFP_KERNEL, DRIVER_NAME ".%d", gi->driver_id_number);
> +
>   	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>   	gi->composite.name = gi->composite.gadget_driver.function;
>   
> -	if (!gi->composite.gadget_driver.function)
> -		goto err;
> +	if (!gi->composite.gadget_driver.function) {
> +		ret = -ENOMEM;
> +		goto err_func;
> +	}
>   
>   	return &gi->group;
> +
> +err_func:
> +	kfree(gi->composite.gadget_driver.driver.name);
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>   err:
>   	kfree(gi);
> -	return ERR_PTR(-ENOMEM);
> +	return ERR_PTR(ret);
>   }
>   
>   static void gadgets_drop(struct config_group *group, struct config_item *item)

