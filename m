Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3C6B6FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCMHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC708301BF;
        Mon, 13 Mar 2023 00:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648A1610D5;
        Mon, 13 Mar 2023 07:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEB3C433D2;
        Mon, 13 Mar 2023 07:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678690853;
        bh=FxS5IHspm1OkbSmYpHUiXGtbPx/YcLDxwASMa9Lkqwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfeNqGuPVQHGmLQuRWKJpI2jTQnmqDcsmyudu8jV3Z3jjsa0ZU3nOeBg9U6qevJMn
         P5k2CJcQdlN+1ls0Xda2lJvssrzLYlls6Bf0kBRWtpQTyRujIvu1UcQrghOQ1AkmHa
         46U9DiZKkzBD7UOH9FayMMvLS2GhpBI2/qAhNdfM=
Date:   Mon, 13 Mar 2023 08:00:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZA7KIs2jA/acpN9n@kroah.com>
References: <20230313010416.845252-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313010416.845252-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit, your "To:" line was corrupted :(

On Mon, Mar 13, 2023 at 03:04:16AM +0200, Jarkko Sonninen wrote:
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> Gpio mode register is set to enable RS-485.
> 
> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> ---
>  drivers/usb/serial/xr_serial.c | 72 +++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index fdb0aae546c3..edbb6add087c 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -93,6 +93,7 @@ struct xr_txrx_clk_mask {
>  #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
>  #define XR_GPIO_MODE_SEL_RS485		0x3
>  #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
> +#define XR_GPIO_MODE_RS485_TX_H		0x8
>  #define XR_GPIO_MODE_TX_TOGGLE		0x100
>  #define XR_GPIO_MODE_RX_TOGGLE		0x200
>  
> @@ -237,6 +238,8 @@ static const struct xr_type xr_types[] = {
>  struct xr_data {
>  	const struct xr_type *type;
>  	u8 channel;			/* zero-based index or interface number */
> +	struct serial_rs485 rs485;
> +	spinlock_t lock;
>  };
>  
>  static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
> @@ -629,6 +632,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>  	struct xr_data *data = usb_get_serial_port_data(port);
>  	const struct xr_type *type = data->type;
>  	u16 flow, gpio_mode;
> +	unsigned long flags, rs485_flags;
>  	int ret;
>  
>  	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
> @@ -645,9 +649,16 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>  	/* Set GPIO mode for controlling the pins manually by default. */
>  	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
>  
> +	spin_lock_irqsave(&data->lock, flags);
> +	rs485_flags = data->rs485.flags;
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	if (rs485_flags & SER_RS485_ENABLED)
> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
> +	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
> +		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
> +
>  	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
>  		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
> -		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>  		flow = XR_UART_FLOW_MODE_HW;
>  	} else if (I_IXON(tty)) {
>  		u8 start_char = START_CHAR(tty);
> @@ -827,6 +838,64 @@ static void xr_set_termios(struct tty_struct *tty,
>  	xr_set_flow_mode(tty, port, old_termios);
>  }
>  
> +static int xr_get_rs485_config(struct tty_struct *tty,
> +			 unsigned int __user *argp)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	unsigned long flags;
> +	struct serial_rs485 rs485;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	memcpy(&rs485, &data->rs485, sizeof(rs485));

Why are you using the stack for this?  Why not directly access the real
structure instead?  And are you sure you need a lock?  If so, why?

> +	spin_unlock_irqrestore(&data->lock, flags);
> +	dev_dbg(tty->dev, "%s flags %02x\n", __func__, rs485.flags);

dev_dbg() provides __func__ for free, so you never need to provide it
again.  Just use the +f flag when enabling it from userspace.

> +
> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int xr_set_rs485_config(struct tty_struct *tty,
> +			 unsigned long __user *argp)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	struct serial_rs485 rs485;
> +	unsigned long flags;
> +
> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	dev_dbg(tty->dev, "%s flags %02x\n", __func__, rs485.flags);

Again, no need for __func__.

> +	rs485.flags &= SER_RS485_ENABLED;
> +	spin_lock_irqsave(&data->lock, flags);
> +	memcpy(&data->rs485, &rs485, sizeof(rs485));
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	xr_set_flow_mode(tty, port, 0);
> +
> +	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +
> +static int xr_ioctl(struct tty_struct *tty,
> +					unsigned int cmd, unsigned long arg)

Very odd indentation, please fix up.

> +{
> +	void __user *argp = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case TIOCGRS485:
> +		return xr_get_rs485_config(tty, argp);
> +	case TIOCSRS485:
> +		return xr_set_rs485_config(tty, argp);
> +	}
> +	return -ENOIOCTLCMD;

Wrong ioctl return value :(

thanks,

greg k-h
