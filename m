Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9C66E017
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAQONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjAQONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:13:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C23BD86;
        Tue, 17 Jan 2023 06:13:09 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FB436602D6D;
        Tue, 17 Jan 2023 14:13:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673964787;
        bh=oFAvNTJOfGp0hIujd0mtIWD6lM3Y8O++iEYEPxPMVoU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oa0JxU/LvrQSWt8rhVcuNQ9TCECIEaVKmYuByj48oUDxvdHrPZESypm8Cyv5iB3W2
         aVEVsk/gP8OGsxfuC9YjEdkd9zs+COOEnp3ObheQvDX0/Vai5z0Ap6ZjKnip6wWito
         tOAPBoNNalF4DG+ffjm+BoCc2NHV/IP0/ew7Udi0BfrPM6BitqozG7fpgmOPGz8TGu
         RemW6YzI0nLb5R3KYvUkURte1qtJ8L9OEyonIr/u+YjQiEXD1PJEHDq2cnW6770teJ
         FpB+5oUAetY+isyGVu7dQrj4F0waN3IpzC7h/Si+g/V1YuQp5jFctulmW78XY5LNaX
         2D84S3RogT+tw==
Message-ID: <4553efe5-6c8a-4421-b125-ffa97d51b88e@collabora.com>
Date:   Tue, 17 Jan 2023 15:13:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 2/2] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230116155545.101391-1-jonathanh@nvidia.com>
 <20230116155545.101391-2-jonathanh@nvidia.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230116155545.101391-2-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

W dniu 16.01.2023 o 16:55, Jon Hunter pisze:
> The function gether_setup_name_default() is called by various USB
> ethernet gadget drivers. This function always generates the MAC address
> for the ethernet gadget device and always prints a warning when
> generating the MAC address. Given that these messages are expected, make
> these debug prints instead of warnings.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
> V1 -> V2: Changed print to debug instead of info.
> 
>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index be8e7b448933..8feb40e38137 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
>   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>   
>   	eth_random_addr(dev->dev_mac);
> -	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
> +	pr_debug("using random self ethernet address %pM\n", dev->dev_mac);
>   
>   	/* by default we always have a random MAC address */
>   	net->addr_assign_type = NET_ADDR_RANDOM;
>   
>   	eth_random_addr(dev->host_mac);
> -	pr_warn("using random host ethernet address %pM\n", dev->host_mac);
> +	pr_debug("using random host ethernet address %pM\n", dev->host_mac);
>   
>   	net->netdev_ops = &eth_netdev_ops;
>   

