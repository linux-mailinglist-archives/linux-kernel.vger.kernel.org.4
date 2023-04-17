Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231B26E4BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDQOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD465A0;
        Mon, 17 Apr 2023 07:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6C9E61FE9;
        Mon, 17 Apr 2023 14:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC26C433EF;
        Mon, 17 Apr 2023 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681743044;
        bh=mC950doGDx3IoJ92opWN6Hi8dgm/VDBovZO1UKmkJ60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOxq3Fh1BwfMbh+Y4fEZgf8mdaVPB+Zm7LKaHJOGGlTwakeYn9ZKI4DIVGP5rhMm+
         Q+uGGEGRklvKqo+3o0Os7nTDvtB/ma/m9kRfQWsxwQCfuVdKIdGqnfifOJOO9ArtRK
         e5NRrmFZuh+XHRVFMUSwWLgjIiUBAlUdwxG8cou18h31aWKUUIMYu/bv3MVoFEBUFr
         Pxf5Vde3JWFIq4W37fz0Q+TkYnfgEYraSBlZ4U/YNz4+ZY5Q99kCe19EPQrWZfHsyJ
         bStdDm5AUovO9wx0hXwOkILwcDsDtdF24KCfVCmVyUAObPKycJUOzNxUEx/wctFHk4
         O1JFk8tvh/Ciw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1poQBw-0007cd-00; Mon, 17 Apr 2023 16:50:52 +0200
Date:   Mon, 17 Apr 2023 16:50:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZD1cy6omacYMRCLs@hovoldconsulting.com>
References: <20230313010416.845252-1-kasper@iki.fi>
 <20230314070002.1008959-1-kasper@iki.fi>
 <ZDfC9xkDMAJn60jc@hovoldconsulting.com>
 <57fef05a-e885-f83b-1536-7a9f9e8a4adf@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fef05a-e885-f83b-1536-7a9f9e8a4adf@iki.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 11:40:00AM +0300, Jarkko Sonninen wrote:
> On 4/13/23 11:53, Johan Hovold wrote:
> > On Tue, Mar 14, 2023 at 09:00:01AM +0200, Jarkko Sonninen wrote:
> >> Add support for RS-485 in Exar USB adapters.
> >> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> >> Gpio mode register is set to enable RS-485.
> > Which register you use is an implementation details which is not really
> > needed in the commit message.
> >
> > Please say something about how the hardware works and try to describe
> > what you are implementing here and perhaps something about what is left
> > unsupported (e.g. the fixed rts polarity).
> 
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> SER_RS485_ENABLED and SER_RS485_RTS_ON_SEND flags are implemented.
> There is only one polarity control in Exar for both RTS_ON_SEND and 
> RTS_AFTER_SEND.
> RS-485 delays and addressing modes are not implemented.
> 
> ok ?

Sure, something like that, but perhaps you can amend the bit about
RTS_AFTER_SEND (see below).

It would be even better if you could try to rephrase this so that it
reads a little easier. Something along the lines of

	Exar devices like <model> can control an RS485 tranceiver by
	automatically asserting the RTS#/RS485 pin before sending data
	and deasserting it when the last stop bit has been transmitted.
	The polarity of the RST#/RS485 signal is configurable and the
	hardware also supports features <XYZ>...

	Add support for enabling and disabling RS-485 mode and
	configuring the signal polarity using the TIOCGRS485 and
	TIOCSRS485 ioctls. Support for <XYZ> is left unimplemented for
	now.

> >> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> >> ---
> >>
> >> In this version only rs485.flags are stored to state.
> >> There is no locking as only one bit of the flags is used.
> >> ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
> >>
> >>   drivers/usb/serial/xr_serial.c | 62 +++++++++++++++++++++++++++++++++-
> >>   1 file changed, 61 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> >> index fdb0aae546c3..7b542ccb6596 100644
> >> --- a/drivers/usb/serial/xr_serial.c
> >> +++ b/drivers/usb/serial/xr_serial.c
> >> @@ -93,6 +93,7 @@ struct xr_txrx_clk_mask {
> >>   #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
> >>   #define XR_GPIO_MODE_SEL_RS485		0x3
> >>   #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
> >> +#define XR_GPIO_MODE_RS485_TX_H		0x8
> >>   #define XR_GPIO_MODE_TX_TOGGLE		0x100
> >>   #define XR_GPIO_MODE_RX_TOGGLE		0x200
> >>   
> >> @@ -237,6 +238,7 @@ static const struct xr_type xr_types[] = {
> >>   struct xr_data {
> >>   	const struct xr_type *type;
> >>   	u8 channel;			/* zero-based index or interface number */
> >> +	u32 rs485_flags;
> >>   };
> >>   
> >>   static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
> >> @@ -645,9 +647,13 @@ static void xr_set_flow_mode(struct tty_struct *tty,
> >>   	/* Set GPIO mode for controlling the pins manually by default. */
> >>   	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
> >>   
> >> +	if (data->rs485_flags & SER_RS485_ENABLED)
> >> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
> >> +	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
> >> +		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
> >> +
> >>   	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
> >>   		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
> >> -		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
> >>   		flow = XR_UART_FLOW_MODE_HW;
> > The logic here is unnecessarily convoluted here and you also should not
> > set hardware flow control mode if rs485 mode is enabled.
> >
> > Perhaps you can add a local boolean flag to hold the rs485 state and
> > test it before the current if-else construct. Then you only enable
> > hw-flow when rs485 mode is disabled while stile allowing sw-flow to be
> > set (hopefully that's a legal combination, please do try to verify
> > that).
> 
> I'll implement SER_RS485_RTS_ON_SEND and set XR_GPIO_MODE_RS485_TX_H 
> according to it.
> 
> I tested sw flow and it works.

Thanks for checking.

> > It also looks like you have inverted the RS485 polarity by using
> > XR_GPIO_MODE_RS485_TX_H (more on that below).
> >
> >>   	} else if (I_IXON(tty)) {
> >>   		u8 start_char = START_CHAR(tty);

> >> +static int xr_set_rs485_config(struct tty_struct *tty,
> >> +			 unsigned long __user *argp)
> > Use a pointer to the struct here too.
> >
> >> +{
> >> +	struct usb_serial_port *port = tty->driver_data;
> >> +	struct xr_data *data = usb_get_serial_port_data(port);
> >> +	struct serial_rs485 rs485;
> >> +
> >> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
> >> +		return -EFAULT;
> >> +
> >> +	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
> > Please update the format string as mentioned above.
> >
> > Add a newline here.
> 
> I'll remove this debug.
> 
> >> +	data->rs485_flags = rs485.flags & SER_RS485_ENABLED;
> >> +	xr_set_flow_mode(tty, port, (const struct ktermios *)0);
> > This function accesses tty->termios so you can not call it here without
> > any locking as it can change underneath you and nothing currently
> > prevents set_termios() from calling the same function in parallel.
> >
> > If you take a write lock on the termios rw sempahore you can use it also
> > to protect the rs485 data instead of relying on implicit atomicity
> > rules.
> >
> > And perhaps you should just copy the entire rs485 struct from the start
> > as these devices supports further features which someone may want to
> > implement support for later (e.g. delay after send and 9th bit
> > addressing).
> >
> > You should just use NULL for the third (old_termios) argument.
> >
> >> +
> >> +	// Only the enable flag is implemented
> > No c99 comments, please.
> >
> >> +	memset(&rs485, 0, sizeof(rs485));
> >> +	rs485.flags = data->rs485_flags;
> > This does not look correct given that you set the RS485 TX polarity so
> > that RTS is high (logic disable) during TX above.
> >
> > You need to at least make sure that both the SER_RS485_RTS_ON_SEND and
> > SER_RS485_RTS_AFTER_SEND bits match the polarity setting. But perhaps
> > you could consider implementing support for configuring the polarity
> > from the start.
> 
> What should happen if user sets SER_RS485_RTS_ON_SEND=1 and 
> SER_RS485_RTS_AFTER_SEND=0 or vice versa ?
> 
> There is only one bit for polarity control in the Exar register.
> 
> I am thinking of using only SER_RS485_RTS_ON_SEND to control the 
> polarity and setting _RTS_AFTER_SEND to the same value.

Yeah, this is perhaps not the best designed interface we have...

The way I interpret those flag, they should generally be each others
negation as presumably most hardware controlled rs485 implementations
works as the Exar devices do (i.e. they have one polarity flag).

Settings both to the same value doesn't seem to make much sense so not
sure why it was designed this way.

But here you should just set SER_RS485_RTS_AFTER_SEND to
!SER_RS485_RTS_ON_SEND.

> >> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
> >> +		return -EFAULT;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +

You can drop the second newline here (and elsewhere if you added more of
these).

> >> +static int xr_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> >> +{
> >> +	void __user *argp = (void __user *)arg;
> >> +
> >> +	switch (cmd) {
> >> +	case TIOCGRS485:
> >> +		return xr_get_rs485_config(tty, argp);
> >> +	case TIOCSRS485:
> >> +		return xr_set_rs485_config(tty, argp);
> >> +	}
> >> +	return -ENOIOCTLCMD;
> >> +}

Johan
