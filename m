Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3598747EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjGEH4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGEH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBAD1711
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688543739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JchDhPT3KR3iSA029I0+obQ1cLL2Ob33e0q6YR+m51M=;
        b=N64ikZos5AfatFf9W8bfFfGQi3pl4CAuHqr2kAbV0O1pbRxbDcuDTfzGZVuN6cC7pDktOu
        WgC9fVE2QCo0tmo/J3jIEKnn3zxv2u/1aZ0dDc2YB9z8y9NgyWGbM5C4INR+7FCPxuK5A/
        C/6+m3LLbvekEA+Opu6wbFdByA1weOo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-p8Z-tV2bNASyMV8WZsDuKg-1; Wed, 05 Jul 2023 03:55:38 -0400
X-MC-Unique: p8Z-tV2bNASyMV8WZsDuKg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635e0889cc5so64670976d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543736; x=1691135736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JchDhPT3KR3iSA029I0+obQ1cLL2Ob33e0q6YR+m51M=;
        b=WSbQL6bW/7RYLllETCCJvH+Zq14T3OZe6xMtxIPqUOJLyTNmylfwP41wazRL+XkeHV
         KGMBctpPG9v90jxkbsGELToqkU+UwAJv1u57uMSqoLM3DKEObrZIhJ9wM4izCyZ/becb
         Ok6xDZDd33jyRLf6lZQQd1rSenXJvLXyQKgxa3JpKkIL1ppeWsnKHROGty1sfboluubQ
         K8LUTfzyFlKyh57q6yy78tkZuy4saIrGSvFWk8tVu7T8dWXvLn1pbDsEldvfgtP5DdCk
         JpK9MiDkbN8iV+IwN6e0vdIeDydlN+NUp1484RfzYey5C7hSUYP0wPlho400t6/uWjuL
         f/dw==
X-Gm-Message-State: ABy/qLYMKLn+Uolp7M+S70GYEdlNB5Mz3OXM+I0/vPlx718a5k5HxRDg
        VslsFzB/TnNuCiKc7ZyrA+mE8hlb/WQqDnzOhBPCCvdmF3OvHyJAkmOJATxLhIaQgPWOiPOKi81
        OMRLP9K0VPinJvtkoHymh0HLhLkQveGKOhiptdxXjlAfxVOn/rq4=
X-Received: by 2002:a0c:e9c7:0:b0:632:301e:62fc with SMTP id q7-20020a0ce9c7000000b00632301e62fcmr14553362qvo.35.1688543736084;
        Wed, 05 Jul 2023 00:55:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqduiWcmunoNBMAdWzr6PpWjNwv7fXWO8C6/ME3RHNm2xO9+3sdoOnnjp1VMMQRCem4bpXAtZUe/vemaJ32+g=
X-Received: by 2002:a0c:e9c7:0:b0:632:301e:62fc with SMTP id
 q7-20020a0ce9c7000000b00632301e62fcmr14553352qvo.35.1688543735859; Wed, 05
 Jul 2023 00:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com> <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com> <20230704063646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704063646-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 5 Jul 2023 15:55:23 +0800
Message-ID: <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 6:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> > On Mon, Jul 3, 2023 at 4:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=C3=A9rez wrote:
> > > > With the current code it is accepted as long as userland send it.
> > > >
> > > > Although userland should not set a feature flag that has not been
> > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code wil=
l not
> > > > complain for it.
> > > >
> > > > Since there is no specific reason for any parent to reject that bac=
kend
> > > > feature bit when it has been proposed, let's control it at vdpa fro=
ntend
> > > > level. Future patches may move this control to the parent driver.
> > > >
> > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK backend feature")
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > Please do send v3. And again, I don't want to send "after driver ok" =
hack
> > > upstream at all, I merged it in next just to give it some testing.
> > > We want RING_ACCESS_AFTER_KICK or some such.
> > >
> >
> > Current devices do not support that semantic.
>
> Which devices specifically access the ring after DRIVER_OK but before
> a kick?

Vhost-net is one example at last. It polls a socket as well, so it
starts to access the ring immediately after DRIVER_OK.

Thanks

>
> > My plan was to convert
> > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> > was not explicit enough.
> >
> > The only solution I can see to that is to trap & emulate in the vdpa
> > (parent?) driver, as talked in virtio-comment. But that complicates
> > the architecture:
> > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > * Store vq enable state separately, at
> > vdpa->config->set_vq_ready(true), but not transmit that enable to hw
> > * Store the doorbell state separately, but do not configure it to the
> > device directly.
> >
> > But how to recover if the device cannot configure them at kick time,
> > for example?
> >
> > Maybe we can just fail if the parent driver does not support enabling
> > the vq after DRIVER_OK? That way no new feature flag is needed.
> >
> > Thanks!
> >
> > >
> > > > ---
> > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kerne=
l/git/mst
> > > > commit. Please let me know if I should send a v3 of [1] instead.
> > > >
> > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst=
@kernel.org/T/
> > > > ---
> > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index e1abf29fed5b..a7e554352351 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct =
file *filep,
> > > >  {
> > > >       struct vhost_vdpa *v =3D filep->private_data;
> > > >       struct vhost_dev *d =3D &v->vdev;
> > > > +     const struct vdpa_config_ops *ops =3D v->vdpa->config;
> > > >       void __user *argp =3D (void __user *)arg;
> > > >       u64 __user *featurep =3D argp;
> > > > -     u64 features;
> > > > +     u64 features, parent_features =3D 0;
> > > >       long r =3D 0;
> > > >
> > > >       if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> > > >               if (copy_from_user(&features, featurep, sizeof(featur=
es)))
> > > >                       return -EFAULT;
> > > > +             if (ops->get_backend_features)
> > > > +                     parent_features =3D ops->get_backend_features=
(v->vdpa);
> > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > >                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER=
_DRIVER_OK)))
> > > > +                              parent_features))
> > > >                       return -EOPNOTSUPP;
> > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > >                    !vhost_vdpa_can_suspend(v))
> > > > --
> > > > 2.39.3
> > >
>

