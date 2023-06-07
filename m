Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE8E7251F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbjFGCMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbjFGCME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12811732
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686103878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAd4y5+O3eSImifxafNCf4uviOOzmlDcfI8xA59qR88=;
        b=JEoU1KHV9NJ4hY/EO9Ow8FMnowiZRndPZr+JL7ynyZlnZ7wMT5Ze1ISo7eSUceQJug2r8J
        Y4p7f78wbfBPd7I0mVIVo/FHg3ZR7/Cu66RAekRxIZDwtIeEB1Zky6zMvBR3vdnVs+JyX7
        AJFUiN/Jjw1HKgdVc6f00Flcl/JVAwg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-psXx4mLLMNak69zd_4Da4w-1; Tue, 06 Jun 2023 22:11:16 -0400
X-MC-Unique: psXx4mLLMNak69zd_4Da4w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1bbe83720so23625031fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 19:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686103875; x=1688695875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAd4y5+O3eSImifxafNCf4uviOOzmlDcfI8xA59qR88=;
        b=SEhMv5kP0DgIgNqe/LdG8Z0EESnOjg7HhBzd2gRn/Jj/jECMdZBum/f+Ga59blJQ5U
         EkvARrsQrg3mGVUuhEB7ZHvC7Dg+2CgRVxJjG1ipQkVQuDWAsmrUKLA9ac1HaXiRbFUU
         ZMS+m9K1xQfpzLcJs3yPYhXrYaVPYvFLnQkYEfQ8XLdRxZC9vZJWI1fLAMpyfWrzEMEh
         Ydt6LnNGVUAvSj+dUldfPG2Ce7ukw9kxAs1MzDxL2CiGdysCPG75Dd4OtgIZOX2AhO4m
         wXeXEhG/nBh8l+Ws5A4VMRpFTAubkbKZcG+uBCOw6psViC9aC4gISTAP4fiVOP/HxlCd
         ezDA==
X-Gm-Message-State: AC+VfDwTtiY7KVPJdrxLwv2m3dFhmagqLVlNYx7CL7W+6UR9m71Nf6k2
        JTxbqoudbQ7w6x+ZGn/dv1jX8KGTw7vvfvegbGCxIr8gfBaeIXL4v/IeLsF/ocIrSSG1eWQULsN
        EAmBnqTlHCGZKXUvTLOzgJzj3kWKXpPt+CmUW1Bh1
X-Received: by 2002:a2e:8ec5:0:b0:2b1:bacc:b3de with SMTP id e5-20020a2e8ec5000000b002b1baccb3demr1831490ljl.4.1686103875354;
        Tue, 06 Jun 2023 19:11:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6R+ZVVNrV5JR/0mOo1J8T/eUXHMmTwBuEzsfzyI0zoS2SnPw2Hkxq9qXSvE2H4n13HyHfoP6+ksOC/s7B78NM=
X-Received: by 2002:a2e:8ec5:0:b0:2b1:bacc:b3de with SMTP id
 e5-20020a2e8ec5000000b002b1baccb3demr1831482ljl.4.1686103875058; Tue, 06 Jun
 2023 19:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
 <CACGkMEtCr-LGVH9QJRaMJ2VF3fyDX2zEVwOSJtb-gB_VtSTV2A@mail.gmail.com> <SG2PR06MB342012C05627EA6456EF59B18552A@SG2PR06MB3420.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB342012C05627EA6456EF59B18552A@SG2PR06MB3420.apcprd06.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 7 Jun 2023 10:11:04 +0800
Message-ID: <CACGkMEsWkyMOUmnFks9C73BMZB3i86Kg0ig745N3OjJs35PAuw@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: Check queue number of vdpa device from add_config
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 2:19=E2=80=AFPM Angus Chen <angus.chen@jaguarmicro.c=
om> wrote:
>
> Hi,Jason.
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, June 5, 2023 2:54 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] vp_vdpa: Check queue number of vdpa device from
> > add_config
> >
> > On Fri, Jun 2, 2023 at 3:35=E2=80=AFPM Angus Chen <angus.chen@jaguarmic=
ro.com>
> > wrote:
> > >
> > > When add virtio_pci vdpa device,check the vqs number of device cap
> > > and max_vq_pairs from add_config.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 281287fae89f..4bf1ab637d32 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -478,7 +478,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> > >         struct device *dev =3D &pdev->dev;
> > >         struct vp_vdpa *vp_vdpa =3D NULL;
> > >         u64 device_features;
> > > -       int ret, i;
> > > +       int ret, i, queues;
> > >
> > >         vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > >                                     dev, &vp_vdpa_ops, 1, 1, name,
> > false);
> > > @@ -491,7 +491,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> > >         vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > >
> > >         vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > > -       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> > > +       queues =3D vp_modern_get_num_queues(mdev);
> > > +       if (add_config->mask &
> > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > > +               if (add_config->net.max_vq_pairs > queues / 2)
> > > +                       return -EINVAL;
> > > +               queues =3D min_t(u32, queues, 2 *
> > add_config->net.max_vq_pairs);
> >
> > Looks like you want to mediate the max_vqp here, but what happens:
> >
> > 1) harware have 4 queue paris
> > 2) vp_vdpa cap it into 2 queue pairs
> > 3) guest may still try to enable 4 queue paris
> >
> Yes=EF=BC=8Cyou are right=EF=BC=8Cthis situation can occur.
> > For 3), the kernel needs to mediate the control virtqueue which seems n=
ot
> > easy.
> >
> > How about simply starting from failing if the provisioned #qp is not
> > equal to the one that hardware has?
> Ok,You mean we just check it in vp_vdpa or check it in all other vdpa net=
 drivers?

vp_vdpa only, since in some other kind of parents, #qps could be provisione=
d.

Thanks

> >
> > Thanks
> >
> > > +       }
> > > +
> > > +       vp_vdpa->queues =3D queues;
> > >         vp_vdpa->mdev =3D mdev;
> > >
> > >         device_features =3D vp_modern_get_features(mdev);
> > > --
> > > 2.25.1
> > >
>

