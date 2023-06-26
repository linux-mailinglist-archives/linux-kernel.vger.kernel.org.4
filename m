Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8E73D622
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjFZDJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZDJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8810B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687748909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+pWG1D7e/A+cYywe5zVuMMMFISdk9+OXc1rsWGkOHM=;
        b=NuHZ434nY1dO5l7dHzW2jri5CCF1MylNL81u5BxVxEhYT/0sfo7UY060CbzuQ33+OHlrKZ
        t4XO77dMabOe//xdoz/WGPYMFTVDEHzWch9es9FrZnN/D1vA1Ga7VtK+qgW/hvF70JtVUF
        IUpkAM5gmnsTR1bQryvG/yege4iRxb0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-w0uMPrhnPgmJF4TB0kwzlA-1; Sun, 25 Jun 2023 23:08:28 -0400
X-MC-Unique: w0uMPrhnPgmJF4TB0kwzlA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f9644c21acso1322821e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687748906; x=1690340906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+pWG1D7e/A+cYywe5zVuMMMFISdk9+OXc1rsWGkOHM=;
        b=FvKItrobmmF4KEc4Ua93bUjPMI6aGDG5dvDPdHnF1UhYTl5h153dTGFpembWmCAr/1
         21h0eLxSOdqOt8UPoE3ySgoGX6rw3QJ0X4Cvw8efo7C4Qesh2wXe5mryC+PVA3X8KWTf
         TAjnh+EnA/MK7YyYNJOdmK/pE5nn7XgklnfKZXLYkLYUn4bkUoOIKaXyykaMqVxW4UQx
         55X+MmK5w9GZvutB2ddzTfqCGl5BQyzKMzfLStbFOwqe5m1tsEqs4VuU20IVudTxii+l
         HegbXde3GKbZfAzGUqCo7+3I2E6O5GXuA9QSXtUh8jFomhxTfk8k23o8Vg9fd1HmwFVk
         elUQ==
X-Gm-Message-State: AC+VfDyjYAbrRBmA8Gry8Cz3Bu4XFA35lfXy1GlrTsu/TlHr1VrRxVpS
        kkjRhYRMlJ/PA/c2D8pxN/p18Ro1ntrc1jP0t8YB+qdoIaC/ularPXQ9fP5FrX6n1jJTYZUIvpz
        NieshDdGljfYKEkhJNCp0Mk9YgcMOfglexgkmpWaf
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id a29-20020a195f5d000000b004f85e62b94bmr7989841lfj.9.1687748906741;
        Sun, 25 Jun 2023 20:08:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gAcONiUlVNLeF7Qu1J/UqNC75pdvtjmEEQ5QFLm5RQJMRkgS7gOiIiu3IidnT3bJ9UC8bqWPi+QRSmCToDlY=
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id
 a29-20020a195f5d000000b004f85e62b94bmr7989838lfj.9.1687748906397; Sun, 25 Jun
 2023 20:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
 <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEuXfo3DRrAfrwFPfKaOTCkmJ7hxVw=JVP12mPBM8Ccp=A@mail.gmail.com> <TY2PR06MB3424EA4EADAE511ED3CB282C8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB3424EA4EADAE511ED3CB282C8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Jun 2023 11:08:15 +0800
Message-ID: <CACGkMEuDKivK69Fky3y9UqC3VCk=e1f98QmkxNqVZcW1-PF4tw@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 11:02=E2=80=AFAM Angus Chen <angus.chen@jaguarmicro=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, June 26, 2023 10:51 AM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device=
 from
> > add_config
> >
> > On Mon, Jun 26, 2023 at 10:42=E2=80=AFAM Angus Chen <angus.chen@jaguarm=
icro.com>
> > wrote:
> > >
> > >
> > > Hi=EF=BC=8Cjason.
> > > > -----Original Message-----
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Monday, June 26, 2023 10:30 AM
> > > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa de=
vice
> > from
> > > > add_config
> > > >
> > > > On Thu, Jun 8, 2023 at 5:02=E2=80=AFPM Angus Chen
> > <angus.chen@jaguarmicro.com>
> > > > wrote:
> > > > >
> > > > > When add virtio_pci vdpa device,check the vqs number of device ca=
p
> > > > > and max_vq_pairs from add_config.
> > > > > Simply starting from failing if the provisioned #qp is not
> > > > > equal to the one that hardware has.
> > > > >
> > > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > > ---
> > > > > v1: Use max_vqs from add_config
> > > > > v2: Just return fail if max_vqs from add_config is not same as de=
vice
> > > > >         cap. Suggested by jason.
> > > > >
> > > > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------=
------
> > > > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > > index 281287fae89f..c1fb6963da12 100644
> > > > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > > @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct
> > > > vdpa_mgmt_dev *v_mdev, const char *name,
> > > > >         u64 device_features;
> > > > >         int ret, i;
> > > > >
> > > > > -       vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > > > -                                   dev, &vp_vdpa_ops, 1, 1,
> > name,
> > > > false);
> > > > > -
> > > > > -       if (IS_ERR(vp_vdpa)) {
> > > > > -               dev_err(dev, "vp_vdpa: Failed to allocate vDPA
> > > > structure\n");
> > > > > -               return PTR_ERR(vp_vdpa);
> > > > > +       if (add_config->mask &
> > > > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > > > > +               if (add_config->net.max_vq_pairs !=3D
> > > > (v_mdev->max_supported_vqs / 2)) {
> > > > > +                       dev_err(&pdev->dev, "max vqs 0x%x should
> > be
> > > > equal to 0x%x which device has\n",
> > > > > +                               add_config->net.max_vq_pairs*2,
> > > > v_mdev->max_supported_vqs);
> > > > > +                       return -EINVAL;
> > > > > +               }
> > > > >         }
> > > > >
> > > > > -       vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > > > > -
> > > > > -       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > > > > -       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> > > > > -       vp_vdpa->mdev =3D mdev;
> > > > > -
> > > > >         device_features =3D vp_modern_get_features(mdev);
> > > > >         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES))
> > {
> > > > >                 if (add_config->device_features & ~device_feature=
s) {
> > > > > -                       ret =3D -EINVAL;
> > > > >                         dev_err(&pdev->dev, "Try to provision
> > features
> > > > "
> > > > >                                 "that are not supported by the
> > device:
> > > > "
> > > > >                                 "device_features 0x%llx
> > provisioned
> > > > 0x%llx\n",
> > > > >                                 device_features,
> > > > add_config->device_features);
> > > > > -                       goto err;
> > > > > +                       return -EINVAL;
> > > > >                 }
> > > > >                 device_features =3D add_config->device_features;
> > > > >         }
> > > > > +
> > > > > +       vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > > > +                                   dev, &vp_vdpa_ops, 1, 1,
> > name,
> > > > false);
> > > > > +
> > > > > +       if (IS_ERR(vp_vdpa)) {
> > > > > +               dev_err(dev, "vp_vdpa: Failed to allocate vDPA
> > > > structure\n");
> > > > > +               return PTR_ERR(vp_vdpa);
> > > > > +       }
> > > > > +
> > > > > +       vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > > > > +
> > > > > +       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > > > > +       vp_vdpa->queues =3D v_mdev->max_supported_vqs;
> > > >
> > > > Why bother with those changes?
> > > >
> > > >         mgtdev->max_supported_vqs =3D
> > vp_modern_get_num_queues(mdev);
> > > max_supported_vqs will not be changed, so we can get max_supported_vq=
s
> > from mgtdev->max_supported_vqs.
> > > If we use vp_modern_get_num_queues(mdev),it will use tlp to communica=
te
> > with device.
> > > It just reduce some tlp .
> >
> > Ok, but
> >
> > 1) I think we don't care the performance here
> > 2) If we did, let's use a separate patch to do that as an optimization
> >
> Thank you.As mst did not support this patch some days ago,so this patch w=
ill be dropped.
> I plan to push a dependent driver of our product rather than reuse vp_vdp=
a.

That would be fine. But please try best to reuse modern virtio-pci library.

> By the way ,if I want to add sriov support in our vdpa pci driver,would i=
t be accepted or not?

I think the answer is yes.

Thanks

> > Thanks
> >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > > +       vp_vdpa->mdev =3D mdev;
> > > > >         vp_vdpa->device_features =3D device_features;
> > > > >
> > > > >         ret =3D devm_add_action_or_reset(dev,
> > vp_vdpa_free_irq_vectors,
> > > > pdev);
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
>

