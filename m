Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5268681690
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjA3Qjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbjA3Qjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649A40C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675096745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOSbIQi6REbvWHHJ9e5FE37Vj75BNZRylNVQD9QT0pQ=;
        b=TSpUFt909PyMJ4z22DnrFUrufdDNonEzyqs+Z/ATwYaHcvNJ22nrSdyAnRCR1IgHN1UeA7
        8fwjQhoYaWmc7IHEBYnYGJI8uwjnJRJtQjlh8zHA4WYO5X/x9UK+OpFp9nLVhGITxdbvME
        IsEQdyl71d/bCrb6GUHG+jmKS29rCQQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-kCoo8ONzMhu_eDRoIXwS3Q-1; Mon, 30 Jan 2023 11:39:03 -0500
X-MC-Unique: kCoo8ONzMhu_eDRoIXwS3Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-50fe0b4495cso56134077b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOSbIQi6REbvWHHJ9e5FE37Vj75BNZRylNVQD9QT0pQ=;
        b=tPOIRVViXsfKtbm3LtBVgSVzoF6kl/Fvs4SMDeUNEthyGG4KkXtHoalD2h0J01yP5Y
         0cn6hMrtHiDC7gvlgzFJsIz3Psa07FmTaDJUFyNbI/RQd8asFMqVDRb4ryQhKezz9FdP
         WOBut4hIO6yyqNmVJ4+1eeW5JtV3QJF+akd8KsxJ3uXH3zBE8oHb/iDEifzO94iaF+RC
         ntbyh/rMBv7M2CeLIcapqhUdnv9j6H2LrVd8n8kygDa4Fx+OZhW2GTq+PQw1Mp/MwDF+
         rjqby7u/TL0xMalQV9AwtkZ3MvUBBpFFsiZTjHMUvF0IJfuhx6TdjlN+t32vM22ely9e
         ispw==
X-Gm-Message-State: AFqh2kosF33PokeRh3XCZcdrSguYPNfk9oJA7EsOAFQQxzd1h/Vx+eP9
        sUXM4WpHkpaIYB3GBRCSLun1sLuqPRpqoAFVKCcJkchPGaAZqc6i6JY5z2J3fUpPXI/N5gOs8Ul
        BvuhPEheFSLlbA15AvDqXM4TCOuWVguD3KOUo1st/
X-Received: by 2002:a81:7307:0:b0:464:4ea1:3baa with SMTP id o7-20020a817307000000b004644ea13baamr5257184ywc.302.1675096741822;
        Mon, 30 Jan 2023 08:39:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv8Hc/0PBjiy1yYTe003vP2IIsZJvaU/f7bDcxzL33GtEtZPIVXDJZQvbzZ3fSubJvmlhLDfrBek23FKfvj5Tw=
X-Received: by 2002:a81:7307:0:b0:464:4ea1:3baa with SMTP id
 o7-20020a817307000000b004644ea13baamr5257182ywc.302.1675096741551; Mon, 30
 Jan 2023 08:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com> <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
In-Reply-To: <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 30 Jan 2023 17:38:25 +0100
Message-ID: <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
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

On Sun, Jan 29, 2023 at 7:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 4:11 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
> > > >
> > > > Starting from an used_idx different than 0 is needed in use cases l=
ike
> > > > virtual machine migration.  Not doing so and letting the caller set=
 an
> > > > avail idx different than 0 causes destination device to try to use =
old
> > > > buffers that source driver already recover and are not available
> > > > anymore.
> > > >
> > > > While callers like vdpa_sim set avail_idx directly it does not set
> > > > used_idx.  Instead of let the caller do the assignment, fetch it fr=
om
> > > > the guest at initialization like vhost-kernel do.
> > > >
> > > > To perform the same at vring_kernel_init and vring_user_init is lef=
t for
> > > > the future.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > > index 33eb941fcf15..0eed825197f2 100644
> > > > --- a/drivers/vhost/vringh.c
> > > > +++ b/drivers/vhost/vringh.c
> > > > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct=
 vringh *vrh,
> > > >         return 0;
> > > >  }
> > > >
> > > > +/**
> > > > + * vringh_update_used_idx - fetch used idx from driver's used spli=
t vring
> > > > + * @vrh: The vring.
> > > > + *
> > > > + * Returns -errno or 0.
> > > > + */
> > > > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > > > +{
> > > > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.u=
sed->idx);
> > > > +}
> > > > +
> > > >  /**
> > > >   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
> > > >   * @vrh: the vringh to initialize.
> > > > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u6=
4 features,
> > > >                       struct vring_avail *avail,
> > > >                       struct vring_used *used)
> > > >  {
> > >
> > > While at this, I wonder if it's better to have a dedicated parameter
> > > for last_avail_idx?
> > >
> >
> > I also had that thought. To directly assign last_avail_idx is not a
> > specially elegant API IMO.
> >
> > Maybe expose a way to fetch used_idx from device vring and pass
> > used_idx as parameter too?
>
> If I was not wrong, we can start from last_avail_idx, for used_idx it
> is only needed for inflight descriptors which might require other
> APIs?
>
> (All the current vDPA user of vringh is doing in order processing)
>

That was actually my first attempt and it works equally well for the
moment, but it diverges from vhost-kernel behavior for little benefit.

To assign both values at set_vring_base mean that if vDPA introduces
an (hypothetical) VHOST_VDPA_F_INFLIGHT backend feature in the future,
the initialization process would vary a lot:
* Without that feature, the used_idx starts with 0, and the avail one
is 0 or whatever value the user set with vring_set_base.
* With that feature, the device will read guest's used_idx as
vhost-kernel? We would enable a new ioctl to set it, or expand
set_base to include used_idx, effectively diverting from vhost-kernel?

To me the wisest option is to move this with vhost-kernel. Maybe we
need to add a feature bit to know that the hypervisor can trust the
device will do "the right thing" (VHOST_VDPA_F_FETCH_USED_AT_ENABLE?),
but we should keep it orthogonal to inflight descriptor migration in
my opinion.

Having said that, I'm totally ok to do it otherwise (or to expand the
patch message if needed).

> >
> > > > -       return vringh_init_kern(vrh, features, num, weak_barriers,
> > > > -                               desc, avail, used);
> > > > +       int r =3D vringh_init_kern(vrh, features, num, weak_barrier=
s, desc,
> > > > +                                avail, used);
> > > > +
> > > > +       if (r !=3D 0)
> > > > +               return r;
> > > > +
> > > > +       /* Consider the ring not initialized */
> > > > +       if ((void *)desc =3D=3D used)
> > > > +               return 0;
> > >
> > > I don't understand when we can get this (actually it should be a bug
> > > of the caller).
> > >
> >
> > You can see it in vdpasim_vq_reset.
> >
> > Note that to consider desc =3D=3D 0 to be an uninitialized ring is a bu=
g
> > IMO. QEMU considers it that way also, but the standard does not forbid
> > any ring to be at address 0. Especially if we use vIOMMU.
> >
> > So I think the best way to know if we can use the vringh is either
> > this way, or provide an explicit "initialized" boolean attribute.
> > Maybe a new "bool is_initialized(vrh)" is enough, if we don't want to
> > add new attributes.
>
> I wonder if we can avoid this in the simulator level instead of the
> vringh (anyhow it only exposes a vringh_init_xxx() helper now).
>

In my opinion that is a mistake if other drivers will use it to
implement the emulated control virtqueue. And it requires more
changes. But it is doable for sure.

Thanks!

