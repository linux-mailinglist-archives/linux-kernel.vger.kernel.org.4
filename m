Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F4663A50
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjAJH7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAJH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:58:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094A1AA1C;
        Mon,  9 Jan 2023 23:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6390BB810D2;
        Tue, 10 Jan 2023 07:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A450C433D2;
        Tue, 10 Jan 2023 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673337475;
        bh=xE48saHTLnYwBKfywpNkPCy00BCpa0LnBT94bNOVB50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ws8isfKLXhbiiTiqjxK0Pkte1GA4y9XipdWi6EfYG5c12sUI45Cpou3/S8MD4C8tt
         qtd0QYeZY09yCBIaYwxRtLhGjNTbxnrumKMwXfiU4n+M/sNkqLlEVG2wFj81pxS3hb
         DXuwPhrNYBf8bnhVOu5GEQ8ZfD/7anUnj+cKXrF0=
Date:   Tue, 10 Jan 2023 08:57:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "ishkamiel@gmail.com" <ishkamiel@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dwindsor@gmail.com" <dwindsor@gmail.com>
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Message-ID: <Y70agALZ+PX3ju4f@kroah.com>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
 <Y70DbEvxDDGXDv4i@ubun2204.myguest.virtualbox.org>
 <DM8PR11MB575088A17680C124D6B9EB73E7FF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y70YKqt+Ej4kU9+h@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70YKqt+Ej4kU9+h@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:17:54PM +0530, Deepak R Varma wrote:
> On Tue, Jan 10, 2023 at 07:27:44AM +0000, Reshetova, Elena wrote:
> >  
> > > On Tue, Jan 03, 2023 at 09:59:52AM +0100, Jiri Slaby wrote:
> > > > On 26. 12. 22, 7:21, Deepak R Varma wrote:
> > > > > The refcount_* APIs are designed to address known issues with the
> > > > > atomic_t APIs for reference counting. They provide following distinct
> > > > > advantages
> > > > >     - protect the reference counters from overflow/underflow
> > > > >     - avoid use-after-free errors
> > > > >     - provide improved memory ordering guarantee schemes
> > > > >     - neater and safer.
> > > >
> > > > Really? (see below)
> > > >
> > > > > --- a/drivers/tty/serial/dz.c
> > > > > +++ b/drivers/tty/serial/dz.c
> > > > ...
> > > > > @@ -687,23 +686,19 @@ static int dz_map_port(struct uart_port *uport)
> > > > >   static int dz_request_port(struct uart_port *uport)
> > > > >   {
> > > > >   	struct dz_mux *mux = to_dport(uport)->mux;
> > > > > -	int map_guard;
> > > > >   	int ret;
> > > > >
> > > > > -	map_guard = atomic_add_return(1, &mux->map_guard);
> > > > > -	if (map_guard == 1) {
> > > > > -		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> > > > > -					"dz")) {
> > > > > -			atomic_add(-1, &mux->map_guard);
> > > > > -			printk(KERN_ERR
> > > > > -			       "dz: Unable to reserve MMIO resource\n");
> > > > > +	refcount_inc(&mux->map_guard);
> > > > > +	if (refcount_read(&mux->map_guard) == 1) {
> > > >
> > > > This is now racy, right?
> > > 
> > > Hello Jiri,
> > > I found this [1] commit which introduced similar transformation in a
> > > neighbouring driver. Can you please comment how is this different from the
> > > current patch proposal?
> > > 
> > > [1] commit ID: 22a33651a56f ("convert sbd_duart.map_guard from atomic_t to
> > > refcount_t")
> > > 
> > > On a side note, I have not been able to find an exact 1:1 map to the
> > > atomic_add_result API. I am wondering should we have one?
> > 
> 
> Hello Elena,
> 
> > In past we have decided not to provide this API for refcount_t
> > because for truly correctly behaving reference counters it should not be needed
> > (vs atomics that cover a broader range of use cases). 
> 
> So, there is no FAA refcount wrapper? I think this is a pretty common need.
> Please correct me if I am wrong.
> 
> > Can you use !refcount_inc_not_zero in the above case?
> 
> I actually did try that but was not sure if truly addresses the objection.
> Please attached and let me know if you have a feedback on the alternate
> approach.
> 
> Thank you,
> ./drv
> 
> 
> > 
> > Best Regards,
> > Elena.

> ############## ORIGINAL CODE ##################################
> -       map_guard = atomic_add_return(1, &mux->map_guard);
> -       if (map_guard == 1) {
> -               if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> -                                       "dz")) {
> -                       atomic_add(-1, &mux->map_guard);
> -                       printk(KERN_ERR
> -                              "dz: Unable to reserve MMIO resource\n");
>                         return -EBUSY;
>                 }
>         }
> 
> ############## INITIAL APPROACH ##################################
> +       refcount_inc(&mux->map_guard);
> +       if (refcount_read(&mux->map_guard) == 1) {
> +               if (!request_mem_region(uport->mapbase, dec_kn_slot_size, "dz")) {
> +                       refcount_dec(&mux->map_guard);
> +                       printk(KERN_ERR "dz: Unable to reserve MMIO resource\n");
>                         return -EBUSY;
>                 }
>         }
> 
> ############## ALTERNATE APPROACH ##################################
> 
> +       if (!refcount_inc_not_zero(&mux->map_guard)) {
> +               refcount_inc(&mux->map_guard);
> +               if (!request_mem_region(uport->mapbase, dec_kn_slot_size, "dz")) {
> +                       refcount_dec(&mux->map_guard);
> +                       printk(KERN_ERR "dz: Unable to reserve MMIO resource\n");
>                         return -EBUSY;
>                 }
>         }
> 

This feels odd to me, why not just use a normal lock instead?

thanks,

greg k-h

