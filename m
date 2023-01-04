Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EE65CE41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjADI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjADI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:28:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967F186CC;
        Wed,  4 Jan 2023 00:28:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA0B7615C3;
        Wed,  4 Jan 2023 08:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9058C433EF;
        Wed,  4 Jan 2023 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672820896;
        bh=AJFMrKxnl4eUbyyWptRKXOFJIxojbdYw+u9qBEVdUYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrihKAEdmgJjdnSdToPubNpXoq+SgITHs9Q3VoE3EfHYEnOycNp5EQPTE2O0P4Qoo
         OQz8vGvvpExcVVakdOutHyJzDgL36UXQVCYhwJnsOtB+qbaz8Fa8EzK4QzFSCkQiag
         lw41t3MPXYkToOPPIZTK8o80QgiLq6ugst8uTAws=
Date:   Wed, 4 Jan 2023 09:28:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Message-ID: <Y7U4ncG4Gkd5uRsb@kroah.com>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
 <Y7P926/+N9IDKCyR@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7P926/+N9IDKCyR@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 03:35:15PM +0530, Deepak R Varma wrote:
> On Tue, Jan 03, 2023 at 09:59:52AM +0100, Jiri Slaby wrote:
> > On 26. 12. 22, 7:21, Deepak R Varma wrote:
> > > The refcount_* APIs are designed to address known issues with the
> > > atomic_t APIs for reference counting. They provide following distinct
> > > advantages
> > >     - protect the reference counters from overflow/underflow
> > >     - avoid use-after-free errors
> > >     - provide improved memory ordering guarantee schemes
> > >     - neater and safer.
> >
> > Really? (see below)
> >
> > > --- a/drivers/tty/serial/dz.c
> > > +++ b/drivers/tty/serial/dz.c
> > ...
> > > @@ -687,23 +686,19 @@ static int dz_map_port(struct uart_port *uport)
> > >   static int dz_request_port(struct uart_port *uport)
> > >   {
> > >   	struct dz_mux *mux = to_dport(uport)->mux;
> > > -	int map_guard;
> > >   	int ret;
> > >
> > > -	map_guard = atomic_add_return(1, &mux->map_guard);
> > > -	if (map_guard == 1) {
> > > -		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> > > -					"dz")) {
> > > -			atomic_add(-1, &mux->map_guard);
> > > -			printk(KERN_ERR
> > > -			       "dz: Unable to reserve MMIO resource\n");
> > > +	refcount_inc(&mux->map_guard);
> > > +	if (refcount_read(&mux->map_guard) == 1) {
> >
> > This is now racy, right?
> 
> Hello Jiri,
> Thank you for the feedback. You are correct. I have split a single instruction
> in two (or more?) instructions potentially resulting in race conditions. I
> looked through the refcount_* APIs but did not find a direct match.
> 
> 
> Can you please comment if the the following variation will avoid race condition?
> 
> 	if (!refcount_add_not_zero(1, &mux->map_guard)) {
> 		refcount_inc(&mux->map_guard);
> 		...
> 	}

What do you think?  The onus is on you to prove the conversion is
correct, otherwise, why do the conversion at all?

Actually, why do this at all, what is the goal here?  And how was this
tested?

thanks,

greg k-h
