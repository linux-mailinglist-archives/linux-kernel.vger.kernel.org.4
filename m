Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4A6336AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiKVIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKVIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:09:43 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7E222B8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:09:38 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 73923448;
        Tue, 22 Nov 2022 09:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669104576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkd4VPvTNaSCvJfQbIZ1hMHTBNNEZBeUZNVhbu3MzZ8=;
        b=M4n19YivhAcAJtYlvUJPZzaGd5Si/9f3J7e4jrZdWRApMRGkBLCP6WdT2OEcayRD1dnovU
        Wng0eFEHhPUhE5qHkafkLDNb82BSzwfphg8xGRNF/mEjZV2/0xgiQwcSYBLzMCZ7thAmPP
        Z65oA3r744qvxQNTl/nUs+CfLreIr/hIEmK9yPFJVN9LaDgjtuWQ+PzEzaclzDdAHHsfXU
        crhcEUwS//qDJ2PWw8wjWcIU1tIjJFpaVui0q76FjtTSjy+7hFgMvXnWuXB5cWPUmvcmkn
        8gWhE1UcBqY2A3qQpk0dp5dE9Nzl6G9qrR9h7eA5oyb7KvYpUy1rRVe8POP8XQ==
MIME-Version: 1.0
Date:   Tue, 22 Nov 2022 09:09:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Jiri Slaby <jirislaby@kernel.org>
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
In-Reply-To: <f95ef7b7-cc23-9fed-5d05-1aa66aaeb86a@kernel.org>
References: <20221004104927.14361-3-jirislaby@kernel.org>
 <20221121202724.1708460-1-michael@walle.cc>
 <f95ef7b7-cc23-9fed-5d05-1aa66aaeb86a@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0ef4f1e6d92601a39fe0d1c316506c12@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-11-22 08:02, schrieb Jiri Slaby:
> On 21. 11. 22, 21:27, Michael Walle wrote:
>> This will break serial output for the userspace on my board
>> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt*dts). The 
>> uart_port_tx()
>> helper will call __port->ops->stop_tx(__port) if 
>> uart_circ_chars_pending()
>> returns 0. But the code above, doesn't do that. In fact, removing the
>> stop_tx() call in the helper macro, will fix the console output.
>> 
>> Any ideas how to fix that?
> 
> Hm, so ATMEL_US_TXRDY is removed from tx_done_mask in stop_tx, but not
> added back in start_tx. So the tx interrupt is never handled (the tx
> tasklet is not scheduled to send the queue chars) in
> atmel_handle_transmit().
> 
> Any chance, the below fixes it?
> 
> diff --git a/drivers/tty/serial/atmel_serial.c
> b/drivers/tty/serial/atmel_serial.c
> index 11bf2466390e..395370e0c77b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -596,6 +596,8 @@ static void atmel_start_tx(struct uart_port *port)
>                 /* re-enable PDC transmit */
>                 atmel_uart_writel(port, ATMEL_PDC_PTCR, 
> ATMEL_PDC_TXTEN);
> 
> +       atmel_port->tx_done_mask |= ATMEL_US_TXRDY;
> +
>         /* Enable interrupts */
>         atmel_uart_writel(port, ATMEL_US_IER, 
> atmel_port->tx_done_mask);
> 
> 
> thanks,

Unfortunately, that doesn't help. Btw, some characters are transmitted:


[    6.219356] Key type dns_resolver registered
[    6.223679] Registering SWP/SWPB emulation handler
[    6.247530] Loading compiled-in X.509 certificates
[    6.288467] Freeing unused kernel image (initmem) memory: 1024K
[    6.297789] Run /init as init process
WbSOROSOSOSOSOStarting linuxptp system clock synchronization: O

-michael
