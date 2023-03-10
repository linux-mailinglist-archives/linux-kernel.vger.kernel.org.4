Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662726B3B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCJJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCJJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBD76167
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678441560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EK9itzNwztWEWdddqk8IMFWiym6+vyjgRi28eISez9E=;
        b=i8sCGw5oHBzJ1hPO5xt0Pjo0Q/DFUX395zov0etcLDQEjYUvM4yILpBy1Pm26FPcVLOe+P
        1Pj77p/tqZ4cd6EMu44S2hPh2P5o1OgBKfADqTSfozPTbiGvdUeNZDLXFAJPosYDLdup0G
        RC7kQpdmqSNwAKzRG6IiHq0SEEsywvQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-ZcCTgBf-MzWdWwTqUesOkw-1; Fri, 10 Mar 2023 04:45:58 -0500
X-MC-Unique: ZcCTgBf-MzWdWwTqUesOkw-1
Received: by mail-oo1-f72.google.com with SMTP id w5-20020a4a9785000000b0052521223553so1483110ooi.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK9itzNwztWEWdddqk8IMFWiym6+vyjgRi28eISez9E=;
        b=jmhsO+lSbmj5SwSN2gjF022tfU1CwXO3yO0RHMh0Hl28DDNP8y3vrUOppv7o+OAZ1Y
         z8U8q/YaR+GNFCug0wPYaitaoEMFde6NUj3agagsSWTCrN50on0MvWKkGS+g8VDbf+vC
         70J2qSJ0IL5hC2U3Vg1qNAY3syZ5gKdem9UQztQNnxEaMfzpQHn1jkgmMI1yPGIxtDSa
         DZgMXNT8unBlmNQDPHhICpfKR9YM/TvOu6s/1RUM6zBIcPQXdAv8njU09vSPmbykea/2
         8dT5MYcPT09mI2cGGEdsZ11qI6PVodDB9AdtYPPcx8owHjaboZVlxzOKqfodfiyKms66
         de5g==
X-Gm-Message-State: AO0yUKUuTg5NvhLoA9cfov72M1Yc+6buwDY2S6AL4rhXhjR3a5gqvoNN
        S/CGXrs6YhQzyrbElZKbVgR8/ZYCZVoqzwBYj2m39Px3oP1wuN0TjipwsNm0ouy0VuyEuxMo0pm
        D2zIlLIcoZNp3kTwk6AxRRqmNS/Qif3EIjhFGBfCT8toTUWejQdEqDw==
X-Received: by 2002:a05:6870:703:b0:172:cef0:4549 with SMTP id ea3-20020a056870070300b00172cef04549mr8547618oab.9.1678441557608;
        Fri, 10 Mar 2023 01:45:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8wFTyGoabixP5OFNVzySToAyCse4a2PQn/SiQim9SvqUPTZJzF14tUdNW7G51x0q/0hGPiEqTsuhQVjiiGEfc=
X-Received: by 2002:a05:6870:703:b0:172:cef0:4549 with SMTP id
 ea3-20020a056870070300b00172cef04549mr8547605oab.9.1678441557382; Fri, 10 Mar
 2023 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com> <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com> <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
 <20230310034101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310034101-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 10 Mar 2023 17:45:46 +0800
Message-ID: <CACGkMEsr3xSa=1WtU35CepWSJ8CK9g4nGXgmHS_9D09LHi7H8g@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        wangrong68@huawei.com, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 4:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Feb 20, 2023 at 10:37:18AM +0800, Jason Wang wrote:
> > On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
> > > > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > > > From: Rong Wang <wangrong68@huawei.com>
> > > > > >
> > > > > > Once enable iommu domain for one device, the MSI
> > > > > > translation tables have to be there for software-managed MSI.
> > > > > > Otherwise, platform with software-managed MSI without an
> > > > > > irq bypass function, can not get a correct memory write event
> > > > > > from pcie, will not get irqs.
> > > > > > The solution is to obtain the MSI phy base address from
> > > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > > then translation tables will be created while request irq.
> > > > >
> > > > > Probably not what anyone wants to hear, but I would prefer we not=
 add
> > > > > more uses of this stuff. It looks like we have to get rid of
> > > > > iommu_get_msi_cookie() :\
> > > > >
> > > > > I'd like it if vdpa could move to iommufd not keep copying stuff =
from
> > > > > it..
> > > >
> > > > Absolutely but when is that happening?
> > >
> > > Don't know, I think it has to come from the VDPA maintainers, Nicolin
> > > made some drafts but wasn't able to get it beyond that.
> >
> > Cindy (cced) will carry on the work.
> >
> > Thanks
>
> Hmm didn't see anything yet. Nanyong Sun maybe you can take a look?

Just to clarify, Cindy will work on the iommufd conversion for
vhost-vDPA, the changes are non-trivial and may take time. Before we
are able to achieve that,  I think we still need something like this
patch to make vDPA work on software managed MSI platforms.

Maybe Nanyong can post a new version that addresses the comment so far?

Thanks

>
> > >
> > > Please have people who need more iommu platform enablement to pick it
> > > up instead of merging hacks like this..
> > >
> > > We are very close to having nested translation on ARM so anyone who i=
s
> > > serious about VDPA on ARM is going to need iommufd anyhow.
> > >
> > > Jason
> > >
>

