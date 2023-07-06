Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B939E74A478
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGFTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:38:05 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8AF19B7;
        Thu,  6 Jul 2023 12:38:03 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Qxmyr208yzyTB;
        Thu,  6 Jul 2023 22:37:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1688672277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQlneAQMvJUO6eSppMGSwfIyIcJUiyBf4uAylUrlma0=;
        b=PeWk86qGOjLjIsmdGLwga4ZgDo8+bVnFvODeRZnLEICNXTzDdphbJ4ZIb0aAq/4P7UsU4L
        sEkBrY5QEmGAJ0JBTKxssayICX08K+0WA9w/s0u4JPDhehP4wOOaNFEsThSfQ/n3LfJokw
        oQ/psx2gTh43cU3XZwbH2ICMHfBx6VE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1688672277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQlneAQMvJUO6eSppMGSwfIyIcJUiyBf4uAylUrlma0=;
        b=ggh98FEEwQukyFJxhuSZPBc5QjEyiZoBh66A73PoMi1PYqwf2J0gXaLGe/7aTK0fXgm1VO
        fbr336wC009Ht4juy1q8glp8cep92GqyX9ZG7ryNwsrTDXJJ9YOTMIuDCh3Z4Wyfd54/Wj
        oVf1IYDSDxZX1hI1bwmvtTp8LYlRfpk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1688672277; a=rsa-sha256; cv=none;
        b=QI7pxDDs4v03+WI8g495xnxstqwnEi3kMSrmmzWSVbLLKAQ2lN0e6IGAKht3vi1epLcbqc
        PnU9nwIss3HNbtURORdig7ZzCDss1XMVMsb9pa57EIEDTUKNVwx15Sk2NLYOoYv7ZWbf7X
        WilPRQpMFpr6d/wke2nJswnRj0w7r0Q=
Received: from [IPV6:2001:14ba:44e3:8200::2] (dkxv4fyyyyyyyyyyyyyby-3.rev.dnainternet.fi [IPv6:2001:14ba:44e3:8200::2])
        by dungeon.fi (Postfix) with ESMTPSA id 49F793F4DA;
        Thu,  6 Jul 2023 22:37:52 +0300 (EEST)
Message-ID: <ae52e145-98b5-dd55-a4d8-5022c99b1129@iki.fi>
Date:   Thu, 6 Jul 2023 22:37:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZD1cy6omacYMRCLs@hovoldconsulting.com>
 <20230423185929.1595056-1-kasper@iki.fi>
 <ZJGduS4z5U65T7IL@hovoldconsulting.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <ZJGduS4z5U65T7IL@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 15:38, Johan Hovold wrote:
> Hi Jarkko,
>
> I've been waiting for you to send a v5 that addresses the issue that the
> kernel test robot found, but I guess I can review the other changes in
> v4 first.

Thank you. Sorry for slow responses. My mind has been elsewhere.

> On Sun, Apr 23, 2023 at 09:59:28PM +0300, Jarkko Sonninen wrote:
>> Exar devices like XR21B1411 can control an RS485 transceiver by
>> automatically asserting the RTS#/RS485 pin before sending data
>> and deasserting it when the last stop bit has been transmitted.
>> The polarity of the RST#/RS485 signal is configurable and the
>> hardware also supports half-duplex turn-around delay and
>> address matching mode.
>>
>> Add support for enabling and disabling RS-485 mode and
>> configuring the RST#/RS485 signal polarity using the TIOCGRS485
>> and TIOCSRS485 ioctls. Support for half-duplex turn-around delay
>> and address matching mode are left unimplemented for now.
>>
>> User enables RS-485 mode by setting SER_RS485_ENABLED flag in
>> struct serial_rs485 flags. User should also set either
>> SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND to select the
>> behaviour of the RTS#/RS485 pin. Setting SER_RS485_RTS_ON_SEND
>> will drive RTS#/RS485 high during transmission. As this is the
>> typical application described by Exar, it is selected when
>> user sets neither or both flags.
> Thanks for updating the commit message here.
>
> Since RTS# is active low, shouldn't SER_RS485_RTS_ON_SEND drive RTS# low
> rather than high during transmission as I also pointed out earlier?

I guess you are right. I'll change that.


I use an exar usb adapter to control a solar charging controller. I 
haven't found any other type of exar adapters in ebay.

This adapter uses high level (RTS off) on TX. So I really would like it 
to work with the default configuration.

I hope it is ok to use SER_RS485_RTS_AFTER_SEND as the default


>> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
>> ---
>> Changes in v3:
>>   - In this version only rs485.flags are stored to state.
>>   - There is no locking as only one bit of the flags is used.
>>   - ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
>> Changes in v4:
>>   - Store struct rs485 to data
>>   - Add mutex to protect data->rs485.
>>   - Implement SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND flags
>>   - SER_RS485_RTS_ON_SEND is the default like in serial_core.c
>>
>>
>>   drivers/usb/serial/xr_serial.c | 93 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
>> index fdb0aae546c3..a2157619b63c 100644
>> --- a/drivers/usb/serial/xr_serial.c
>> +++ b/drivers/usb/serial/xr_serial.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/usb.h>
>>   #include <linux/usb/cdc.h>
>>   #include <linux/usb/serial.h>
>> +#include <linux/mutex.h>
> Nit: keep the includes sorted alphabetically.
>
>>   struct xr_txrx_clk_mask {
>>   	u16 tx;
>> @@ -93,6 +94,7 @@ struct xr_txrx_clk_mask {
>>   #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
>>   #define XR_GPIO_MODE_SEL_RS485		0x3
>>   #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
>> +#define XR_GPIO_MODE_RS485_TX_H		0x8
>>   #define XR_GPIO_MODE_TX_TOGGLE		0x100
>>   #define XR_GPIO_MODE_RX_TOGGLE		0x200
>>   
>> @@ -237,6 +239,8 @@ static const struct xr_type xr_types[] = {
>>   struct xr_data {
>>   	const struct xr_type *type;
>>   	u8 channel;			/* zero-based index or interface number */
>> +	struct serial_rs485 rs485;
>> +	struct mutex lock;
>>   };
>>   
>>   static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
>> @@ -630,6 +634,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>>   	const struct xr_type *type = data->type;
>>   	u16 flow, gpio_mode;
>>   	int ret;
>> +	bool rs485_enabled;
> Nit: move above ret to maintain some approximation of reverse xmas style
> declaration.
>
>>   
>>   	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
>>   	if (ret)
>> @@ -645,7 +650,17 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>>   	/* Set GPIO mode for controlling the pins manually by default. */
>>   	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
>>   
>> -	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
>> +	rs485_enabled = !!(data->rs485.flags & SER_RS485_ENABLED);
>> +	if (rs485_enabled) {
>> +		dev_dbg(&port->dev, "Enabling RS-485\n");
>> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485;
>> +		if (data->rs485.flags & SER_RS485_RTS_ON_SEND)
>> +			gpio_mode |= XR_GPIO_MODE_RS485_TX_H;
>> +		else
>> +			gpio_mode &= ~XR_GPIO_MODE_RS485_TX_H;
> As mentioned above, should this not be inverted?
>
>> +	}
>> +
>> +	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0 && !rs485_enabled) {
>>   		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
>>   		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>>   		flow = XR_UART_FLOW_MODE_HW;
>> @@ -809,6 +824,80 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
>>   	kfree(lc);
>>   }
>>   
>> +static void xr_sanitize_serial_rs485(struct serial_rs485 *rs485)
>> +{
>> +	if (!(rs485->flags & SER_RS485_ENABLED)) {
>> +		memset(rs485, 0, sizeof(*rs485));
>> +		return;
>> +	}
> This looks odd to me, but I see that this is what serial core is
> currently doing...
>
>> +
>> +	/* Select RTS on send if the user hasn't selected the mode properly */
>> +	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
>> +	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
>> +		rs485->flags |= SER_RS485_RTS_ON_SEND;
>> +		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
>> +	}
>> +
>> +	/* Only the flags are implemented at the moment */
>> +	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
>> +			SER_RS485_RTS_AFTER_SEND;
>> +	rs485->delay_rts_before_send = 0;
>> +	rs485->delay_rts_after_send = 0;
>> +	memset(rs485->padding, 0, sizeof(rs485->padding));
>> +}
>> +
>> +static int xr_get_rs485_config(struct tty_struct *tty,
>> +			       struct serial_rs485 *argp)
> You still need __user annotation here as the build robot reported.
>
>> +{
>> +	struct usb_serial_port *port = tty->driver_data;
>> +	struct xr_data *data = usb_get_serial_port_data(port);
>> +
>> +	mutex_lock(&data->lock);
> This does not prevent the termios structure from changing underneath
> you. You need to take a write lock on the termios rw sem here instead.


I'll change these to "down_read(&tty->termios_rwsem);" and 
"up_read(&tty->termios_rwsem);"

I would feel safer by using a local variable "struct serial_rs485" to 
minimize the holding of the semaphore.


>
>> +	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485))) {
>> +		mutex_unlock(&data->lock);
>> +		return -EFAULT;
>> +	}
>> +	mutex_unlock(&data->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int xr_set_rs485_config(struct tty_struct *tty,
>> +			       struct serial_rs485 *argp)
> missing __user
>
>> +{
>> +	struct usb_serial_port *port = tty->driver_data;
>> +	struct xr_data *data = usb_get_serial_port_data(port);
>> +	struct serial_rs485 rs485;
>> +
>> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
>> +		return -EFAULT;
>> +	xr_sanitize_serial_rs485(&rs485);
>> +
>> +	mutex_lock(&data->lock);
> Same here as set_termios() (and xr_set_flow_mode()) can otherwise be
> called in parallel.


I'll change these to "down_write(&tty->termios_rwsem);" and 
"up_write(&tty->termios_rwsem);"


>> +	data->rs485 = rs485;
>> +	xr_set_flow_mode(tty, port, NULL);
>> +	mutex_unlock(&data->lock);
>> +
>> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
> Looks good otherwise.
>
> Johan

      - Jarkko

