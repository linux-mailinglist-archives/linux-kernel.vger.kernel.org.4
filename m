Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3669DC32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjBUIih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBUIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:38:35 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293523858;
        Tue, 21 Feb 2023 00:38:06 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b18so3561625ljr.4;
        Tue, 21 Feb 2023 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXmAWRuzmcV8Elsgdpg1EiI+Ar/Kv6HOxJGHhplNmBg=;
        b=dacIh5Ip7zWYTo66VddkqH1AfAudtj7gH52ck6kXphg5LwhFeolG9qkrO5LWkYrWyf
         GqvWuZ2hA54hvbMbl8tRU6otjWwAMQ6bvtvZh5kLtSS4eeg+CaW2UFF77WFdzDI2VO3Y
         7jVrXjtT2juixcnwr1x5LiyFghiE/hjVahbY6+YD2FqqWhQD/Z5214mrmCUZvaicui0h
         2rO+0B9/MP5IcWzLESsiPdMB/Q2Kus+ed5DtStRFYKTuUj+5PL7G6EstrxrT6Lpxufcs
         mcutB/4bghXrgFem9w3UcAgEr32cDXDvGDD6JRLy0ibSiJ4WMe9ncBolo7MeuNu73vUq
         ZFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXmAWRuzmcV8Elsgdpg1EiI+Ar/Kv6HOxJGHhplNmBg=;
        b=zbCJ94i4j7inMvDxre54pPyQjvOnH66FF3sFP2pDzhv77kqitUFWy8jFmh+zygSg2g
         JVn/YkOvY2JdmsoC4okmHTMm7deCOLM7ImYFxgqKb8bh4otYkgDp/FvyyOfSJb2nyDrk
         OZ/K2ZEC3zrFYXp+wkewUYgI2fp8X34yKoXdVuYz4e4DoWp6UcnbKT1fGxxJvcC6/cG8
         35UR0b0rHgkcf+7IHLF/F+mvK0Bptn08a1fT2Jdb628m8tLeHR5PSPudG/4L7c4qfsIH
         chV6uUwTDxI8f78ejvVVSFu0c9lv2WePsiPL/UxRRM5+hnX22OkRzmXp6c2WFke5Gu9Z
         XM2w==
X-Gm-Message-State: AO0yUKVCYyeHitMir/RUzIiyNQ7s0cur6glFFGHm63v1CfnKoLzskGSp
        EdZiALQnTtd4FD1BI020qrg=
X-Google-Smtp-Source: AK7set+RqtfaOTqpjveAHIaH/mYBQDFd3HyzVq+YqARYpYETRDSQ5RKHLNE5xPgMIu7o4b3tO9CwXQ==
X-Received: by 2002:a2e:a1c7:0:b0:293:6037:9850 with SMTP id c7-20020a2ea1c7000000b0029360379850mr1456739ljm.51.1676968683953;
        Tue, 21 Feb 2023 00:38:03 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05651c169100b002934ed148afsm23315ljb.52.2023.02.21.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 00:38:03 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:37:53 +0200
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
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
Message-ID: <20230221103753.205082d3@eldfell>
In-Reply-To: <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
        <20230218211608.1630586-7-robdclark@gmail.com>
        <20230220105345.70e46fa5@eldfell>
        <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GOkb+s3y./0Y.sz97vQW68J";
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

--Sig_/GOkb+s3y./0Y.sz97vQW68J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Feb 2023 08:14:47 -0800
Rob Clark <robdclark@gmail.com> wrote:

> On Mon, Feb 20, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wro=
te:
> >
> > On Sat, 18 Feb 2023 13:15:49 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> > =20
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
> > > wait (as opposed to a "housekeeping" wait to know when to cleanup aft=
er
> > > some work has completed).  Usermode components of GPU driver stacks
> > > often poll() on fence fd's to know when it is safe to do things like
> > > free or reuse a buffer, but they can also poll() on a fence fd when
> > > waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
> > > lets the kernel differentiate these two cases.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org> =20
> >
> > Hi,
> >
> > where would the UAPI documentation of this go?
> > It seems to be missing. =20
>=20
> Good question, I am not sure.  The poll() man page has a description,
> but my usage doesn't fit that _exactly_ (but OTOH the description is a
> bit vague).
>=20
> > If a Wayland compositor is polling application fences to know which
> > client buffer to use in its rendering, should the compositor poll with
> > PRI or not? If a compositor polls with PRI, then all fences from all
> > applications would always be PRI. Would that be harmful somehow or
> > would it be beneficial? =20
>=20
> I think a compositor would rather use the deadline ioctl and then poll
> without PRI.  Otherwise you are giving an urgency signal to the fence
> signaller which might not necessarily be needed.
>=20
> The places where I expect PRI to be useful is more in mesa (things
> like glFinish(), readpix, and other similar sorts of blocking APIs)

Sounds good. Docs... ;-)

Hmm, so a compositor should set the deadline when it processes the
wl_surface.commit, and not when it actually starts repainting, to give
time for the driver to react and the GPU to do some more work. The
deadline would be the time when the compositor starts its repaint, so
it knows if the buffer is ready or not.


Thanks,
pq


>=20
> BR,
> -R
>=20
> >
> >
> > Thanks,
> > pq
> > =20
> > > ---
> > >  drivers/dma-buf/sync_file.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> > > index fb6ca1032885..c30b2085ee0a 100644
> > > --- a/drivers/dma-buf/sync_file.c
> > > +++ b/drivers/dma-buf/sync_file.c
> > > @@ -192,6 +192,14 @@ static __poll_t sync_file_poll(struct file *file=
, poll_table *wait)
> > >  {
> > >       struct sync_file *sync_file =3D file->private_data;
> > >
> > > +     /*
> > > +      * The POLLPRI/EPOLLPRI flag can be used to signal that
> > > +      * userspace wants the fence to signal ASAP, express this
> > > +      * as an immediate deadline.
> > > +      */
> > > +     if (poll_requested_events(wait) & EPOLLPRI)
> > > +             dma_fence_set_deadline(sync_file->fence, ktime_get());
> > > +
> > >       poll_wait(file, &sync_file->wq, wait);
> > >
> > >       if (list_empty(&sync_file->cb.node) && =20
> > =20


--Sig_/GOkb+s3y./0Y.sz97vQW68J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP0guEACgkQI1/ltBGq
qqf13g//YJ2rnH+E++Hj+BIIexJyigGRb4u4jrJTM5mZ9F5IbwwlyPYI1ave26xA
E2fQdmTIrob7UZDSU0pjl0rHfGvqDlZVZP8IdhAA1Qwvsw8JUZ8XknppQ4THxMPh
RgR5+XExivkzqj5L7UZaPb4oYLlp5qCooiS6iIgCI0Dx+cov3zfOGL8DJOFQKGXV
reume8wVPWdqLS85ALYVHVdiOgWdxd+kw/njtM6lc6DYj3JTmrlEXY5puS60bH9t
uBbd9AZm+PCKWX3qbxKCxWK8W06xAqaR1ZiCuRMvxN7L4hEbTTrkTIgUEkM2W6cF
ItT8wY83agbYcCNQJcQ7U3EOGoDY/CKsKAnXNrEKKh3Jpemn3sKwVkIk4KboT4Ke
mBtKMFrB/DtBGQBSD4Vn2YFSBZg8R5fDlOoMZhbZUltzYBHDOs7U631uVEkia+Mp
RU2hOSjThTwQpJTTzw6QzrXQdurSUMYP/Wub6jOEH0mTnkCr4ENuR+QfdVeHCt37
AM0B7KHNlEn40Vn8dbGV7yzUIep87BJWOKFXWhXWIJKQQPW9R6TWms5Xx7c/QbYd
iwbPR/DBfQb6Huz9Ls8WFN5o8VvAEKQGtjCRn33J35aQYFmDseUbVqCuDv0HIYI+
fFaaFPBWL+1GhBlITlBWAq5/ow9vvif11bWzStLTowmvoivxyWU=
=WDHn
-----END PGP SIGNATURE-----

--Sig_/GOkb+s3y./0Y.sz97vQW68J--
