Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F77495B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjGFGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjGFGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C21737
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688625369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RW6sZxQEq7r6/MAdcOAFMIZmsNq8xRUmGtzjXz5LxLU=;
        b=heS30NX/F4UuR0Kyl14wIf0YOGIqchhkDqcy2nuFC76XTqri3EH7Dov1pcgUMep1bZKsRN
        B9pYfk0xerNuOiVJFJE4wuvJjLDNRVe/j/6uNf6Bm6RoCw+ydsweeaddgR9hlSM3wmhe1p
        52XpH9syonfavtiAnRP4KgqoGnrYilI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361--RLlLIvVMN6UQQV8odiUGQ-1; Thu, 06 Jul 2023 02:36:07 -0400
X-MC-Unique: -RLlLIvVMN6UQQV8odiUGQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-c4e0342c50dso331338276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625367; x=1691217367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RW6sZxQEq7r6/MAdcOAFMIZmsNq8xRUmGtzjXz5LxLU=;
        b=cH0iyun1dGzU2Ao8DW+fTcWQFXY9+KGbtqD8X61Dj4lNNz7ij9IyZJCCSYzVVoJ3Of
         TjR0Y7GHOcsIaGnxc/qT+uhdchHhTgoqEqXddvaffT5B27iPrRZb5IOyI9QF24NkgUkN
         4ZaRnPsIwBlFDHCXpY8GWwM6zWOzcwNPYqsKFpZydZRfWW7pXQGkTIXSe7gCUJ2yiEYU
         LsIkVo0V0YLu2divN01PPeQqILC5ebYKngQ7QVdWYGKhgwxAzlcypmJcvJ2NjLoIEN2R
         8e2iBa1MfcDKR3reAK1SUIAMm8hMldLBlyxmBe7dXyJY/nw4sagiW6tQasoRa5VRuB6w
         uI5A==
X-Gm-Message-State: ABy/qLY58mofNOE+bpkWV3sCCf9614XVgcMQgALOFK5fwsfBY/aDzqvW
        n+Ln6Yl64PRIZsAL1rH4GeX6gjq3kQbWV0nKBr3Y4CNQBlNKR05LzhoeVeLijCUPoWhhvFQUXo4
        FFmszfVeQF/EYysh1Pz0P9gLkmANgK+r5LwNn0B28puzEdR5/
X-Received: by 2002:a25:abe4:0:b0:c5c:616:39cb with SMTP id v91-20020a25abe4000000b00c5c061639cbmr975945ybi.14.1688625367166;
        Wed, 05 Jul 2023 23:36:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFECekMAxlWyeEFXBzoSN0G8Fu9nyn23my+I7VhTksunE0lAA3zV4rTA/m36+6QaByRCoLJWb4Cqj7AXCpHZng=
X-Received: by 2002:a25:abe4:0:b0:c5c:616:39cb with SMTP id
 v91-20020a25abe4000000b00c5c061639cbmr975933ybi.14.1688625366902; Wed, 05 Jul
 2023 23:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org> <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org> <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com> <20230706020603-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706020603-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 6 Jul 2023 08:35:30 +0200
Message-ID: <CAJaqyWeCv6HhWni=c7xySTCyj9WAFfM3JhWL2e_mDKjHp3wPzQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 8:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 05, 2023 at 05:07:11PM -0700, Shannon Nelson wrote:
> > On 7/5/23 11:27 AM, Eugenio Perez Martin wrote:
> > >
> > > On Wed, Jul 5, 2023 at 9:50=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Tue, Jul 4, 2023 at 11:45=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin wr=
ote:
> > > > > > On Tue, Jul 4, 2023 at 12:38=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Marti=
n wrote:
> > > > > > > > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <=
mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9=
rez wrote:
> > > > > > > > > > With the current code it is accepted as long as userlan=
d send it.
> > > > > > > > > >
> > > > > > > > > > Although userland should not set a feature flag that ha=
s not been
> > > > > > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the curr=
ent code will not
> > > > > > > > > > complain for it.
> > > > > > > > > >
> > > > > > > > > > Since there is no specific reason for any parent to rej=
ect that backend
> > > > > > > > > > feature bit when it has been proposed, let's control it=
 at vdpa frontend
> > > > > > > > > > level. Future patches may move this control to the pare=
nt driver.
> > > > > > > > > >
> > > > > > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENAB=
LE_AFTER_DRIVER_OK backend feature")
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > >
> > > > > > > > > Please do send v3. And again, I don't want to send "after=
 driver ok" hack
> > > > > > > > > upstream at all, I merged it in next just to give it some=
 testing.
> > > > > > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Current devices do not support that semantic.
> > > > > > >
> > > > > > > Which devices specifically access the ring after DRIVER_OK bu=
t before
> > > > > > > a kick?
> >
> > The PDS vdpa device can deal with a call to .set_vq_ready after DRIVER_=
OK is
> > set.  And I'm told that our VQ activity should start without a kick.
> >
> > Our vdpa device FW doesn't currently have support for VIRTIO_F_RING_RES=
ET,
> > but I believe it could be added without too much trouble.
> >
> > sln
> >
>
> OK it seems clear at least in the current version pds needs
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
> However can we also code up the RING_RESET path as the default?
> Then down the road vendors can choose what to do.
>

Yes, the RING_RESET path can be coded & tested for vp_vdpa, for
example. I'm ok with making it the default, and let
_F_ENABLE_AFTER_DRIVER_OK as a fallback.

>
>
>
>
> > > > > > >
> > > > > >
> > > > > > Previous versions of the QEMU LM series did a spurious kick to =
start
> > > > > > traffic at the LM destination [1]. When it was proposed, that s=
purious
> > > > > > kick was removed from the series because to check for descripto=
rs
> > > > > > after driver_ok, even without a kick, was considered work of th=
e
> > > > > > parent driver.
> > > > > >
> > > > > > I'm ok to go back to this spurious kick, but I'm not sure if th=
e hw
> > > > > > will read the ring before the kick actually. I can ask.
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/ms=
g02775.html
> > > > >
> > > > > Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too, =
no?
> > > >
> > > > My understanding is [1] assuming ACCESS_AFTER_KICK. This seems
> > > > sub-optimal than assuming ENABLE_AFTER_DRIVER_OK.
> > > >
> > > > But this reminds me one thing, as the thread is going too long, I
> > > > wonder if we simply assume ENABLE_AFTER_DRIVER_OK if RING_RESET is
> > > > supported?
> > > >
> > >
> > > The problem with that is that the device needs to support all
> > > RING_RESET, like to be able to change vq address etc after DRIVER_OK.
> > > Not all HW support it.
> > >
> > > We just need the subset of having the dataplane freezed until all CVQ
> > > commands have been consumed. I'm sure current vDPA code already
> > > supports it in some devices, like MLX and PSD.
> > >
> > > Thanks!
> > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > > > My plan was to convert
> > > > > > > > it in vp_vdpa if needed, and reuse the current vdpa ops. So=
rry if I
> > > > > > > > was not explicit enough.
> > > > > > > >
> > > > > > > > The only solution I can see to that is to trap & emulate in=
 the vdpa
> > > > > > > > (parent?) driver, as talked in virtio-comment. But that com=
plicates
> > > > > > > > the architecture:
> > > > > > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > > > > > * Store vq enable state separately, at
> > > > > > > > vdpa->config->set_vq_ready(true), but not transmit that ena=
ble to hw
> > > > > > > > * Store the doorbell state separately, but do not configure=
 it to the
> > > > > > > > device directly.
> > > > > > > >
> > > > > > > > But how to recover if the device cannot configure them at k=
ick time,
> > > > > > > > for example?
> > > > > > > >
> > > > > > > > Maybe we can just fail if the parent driver does not suppor=
t enabling
> > > > > > > > the vq after DRIVER_OK? That way no new feature flag is nee=
ded.
> > > > > > > >
> > > > > > > > Thanks!
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm=
/linux/kernel/git/mst
> > > > > > > > > > commit. Please let me know if I should send a v3 of [1]=
 instead.
> > > > > > > > > >
> > > > > > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-se=
nd-email-mst@kernel.org/T/
> > > > > > > > > > ---
> > > > > > > > > >   drivers/vhost/vdpa.c | 7 +++++--
> > > > > > > > > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.=
c
> > > > > > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_i=
octl(struct file *filep,
> > > > > > > > > >   {
> > > > > > > > > >        struct vhost_vdpa *v =3D filep->private_data;
> > > > > > > > > >        struct vhost_dev *d =3D &v->vdev;
> > > > > > > > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->co=
nfig;
> > > > > > > > > >        void __user *argp =3D (void __user *)arg;
> > > > > > > > > >        u64 __user *featurep =3D argp;
> > > > > > > > > > -     u64 features;
> > > > > > > > > > +     u64 features, parent_features =3D 0;
> > > > > > > > > >        long r =3D 0;
> > > > > > > > > >
> > > > > > > > > >        if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > > > > > > > >                if (copy_from_user(&features, featurep, =
sizeof(features)))
> > > > > > > > > >                        return -EFAULT;
> > > > > > > > > > +             if (ops->get_backend_features)
> > > > > > > > > > +                     parent_features =3D ops->get_back=
end_features(v->vdpa);
> > > > > > > > > >                if (features & ~(VHOST_VDPA_BACKEND_FEAT=
URES |
> > > > > > > > > >                                 BIT_ULL(VHOST_BACKEND_F=
_SUSPEND) |
> > > > > > > > > >                                 BIT_ULL(VHOST_BACKEND_F=
_RESUME) |
> > > > > > > > > > -                              BIT_ULL(VHOST_BACKEND_F_=
ENABLE_AFTER_DRIVER_OK)))
> > > > > > > > > > +                              parent_features))
> > > > > > > > > >                        return -EOPNOTSUPP;
> > > > > > > > > >                if ((features & BIT_ULL(VHOST_BACKEND_F_=
SUSPEND)) &&
> > > > > > > > > >                     !vhost_vdpa_can_suspend(v))
> > > > > > > > > > --
> > > > > > > > > > 2.39.3
> > > > > > > > >
> > > > > > >
> > > > >
> > > >
> > >
>

