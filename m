Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753C66B5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAPCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjAPCuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2A66E9E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 18:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673837363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rY+5DbLLon7IpXdDXykQnTd3J3XFXUn+jM1P9sxlSJQ=;
        b=f7dox+GTNpLsEkRzM7p71azAr7KpGCsbYviFTWCFZPMthwTidzKwiAEHh95jg7dr/vI6sh
        MhoKkVnEWjJdms1kt7+V3j+O9b5/wgYbgJqlZJhCJ78DafFsFdq8yFKG3KbMbqO1DHhQzA
        RlyxnMy0yqNBuOOHgscVwi32WE066cI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-VO4o6_w0NPaUbUxPgPoyKQ-1; Sun, 15 Jan 2023 21:49:22 -0500
X-MC-Unique: VO4o6_w0NPaUbUxPgPoyKQ-1
Received: by mail-oi1-f197.google.com with SMTP id u26-20020a056808001a00b00364ef1c0872so258432oic.20
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 18:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY+5DbLLon7IpXdDXykQnTd3J3XFXUn+jM1P9sxlSJQ=;
        b=iebPef4Xxm7mEslblzVy8eSC5SNc+4dZixAhlAJx2umJX/TJ7KEOySOHIJlBaG0LBi
         qmxJceg0FJ5cI10jVl3zuz9T128k4Q478HUpOM1ahvTFY9z2WZ7LCky9jL7ElzTz76iA
         XeFYf82rnN3ca3NmS1olQ9ZTY1kmQ4naC7EExP++41V6ti5IpRSlHrPtxgt42AAw0Fqo
         779dUWJJP9dUdJXi244idMjueg9/5/eUoYc1c0l4N0QRvz9tjI7Roo1bOOTVBv/FRI2M
         sFOgGi0OVz36rKaoXkzhv7+TWG5EhmPrOqbEq01j8qWB0YnybZDAFffFcbvC2Dcmmh52
         ePEg==
X-Gm-Message-State: AFqh2kpJg+k7EmnWWxH6dVW+UTgVl4LPwGfY9Trj6jfaPcgxFa0CSJ/k
        OO6Gl/b+MAz66oEfzkaEM3nIjNZ3jjVwORKjFzNa7Vgt4dqVsULX9fOeYOEoLCL8SQzU17T41bI
        +cgiq+VFb+CTy/gR1jh78fVdSXJ/Nj2bvOwfVLgA4
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id ck1-20020a056830648100b006849f723fe3mr1350377otb.201.1673837361345;
        Sun, 15 Jan 2023 18:49:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvO6FVjt9bvYf1kCUltQhsPShpvRiYCRk6EbN55E2Ai6Dqz4AuNGRG7U4Ab+Mh2kcQQo8MOTa4PLpkw6cCFeGw=
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id
 ck1-20020a056830648100b006849f723fe3mr1350372otb.201.1673837361160; Sun, 15
 Jan 2023 18:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20230111062809.25020-1-jasowang@redhat.com> <20230111062809.25020-6-jasowang@redhat.com>
 <DM8PR12MB5400D84460E084D3459B49B1ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400D84460E084D3459B49B1ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 16 Jan 2023 10:49:10 +0800
Message-ID: <CACGkMEu4ZWgh8xb5xF26AEWafpX=CfUh_CcV0Nf97+iN9+E2ZA@mail.gmail.com>
Subject: Re: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
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

On Sun, Jan 15, 2023 at 7:08 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 11 January 2023 8:28
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
> >
> > This patch implements per virtqueue dma device for mlx5_vdpa. This is
> > needed for virtio_vdpa to work for CVQ which is backed by vringh but
> > not DMA. We simply advertise the vDPA device itself as the DMA device
> > for CVQ then DMA API can simply use PA so the identical mapping for
> > CVQ can still be used. Otherwise the identical (1:1) mapping won't
> > work when platform IOMMU is enabled since the IOVA is allocated on
> > demand which is not necessarily the PA.
> >
> > This fixes the following crash when mlx5 vDPA device is bound to
> > virtio-vdpa with platform IOMMU enabled but not in passthrough mode:
> >
> > BUG: unable to handle page fault for address: ff2fb3063deb1002
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 1393001067 P4D 1393002067 PUD 0
> > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 55 PID: 8923 Comm: kworker/u112:3 Kdump: loaded Not tainted 6.1.0+
> > #7
> > Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4 12/17/2021
> > Workqueue: mlx5_vdpa_wq mlx5_cvq_kick_handler [mlx5_vdpa]
> > RIP: 0010:vringh_getdesc_iotlb+0x93/0x1d0 [vringh]
> > Code: 14 25 40 ef 01 00 83 82 c0 0a 00 00 01 48 2b 05 93 5a 1b ea 8b 4c 24
> > 14 48 c1 f8 06 48 c1 e0 0c 48 03 05 90 5a 1b ea 48 01 c8 <0f> b7 00 83 aa c0
> > 0a 00 00 01 65 ff 0d bc e4 41 3f 0f 84 05 01 00
> > RSP: 0018:ff46821ba664fdf8 EFLAGS: 00010282
> > RAX: ff2fb3063deb1002 RBX: 0000000000000a20 RCX: 0000000000000002
> > RDX: ff2fb318d2f94380 RSI: 0000000000000002 RDI: 0000000000000001
> > RBP: ff2fb3065e832410 R08: ff46821ba664fe00 R09: 0000000000000001
> > R10: 0000000000000000 R11: 000000000000000d R12: ff2fb3065e832488
> > R13: ff2fb3065e8324a8 R14: ff2fb3065e8324c8 R15: ff2fb3065e8324a8
> > FS:  0000000000000000(0000) GS:ff2fb3257fac0000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ff2fb3063deb1002 CR3: 0000001392010006 CR4: 0000000000771ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> >   mlx5_cvq_kick_handler+0x89/0x2b0 [mlx5_vdpa]
> >   process_one_work+0x1e2/0x3b0
> >   ? rescuer_thread+0x390/0x390
> >   worker_thread+0x50/0x3a0
> >   ? rescuer_thread+0x390/0x390
> >   kthread+0xd6/0x100
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x1f/0x30
> >   </TASK>
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> mlx5_get_vq_dma_dev needs to made static.

Right, I will fix it in v2.

> Other than that:
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Tested-by: <elic@nvidia.com>

Thanks

>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Tested-by: <elic@nvidia.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 6632651b1e54..b0e74c25bf48 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2682,6 +2682,16 @@ static int mlx5_vdpa_set_map(struct vdpa_device
> > *vdev, unsigned int asid,
> >       return err;
> >  }
> >
> > +struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > +
> > +     if (is_ctrl_vq_idx(mvdev, idx))
> > +             return &vdev->dev;
> > +
> > +     return mvdev->vdev.dma_dev;
> > +}
> > +
> >  static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >  {
> >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > @@ -2897,6 +2907,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops
> > = {
> >       .get_generation = mlx5_vdpa_get_generation,
> >       .set_map = mlx5_vdpa_set_map,
> >       .set_group_asid = mlx5_set_group_asid,
> > +     .get_vq_dma_dev = mlx5_get_vq_dma_dev,
> >       .free = mlx5_vdpa_free,
> >       .suspend = mlx5_vdpa_suspend,
> >  };
> > --
> > 2.25.1
>

