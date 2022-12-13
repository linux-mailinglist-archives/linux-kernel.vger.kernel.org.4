Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4664B05B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiLMHWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLMHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:22:31 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0618388
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:22:29 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 4zcOpfbp15FWA4zcOpIi5P; Tue, 13 Dec 2022 08:22:27 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Dec 2022 08:22:27 +0100
X-ME-IP: 86.243.100.34
Message-ID: <720b814d-5102-04d3-4938-33a25e87a46d@wanadoo.fr>
Date:   Tue, 13 Dec 2022 08:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] USB: gadget: Add ID numbers to configfs-gadget driver
 names
Content-Language: fr
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
References: <20221213041203.21080-1-chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Vacura <w36195@motorola.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221213041203.21080-1-chanh@os.amperecomputing.com>
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

Le 13/12/2022 à 05:12, Chanh Nguyen a écrit :
> It is unable to use configfs to attach more than one gadget. When
> attaching the second gadget, it always fails and the kernel message
> prints out:
> 
> Error: Driver 'configfs-gadget' is already registered, aborting...
> UDC core: g1: driver registration failed: -16
> 
> This commit fixes the problem by a ".N" suffix added to each
> configfs_gadget's driver name (where N is a unique ID number),
> thus making the names distinct.
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: Chanh Nguyen <chanh-shex6MNQR2J/SfDzf78azzKzEDxYleXD@public.gmane.org>
> ---
>   drivers/usb/gadget/configfs.c | 42 +++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 96121d1c8df4..d8c5156ad777 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -3,6 +3,7 @@
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/device.h>
> +#include <linux/idr.h>
>   #include <linux/kstrtox.h>
>   #include <linux/nls.h>
>   #include <linux/usb/composite.h>
> @@ -11,6 +12,16 @@
>   #include "u_f.h"
>   #include "u_os_desc.h"
>   
> +static DEFINE_IDA(driver_id_numbers);
> +
> +/*
> + * Driver name has the form of "configfs-gadget.%d", where %d
> + * is id allocated by ida_alloc(). The max value returns by
> + * ida_alloc() is INT_MAX, in 64-bit system, it is about nine
> + * quintillion: 19 digits in decimal. Set the max length to 35.
> + */
> +#define DRIVER_NAME_LENGTH_MAX 35

Hi,

if paranoiac, the final \0 seems to be missing in the max length 
computation, but see below.

> +
>   int check_user_usb_string(const char *name,
>   		struct usb_gadget_strings *stringtab_dev)
>   {
> @@ -52,6 +63,9 @@ struct gadget_info {
>   	char qw_sign[OS_STRING_QW_SIGN_LEN];
>   	spinlock_t spinlock;
>   	bool unbind;
> +
> +	/* Make driver names unique */
> +	int driver_id_number;
>   };
>   
>   static inline struct gadget_info *to_gadget_info(struct config_item *item)
> @@ -1582,6 +1596,8 @@ static struct config_group *gadgets_make(
>   		const char *name)
>   {
>   	struct gadget_info *gi;
> +	char *driver_name;
> +	int ret;
>   
>   	gi = kzalloc(sizeof(*gi), GFP_KERNEL);
>   	if (!gi)
> @@ -1623,6 +1639,21 @@ static struct config_group *gadgets_make(
>   
>   	gi->composite.gadget_driver = configfs_driver_template;
>   
> +	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err;
> +	gi->driver_id_number = ret;
> +
> +	driver_name = kmalloc(DRIVER_NAME_LENGTH_MAX, GFP_KERNEL);
> +	if (!driver_name)
> +		goto out_free_driver_id_number;
> +
> +	ret = scnprintf(driver_name, DRIVER_NAME_LENGTH_MAX,
> +			"configfs-gadget.%d", gi->driver_id_number);


using kasprintf() looks simpler here.
No need to kmalloc()+scnprintf(), and no need for DRIVER_NAME_LENGTH_MAX.

Just my 2c,

CJ

> +	if (ret < 0)
> +		goto out_free_driver_name;
> +
> +	gi->composite.gadget_driver.driver.name = driver_name;
>   	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>   	gi->composite.name = gi->composite.gadget_driver.function;
>   
> @@ -1630,6 +1661,11 @@ static struct config_group *gadgets_make(
>   		goto err;
>   
>   	return &gi->group;
> +
> +out_free_driver_name:
> +	kfree(driver_name);
> +out_free_driver_id_number:
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>   err:
>   	kfree(gi);
>   	return ERR_PTR(-ENOMEM);
> @@ -1637,6 +1673,12 @@ static struct config_group *gadgets_make(
>   
>   static void gadgets_drop(struct config_group *group, struct config_item *item)
>   {
> +	struct gadget_info *gi = to_gadget_info(item);
> +
> +	mutex_lock(&gi->lock);
> +	kfree(gi->composite.gadget_driver.driver.name);
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
> +	mutex_unlock(&gi->lock);
>   	config_item_put(item);
>   }
>   

