Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9371F6A9AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjCCPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCCPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:45:23 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E612BF7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:45:18 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17213c961dfso3425570fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677858317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oMaAqKp70rucwAbCAe5Akiveom7SO9ApMDc3ILYjPM=;
        b=CZS/kLR1XDmMZutlePV59iDp/P690A0ZT5manMZ7/nS/4HLtN+WFNFuTBRhkgyt2eo
         40+ngPGZ+iH2Gkn34gpMdeRfh/yyRs9V75po+2OL7rtpHz04Hgwt+o/pzt7rumFzY+Dr
         zUKrGit+yK+JsY800eQ0QUIEXMFGXlrxsx9f2Z4mlCRCtKOz4Jh+MrPSFHw2ETuDyM8e
         gA9RxkGtRfTM1wankLqMwUHjHyGC2cjdwnuAYtkQckeS0N8xiOFtXABahQmlgZKM9FWS
         diI+qeta4mNPyERFenvA2ymh+0VvyoD71Ysv5T9uHNAJZuTf2yJyhKUEvfcN5qHT86Fh
         wrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677858317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oMaAqKp70rucwAbCAe5Akiveom7SO9ApMDc3ILYjPM=;
        b=Vs7pKXVrx1TlISKarlfIufog8L6mWrBgcyEjImnGpT4HPTkoskdFVwJsIdBP+RGekp
         iL709rkHYyX/hw5MXQuRhcNk7ki7o7TNtJVH2sVg++Vc7+W7gArwczmfGUXx74/LTfD/
         OKSeuPKfrIRaywOUN/suJnz7L0xMI/c7UW0OaV2DmxnlxS7MtxaANS6mX7+o/Sg/jC1o
         5dsTFlPu2enyDfrkjVTSwqj7REaWldnJ2L3LA1LiPtkDu3Px+V9YPXH1yLi6PUyHP4pV
         DJ/5nJ1GyM1jq7hng1dw5pqmi34FpwLuUsVRs1KfGgqSW92j5l8Dyy30xJ7NqA7DFbRL
         QQMg==
X-Gm-Message-State: AO0yUKVRoTa113bsAWkozmehZXurtwTzjSJf3TJh9ZZJfMPn6UVauLGJ
        5ttUYVMQl0isPGXz7M4uIw4E4nkBQTmFELQ7V7I=
X-Google-Smtp-Source: AK7set8dni3ftARSzuB7mCn0RHsIaZgP2tzM95InzxXtdqoh5ooukYqrssT6lkvFBO4iOrGptErrOnoURJB1EoAxZZE=
X-Received: by 2002:a05:6870:d2a5:b0:172:6f4:dcdf with SMTP id
 d37-20020a056870d2a500b0017206f4dcdfmr713624oae.3.1677858317098; Fri, 03 Mar
 2023 07:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20230302235356.3148279-1-robdclark@gmail.com> <20230302235356.3148279-12-robdclark@gmail.com>
 <ZAIOaiogeUhhNVfo@intel.com>
In-Reply-To: <ZAIOaiogeUhhNVfo@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 3 Mar 2023 07:45:05 -0800
Message-ID: <CAF6AEGuL+B6sR2=7MFvqT0zfsgraoOdzAJBF=Ke1ce1umYh4Xw@mail.gmail.com>
Subject: Re: [PATCH v9 11/15] drm/atomic-helper: Set fence deadline for vblank
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:12 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Mar 02, 2023 at 03:53:33PM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > For an atomic commit updating a single CRTC (ie. a pageflip) calculate
> > the next vblank time, and inform the fence(s) of that deadline.
> >
> > v2: Comment typo fix (danvet)
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index d579fd8f7cb8..d8ee98ce2fc5 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1511,6 +1511,40 @@ void drm_atomic_helper_commit_modeset_enables(st=
ruct drm_device *dev,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> >
> > +/*
> > + * For atomic updates which touch just a single CRTC, calculate the ti=
me of the
> > + * next vblank, and inform all the fences of the deadline.
> > + */
> > +static void set_fence_deadline(struct drm_device *dev,
> > +                            struct drm_atomic_state *state)
> > +{
> > +     struct drm_crtc *crtc, *wait_crtc =3D NULL;
> > +     struct drm_crtc_state *new_crtc_state;
> > +     struct drm_plane *plane;
> > +     struct drm_plane_state *new_plane_state;
> > +     ktime_t vbltime;
> > +     int i;
> > +
> > +     for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> > +             if (wait_crtc)
> > +                     return;
> > +             wait_crtc =3D crtc;
> > +     }
> > +
> > +     /* If no CRTCs updated, then nothing to do: */
> > +     if (!wait_crtc)
> > +             return;
>
> Is there an actual point in limiting this to single crtc updates?
> That immediately excludes tiled displays/etc.
>
> Handling an arbitrary number of crtcs shouldn't really be a lot
> more complicated should it?

I guess I could find the soonest upcoming vblank of all the CRTCs and
use that as the deadline?

BR,
-R

> > +
> > +     if (drm_crtc_next_vblank_start(wait_crtc, &vbltime))
> > +             return;
> > +
> > +     for_each_new_plane_in_state (state, plane, new_plane_state, i) {
> > +             if (!new_plane_state->fence)
> > +                     continue;
> > +             dma_fence_set_deadline(new_plane_state->fence, vbltime);
> > +     }
> > +}
> > +
> >  /**
> >   * drm_atomic_helper_wait_for_fences - wait for fences stashed in plan=
e state
> >   * @dev: DRM device
> > @@ -1540,6 +1574,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_=
device *dev,
> >       struct drm_plane_state *new_plane_state;
> >       int i, ret;
> >
> > +     set_fence_deadline(dev, state);
> > +
> >       for_each_new_plane_in_state(state, plane, new_plane_state, i) {
> >               if (!new_plane_state->fence)
> >                       continue;
> > --
> > 2.39.1
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
