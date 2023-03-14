Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28886B8C19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCNHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCNHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:37:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A60898FE;
        Tue, 14 Mar 2023 00:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 702A2B818A0;
        Tue, 14 Mar 2023 07:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8EBC433EF;
        Tue, 14 Mar 2023 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678779454;
        bh=TjlGRsE1M6KA98s2hpAwK21M3/yIO8CR8yaiRC8Hb0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zls9ke29aj1DCCmOJrJdv4uEoLDDaGk9M1d1m1oeyi0mghfr8hu8LWWKV63182/pN
         3LuxeFbKUFr5TPsWh+tz8mlklmZHwGJJ2ySIvyercn5FSkUd8Jsj3h0lIHWsFjRHw3
         jUVadXbLVgBPiCZyte6lgF/0BrkRF6/eVX5Lajf0=
Date:   Tue, 14 Mar 2023 08:37:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZBAkOr0epPPICLNP@kroah.com>
References: <20230313010416.845252-1-kasper@iki.fi>
 <20230314070002.1008959-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314070002.1008959-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:00:01AM +0200, Jarkko Sonninen wrote:
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> Gpio mode register is set to enable RS-485.
> 
> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> ---
> 
> In this version only rs485.flags are stored to state.
> There is no locking as only one bit of the flags is used.
> ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.

And the difference between previous versions?  Take a look at the
documentation for how to better describe version differences please.

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

Nit, you might want to move this up above channel as you now have a hole
in this structure.  Not like it's that big of a deal so if you don't
have to respin this no need to change.

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
>  	} else if (I_IXON(tty)) {
>  		u8 start_char = START_CHAR(tty);
> @@ -827,6 +833,59 @@ static void xr_set_termios(struct tty_struct *tty,
>  	xr_set_flow_mode(tty, port, old_termios);
>  }
>  
> +static int xr_get_rs485_config(struct tty_struct *tty,
> +			 unsigned int __user *argp)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	struct serial_rs485 rs485;
> +
> +	dev_dbg(tty->dev, "Flags %02x\n", data->rs485_flags);
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
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_data *data = usb_get_serial_port_data(port);
> +	struct serial_rs485 rs485;
> +
> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
> +	data->rs485_flags = rs485.flags & SER_RS485_ENABLED;
> +	xr_set_flow_mode(tty, port, (const struct ktermios *)0);
> +
> +	// Only the enable flag is implemented

All the other comments in this file use /* */ so you should be
consistent.

> +	memset(&rs485, 0, sizeof(rs485));

But you just copied this from userspace, why zero it out again?  Is that
to be expected (I really don't remember, sorry).

Anyway, just minor comments, I'll let others review it as well.

thanks,

greg k-h
