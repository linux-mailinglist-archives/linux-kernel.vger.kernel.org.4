Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F8663932
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAJGT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAJGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:19:53 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2141C13F;
        Mon,  9 Jan 2023 22:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673331575; bh=AjgynNBr/mV6n4OufalsOpyUFIzKr5jr/Xc9OZlSOqk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=XzgY1ISrme2QMtEBFTb0yqz0UWDKybPhZjD2/7uBRoU8dRVCACcvYGhne5hjdksXv
         5rFjAXijKBdZD4L31191XxfuXlE1F10lVS6bUB6y1RX5ZBUer7ToolIL8dCfs9jdmg
         1jKPQ61+sbjhTUpBtjvl9sPvqDcXg2TtmF62ZVMQ=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 07:19:35 +0100 (CET)
X-EA-Auth: ICFYLf7N9+Khicp+t3rOKg2K8X0GbTwgdIY7JUEm/5uERWOSmKnp/BzlJwN1Giq4FtkLba00NAUgm67DioDLZNAajmk9ufKK
Date:   Tue, 10 Jan 2023 11:49:24 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        elena.reshetova@intel.com, ishkamiel@gmail.com,
        keescook@chromium.org, dwindsor@gmail.com,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Message-ID: <Y70DbEvxDDGXDv4i@ubun2204.myguest.virtualbox.org>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:59:52AM +0100, Jiri Slaby wrote:
> On 26. 12. 22, 7:21, Deepak R Varma wrote:
> > The refcount_* APIs are designed to address known issues with the
> > atomic_t APIs for reference counting. They provide following distinct
> > advantages
> >     - protect the reference counters from overflow/underflow
> >     - avoid use-after-free errors
> >     - provide improved memory ordering guarantee schemes
> >     - neater and safer.
> 
> Really? (see below)
> 
> > --- a/drivers/tty/serial/dz.c
> > +++ b/drivers/tty/serial/dz.c
> ...
> > @@ -687,23 +686,19 @@ static int dz_map_port(struct uart_port *uport)
> >   static int dz_request_port(struct uart_port *uport)
> >   {
> >   	struct dz_mux *mux = to_dport(uport)->mux;
> > -	int map_guard;
> >   	int ret;
> > 
> > -	map_guard = atomic_add_return(1, &mux->map_guard);
> > -	if (map_guard == 1) {
> > -		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> > -					"dz")) {
> > -			atomic_add(-1, &mux->map_guard);
> > -			printk(KERN_ERR
> > -			       "dz: Unable to reserve MMIO resource\n");
> > +	refcount_inc(&mux->map_guard);
> > +	if (refcount_read(&mux->map_guard) == 1) {
> 
> This is now racy, right?

Hello Jiri,
I found this [1] commit which introduced similar transformation in a
neighbouring driver. Can you please comment how is this different from the
current patch proposal?

[1] commit ID: 22a33651a56f ("convert sbd_duart.map_guard from atomic_t to refcount_t")

On a side note, I have not been able to find an exact 1:1 map to the
atomic_add_result API. I am wondering should we have one?

Thank you,
./drv


Thank you,
./drv

> 
> thanks,
> -- 
> js
> suse labs
> 


