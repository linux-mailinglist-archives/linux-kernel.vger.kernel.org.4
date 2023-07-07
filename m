Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1774B86A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGGVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E121BDB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DCE617C2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6F2C433C7;
        Fri,  7 Jul 2023 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688763723;
        bh=GJvLW/gqfLJM73MfMfqaOwxiWr3qqT/j+wGcRCsHktM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=C2uhRmFr5uKr64PBiZQ44mPEB+R1YgAQc8trIwUa5SZdzSt24CpW/cIC4+rUkfvz9
         38YpjG8HpYxrYTdw7j8uC8YQ4FHKuxmao4Jhddwv/FDDXlvL6dzQaQCP9x1ECu1mNg
         vW9i4oxCId88KuWtcGpHg4A6ywC0vFQwMTArDVww/WFrHEbrEZcOE/8NgHd93xDLTB
         vZODprhFr4o6YXrebfrW//AGbKhhsKWipg023iGDrFXFuB1d/xt7Lry/qSETjbBG0J
         Pw6u9GX4lA8QkZH/HuugKtT7tjnr8YM9YwcNAvlGRKTT3hdyFcCLJjiMSWbLthbPw8
         fYmCmMhtu3jkg==
Date:   Fri, 7 Jul 2023 14:02:01 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     Petr Pavlu <petr.pavlu@suse.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <41893db4-cd66-a9f7-ffe5-d90fffb43657@suse.com>
Message-ID: <alpine.DEB.2.22.394.2307071351530.761183@ubuntu-linux-20-04-desktop>
References: <20230621131214.9398-1-petr.pavlu@suse.com> <20230621131214.9398-3-petr.pavlu@suse.com> <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com> <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com> <41893db4-cd66-a9f7-ffe5-d90fffb43657@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023, Juergen Gross wrote:
> On 26.06.23 15:17, Petr Pavlu wrote:
> > On 6/21/23 19:58, Oleksandr Tyshchenko wrote:
> > > On 21.06.23 16:12, Petr Pavlu wrote:
> > > > When attempting to run Xen on a QEMU/KVM virtual machine with virtio
> > > > devices (all x86_64), dom0 tries to establish a grant for itself which
> > > > eventually results in a hang during the boot.
> > > > 
> > > > The backtrace looks as follows, the while loop in __send_control_msg()
> > > > makes no progress:
> > > > 
> > > >     #0  virtqueue_get_buf_ctx (_vq=_vq@entry=0xffff8880074a8400,
> > > > len=len@entry=0xffffc90000413c94, ctx=ctx@entry=0x0 <fixed_percpu_data>)
> > > > at ../drivers/virtio/virtio_ring.c:2326
> > > >     #1  0xffffffff817086b7 in virtqueue_get_buf
> > > > (_vq=_vq@entry=0xffff8880074a8400, len=len@entry=0xffffc90000413c94) at
> > > > ../drivers/virtio/virtio_ring.c:2333
> > > >     #2  0xffffffff8175f6b2 in __send_control_msg (portdev=<optimized
> > > > out>, port_id=0xffffffff, event=0x0, value=0x1) at
> > > > ../drivers/char/virtio_console.c:562
> > > >     #3  0xffffffff8175f6ee in __send_control_msg (portdev=<optimized
> > > > out>, port_id=<optimized out>, event=<optimized out>, value=<optimized
> > > > out>) at ../drivers/char/virtio_console.c:569
> > > >     #4  0xffffffff817618b1 in virtcons_probe (vdev=0xffff88800585e800)
> > > > at ../drivers/char/virtio_console.c:2098
> > > >     #5  0xffffffff81707117 in virtio_dev_probe (_d=0xffff88800585e810)
> > > > at ../drivers/virtio/virtio.c:305
> > > >     #6  0xffffffff8198e348 in call_driver_probe (drv=0xffffffff82be40c0
> > > > <virtio_console>, drv=0xffffffff82be40c0 <virtio_console>,
> > > > dev=0xffff88800585e810) at ../drivers/base/dd.c:579
> > > >     #7  really_probe (dev=dev@entry=0xffff88800585e810,
> > > > drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at
> > > > ../drivers/base/dd.c:658
> > > >     #8  0xffffffff8198e58f in __driver_probe_device
> > > > (drv=drv@entry=0xffffffff82be40c0 <virtio_console>,
> > > > dev=dev@entry=0xffff88800585e810) at ../drivers/base/dd.c:800
> > > >     #9  0xffffffff8198e65a in driver_probe_device
> > > > (drv=drv@entry=0xffffffff82be40c0 <virtio_console>,
> > > > dev=dev@entry=0xffff88800585e810) at ../drivers/base/dd.c:830
> > > >     #10 0xffffffff8198e832 in __driver_attach (dev=0xffff88800585e810,
> > > > data=0xffffffff82be40c0 <virtio_console>) at ../drivers/base/dd.c:1216
> > > >     #11 0xffffffff8198bfb2 in bus_for_each_dev (bus=<optimized out>,
> > > > start=start@entry=0x0 <fixed_percpu_data>,
> > > > data=data@entry=0xffffffff82be40c0 <virtio_console>,
> > > >         fn=fn@entry=0xffffffff8198e7b0 <__driver_attach>) at
> > > > ../drivers/base/bus.c:368
> > > >     #12 0xffffffff8198db65 in driver_attach
> > > > (drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at
> > > > ../drivers/base/dd.c:1233
> > > >     #13 0xffffffff8198d207 in bus_add_driver
> > > > (drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at
> > > > ../drivers/base/bus.c:673
> > > >     #14 0xffffffff8198f550 in driver_register
> > > > (drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at
> > > > ../drivers/base/driver.c:246
> > > >     #15 0xffffffff81706b47 in register_virtio_driver
> > > > (driver=driver@entry=0xffffffff82be40c0 <virtio_console>) at
> > > > ../drivers/virtio/virtio.c:357
> > > >     #16 0xffffffff832cd34b in virtio_console_init () at
> > > > ../drivers/char/virtio_console.c:2258
> > > >     #17 0xffffffff8100105c in do_one_initcall (fn=0xffffffff832cd2e0
> > > > <virtio_console_init>) at ../init/main.c:1246
> > > >     #18 0xffffffff83277293 in do_initcall_level
> > > > (command_line=0xffff888003e2f900 "root", level=0x6) at
> > > > ../init/main.c:1319
> > > >     #19 do_initcalls () at ../init/main.c:1335
> > > >     #20 do_basic_setup () at ../init/main.c:1354
> > > >     #21 kernel_init_freeable () at ../init/main.c:1571
> > > >     #22 0xffffffff81f64be1 in kernel_init (unused=<optimized out>) at
> > > > ../init/main.c:1462
> > > >     #23 0xffffffff81001f49 in ret_from_fork () at
> > > > ../arch/x86/entry/entry_64.S:308
> > > >     #24 0x0000000000000000 in ?? ()
> > > > 
> > > > Fix the problem by preventing xen_grant_init_backend_domid() from
> > > > setting dom0 as a backend when running in dom0.
> > > > 
> > > > Fixes: 035e3a4321f7 ("xen/virtio: Optimize the setup of "xen-grant-dma"
> > > > devices")
> > > 
> > > 
> > > I am not 100% sure whether the Fixes tag points to precise commit. If I
> > > am not mistaken, the said commit just moves the code in the context
> > > without changing the logic of CONFIG_XEN_VIRTIO_FORCE_GRANT, this was
> > > introduced before.
> > 
> > I see, the tag should better point to 7228113d1fa0 ("xen/virtio: use
> > dom0 as default backend for CONFIG_XEN_VIRTIO_FORCE_GRANT") which
> > introduced the original logic to use dom0 as backend.
> > 
> > Commit 035e3a4321f7 ("xen/virtio: Optimize the setup of "xen-grant-dma"
> > devices") is relevant in sense that it extended when this logic is
> > active by adding an OR check for xen_pv_domain().
> > 
> > > 
> > > 
> > > > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> > > > ---
> > > >    drivers/xen/grant-dma-ops.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> > > > index 76f6f26265a3..29ed27ac450e 100644
> > > > --- a/drivers/xen/grant-dma-ops.c
> > > > +++ b/drivers/xen/grant-dma-ops.c
> > > > @@ -362,7 +362,9 @@ static int xen_grant_init_backend_domid(struct
> > > > device *dev,
> > > >    	if (np) {
> > > >    		ret = xen_dt_grant_init_backend_domid(dev, np,
> > > > backend_domid);
> > > >    		of_node_put(np);
> > > > -	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) ||
> > > > xen_pv_domain()) {
> > > > +	} else if ((IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) ||
> > > > +		    xen_pv_domain()) &&
> > > > +		   !xen_initial_domain()) {
> > > 
> > > The commit lgtm, just one note:
> > > 
> > > 
> > > I would even bail out early in xen_virtio_restricted_mem_acc() instead,
> > > as I assume the same issue could happen on Arm with DT (although there
> > > we don't guess the backend's domid, we read it from DT and quite
> > > unlikely we get Dom0 being in Dom0 with correct DT).
> > > 
> > > Something like:
> > > 
> > > @@ -416,6 +421,10 @@ bool xen_virtio_restricted_mem_acc(struct
> > > virtio_device *dev)
> > >    {
> > >           domid_t backend_domid;
> > > 
> > > +       /* Xen grant DMA ops are not used when running as initial domain
> > > */
> > > +       if (xen_initial_domain())
> > > +               return false;
> > > +
> > >           if (!xen_grant_init_backend_domid(dev->dev.parent,
> > > &backend_domid)) {
> > >                   xen_grant_setup_dma_ops(dev->dev.parent, backend_domid);
> > >                   return true;
> > > (END)
> > > 
> > > 
> > > 
> > > If so, that commit subject would need to be updated accordingly.
> > > 
> > > Let's see what other reviewers will say.
> > 
> > Ok, makes sense.
> 
> I think this is okay for a fix of the current problem.
> 
> Passing through virtio devices to a PV domU is not covered by this fix, but
> this
> should be a rather rare configuration, which doesn't work today either. So the
> suggested patch would fix the current issue without introducing a regression.
> 
> Anything else can be done later.

Why do you say that passing through virtio devices to a PV domU doesn't
work today anyway? Also, as you know many people use Xen outside of
datacenter deployments (laptops, embedded etc.) where drivers domains
and device assignment are very common. You could assign a virtio network
card to a domU and use PV network to share the network with other
guests. Physical virtio devices, especially virtio-net devices, exist. I
could probably repro this problem today in a domU just installing
QubesOS inside QEMU. QubesOS uses network driver domains and if QEMU
provides a virtio-net network card, this would break even with this
patch.
