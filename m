Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9454686CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjBAR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBAR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F4FE05B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675272355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7y1fIGIbJjAc6cgonvw6ScmNaAecEK28xV0DcGW6vI=;
        b=Kb5DQ7tb7Okgqpd6gqWzzncNbmnkrZArDCtsANx55vXEr+MCQQ9x3DVj6TJ7VFi6+feKl0
        FXiQyPirqPvSYkcWir3a4o9aLDIJmSmbwjy/ozPxWeqQYY4vKPgDah9VQxBtl6aZRUzUbg
        dZofW4T0yXiQNsioXfmMo6vah1TQWOU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-V6DhySHeNq-huhODbEifgw-1; Wed, 01 Feb 2023 12:25:17 -0500
X-MC-Unique: V6DhySHeNq-huhODbEifgw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-50e79ffba49so153887737b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 09:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7y1fIGIbJjAc6cgonvw6ScmNaAecEK28xV0DcGW6vI=;
        b=V+BO5t9PNMA+ACc8W3QJKhDw3os5P3EiAR2/d1W15sMjzePoxV6qzeD7NGjjFVI0bn
         1qoy1XDTfVUaEmannhnew5ChUQJcF0V8/oRMv3zoQaadZwdAZM41OnPiiNfC77OFHPO5
         IcusY6ZB+Je0UPyS1P8UZBMfpC5yN1ED2ILaz5GWO5lj5Y5M6ZWbqUmOfKDg89a4XJz5
         TTntfYnwaeP49kLIJy36dPntsWJMNUvzTTReVmsMrJuIczWP7rQdzuOKYIZUilN4fWro
         k6n+3BaY6dM9i/7R5oepbsqCT7SerBa6X80MTmDlzh8BJi6aGxXnmBvI67h0Y97DunSE
         3xPQ==
X-Gm-Message-State: AO0yUKV4H1pcSE6P0X2N3DT3S2gydxUqggpyy6txdJ171t0P9VjJ79zC
        jROVPDxvELf6Uwp+8d5/YtRyfSwYNZqS9cli8YviMxSM/lStuW8Z6UIy/I8CgDRzqfG2pILAqwJ
        hhDwS2JqdRs3EjUw8+PtBS1BeV6fKuX+T9X+iG+GY
X-Received: by 2002:a25:d28b:0:b0:6fb:5983:d192 with SMTP id j133-20020a25d28b000000b006fb5983d192mr453332ybg.163.1675272282838;
        Wed, 01 Feb 2023 09:24:42 -0800 (PST)
X-Google-Smtp-Source: AK7set8tQjttePQIjFMEXPc2trwl4WUwjUZ5ieq9x9GsbFjQURMjQYMK1bjffjVThISX2U5tOEmqJjlBVRORvga3c+o=
X-Received: by 2002:a25:d28b:0:b0:6fb:5983:d192 with SMTP id
 j133-20020a25d28b000000b006fb5983d192mr453321ybg.163.1675272282601; Wed, 01
 Feb 2023 09:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
 <20230201111108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230201111108-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 1 Feb 2023 18:24:06 +0100
Message-ID: <CAJaqyWdaTY=fHpKxOhWw1Ap-FT4taZB3FogVuMa-Ackjdfz0vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     leiyang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
        sgarzare@redhat.com, jasowang@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
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

On Wed, Feb 1, 2023 at 5:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 18, 2023 at 05:43:59PM +0100, Eugenio P=C3=A9rez wrote:
> > Starting from an used_idx different than 0 is needed in use cases like
> > virtual machine migration.  Not doing so and letting the caller set an
> > avail idx different than 0 causes destination device to try to use old
> > buffers that source driver already recover and are not available
> > anymore.
> >
> > While callers like vdpa_sim set avail_idx directly it does not set
> > used_idx.  Instead of let the caller do the assignment, fetch it from
> > the guest at initialization like vhost-kernel do.
> >
> > To perform the same at vring_kernel_init and vring_user_init is left fo=
r
> > the future.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>
> So I applied 1/2 and dropped 2/2 for now, right?
>

Yes, please. 2/2 needs tweaking, I'll address them ASAP.

Thanks!

> > ---
> >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 33eb941fcf15..0eed825197f2 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct vri=
ngh *vrh,
> >       return 0;
> >  }
> >
> > +/**
> > + * vringh_update_used_idx - fetch used idx from driver's used split vr=
ing
> > + * @vrh: The vring.
> > + *
> > + * Returns -errno or 0.
> > + */
> > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > +{
> > +     return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->i=
dx);
> > +}
> > +
> >  /**
> >   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
> >   * @vrh: the vringh to initialize.
> > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 fe=
atures,
> >                     struct vring_avail *avail,
> >                     struct vring_used *used)
> >  {
> > -     return vringh_init_kern(vrh, features, num, weak_barriers,
> > -                             desc, avail, used);
> > +     int r =3D vringh_init_kern(vrh, features, num, weak_barriers, des=
c,
> > +                              avail, used);
> > +
> > +     if (r !=3D 0)
> > +             return r;
> > +
> > +     /* Consider the ring not initialized */
> > +     if ((void *)desc =3D=3D used)
> > +             return 0;
> > +
> > +     return vringh_update_used_idx(vrh);
> > +
> >  }
> >  EXPORT_SYMBOL(vringh_init_iotlb);
> >
> > --
> > 2.31.1
>

