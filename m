Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F8274B860
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGGUv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGGUv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:51:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2571FEB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5120E61A66
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF2AC433C7;
        Fri,  7 Jul 2023 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688763083;
        bh=GkXa8NYTqsjiWmtWF+qgPMdkxGiHi2MVtxO2Vakv29A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WK1csyYveOTFWsizvszDMo8qCgo1qc0k2DanpwjXjN1D+dSiyEbnoQZJhKjUhCva4
         s+3GqsRvhPqwOIyZFbUEjUd/4q71D63u8xUUCobHPmbLJ3o6KfipfkhiexKduTlW/Q
         DxhBaruLd9jB+Xv6F1MIjySBwgr6JRrYYn6z7YVlxxWh2vSRZIcBRUNnTjoATlHURb
         d1GwybmKL6/1bvbdfWZGNlWaBfNeduJE7DjiXWSy1rzVkTR3X9kjenThs/W9qwDU+K
         54N+7USxbT8r3yxoBj5aXOMFvf+kCOaoiN501guP/01T98fifkhwYyhAw9ZfyzFaFg
         70VtWOtLzX9EQ==
Date:   Fri, 7 Jul 2023 13:51:20 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     jgross@suse.com
cc:     roger.pau@citrix.com, sstabellini@kernel.org, olekstysh@gmail.com,
        marmarek@invisiblethingslab.com, Oleksandr_Tyshchenko@epam.com,
        petr.pavlu@suse.com, xen-devel@lists.xenproject.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <100177f8fec144ac96d91de226f76ebe@posteo.net>
Message-ID: <alpine.DEB.2.22.394.2307071347160.761183@ubuntu-linux-20-04-desktop>
References: <100177f8fec144ac96d91de226f76ebe@posteo.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-55874677-1688763083=:761183"
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

--8323329-55874677-1688763083=:761183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 7 Jul 2023:
> On 07.07.23 16:42, Roger Pau Monné wrote:
> > On Fri, Jul 07, 2023 at 04:10:14PM +0200, Juergen Gross wrote:
> > > On 07.07.23 11:50, Roger Pau Monné wrote:
> > > > On Fri, Jul 07, 2023 at 06:38:48AM +0200, Juergen Gross wrote:
> > > > > On 06.07.23 23:49, Stefano Stabellini wrote:
> > > > > > On Thu, 6 Jul 2023, Roger Pau Monné wrote:
> > > > > > > On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini
> > > > > > > wrote:
> > > > > > > > On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > > > > > > > > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko
> > > > > > > > > wrote:
> > > > > > > > > > Part 2 (clarification):
> > > > > > > > > > 
> > > > > > > > > > I think using a special config space register in the root
> > > > > > > > > > complex would
> > > > > > > > > > not be terrible in terms of guest changes because it is easy
> > > > > > > > > > to
> > > > > > > > > > introduce a new root complex driver in Linux and other OSes.
> > > > > > > > > > The root
> > > > > > > > > > complex would still be ECAM compatible so the regular ECAM
> > > > > > > > > > driver would
> > > > > > > > > > still work. A new driver would only be necessary if you want
> > > > > > > > > > to be able
> > > > > > > > > > to access the special config space register.
> > > > > > > > > 
> > > > > > > > > I'm slightly worry of this approach, we end up modifying a
> > > > > > > > > root
> > > > > > > > > complex emulation in order to avoid modifying a PCI device
> > > > > > > > > emulation
> > > > > > > > > on QEMU, not sure that's a good trade off.
> > > > > > > > > 
> > > > > > > > > Note also that different architectures will likely have
> > > > > > > > > different root
> > > > > > > > > complex, and so you might need to modify several of them, plus
> > > > > > > > > then
> > > > > > > > > arrange the PCI layout correctly in order to have the proper
> > > > > > > > > hierarchy
> > > > > > > > > so that devices belonging to different driver domains are
> > > > > > > > > assigned to
> > > > > > > > > different bridges.
> > > > > > > > 
> > > > > > > > I do think that adding something to the PCI conf register
> > > > > > > > somewhere is
> > > > > > > > the best option because it is not dependent on ACPI and it is
> > > > > > > > not
> > > > > > > > dependent on xenstore both of which are very undesirable.
> > > > > > > > 
> > > > > > > > I am not sure where specifically is the best place. These are 3
> > > > > > > > ideas
> > > > > > > > we came up with:
> > > > > > > > 1. PCI root complex
> > > > > > > > 2. a register on the device itself
> > > > > > > > 3. a new capability of the device
> > > > > > > > 4. add one extra dummy PCI device for the sole purpose of
> > > > > > > > exposing the
> > > > > > > >       grants capability
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Looking at the spec, there is a way to add a vendor-specific
> > > > > > > > capability
> > > > > > > > (cap_vndr = 0x9). Could we use that? It doesn't look like it is
> > > > > > > > used
> > > > > > > > today, Linux doesn't parse it.
> > > > > > > 
> > > > > > > I did wonder the same from a quick look at the spec.  There's
> > > > > > > however
> > > > > > > a text in the specification that says:
> > > > > > > 
> > > > > > > "The driver SHOULD NOT use the Vendor data capability except for
> > > > > > > debugging and reporting purposes."
> > > > > > > 
> > > > > > > So we would at least need to change that because the capability
> > > > > > > would
> > > > > > > then be used by other purposes different than debugging and
> > > > > > > reporting.
> > > > > > > 
> > > > > > > Seems like a minor adjustment, so might we worth asking upstream
> > > > > > > about
> > > > > > > their opinion, and to get a conversation started.
> > > > > > 
> > > > > > Wait, wouldn't this use-case fall under "reporting" ? It is exactly
> > > > > > what
> > > > > > we are doing, right?
> > > > > 
> > > > > I'd understand "reporting" as e.g. logging, transferring statistics,
> > > > > ...
> > > > > 
> > > > > We'd like to use it for configuration purposes.
> > > > 
> > > > I've also read it that way.
> > > > 
> > > > > Another idea would be to enhance the virtio IOMMU device to suit our
> > > > > needs:
> > > > > we could add the domid as another virtio IOMMU device capability and
> > > > > (for now)
> > > > > use bypass mode for all "productive" devices.
> > > > 
> > > > If we have to start adding capabilties, won't it be easier to just add
> > > > it to the each device instead of adding it to virtio IOMMU.  Or is the
> > > > parsing of capabilities device specific, and hence we would have to
> > > > implement such parsing for each device?  I would expect some
> > > > capabilities are shared between all devices, and a Xen capability could
> > > > be one of those.
> > > 
> > > Have a look at [1], which is describing the common device config layout.
> > > The problem here is that we'd need to add the domid after the queue
> > > specific
> > > data, resulting in a mess if further queue fields would be added later.
> > > 
> > > We could try that, of course.
> > 
> > Right, we must make it part of the standard if we modify
> > virtio_pci_common_cfg, or else newly added fields would overlap the
> > Xen specific one.
> > 
> > Would it be possible to signal Xen-grants support in the
> > `device_feature` field, and then expose it from a vendor capability?
> > IOW, would it be possible to add a Xen-specific hook in the parsing of
> > virtio_pci_common_cfg that would then fetch additional data from a
> > capability?
> 
> TBH, I don't know. It might require some changes in the central parsing
> logic, but this shouldn't be too hard to do.
> 
> > That would likely be less intrusive than adding a new Xen-specific
> > field to virtio_pci_common_cfg while still allowing us to do Xen
> > specific configuration for all VirtIO devices.
> 
> In case we want to go that route, this should be in a new "platform config"
> capability, which might be just another form of a vendor capability.
 
I think this is the best idea. We should look into this.


> > > > > Later we could even add grant-V3 support to Xen and to the virtio
> > > > > IOMMU device
> > > > > (see my last year Xen Summit design session). This could be usable for
> > > > > disaggregated KVM setups, too, so I believe there is a chance to get
> > > > > this
> > > > > accepted.
> > > > > 
> > > > > > > > > > **********
> > > > > > > > > > What do you think about it? Are there any pitfalls, etc?
> > > > > > > > > > This also requires
> > > > > > > > > > system changes, but at least without virtio spec changes.
> > > > > > > > > 
> > > > > > > > > Why are we so reluctant to add spec changes?  I understand
> > > > > > > > > this might
> > > > > > > > > take time an effort, but it's the only way IMO to build a
> > > > > > > > > sustainable
> > > > > > > > > VirtIO Xen implementation.  Did we already attempt to
> > > > > > > > > negotiate with
> > > > > > > > > Oasis Xen related spec changes and those where refused?
> > > > > > > > 
> > > > > > > > That's because spec changes can be very slow. This is a bug that
> > > > > > > > we need
> > > > > > > > a relatively quick solution for and waiting 12-24 months for a
> > > > > > > > spec
> > > > > > > > update is not realistic.
> > > > > > > > 
> > > > > > > > I think a spec change would be best as a long term solution. We
> > > > > > > > also
> > > > > > > > need a short term solution. The short term solution doesn't have
> > > > > > > > to be
> > > > > > > > ideal but it has to work now.
> > > > > > > 
> > > > > > > My fear with such approach is that once a bodge is in place people
> > > > > > > move on to other stuff and this never gets properly fixed.
> > > > > > > 
> > > > > > > I know this might not be a well received opinion, but it would be
> > > > > > > better if such bodge is kept in each interested party patchqueue
> > > > > > > for
> > > > > > > the time being, until a proper solution is implemented.  That way
> > > > > > > there's an interest from parties into properly fixing it upstream.
> > > > > > 
> > > > > > Unfortunately we are in the situation where we have an outstanding
> > > > > > upstream bug, so we have to take action one way or the other.
> > > > > 
> > > > > The required virtio IOMMU device modification would be rather small,
> > > > > so
> > > > > adding it maybe under a CONFIG option defaulting to off might be
> > > > > acceptable.
> > > > 
> > > > Would you then do the grant allocation as part of virtio IOMMU?
> > > 
> > > Long term, maybe. Do you remember my Grant-V3 design session last year?
> > > Being
> > > able to reuse the same layout for virtio IOMMU was one of the basic ideas
> > > for
> > > that layout (this would need some heavy work on the virtio IOMMU frontend
> > > and
> > > backend, of course).
> > 
> > While this might well be the best option, do we have anyone with the
> > time and expertise to work on this?  I might be wrong, but it seems
> > like a huge task.
> 
> As a background project I'd like to pursue it. OTOH I'm not sure how much time
> I could spend on it.

Not only it is complex but also has severe implications in terms of
security, safety, and needs to interact with potential virtual IOMMUs in
the guest (virtual IOMMUs to expose another IOMMU stage of translation
in the guest.)

This is definitely not simple.

At that point I would feel more confident in a solution that uses ACPI
tables to add the necessary information the same way we use Device Tree
to do it on ARM. Keep in mind that if an existing ACPI table doesn't
have the fields that we need, we can introduce a new ACPI table.
--8323329-55874677-1688763083=:761183--
