Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCA62A062
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiKORak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiKORab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:30:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B49727CC3;
        Tue, 15 Nov 2022 09:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668533431; x=1700069431;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=v/gXZgAkBDWLR52/dCOevLzgqKOuZMBAd/MdsAF6coQ=;
  b=WDb6xThU/P7QfqYmuGiyt3Cpm61RWhUyMK4kQaai0n9WkxUWij0dUDB9
   ZXNOJ/6Imr1Uc/W9hwoOXRUjB3CjMlZovS1taCS2MCYwqaTSfv9tXDPFS
   kycZFX14gLNw7GjZ/QMv9Z/Vm2OL+UbOE4PuLMmJ3/27rm38NuGzXEeX8
   MAvnXBQaqQD62vhwe0tqCc0E9r2AB7y8RwEgJ8OBYafHL7ixYC89ytLTI
   7RT3sWu0sG2SET09Np7YCiyRNPgJz8hfhGS7V66qTYegHTGrXKP0na7N4
   BEda+DBq5ZgPLWD4fHy2+TPJvNFpmliYTZg4vakjFfMGRfocBLPXqdtu/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="309943770"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="309943770"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:30:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="639025728"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="639025728"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:30:26 -0800
Date:   Tue, 15 Nov 2022 19:30:09 +0200 (EET)
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
In-Reply-To: <Y3PI0gP0vnmYTmZK@errol.ini.cmu.edu>
Message-ID: <281fcd2-157e-c9ce-a0e5-b077ed43887a@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-14-gsomlo@gmail.com> <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com> <Y3PI0gP0vnmYTmZK@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1451186594-1668533231=:63372"
Content-ID: <253696f8-4b14-c119-b4a6-c92b93cb4d@linux.intel.com>
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

--8323329-1451186594-1668533231=:63372
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <5acca97e-6fac-d1fc-15b5-de58d993f3fe@linux.intel.com>

On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:

> On Tue, Nov 15, 2022 at 06:14:50PM +0200, Ilpo Järvinen wrote:
> > On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> > 
> > > Modify the TX path to operate in an IRQ-compatible way, while
> > > maintaining support for polling mode via the poll timer.
> > > 
> > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > ---
> > >  drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
> > >  1 file changed, 47 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > index e30adb30277f..307c27398e30 100644
> > > --- a/drivers/tty/serial/liteuart.c
> > > +++ b/drivers/tty/serial/liteuart.c

> > > +	if (port->irq) {
> > > +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> > > +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> > 
> > If you put irq_mask into liteuart_port you wouldn't need to read it 
> > back here?
> 
> So, instead of `bool poll_tx_started` I should just keep a copy of the
> irq_mask there, and take `&port->lock` whenever I need to *both* update
> the mask *and* write it out to the actual device register?

I was mostly thinking of storing EV_RX there but then it could be derived 
from port->irq that is checked by all paths already.

> > > +	if (unlikely(port->x_char)) {
> > > +		litex_write8(port->membase + OFF_RXTX, port->x_char);
> > > +		port->x_char = 0;
> > > +		port->icount.tx++;
> > > +		return;
> > > +	}
> > > +
> > > +	while (!litex_read8(port->membase + OFF_TXFULL)) {
> > > +		if (xmit->head == xmit->tail)
> > 
> > There exists a helper for this condition.
> 
> Is that in the released linus tree, or still only in tty-next?

uart_circ_empty() has been around for ages.

> > > +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > > +		uart_write_wakeup(port);
> > > +
> > > +	if (uart_circ_empty(xmit))
> > > +		liteuart_stop_tx(port);
> > > +}
> > 
> > You might want to check if you can generate this whole function with 
> > Jiri's tx helpers (IIRC, they're only in tty-next tree currently).
> 
> Looks like I should switch to tty-next for this whole series, which
> makes sense, since it's a tty I'm working on :)
> 
> I'll rebase on top of that before I send out v4, hopefully later this
> afternoon.

Ok.

As I now looked it up, Jiri's tx helpers is 
8275b48b278096edc1e3ea5aa9cf946a10022f79 and you'll find some example 
conversions in the changes following it.


-- 
 i.
--8323329-1451186594-1668533231=:63372--
