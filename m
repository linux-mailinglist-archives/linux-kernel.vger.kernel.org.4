Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F08629EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKOQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKOQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:21:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1210C3;
        Tue, 15 Nov 2022 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668529266; x=1700065266;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JfTC8m8Q4FYXgVJlchjlzdhxCWxzzUXbMBu2VN/q2cQ=;
  b=RRpAxpfTNlmRBFrlJWhrUdM2JgkQPCYFnbgweo7uLuH7sbgNi3p5Zg10
   r7X9TDCfww/vjztiLDCHmBrbOofBlWVYc/RfIAB1WP0YXd/HNaYcQP3Up
   scDNb5DdgsKzbcP7xXeWspyiv2QsGWoqRCgIphIph/NeWaKOohaamH9GB
   QlNBUhKpCknloqIT4/Sq2zR7bmbhNVDAt5yBaN4km8OLE0UtQZMBY8A29
   nwCHL3tLiYMKrisqY6+hyGekQEcdauavWRocRhymuGsVe6vEsuQKuXhgV
   QSR50bLFiOEXfijXCY9QcpIk5RvddnlE0kJSPcjYfueSJ056rrRpl5hlH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398584148"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="398584148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:21:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707791440"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="707791440"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:21:01 -0800
Date:   Tue, 15 Nov 2022 18:21:00 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 12/14] serial: liteuart: add IRQ support for the RX
 path
In-Reply-To: <Y3O7AKVuY3/n6I5K@errol.ini.cmu.edu>
Message-ID: <7b5042be-8061-d4f4-43b5-75a5ad6dbcb0@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-13-gsomlo@gmail.com> <a914ebd3-5eb8-6c53-3f58-3371fdabf7@linux.intel.com> <Y3O7AKVuY3/n6I5K@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-155084183-1668529265=:2268"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-155084183-1668529265=:2268
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:

> On Tue, Nov 15, 2022 at 06:00:11PM +0200, Ilpo Järvinen wrote:
> > On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> > 
> > > Add support for IRQ-driven RX. Support for the TX path will be added
> > > in a separate commit.
> > > 
> > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > ---
> > >  drivers/tty/serial/liteuart.c | 61 +++++++++++++++++++++++++++++++----
> > >  1 file changed, 54 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > index cf1ce597b45e..e30adb30277f 100644
> > > --- a/drivers/tty/serial/liteuart.c
> > > +++ b/drivers/tty/serial/liteuart.c
> > > @@ -6,6 +6,7 @@
> > >   */
> > >  
> > >  #include <linux/console.h>
> > > +#include <linux/interrupt.h>
> > >  #include <linux/litex.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > @@ -130,13 +131,29 @@ static void liteuart_rx_chars(struct uart_port *port)
> > >  	tty_flip_buffer_push(&port->state->port);
> > >  }
> > >  
> > > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > > +{
> > > +	struct liteuart_port *uart = data;
> > > +	struct uart_port *port = &uart->port;
> > > +	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
> > > +
> > > +	/* for now, only rx path triggers interrupts */
> > 
> > Please don't add comment like this at all when your series removes it in a 
> > later patch.
> 
> OK, I will remove it in v4.
> 
> > > +	isr &= EV_RX;
> > > +
> > > +	spin_lock(&port->lock);
> > > +	if (isr & EV_RX)
> > > +		liteuart_rx_chars(port);
> > > +	spin_unlock(&port->lock);
> > > +
> > > +	return IRQ_RETVAL(isr);
> > > +}
> > > +
> > >  static void liteuart_timer(struct timer_list *t)
> > >  {
> > >  	struct liteuart_port *uart = from_timer(uart, t, timer);
> > >  	struct uart_port *port = &uart->port;
> > >  
> > > -	liteuart_rx_chars(port);
> > > -
> > > +	liteuart_interrupt(0, port);
> > >  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > >  }
> > >  
> > > @@ -162,19 +179,42 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
> > >  static int liteuart_startup(struct uart_port *port)
> > >  {
> > >  	struct liteuart_port *uart = to_liteuart_port(port);
> > > +	int ret;
> > > +	u8 irq_mask = 0;
> > >  
> > > -	/* disable events */
> > > -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > > +	if (port->irq) {
> > > +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> > > +				  KBUILD_MODNAME, uart);
> > > +		if (ret == 0) {
> > > +			/* only enable rx interrupts at this time */
> > 
> > This comment seems pretty useless. Your code says very much the same.
> 
> The comment was meant to let the reader know that the code is doing it
> *intentionally* (rather than forgetting to enable tx irqs by mistake).
> But I'm OK with removing this comment in v4 as well if you think
> that's an overly paranoid and redundant thing to do... :)

I see. Reading the other comment first caused me to misinterpret this one 
to mean that only RX interrupts are implemented.

Maybe if you change "at this time" to "at startup" it would make it more 
obvious.

-- 
 i.

--8323329-155084183-1668529265=:2268--
