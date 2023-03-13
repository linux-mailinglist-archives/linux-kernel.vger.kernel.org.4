Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040336B85D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCMXEQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 19:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCMXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:04:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21799385B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:03:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-270-dDXYfkCXNfKgBi0MNI-W8g-1; Mon, 13 Mar 2023 23:02:23 +0000
X-MC-Unique: dDXYfkCXNfKgBi0MNI-W8g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 13 Mar
 2023 23:02:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Mon, 13 Mar 2023 23:02:22 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jarkko Sonninen' <kasper@iki.fi>
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Thread-Topic: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Thread-Index: AQHZVYXc9R4nUUIaSE2rrq7+pSxNzK75UfkQ
Date:   Mon, 13 Mar 2023 23:02:22 +0000
Message-ID: <f17e5d7c4ccd4db7a5d5001d7dde42da@AcuMS.aculab.com>
References: <ZA7Wh2Z/DdKOsOYr@kroah.com>
 <20230313082734.886890-1-kasper@iki.fi>
In-Reply-To: <20230313082734.886890-1-kasper@iki.fi>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sonninen
> Sent: 13 March 2023 08:28
> 
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> Gpio mode register is set to enable RS-485.

The locking is entirely dubious.
Summary:

Taking the lock to read the flags is pretty pointless.
You are only looking at one bit and nothing else is tied
to the lock.
Even a READ_ONCE() isn't needed.
> +	spin_lock_irqsave(&data->lock, flags);
> +	rs485_flags = data->rs485.flags;
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	if (rs485_flags & SER_RS485_ENABLED)
> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
> +	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
> +		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
> +

The ioctl read code reads the data unlocked.
> +	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
> +		return -EFAULT;
So could return old and new data if the ioctl write code
runs concurrently (and you get a hardware interrupt or page
fault mid-buffer).

The ioctl write code acquires the lock across a structure copy.
(which should be a structure copy, not a memcpy).
The only way the lock will have any effect is if multiple
threads are doing updates at the same time.
Code doing that won't work anyway.
> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
> +		return -EFAULT;
> +
> +	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
> +	rs485.flags &= SER_RS485_ENABLED;
> +	spin_lock_irqsave(&data->lock, flags);
> +	memcpy(&data->rs485, &rs485, sizeof(rs485));
> +	spin_unlock_irqrestore(&data->lock, flags);

In any case you one seem to be implementing one bit of
the flags - so the rest of the data can be ignored.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

