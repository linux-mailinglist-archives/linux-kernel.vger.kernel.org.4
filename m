Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C817103F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbjEYEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEYEN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:13:58 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8D1BD5;
        Wed, 24 May 2023 21:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R7BsKuXRvafTncknbatCeztkH8x+NR2fV4WpB9u/hV0=; b=G4JmrcqkeToYptfFrlwtEYjzCO
        uqvltTFMWAeFa/yeNW2Wn/HlEPed/PTrM+6sORdVE2mPkJcOFy50QBVdnj6KKYqxTsijCY2LsoTT3
        AxMQsXwxgRt1xv+HbDDq7su9RqX3jfKgbpMlfyJpo0VL57re1E1q7pUg0lXNY9+Lxgc0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57286 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22I0-0001nr-Nw; Thu, 25 May 2023 00:09:25 -0400
Date:   Thu, 25 May 2023 00:09:24 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230525000924.7946d5df5c163451cd8860f5@hugovil.com>
In-Reply-To: <20230517194406.4125912-1-hugo@hugovil.com>
References: <20230517194406.4125912-1-hugo@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [RFC PATCH] serial: sc16is7xx: fix broken port 0 uart init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 15:44:07 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> While experimenting with rs485 configuration on a SC16IS752 dual UART,
> I found that the sc16is7xx_config_rs485() function was called only for
> the second port (index 1, channel B), causing initialization problems
> for the first port.
> 
> For the sc16is7xx driver, port->membase and port->mapbase are not set,
> and their default values are 0. And we set port->iobase to the device
> index. This means that when the first device is registered using the
> uart_add_one_port() function, the following values will be in the port
> structure:
>     port->membase = 0
>     port->mapbase = 0
>     port->iobase  = 0
> 
> Therefore, the function uart_configure_port() in serial_core.c will
> exit early because of the following check:
> 	/*
> 	 * If there isn't a port here, don't do anything further.
> 	 */
> 	if (!port->iobase && !port->mapbase && !port->membase)
> 		return;
> 
> Typically, I2C and SPI drivers do not set port->membase and
> port->mapbase. But I found that the max310x driver sets
> port->membase to ~0 (all ones). By implementing the same change in our
> driver, uart_configure_port() is now correctly executed.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> 
> I am not sure if this change is the best long-term solution to this
> problem, and maybe uart_configure_port() itself could be modified to
> take into account the fact that some devices have all three *base
> values set to zero?
> 
> Also, many drivers use port->iobase as an index, is it the correct way
> to use it?
> 
> For example, for our driver, there was
> commit 5da6b1c079e6 ("sc16is7xx: Set iobase to device index") with the
> following explanation:
>     "Set the .iobase value to the relative index within the device to allow
>     infering the order through sysfs."
> 
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 1a3143331c1f..3e0e63498052 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1432,6 +1432,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
>  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
>  		s->p[i].port.iobase	= i;
> +		s->p[i].port.membase	= (void __iomem *)~0;
>  		s->p[i].port.iotype	= UPIO_PORT;
>  		s->p[i].port.uartclk	= freq;
>  		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
> -- 
> 2.30.2

This patch is now integrated in the following series:
https://lkml.org/lkml/2023/5/25/7
 
