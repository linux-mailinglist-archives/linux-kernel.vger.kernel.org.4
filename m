Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0A673361
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjASIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjASIMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A24EF2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674115883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHaosMPT2TRXmVyMHOxOlp8TX7e5ajXgIFwsrPYijmY=;
        b=E04PeSS3LY4ZeWNHowN1ovf9T4DyWXB5+ee/c/erfL3L9cNa9LBOOS6uPtaTLo9qiWP1qB
        +YReEPyIueL6v31jVqBAHToVl8CzdUu6QAmd54OCony9uXnFMzG+UOx7P0ECicElEbPlDm
        uUB+29c0WNYk4HVHkp1x7pvOA7lzKwU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-5YbTUNnWMaeLnAFh1uXUog-1; Thu, 19 Jan 2023 03:11:22 -0500
X-MC-Unique: 5YbTUNnWMaeLnAFh1uXUog-1
Received: by mail-yb1-f198.google.com with SMTP id i17-20020a25bc11000000b007b59a5b74aaso1453786ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHaosMPT2TRXmVyMHOxOlp8TX7e5ajXgIFwsrPYijmY=;
        b=yo5mr2qQOuVfehDzd+L6M1fYsV87peGmGNvqSmODOlrXXtV0ohJiMC3XLrNz360NfN
         Xq6MsQWZHPo/DGOSVXTl8RwR8sptA3cQsjXNOIWQ2Bmmo+G1qgQbLDACYgitKCH4c2ON
         iP2voUm6Js+jcERybqWbu0DJppd2/31V0c9odUBGvkmMnQSvCcs44Mg24k0J2kTyoAgs
         jJrJ+2YNzp1qydcvCtFl7A5XYoXm85+aWDHsmrEuhgb57YfEbpwpAB4dZcH3xCTUKIlJ
         gK9aXn6a7IgioWBqv02pozOzVyee5RUJuWBzpGrWPeQKXfTyJLnJ8izZnC4GUOVhSsf+
         csZw==
X-Gm-Message-State: AFqh2kqU0yLza4Xs2GVyTCkUS3ZGVyb3c9jxvcWoo/nKooTncp+Tugzz
        c7Lsgf4DThqxPCH/vUc5LmCgcCo/DN3tKzBbNXWv18KsdSVLxUrJIA64IOaYOl+o3HQCsN/P/nr
        iQX3Kuhv5exwRKzAYlW3uZY/224osypbIrtaaxl7f
X-Received: by 2002:a25:60c4:0:b0:6fb:5983:d192 with SMTP id u187-20020a2560c4000000b006fb5983d192mr1231655ybb.163.1674115881479;
        Thu, 19 Jan 2023 00:11:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQWesmMCNlgjNKOio42EwP9OikciqzMOJlfuVvC0YUh+ntaAsQ5ZMZrCH6zCSVlNTduHi2E85f6moyhv9nd30=
X-Received: by 2002:a25:60c4:0:b0:6fb:5983:d192 with SMTP id
 u187-20020a2560c4000000b006fb5983d192mr1231645ybb.163.1674115881246; Thu, 19
 Jan 2023 00:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
In-Reply-To: <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 19 Jan 2023 09:10:45 +0100
Message-ID: <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, leiyang@redhat.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
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

On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.com>=
 wrote:
> >
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
> >         return 0;
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
> > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used-=
>idx);
> > +}
> > +
> >  /**
> >   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
> >   * @vrh: the vringh to initialize.
> > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 fe=
atures,
> >                       struct vring_avail *avail,
> >                       struct vring_used *used)
> >  {
>
> While at this, I wonder if it's better to have a dedicated parameter
> for last_avail_idx?
>

I also had that thought. To directly assign last_avail_idx is not a
specially elegant API IMO.

Maybe expose a way to fetch used_idx from device vring and pass
used_idx as parameter too?

> > -       return vringh_init_kern(vrh, features, num, weak_barriers,
> > -                               desc, avail, used);
> > +       int r =3D vringh_init_kern(vrh, features, num, weak_barriers, d=
esc,
> > +                                avail, used);
> > +
> > +       if (r !=3D 0)
> > +               return r;
> > +
> > +       /* Consider the ring not initialized */
> > +       if ((void *)desc =3D=3D used)
> > +               return 0;
>
> I don't understand when we can get this (actually it should be a bug
> of the caller).
>

You can see it in vdpasim_vq_reset.

Note that to consider desc =3D=3D 0 to be an uninitialized ring is a bug
IMO. QEMU considers it that way also, but the standard does not forbid
any ring to be at address 0. Especially if we use vIOMMU.

So I think the best way to know if we can use the vringh is either
this way, or provide an explicit "initialized" boolean attribute.
Maybe a new "bool is_initialized(vrh)" is enough, if we don't want to
add new attributes.

Thanks!

> Thanks
>
> > +
> > +       return vringh_update_used_idx(vrh);
> > +
> >  }
> >  EXPORT_SYMBOL(vringh_init_iotlb);
> >
> > --
> > 2.31.1
> >
>

