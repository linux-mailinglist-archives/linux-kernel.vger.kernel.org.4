Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A665BE0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiITIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiITIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:54:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691296B8FA;
        Tue, 20 Sep 2022 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663664059; x=1695200059;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3JHiv1cbPe8ZCd8mmIXB55mW1dRePjWIOPwNMnry1hk=;
  b=LiMjq9up6eA+Dl6DrohfV6nmRHDJrD08V5Sp18PQIO04YDpYyDCqP8Wq
   AsB0rkCiycuVexciCTwXVnxFaX58q/iENr0MVf7yYjB33c55GikFKwbn/
   shuhfOzJXWm7jplRYBHp8zYRkiIHTx2SUOCp8JG6V00YhyJZj7DwRu7Hl
   1D/qSCP2Z6ZUO1TRRMbAf1Ox8tCwGw/krGW5+cQbsWXYP0l4KDz0iW2GE
   uuoxHoI74xAEVTt9XCpjblgg/xbJDkoPwvovEjnGvu4VoFREpntw2AqSZ
   hiU7qT4XdmKP8RbHMCW2MSoe/+Swm5I7ueOc8sCaMvv5vZ6Ztlwug9g4k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297231680"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="297231680"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="687323021"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:54:14 -0700
Date:   Tue, 20 Sep 2022 11:54:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v4 09/10] tty: serial: use uart_port_tx() helper
In-Reply-To: <20220920052049.20507-10-jslaby@suse.cz>
Message-ID: <87251b8a-d955-e6dd-94df-c7621e72bac@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-10-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-407419242-1663660068=:1766"
Content-ID: <df4c474-68d1-debd-b7bb-519782b4b5f4@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-407419242-1663660068=:1766
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <6ec236dd-66a1-72aa-3adc-f63fdc3ee@linux.intel.com>

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> uart_port_tx() is a new helper to send characters to the device. Use it
> in these drivers.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---

> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index b1cd9a76dd93..53b642ea46ba 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
> @@ -327,29 +327,13 @@ static void mcf_rx_chars(struct mcf_uart *pp)
>  static void mcf_tx_chars(struct mcf_uart *pp)
>  {
>  	struct uart_port *port = &pp->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> -
> -	if (port->x_char) {
> -		/* Send special char - probably flow control */
> -		writeb(port->x_char, port->membase + MCFUART_UTB);
> -		port->x_char = 0;
> -		port->icount.tx++;
> -		return;
> -	}
> -
> -	while (readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY) {
> -		if (uart_circ_empty(xmit))
> -			break;
> -		writeb(xmit->buf[xmit->tail], port->membase + MCFUART_UTB);
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE -1);
> -		port->icount.tx++;
> -	}
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> +	unsigned int pending;
> +	u8 ch;
>  
> -	if (uart_circ_empty(xmit)) {
> -		mcf_stop_tx(port);
> +	pending = uart_port_tx(port, ch,
> +		readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY,
> +		writeb(ch, port->membase + MCFUART_UTB));
> +	if (!pending) {

Why unsigned int pending here and bool pending in the other cases?

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.
--8323329-407419242-1663660068=:1766--
