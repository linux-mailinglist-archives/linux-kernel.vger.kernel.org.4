Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AE6669F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjALEFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjALEFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:05:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD074BD76
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673496250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0OY2I1ezHTRqIu9Y/LC7ts0y7/Uyj7Fzh0DQLGJ/B0=;
        b=Nv9D4/1aM1Sm8aTd1SHNdZtAhfppRWGvLwqoOXi81EYvAEV3v7gU9xteba+C06NTIWNSPG
        Bv9KQJuXH5GjmGVBk4X+4A2mteHjIA7OI6etYwSqVJPvf21t+O2PgT4Z93weO6ZqowmmlZ
        8mfimbltegfNbA0/Jy77x2bDV9oZkm4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-BndBdAbrMC-ib8T6Cj9Zrg-1; Wed, 11 Jan 2023 23:04:09 -0500
X-MC-Unique: BndBdAbrMC-ib8T6Cj9Zrg-1
Received: by mail-oo1-f71.google.com with SMTP id n30-20020a4a345e000000b004ac99b461b5so6386607oof.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0OY2I1ezHTRqIu9Y/LC7ts0y7/Uyj7Fzh0DQLGJ/B0=;
        b=CjmX4X/n/YjH83O9giLHz0Vgo5a8k56GdmYnp7C1noRJhkByj8EJJ+OEQaM5ewZpp4
         Um5djk2gnSffBNzJFWzfX9KqSrzMgheQaV+lomEe1XrEAA5zr46lTYcJPp6F+vtL+HP9
         cl/T3tQ1pY93V0F6WG0Jihogt/M6XLLY2AolltP2nfhsiRCTTNTnqjgx7dHQIY0MXyND
         270z+xGYWfUtgBl2/0H2AOcNa5SO9fxm2h38TLe5xlWKa5+t7b3Jk7CDWdBLlylsqgDe
         keC1eSqiCQJr5QYMKOtIZTASvpl5HzIiRS44g040qH5yVS55TPmD0jqVsb+pkB1/v5LZ
         rKHw==
X-Gm-Message-State: AFqh2krVscae9P8tmgmZdlh7TCRTctgi5S3f/9dNCgDxBUnk7TGI0gHA
        vhKQjZs5Fi2elo2/8ZhQG3S6ypF5789cZZHMdjfiWDuYE4kQt9IxaJ8Hx0HPj5l4EIKyEWP3icu
        /UXB/av/q3sTnDLWHdwF7hgLJiPGomz69pFIHWcpD
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id ck1-20020a056830648100b006849f723fe3mr579248otb.201.1673496248610;
        Wed, 11 Jan 2023 20:04:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvdhsnX1tQ73S1tyQpK140LB2FMMbmrPAh6IYodfSt/BgEx43J6hE6A3CR6z4IpaIqh9udBSGJaPJYAFihg+yY=
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id
 ck1-20020a056830648100b006849f723fe3mr579244otb.201.1673496248425; Wed, 11
 Jan 2023 20:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20230111062809.25020-1-jasowang@redhat.com> <DM8PR12MB540054712BACEF34E065C2BBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB540054712BACEF34E065C2BBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 Jan 2023 12:03:57 +0800
Message-ID: <CACGkMEtNn5oiQEdY49O4TyCOV68AF7ypGzMQKzRaq0Tc6rvcYA@mail.gmail.com>
Subject: Re: [PATCH 0/5] virtio_ring: per virtqueue DMA device
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 9:33 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 11 January 2023 8:28
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: [PATCH 0/5] virtio_ring: per virtqueue DMA device
> >
> > Hi All:
> >
> > In some cases, the virtqueue could be backed by different devices. One
> > example is that in the case of vDPA some parent may emualte virtqueue
> > via vringh. In this case, it would be wrong if we stick with the
> > physical DMA device for software emulated device, since there's no
> > easy way for vringh to know about the hardware IOMMU mappings.
> >
> > So this series tries to introduce per virtqueue DMA device, then
> > software virtqueues can utilize the transport specific method to
> > assign appropirate DMA device.
> >
> > This fixes the crash of mlx5_vdpa + virtio_vdpa when platform IOMMU is
> > enabled but not in the passthrough mode. The reason for the crash is
> > that the virito_ring tries to map the control virtqueue into platform
> > IOMMU but the vringh assumes a direct mapping (PA as IOVA). This is
> > fixed by advetise the vDPA device that doesnt do DMA (without a DMA
> > ops). So DMA API can go with the direct mapping then the vringh will
> > be happy since mlx5_vdpa assuems a direct/identical mapping by
> > default.
> >
>
> Could you provide instructions how to reproduce the crash you were seeing?

It should be something like:

1) boot host kernel with iommu enabled but not in passthrough mode: I
use intel_iommu=on
2) create vdpa device on top of mlx5_vdpa VF
3) bind the vdpa device to virtio_vdpa

Then I can see the crash.

Thanks

>
> > Please review.
> >
> > Thanks
> >
> > Jason Wang (5):
> >   virtio_ring: per virtqueue dma device
> >   vdpa: introduce get_vq_dma_device()
> >   virtio-vdpa: support per vq dma device
> >   vdpa: set dma mask for vDPA device
> >   vdpa: mlx5: support per virtqueue dma device
> >
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c |  11 +++
> >  drivers/vdpa/vdpa.c               |   5 ++
> >  drivers/virtio/virtio_ring.c      | 133 +++++++++++++++++++++---------
> >  drivers/virtio/virtio_vdpa.c      |  13 ++-
> >  include/linux/vdpa.h              |   6 ++
> >  include/linux/virtio_ring.h       |  16 ++++
> >  6 files changed, 141 insertions(+), 43 deletions(-)
> >
> > --
> > 2.25.1
>

