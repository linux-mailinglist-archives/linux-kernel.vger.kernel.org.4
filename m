Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8A67FD04
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjA2GBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjA2GBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:01:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448B22DDF
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674972066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNte/epZiic5eC+qCjYGlwvstqynHQ526X6mXWyY2rg=;
        b=Q2ZmKugpaY+xK+dMZMUVQh5cbcYAs+qjX5aG1p6hxh9IAJS56XRhQCnENZjAP7atvUHnuW
        Fa6pCNs7FIgj+Fwn1lC9hp6FVMwEQytWsj4pXDSIeyYxuV2JCbMmuNzz8bbgBhDAz1F44U
        XM7oi1WwHWIIMzm30wdOdTWkY2FbNrE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-XR4MD6SKPdyRp_cZniHguw-1; Sun, 29 Jan 2023 01:01:04 -0500
X-MC-Unique: XR4MD6SKPdyRp_cZniHguw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1632b78625cso3104285fac.22
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNte/epZiic5eC+qCjYGlwvstqynHQ526X6mXWyY2rg=;
        b=7TYj6zBPdY2fLqr+LSCNijPmsDgS/OSMfc+VJ5Jk/mdNC1vlso0QTmLUBKsWZqO0/8
         RCB6H7EFmCGfTTwE680LehpmMjwSFU46GNwK7XgGl8Fz6H/Ef52x2lmcdoxdwHaNc3aI
         7pbWQgctANaP6ManuGjHwAI+Bzw6FH5Cex0tTtxEaCndjUDiZUf8v9oRV1nTT2kyqLYj
         eeOe72j1d+4mg2d63Cf67gdurB2SL061LXwrVhWZbyYCeqW2SSRNU8vKFmvjIoZiKONg
         itnlQKE0nX1H67zWcdxKHHLrrG3PynqeuGr5ZZLVCw/UMiDIJTdInVlLMbX6D5DMxUDf
         hJNw==
X-Gm-Message-State: AFqh2kqQSTGYEzgEyVac4LVQMUtucCGnAk6GBVLU1ChgALEpXMik/R3+
        vCsb1AWgA6O8mM2USLX8Rt0XZA3ndqyWlf0FtcaFBnWjM1O3fcwW77SEwXDkLotgEWPbWKW5xCH
        zR0nxcuXxFzs/F1vt2h0c9cOU6gb7r81KKfbtk7iQ
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id m126-20020aca3f84000000b0036ef5f8cce1mr790410oia.35.1674972063216;
        Sat, 28 Jan 2023 22:01:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBzcCdXZc7bwOwz3areMJGTSfIiWdbhghFTG36ykYsyjKjmQmJuRCs5BcZgYBNJ5opYdriLWh+zpc/ToYbCng=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr790402oia.35.1674972062940; Sat, 28
 Jan 2023 22:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com> <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
In-Reply-To: <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 29 Jan 2023 14:00:51 +0800
Message-ID: <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To:     Eugenio Perez Martin <eperezma@redhat.com>
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

On Thu, Jan 19, 2023 at 4:11 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.co=
m> wrote:
> > >
> > > Starting from an used_idx different than 0 is needed in use cases lik=
e
> > > virtual machine migration.  Not doing so and letting the caller set a=
n
> > > avail idx different than 0 causes destination device to try to use ol=
d
> > > buffers that source driver already recover and are not available
> > > anymore.
> > >
> > > While callers like vdpa_sim set avail_idx directly it does not set
> > > used_idx.  Instead of let the caller do the assignment, fetch it from
> > > the guest at initialization like vhost-kernel do.
> > >
> > > To perform the same at vring_kernel_init and vring_user_init is left =
for
> > > the future.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > index 33eb941fcf15..0eed825197f2 100644
> > > --- a/drivers/vhost/vringh.c
> > > +++ b/drivers/vhost/vringh.c
> > > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct v=
ringh *vrh,
> > >         return 0;
> > >  }
> > >
> > > +/**
> > > + * vringh_update_used_idx - fetch used idx from driver's used split =
vring
> > > + * @vrh: The vring.
> > > + *
> > > + * Returns -errno or 0.
> > > + */
> > > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > > +{
> > > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.use=
d->idx);
> > > +}
> > > +
> > >  /**
> > >   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
> > >   * @vrh: the vringh to initialize.
> > > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 =
features,
> > >                       struct vring_avail *avail,
> > >                       struct vring_used *used)
> > >  {
> >
> > While at this, I wonder if it's better to have a dedicated parameter
> > for last_avail_idx?
> >
>
> I also had that thought. To directly assign last_avail_idx is not a
> specially elegant API IMO.
>
> Maybe expose a way to fetch used_idx from device vring and pass
> used_idx as parameter too?

If I was not wrong, we can start from last_avail_idx, for used_idx it
is only needed for inflight descriptors which might require other
APIs?

(All the current vDPA user of vringh is doing in order processing)

>
> > > -       return vringh_init_kern(vrh, features, num, weak_barriers,
> > > -                               desc, avail, used);
> > > +       int r =3D vringh_init_kern(vrh, features, num, weak_barriers,=
 desc,
> > > +                                avail, used);
> > > +
> > > +       if (r !=3D 0)
> > > +               return r;
> > > +
> > > +       /* Consider the ring not initialized */
> > > +       if ((void *)desc =3D=3D used)
> > > +               return 0;
> >
> > I don't understand when we can get this (actually it should be a bug
> > of the caller).
> >
>
> You can see it in vdpasim_vq_reset.
>
> Note that to consider desc =3D=3D 0 to be an uninitialized ring is a bug
> IMO. QEMU considers it that way also, but the standard does not forbid
> any ring to be at address 0. Especially if we use vIOMMU.
>
> So I think the best way to know if we can use the vringh is either
> this way, or provide an explicit "initialized" boolean attribute.
> Maybe a new "bool is_initialized(vrh)" is enough, if we don't want to
> add new attributes.

I wonder if we can avoid this in the simulator level instead of the
vringh (anyhow it only exposes a vringh_init_xxx() helper now).

Thanks

>
> Thanks!
>
> > Thanks
> >
> > > +
> > > +       return vringh_update_used_idx(vrh);
> > > +
> > >  }
> > >  EXPORT_SYMBOL(vringh_init_iotlb);
> > >
> > > --
> > > 2.31.1
> > >
> >
>

