Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133D62BC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKPLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiKPLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:38:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5DB59FD5;
        Wed, 16 Nov 2022 03:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668598002; x=1700134002;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MYpBpylj8pMY9WIe8XTtpCtT58gvamyc9KojdYzS4oI=;
  b=K8tiPlosuXvW76KrZt1Au+GA876nkeBmhAT3sVZP7MBrDh7ROHftrb5V
   MNUTVTE3hKPSDDGZS3AbwwCyBr6ALwGicWhhLIdlqgO5f4AeUAZPAa3VS
   i7ObN8H3RF61BOoMJs/SNMsH1xkcNHShBENvIeI8tm/TuR1tjRQGMaJ0R
   jvkAfzvQXrcHmKKy9pwtDu21jyIp5SnBm22xstSHEsGYb2A7M9WEEkYDU
   jWmnFUdpTtq0z/1O6w3Dz0tYKn2HmJwph2TdZWNfpYb+YS0jlvvZtjpN/
   l/M1pJRMiwoYEIigqD0STKj/zMiI06FKCapdd2q/Q/3R3MWxq1ztvEDEL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295885321"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295885321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 03:26:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="708131352"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="708131352"
Received: from tkrebs-mobl.ger.corp.intel.com ([10.252.58.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 03:26:39 -0800
Date:   Wed, 16 Nov 2022 13:26:36 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX
 path
In-Reply-To: <Y3Qry3Hza6ydnibL@errol.ini.cmu.edu>
Message-ID: <fa879d4-94a3-ed73-9b5e-edea78a160c8@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-14-gsomlo@gmail.com> <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com> <Y3PI0gP0vnmYTmZK@errol.ini.cmu.edu> <281fcd2-157e-c9ce-a0e5-b077ed43887a@linux.intel.com>
 <Y3Qry3Hza6ydnibL@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1091608436-1668598001=:1688"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1091608436-1668598001=:1688
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:

> On Tue, Nov 15, 2022 at 07:30:09PM +0200, Ilpo Järvinen wrote:
> > On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:
> > 
> > > On Tue, Nov 15, 2022 at 06:14:50PM +0200, Ilpo Järvinen wrote:
> > > > On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> > > > 
> > > > > Modify the TX path to operate in an IRQ-compatible way, while
> > > > > maintaining support for polling mode via the poll timer.
> > > > > 
> > > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > > > ---
> > > > >  drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
> > > > >  1 file changed, 47 insertions(+), 20 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > > > index e30adb30277f..307c27398e30 100644
> > > > > --- a/drivers/tty/serial/liteuart.c
> > > > > +++ b/drivers/tty/serial/liteuart.c
> > 
> > > > > +	if (port->irq) {
> > > > > +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> > > > > +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> > > > 
> > > > If you put irq_mask into liteuart_port you wouldn't need to read it 
> > > > back here?
> > > 
> > > So, instead of `bool poll_tx_started` I should just keep a copy of the
> > > irq_mask there, and take `&port->lock` whenever I need to *both* update
> > > the mask *and* write it out to the actual device register?
> > 
> > I was mostly thinking of storing EV_RX there but then it could be derived 
> > from port->irq that is checked by all paths already.
> 
> So, just to clear up the best course of action here (before I rebase
> everything on top of tty-next: How about the patch below (currently
> applied separately at the end of the entire series, but I can respin
> it as part of the rx path (12/14) and tx path (13/14) as appropriate.
> 
> Let me know what you think.

I'm fine with that I think. I'd change to bits parameter name to something 
more meaningful though, I guess the irq_mask could do ok there.

-- 
 i.

> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index eb0ae8c8bd94..185db423c65f 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -47,7 +47,7 @@ struct liteuart_port {
>  	struct uart_port port;
>  	struct timer_list timer;
>  	u32 id;
> -	bool poll_tx_started;
> +	u8 irq_reg;
>  };
>  
>  #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> @@ -70,26 +70,27 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>  
> +static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 bits)
> +{
> +	struct liteuart_port *uart = to_liteuart_port(port);
> +
> +	if (set)
> +		uart->irq_reg |= bits;
> +	else
> +		uart->irq_reg &= ~bits;
> +
> +	if (port->irq)
> +		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
> +}
> +
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
> -	if (port->irq) {
> -		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> -		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> -	} else {
> -		struct liteuart_port *uart = to_liteuart_port(port);
> -		uart->poll_tx_started = false;
> -	}
> +	liteuart_update_irq_reg(port, false, EV_TX);
>  }
>  
>  static void liteuart_start_tx(struct uart_port *port)
>  {
> -	if (port->irq) {
> -		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> -		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask | EV_TX);
> -	} else {
> -		struct liteuart_port *uart = to_liteuart_port(port);
> -		uart->poll_tx_started = true;
> -	}
> +	liteuart_update_irq_reg(port, true, EV_TX);
>  }
>  
>  static void liteuart_stop_rx(struct uart_port *port)
> @@ -149,12 +150,10 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
>  {
>  	struct liteuart_port *uart = data;
>  	struct uart_port *port = &uart->port;
> -	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
> -
> -	if (!(port->irq || uart->poll_tx_started))
> -		isr &= ~EV_TX;	/* polling mode with tx stopped */
> +	u8 isr;
>  
>  	spin_lock(&port->lock);
> +	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
>  	if (isr & EV_RX)
>  		liteuart_rx_chars(port);
>  	if (isr & EV_TX)
> @@ -195,39 +194,40 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
>  static int liteuart_startup(struct uart_port *port)
>  {
>  	struct liteuart_port *uart = to_liteuart_port(port);
> +	unsigned long flags;
>  	int ret;
> -	u8 irq_mask = 0;
>  
>  	if (port->irq) {
>  		ret = request_irq(port->irq, liteuart_interrupt, 0,
>  				  KBUILD_MODNAME, uart);
> -		if (ret == 0) {
> -			/* only enabling rx interrupts at startup */
> -			irq_mask = EV_RX;
> -		} else {
> +		if (ret) {
>  			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
>  				port->line, port->irq);
>  			port->irq = 0;
>  		}
>  	}
>  
> +	spin_lock_irqsave(&port->lock, flags);
> +	/* only enabling rx irqs during startup */
> +	liteuart_update_irq_reg(port, true, EV_RX);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
>  	if (!port->irq) {
> -		uart->poll_tx_started = false;
>  		timer_setup(&uart->timer, liteuart_timer, 0);
>  		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  	}
>  
> -	litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
> -
>  	return 0;
>  }
>  
>  static void liteuart_shutdown(struct uart_port *port)
>  {
>  	struct liteuart_port *uart = to_liteuart_port(port);
> +	unsigned long flags;
>  
> -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> -	uart->poll_tx_started = false;
> +	spin_lock_irqsave(&port->lock, flags);
> +	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  
>  	if (port->irq)
>  		free_irq(port->irq, port);
> 

--8323329-1091608436-1668598001=:1688--
