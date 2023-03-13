Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7656B7178
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCMIrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCMIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:46:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F74ECF7;
        Mon, 13 Mar 2023 01:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD55ECE0EC8;
        Mon, 13 Mar 2023 08:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60803C433D2;
        Mon, 13 Mar 2023 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678697144;
        bh=VMjyX8k6XHFsXNNjGBjW/9pSpOIbM79TjTGsE28Bw/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYGTujPGnhqti7Zk3vjRz5EjsoD1LjRJwSqzpLH+KZH3RYqz9A59VzG28R3rFGJGg
         fo0CgrIsuriiHp2WiIR97mVZCQxP4qyxWiAbLxaONQrxeD9TWN3zMxb9QHOwHJFZw1
         6TKOs4IwnSn6yNDTo5UcatJJfbIwek9JOV86EOS8=
Date:   Mon, 13 Mar 2023 09:45:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZA7itvkEhW11AFfJ@kroah.com>
References: <ZA7Wh2Z/DdKOsOYr@kroah.com>
 <20230313082734.886890-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313082734.886890-1-kasper@iki.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:27:34AM +0200, Jarkko Sonninen wrote:
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> Gpio mode register is set to enable RS-485.
> 
> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> ---
>  drivers/usb/serial/xr_serial.c | 65 +++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index fdb0aae546c3..480cda0daafc 100644
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
> @@ -827,6 +838,57 @@ static void xr_set_termios(struct tty_struct *tty,
>  	xr_set_flow_mode(tty, port, old_termios);
>  }
>  
> +static int xr_get_rs485_config(struct tty_struct *tty,
> +			 unsigned int __user *argp)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +
> +	dev_dbg(tty->dev, "Flags %02x\n", data->rs485.flags);
> +	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
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
> +	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
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
> +static int xr_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case TIOCGRS485:
> +		return xr_get_rs485_config(tty, argp);
> +	case TIOCSRS485:
> +		return xr_set_rs485_config(tty, argp);
> +	}
> +	return -ENOTTY;
> +}
> +
>  static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
>  {
>  	int ret;
> @@ -1010,6 +1072,7 @@ static struct usb_serial_driver xr_device = {
>  	.set_termios		= xr_set_termios,
>  	.tiocmget		= xr_tiocmget,
>  	.tiocmset		= xr_tiocmset,
> +	.ioctl			= xr_ioctl,
>  	.dtr_rts		= xr_dtr_rts
>  };
>  
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
