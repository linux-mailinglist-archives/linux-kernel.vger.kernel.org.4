Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2861F696
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiKGOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKGOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:52:04 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E041BEB6;
        Mon,  7 Nov 2022 06:52:01 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 206ED84DF9;
        Mon,  7 Nov 2022 15:51:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667832717;
        bh=m9s9K4UOs/+xHYBcfQzt0H+E+MMhze9rMN8G8j2bazE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WxI9aS92Mh9Q/o2IvZq/XUdAODm/WMYka+sIQ4TdB14ulmU02SOfFL/NNg9PvrJbi
         /DAML8ekEt/s4dOMJiozMpSkSRygVDH7TFyrIspTHFz3FIaFRpwDmp/tAYnat2CiVy
         3gvAAO5kg0AC7SW3E9hsZfOOCpI+bA5zR7tJHyTLlIKGg/bjdpJsbSJEzgmZ/p9hi1
         d+D+hUJFaFgRfRQ+rO76/MdBaDCxAv/MALorV1TFe7P8xhDilbu6xmFZLIDXDBonGJ
         5R0KnBiNs85NO8v+lVVK08uLkPiiqx1DVWQkJoQ/1sV6N4gbW8uRhJ7NxbUqPiACIQ
         Ji0hsvBG8i60A==
Message-ID: <49a553b3-bd79-7845-41c4-2b8a3a3d4932@denx.de>
Date:   Mon, 7 Nov 2022 15:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] extcon: usbc-tusb320: Call the Type-C IRQ handler only if
 a port is registered
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20221107144810.588755-1-y.oudjana@protonmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221107144810.588755-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 15:48, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
> added an optional Type-C interface to the driver but missed to check
> if it is in use when calling the IRQ handler. This causes an oops on
> devices currently using the old extcon interface. Check if a Type-C
> port is registered before calling the Type-C IRQ handler.
> 
> Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/extcon/extcon-usbc-tusb320.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 41041ff0fadb..037bc11b2a48 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -327,7 +327,14 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>   		return IRQ_NONE;
>   
>   	tusb320_extcon_irq_handler(priv, reg);
> -	tusb320_typec_irq_handler(priv, reg);
> +
> +	/*
> +	 * Type-C support is optional for backward compatibility.

It's the other way around, extcon is the legacy, type-c is the new, right ?

> +	 * Only call the Type-C handler if a port had been registered
> +	 * previously.
> +	 */
> +	if (priv->port)
> +		tusb320_typec_irq_handler(priv, reg);
>   
>   	regmap_write(priv->regmap, TUSB320_REG9, reg);

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks!
