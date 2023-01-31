Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ADD6822AD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAaDRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjAaDRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4551A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 19:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675134992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWiJjxw4dIrl+Ur1IaXYBn5fUEbMiL3kVPQT9CCa9z4=;
        b=e1MHRAEU7BSv42TirqRjZet/ljJUtNfK0lEDv39PSxBVy6aFw/nTCaFbZnl7lBa3HFdHdC
        GSaWJwrfyUBFcNIr7cbNWrBwNfB64yXQ/zdgE3FUR/EqUEt4LJynBxKGLOYyCm/3Rjo2bT
        jjMPPkWnJk/NphRHoOxzuY9LCnbix2g=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-am6ZOCNSMr-25WoPGmKGxg-1; Mon, 30 Jan 2023 22:16:31 -0500
X-MC-Unique: am6ZOCNSMr-25WoPGmKGxg-1
Received: by mail-oi1-f199.google.com with SMTP id k2-20020a056808068200b00360fc885001so5866007oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 19:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWiJjxw4dIrl+Ur1IaXYBn5fUEbMiL3kVPQT9CCa9z4=;
        b=7gUC+SPIUxSalQAfQ552AqOhlWrlfDAKk6QvE309By8isBiFNPYrc2I5WbvPpK6eHk
         tBbDxNKWRfjF3CXzc8ub2xOCAvvs4XIo+XlG29wqXxtpeSccM0v6MSS49a/We+kfkdAR
         iwl25k02sl7UQHKIlI7KYglEitXXXf/DJ8Qbeq7BTEb/ekNDnZGWWog/PU62D49us2T/
         IAbEPPNP6ESCkqlEoshHLTIASUQZ/UxhH1iGVc/mtKwACwv8qnf8tdBGkjjOD4UtWS/0
         0Zdi8nJdQDN/Tk0is6M+CONJA/ICBxQEQ8KInGzW/QA6YEyefbaKzF4Qlt9/rZNqn01J
         /7pg==
X-Gm-Message-State: AO0yUKUs3B/1rsseDdeInvCvTkFGwu4p29KQkPKVIfrv8GMb8qBkWR2s
        GtTWfhBgSCtIT7/yfFlHi67SUzBIQue8kF/LASmXopL8w86eI/mZdFLdTQayBNOVOiOxcoizJEr
        cIzGBAcPpVt4TCzjXF6bOUayIUapHZNtOeSiuqZjp
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id k30-20020a056870959e00b001639ceaeea7mr566768oao.35.1675134990424;
        Mon, 30 Jan 2023 19:16:30 -0800 (PST)
X-Google-Smtp-Source: AK7set96OS1U2BfjLs7lmzFI49lAg6/8VPvlF266fjVSZY7JzDpLd0NGhvpOhMye+Yt56NiHsiUluGiQ8gkYcRC/qWU=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr566764oao.35.1675134990144; Mon, 30 Jan
 2023 19:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
 <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com> <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
In-Reply-To: <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 31 Jan 2023 11:16:19 +0800
Message-ID: <CACGkMEubK3jRyKy5_TsRvKtcUQ2dYnr_hEnWwds4ZtewVsxz_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To:     Eugenio Perez Martin <eperezma@redhat.com>
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

On Tue, Jan 31, 2023 at 12:39 AM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Sun, Jan 29, 2023 at 7:01 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 4:11 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> wrot=
e:
> > > >
> > > > On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> > > > >
> > > > > Starting from an used_idx different than 0 is needed in use cases=
 like
> > > > > virtual machine migration.  Not doing so and letting the caller s=
et an
> > > > > avail idx different than 0 causes destination device to try to us=
e old
> > > > > buffers that source driver already recover and are not available
> > > > > anymore.
> > > > >
> > > > > While callers like vdpa_sim set avail_idx directly it does not se=
t
> > > > > used_idx.  Instead of let the caller do the assignment, fetch it =
from
> > > > > the guest at initialization like vhost-kernel do.
> > > > >
> > > > > To perform the same at vring_kernel_init and vring_user_init is l=
eft for
> > > > > the future.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > > > index 33eb941fcf15..0eed825197f2 100644
> > > > > --- a/drivers/vhost/vringh.c
> > > > > +++ b/drivers/vhost/vringh.c
> > > > > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const stru=
ct vringh *vrh,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * vringh_update_used_idx - fetch used idx from driver's used sp=
lit vring
> > > > > + * @vrh: The vring.
> > > > > + *
> > > > > + * Returns -errno or 0.
> > > > > + */
> > > > > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > > > > +{
> > > > > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring=
.used->idx);
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB=
.
> > > > >   * @vrh: the vringh to initialize.
> > > > > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, =
u64 features,
> > > > >                       struct vring_avail *avail,
> > > > >                       struct vring_used *used)
> > > > >  {
> > > >
> > > > While at this, I wonder if it's better to have a dedicated paramete=
r
> > > > for last_avail_idx?
> > > >
> > >
> > > I also had that thought. To directly assign last_avail_idx is not a
> > > specially elegant API IMO.
> > >
> > > Maybe expose a way to fetch used_idx from device vring and pass
> > > used_idx as parameter too?
> >
> > If I was not wrong, we can start from last_avail_idx, for used_idx it
> > is only needed for inflight descriptors which might require other
> > APIs?
> >
> > (All the current vDPA user of vringh is doing in order processing)
> >
>
> That was actually my first attempt and it works equally well for the
> moment, but it diverges from vhost-kernel behavior for little benefit.
>
> To assign both values at set_vring_base mean that if vDPA introduces
> an (hypothetical) VHOST_VDPA_F_INFLIGHT backend feature in the future,
> the initialization process would vary a lot:
> * Without that feature, the used_idx starts with 0, and the avail one
> is 0 or whatever value the user set with vring_set_base.
> * With that feature, the device will read guest's used_idx as
> vhost-kernel? We would enable a new ioctl to set it, or expand
> set_base to include used_idx, effectively diverting from vhost-kernel?

Adding Longpeng who is looking at this.

We can leave this to the caller to decide.

Btw, a question, at which case the device used index does not equal to
the used index in the vring when the device is suspended? I think the
correct way is to flush the pending used indexes before suspending.
Otherwise we need an API to get pending used indices?

>
> To me the wisest option is to move this with vhost-kernel. Maybe we
> need to add a feature bit to know that the hypervisor can trust the
> device will do "the right thing" (VHOST_VDPA_F_FETCH_USED_AT_ENABLE?),
> but we should keep it orthogonal to inflight descriptor migration in
> my opinion.

I think we need to understand if there are any other possible use
cases for setting used idx other than inflight stuff.

>
> Having said that, I'm totally ok to do it otherwise (or to expand the
> patch message if needed).

I tend to do that in another series (not mix with the fixes).

>
> > >
> > > > > -       return vringh_init_kern(vrh, features, num, weak_barriers=
,
> > > > > -                               desc, avail, used);
> > > > > +       int r =3D vringh_init_kern(vrh, features, num, weak_barri=
ers, desc,
> > > > > +                                avail, used);
> > > > > +
> > > > > +       if (r !=3D 0)
> > > > > +               return r;
> > > > > +
> > > > > +       /* Consider the ring not initialized */
> > > > > +       if ((void *)desc =3D=3D used)
> > > > > +               return 0;
> > > >
> > > > I don't understand when we can get this (actually it should be a bu=
g
> > > > of the caller).
> > > >
> > >
> > > You can see it in vdpasim_vq_reset.
> > >
> > > Note that to consider desc =3D=3D 0 to be an uninitialized ring is a =
bug
> > > IMO. QEMU considers it that way also, but the standard does not forbi=
d
> > > any ring to be at address 0. Especially if we use vIOMMU.
> > >
> > > So I think the best way to know if we can use the vringh is either
> > > this way, or provide an explicit "initialized" boolean attribute.
> > > Maybe a new "bool is_initialized(vrh)" is enough, if we don't want to
> > > add new attributes.
> >
> > I wonder if we can avoid this in the simulator level instead of the
> > vringh (anyhow it only exposes a vringh_init_xxx() helper now).
> >
>
> In my opinion that is a mistake if other drivers will use it to
> implement the emulated control virtqueue. And it requires more
> changes. But it is doable for sure.

The problem is, there's no reset API in vringh, that's why you need to
do if ((void *)desc =3D=3D used) which depends on behaviour of the vringh
user.

So I think we should either:

1) move that check in vdpa_sim (since it's not guaranteed that all the
vringh users will make desc equal to used during reset)

or

2) introduce a vringh_reset_xxx()

1) seems a good step for -stable.

Thanks

>
> Thanks!
>

