Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEF7032C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbjEOQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbjEOQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2B2D58;
        Mon, 15 May 2023 09:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1795762733;
        Mon, 15 May 2023 16:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B042C433EF;
        Mon, 15 May 2023 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684167605;
        bh=nBf8uSvL9LXLbznmFYahzkzw9v0anK6Riy2/JiUwy2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2RS9eiuZzSrjBM9jF1GSnFBo9GDfN7gzwpXoYG9CLz2zSUYtPAckYZ2Ez9BxYOZn
         3kfvRK9ZkyM85jwg6IvWZwMUSIVGWEA37x7/XYnCLTGCIBPodWePQ3Sd+J1dcw6BAb
         hpLEBJhDsQJfw8GJ8zFYTu1HDoR/DMocotKU7i/4=
Date:   Mon, 15 May 2023 18:20:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Revert "sc16is7xx: Separate GPIOs from modem control
 lines"
Message-ID: <2023051551-quickstep-outshine-5526@gregkh>
References: <20230515160206.2801991-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515160206.2801991-1-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:02:07PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.
> 
> Because of this commit, it is no longer possible to use the 16 GPIO
> lines as dedicated GPIOs on the SC16IS752.
> 
> Reverting it makes it work again.
> 
> The log message of the original commit states:
>     "Export only the GPIOs that are not shared with hardware modem
>     control lines"
> 
> But there is no explanation as to why this decision was taken to
> permanently set the function of the GPIO lines as modem control
> lines. AFAIK, there is no problem with using these lines as GPIO or modem
> control lines.
> 
> Maybe after reverting this commit, we could define a new
> device-tree property named, for example,
> "use-modem-control-lines", so that both options can be supported.
> 
> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
> lines")

Please do not line-wrap these lines.

> 

Nor is a blank line needed here.

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 5bd98e4316f5..25f1b2f6ec51 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
>  	char	name[10];
>  	int	nr_gpio;
>  	int	nr_uart;
> -	int	has_mctrl;
>  };
>  
>  #define SC16IS7XX_RECONF_MD		(1 << 0)
> @@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc16is74x_devtype = {
>  	.name		= "SC16IS74X",
>  	.nr_gpio	= 0,
>  	.nr_uart	= 1,
> -	.has_mctrl	= 0,
>  };
>  
>  static const struct sc16is7xx_devtype sc16is750_devtype = {
>  	.name		= "SC16IS750",
> -	.nr_gpio	= 4,
> +	.nr_gpio	= 8,

I think this one line change is all you really need here, right?  the
otner changes do nothing in this patch, so you should just create a new
one changing this value.  Oh, and this one:

>  	.nr_uart	= 1,
> -	.has_mctrl	= 1,
>  };
>  
>  static const struct sc16is7xx_devtype sc16is752_devtype = {
>  	.name		= "SC16IS752",
> -	.nr_gpio	= 0,
> +	.nr_gpio	= 8,

right?

Don't mess with the has_mctrl stuff, that's not relevant here.

thanks,

greg k-h
