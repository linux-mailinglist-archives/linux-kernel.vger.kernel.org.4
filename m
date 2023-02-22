Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57669F280
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjBVKJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjBVKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:09:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759532799F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:09:10 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n2so6037468lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSg9xOX1Ngw5Wi6oQCC+aT9UKD1VhnG7bi35k+Luc08=;
        b=mR2CeM30+3fQXJC4R8tJpy9urNGageo7AiS623uMvUjNAe1+a6TuzUC1R07StGheTv
         E6+GK19Q/OGV+7NFxMFVMGH7ap3ubP9tl7XU4TIwDiVtORoA5whRwwCmhxr+utoikZnN
         pQthsb4dVtADnatuoVhQUUfswSLdbgM3QmWX9UdUsfLf6Bet1hLIV4ui9GJc0SFXDNJD
         sFnbxzf9yoW5vC/JQmqeaeeoQu+iZeRuz+7/cMg0WfiozuiTK6bpU+HTFMfNOt/TZ5AQ
         kJqP/o5y3wgPz0hAj5eUFQKzaLQLAAtSRkLiVil4Tcg/JqYo8W44uA9JHgivSGl36Vy1
         ytkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSg9xOX1Ngw5Wi6oQCC+aT9UKD1VhnG7bi35k+Luc08=;
        b=4Kw9jrc2UXolhs1n5O2BckKL7bjOYkdKVkHWY+l8CISDG/PnSxe88HeTZLjmcQTTPo
         yi/IVtai5AMJs2Ybp0+tyL7DA2SWoI6fNqPwoev/pvtcuuIgJICLQZnthKKq0kjTDFI8
         guUAUYEnVmkhb4vm2GGO3Ay2I6JKemchkFQ42vgH1mNIg9udOwlOYThsLgGtdlV1+aOP
         ZUvk0e+YK5aJfgrp2EqVOLQS7Iz+KvQcmaOCQNBOoSEYY9VVe9SrAIvhX0poZ+2/aRel
         ATIdMOMftRMloTI70wWKazT8ad2cevEAmx0IrWG/ESceE8fH3FKUcsJzCO5J9HwBxMqi
         XAqA==
X-Gm-Message-State: AO0yUKVBB96rvO4SomqIxyv2oOzu1yuc2CQskVfMH1H6Gd5YwZAYFD2q
        +j+V/dr3Yh2+y+IgbUxqFkw=
X-Google-Smtp-Source: AK7set+66JeEj3yoFfxtPeJGp9hY1J7PBtTqQuyARvvBI1Gw4FB7gIdmOtkg7hxjy/k0+im4Gs9jaQ==
X-Received: by 2002:ac2:5982:0:b0:4d8:56f2:6053 with SMTP id w2-20020ac25982000000b004d856f26053mr2701321lfn.18.1677060548648;
        Wed, 22 Feb 2023 02:09:08 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id t17-20020ac24c11000000b004db3e330dcesm901645lfq.178.2023.02.22.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 02:09:08 -0800 (PST)
Date:   Wed, 22 Feb 2023 12:09:04 +0200
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
Subject: Re: [PATCH v5 09/14] drm/syncobj: Add deadline support for syncobj
 waits
Message-ID: <20230222120904.5c281652@eldfell>
In-Reply-To: <CAF6AEGtd_9JYtPU-AGmZY0My_d48rSSWQiD-efbR2KFxD-+tTA@mail.gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
        <20230220201916.1822214-10-robdclark@gmail.com>
        <20230221105307.7430c301@eldfell>
        <CAF6AEGtd_9JYtPU-AGmZY0My_d48rSSWQiD-efbR2KFxD-+tTA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0nGQc7.fWXR1w2fbHGJuA_n";
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

--Sig_/0nGQc7.fWXR1w2fbHGJuA_n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Feb 2023 09:25:18 -0800
Rob Clark <robdclark@gmail.com> wrote:

> On Tue, Feb 21, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wro=
te:
> >
> > On Mon, 20 Feb 2023 12:18:56 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> > =20
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Add a new flag to let userspace provide a deadline as a hint for sync=
obj
> > > and timeline waits.  This gives a hint to the driver signaling the
> > > backing fences about how soon userspace needs it to compete work, so =
it
> > > can addjust GPU frequency accordingly.  An immediate deadline can be
> > > given to provide something equivalent to i915 "wait boost".
> > >
> > > v2: Use absolute u64 ns value for deadline hint, drop cap and driver
> > >     feature flag in favor of allowing count_handles=3D=3D0 as a way f=
or
> > >     userspace to probe kernel for support of new flag
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_syncobj.c | 59 +++++++++++++++++++++++++++------=
--
> > >  include/uapi/drm/drm.h        |  5 +++
> > >  2 files changed, 51 insertions(+), 13 deletions(-) =20
> >
> > ...
> > =20
> > > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > index 642808520d92..aefc8cc743e0 100644
> > > --- a/include/uapi/drm/drm.h
> > > +++ b/include/uapi/drm/drm.h
> > > @@ -887,6 +887,7 @@ struct drm_syncobj_transfer {
> > >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> > >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> > >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for t=
ime point to become available */
> > > +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence d=
eadline based to deadline_nsec/sec */ =20
> >
> > Hi,
> >
> > where is the UAPI documentation explaining what is a "fence deadline"
> > and what setting it does here? =20
>=20
> It's with the rest of the drm_syncobj UAPI docs ;-)

Is that https://www.kernel.org/doc/html/latest/driver-api/dma-buf.html#dma-=
fence-uabi-sync-file ?

That whole page never mentions e.g. WAIT_AVAILABLE, so at least the
flags are not there. Does not mention syncobj_wait either.

I could ask where the real non-IGT userspace is or the plan for it,
too, since this is new DRM UAPI.


Thanks,
pq

>=20
> BR,
> -R
>=20
> > btw. no nsec/sec anymore.
> >
> >
> > Thanks,
> > pq
> >
> > =20
> > >  struct drm_syncobj_wait {
> > >       __u64 handles;
> > >       /* absolute timeout */
> > > @@ -895,6 +896,8 @@ struct drm_syncobj_wait {
> > >       __u32 flags;
> > >       __u32 first_signaled; /* only valid when not waiting all */
> > >       __u32 pad;
> > > +     /* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC:=
 */
> > > +     __u64 deadline_ns;
> > >  };
> > >
> > >  struct drm_syncobj_timeline_wait {
> > > @@ -907,6 +910,8 @@ struct drm_syncobj_timeline_wait {
> > >       __u32 flags;
> > >       __u32 first_signaled; /* only valid when not waiting all */
> > >       __u32 pad;
> > > +     /* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC:=
 */
> > > +     __u64 deadline_ns;
> > >  };
> > >
> > > =20
> > =20


--Sig_/0nGQc7.fWXR1w2fbHGJuA_n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP16cAACgkQI1/ltBGq
qqcVDw//U888e4ZdDOlNWEcTd5zRwWV+wT1SJKFvDnR1WVGdapkp5akmg+EAelAP
k/jEGX8YWQmLDd7r+Z0Vbtj6ccR8BKzuHBXLfW8jvsM0wcaJlvWKrVTIulS9t340
gHaIkHqhehon0bWZXAlkPHd+vjR1BIoyfN/1LfABKMaerY+igKo71ISsvYzNOzvI
lUBzGLhdi+6/15B7VLvOX/SgjNOLEWT9fapLOc0dKpyXJI+hV1ry2rj98HzdQRC5
KBOjJeBb3mjESlkF3Izd61GCJRARCZ5VzF1EQa1VrBGGLa0Uf0NHBpEu2Hh8h5BP
GpqOhuCKk77rEllaycuSz4iLN+947UR44kGRp8buU0zUsZkU9+EYmnjrkOFZuDeu
SNxclydeIY5Djy3OiaimR7lo4jc9eerXE2i5Acr4yaY+0SfB0QNgGIqsnyixVU+5
l1bZoi5gCAGnD1a7OTDvFLRl73vlb0aXJRJGnYgtFYlyVOWSSHRFYQi2wHQmFeXR
pA4LMAi9buCG1lsrGrWEmdLXamWY0aV9cWTDgsxN6t18ngSGh98rgCwXsZaVgFjb
BXKJSs3/seIK/SpDlxFi5XgOPyoG3wkZg3gZDvkXTEiaxAysYZuyUeam3hc+VM7X
5jTRQh0NL+OWoF+Srw6sHoM+qLi8ySiiVRB7vZEGVg4w/MYgI20=
=9D5P
-----END PGP SIGNATURE-----

--Sig_/0nGQc7.fWXR1w2fbHGJuA_n--
