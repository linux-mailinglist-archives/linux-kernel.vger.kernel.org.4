Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835B469D098
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjBTPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjBTPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF012597
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676906671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXbeg/8n4ojsPY6rFquIIVMt+7vRYFxzuQ9z7o+cgT8=;
        b=IdLpkj2qAOZ0hxUwiWoqOL5tnnVeO+Ws4EA/87dZPbgc0fZ77aZXdO9ds0BXW/ccGT1Snc
        ERHf9VQEKpu8/ApyFmnYWWzY/QXuVmhjrbDG70nCdHNbUCxrvgYNYgONc9YAPJH1hM+ElI
        K2obr6Ko7wlW5iELX0ANj8YwSrQGrw0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-3OFhPygUNG2CqYyLGkCdOg-1; Mon, 20 Feb 2023 10:24:28 -0500
X-MC-Unique: 3OFhPygUNG2CqYyLGkCdOg-1
Received: by mail-wm1-f70.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso698676wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXbeg/8n4ojsPY6rFquIIVMt+7vRYFxzuQ9z7o+cgT8=;
        b=eP/OX8IBZ2wUkwt/SyC7eFvggeuQmcNz94GrBT2OMct7kp8rpDlg3931ZqEjO49qMP
         j8OHtkqsx7IF3Up3y6noW+hZkVHYaIGTTepnoP9FcEsswk9i6pIcllKxhI0dlWSqmzD1
         rEk5DZrGOze/T8oP0pMwqbPQvE023zhXookrHzDM6nsUfuSApUAbpbLU44+WFTRhPAmP
         JwySZFz0KXjognoPru22jhPG32+K1+gIi2M7QJnRa6jaTYquectw74va5OW/IHwmLrLR
         XVaTrVGZCm083hheiAup75x7Gcb7jJO0ga+Tymwd0WZuynoyt3I/5jNUUgrTDWR2Hv2N
         anUw==
X-Gm-Message-State: AO0yUKVI8+5qlQeYjp7cdjj3TGXxdqDf9PkkV6mFUFJWVcL9xaDjp5xs
        XzIaacMwEHwcLW2TZMdOCd7z+FBj0cOEBeFChCqrVbCyd08VNF+fVMwvvpz1LkNKYQO1P3qLlFl
        1TK6JP+mBwme6IEhhIFC2WNi0
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id r17-20020a05600c459100b003e00481c897mr1269883wmo.37.1676906667352;
        Mon, 20 Feb 2023 07:24:27 -0800 (PST)
X-Google-Smtp-Source: AK7set9tFwhAVYPdJYx0EhG2sVxAmzmAIlOl5vAvFJ3YD45gjzKLDP25kfvtfbMuXNPd38LD2ll++g==
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id r17-20020a05600c459100b003e00481c897mr1269863wmo.37.1676906667016;
        Mon, 20 Feb 2023 07:24:27 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c7408000000b003b47b80cec3sm541587wmc.42.2023.02.20.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:24:26 -0800 (PST)
Date:   Mon, 20 Feb 2023 10:24:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        wangrong68@huawei.com
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230220102216-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
 <20230217051038-mutt-send-email-mst@kernel.org>
 <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:36:27AM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 6:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 01:35:59PM +0800, Jason Wang wrote:
> > > On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > > From: Rong Wang <wangrong68@huawei.com>
> > > > >
> > > > > Once enable iommu domain for one device, the MSI
> > > > > translation tables have to be there for software-managed MSI.
> > > > > Otherwise, platform with software-managed MSI without an
> > > > > irq bypass function, can not get a correct memory write event
> > > > > from pcie, will not get irqs.
> > > > > The solution is to obtain the MSI phy base address from
> > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > then translation tables will be created while request irq.
> > > >
> > > > Probably not what anyone wants to hear, but I would prefer we not add
> > > > more uses of this stuff. It looks like we have to get rid of
> > > > iommu_get_msi_cookie() :\
> > > >
> > > > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > > > it..
> > >
> > > Yes, but we probably need a patch for -stable.
> >
> > Hmm do we? this looks like it's enabling new platforms is not a bugfix...
> 
> I think we haven't limited vDPA to any specific arch in the past?
> 
> Thanks

No, but it still fails gracefully right?

Anyway, this will need iommu maintainer's ack.  We'll see.


> >
> > > >
> > > > Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> > > > path, and it is missing the iommu ownership mechanism.
> > >
> > > Ok.
> > >
> > > >
> > > > Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> > >
> > > ifcvf and vp_vpda are two drivers that use platform IOMMU.
> > >
> > > Thanks
> > >
> > > > don't propose core changes for unmerged drivers. :(
> > > >
> > > > Jason
> > > >
> >

