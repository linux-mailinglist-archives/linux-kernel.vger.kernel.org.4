Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47F96825F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAaIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAaIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:00:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3386B40BF5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675151960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WtNudo9NGQKDE7DKx2KtogwCJrm4L/oIy9aFYNx6RA=;
        b=DW+9/8aacrMA0jXRw7wqM+Mxz1h+EJIuu91r//C97Gk0p4zmExIbtM2VlaiWCpwp9+0B8r
        eXiYZE6GcgQLGCiWkGhJB1ZQnrue2w3AZgf3lFy1/cehPU2S01kgZ+aKM/Qq8PJZrh3QGQ
        WWcprzHV3lHV6Y3exFbrWLoBfYp92Tw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-Bpg6BLsSNey19w6s05obDg-1; Tue, 31 Jan 2023 02:59:14 -0500
X-MC-Unique: Bpg6BLsSNey19w6s05obDg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-509ab88f98fso150787317b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WtNudo9NGQKDE7DKx2KtogwCJrm4L/oIy9aFYNx6RA=;
        b=2XHnhY0//o4ONX8ZTU0TpANl/igjtjsVo3Zry2VNjFJKwcUXjcGjOvkf9XZ9kejxwj
         nijo9W6AOrc4Auj8+VD4yb6PH8OkdTAoIAxjQjYDxsG2BCcCNGhWGLggP+Qz4qPAycfk
         vP1J64GnugCIiwF9eEXs0nrNQGgvuvQT5SlDjmc4gaHy9AoT6Fu0HxnaOh7ql7vTvlvb
         fRn4SuxHpGdUNEwR/TK2tKJydNAAd3SCOn4Mb9zY+gtN/RSB2XE8RNazZYrvLyT+p3GX
         w67kPqN6TydpM7ixjGowK4TiKl06Gukwtq5oZRLWCc7MivtRn82zMnHrgtoaVdg5gTWq
         GF0Q==
X-Gm-Message-State: AFqh2koOq1jr22wP93x853Nqur3Bdo+ROtTJt5KMPtmsZxhu7qcJcl0z
        zGnY0zJQoZvbBYebQP93tWgYGG6Fr3mqfI/3nldJAyovDunvXygxiam/KFGkGJt7wOzkUXC0MTK
        C1LMz8od4QGrbOEYlhrI36skzldZjqBqVfLJ7fhcb
X-Received: by 2002:a0d:e944:0:b0:499:f27a:2924 with SMTP id s65-20020a0de944000000b00499f27a2924mr7090415ywe.411.1675151954041;
        Mon, 30 Jan 2023 23:59:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvOppYZ9Y/Uq8bgptVGV5yE1bfu/bcMG7Bt7H8yEy2iKexqHdUh0mcHLXVhGOe/pN4Sk7Pz2BMuZBPb0BLAyrs=
X-Received: by 2002:a0d:e944:0:b0:499:f27a:2924 with SMTP id
 s65-20020a0de944000000b00499f27a2924mr7090411ywe.411.1675151953814; Mon, 30
 Jan 2023 23:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
 <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
 <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com> <CACGkMEubK3jRyKy5_TsRvKtcUQ2dYnr_hEnWwds4ZtewVsxz_Q@mail.gmail.com>
In-Reply-To: <CACGkMEubK3jRyKy5_TsRvKtcUQ2dYnr_hEnWwds4ZtewVsxz_Q@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 31 Jan 2023 08:58:37 +0100
Message-ID: <CAJaqyWcqnHAkUv9UZF=dOukg0C5u2g+eB-G5g8p+adcGZwRB_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, leiyang@redhat.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
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

On Tue, Jan 31, 2023 at 4:16 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Jan 31, 2023 at 12:39 AM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Sun, Jan 29, 2023 at 7:01 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jan 19, 2023 at 4:11 PM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > >
> > > > > On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > > > > >
> > > > > > Starting from an used_idx different than 0 is needed in use cas=
es like
> > > > > > virtual machine migration.  Not doing so and letting the caller=
 set an
> > > > > > avail idx different than 0 causes destination device to try to =
use old
> > > > > > buffers that source driver already recover and are not availabl=
e
> > > > > > anymore.
> > > > > >
> > > > > > While callers like vdpa_sim set avail_idx directly it does not =
set
> > > > > > used_idx.  Instead of let the caller do the assignment, fetch i=
t from
> > > > > > the guest at initialization like vhost-kernel do.
> > > > > >
> > > > > > To perform the same at vring_kernel_init and vring_user_init is=
 left for
> > > > > > the future.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> > > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > > > > index 33eb941fcf15..0eed825197f2 100644
> > > > > > --- a/drivers/vhost/vringh.c
> > > > > > +++ b/drivers/vhost/vringh.c
> > > > > > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const st=
ruct vringh *vrh,
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * vringh_update_used_idx - fetch used idx from driver's used =
split vring
> > > > > > + * @vrh: The vring.
> > > > > > + *
> > > > > > + * Returns -errno or 0.
> > > > > > + */
> > > > > > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > > > > > +{
> > > > > > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vri=
ng.used->idx);
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * vringh_init_iotlb - initialize a vringh for a ring with IOT=
LB.
> > > > > >   * @vrh: the vringh to initialize.
> > > > > > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh=
, u64 features,
> > > > > >                       struct vring_avail *avail,
> > > > > >                       struct vring_used *used)
> > > > > >  {
> > > > >
> > > > > While at this, I wonder if it's better to have a dedicated parame=
ter
> > > > > for last_avail_idx?
> > > > >
> > > >
> > > > I also had that thought. To directly assign last_avail_idx is not a
> > > > specially elegant API IMO.
> > > >
> > > > Maybe expose a way to fetch used_idx from device vring and pass
> > > > used_idx as parameter too?
> > >
> > > If I was not wrong, we can start from last_avail_idx, for used_idx it
> > > is only needed for inflight descriptors which might require other
> > > APIs?
> > >
> > > (All the current vDPA user of vringh is doing in order processing)
> > >
> >
> > That was actually my first attempt and it works equally well for the
> > moment, but it diverges from vhost-kernel behavior for little benefit.
> >
> > To assign both values at set_vring_base mean that if vDPA introduces
> > an (hypothetical) VHOST_VDPA_F_INFLIGHT backend feature in the future,
> > the initialization process would vary a lot:
> > * Without that feature, the used_idx starts with 0, and the avail one
> > is 0 or whatever value the user set with vring_set_base.
> > * With that feature, the device will read guest's used_idx as
> > vhost-kernel? We would enable a new ioctl to set it, or expand
> > set_base to include used_idx, effectively diverting from vhost-kernel?
>
> Adding Longpeng who is looking at this.
>

Sorry, I'll CC longpeng2@huawei.com in future series like this one.

> We can leave this to the caller to decide.
>
> Btw, a question, at which case the device used index does not equal to
> the used index in the vring when the device is suspended? I think the
> correct way is to flush the pending used indexes before suspending.
> Otherwise we need an API to get pending used indices?
>
> >
> > To me the wisest option is to move this with vhost-kernel. Maybe we
> > need to add a feature bit to know that the hypervisor can trust the
> > device will do "the right thing" (VHOST_VDPA_F_FETCH_USED_AT_ENABLE?),
> > but we should keep it orthogonal to inflight descriptor migration in
> > my opinion.
>
> I think we need to understand if there are any other possible use
> cases for setting used idx other than inflight stuff.
>

Answering this and the previous comment, I cannot think in any case
outside of inflight migration. I'm just trying to avoid different
behavior between vhost-kernel and vhost-vdpa, and to make features as
orthogonal as possible.

> >
> > Having said that, I'm totally ok to do it otherwise (or to expand the
> > patch message if needed).
>
> I tend to do that in another series (not mix with the fixes).
>
> >
> > > >
> > > > > > -       return vringh_init_kern(vrh, features, num, weak_barrie=
rs,
> > > > > > -                               desc, avail, used);
> > > > > > +       int r =3D vringh_init_kern(vrh, features, num, weak_bar=
riers, desc,
> > > > > > +                                avail, used);
> > > > > > +
> > > > > > +       if (r !=3D 0)
> > > > > > +               return r;
> > > > > > +
> > > > > > +       /* Consider the ring not initialized */
> > > > > > +       if ((void *)desc =3D=3D used)
> > > > > > +               return 0;
> > > > >
> > > > > I don't understand when we can get this (actually it should be a =
bug
> > > > > of the caller).
> > > > >
> > > >
> > > > You can see it in vdpasim_vq_reset.
> > > >
> > > > Note that to consider desc =3D=3D 0 to be an uninitialized ring is =
a bug
> > > > IMO. QEMU considers it that way also, but the standard does not for=
bid
> > > > any ring to be at address 0. Especially if we use vIOMMU.
> > > >
> > > > So I think the best way to know if we can use the vringh is either
> > > > this way, or provide an explicit "initialized" boolean attribute.
> > > > Maybe a new "bool is_initialized(vrh)" is enough, if we don't want =
to
> > > > add new attributes.
> > >
> > > I wonder if we can avoid this in the simulator level instead of the
> > > vringh (anyhow it only exposes a vringh_init_xxx() helper now).
> > >
> >
> > In my opinion that is a mistake if other drivers will use it to
> > implement the emulated control virtqueue. And it requires more
> > changes. But it is doable for sure.
>
> The problem is, there's no reset API in vringh, that's why you need to
> do if ((void *)desc =3D=3D used) which depends on behaviour of the vringh
> user.
>

That's a very good point indeed.

> So I think we should either:
>
> 1) move that check in vdpa_sim (since it's not guaranteed that all the
> vringh users will make desc equal to used during reset)
>
> or
>
> 2) introduce a vringh_reset_xxx()
>
> 1) seems a good step for -stable.
>

We can go to 1 for sure. So let's set last_used_idx at
vdpasim_set_vq_state, same value as last_avail_idx, and stash it at
vdpasim_queue_ready.

Do I need to resend the previous patch in this series?

Do we need to offer a new feature flag indicating we will set used_idx
with avail_idx?

Thanks!

