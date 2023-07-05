Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8812D749111
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGEWl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGEWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36C719BE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440C6617A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A45C433C8;
        Wed,  5 Jul 2023 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688596876;
        bh=5lO1UZwr1QyXUX5X9qJwcmT+eeoq/3hGknbkT7qB0Sk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vQ3yxb8k5vJtWOZaak0lKZfinVXALmUL2GrI1zIRfeOrPtAcLNn9fO7kLtmKmpXDF
         huAx0MIgcShHwGt1Qep9IGZDHA5RnC9K6vNkjkp1ahy+fYu408FTKdpZO8iGqN5HN3
         C9/dxmJEoH/iRBSaH8JvjxOwTYdHXhnQMnmSBDRC/xLX3tm66BSKG953J7QCIFDcEY
         asu07R7fe9UDI9l1qc8J7qkiWdHijpw6ZktA7JO19r8VRczLtYtQrF6hl7I8vL/Xqn
         zBpfgOwrArdo4DLA0iiHIy40w4hH6TOvPgXxV1H3uvfAdmjyjprA3NMUn04kuuMmKR
         /yizIdDS6tQlg==
Date:   Wed, 5 Jul 2023 15:41:10 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
cc:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
Message-ID: <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
References: <20230621131214.9398-3-petr.pavlu@suse.com> <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com> <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop> <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop> <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local> <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl> <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com> <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-245712701-1688596068=:761183"
Content-ID: <alpine.DEB.2.22.394.2307051527500.761183@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-245712701-1688596068=:761183
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2307051527501.761183@ubuntu-linux-20-04-desktop>

On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > On Tue, Jul 4, 2023 at 5:49 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
> > 
> > Hello all.
> > 
> > [sorry for the possible format issues]
> > 
> > 
> > On Tue, Jul 04, 2023 at 01:43:46PM +0200, Marek Marczykowski-Górecki wrote:
> > > > Hi,
> > > >
> > > > FWIW, I have ran into this issue some time ago too. I run Xen on top of
> > > > KVM and then passthrough some of the virtio devices (network one
> > > > specifically) into a (PV) guest. So, I hit both cases, the dom0 one and
> > > > domU one. As a temporary workaround I needed to disable
> > > > CONFIG_XEN_VIRTIO completely (just disabling
> > > > CONFIG_XEN_VIRTIO_FORCE_GRANT was not enough to fix it).
> > > > With that context in place, the actual response below.
> > > >
> > > > On Tue, Jul 04, 2023 at 12:39:40PM +0200, Juergen Gross wrote:
> > > > > On 04.07.23 09:48, Roger Pau Monné wrote:
> > > > > > On Thu, Jun 29, 2023 at 03:44:04PM -0700, Stefano Stabellini wrote:
> > > > > > > On Thu, 29 Jun 2023, Oleksandr Tyshchenko wrote:
> > > > > > > > On 29.06.23 04:00, Stefano Stabellini wrote:
> > > > > > > > > I think we need to add a second way? It could be anything that
> > > can help
> > > > > > > > > us distinguish between a non-grants-capable virtio backend and
> > > a
> > > > > > > > > grants-capable virtio backend, such as:
> > > > > > > > > - a string on xenstore
> > > > > > > > > - a xen param
> > > > > > > > > - a special PCI configuration register value
> > > > > > > > > - something in the ACPI tables
> > > > > > > > > - the QEMU machine type
> > > > > > > >
> > > > > > > >
> > > > > > > > Yes, I remember there was a discussion regarding that. The point
> > > is to
> > > > > > > > choose a solution to be functional for both PV and HVM *and* to
> > > be able
> > > > > > > > to support a hotplug. IIRC, the xenstore could be a possible
> > > candidate.
> > > > > > >
> > > > > > > xenstore would be among the easiest to make work. The only
> > > downside is
> > > > > > > the dependency on xenstore which otherwise virtio+grants doesn't
> > > have.
> > > > > >
> > > > > > I would avoid introducing a dependency on xenstore, if nothing else
> > > we
> > > > > > know it's a performance bottleneck.
> > > > > >
> > > > > > We would also need to map the virtio device topology into xenstore,
> > > so
> > > > > > that we can pass different options for each device.
> > > > >
> > > > > This aspect (different options) is important. How do you want to pass
> > > virtio
> > > > > device configuration parameters from dom0 to the virtio backend
> > > domain? You
> > > > > probably need something like Xenstore (a virtio based alternative like
> > > virtiofs
> > > > > would work, too) for that purpose.
> > > > >
> > > > > Mapping the topology should be rather easy via the PCI-Id, e.g.:
> > > > >
> > > > > /local/domain/42/device/virtio/0000:00:1c.0/backend
> > > >
> > > > While I agree this would probably be the simplest to implement, I don't
> > > > like introducing xenstore dependency into virtio frontend either.
> > > > Toolstack -> backend communication is probably easier to solve, as it's
> > > > much more flexible (could use qemu cmdline, QMP, other similar
> > > > mechanisms for non-qemu backends etc).
> > >
> > > I also think features should be exposed uniformly for devices, it's at
> > > least weird to have certain features exposed in the PCI config space
> > > while other features exposed in xenstore.
> > >
> > > For virtio-mmio this might get a bit confusing, are we going to add
> > > xenstore entries based on the position of the device config mmio
> > > region?
> > >
> > > I think on Arm PCI enumeration is not (usually?) done by the firmware,
> > > at which point the SBDF expected by the tools/backend might be
> > > different than the value assigned by the guest OS.
> > >
> > > I think there are two slightly different issues, one is how to pass
> > > information to virtio backends, I think doing this initially based on
> > > xenstore is not that bad, because it's an internal detail of the
> > > backend implementation. However passing information to virtio
> > > frontends using xenstore is IMO a bad idea, there's already a way to
> > > negotiate features between virtio frontends and backends, and Xen
> > > should just expand and use that.
> > >
> > >
> > 
> > On Arm with device-tree we have a special bindings which purpose is to
> > inform us whether we need to use grants for virtio and backend domid for a
> > particular device.Here on x86, we don't have a device tree, so cannot
> > (easily?) reuse this logic.
> > 
> > I have just recollected one idea suggested by Stefano some time ago [1].
> > The context of discussion was about what to do when device-tree and ACPI
> > cannot be reused (or something like that).The idea won't cover virtio-mmio,
> > but I have heard that virtio-mmio usage with x86 Xen is rather unusual case.
> > 
> > I will paste the text below for convenience.

Thanks Oleksandr! I had forgotten about this, but in retrospect it was a
good suggestion :-D


> > **********
> > 
> > Part 1 (intro):
> > 
> > We could reuse a PCI config space register to expose the backend id.
> > However this solution requires a backend change (QEMU) to expose the
> > backend id via an emulated register for each emulated device.
> > 
> > To avoid having to introduce a special config space register in all
> > emulated PCI devices (virtio-net, virtio-block, etc) I wonder if we
> > could add a special PCI config space register at the emulated PCI Root
> > Complex level.
> > 
> > Basically the workflow would be as follow:
> > 
> > - Linux recognizes the PCI Root Complex as a Xen PCI Root Complex
> > - Linux writes to special PCI config space register of the Xen PCI Root
> >   Complex the PCI device id (basically the BDF)
> > - The Xen PCI Root Complex emulated by Xen answers by writing back to
> >   the same location the backend id (domid of the backend)
> > - Linux reads back the same PCI config space register of the Xen PCI
> >   Root Complex and learn the relevant domid
> 
> IMO this seems awfully complex.  I'm not familiar with the VirtIO
> spec, but I see there's a Vendor data capability, could we possibly
> expose Xen-specific information on that capability?

That is also a possibility too. Also we could use a PCI conf register
which is known to be unused in the Virtio spec to expose the grant
capability and backend domid.


> > Part 2 (clarification):
> > 
> > I think using a special config space register in the root complex would
> > not be terrible in terms of guest changes because it is easy to
> > introduce a new root complex driver in Linux and other OSes. The root
> > complex would still be ECAM compatible so the regular ECAM driver would
> > still work. A new driver would only be necessary if you want to be able
> > to access the special config space register.
> 
> I'm slightly worry of this approach, we end up modifying a root
> complex emulation in order to avoid modifying a PCI device emulation
> on QEMU, not sure that's a good trade off.
> 
> Note also that different architectures will likely have different root
> complex, and so you might need to modify several of them, plus then
> arrange the PCI layout correctly in order to have the proper hierarchy
> so that devices belonging to different driver domains are assigned to
> different bridges.

I do think that adding something to the PCI conf register somewhere is
the best option because it is not dependent on ACPI and it is not
dependent on xenstore both of which are very undesirable.

I am not sure where specifically is the best place. These are 3 ideas
we came up with:
1. PCI root complex
2. a register on the device itself
3. a new capability of the device
4. add one extra dummy PCI device for the sole purpose of exposing the
   grants capability


Looking at the spec, there is a way to add a vendor-specific capability
(cap_vndr = 0x9). Could we use that? It doesn't look like it is used
today, Linux doesn't parse it.


> > 
> > 
> > **********
> > What do you think about it? Are there any pitfalls, etc? This also requires
> > system changes, but at least without virtio spec changes.
> 
> Why are we so reluctant to add spec changes?  I understand this might
> take time an effort, but it's the only way IMO to build a sustainable
> VirtIO Xen implementation.  Did we already attempt to negotiate with
> Oasis Xen related spec changes and those where refused?

That's because spec changes can be very slow. This is a bug that we need
a relatively quick solution for and waiting 12-24 months for a spec
update is not realistic.

I think a spec change would be best as a long term solution. We also
need a short term solution. The short term solution doesn't have to be
ideal but it has to work now.
--8323329-245712701-1688596068=:761183--
