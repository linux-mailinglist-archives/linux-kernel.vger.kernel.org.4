Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D66BA97D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCOHjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjCOHjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A887137F17;
        Wed, 15 Mar 2023 00:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3160CB81CCE;
        Wed, 15 Mar 2023 07:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF8C433EF;
        Wed, 15 Mar 2023 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678865874;
        bh=I4qlfV5mv2+OQ3PEUfgFdAU+FA2UpcPIsZUMmCKtaP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ee5w8MnRQk6LLqSIVMK4OU23IhD14jL1y/+REVgu3MlkDgONkk5t9tS4QaIJyDLNQ
         jM5wpONJkHdkIIqIlg2WuJ+Y1BYBDXXMV3Fmt1+PrYUWletPtUHKFdOIlg6u4LJ8Ze
         xETWFLMV5rQmb72IlpIX1wb4nTwXnakSmibv7er0=
Date:   Wed, 15 Mar 2023 08:37:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Message-ID: <ZBF1z5Bx9jnrpxox@kroah.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-15-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315072902.9298-15-ychuang570808@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:29:01AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds UART and console driver for Nuvoton ma35d1 Soc.
> 
> MA35D1 SoC provides up to 17 UART controllers, each with one uart port.
> The ma35d1 uart controller is not compatible with 8250.

A new UART being designed that is not an 8250 compatible?  Why????

Anyway, some minor comments:

>  drivers/tty/serial/ma35d1_serial.c | 842 +++++++++++++++++++++++++++++
>  drivers/tty/serial/ma35d1_serial.h |  93 ++++

Why do you have a .h file for only a single .c file?  Please just put
them both together into one .c file.

>  include/uapi/linux/serial_core.h   |   3 +

Why do you need this #define?  Are you using it in userspace now?  If
not, why have it?

> +static void
> +receive_chars(struct uart_ma35d1_port *up)

Please just put all one one line.


> +{
> +	u8 ch;
> +	u32 fsr;
> +	u32 isr;
> +	u32 dcnt;
> +	char flag;
> +
> +	isr = serial_in(up, UART_REG_ISR);
> +	fsr = serial_in(up, UART_REG_FSR);
> +
> +	while (!(fsr & RX_EMPTY)) {

You have no way out if the hardware is stuck?  That feels wrong.

> +static int ma35d1serial_ioctl(struct uart_port *port, u32 cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +	return 0;
> +}

You do not need to handle any ioctls?

> +static void ma35d1serial_console_putchar(struct uart_port *port,
> +					 unsigned char ch)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +
> +	do {
> +	} while ((serial_in(up, UART_REG_FSR) & TX_FULL));

Again, no way out if this gets stuck in a loop?

> +/**
> + *  Suspend one serial port.
> + */
> +void ma35d1serial_suspend_port(int line)
> +{
> +	uart_suspend_port(&ma35d1serial_reg, &ma35d1serial_ports[line].port);
> +}
> +EXPORT_SYMBOL(ma35d1serial_suspend_port);

Why is this exported?  Who uses it?

And why not EXPORT_SYMBOL_GPL()?

> +
> +/**
> + *  Resume one serial port.
> + */
> +void ma35d1serial_resume_port(int line)
> +{
> +	struct uart_ma35d1_port *up = &ma35d1serial_ports[line];
> +
> +	uart_resume_port(&ma35d1serial_reg, &up->port);
> +}
> +EXPORT_SYMBOL(ma35d1serial_resume_port);

Same here, who calls this and why?

> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -279,4 +279,7 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* Nuvoton MA35D1 UART */
> +#define PORT_MA35D1	124

Again, why is this define needed?

thanks,

greg k-h
