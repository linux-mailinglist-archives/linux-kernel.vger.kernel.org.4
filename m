Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B3674070
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjASSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjASSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:01:56 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90287289
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ch3G+TVl0zLt31mvi7p9Ehua4+39FF3iqi5hnpOXoh4=; b=e/K35kytzIPX47JGNKYJnUPu8X
        dIBnlvdGseBHIt9Fv6ze/kQbv6iaNjp6tBTxk0zO8QoyI9pEXfROAZ31YCGJd/bJ9pG6COUDxjskj
        HAGKUlpXJUMCR2QHmn/8xZR7fClFfuCAx/zAl6LYUuk4cf6X+l4PGaoJQLQqKDscRl4Xp+PYzJapY
        MdaANQQh5QQotDQvYOpIr5TisI+gdgqrcSUNbrUmcvICI6Sjc508eVvbzLZd7hpZYnLinD+9yfuPL
        7/U8cdtf5jzDpDeZKzzVRXahmkq99JS8IhrtixgEJiAZJ9nXBF4PAiZTxV8rtcD0cZC0Sa1JlHdI4
        b7SVEOLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36216)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pIZEW-0004pK-7c; Thu, 19 Jan 2023 18:01:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pIZEU-0000fk-Vu; Thu, 19 Jan 2023 18:01:50 +0000
Date:   Thu, 19 Jan 2023 18:01:50 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: potential dereference of null pointer
Message-ID: <Y8mFjt/K1VSt5d03@shell.armlinux.org.uk>
References: <202301191051184033370@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301191051184033370@zte.com.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:51:18AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  arch/arm/mach-mvebu/board-v7.c  | 4 ++++
>  arch/arm/mach-mvebu/coherency.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index fd5d0c8ff695..3c031b2efe16 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -125,11 +125,15 @@ static void __init i2c_quirk(void)
>  		struct property *new_compat;
> 
>  		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
> +		if (!new_compat)
> +			return;
> 
>  		new_compat->name = kstrdup("compatible", GFP_KERNEL);
>  		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
>  		new_compat->value = kstrdup("marvell,mv78230-a0-i2c",
>  						GFP_KERNEL);
> +		if (!new_compat->name || !new_compat->value)
> +			return;

... and then someone else comes along and spots that "new_compat"
gets leaked, so we get another patch to add a kfree() for new_compat.

Why not do the job properly first time around?

>  		of_update_property(np, new_compat);
>  	}
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index a6b621ff0b87..8291185c52cc 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -191,7 +191,11 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
>  		struct property *p;
> 
>  		p = kzalloc(sizeof(*p), GFP_KERNEL);
> +		if (!p)
> +			return;
>  		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
> +		if (!p->name)
> +			return;

Same problem here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
