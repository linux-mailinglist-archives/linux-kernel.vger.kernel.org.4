Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0F69DC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjBUIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBUIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:46:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1B234DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:45:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r27so2589666lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4uKfROoayYc7P+9YMJpCwEmpyxpB8+srD3uF1uj/+M=;
        b=bcaoLoThlNbG2TMa1e22sHPCme7ciYVa8vVOJDUDE03kDcjN9DZ5u9MboNtVeyxrrl
         AJVwQxvNc4/YfuPm9GVuhzIGH4+D2GOjXPJQkaNjnb1xcTj18NcpRBXfA+bcXTqy11B1
         MzHwJMfbNO1S+KO+fQl9UBpE33CLRSzcaLzEAhhWyVgvnHuMoCdGZbSxdxb8fnOIS/9P
         RfMB6bDOSYfPTQ7H7AXDXqn/gTX0FWB4OOugE+lEZC1wK8BAZ41xieoneK12xs8TvLNR
         kBLoYenoyz4jkiIjIGJZPKDPUusmXMcCGAEmAn1XbnTqUd1t/2hvvyJ1YxBzki0wJ4ZO
         QMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4uKfROoayYc7P+9YMJpCwEmpyxpB8+srD3uF1uj/+M=;
        b=fO1Y73iX0zmGAYBk1hup987XpfYLQLi/Ux/xoPaV6awVF9pWox6kSdueueftiB1Rgh
         riOfcml6jrbzvnsnvcfvQsQRevJK2orCsjdVwcMvv/4pcKxoCDQs9g9W8RY9Uha/Kypl
         /eCkmWcKuT64X8idPeGsUdgonl/hq/HPmw2P8hvMOiU6WnfwX7LLR1MTPsKcjmUlFQ7I
         59qDQRRtpCElbmIqBmULkxA9FtHzdx/u121JgrEt4NDhcf37ZfsoWy4Wn5o8RJBDJtSQ
         NV2r6PHiq7gRaJ1Y1iD9bKhIXJ614yyVmqxyw6LE+SuZDSLLrWzdifqck6T0gnyQcUhj
         SKdg==
X-Gm-Message-State: AO0yUKWN5/rQHKscL4ColZEezabT3J8epRQKFyWLw+7p9BsBQKuxEvmv
        NSujcrQft6UTI/nXPgUQtto=
X-Google-Smtp-Source: AK7set/73Ns6OKuL5yIVyPHWFMBtbJkbnW3kbLgZpcOmj3xIUauu/5zySUWJbkr9SWgKPAAaRdrozw==
X-Received: by 2002:ac2:5456:0:b0:4c0:91d0:e7ab with SMTP id d22-20020ac25456000000b004c091d0e7abmr1478183lfn.28.1676969157294;
        Tue, 21 Feb 2023 00:45:57 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25109000000b004cb8de497ffsm1777373lfb.154.2023.02.21.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 00:45:56 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:45:51 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
Message-ID: <20230221104551.60d44d1c@eldfell>
In-Reply-To: <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
        <20230218211608.1630586-11-robdclark@gmail.com>
        <20230220110820.595cfa37@eldfell>
        <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zh0WND8Gk+Ddg05nRgp0_tS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zh0WND8Gk+Ddg05nRgp0_tS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Feb 2023 07:55:41 -0800
Rob Clark <robdclark@gmail.com> wrote:

> On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@gmail.com> wrot=
e:
> >
> > On Sat, 18 Feb 2023 13:15:53 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> > =20
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Will be used in the next commit to set a deadline on fences that an
> > > atomic update is waiting on.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++++
> > >  include/drm/drm_vblank.h     |  1 +
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblan=
k.c
> > > index 2ff31717a3de..caf25ebb34c5 100644
> > > --- a/drivers/gpu/drm/drm_vblank.c
> > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct drm_cr=
tc *crtc,
> > >  }
> > >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > >
> > > +/**
> > > + * drm_crtc_next_vblank_time - calculate the time of the next vblank
> > > + * @crtc: the crtc for which to calculate next vblank time
> > > + * @vblanktime: pointer to time to receive the next vblank timestamp.
> > > + *
> > > + * Calculate the expected time of the next vblank based on time of p=
revious
> > > + * vblank and frame duration =20
> >
> > Hi,
> >
> > for VRR this targets the highest frame rate possible for the current
> > VRR mode, right?
> > =20
>=20
> It is based on vblank->framedur_ns which is in turn based on
> mode->crtc_clock.  Presumably for VRR that ends up being a maximum?

I don't know. :-)

You need a number of clock cycles in addition to the clock frequency,
and that could still be minimum, maximum, the last realized one, ...

VRR works by adjusting the front porch length IIRC.


Thanks,
pq

> BR,
> -R
>=20
>=20
> >
> > Thanks,
> > pq
> > =20
> > > + */
> > > +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblank=
time)
> > > +{
> > > +     unsigned int pipe =3D drm_crtc_index(crtc);
> > > +     struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
> > > +     u64 count;
> > > +
> > > +     if (!vblank->framedur_ns)
> > > +             return -EINVAL;
> > > +
> > > +     count =3D drm_vblank_count_and_time(crtc->dev, pipe, vblanktime=
);
> > > +
> > > +     /*
> > > +      * If we don't get a valid count, then we probably also don't
> > > +      * have a valid time:
> > > +      */
> > > +     if (!count)
> > > +             return -EINVAL;
> > > +
> > > +     *vblanktime =3D ktime_add(*vblanktime, ns_to_ktime(vblank->fram=
edur_ns));
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_crtc_next_vblank_time);
> > > +
> > >  static void send_vblank_event(struct drm_device *dev,
> > >               struct drm_pending_vblank_event *e,
> > >               u64 seq, ktime_t now)
> > > diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> > > index 733a3e2d1d10..a63bc2c92f3c 100644
> > > --- a/include/drm/drm_vblank.h
> > > +++ b/include/drm/drm_vblank.h
> > > @@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *=
dev);
> > >  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> > >  u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> > >                                  ktime_t *vblanktime);
> > > +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblank=
time);
> > >  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
> > >                              struct drm_pending_vblank_event *e);
> > >  void drm_crtc_arm_vblank_event(struct drm_crtc *crtc, =20
> > =20


--Sig_/zh0WND8Gk+Ddg05nRgp0_tS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP0hL8ACgkQI1/ltBGq
qqf77A//cdhJqizuEomrgrBVpudhthguc/i1HmDVZDyiilsQaCfi2O7EVqEqzqDA
POfMez1YPULxreaZnNMlCVqnXuzQKCzlg4baUHN7hPznQdXJjf0JQQfb9SlNCjyb
nPQvtchWxj6oLM4kWv5FReny5mAKTchKMCLbDOQuTGb+jaFsF6AKFpD2E53aBagp
MbKiz/hjrClfG6kBQit9/XxEbRyVcshOyVpU5lna2gQeMJUm37wwYQMrQYuH4Zkm
wz3CppZA3kNk2jPMjbdy4AOcTimpyDDZ+9k1SK1NW8StxNYYfi6x3gLUm7SE4FO6
rwvEgotv2nye/DI7nX2YU8DQhgQXUJWMyYXfy9AoVF6HxXoMQ0xmoO+mmM8wP+hD
m5C+1APA2Ym4nGCoZj6OEL8RrcLmWNWRZhHOGumNwsYbkTq8bV2XAE7g1PvnaXMs
43OkC15MbxMr2C+AURgt8m1R2FjSIyKiPPrMRDjfXgJf9nSTcxuXUoaanyV/oksf
c4GIHofydnDMEtfUK8rMEiyzOhhGu+vhahYqGT+E++J/WMZX1STrD0mkp5QNOToI
rVnGbvs7asZ1U6dEN7X4F8GS/szRsqnyqt2SMcJIqFDAWtbI5mcZ5S9V4ZUS225X
VIS+hpe41nDmvPfN3wIlmz6sxMazJVPfgRQAisSKjKZzYTRSwb4=
=Y9kM
-----END PGP SIGNATURE-----

--Sig_/zh0WND8Gk+Ddg05nRgp0_tS--
