Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5766461B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjAJQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjAJQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:31:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB681D4C;
        Tue, 10 Jan 2023 08:31:35 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFF4A6602D7B;
        Tue, 10 Jan 2023 16:31:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673368294;
        bh=gf2SVFXGu/ip2hmdsTFFak6Bv478mdC5jsczhYIQnc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iUaDRdgBA8r/cNb9FciggE1Y3/3iPFlNHrF7NrKHEtcSjhWtr4oQU46S7K7at0/Bp
         /8M5AjmVxNACscme3WknZVAZSVmSfCm7nqf95tcfEAhZiX38Uty/SU9akvcK/eKSGS
         09XYRrXl7xhCthCNcz62eo75WS0VfnAI5sbIxFLzUlG/rmvqsO4RdjeTTEDPTE28xQ
         l7IIvoR/f5FIAU7uK3p/DU44l5tRjBqpzf8v1/ZjdJoJucglA48C0OGFzRuvZAGuQc
         uMY7eGHoBFNdhzSZVBs3IFFdob+NSRbhC6XijK9sipTFA5sgIK8LAmUmIXwHGVSBR6
         BnjoskOtgypOg==
Message-ID: <87cab5a1-a122-2b10-43b4-7a5819ff55ef@collabora.com>
Date:   Tue, 10 Jan 2023 17:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230106161759.66019-1-jonathanh@nvidia.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230106161759.66019-1-jonathanh@nvidia.com>
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

Hi,

Hasn't there been a similar patch already?

W dniu 6.01.2023 o 17:17, Jon Hunter pisze:
> The function gether_setup_name_default() is called by various USB
> ethernet gadget drivers. This function always generates the MAC address
> for the ethernet gadget device and always prints a warning when
> generating the MAC address. Given that these messages are expected, make
> these prints informational instead of warnings.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 8f12f3f8f6ee..c19d66cd1446 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
>   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>   
>   	eth_random_addr(dev->dev_mac);
> -	pr_warn("using random %s ethernet address\n", "self");
> +	pr_info("using random %s ethernet address\n", "self");

As far as I can tell this function is called by all Ethernet gadgets,
and using random Ethernet addresses is the default behavior for all of them,
including legacy gadgets. Why to inform about the default situation happening?
So in fact maybe it would be better to eliminate the pr_warn() altogether,
instead of replacing it with pr_info()? If the user does not care to
explicitly set some non-default address(es), why would she care to know
that a randomly selected address has been chosen? Note that learning
_what_ specific address has been chosen is perfectly doable without
these pr_info() calls.

Regards,

Andrzej

>   
>   	/* by default we always have a random MAC address */
>   	net->addr_assign_type = NET_ADDR_RANDOM;
>   
>   	eth_random_addr(dev->host_mac);
> -	pr_warn("using random %s ethernet address\n", "host");
> +	pr_info("using random %s ethernet address\n", "host");
>   
>   	net->netdev_ops = &eth_netdev_ops;
>   

