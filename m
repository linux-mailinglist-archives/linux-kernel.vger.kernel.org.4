Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90573D60C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFZCwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFZCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1075103
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687747885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0vYrUDyV/6RMq5CSF7DYnD/d7A80ahqpZ8xKzvwRDs=;
        b=AVEE5EwpUrXj5dBZ3eWEZ2ysvKud0SjBpSplf8cAhPvVuHyKXT8WZKBQ6MAIK8EGo8kXwy
        dpjq1u9V2KuHSB3bUy/xEIrtV9QnwdY43Ea3S4UcLuMTGylMxSZnm5FPtRXFZh5sITkZwt
        SZ6ZLfBL+zZ+a80rQgHVQFVUttU/aIE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-cWrcLcTiM-erIb4hf6Iiyg-1; Sun, 25 Jun 2023 22:51:24 -0400
X-MC-Unique: cWrcLcTiM-erIb4hf6Iiyg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb76659d44so202828e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687747882; x=1690339882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0vYrUDyV/6RMq5CSF7DYnD/d7A80ahqpZ8xKzvwRDs=;
        b=Uq0CtFJmGxQSBeXCO1ogFKTLPvB6xb5yWhWP9KJsqDKVZ8akz+0Q1nrSsrRVs1oUl5
         ni/hx2fr/a0x/uj488dSsXrhI73K+DRSlQax0Fk7yQ/InG8dKPuRFyN2UbZOVIVWXAgU
         CPCiLsDxoAMe3CZRlCEh9EJkyq4PvAx4GaMEoi8MJvCnUu87OV3CYP48lIfi6645/cjk
         5Rv3hjIA5Z1lEd5EY6As7lGEDoQypsBktTnpWuHr2Vkk55joVWSG1v3ywwgNcaEJZT8T
         4Ib0fuwbMwRc1EAXZQi1DPQfz2jsZYGdcolTwl4OXwmkp8fXL0amj/iWAD60gDDlLs9q
         3RrQ==
X-Gm-Message-State: AC+VfDyDl9lAwGJoPWtMqgeJIs7nS0TJD4TyuJPC7yMf8NaL82WzaVGu
        BZbl/9Y9mA0BF+3UCTv2TeGrIlFRhu1tx23BeF7clY+neLygngCu0vI6kk/5ZISxWiP2/foxbaq
        PC8CNqE5RwOvCyCspXb+STiJQxoyRadlmsmKHRrdX
X-Received: by 2002:a19:e34a:0:b0:4f8:4263:42f with SMTP id c10-20020a19e34a000000b004f84263042fmr15449490lfk.17.1687747882744;
        Sun, 25 Jun 2023 19:51:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4u/Cj2EZgmu8RH/cDDxOTUvw6aWO+J3zOZLz0Q8XLq33+9vmn8d4xns+raM0RyE3hqVH1pfKjQpvbICCgQbmM=
X-Received: by 2002:a19:e34a:0:b0:4f8:4263:42f with SMTP id
 c10-20020a19e34a000000b004f84263042fmr15449488lfk.17.1687747882465; Sun, 25
 Jun 2023 19:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com> <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Jun 2023 10:51:11 +0800
Message-ID: <CACGkMEuXfo3DRrAfrwFPfKaOTCkmJ7hxVw=JVP12mPBM8Ccp=A@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from add_config
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:42=E2=80=AFAM Angus Chen <angus.chen@jaguarmicro=
.com> wrote:
>
>
> Hi=EF=BC=8Cjason.
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, June 26, 2023 10:30 AM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device=
 from
> > add_config
> >
> > On Thu, Jun 8, 2023 at 5:02=E2=80=AFPM Angus Chen <angus.chen@jaguarmic=
ro.com>
> > wrote:
> > >
> > > When add virtio_pci vdpa device,check the vqs number of device cap
> > > and max_vq_pairs from add_config.
> > > Simply starting from failing if the provisioned #qp is not
> > > equal to the one that hardware has.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > > v1: Use max_vqs from add_config
> > > v2: Just return fail if max_vqs from add_config is not same as device
> > >         cap. Suggested by jason.
> > >
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-----------=
--
> > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 281287fae89f..c1fb6963da12 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct
> > vdpa_mgmt_dev *v_mdev, const char *name,
> > >         u64 device_features;
> > >         int ret, i;
> > >
> > > -       vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > -                                   dev, &vp_vdpa_ops, 1, 1, name,
> > false);
> > > -
> > > -       if (IS_ERR(vp_vdpa)) {
> > > -               dev_err(dev, "vp_vdpa: Failed to allocate vDPA
> > structure\n");
> > > -               return PTR_ERR(vp_vdpa);
> > > +       if (add_config->mask &
> > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > > +               if (add_config->net.max_vq_pairs !=3D
> > (v_mdev->max_supported_vqs / 2)) {
> > > +                       dev_err(&pdev->dev, "max vqs 0x%x should be
> > equal to 0x%x which device has\n",
> > > +                               add_config->net.max_vq_pairs*2,
> > v_mdev->max_supported_vqs);
> > > +                       return -EINVAL;
> > > +               }
> > >         }
> > >
> > > -       vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > > -
> > > -       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > > -       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> > > -       vp_vdpa->mdev =3D mdev;
> > > -
> > >         device_features =3D vp_modern_get_features(mdev);
> > >         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > >                 if (add_config->device_features & ~device_features) {
> > > -                       ret =3D -EINVAL;
> > >                         dev_err(&pdev->dev, "Try to provision feature=
s
> > "
> > >                                 "that are not supported by the device=
:
> > "
> > >                                 "device_features 0x%llx provisioned
> > 0x%llx\n",
> > >                                 device_features,
> > add_config->device_features);
> > > -                       goto err;
> > > +                       return -EINVAL;
> > >                 }
> > >                 device_features =3D add_config->device_features;
> > >         }
> > > +
> > > +       vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > +                                   dev, &vp_vdpa_ops, 1, 1, name,
> > false);
> > > +
> > > +       if (IS_ERR(vp_vdpa)) {
> > > +               dev_err(dev, "vp_vdpa: Failed to allocate vDPA
> > structure\n");
> > > +               return PTR_ERR(vp_vdpa);
> > > +       }
> > > +
> > > +       vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > > +
> > > +       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > > +       vp_vdpa->queues =3D v_mdev->max_supported_vqs;
> >
> > Why bother with those changes?
> >
> >         mgtdev->max_supported_vqs =3D vp_modern_get_num_queues(mdev);
> max_supported_vqs will not be changed, so we can get max_supported_vqs fr=
om mgtdev->max_supported_vqs.
> If we use vp_modern_get_num_queues(mdev),it will use tlp to communicate w=
ith device.
> It just reduce some tlp .

Ok, but

1) I think we don't care the performance here
2) If we did, let's use a separate patch to do that as an optimization

Thanks

> >
> > Thanks
> >
> >
> > > +       vp_vdpa->mdev =3D mdev;
> > >         vp_vdpa->device_features =3D device_features;
> > >
> > >         ret =3D devm_add_action_or_reset(dev, vp_vdpa_free_irq_vector=
s,
> > pdev);
> > > --
> > > 2.25.1
> > >
>

