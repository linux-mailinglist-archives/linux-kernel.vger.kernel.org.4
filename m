Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75F6E0962
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDMIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjDMIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0808793D8;
        Thu, 13 Apr 2023 01:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FFB660F82;
        Thu, 13 Apr 2023 08:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB5AC433D2;
        Thu, 13 Apr 2023 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681375989;
        bh=KD2i7rfc05PNm6fc+ra9GKR25FspBvRlzhcKY9GMol4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCX6bClgI9it97V9kSVUo+plGUqXnU1pMdGONvavGaXjoMIdNj0S2dL7pq++3n97S
         KEAgDcJlitxkowAd7t/tuCIzBdLYTLFKFvq00/B0vcCQIQOkL10MuJBaEYEJA5mvjP
         wnAoNUsOXLL1mtOkFoFj2I+bTbJmGbJ+/xsACyoXroZFFvzEYna0rzeYDPSb+wxYSd
         dWxy+4c85dRt9Qh/koZycOtBuSxToStJhTeJLbOEWui51kcM9YZPePxWpbYis6TASI
         AD1k/xV7FYcSV3m4VIdk7p8KZF7V0mfxyBYQwaOizniJk3y6IPloRW56yd89jdIMlk
         9BOvQaC6H09Uw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmshb-00007D-5U; Thu, 13 Apr 2023 10:53:11 +0200
Date:   Thu, 13 Apr 2023 10:53:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZDfC9xkDMAJn60jc@hovoldconsulting.com>
References: <20230313010416.845252-1-kasper@iki.fi>
 <20230314070002.1008959-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314070002.1008959-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:00:01AM +0200, Jarkko Sonninen wrote:
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> Gpio mode register is set to enable RS-485.

Which register you use is an implementation details which is not really
needed in the commit message.

Please say something about how the hardware works and try to describe
what you are implementing here and perhaps something about what is left
unsupported (e.g. the fixed rts polarity).

> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> ---
> 
> In this version only rs485.flags are stored to state.
> There is no locking as only one bit of the flags is used.
> ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
> 
>  drivers/usb/serial/xr_serial.c | 62 +++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index fdb0aae546c3..7b542ccb6596 100644
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
> @@ -237,6 +238,7 @@ static const struct xr_type xr_types[] = {
>  struct xr_data {
>  	const struct xr_type *type;
>  	u8 channel;			/* zero-based index or interface number */
> +	u32 rs485_flags;
>  };
>  
>  static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
> @@ -645,9 +647,13 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>  	/* Set GPIO mode for controlling the pins manually by default. */
>  	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
>  
> +	if (data->rs485_flags & SER_RS485_ENABLED)
> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
> +	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
> +		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
> +
>  	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
>  		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
> -		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>  		flow = XR_UART_FLOW_MODE_HW;

The logic here is unnecessarily convoluted here and you also should not
set hardware flow control mode if rs485 mode is enabled.

Perhaps you can add a local boolean flag to hold the rs485 state and
test it before the current if-else construct. Then you only enable
hw-flow when rs485 mode is disabled while stile allowing sw-flow to be
set (hopefully that's a legal combination, please do try to verify
that).

It also looks like you have inverted the RS485 polarity by using
XR_GPIO_MODE_RS485_TX_H (more on that below).

>  	} else if (I_IXON(tty)) {
>  		u8 start_char = START_CHAR(tty);
> @@ -827,6 +833,59 @@ static void xr_set_termios(struct tty_struct *tty,
>  	xr_set_flow_mode(tty, port, old_termios);
>  }
>  
> +static int xr_get_rs485_config(struct tty_struct *tty,
> +			 unsigned int __user *argp)

argp points to struct serial_rs485 to use that as the type rather than
pointer to unsigned int.

> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	struct serial_rs485 rs485;
> +
> +	dev_dbg(tty->dev, "Flags %02x\n", data->rs485_flags);

This is not a very informative message. Please add back the function
prefix so that is also distinguishable from the dev_dbg() in the other
rs485 helper and use the following format:

	"%s - flags = 0x%02x\n", __func__, ...

And add a new line here.

> +	memset(&rs485, 0, sizeof(rs485));
> +	rs485.flags = data->rs485_flags;
> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int xr_set_rs485_config(struct tty_struct *tty,
> +			 unsigned long __user *argp)

Use a pointer to the struct here too.

> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	struct serial_rs485 rs485;
> +
> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);

Please update the format string as mentioned above.

Add a newline here.

> +	data->rs485_flags = rs485.flags & SER_RS485_ENABLED;
> +	xr_set_flow_mode(tty, port, (const struct ktermios *)0);

This function accesses tty->termios so you can not call it here without
any locking as it can change underneath you and nothing currently
prevents set_termios() from calling the same function in parallel.

If you take a write lock on the termios rw sempahore you can use it also
to protect the rs485 data instead of relying on implicit atomicity
rules.

And perhaps you should just copy the entire rs485 struct from the start
as these devices supports further features which someone may want to
implement support for later (e.g. delay after send and 9th bit
addressing).

You should just use NULL for the third (old_termios) argument.

> +
> +	// Only the enable flag is implemented

No c99 comments, please.

> +	memset(&rs485, 0, sizeof(rs485));
> +	rs485.flags = data->rs485_flags;

This does not look correct given that you set the RS485 TX polarity so
that RTS is high (logic disable) during TX above.

You need to at least make sure that both the SER_RS485_RTS_ON_SEND and
SER_RS485_RTS_AFTER_SEND bits match the polarity setting. But perhaps
you could consider implementing support for configuring the polarity
from the start.

> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
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
> +	return -ENOIOCTLCMD;
> +}
> +
>  static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
>  {
>  	int ret;
> @@ -1010,6 +1069,7 @@ static struct usb_serial_driver xr_device = {
>  	.set_termios		= xr_set_termios,
>  	.tiocmget		= xr_tiocmget,
>  	.tiocmset		= xr_tiocmset,
> +	.ioctl			= xr_ioctl,
>  	.dtr_rts		= xr_dtr_rts
>  };

Johan
