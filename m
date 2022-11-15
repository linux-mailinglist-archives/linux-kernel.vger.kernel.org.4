Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA162A140
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKOSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiKOSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:21:38 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539B2980E;
        Tue, 15 Nov 2022 10:21:37 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x21so10100203qkj.0;
        Tue, 15 Nov 2022 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=38lbvHtM/Sh5K1youCdXU00uQaYmJjr9mutlugnfY2U=;
        b=FDDekQG05EB4iFbBqvrMs4kK02G8tKxIcVGHXR9mcS8Il26xpbzz0iBGWICM0jkdlV
         3rH/pH+DmWSqg96r1wOCbygUisOxhkbIZLhdk2nURTTu4Q88MhSp2Cv75kWXT+op2sdq
         pa2d/no3UyPnsdBoYjN0JQObptNcW2GFjqPaaGrBmcngiPZLMiEPxYC80Ju87hmF2Htx
         GAYlaQwxJeMuCd/RYRqjE10uk1vIEWqhXfXDxja36EGOIyYFy5ykWLMRjeLOX1MbBu/E
         iJYSXBPOt5MoLeB4s7Io1GwKQir4eVBIxjyHB518uDKOOV2L8PHjWUH2Q/tpgi9PmOHn
         NmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38lbvHtM/Sh5K1youCdXU00uQaYmJjr9mutlugnfY2U=;
        b=d1G8HgfHiEVd+sruTXhnhoYUgVwbD91on0nvFl39MvqDC7FLp2lunSlPNcQ6XUPFna
         f+6S55WYsErrjAKahGFG/tleR0hq6zTfsDLcXAHEMfDgu4CORKBOgIRzn4Ka0evyF7G7
         PJbiDZqzq1URTL0i/xy7iQ1byyqT2R7CQWHB8X0Z1mJpH7r92xSicNdQCYH96qwoi57k
         LUy7ebAqB1le9gb1JTQI57CvvflptdxAatyFBO16s5ZzzDsa+cTyNeYNBtUlq5oAqMNs
         UGtxJQXroKRzaD7SsHPApUmSAsx83y40J5dJWNfnK3rmrbd9Nc+ZcbLcKrgB9yNFtS5V
         XgGA==
X-Gm-Message-State: ANoB5pk2JAIbDl1CEs3ATOPWu2R3FvqzuzKRkRsNTnZVDh2SbFqeZlYM
        XBVq7PSF9hCzfkpnwLfV1IA=
X-Google-Smtp-Source: AA0mqf59s8GBbOflxICSmriBe32P8xmvmu5vMXrZk4Y8aPAvbpLIaI+pbjTGa6WLAs7u76eREsV30w==
X-Received: by 2002:a37:b01:0:b0:6ee:9453:9d92 with SMTP id 1-20020a370b01000000b006ee94539d92mr16606911qkl.520.1668536496920;
        Tue, 15 Nov 2022 10:21:36 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a280900b006b95b0a714esm8490461qkp.17.2022.11.15.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:21:36 -0800 (PST)
Date:   Tue, 15 Nov 2022 13:21:34 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX
 path
Message-ID: <Y3PYrsjW7yUMuusO@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-14-gsomlo@gmail.com>
 <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com>
 <Y3PI0gP0vnmYTmZK@errol.ini.cmu.edu>
 <281fcd2-157e-c9ce-a0e5-b077ed43887a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <281fcd2-157e-c9ce-a0e5-b077ed43887a@linux.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 07:30:09PM +0200, Ilpo Järvinen wrote:
> On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:
> 
> > On Tue, Nov 15, 2022 at 06:14:50PM +0200, Ilpo Järvinen wrote:
> > > On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> > > 
> > > > Modify the TX path to operate in an IRQ-compatible way, while
> > > > maintaining support for polling mode via the poll timer.
> > > > 
> > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > > ---
> > > >  drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
> > > >  1 file changed, 47 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > > index e30adb30277f..307c27398e30 100644
> > > > --- a/drivers/tty/serial/liteuart.c
> > > > +++ b/drivers/tty/serial/liteuart.c
> 
> > > > +	if (port->irq) {
> > > > +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> > > > +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> > > 
> > > If you put irq_mask into liteuart_port you wouldn't need to read it 
> > > back here?
> > 
> > So, instead of `bool poll_tx_started` I should just keep a copy of the
> > irq_mask there, and take `&port->lock` whenever I need to *both* update
> > the mask *and* write it out to the actual device register?
> 
> I was mostly thinking of storing EV_RX there but then it could be derived 
> from port->irq that is checked by all paths already.

I'm a bit confused here -- the reason I was reading in irq_mask from
the mmio port and then flipping the EV_TX bit before writing it back
out was to preserve the current value of the EV_RX bit in that
register, whatever it may happen to be at the time. If I shadowed the
entire register value (with both EV_RX and EV_TX bits reflecting their
current value), I could get away with only ever *writing* the MMIO
register each time the shadow register value is modified (one or both
of the bits are flipped), and only when port->irq is non-zero (i.e.,
the shadow register would work for polling-mode also).

I think that's how altera_uart.c is doing it (I've been using that as
a source of inspiration).

I thought that's what you were suggesting earlie, but based on your
response above I'm no longer sure I follow.

> > > > +	if (unlikely(port->x_char)) {
> > > > +		litex_write8(port->membase + OFF_RXTX, port->x_char);
> > > > +		port->x_char = 0;
> > > > +		port->icount.tx++;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	while (!litex_read8(port->membase + OFF_TXFULL)) {
> > > > +		if (xmit->head == xmit->tail)
> > > 
> > > There exists a helper for this condition.
> > 
> > Is that in the released linus tree, or still only in tty-next?
> 
> uart_circ_empty() has been around for ages.

Oh, I misunderstood what you meant here originally -- just use
`uart_circ_empty()` like I'm already doing elsewhere in the code, got
it!

> > > > +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > > > +		uart_write_wakeup(port);
> > > > +
> > > > +	if (uart_circ_empty(xmit))
> > > > +		liteuart_stop_tx(port);
> > > > +}
> > > 
> > > You might want to check if you can generate this whole function with 
> > > Jiri's tx helpers (IIRC, they're only in tty-next tree currently).
> > 
> > Looks like I should switch to tty-next for this whole series, which
> > makes sense, since it's a tty I'm working on :)
> > 
> > I'll rebase on top of that before I send out v4, hopefully later this
> > afternoon.
> 
> Ok.
> 
> As I now looked it up, Jiri's tx helpers is 
> 8275b48b278096edc1e3ea5aa9cf946a10022f79 and you'll find some example 
> conversions in the changes following it.

I'll check that out and follow the examples.

Thanks again,
--G
