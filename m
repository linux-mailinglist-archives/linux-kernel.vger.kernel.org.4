Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5976284EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiKNQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiKNQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:18:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579B38F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A638F612A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8FC433D7;
        Mon, 14 Nov 2022 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668442706;
        bh=AqtzYtgXN3z9nM+kNUs9g6opjfSPy/5KmOAnNI1Je7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfcJXHl/qAG6UhIPzAWlKql8R2YTxkgePNZkoB8I8NWZmiEKmqYfi1uhCPxoI3NYl
         OGfPj1Tt77iI7zUf1D+TyWRFtZTxZgCJ5j7bVUv5VTN4r1ohjSqJNhTOUPdo/T0Jnw
         jZyOiBNTNPUxkdpLI0LWXbaswhvoUyMnH6i4XFnU=
Date:   Mon, 14 Nov 2022 17:18:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_console: Use an atomic to allocate virtual
 console numbers
Message-ID: <Y3JqThFr67DJnGJL@kroah.com>
References: <20221114080752.1900699-1-clg@kaod.org>
 <Y3IC3miVoiMROwaE@kroah.com>
 <b0503354-2d1e-a93d-a6a5-6f6a1f55f0e2@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0503354-2d1e-a93d-a6a5-6f6a1f55f0e2@kaod.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:03:40PM +0100, Cédric Le Goater wrote:
> On 11/14/22 09:57, Greg Kroah-Hartman wrote:
> > On Mon, Nov 14, 2022 at 09:07:52AM +0100, Cédric Le Goater wrote:
> > > When a virtio console port is initialized, it is registered as an hvc
> > > console using a virtual console number. If a KVM guest is started with
> > > multiple virtio console devices, the same vtermno (or virtual console
> > > number) can be used to allocate different hvc consoles, which leads to
> > > various communication problems later on.
> > > 
> > > This is also reported in debugfs :
> > > 
> > >    # grep vtermno /sys/kernel/debug/virtio-ports/*
> > >    /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
> > >    /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
> > >    /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
> > >    /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
> > > 
> > > Fix the issue with an atomic variable and start the first console
> > > number at 1 as it is today.
> > > 
> > > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > > ---
> > >   drivers/char/virtio_console.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 9fa3c76a267f..253574f41e57 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -58,12 +58,13 @@ struct ports_driver_data {
> > >   	 * We also just assume the first console being initialised was
> > >   	 * the first one that got used as the initial console.
> > >   	 */
> > > -	unsigned int next_vtermno;
> > > +	atomic_t next_vtermno;
> > >   	/* All the console devices handled by this driver */
> > >   	struct list_head consoles;
> > >   };
> > > -static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
> > > +
> > > +static struct ports_driver_data pdrvdata = { .next_vtermno = ATOMIC_INIT(0) };
> > >   static DEFINE_SPINLOCK(pdrvdata_lock);
> > >   static DECLARE_COMPLETION(early_console_added);
> > > @@ -1244,7 +1245,7 @@ static int init_port_console(struct port *port)
> > >   	 * pointers.  The final argument is the output buffer size: we
> > >   	 * can do any size, so we put PAGE_SIZE here.
> > >   	 */
> > > -	port->cons.vtermno = pdrvdata.next_vtermno;
> > > +	port->cons.vtermno = atomic_inc_return(&pdrvdata.next_vtermno);
> > 
> > Why not use a normal ida/idr structure here?
> 
> yes that works.
> 
> > And why is this never decremented?
> 
> The driver would then need to track the id allocation ...

That's what an ida/idr does.

> > and finally, why not use the value that created the "vportN" number
> > instead?
> 
> yes. we could also encode the tuple (vdev->index, port) using a bitmask,

No need for that, you already have a unique number in the name above,
why not use that?

> possibly using 'max_nr_ports' to reduce the port width.

Why is that an issue?  Maybe I am confused as to what this magic
"vtermno" is here.  Who uses it and why is the vportN number not
sufficient?

> VIRTCONS_MAX_PORTS
> seems a bit big for this device and QEMU sets the #ports to 31.
> 
> An ida might be simpler. One drawback is that an id can be reused for a
> different device/port tuple in case of an (unlikely) unplug/plug sequence.

What's wrong with that?  We do not have persistent device names from
within the kernel.

thanks,

greg k-h
