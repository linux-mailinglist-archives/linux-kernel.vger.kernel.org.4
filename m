Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D396BC0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjCOXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCOXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE912F96B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3472161E97
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13837C4339B;
        Wed, 15 Mar 2023 23:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678922713;
        bh=jc1Gbldgu0s3c1IL4ZwUV75CvRBN1rI1hujAlbgRO+M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NnDonRvDGOEUa1gqnkXP4Rh19Niwv9n0KsLi7zCRaxG2und0Dk6en63v1orrj6ZGw
         lozAuqt876/Db9pEtvAZt2dR5InwzKUlbBdsfnujEuG5F/cujBwEY5jHoe1VE7OuS9
         3LMXbUq59uW8YMc83N0zrUSpADe/oEKUGVmV1RIIA0/yveyALHfvtJ9S6+RJLXwKKs
         povEA3lU9rUCt++t5O3sgG1gRk3tAhaQsgKZNbl5UdljiPuS3lZG7lIaPIlD8OgIq0
         dk3NgWu2z0h5LVZyBMVvG/QWHp7XM3OFPKp0tTwY2yrLMOUsaePm7IewZlpl6eDagG
         NfFs5aff/mgCQ==
Date:   Wed, 15 Mar 2023 16:25:06 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Jan Beulich <jbeulich@suse.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        Julia Zhang <julia.zhang@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [RFC PATCH 1/5] x86/xen: disable swiotlb for xen pvh
In-Reply-To: <f5e03f2a-8176-528f-e885-9a97940367c0@suse.com>
Message-ID: <alpine.DEB.2.22.394.2303151616200.3462@ubuntu-linux-20-04-desktop>
References: <20230312120157.452859-1-ray.huang@amd.com> <20230312120157.452859-2-ray.huang@amd.com> <ea0e3852-87ba-984b-4010-5eeac3d6c507@suse.com> <alpine.DEB.2.22.394.2303141747350.863724@ubuntu-linux-20-04-desktop>
 <f5e03f2a-8176-528f-e885-9a97940367c0@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023, Jan Beulich wrote:
> On 15.03.2023 01:52, Stefano Stabellini wrote:
> > On Mon, 13 Mar 2023, Jan Beulich wrote:
> >> On 12.03.2023 13:01, Huang Rui wrote:
> >>> Xen PVH is the paravirtualized mode and takes advantage of hardware
> >>> virtualization support when possible. It will using the hardware IOMMU
> >>> support instead of xen-swiotlb, so disable swiotlb if current domain is
> >>> Xen PVH.
> >>
> >> But the kernel has no way (yet) to drive the IOMMU, so how can it get
> >> away without resorting to swiotlb in certain cases (like I/O to an
> >> address-restricted device)?
> > 
> > I think Ray meant that, thanks to the IOMMU setup by Xen, there is no
> > need for swiotlb-xen in Dom0. Address translations are done by the IOMMU
> > so we can use guest physical addresses instead of machine addresses for
> > DMA. This is a similar case to Dom0 on ARM when the IOMMU is available
> > (see include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect, the corresponding
> > case is XENFEAT_not_direct_mapped).
> 
> But how does Xen using an IOMMU help with, as said, address-restricted
> devices? They may still need e.g. a 32-bit address to be programmed in,
> and if the kernel has memory beyond the 4G boundary not all I/O buffers
> may fulfill this requirement.

In short, it is going to work as long as Linux has guest physical
addresses (not machine addresses, those could be anything) lower than
4GB.

If the address-restricted device does DMA via an IOMMU, then the device
gets programmed by Linux using its guest physical addresses (not machine
addresses).

The 32-bit restriction would be applied by Linux to its choice of guest
physical address to use to program the device, the same way it does on
native. The device would be fine as it always uses Linux-provided <4GB
addresses. After the IOMMU translation (pagetable setup by Xen), we
could get any address, including >4GB addresses, and that is expected to
work.
