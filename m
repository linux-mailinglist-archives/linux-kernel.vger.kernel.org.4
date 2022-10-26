Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F9660DC63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiJZHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiJZHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:44:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD00A6C37
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:44:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id jb18so6202858wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxYf73s3xgQHPjgaJYLNKSY52juiOV4Io/j3A3VHpOo=;
        b=3zBDOL8ngYX81xMqmYHR2Y8U5YqvhX91VmGX/0Cc7C4k78kwO8H5DsPkwQ2cvlpPnR
         VF3Be2kaJUfyOy+2S8jZUc0MiHFhRWvs2VPz35OKXL85wp6MNNuEdrWh/jBzBr8YBn9P
         /wBY9fTlZoR3l3/yUbtIWdqB2HIHKB8pGbnqGedKTE6/wfVuaKF3a+DlUoHsY4b6L4rP
         QnbmCGyEUxPg7gx9SV5Y7WX21OvP+SD8p9Du/HvZzfVS8bEcMn1OqLDUZsm/KSgD0dTk
         h1HPn23et+PuYwbhnAbPIUdcABVpO/pPBd/PqXbBuwIN6pIJ/1z60urN9SNOBIA/nE9d
         Q27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxYf73s3xgQHPjgaJYLNKSY52juiOV4Io/j3A3VHpOo=;
        b=DStxbEdHS7OO3ZJk08Sv+eT8NSronm7HaxO5H0YGixS7p8unXxItCQlN8lxJTn52C0
         ijqNe3/021bxXY7XBtfkgviG6imuRmvUdC1y/WfKGHzZdumyuTyMZ+zPfSX8GZMSxGz1
         AAPni8OJuuSuwMyAQeo7tY4iXotfJyayrSFEHC18GrygJLrxw1W3s9zvIvP5kkZ1sr6s
         iShliC0KKT4oYoEn3630G+TT27RQDYYSXevvpxxah9fKfI2ptqHnafmqtMyXFfeilInz
         qBqUE3YxNClOh5oSCrt7Y2t7Q+Gub1de98BEkw/CILvAQwCJ+I9sncVa8h+RXdoIKECO
         /vSw==
X-Gm-Message-State: ACrzQf0PQb1ujPicO0d5n/ud2zLsMXgFMl8EPFTUmlmDnG4RWJyGqtg/
        jXaNBaeOyO87etrww8020tRqHA==
X-Google-Smtp-Source: AMsMyM7enZgJ7JHsGNavIYiIobSpf4ullddfFCTFv9Fn5InagRsjwMG3s6O2gxEA2IUmelma2CHAYQ==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr1397660wmq.189.1666770254441;
        Wed, 26 Oct 2022 00:44:14 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id i7-20020a5d4387000000b002366e8eee11sm4500955wrq.101.2022.10.26.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 00:44:14 -0700 (PDT)
Date:   Wed, 26 Oct 2022 09:44:12 +0200
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] usb: serial: add support for CH348
Message-ID: <Y1jlTP7HuH1FQbpk@Red>
References: <20221021133758.1881904-1-clabbe@baylibre.com>
 <20221021133758.1881904-2-clabbe@baylibre.com>
 <135c51e3-56b6-cdf0-3499-cd354f43601d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <135c51e3-56b6-cdf0-3499-cd354f43601d@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Oct 24, 2022 at 11:40:16AM +0200, Oliver Neukum a écrit :
> 
> 
> On 21.10.22 15:37, Corentin Labbe wrote:
> > The CH348 is an USB octo port serial adapter.
> > This patch adds support for it.
> > 
> 
> Hi,
> 
> comments inline.
> 
> > +struct ch348_rxbuf {
> > +	u8 port;
> > +	u8 length;
> > +	u8 data[];
> > +} __packed;
> > +
> > +#define CH348_RX_PORT_CHUNK_LENGTH	32
> > +#define CH348_RX_PORT_MAX_LENGTH	30
> > +
> > +struct ch348_txbuf {
> > +	u8 port;
> > +	__le16 length;
> > +	u8 data[];
> > +} __packed;
> > +
> 
> You know how long data will be. Why leave it unspecified?
> 
> > +static void ch348_process_read_urb(struct urb *urb)
> > +{
> > +	struct usb_serial_port *port = urb->context;
> > +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> > +	u8 *buffer = urb->transfer_buffer, *end;
> > +	unsigned int portnum, usblen;
> > +	struct ch348_rxbuf *rxb;
> > +
> > +	if (!urb->actual_length) {
> 
> That check needs to be for < 2 or you can process garbage.
> 
> > +		dev_warn(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);
> > +		return;
> > +	}
> > +
> > +	end = buffer + urb->actual_length;
> > +
> > +	for (; buffer < end; buffer += CH348_RX_PORT_CHUNK_LENGTH) {
> > +		rxb = (struct ch348_rxbuf *)buffer;
> > +		portnum = rxb->port;
> > +		if (portnum >= CH348_MAXPORT) {
> > +			dev_warn(&port->dev, "%s:%d invalid port %d\n",
> > +				 __func__, __LINE__, portnum);
> > +			break;
> > +		}
> > +
> > +		usblen = rxb->length;
> > +		if (usblen > 30) {
> 
> You have defined a nummerical constant for that. Use it.
> 
> > +			dev_warn(&port->dev, "%s:%d invalid length %d for port %d\n",
> > +				 __func__, __LINE__, usblen, portnum);
> > +			break;
> > +		}
> > +
> > +		port = ch348->ttyport[portnum].port;
> > +		tty_insert_flip_string(&port->port, rxb->data, usblen);
> > +		tty_flip_buffer_push(&port->port);
> > +		port->icount.rx += usblen;
> > +		usb_serial_debug_data(&port->dev, __func__, usblen, rxb->data);
> > +	}
> > +}
> > +
> > +static int ch348_prepare_write_buffer(struct usb_serial_port *port, void *dest, size_t size)
> > +{
> > +	struct ch348_txbuf *rxt = dest;
> > +	const size_t txhdrsize = offsetof(struct ch348_txbuf, data);
> 
> What is that? This is a constant.
> 
> > +	int count;
> > +
> > +	count = kfifo_out_locked(&port->write_fifo, rxt->data,
> > +				 size - txhdrsize, &port->lock);
> > +
> > +	rxt->port = port->port_number;
> > +	rxt->length = cpu_to_le16(count);
> > +
> > +	return count + txhdrsize;
> > +}
> 
> > +static void ch348_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
> > +			      const struct ktermios *termios_old)
> > +{
> > +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> > +	int portnum = port->port_number;
> > +	struct ktermios *termios = &tty->termios;
> > +	int ret, sent;
> > +	__le32	dwDTERate;
> 
> OK it is LE.
> 
> > +	u8	bCharFormat;
> > +	struct ch348_initbuf *buffer;
> > +
> > +	if (termios_old && !tty_termios_hw_change(&tty->termios, termios_old))
> > +		return;
> > +
> > +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> > +	if (!buffer) {
> > +		if (termios_old)
> > +			tty->termios = *termios_old;
> > +		return;
> > +	}
> > +
> > +	dwDTERate = tty_get_baud_rate(tty);
> 
> This is speed_t, in other words unsigned int without specified endianness.
> 
> > +	/* test show no success on low baud and datasheet said it is not supported */
> > +	if (dwDTERate < 1200)
> > +		dwDTERate = DEFAULT_BAUD_RATE;
> > +	/* datasheet said it is not supported */
> > +	if (dwDTERate > 6000000)
> > +		dwDTERate = 6000000;
> 
> You are comparing to constants in native endianness.
> 
> > +
> > +	bCharFormat = termios->c_cflag & CSTOPB ? 2 : 1;
> > +
> > +	buffer->bParityType = termios->c_cflag & PARENB ?
> > +			     (termios->c_cflag & PARODD ? 1 : 2) +
> > +			     (termios->c_cflag & CMSPAR ? 2 : 0) : 0;
> > +
> > +	switch (termios->c_cflag & CSIZE) {
> > +	case CS5:
> > +		buffer->bDataBits = 5;
> > +		break;
> > +	case CS6:
> > +		buffer->bDataBits = 6;
> > +		break;
> > +	case CS7:
> > +		buffer->bDataBits = 7;
> > +		break;
> > +	case CS8:
> > +	default:
> > +		buffer->bDataBits = 8;
> > +		break;
> > +	}
> > +	buffer->cmd = CMD_WB_E | (portnum & 0x0F);
> > +	buffer->reg = R_INIT;
> > +	buffer->port = portnum;
> > +	buffer->dwDTERate = cpu_to_be32(le32_to_cpu(dwDTERate));
> 
> So it is native, not LE?
> 

Hello

Thanks for your review, I will fix them all.

> [..]
> 
> > +
> > +static int ch348_fixup_port_bulk_in(struct ch348 *ch348, struct usb_serial_port *port)
> > +{
> > +	int i;
> > +
> > +	/* Already Initialized */
> > +	if (port->bulk_in_size) {
> 
> BTW, shouldn't these be unsigned int?

I dont understand what you mean here.

Regards
