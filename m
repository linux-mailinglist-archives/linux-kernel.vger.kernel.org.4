Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21339671E53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjARNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjARNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:46:54 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C8F65F37
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wd8rPoxSEOy2m/HQXKKEeOnbpnN+wzZH84RSXywB5Ok=; b=kE12tB6grAfclGwnHOd+B8gs3P
        ee+o8Uvt7azWscY1yd/rzi99XHXgRxhfEZHn3R39jBOfiABbzgWc4sjLQpcO6vTXBE9qItBwbepl4
        UQxUcDsLwQLTLYQSYGcgCym4IBystWypGQa/JE3RPThemi/PaDlifX2DjigSh2g97v88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pI8JI-002RSP-El; Wed, 18 Jan 2023 14:17:00 +0100
Date:   Wed, 18 Jan 2023 14:17:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     ye.xingchen@zte.com.cn
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn
Subject: Re: [PATCH] ARM: mvebu: potential dereference of null pointer
Message-ID: <Y8fxTCLpQ8mBAHzL@lunn.ch>
References: <202301171822040406304@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301171822040406304@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:22:04PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index fd5d0c8ff695..b93b4a8a8357 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -125,7 +125,8 @@ static void __init i2c_quirk(void)
>  		struct property *new_compat;
> 
>  		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
> -
> +		if (!new_compat)
> +			return;
>  		new_compat->name = kstrdup("compatible", GFP_KERNEL);
>  		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
>  		new_compat->value = kstrdup("marvell,mv78230-a0-i2c",

Please add a blank line after the return statement.

Also, i find it interested your bot is telling you about kzalloc, but
totally ignoring kstrdup().

	Andrew
