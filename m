Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38AD69D0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjBTPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBTPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:55:53 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0D1C32E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:55:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id c11so2160963oiw.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ6Kknlmvc9DIbm4e8wsI/pOA7p8O3i81OSguHmnNFI=;
        b=gk4ZoYpF6iksdu5qT+UZvbxnmmmVT5Im7xBF4n9KIXSILbxnqgMFgrCmZ3HLp+4Pn8
         hWb1uonfp40Ddh3Hf3aj4uTt5OcveMYw5o5SEz/3mFFK83GFX+dV6HL5478mUsrzYrp1
         jMvlaNhQM3booiC0YrY0uZwKVs11TjZDNaxrPa2OUeNwB1ngqnXsijPiK+oxeAsBySTO
         dY3Uo1qMRQPyOi38gqSdJHmGILHn0zd6LzQ2O/2iSDXbHqBQH9aqsLPIbtbqVlOz5ka4
         DdUraySxUyhVacai27Rw7i/8rkzFqXaR16Yz/ePdCIu0eFf4MOxWsNddNEWlD5r4NtRj
         5gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQ6Kknlmvc9DIbm4e8wsI/pOA7p8O3i81OSguHmnNFI=;
        b=nWEGAOmYuu+lr9+Aj1N8ML2Y4XkyCWo1SeOt7hsWq/boMjquHrV/1k604Q6q+ikYge
         7Wzy0d5V+k0T+/wvL56qpUmajzxGwTvAFRCQ1O8bBk21GOexTbz7fC4ukCXZpFQgkx9J
         WhMm+bFIZZKQCCFy4Yp2ELDwCSUsisNvsrVtm/RBp/QwuxJmzFCgHPgc/qWQwDUINUji
         clrCBWLWqji4zgkoJ9dmwaBHIZ1YbEc1DEPNzUcaSHchtj1aSib4at+TrwLy4M4lOuX+
         QZbrfdiwYwBagYZ1gnVzWCSxkhkIX0/+pZyUVvV46Rp6mumSfxVZB3MBTz6qOdqduuIb
         UoLQ==
X-Gm-Message-State: AO0yUKXmMWBGkzUBIRQNCKHzqXzjLtNh5Nej10bjf2LAD4i9/tIJWCbR
        KqxRLRtTZzc8NYAVg+CdBUtgP+I2b6d7f7IWECA=
X-Google-Smtp-Source: AK7set+1QVqU6Yi01Un76S8bt89KSL5PD7pJAEx9qb3NA/5CI1WH8naIPrQAeTFJ7Z/4IijGHI55omf90jmAN5A9jPw=
X-Received: by 2002:a05:6808:ec7:b0:364:c0a5:1fcf with SMTP id
 q7-20020a0568080ec700b00364c0a51fcfmr1099851oiv.58.1676908551633; Mon, 20 Feb
 2023 07:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-11-robdclark@gmail.com>
 <20230220110820.595cfa37@eldfell>
In-Reply-To: <20230220110820.595cfa37@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Feb 2023 07:55:41 -0800
Message-ID: <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
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

On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Sat, 18 Feb 2023 13:15:53 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Will be used in the next commit to set a deadline on fences that an
> > atomic update is waiting on.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++++
> >  include/drm/drm_vblank.h     |  1 +
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 2ff31717a3de..caf25ebb34c5 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> >  }
> >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> >
> > +/**
> > + * drm_crtc_next_vblank_time - calculate the time of the next vblank
> > + * @crtc: the crtc for which to calculate next vblank time
> > + * @vblanktime: pointer to time to receive the next vblank timestamp.
> > + *
> > + * Calculate the expected time of the next vblank based on time of previous
> > + * vblank and frame duration
>
> Hi,
>
> for VRR this targets the highest frame rate possible for the current
> VRR mode, right?
>

It is based on vblank->framedur_ns which is in turn based on
mode->crtc_clock.  Presumably for VRR that ends up being a maximum?

BR,
-R


>
> Thanks,
> pq
>
> > + */
> > +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime)
> > +{
> > +     unsigned int pipe = drm_crtc_index(crtc);
> > +     struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
> > +     u64 count;
> > +
> > +     if (!vblank->framedur_ns)
> > +             return -EINVAL;
> > +
> > +     count = drm_vblank_count_and_time(crtc->dev, pipe, vblanktime);
> > +
> > +     /*
> > +      * If we don't get a valid count, then we probably also don't
> > +      * have a valid time:
> > +      */
> > +     if (!count)
> > +             return -EINVAL;
> > +
> > +     *vblanktime = ktime_add(*vblanktime, ns_to_ktime(vblank->framedur_ns));
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(drm_crtc_next_vblank_time);
> > +
> >  static void send_vblank_event(struct drm_device *dev,
> >               struct drm_pending_vblank_event *e,
> >               u64 seq, ktime_t now)
> > diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> > index 733a3e2d1d10..a63bc2c92f3c 100644
> > --- a/include/drm/drm_vblank.h
> > +++ b/include/drm/drm_vblank.h
> > @@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *dev);
> >  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> >  u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> >                                  ktime_t *vblanktime);
> > +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime);
> >  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
> >                              struct drm_pending_vblank_event *e);
> >  void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
>
