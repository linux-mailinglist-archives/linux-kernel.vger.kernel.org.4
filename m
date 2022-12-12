Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C086499DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiLLIH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiLLIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:07:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0CF64;
        Mon, 12 Dec 2022 00:07:25 -0800 (PST)
Received: from [192.168.15.130] (unknown [194.152.46.36])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06F956602C04;
        Mon, 12 Dec 2022 08:07:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670832443;
        bh=7jZrcS12eovJk4yTr33qb2JRyO2HH5tfG3QVcOFRV8M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MblcTWhM2ljhtpIQ2hdDwhvcE80egkRIbneeI2QiqCW3LC5Rmhuz8Z96QcQtPvuS3
         6nysNSWrcRL68COfkybBYadNgQpgNNwbNz9oCJU/DKF1BaUlecFT6AHsei/UclMNEQ
         XqlcUodv7oSLBRz5rWT4CF2fQ6hX+kxH5hWN65QrV5ysk4/nJ3aNXZE6NVZXReO0fL
         lDTAC7Lk3a2qi6JxhhVl5mdd+t7LOzqJbIvtqH//6sWEhIhMbr3d76ppsnnqhaTiOl
         ZUifgC/pzyIY00oq4mt7sYNigpy4Lutq6c6dw73zFAWYV5UrEhA6SADHgsA17ir+oG
         Z2RLykZPtt/RA==
Message-ID: <91368ea6-5517-bd6c-3428-3871a9ad4d14@collabora.com>
Date:   Mon, 12 Dec 2022 09:07:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: gadget: u_ether: remove obnoxious warning messages
To:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209172853.2138941-1-alvin@pqrs.dk>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221209172853.2138941-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 9.12.2022 o 18:28, Alvin Šipraga pisze:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> There is really no need for the driver to unconditionally emit warnings
> like this on every usage:
> 
> [    6.967283] using random self ethernet address
> [    6.967294] using random host ethernet address
> 
> Since this is normal behaviour, just remove the messages altogether.
> > Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/usb/gadget/function/u_ether.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 8f12f3f8f6ee..3fdc913ef262 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -845,13 +845,11 @@ struct net_device *gether_setup_name_default(const char *netname)
>   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>   
>   	eth_random_addr(dev->dev_mac);
> -	pr_warn("using random %s ethernet address\n", "self");
>   
>   	/* by default we always have a random MAC address */
>   	net->addr_assign_type = NET_ADDR_RANDOM;
>   
>   	eth_random_addr(dev->host_mac);
> -	pr_warn("using random %s ethernet address\n", "host");
>   
>   	net->netdev_ops = &eth_netdev_ops;
>   

