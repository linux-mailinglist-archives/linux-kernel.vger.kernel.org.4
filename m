Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5B62E67B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiKQVKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiKQVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:10:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EAC6150A;
        Thu, 17 Nov 2022 13:10:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F31562244;
        Thu, 17 Nov 2022 21:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBA0C433C1;
        Thu, 17 Nov 2022 21:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668719444;
        bh=ulKbmepQK2sAIKuchll7WMs+rDidt3FKe8fmmwtt6s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8+kfEk3B3ssl4EvyEo1GW3Z2mOYWxTH55YHPOQKlqmYDMxH/nGwWKJEAiG2XfXjg
         OkPXL+bmeW+UBvXubzHmfuISoZPKNycGxUWPfA9UWeXaMgp6Fp912yy02rJMUWRVXZ
         ZxwSH7XqcSYfDZpmraTGVz2hhBFeSSpFP5zfWQpM=
Date:   Thu, 17 Nov 2022 22:10:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     delisun <delisun@pateo.com.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: pl011: Do not clear RX FIFO & RX interrupt in
 unthrottle.
Message-ID: <Y3ajR/S/wcQMvXQ2@kroah.com>
References: <20221109105822.332011-1-delisun@pateo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109105822.332011-1-delisun@pateo.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 06:58:22PM +0800, delisun wrote:
> Clearing the RX FIFO will cause data loss.
> Copy the pl011_enabl_interrupts implementation, and remove the clear
> interrupt and FIFO part of the code.
> 
> Signed-off-by: delisun <delisun@pateo.com.cn>
> ---
>  drivers/tty/serial/amba-pl011.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5cdced39eafd..08034e5dcec0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1828,8 +1828,17 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
>  static void pl011_unthrottle_rx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
> +	unsigned long flags;
>  
> -	pl011_enable_interrupts(uap);
> +	spin_lock_irqsave(&uap->port.lock, flags);
> +
> +	uap->im = UART011_RTIM;
> +	if (!pl011_dma_rx_running(uap))
> +		uap->im |= UART011_RXIM;
> +
> +	pl011_write(uap->im, uap, REG_IMSC);
> +
> +	spin_unlock_irqrestore(&uap->port.lock, flags);
>  }
>  
>  static int pl011_startup(struct uart_port *port)
> -- 
> 2.25.1
> 
> 
> 

How was this tested?

What commit id does this fix?

And your email is showing up as unvalidated, please fix your email
infrastructure to properly verify messages.

thanks,

greg k-h
