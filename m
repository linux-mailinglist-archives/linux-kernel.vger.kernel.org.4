Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553EE74A621
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGFVt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGFVt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86A1BEE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DF46136F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878D3C433C8;
        Thu,  6 Jul 2023 21:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688680163;
        bh=6nr9Df/SLX875a6ZfuEptghy0rbv4s3pkVdYz+vBJIg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VR9mnRcHMHfP3au1WeXeEnCB5LmMzYnVRE0CDvXHPF+mpw0sQeuYZR0GxyzJ29n/S
         mhB7NYIaY9sa0KUwwfrWZdxzXVW7WYav5YLYkfJaRRMv9cAePDZRGcQi97ix791me9
         /D1O+/eKz0lWlSn7lECbkVbhWWgZicUs+IvxFKMgkk1OmNWvp7NIytKkeGjEeMJlHs
         ZnCnxjE/b9iotycllAIlkbw9Dv3kvFlvJHLpxA1IyMJ26Pf4+cmrXfZKuHaAjv6Lqw
         BCq67Sw0eTOdYChqXVlLJkWTed73DCRYpezTyc18OpiE8aI4LfBZm4pgnCCbopEx9O
         k+4hMTkBIFf5g==
Date:   Thu, 6 Jul 2023 14:49:20 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
Message-ID: <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop> <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com> <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop> <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl> <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local> <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com> <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop> <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-507063870-1688680118=:761183"
Content-ID: <alpine.DEB.2.22.394.2307061448420.761183@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-507063870-1688680118=:761183
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2307061448421.761183@ubuntu-linux-20-04-desktop>

On Thu, 6 Jul 2023, Roger Pau Monné wrote:
> On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini wrote:
> > On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > > > **********
> > > > 
> > > > Part 1 (intro):
> > > > 
> > > > We could reuse a PCI config space register to expose the backend id.
> > > > However this solution requires a backend change (QEMU) to expose the
> > > > backend id via an emulated register for each emulated device.
> > > > 
> > > > To avoid having to introduce a special config space register in all
> > > > emulated PCI devices (virtio-net, virtio-block, etc) I wonder if we
> > > > could add a special PCI config space register at the emulated PCI Root
> > > > Complex level.
> > > > 
> > > > Basically the workflow would be as follow:
> > > > 
> > > > - Linux recognizes the PCI Root Complex as a Xen PCI Root Complex
> > > > - Linux writes to special PCI config space register of the Xen PCI Root
> > > >   Complex the PCI device id (basically the BDF)
> > > > - The Xen PCI Root Complex emulated by Xen answers by writing back to
> > > >   the same location the backend id (domid of the backend)
> > > > - Linux reads back the same PCI config space register of the Xen PCI
> > > >   Root Complex and learn the relevant domid
> > > 
> > > IMO this seems awfully complex.  I'm not familiar with the VirtIO
> > > spec, but I see there's a Vendor data capability, could we possibly
> > > expose Xen-specific information on that capability?
> > 
> > That is also a possibility too. Also we could use a PCI conf register
> > which is known to be unused in the Virtio spec to expose the grant
> > capability and backend domid.
> 
> Capabilities don't have a fixed config space register, they are a
> linked list, and so capabilities end up at different positions
> depending on the specific device layout.  The only fixed part is the
> range from [0, 0x3F), and that's fully defined in the specification.
> 
> Trying to define a fixed address for Xen use after the 3f boundary
> seems like a bad idea, as it's going to be hard to make sure that such
> address is not used on all possible devices.  IMO the only way is to
> place such information in a capability, whether that's an existing
> capability or a new one I don't really know.

That seems like a good idea
 
 
> > > > Part 2 (clarification):
> > > > 
> > > > I think using a special config space register in the root complex would
> > > > not be terrible in terms of guest changes because it is easy to
> > > > introduce a new root complex driver in Linux and other OSes. The root
> > > > complex would still be ECAM compatible so the regular ECAM driver would
> > > > still work. A new driver would only be necessary if you want to be able
> > > > to access the special config space register.
> > > 
> > > I'm slightly worry of this approach, we end up modifying a root
> > > complex emulation in order to avoid modifying a PCI device emulation
> > > on QEMU, not sure that's a good trade off.
> > > 
> > > Note also that different architectures will likely have different root
> > > complex, and so you might need to modify several of them, plus then
> > > arrange the PCI layout correctly in order to have the proper hierarchy
> > > so that devices belonging to different driver domains are assigned to
> > > different bridges.
> > 
> > I do think that adding something to the PCI conf register somewhere is
> > the best option because it is not dependent on ACPI and it is not
> > dependent on xenstore both of which are very undesirable.
> > 
> > I am not sure where specifically is the best place. These are 3 ideas
> > we came up with:
> > 1. PCI root complex
> > 2. a register on the device itself
> > 3. a new capability of the device
> > 4. add one extra dummy PCI device for the sole purpose of exposing the
> >    grants capability
> > 
> > 
> > Looking at the spec, there is a way to add a vendor-specific capability
> > (cap_vndr = 0x9). Could we use that? It doesn't look like it is used
> > today, Linux doesn't parse it.
> 
> I did wonder the same from a quick look at the spec.  There's however
> a text in the specification that says:
> 
> "The driver SHOULD NOT use the Vendor data capability except for
> debugging and reporting purposes."
> 
> So we would at least need to change that because the capability would
> then be used by other purposes different than debugging and reporting.
> 
> Seems like a minor adjustment, so might we worth asking upstream about
> their opinion, and to get a conversation started.

Wait, wouldn't this use-case fall under "reporting" ? It is exactly what
we are doing, right?

 
> > > > 
> > > > 
> > > > **********
> > > > What do you think about it? Are there any pitfalls, etc? This also requires
> > > > system changes, but at least without virtio spec changes.
> > > 
> > > Why are we so reluctant to add spec changes?  I understand this might
> > > take time an effort, but it's the only way IMO to build a sustainable
> > > VirtIO Xen implementation.  Did we already attempt to negotiate with
> > > Oasis Xen related spec changes and those where refused?
> > 
> > That's because spec changes can be very slow. This is a bug that we need
> > a relatively quick solution for and waiting 12-24 months for a spec
> > update is not realistic.
> > 
> > I think a spec change would be best as a long term solution. We also
> > need a short term solution. The short term solution doesn't have to be
> > ideal but it has to work now.
> 
> My fear with such approach is that once a bodge is in place people
> move on to other stuff and this never gets properly fixed.
> 
> I know this might not be a well received opinion, but it would be
> better if such bodge is kept in each interested party patchqueue for
> the time being, until a proper solution is implemented.  That way
> there's an interest from parties into properly fixing it upstream.

Unfortunately we are in the situation where we have an outstanding
upstream bug, so we have to take action one way or the other.
--8323329-507063870-1688680118=:761183--
