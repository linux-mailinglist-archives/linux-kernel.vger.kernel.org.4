Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C1736C11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjFTMiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFTMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834C10F4;
        Tue, 20 Jun 2023 05:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9316611EA;
        Tue, 20 Jun 2023 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4260AC433C8;
        Tue, 20 Jun 2023 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687264697;
        bh=/Ks2ZmOZaxBIkHrChnuy4/4MQm9dVXe+5g4kQsQ7ukw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URxfrxq+oAaSnPRSPpGN0MYkrQrrW22s6oEXZL7xJjFD4OEfte7onhe+x56/SE2Uq
         ta4TcQuzbLaq/j/B6RHxet+HsVEP3mdD3aRgcXgasxGGjKkTTGn8H772cvn59URCHX
         erovsg+dwcZfLBF8nVMHsy2Fr9SO7j60YT4vymSCThswrLg4dLci7DwcmWY1u/SkFE
         Nz9CQOzqgPjSVq9mGHKEnbK3vEJXfr/Vpb26T/YNFps3rTk6EUWbfCxzLc9nPW0nLM
         8wMgXWIRCvxvGDKAM/n7V09NpqqUYPUOBLN054w0UEV5wSmr9nnsof3OXjAm8SrY3q
         vY3HLO42j0F4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBacj-0000HE-PC; Tue, 20 Jun 2023 14:38:17 +0200
Date:   Tue, 20 Jun 2023 14:38:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZJGduS4z5U65T7IL@hovoldconsulting.com>
References: <ZD1cy6omacYMRCLs@hovoldconsulting.com>
 <20230423185929.1595056-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423185929.1595056-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

I've been waiting for you to send a v5 that addresses the issue that the
kernel test robot found, but I guess I can review the other changes in
v4 first.

On Sun, Apr 23, 2023 at 09:59:28PM +0300, Jarkko Sonninen wrote:
> Exar devices like XR21B1411 can control an RS485 transceiver by
> automatically asserting the RTS#/RS485 pin before sending data
> and deasserting it when the last stop bit has been transmitted.
> The polarity of the RST#/RS485 signal is configurable and the
> hardware also supports half-duplex turn-around delay and
> address matching mode.
> 
> Add support for enabling and disabling RS-485 mode and
> configuring the RST#/RS485 signal polarity using the TIOCGRS485
> and TIOCSRS485 ioctls. Support for half-duplex turn-around delay
> and address matching mode are left unimplemented for now.
> 
> User enables RS-485 mode by setting SER_RS485_ENABLED flag in
> struct serial_rs485 flags. User should also set either
> SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND to select the
> behaviour of the RTS#/RS485 pin. Setting SER_RS485_RTS_ON_SEND
> will drive RTS#/RS485 high during transmission. As this is the
> typical application described by Exar, it is selected when
> user sets neither or both flags.

Thanks for updating the commit message here.

Since RTS# is active low, shouldn't SER_RS485_RTS_ON_SEND drive RTS# low
rather than high during transmission as I also pointed out earlier?

> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> ---
> Changes in v3:
>  - In this version only rs485.flags are stored to state.
>  - There is no locking as only one bit of the flags is used.
>  - ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
> Changes in v4:
>  - Store struct rs485 to data
>  - Add mutex to protect data->rs485.
>  - Implement SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND flags
>  - SER_RS485_RTS_ON_SEND is the default like in serial_core.c
> 
> 
>  drivers/usb/serial/xr_serial.c | 93 +++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index fdb0aae546c3..a2157619b63c 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -19,6 +19,7 @@
>  #include <linux/usb.h>
>  #include <linux/usb/cdc.h>
>  #include <linux/usb/serial.h>
> +#include <linux/mutex.h>

Nit: keep the includes sorted alphabetically.

>  struct xr_txrx_clk_mask {
>  	u16 tx;
> @@ -93,6 +94,7 @@ struct xr_txrx_clk_mask {
>  #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
>  #define XR_GPIO_MODE_SEL_RS485		0x3
>  #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
> +#define XR_GPIO_MODE_RS485_TX_H		0x8
>  #define XR_GPIO_MODE_TX_TOGGLE		0x100
>  #define XR_GPIO_MODE_RX_TOGGLE		0x200
>  
> @@ -237,6 +239,8 @@ static const struct xr_type xr_types[] = {
>  struct xr_data {
>  	const struct xr_type *type;
>  	u8 channel;			/* zero-based index or interface number */
> +	struct serial_rs485 rs485;
> +	struct mutex lock;
>  };
>  
>  static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
> @@ -630,6 +634,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>  	const struct xr_type *type = data->type;
>  	u16 flow, gpio_mode;
>  	int ret;
> +	bool rs485_enabled;

Nit: move above ret to maintain some approximation of reverse xmas style
declaration.

>  
>  	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
>  	if (ret)
> @@ -645,7 +650,17 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>  	/* Set GPIO mode for controlling the pins manually by default. */
>  	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
>  
> -	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
> +	rs485_enabled = !!(data->rs485.flags & SER_RS485_ENABLED);
> +	if (rs485_enabled) {
> +		dev_dbg(&port->dev, "Enabling RS-485\n");
> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485;
> +		if (data->rs485.flags & SER_RS485_RTS_ON_SEND)
> +			gpio_mode |= XR_GPIO_MODE_RS485_TX_H;
> +		else
> +			gpio_mode &= ~XR_GPIO_MODE_RS485_TX_H;

As mentioned above, should this not be inverted?

> +	}
> +
> +	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0 && !rs485_enabled) {
>  		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
>  		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>  		flow = XR_UART_FLOW_MODE_HW;
> @@ -809,6 +824,80 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
>  	kfree(lc);
>  }
>  
> +static void xr_sanitize_serial_rs485(struct serial_rs485 *rs485)
> +{
> +	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +		memset(rs485, 0, sizeof(*rs485));
> +		return;
> +	}

This looks odd to me, but I see that this is what serial core is
currently doing...

> +
> +	/* Select RTS on send if the user hasn't selected the mode properly */
> +	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> +	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
> +		rs485->flags |= SER_RS485_RTS_ON_SEND;
> +		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> +	}
> +
> +	/* Only the flags are implemented at the moment */
> +	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +			SER_RS485_RTS_AFTER_SEND;
> +	rs485->delay_rts_before_send = 0;
> +	rs485->delay_rts_after_send = 0;
> +	memset(rs485->padding, 0, sizeof(rs485->padding));
> +}
> +
> +static int xr_get_rs485_config(struct tty_struct *tty,
> +			       struct serial_rs485 *argp)

You still need __user annotation here as the build robot reported.

> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +
> +	mutex_lock(&data->lock);

This does not prevent the termios structure from changing underneath
you. You need to take a write lock on the termios rw sem here instead.

> +	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485))) {
> +		mutex_unlock(&data->lock);
> +		return -EFAULT;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static int xr_set_rs485_config(struct tty_struct *tty,
> +			       struct serial_rs485 *argp)

missing __user

> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	struct serial_rs485 rs485;
> +
> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
> +		return -EFAULT;
> +	xr_sanitize_serial_rs485(&rs485);
> +
> +	mutex_lock(&data->lock);

Same here as set_termios() (and xr_set_flow_mode()) can otherwise be
called in parallel.

> +	data->rs485 = rs485;
> +	xr_set_flow_mode(tty, port, NULL);
> +	mutex_unlock(&data->lock);
> +
> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	return 0;
> +}

Looks good otherwise.

Johan
