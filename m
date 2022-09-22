Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0BA5E65BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiIVOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiIVOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:33:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0BF5099;
        Thu, 22 Sep 2022 07:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 841E1B837D2;
        Thu, 22 Sep 2022 14:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6D5C433C1;
        Thu, 22 Sep 2022 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663857228;
        bh=sqCQwtDVxfkOzLY4nfTpRMTNCFqteOOYmhW/5ec8LJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sz5zKyo5DHM0u8L95KThgscgfTQnjeJzTdglMX22Oi91oMQIBf9f9a9yubR8iqW4+
         X/dYMsw7T1UUMKADgJGBtEs7yQ9fvlMTgwojkrVdBqbR4/dUs6Ur4gtbiwB++BRrx/
         YKAjna9JJkBBqvMZewaiOjs87zsM0o8VuXVsPmzo=
Date:   Thu, 22 Sep 2022 16:33:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
Message-ID: <YyxySWYgJ7ceavcM@kroah.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
 <Yyxs8o7tB6BVS0Kt@kroah.com>
 <1ae6a32c-9f3d-ee56-a26a-7a90b4ee2bfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ae6a32c-9f3d-ee56-a26a-7a90b4ee2bfe@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:24:55PM +0300, Ilpo Järvinen wrote:
> On Thu, 22 Sep 2022, Greg Kroah-Hartman wrote:
> 
> > On Fri, Sep 09, 2022 at 12:11:02PM +0300, Andy Shevchenko wrote:
> > > uart_xmit_advance() provides a common way on how to advance
> > > the Tx queue. Use it for the sake of unification and robustness.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_dma.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> > > index d99020fd3427..b85c82616e8c 100644
> > > --- a/drivers/tty/serial/8250/8250_dma.c
> > > +++ b/drivers/tty/serial/8250/8250_dma.c
> > > @@ -26,9 +26,7 @@ static void __dma_tx_complete(void *param)
> > >  
> > >  	dma->tx_running = 0;
> > >  
> > > -	xmit->tail += dma->tx_size;
> > > -	xmit->tail &= UART_XMIT_SIZE - 1;
> > > -	p->port.icount.tx += dma->tx_size;
> > > +	uart_xmit_advance(&p->port, dma->tx_size);
> > >  
> > >  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > >  		uart_write_wakeup(&p->port);
> > > -- 
> > > 2.35.1
> > > 
> > 
> > Breaks the build :(
> 
> I'd guess it's because uart_xmit_advance() is current only in tty-linus, 
> not in tty-next.

Probably, can someone resend this when 6.1-rc1 is out?

thanks,

greg k-h
