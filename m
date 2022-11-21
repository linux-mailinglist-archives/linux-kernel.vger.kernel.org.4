Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4950B632DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKUU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKUU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:27:41 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83212D1F;
        Mon, 21 Nov 2022 12:27:39 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D0C3F1359;
        Mon, 21 Nov 2022 21:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669062457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dK3d1oQe8X/2pt53oFWkl+Bv7pDERsDly7J5/Bok7U=;
        b=o921CSn/87OErQwPhLw+XZXrl1z/1WIdOI3ijg2y3bWIDdTV6b3Kti9W59jDmL/CZIHcUi
        1SncAISlqzwHnbLTKRWIHDkbdipwYU/XVVzI2J6GLwEcE1PJoQWXSNw0bZeTAILBo7r3Bo
        c2AYqk7zscF44u/utES2ZVTyJDGM8zK420esoS/IP2nMS+24ZYb64rcWV7u8/DArxpKgwN
        PccvGDLnHVjDo5kJrRXcoYh/QOtoo6FQVg1Fs3V5hkKvt3YEgV/vvkAoY4QvPGzdr7RV7t
        S/q33mEGojWVUyNCZMYV9/a4QMh1K6M/fyXHfVkOyuNzTYoIqbbetlAOC6keIQ==
From:   Michael Walle <michael@walle.cc>
To:     jirislaby@kernel.org
Cc:     afaerber@suse.de, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, mani@kernel.org,
        nicolas.ferre@microchip.com, richard.genoud@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, sudeep.holla@arm.com,
        tklauser@distanz.ch, vz@mleia.com
Subject: Re: [PATCH v5 2/3] tty: serial: use uart_port_tx() helper
Date:   Mon, 21 Nov 2022 21:27:24 +0100
Message-Id: <20221121202724.1708460-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221004104927.14361-3-jirislaby@kernel.org>
References: <20221004104927.14361-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

Hi Jiri,

> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index bd07f79a2df9..a6b4d30c5888 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -824,30 +824,14 @@ static void atmel_rx_chars(struct uart_port *port)
>   */
>  static void atmel_tx_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	bool pending;
> +	u8 ch;
>  
> -	if (port->x_char &&
> -	    (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY)) {
> -		atmel_uart_write_char(port, port->x_char);
> -		port->icount.tx++;
> -		port->x_char = 0;
> -	}
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> -		return;
> -
> -	while (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY) {
> -		atmel_uart_write_char(port, xmit->buf[xmit->tail]);
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> -		if (uart_circ_empty(xmit))
> -			break;
> -	}
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> -
> -	if (!uart_circ_empty(xmit)) {
> +	pending = uart_port_tx(port, ch,
> +		atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY,
> +		atmel_uart_write_char(port, ch));
> +	if (pending) {
>  		/* we still have characters to transmit, so we should continue
>  		 * transmitting them when TX is ready, regardless of
>  		 * mode or duplexity

This will break serial output for the userspace on my board
(arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt*dts). The uart_port_tx()
helper will call __port->ops->stop_tx(__port) if uart_circ_chars_pending()
returns 0. But the code above, doesn't do that. In fact, removing the
stop_tx() call in the helper macro, will fix the console output.

Any ideas how to fix that?

-michael
