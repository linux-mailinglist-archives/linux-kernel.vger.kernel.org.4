Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047DE638B44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKYNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKYNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:34:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667D27930;
        Fri, 25 Nov 2022 05:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD99EB82A90;
        Fri, 25 Nov 2022 13:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2D8C433C1;
        Fri, 25 Nov 2022 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669383269;
        bh=acYtzPDXmpD5qckKvnQn14k+w7AIZCKOH5FG/qBeLDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeHwXvHTRH+dc9G5PQK6O018DhzyXfGm5RI36YyFOAMam94civyquKJqSnL3xUBKR
         4gf7KuaBTR2zjtqR4l3Rjs8QHLMwEcQ/RxTZ0YQLKXcvu1Oh3SX8yCzDhO+2gdULfN
         LiOSOrSa13i0xrq62DqvEt4mmxkUEbaZawjOuCyqNm7pL2c5Lt7VTWcDpm4LELAiCu
         J1PsgL20iesjyi+OAWdL5HkvipnCb8YbxbQywtj3/J4/tz19BH6URwXX/cw8S3KhDd
         lCCwGcf+ObZqDMJCNslO8FXOAjg1XPAiuK/fD2DKRSiNS2ZXtRv2vNRoob7ni0MhY/
         r1TetBsPM6rJg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyYqC-0004jP-Ps; Fri, 25 Nov 2022 14:34:04 +0100
Date:   Fri, 25 Nov 2022 14:34:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usb: serial: add support for CH348
Message-ID: <Y4DETJvl12YfnMxF@hovoldconsulting.com>
References: <20221114073736.672194-1-clabbe@baylibre.com>
 <20221114073736.672194-2-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114073736.672194-2-clabbe@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:37:35AM +0000, Corentin Labbe wrote:
> The CH348 is an USB octo port serial adapter.

Please add some more details on the endpoints are used etc. Perhaps
mention some of the magic you've incorporated from the vendor driver
(with a link?).

> This patch adds support for it.

No need for this bit.

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/usb/serial/Kconfig  |   9 +
>  drivers/usb/serial/Makefile |   1 +
>  drivers/usb/serial/ch348.c  | 739 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 749 insertions(+)
>  create mode 100644 drivers/usb/serial/ch348.c
> 
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index ef8d1c73c754..1e1842656b54 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -112,6 +112,15 @@ config USB_SERIAL_CH341
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ch341.
>  
> +config USB_SERIAL_CH348
> +	tristate "USB Winchiphead CH348 Octo Port Serial Driver"
> +	help
> +	  Say Y here if you want to use a Winchiphead CH348 octo port
> +	  USB to serial adapter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ch348.
> +
>  config USB_SERIAL_WHITEHEAT
>  	tristate "USB ConnectTech WhiteHEAT Serial Driver"
>  	select USB_EZUSB_FX2
> diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> index c7bb1a88173e..d16ff59fde68 100644
> --- a/drivers/usb/serial/Makefile
> +++ b/drivers/usb/serial/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_USB_SERIAL_AIRCABLE)		+= aircable.o
>  obj-$(CONFIG_USB_SERIAL_ARK3116)		+= ark3116.o
>  obj-$(CONFIG_USB_SERIAL_BELKIN)			+= belkin_sa.o
>  obj-$(CONFIG_USB_SERIAL_CH341)			+= ch341.o
> +obj-$(CONFIG_USB_SERIAL_CH348)			+= ch348.o
>  obj-$(CONFIG_USB_SERIAL_CP210X)			+= cp210x.o
>  obj-$(CONFIG_USB_SERIAL_CYBERJACK)		+= cyberjack.o
>  obj-$(CONFIG_USB_SERIAL_CYPRESS_M8)		+= cypress_m8.o
> diff --git a/drivers/usb/serial/ch348.c b/drivers/usb/serial/ch348.c
> new file mode 100644
> index 000000000000..eb3d7d62f799
> --- /dev/null
> +++ b/drivers/usb/serial/ch348.c
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB serial driver for USB to Octal UARTs chip ch348.
> + *
> + * Copyright (C) 2022 Corentin Labbe <clabbe@baylibre.com>
> + * With the help of Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serial.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +
> +#define DEFAULT_BAUD_RATE 9600
> +#define DEFAULT_TIMEOUT   2000
> +
> +#define CH348_CTO_D	0x01
> +#define CH348_CTO_R	0x02
> +
> +#define CH348_CTI_C	0x10
> +#define CH348_CTI_DSR	0x20
> +#define CH348_CTI_R	0x40
> +#define CH348_CTI_DCD	0x80
> +
> +#define CH348_LO	0x02
> +#define CH348_LP	0x04
> +#define CH348_LF	0x08
> +#define CH348_LB	0x10
> +
> +#define CMD_W_R		0xC0
> +#define CMD_W_BR	0x80
> +
> +#define CMD_WB_E	0x90
> +#define CMD_RB_E	0xC0
> +
> +#define M_NOR		0x00
> +#define M_HF		0x03
> +
> +#define R_MOD		0x97
> +#define R_IO_D		0x98
> +#define R_IO_O		0x99
> +#define R_IO_I		0x9b
> +#define R_TM_O		0x9c
> +#define R_INIT		0xa1
> +
> +#define R_C1		0x01
> +#define R_C2		0x02
> +#define R_C4		0x04
> +#define R_C5		0x06
> +
> +#define R_II_B1		0x06
> +#define R_II_B2		0x02
> +#define R_II_B3		0x00
> +
> +#define CH348_RX_PORT_CHUNK_LENGTH	32
> +#define CH348_RX_PORT_MAX_LENGTH	30
> +
> +struct ch348_rxbuf {
> +	u8 port;
> +	u8 length;
> +	u8 data[CH348_RX_PORT_MAX_LENGTH];
> +} __packed;
> +
> +struct ch348_txbuf {
> +	u8 port;
> +	__le16 length;
> +	u8 data[];
> +} __packed;
> +
> +#define CH348_TX_HDRSIZE offsetof(struct ch348_txbuf, data)
> +
> +struct ch348_initbuf {
> +	u8 cmd;
> +	u8 reg;
> +	u8 port;
> +	__be32 dwDTERate;
> +	u8 bCharFormat;
> +	u8 bParityType;
> +	u8 bDataBits;
> +	u8 rate;
> +	u8 unk;
> +} __packed;
> +
> +#define CH348_MAXPORT 8
> +
> +/*
> + * The CH348 multiplexes rx & tx into a pair of Bulk USB endpoints for
> + * the 8 serial ports, and another pair of Bulk USB endpoints to
> + * set port settings and receive port status events.
> + *
> + * The USB serial cores ties every Bulk endpoints pairs to each ports,
> + * but in our case it will set port 0 with the rx/tx endpoints
> + * and port 1 with the setup/status endpoints.
> + *
> + * To still take advantage of the generic code, we (re-)initialize
> + * the USB serial port structure with the correct USB endpoint
> + * for read and write, and write proper process_read_urb()
> + * and prepare_write_buffer() to correctly (de-)multiplex data.
> + */

Take a look at how this was implemented for mx_uport.c which uses a
similar setup, including commit d69f138747b9 ("USB: serial: mxuport:
clean up port bulk-out setup") which allows to use core to allocate the
resources needed. Each port gets a write fifo and write URBs, while only
the read and status URBs are shared via ports 0 and 1.

mx_uport submits the shared URBs at attach, but this is preferable done
at first open.

> +
> +/* struct ch348_ttyport - per-port information
> + * @uartmode           UART port current mode
> + * @port:              USB Serial Port structure
> + * @io_status:         last reported I/O state
> + * @modem_status:      last reported modem signals state
> + */

Kernel doc starts with /** and you need a newline after the opening
marker (throughout).

> +struct ch348_ttyport {
> +	u8 uartmode;
> +	struct usb_serial_port *port;
> +	unsigned int io_status;
> +	unsigned int modem_status;
> +};
> +
> +/* struct ch348 - main container for all this driver information
> + * @udev:		pointer to the CH348 usb device
> + * @ttyport:		List of per-port information
> + * @rx_endpoint:	endpoint number for read operations
> + * @statusrx_endpoint:	endpoint number for status operations
> + * @cmdtx_endpoint:	endpoint number for configure operations
> + * @status_read_urb:	URB for status
> + * @status_read_buffer:	buffer used by status_read_urb
> + * @status_lock:	control access of io_status/modem_status
> + * @readsize:		packet size for bulk_in
> + * @writesize:		packet size for bulk_out
> + */
> +struct ch348 {
> +	struct usb_device *udev;
> +	struct ch348_ttyport ttyport[CH348_MAXPORT];

This should not be needed. You have pointers to the usb-serial ports in
struct usb_serial.

> +
> +	int rx_endpoint;
> +	int tx_endpoint;
> +	int statusrx_endpoint;
> +	int cmdtx_endpoint;
> +
> +	struct urb *status_read_urb;
> +	u8 *status_read_buffer;
> +
> +	spinlock_t status_lock;
> +	int readsize;
> +	int writesize;
> +};
> +
> +struct ch348_magic {
> +	u8 action;
> +	u8 reg;
> +	u8 control;
> +} __packed;
> +
> +/* Some values came from vendor tree, and we have no meaning for them, this
> + * function simply use them.
> + */
> +static int ch348_do_magic(struct ch348 *ch348, int portnum, u8 action, u8 reg, u8 control)
> +{
> +	int ret = 0, len;
> +	struct ch348_magic *buffer;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	if (portnum < 4)
> +		reg += 0x10 * portnum;
> +	else
> +		reg += 0x10 * (portnum - 4) + 0x08;
> +
> +	buffer->action = action;
> +	buffer->reg = reg;
> +	buffer->control = control;
> +
> +	ret = usb_bulk_msg(ch348->udev, ch348->cmdtx_endpoint, buffer, 3, &len,
> +			   DEFAULT_TIMEOUT);
> +	if (ret)
> +		dev_err(&ch348->udev->dev, "%s usb_bulk_msg err=%d\n", __func__, ret);
> +
> +	kfree(buffer);
> +	return ret;
> +}
> +
> +static int ch348_configure(struct ch348 *ch348, int portnum)
> +{
> +	int ret;
> +
> +	ret = ch348_do_magic(ch348, portnum, CMD_W_R, R_C2, 0x87);
> +	if (ret)
> +		return ret;
> +	ret = ch348_do_magic(ch348, portnum, CMD_W_R, R_C4, 0x08);
> +	return ret;

Here I'd use an explicit error path for symmetry and return 0 on the
success path.

> +}
> +
> +static void ch348_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	u8 *buffer = urb->transfer_buffer, *end;
> +	unsigned int portnum, usblen;
> +	struct ch348_rxbuf *rxb;
> +
> +	if (urb->actual_length < 2) {
> +		dev_warn(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);

Drop the __func__ and __LINE__ from all error messages. But here you
should just return as there's no point in spamming in the logs for
malfunctioning hardware.

> +		return;
> +	}
> +
> +	end = buffer + urb->actual_length;
> +
> +	for (; buffer < end; buffer += CH348_RX_PORT_CHUNK_LENGTH) {
> +		rxb = (struct ch348_rxbuf *)buffer;
> +		portnum = rxb->port;
> +		if (portnum >= CH348_MAXPORT) {
> +			dev_warn(&port->dev, "%s:%d invalid port %d\n",
> +				 __func__, __LINE__, portnum);
> +			break;
> +		}
> +
> +		usblen = rxb->length;
> +		if (usblen > CH348_RX_PORT_MAX_LENGTH) {
> +			dev_warn(&port->dev, "%s:%d invalid length %d for port %d\n",
> +				 __func__, __LINE__, usblen, portnum);
> +			break;
> +		}
> +
> +		port = ch348->ttyport[portnum].port;
> +		tty_insert_flip_string(&port->port, rxb->data, usblen);
> +		tty_flip_buffer_push(&port->port);
> +		port->icount.rx += usblen;
> +		usb_serial_debug_data(&port->dev, __func__, usblen, rxb->data);
> +	}
> +}
> +
> +static int ch348_prepare_write_buffer(struct usb_serial_port *port, void *dest, size_t size)
> +{
> +	struct ch348_txbuf *rxt = dest;
> +	int count;
> +
> +	count = kfifo_out_locked(&port->write_fifo, rxt->data,
> +				 size - CH348_TX_HDRSIZE, &port->lock);
> +
> +	rxt->port = port->port_number;
> +	rxt->length = cpu_to_le16(count);
> +
> +	return count + CH348_TX_HDRSIZE;
> +}
> +
> +static int ch348_set_uartmode(struct ch348 *ch348, int portnum, u8 index, u8 mode)
> +{
> +	int ret = 0;

No need to initialise.

> +
> +	if (ch348->ttyport[portnum].uartmode == M_NOR && mode == M_HF) {
> +		ret = ch348_do_magic(ch348, portnum, CMD_W_BR, R_C4, 0x51);
> +		if (ret)
> +			return ret;
> +		ch348->ttyport[portnum].uartmode = M_HF;
> +	}
> +
> +	if (ch348->ttyport[portnum].uartmode == M_HF && mode == M_NOR) {
> +		ret = ch348_do_magic(ch348, portnum, CMD_W_BR, R_C4, 0x50);
> +		if (ret)
> +			return ret;
> +		ch348->ttyport[portnum].uartmode = M_NOR;
> +	}
> +	return 0;
> +}
> +
> +static void ch348_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
> +			      const struct ktermios *termios_old)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	int portnum = port->port_number;
> +	struct ktermios *termios = &tty->termios;
> +	int ret, sent;
> +	speed_t	dwDTERate;
> +	u8	bCharFormat;

Drop indentation of identifier.

Perhaps drop the camel case and just call these rate and format, it's
clear below how they are used. Ok, maybe not rate that's used for a
different purpose.

> +	struct ch348_initbuf *buffer;
> +
> +	if (termios_old && !tty_termios_hw_change(&tty->termios, termios_old))
> +		return;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer) {
> +		if (termios_old)
> +			tty->termios = *termios_old;
> +		return;
> +	}
> +
> +	dwDTERate = tty_get_baud_rate(tty);
> +	/* test show no success on low baud and datasheet said it is not supported */
> +	if (dwDTERate < 1200)
> +		dwDTERate = DEFAULT_BAUD_RATE;
> +	/* datasheet said it is not supported */
> +	if (dwDTERate > 6000000)
> +		dwDTERate = 6000000;
> +
> +	bCharFormat = termios->c_cflag & CSTOPB ? 2 : 1;
> +
> +	buffer->bParityType = termios->c_cflag & PARENB ?
> +			     (termios->c_cflag & PARODD ? 1 : 2) +
> +			     (termios->c_cflag & CMSPAR ? 2 : 0) : 0;

I know we have this elsewhere, but please just spell it out using nested
conditionals (not ternary ?:) so that is it obvious what is going on.

> +
> +	switch (termios->c_cflag & CSIZE) {

Use C_CSIZE(tty) and friends.

> +	case CS5:
> +		buffer->bDataBits = 5;
> +		break;
> +	case CS6:
> +		buffer->bDataBits = 6;
> +		break;
> +	case CS7:
> +		buffer->bDataBits = 7;
> +		break;
> +	case CS8:
> +	default:
> +		buffer->bDataBits = 8;
> +		break;
> +	}
> +	buffer->cmd = CMD_WB_E | (portnum & 0x0F);
> +	buffer->reg = R_INIT;
> +	buffer->port = portnum;
> +	buffer->dwDTERate = cpu_to_be32(dwDTERate);
> +	if (bCharFormat == 2)
> +		buffer->bCharFormat = 0x02;
> +	else if (bCharFormat == 1)
> +		buffer->bCharFormat = 0x00;
> +	buffer->rate = max_t(speed_t, 5, DIV_ROUND_CLOSEST(10000 * 15, dwDTERate));

Some newlines (e.g. here) should improve readability.

> +	ret = usb_bulk_msg(ch348->udev, ch348->cmdtx_endpoint, buffer,
> +			   sizeof(*buffer), &sent, DEFAULT_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&ch348->udev->dev, "%s usb_bulk_msg err=%d\n",
> +			__func__, ret);

Use a message like 

	"failed to change line settings: %d\n"

> +		goto out;
> +	}
> +
> +	ret = ch348_do_magic(ch348, portnum, CMD_W_R, R_C1, 0x0F);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (C_CRTSCTS(tty))
> +		ret = ch348_set_uartmode(ch348, portnum, portnum, M_HF);
> +	else
> +		ret = ch348_set_uartmode(ch348, portnum, portnum, M_NOR);
> +
> +out:
> +	kfree(buffer);
> +}
> +
> +static int ch348_open(struct tty_struct *tty, struct usb_serial_port *port)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	int rv;

Use 'ret' consistently.

> +
> +	if (tty)
> +		ch348_set_termios(tty, port, NULL);
> +
> +	rv = ch348_configure(ch348, port->port_number);
> +	if (rv)
> +		pr_err("%s configure err\n", __func__);
> +
> +	rv = usb_serial_generic_open(tty, port);
> +
> +	return rv;

Either add an explicit error path or

	return usb_serial_generic_open(tty, port);

> +}

[...]

> +static void ch348_update_status(struct ch348 *ch348, u8 *data, unsigned int len)
> +{
> +	u8 *end = data + len;
> +	unsigned int portnum, reg;
> +
> +	for (; data < end; ) {
> +		portnum = data[0] & 0xf;
> +		reg = data[1];

This looks broken, what if len is 1? Similar below.

> +
> +		if (reg == R_INIT) {
> +			data += sizeof(struct ch348_initbuf);
> +			continue;
> +		}
> +
> +		if (reg >= R_MOD && reg <= R_IO_I) {
> +			/* This signal is used by vendor driver to handle GPIO Interrupts */
> +			dev_dbg(&ch348->udev->dev, "port%d: unhandled status %02x%02x\n",
> +				portnum, data[2], data[3]);
> +			data += 4;
> +			continue;
> +		}
> +
> +		if ((reg & 0xf) == R_II_B1) {
> +			dev_dbg(&ch348->udev->dev, "port%d: uart io state %02x\n",
> +				portnum, data[2]);
> +			ch348_update_io_status(ch348, portnum, data[2]);
> +			data += 3;
> +			continue;
> +		}
> +
> +		if ((reg & 0xf) == R_II_B2) {
> +			/* This signal is used by vendor driver to aggregate multiple port TX */
> +			dev_dbg(&ch348->udev->dev,
> +				"port%d: unhandled Write Empty status\n", portnum);
> +			data += 3;
> +			continue;
> +		}
> +
> +		if ((reg & 0xf) == R_II_B3) {
> +			dev_dbg(&ch348->udev->dev, "port%d: modem status %02x\n", portnum, data[2]);
> +			ch348_update_modem_status(ch348, portnum, data[2]);
> +			data += 3;
> +			continue;
> +		}
> +
> +		dev_dbg(&ch348->udev->dev, "port%d: unknown status %02x\n", portnum, reg);
> +		data += 3;
> +	}
> +}
> +
> +static void ch348_status_read_bulk_callback(struct urb *urb)
> +{
> +	struct ch348 *ch348 = urb->context;
> +	u8 *data = urb->transfer_buffer;
> +	unsigned int len = urb->actual_length;
> +	int ret;
> +
> +	switch (urb->status) {
> +	case 0:
> +		/* success */
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		/* this urb is terminated, clean up */
> +		dev_dbg(&ch348->udev->dev, "%s - urb shutting down: %d\n",
> +			__func__, urb->status);
> +		return;
> +	default:
> +		dev_dbg(&ch348->udev->dev, "%s - nonzero urb status: %d\n",
> +			__func__, urb->status);
> +		goto exit;
> +	}
> +
> +	usb_serial_debug_data(&ch348->udev->dev, __func__, len, data);
> +	ch348_update_status(ch348, data, len);
> +
> +exit:
> +	ret = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (ret) {
> +		dev_err(&ch348->udev->dev, "%s - usb_submit_urb failed: %d\n",

Spell out "failed to submit status urb: %d\n" (and similar elsewhere).

> +			__func__, ret);
> +	}
> +}
> +
> +static int ch348_allocate_status_read(struct ch348 *ch348, struct usb_endpoint_descriptor *epd)
> +{
> +	int buffer_size = usb_endpoint_maxp(epd);
> +
> +	ch348->status_read_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!ch348->status_read_urb)
> +		return -ENOMEM;
> +	ch348->status_read_buffer = kmalloc(buffer_size, GFP_KERNEL);

This buffer is not freed anywhere.

> +	if (!ch348->status_read_buffer) {
> +		usb_free_urb(ch348->status_read_urb);
> +		return -ENOMEM;
> +	}
> +
> +	usb_fill_bulk_urb(ch348->status_read_urb, ch348->udev,
> +			  ch348->statusrx_endpoint, ch348->status_read_buffer,
> +			  buffer_size, ch348_status_read_bulk_callback, ch348);
> +
> +	return 0;
> +}
> +
> +static void ch348_release(struct usb_serial *serial)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +
> +	usb_kill_urb(ch348->status_read_urb);
> +	usb_free_urb(ch348->status_read_urb);
> +}
> +
> +static int ch348_probe(struct usb_serial *serial, const struct usb_device_id *id)
> +{
> +	struct usb_interface *intf;
> +	struct usb_endpoint_descriptor *epcmdwrite = NULL;
> +	struct usb_endpoint_descriptor *epstatusread = NULL;
> +	struct usb_endpoint_descriptor *epread = NULL;
> +	struct usb_endpoint_descriptor *epwrite = NULL;
> +	struct usb_device *usb_dev = serial->dev;
> +	struct ch348 *ch348;
> +	int ret;
> +
> +	intf = usb_ifnum_to_if(usb_dev, 0);
> +
> +	ret = usb_find_common_endpoints(intf->cur_altsetting, &epread, &epwrite,
> +					NULL, NULL);
> +	if (ret) {
> +		dev_err(&serial->dev->dev, "ERROR: failed to find basic endpoints ret=%d\n", ret);
> +		return ret;
> +	}
> +	epstatusread = &intf->cur_altsetting->endpoint[2].desc;
> +	epcmdwrite = &intf->cur_altsetting->endpoint[3].desc;
> +
> +	if (!usb_endpoint_is_bulk_in(epstatusread)) {
> +		dev_err(&serial->dev->dev, "ERROR: missing second bulk in\n");
> +		return -EINVAL;
> +	}
> +	if (!usb_endpoint_is_bulk_out(epcmdwrite)) {
> +		dev_err(&serial->dev->dev, "ERROR: missing second bulk out\n");
> +		return -EINVAL;
> +	}

The above should not be needed (cf. mx_uport).

> +
> +	ch348 = devm_kzalloc(&serial->dev->dev, sizeof(*ch348), GFP_KERNEL);
> +	if (!ch348)
> +		return -ENOMEM;
> +
> +	usb_set_serial_data(serial, ch348);
> +
> +	ch348->readsize = usb_endpoint_maxp(epread);
> +	ch348->writesize = usb_endpoint_maxp(epwrite);
> +	ch348->udev = serial->dev;
> +
> +	spin_lock_init(&ch348->status_lock);
> +
> +	ch348->rx_endpoint = usb_rcvbulkpipe(usb_dev, epread->bEndpointAddress);
> +	ch348->tx_endpoint = usb_sndbulkpipe(usb_dev, epwrite->bEndpointAddress);
> +	ch348->cmdtx_endpoint = usb_sndbulkpipe(usb_dev, epcmdwrite->bEndpointAddress);
> +	ch348->statusrx_endpoint = usb_rcvbulkpipe(usb_dev, epstatusread->bEndpointAddress);
> +
> +	ret = ch348_allocate_status_read(ch348, epstatusread);
> +	if (ret)
> +		return ret;

Neither should this.

> +	return 0;
> +}
> +
> +static int ch348_port_probe(struct usb_serial_port *port)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +
> +	ch348->ttyport[port->port_number].port = port;

Or this.

> +
> +	return 0;
> +}

Johan
