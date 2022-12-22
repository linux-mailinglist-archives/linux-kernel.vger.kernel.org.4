Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF4654420
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiLVPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLVPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:20:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CF1AD;
        Thu, 22 Dec 2022 07:20:16 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E32616602CD4;
        Thu, 22 Dec 2022 15:20:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671722414;
        bh=0WLku65f/V6ZFbTI8eRaD22um8ER97RajgZyN2ZWo+w=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=bYpPeK+exgNtp/fIMWWDdygR1jbWZ+llFWRNMB19amjByhA3Y8ydSKLTnwVbY+Uxw
         6xs7cztJbbVOOKen5ui4FK6AIeSR8Uu3M4XxwF4C/7NQeQix16PjOR9oBjg3BqbZw1
         X8k/wU71V0+IKxaJ/xfuQCC7GUfGIonMEVRQ9U+P+e7txp+x0CXyHevGptTF/OeQmG
         DbpHYERswk2kdGi38AR4rCczLFa0G+o7al15HOrJdw1QYD583Ey/W0uNv1psVW3gS+
         +9SsYbCZZH9DJkYTrDGHWa1qHe8ERf7WKdHkh3MshmGJPYsjqWtDq8fd11scLHOIpS
         17ZwZdeagFy5w==
Message-ID: <f7067028-9662-7776-80a5-3bbe046c92e0@collabora.com>
Date:   Thu, 22 Dec 2022 16:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] USB: gadget: Add ID numbers to configfs-gadget driver
 names
To:     Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Li <frank.li@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Vacura <w36195@motorola.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        Rondreis <linhaoguo86@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>
References: <20221221091317.19380-1-chanh@os.amperecomputing.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221221091317.19380-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

W dniu 21.12.2022 o 10:13, Chanh Nguyen pisze:
> It is unable to use configfs to attach more than one gadget. When
> attaching the second gadget, it always fails and the kernel message
> prints out:
> 
> Error: Driver 'configfs-gadget' is already registered, aborting...
> UDC core: g1: driver registration failed: -16
> 

I assume you are interested in a scenario where there is more than one
UDC available which means you can have more than one active gadget?

> This commit fixes the problem by a ".N" suffix added to each
> configfs_gadget's driver name (where N is a unique ID number),
> thus making the names distinct.
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> 
> ---
> Changes in v2:
>    - Replace scnprintf() by kasprintf() to simplify the code [CJ]
>    - Move the clean up code from gadgets_drop() to
>      gadget_info_attr_release()                        [Frank Li]
>    - Correct the resource free up in gadges_make()   [Alan Stern]
>    - Remove the unnecessary variable in gadgets_make()    [Chanh]
>    - Fixes minor grammar issue in commit message          [Chanh]
> ---
>   drivers/usb/gadget/configfs.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 96121d1c8df4..7faf68bfa716 100644
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
> @@ -11,6 +12,8 @@
>   #include "u_f.h"
>   #include "u_os_desc.h"
>   
> +static DEFINE_IDA(driver_id_numbers);
> +
>   int check_user_usb_string(const char *name,
>   		struct usb_gadget_strings *stringtab_dev)
>   {
> @@ -52,6 +55,9 @@ struct gadget_info {
>   	char qw_sign[OS_STRING_QW_SIGN_LEN];
>   	spinlock_t spinlock;
>   	bool unbind;
> +
> +	/* Make driver names unique */
> +	int driver_id_number;
>   };
>   
>   static inline struct gadget_info *to_gadget_info(struct config_item *item)
> @@ -393,6 +399,8 @@ static void gadget_info_attr_release(struct config_item *item)
>   	WARN_ON(!list_empty(&gi->string_list));
>   	WARN_ON(!list_empty(&gi->available_func));
>   	kfree(gi->composite.gadget_driver.function);
> +	kfree(gi->composite.gadget_driver.driver.name);
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>   	kfree(gi);
>   }
>   
> @@ -1623,13 +1631,28 @@ static struct config_group *gadgets_make(
>   
>   	gi->composite.gadget_driver = configfs_driver_template;
>   
> +	gi->driver_id_number = ida_alloc(&driver_id_numbers, GFP_KERNEL);
> +	if (gi->driver_id_number < 0)
> +		goto err;
> +
> +	gi->composite.gadget_driver.driver.name = kasprintf(GFP_KERNEL,
> +							    "configfs-gadget.%d",
> +							    gi->driver_id_number);

I'm wondering if it maybe makes more sense to use the gadget name as a suffix
instead?

	gi->composite.gadget_driver.driver.name =
		kasprintf(GFP_KERNEL, "configfs-gadget.%s" name);

So that when you

mkdir g1

you will ultimately see /sys/bus/gadget/drivers/configfs-gadget.g1

instead of /sys/bus/gadget/drivers/configfs-gadget.0

Gadget names are guaranteed to be unique because they are created
as sibling subdirectories in configfs. Your patch would then be greatly
simplified (no need for ida).

Regards,

Andrzej

> +	if (!gi->composite.gadget_driver.driver.name)
> +		goto out_free_driver_id_number;
> +
>   	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>   	gi->composite.name = gi->composite.gadget_driver.function;
>   
>   	if (!gi->composite.gadget_driver.function)
> -		goto err;
> +		goto out_free_driver_name;
>   
>   	return &gi->group;
> +
> +out_free_driver_name:
> +	kfree(gi->composite.gadget_driver.driver.name);
> +out_free_driver_id_number:
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>   err:
>   	kfree(gi);
>   	return ERR_PTR(-ENOMEM);

