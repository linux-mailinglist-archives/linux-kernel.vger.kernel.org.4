Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B994749356
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjGFB4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjGFB4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E019B5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688608541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4oDji0pnQjBPZE3409rybSrvPTs16jwzEuyNSmoWi0=;
        b=ehejH2mXvcACS7WfZEcQ2l0RH7lh4p6q+5SqiCf2TOvLJL654VYBMafufm72LzK+7pxhMe
        dJ2bRBFMYKuP8vt58YAwfhCoCqVfSm1+aH2gdz7U357GE6uDKpgcKCImXOk3QrqOMkYFPR
        NN/f7B7Yns07V9C1CphfUh+aLlycYrc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-NaNIQlbgOY-WsWKtf80I_w-1; Wed, 05 Jul 2023 21:55:39 -0400
X-MC-Unique: NaNIQlbgOY-WsWKtf80I_w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6bf4d97beso1261991fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 18:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688608538; x=1691200538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4oDji0pnQjBPZE3409rybSrvPTs16jwzEuyNSmoWi0=;
        b=EXNF4EvYQyqed70+uchJhdfyfttVNVsGiBUkv+2ouCH47lzK/csFwBa5PvL2mUOLCk
         +iDUc7vBqX8sugqllNuKgHAOgG7rEHsowpZTYYbaJMI/wTEL3K57u95rrEkx/mjKSrxW
         QtxmWdQrz1Y0DjuSI09ajP418GMNVg+Ho2b8EDaqSGxYvt80G2qkH8EgtECGVaPgBnRS
         Ggvd5s6jla6O8LzVRnl0gqwYcuI9itSKXjXa+w+VRfy05P+Yo4hHkvifkN/OMCraiemn
         eT4gpUSNWrOZn2FhJZoEgSTiP2D+mxmMB6WUTyAxfLq4WqvGmutqz49loF/5f0s6JpN0
         TgWg==
X-Gm-Message-State: ABy/qLacnqQwnZ2/cC0I/X2JYJ9+VOv/Zd0B7RfsFie4I4O3sDDYszBS
        JMZQSA3VZsz7+DCsZSxVeg3PlJ0W6v5k38rWePlw6IPY3ivFfm+rKE0luqHg5IKVVntMaEPysEh
        g6GhoiQmZkxRAPkYDTI05cJbPgXrbuq5xdNPnKem1
X-Received: by 2002:a2e:6a05:0:b0:2b6:e10a:a9b with SMTP id f5-20020a2e6a05000000b002b6e10a0a9bmr245850ljc.26.1688608537857;
        Wed, 05 Jul 2023 18:55:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgWAJSVdWWCkpGlV699dPhWPv844SliSf2RkOP2SP0+DOWdaEzY8qOW4IMuOO9EKsYchCQiS3Os6UX/qiEM3o=
X-Received: by 2002:a2e:6a05:0:b0:2b6:e10a:a9b with SMTP id
 f5-20020a2e6a05000000b002b6e10a0a9bmr245839ljc.26.1688608537515; Wed, 05 Jul
 2023 18:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org> <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org> <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <20230705043940-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705043940-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 6 Jul 2023 09:55:26 +0800
Message-ID: <CACGkMEufNZGvWMN9Shh6NPOZOe-vf0RomfS1DX6DtxJjvO7fNA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 4:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 05, 2023 at 03:49:58PM +0800, Jason Wang wrote:
> > On Tue, Jul 4, 2023 at 11:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin wrote:
> > > > On Tue, Jul 4, 2023 at 12:38=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wr=
ote:
> > > > > > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9rez =
wrote:
> > > > > > > > With the current code it is accepted as long as userland se=
nd it.
> > > > > > > >
> > > > > > > > Although userland should not set a feature flag that has no=
t been
> > > > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current =
code will not
> > > > > > > > complain for it.
> > > > > > > >
> > > > > > > > Since there is no specific reason for any parent to reject =
that backend
> > > > > > > > feature bit when it has been proposed, let's control it at =
vdpa frontend
> > > > > > > > level. Future patches may move this control to the parent d=
river.
> > > > > > > >
> > > > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_A=
FTER_DRIVER_OK backend feature")
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > >
> > > > > > > Please do send v3. And again, I don't want to send "after dri=
ver ok" hack
> > > > > > > upstream at all, I merged it in next just to give it some tes=
ting.
> > > > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > > > >
> > > > > >
> > > > > > Current devices do not support that semantic.
> > > > >
> > > > > Which devices specifically access the ring after DRIVER_OK but be=
fore
> > > > > a kick?
> > > > >
> > > >
> > > > Previous versions of the QEMU LM series did a spurious kick to star=
t
> > > > traffic at the LM destination [1]. When it was proposed, that spuri=
ous
> > > > kick was removed from the series because to check for descriptors
> > > > after driver_ok, even without a kick, was considered work of the
> > > > parent driver.
> > > >
> > > > I'm ok to go back to this spurious kick, but I'm not sure if the hw
> > > > will read the ring before the kick actually. I can ask.
> > > >
> > > > Thanks!
> > > >
> > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg027=
75.html
> > >
> > > Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too, no?
> >
> > My understanding is [1] assuming ACCESS_AFTER_KICK. This seems
> > sub-optimal than assuming ENABLE_AFTER_DRIVER_OK.
> >
> > But this reminds me one thing, as the thread is going too long, I
> > wonder if we simply assume ENABLE_AFTER_DRIVER_OK if RING_RESET is
> > supported?
> >
> > Thanks
>
> I don't see what does one have to do with another ...
>
> I think with RING_RESET we had another solution, enable rings
> mapping them to a zero page, then reset and re-enable later.

As discussed before, this seems to have some problems:

1) The behaviour is not clarified in the document
2) zero is a valid IOVA

Thanks

>
> > >
> > >
> > >
> > > > > > My plan was to convert
> > > > > > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry =
if I
> > > > > > was not explicit enough.
> > > > > >
> > > > > > The only solution I can see to that is to trap & emulate in the=
 vdpa
> > > > > > (parent?) driver, as talked in virtio-comment. But that complic=
ates
> > > > > > the architecture:
> > > > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > > > * Store vq enable state separately, at
> > > > > > vdpa->config->set_vq_ready(true), but not transmit that enable =
to hw
> > > > > > * Store the doorbell state separately, but do not configure it =
to the
> > > > > > device directly.
> > > > > >
> > > > > > But how to recover if the device cannot configure them at kick =
time,
> > > > > > for example?
> > > > > >
> > > > > > Maybe we can just fail if the parent driver does not support en=
abling
> > > > > > the vq after DRIVER_OK? That way no new feature flag is needed.
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/lin=
ux/kernel/git/mst
> > > > > > > > commit. Please let me know if I should send a v3 of [1] ins=
tead.
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-e=
mail-mst@kernel.org/T/
> > > > > > > > ---
> > > > > > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl=
(struct file *filep,
> > > > > > > >  {
> > > > > > > >       struct vhost_vdpa *v =3D filep->private_data;
> > > > > > > >       struct vhost_dev *d =3D &v->vdev;
> > > > > > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->config=
;
> > > > > > > >       void __user *argp =3D (void __user *)arg;
> > > > > > > >       u64 __user *featurep =3D argp;
> > > > > > > > -     u64 features;
> > > > > > > > +     u64 features, parent_features =3D 0;
> > > > > > > >       long r =3D 0;
> > > > > > > >
> > > > > > > >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > > > > > >               if (copy_from_user(&features, featurep, sizeo=
f(features)))
> > > > > > > >                       return -EFAULT;
> > > > > > > > +             if (ops->get_backend_features)
> > > > > > > > +                     parent_features =3D ops->get_backend_=
features(v->vdpa);
> > > > > > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES =
|
> > > > > > > >                                BIT_ULL(VHOST_BACKEND_F_SUSP=
END) |
> > > > > > > >                                BIT_ULL(VHOST_BACKEND_F_RESU=
ME) |
> > > > > > > > -                              BIT_ULL(VHOST_BACKEND_F_ENAB=
LE_AFTER_DRIVER_OK)))
> > > > > > > > +                              parent_features))
> > > > > > > >                       return -EOPNOTSUPP;
> > > > > > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPE=
ND)) &&
> > > > > > > >                    !vhost_vdpa_can_suspend(v))
> > > > > > > > --
> > > > > > > > 2.39.3
> > > > > > >
> > > > >
> > >
>

