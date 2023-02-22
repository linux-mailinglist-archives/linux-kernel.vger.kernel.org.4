Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9269F850
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjBVPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjBVPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:50:20 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6038E87
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:50:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bq17so8420451oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UHAZZhL11gL8UTjrX5E88IcCEXngYleP44TeQvxj0s=;
        b=YdRvd5v12NrKg99SfPtndyWPurVRX+Kx3nmMpqHLX4atNqYHhwHVGg++kO6dVv5//g
         8g3LU99Zd3nF+s+vrxzZ5airWex5WBaSettImAINg2M6ChB/SHfLhS+271CePJxoWMvt
         WhgvwIeglq1xNcgWbJq16m58R991MBKdhk/PD0chH/FMqTwRJgYzmhGkWY1WE/DUE+4Z
         QJy3H7LSr+RRvR19rqezNf0BEk1U52nLMajRohsSjfejNaung+7edg4JriLocxqazSCF
         7pa3wcEYOwaFsLBlFdPf5QYn7Kpn8zYzZ084OT84P2IhVBCiDzBeIfAzWz0W3RVDrZY3
         2N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UHAZZhL11gL8UTjrX5E88IcCEXngYleP44TeQvxj0s=;
        b=ob2Jaqd/ulpF3PHg5j/zpnzvc5BXDd7KeF5hoHO6DYyhQ5G64zvteDYy79xUQ7j64N
         TabRZ4+4rIzk4gyObSUjeVLt60ptbJWq2TlTaL5F3e+098RAl0e5ZbPThEgPm6aNAgLp
         j2hG0hIykEhwIm8g+cJG77qQsRY/8yKz673tkuSsBXbgk8+BpSdn/vnX18fIsrTgfWKE
         iUdfxA9Oih9bD8pP0ofxurd+DpWn5lCkBg8s8FN/kOIxn0Y5M4gIenDweC8R31ez1KWb
         ROqrm8CzCRH332Pv81E45oI3UqbmvJG9WN3yy7bGfRb1fBYflTtbVMNR6DxVACXqFKC8
         /zvQ==
X-Gm-Message-State: AO0yUKXxYMQyUODccirSjEdU/PZzx/wjW0MlbtmtLyxi4lS7edDb+fW0
        ilhlULMn+TEvLRv8KeUZiXqpLCScbcsZx4mI7OU=
X-Google-Smtp-Source: AK7set+c0dy4ImZnheb+bG7g5OkK5ckxlgxd/4GTHy65N9mf+AP7QsVeve9HcZDEG2G1Uo5tQ+esjM06YWfaFAGZ3p4=
X-Received: by 2002:a05:6808:16ab:b0:37d:81a9:5103 with SMTP id
 bb43-20020a05680816ab00b0037d81a95103mr1416311oib.38.1677081015390; Wed, 22
 Feb 2023 07:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-12-robdclark@gmail.com>
 <a4a72b25-2db3-21c4-c8c0-bb027db59d61@amd.com>
In-Reply-To: <a4a72b25-2db3-21c4-c8c0-bb027db59d61@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Feb 2023 07:50:04 -0800
Message-ID: <CAF6AEGvksxih1zVYrD861uVyp=7SVg+_PmJMZd24fo0Rt6jzmA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] drm/atomic-helper: Set fence deadline for vblank
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 2:46 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2023-02-18 16:15, Rob Clark wrote:
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
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index d579fd8f7cb8..35a4dc714920 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1511,6 +1511,40 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> >
> > +/*
> > + * For atomic updates which touch just a single CRTC, calculate the time of the
> > + * next vblank, and inform all the fences of the deadline.
> > + */
> > +static void set_fence_deadline(struct drm_device *dev,
> > +                            struct drm_atomic_state *state)
> > +{
> > +     struct drm_crtc *crtc, *wait_crtc = NULL;
> > +     struct drm_crtc_state *new_crtc_state;
> > +     struct drm_plane *plane;
> > +     struct drm_plane_state *new_plane_state;
> > +     ktime_t vbltime;
>
> I've not looked at the latest language spec, but is AFAIR "vbltime"
> would be uninitialized here. Has this changed?
>
> > +     int i;
> > +
> > +     for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> > +             if (wait_crtc)
> > +                     return;
> > +             wait_crtc = crtc;
> > +     }
> > +
> > +     /* If no CRTCs updated, then nothing to do: */
> > +     if (!wait_crtc)
> > +             return;
> > +
> > +     if (drm_crtc_next_vblank_time(wait_crtc, &vbltime))
> > +             return;
>
> We have a problem here in that we're adding the time remaining to the next
> vblank event to an uninitialized local variable. As per my comment on patch 10,
> I'd rather drm_crtc_next_vblank_time() yield the time remaining to the vblank event,
> and we can do the arithmetic locally here in this function.

if drm_crtc_next_vblank_time() returns 0 then it has initialized
vbltime, so no problem here

BR,
-R

> --
> Regards,
> Luben
>
> > +
> > +     for_each_new_plane_in_state (state, plane, new_plane_state, i) {
> > +             if (!new_plane_state->fence)
> > +                     continue;
> > +             dma_fence_set_deadline(new_plane_state->fence, vbltime);
> > +     }
> > +}
> > +
> >  /**
> >   * drm_atomic_helper_wait_for_fences - wait for fences stashed in plane state
> >   * @dev: DRM device
> > @@ -1540,6 +1574,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
> >       struct drm_plane_state *new_plane_state;
> >       int i, ret;
> >
> > +     set_fence_deadline(dev, state);
> > +
> >       for_each_new_plane_in_state(state, plane, new_plane_state, i) {
> >               if (!new_plane_state->fence)
> >                       continue;
>
