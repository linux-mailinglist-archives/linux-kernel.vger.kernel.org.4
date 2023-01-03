Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D865BBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjACIQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbjACIQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07697DEED
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672733740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBT39XTMOmL9bhDcTUw+nP4DkA+kGa0L8uAe6X+hHsI=;
        b=i9fUMxuFb2rsUhoj32utrqzFLGkfptBU447keplvilet+Jc5H0RM4EDM6K0e/8fLdF572K
        +eljeA1Ph21SQzL7l6A9P+VtzwD0GiKWV4pCtmiri7ytNSnLcsqdMfjBdvBxkJvsiPUbmg
        kxlSBqaFh70gr53+7B7N2XAh2jwwIcI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-7taD9nXaMwasV24olleJzw-1; Tue, 03 Jan 2023 03:15:39 -0500
X-MC-Unique: 7taD9nXaMwasV24olleJzw-1
Received: by mail-ot1-f69.google.com with SMTP id s22-20020a9d7596000000b0066eb4e77127so15802521otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBT39XTMOmL9bhDcTUw+nP4DkA+kGa0L8uAe6X+hHsI=;
        b=xQJmTqpO+gDwbLMiEPtjXqYlBc/2UE8SCGgj6aZ/tZzH2lXpWet1xQ6NxhMirwt3EE
         WkvUJJiAqKtpn5ovqJkAhvONY0b17W7ijN0qSXWL+mno/ReAMQuaI4+8XtMy+/YU0DJp
         f43JuRVJtl5pHb4fuEygoIyb7ZUipVO+W9XBEERoNGpuvP+VOJ8p9rV8wLPzTEIsllyz
         EKK/m1IuIP67bOMLP64rBTsmfWhPaoC+YTSeRrBOTFs0qWYUSg8LdmZ+9uIH5XcmVA/v
         dfhT5Oavt2ldhWIHYEMp0t6F+H8TcVRB2TfdOCgGB5GrZG8rzmWxCKZcwGsdMkIwwxU4
         P1/A==
X-Gm-Message-State: AFqh2krEyCdyedREoal8rWMo1pDe2mMMiXdPUEMSPajoR60O/47Mvwy+
        NuaWuDZVN+ndGX850f4WP50/qCPp1nF1saRHr1iB7Ae1xOlOawW2cA+fsbLGu23PlvAJxp72abU
        az8PEqNWxgwpeA77ZTF2j0zjwiXmStcytkNn7q58O
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id u19-20020a056870441300b00144a97b1ae2mr2155882oah.35.1672733738755;
        Tue, 03 Jan 2023 00:15:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1GGmg1HASqnfcpH0pIPC6Y5Ny3UPmj9l/BMmRYuoACIiumpcxK4Yyf7lIpX4Hm9LZeX5hxpzoMD0D+cVTdXk=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr2155877oah.35.1672733738512; Tue, 03
 Jan 2023 00:15:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
 <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
 <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com> <BY5PR11MB4401D90E9853727F06B309CFEAF79@BY5PR11MB4401.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB4401D90E9853727F06B309CFEAF79@BY5PR11MB4401.namprd11.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 3 Jan 2023 16:15:27 +0800
Message-ID: <CACGkMEuP9DaWq7kiFrkYqt2CxwuTqc4iMpypUOLLLzBzn1rm2Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
To:     "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 12:52 AM Boeuf, Sebastien
<sebastien.boeuf@intel.com> wrote:
>
> Hi Jason,
>
> Are you suggesting we do something like the following:
>
> if ((!vdpasim->running) && (vdpasim->status =3D=3D DRIVER_OK)) {
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82vdpasim->pending_ki=
ck =3D true;
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82return;
> }
>
> ?

Yes.

Thanks

>
> Thanks,
> Sebastien
> ________________________________
> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, November 7, 2022 8:43 AM
> To: Boeuf, Sebastien <sebastien.boeuf@intel.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; virtuali=
zation@lists.linux-foundation.org <virtualization@lists.linux-foundation.or=
g>; mst@redhat.com <mst@redhat.com>; eperezma@redhat.com <eperezma@redhat.c=
om>
> Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
>
> On Wed, Oct 26, 2022 at 11:09 PM <sebastien.boeuf@intel.com> wrote:
> >
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> >
> > Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> > offer that backend feature and userspace can effectively resume the
> > device.
> >
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> > index b071f0d842fb..84fee8bb2929 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -357,6 +357,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vd=
pa, u16 idx)
> >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> >
> > +       if (!vdpasim->running) {
> > +               vdpasim->pending_kick =3D true;
> > +               return;
>
> I think we may hit here when the driver kicks vq before DRIVER_OK. Do
> we need to check device status in this case and resume?
>
> Thanks
>
> > +       }
> > +
> >         if (vq->ready)
> >                 schedule_work(&vdpasim->work);
> >  }
> > @@ -527,6 +532,27 @@ static int vdpasim_suspend(struct vdpa_device *vdp=
a)
> >         return 0;
> >  }
> >
> > +static int vdpasim_resume(struct vdpa_device *vdpa)
> > +{
> > +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > +       int i;
> > +
> > +       spin_lock(&vdpasim->lock);
> > +       vdpasim->running =3D true;
> > +
> > +       if (vdpasim->pending_kick) {
> > +               /* Process pending descriptors */
> > +               for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
> > +                       vdpasim_kick_vq(vdpa, i);
> > +
> > +               vdpasim->pending_kick =3D false;
> > +       }
> > +
> > +       spin_unlock(&vdpasim->lock);
> > +
> > +       return 0;
> > +}
> > +
> >  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > @@ -717,6 +743,7 @@ static const struct vdpa_config_ops vdpasim_config_=
ops =3D {
> >         .set_status             =3D vdpasim_set_status,
> >         .reset                  =3D vdpasim_reset,
> >         .suspend                =3D vdpasim_suspend,
> > +       .resume                 =3D vdpasim_resume,
> >         .get_config_size        =3D vdpasim_get_config_size,
> >         .get_config             =3D vdpasim_get_config,
> >         .set_config             =3D vdpasim_set_config,
> > @@ -750,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_c=
onfig_ops =3D {
> >         .set_status             =3D vdpasim_set_status,
> >         .reset                  =3D vdpasim_reset,
> >         .suspend                =3D vdpasim_suspend,
> > +       .resume                 =3D vdpasim_resume,
> >         .get_config_size        =3D vdpasim_get_config_size,
> >         .get_config             =3D vdpasim_get_config,
> >         .set_config             =3D vdpasim_set_config,
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/v=
dpa_sim.h
> > index 0e78737dcc16..a745605589e2 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -67,6 +67,7 @@ struct vdpasim {
> >         u64 features;
> >         u32 groups;
> >         bool running;
> > +       bool pending_kick;
> >         /* spinlock to synchronize iommu table */
> >         spinlock_t iommu_lock;
> >  };
> > --
> > 2.34.1
> >
> > ---------------------------------------------------------------------
> > Intel Corporation SAS (French simplified joint stock company)
> > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > 92196 Meudon Cedex, France
> > Registration Number:  302 456 199 R.C.S. NANTERRE
> > Capital: 5 208 026.16 Euros
> >
> > This e-mail and any attachments may contain confidential material for
> > the sole use of the intended recipient(s). Any review or distribution
> > by others is strictly prohibited. If you are not the intended
> > recipient, please contact the sender and delete all copies.
> >
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

