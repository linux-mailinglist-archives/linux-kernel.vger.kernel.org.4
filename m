Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DC66580D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjAKJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAKJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:47:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4621AE6C;
        Wed, 11 Jan 2023 01:46:27 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5EFB6602D92;
        Wed, 11 Jan 2023 09:46:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673430386;
        bh=ZJwlsBY464BplGHr72r5hWWc6BG/4HDq2NZ3M0JCMaA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=IAui+3e0mTVabAj1AMfgOOBhqwNvOsQsae3YSUIgGpMWejhgZTaRIkjfgRa5cS9ok
         La2f8A4zz4Dl2pCXDrwu+A0kxoOFEGH4vN0SVJIv576bedSN3RWmjUrJibsWfT6kH0
         miVr9PBmn/cy8MRr6i+osK7uJ04z0JQNaDZ/PtK+5PLYD+Q0w90MVc/U1lDPfA1W32
         UW3MGlvFNn2wslFMLhet2vMdXISdzzp2j4ClE5LWAx56COH6NcxQ0pxl7v5jTG5+I2
         SnEAu22bsFNiRb0yQIG5aGDAhpmd5+22rUQyGDb3S4zsvIMnJ+LPdken9GSepfGkBK
         d0eMVZrV17dLg==
Message-ID: <4e98a5ee-96a1-eb98-8529-68f36c3cb7fa@collabora.com>
Date:   Wed, 11 Jan 2023 10:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] USB: gadget: Add ID numbers to configfs-gadget driver
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
        Rondreis <linhaoguo86@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>
References: <20230111065105.29205-1-chanh@os.amperecomputing.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230111065105.29205-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

W dniu 11.01.2023 o 07:51, Chanh Nguyen pisze:
> It is unable to use configfs to attach more than one gadget. When
> attaching the second gadget, it always fails and the kernel message
> prints out:
> 
> Error: Driver 'configfs-gadget' is already registered, aborting...
> UDC core: g1: driver registration failed: -16
> 
> This commit fixes the problem by using the gadget name as a suffix
> to each configfs_gadget's driver name, thus making the names
> distinct.
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> 
> ---
> Changes in v3:
>    - Use the gadget name as a unique suffix instead     [Andrzej]
>    - Remove the driver.name allocation by template        [Chanh]
>    - Update commit message                                [Chanh]
> 
> Changes in v2:
>    - Replace scnprintf() by kasprintf() to simplify the code [CJ]
>    - Move the clean up code from gadgets_drop() to
>      gadget_info_attr_release()                        [Frank Li]
>    - Correct the resource free up in gadges_make()   [Alan Stern]
>    - Remove the unnecessary variable in gadgets_make()    [Chanh]
>    - Fixes minor grammar issue in commit message          [Chanh]
> ---
>   drivers/usb/gadget/configfs.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 96121d1c8df4..0853536cbf2e 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -393,6 +393,7 @@ static void gadget_info_attr_release(struct config_item *item)
>   	WARN_ON(!list_empty(&gi->string_list));
>   	WARN_ON(!list_empty(&gi->available_func));
>   	kfree(gi->composite.gadget_driver.function);
> +	kfree(gi->composite.gadget_driver.driver.name);
>   	kfree(gi);
>   }
>   
> @@ -1572,7 +1573,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
>   	.max_speed	= USB_SPEED_SUPER_PLUS,
>   	.driver = {
>   		.owner          = THIS_MODULE,
> -		.name		= "configfs-gadget",
>   	},
>   	.match_existing_only = 1,
>   };
> @@ -1623,13 +1623,21 @@ static struct config_group *gadgets_make(
>   
>   	gi->composite.gadget_driver = configfs_driver_template;
>   
> +	gi->composite.gadget_driver.driver.name = kasprintf(GFP_KERNEL,
> +							    "configfs-gadget.%s", name);

This line is 88 chars long, which means you're taking advantage of checkpatch
allowing 100 columns nowadays. That's absolutely fine. If you collapse the above
two lines into one, the combined length is exactly 100 chars, so you might
just as well use a single line. In any case (collapsed or not) you can add my

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> +	if (!gi->composite.gadget_driver.driver.name)
> +		goto err;
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
>   err:
>   	kfree(gi);
>   	return ERR_PTR(-ENOMEM);

