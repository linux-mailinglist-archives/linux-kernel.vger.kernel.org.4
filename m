Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D45663A27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjAJHsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjAJHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:48:21 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71F178B2;
        Mon,  9 Jan 2023 23:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673336879; bh=EiXkQ2JEZGnLUb6tfZO7vd8G6NiaZjjsaBJ1fvdxXPM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=IZKYGpjv9ejzRTD7LR95ZrMWEH5H+A/L1ASzRI6+VMXqN1R51fca9X5f1pmzMVZaa
         iFr9Xrqmsb3B9UeMqvRtUfqxwc4AmgOa5s4wTeQ62iZ7FTJVFcriM9Vu63oTnKGI6z
         JRz3x6V9QArXtwOjpjl7qh5b6QeHnU4tq6G7VSC0=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 08:47:59 +0100 (CET)
X-EA-Auth: PprNwOeWQeT6qxQf+3gYvLF4aPgOloBh7REyAC3mB29FCIBf1kwszEl+TiorbYIjmmwWduBdrFTsD74Hg5HAMFy19f1+7J9e
Date:   Tue, 10 Jan 2023 13:17:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "ishkamiel@gmail.com" <ishkamiel@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dwindsor@gmail.com" <dwindsor@gmail.com>
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Message-ID: <Y70YKqt+Ej4kU9+h@ubun2204.myguest.virtualbox.org>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
 <Y70DbEvxDDGXDv4i@ubun2204.myguest.virtualbox.org>
 <DM8PR11MB575088A17680C124D6B9EB73E7FF9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jSLdvTZAgZry9A9c"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575088A17680C124D6B9EB73E7FF9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jSLdvTZAgZry9A9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2023 at 07:27:44AM +0000, Reshetova, Elena wrote:
>  
> > On Tue, Jan 03, 2023 at 09:59:52AM +0100, Jiri Slaby wrote:
> > > On 26. 12. 22, 7:21, Deepak R Varma wrote:
> > > > The refcount_* APIs are designed to address known issues with the
> > > > atomic_t APIs for reference counting. They provide following distinct
> > > > advantages
> > > >     - protect the reference counters from overflow/underflow
> > > >     - avoid use-after-free errors
> > > >     - provide improved memory ordering guarantee schemes
> > > >     - neater and safer.
> > >
> > > Really? (see below)
> > >
> > > > --- a/drivers/tty/serial/dz.c
> > > > +++ b/drivers/tty/serial/dz.c
> > > ...
> > > > @@ -687,23 +686,19 @@ static int dz_map_port(struct uart_port *uport)
> > > >   static int dz_request_port(struct uart_port *uport)
> > > >   {
> > > >   	struct dz_mux *mux = to_dport(uport)->mux;
> > > > -	int map_guard;
> > > >   	int ret;
> > > >
> > > > -	map_guard = atomic_add_return(1, &mux->map_guard);
> > > > -	if (map_guard == 1) {
> > > > -		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> > > > -					"dz")) {
> > > > -			atomic_add(-1, &mux->map_guard);
> > > > -			printk(KERN_ERR
> > > > -			       "dz: Unable to reserve MMIO resource\n");
> > > > +	refcount_inc(&mux->map_guard);
> > > > +	if (refcount_read(&mux->map_guard) == 1) {
> > >
> > > This is now racy, right?
> > 
> > Hello Jiri,
> > I found this [1] commit which introduced similar transformation in a
> > neighbouring driver. Can you please comment how is this different from the
> > current patch proposal?
> > 
> > [1] commit ID: 22a33651a56f ("convert sbd_duart.map_guard from atomic_t to
> > refcount_t")
> > 
> > On a side note, I have not been able to find an exact 1:1 map to the
> > atomic_add_result API. I am wondering should we have one?
> 

Hello Elena,

> In past we have decided not to provide this API for refcount_t
> because for truly correctly behaving reference counters it should not be needed
> (vs atomics that cover a broader range of use cases). 

So, there is no FAA refcount wrapper? I think this is a pretty common need.
Please correct me if I am wrong.

> Can you use !refcount_inc_not_zero in the above case?

I actually did try that but was not sure if truly addresses the objection.
Please attached and let me know if you have a feedback on the alternate
approach.

Thank you,
./drv


> 
> Best Regards,
> Elena.

--jSLdvTZAgZry9A9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=code_diff

############## ORIGINAL CODE ##################################
-       map_guard = atomic_add_return(1, &mux->map_guard);
-       if (map_guard == 1) {
-               if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
-                                       "dz")) {
-                       atomic_add(-1, &mux->map_guard);
-                       printk(KERN_ERR
-                              "dz: Unable to reserve MMIO resource\n");
                        return -EBUSY;
                }
        }

############## INITIAL APPROACH ##################################
+       refcount_inc(&mux->map_guard);
+       if (refcount_read(&mux->map_guard) == 1) {
+               if (!request_mem_region(uport->mapbase, dec_kn_slot_size, "dz")) {
+                       refcount_dec(&mux->map_guard);
+                       printk(KERN_ERR "dz: Unable to reserve MMIO resource\n");
                        return -EBUSY;
                }
        }

############## ALTERNATE APPROACH ##################################

+       if (!refcount_inc_not_zero(&mux->map_guard)) {
+               refcount_inc(&mux->map_guard);
+               if (!request_mem_region(uport->mapbase, dec_kn_slot_size, "dz")) {
+                       refcount_dec(&mux->map_guard);
+                       printk(KERN_ERR "dz: Unable to reserve MMIO resource\n");
                        return -EBUSY;
                }
        }


--jSLdvTZAgZry9A9c--


