Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916A69E5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjBUR0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjBURZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:25:55 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605A2B282
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:25:33 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so919323otm.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUZKbSoFWnuwReSERsoV9Wdb3OjgxSIYogm4tO3N2Ec=;
        b=FCO2AKwabY6RQETfbchne5LUaaKUFyRuhWeic6UgWM9TYRUqdmEXDWg+YnkSIN7DqN
         bMKG7zZzrZKez6XUtW4wEgNCNZl+3aSaf1yCtULjfRatInCvE2hyCD+itjyosC7WL35I
         PYoS6iK/4lVpTnTvAfGqnSaMYCTE4bzGaDjAayRep3N+4fcYigCDz7PAWMSvedSpLR5u
         LOJyY3cxtECh4FEjdA0gioaCXtUdQUQQA3nkcooqSm5vJ8gqF4clD4ciZ9K4M/y2kmgD
         1IuhInRzNKKQ9C7cAYJVlvH+iHFHh+c4kNn7izoXjUiXWQ7ClQ7GWmGlziFPzGaxfCpA
         BMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUZKbSoFWnuwReSERsoV9Wdb3OjgxSIYogm4tO3N2Ec=;
        b=KfTtCzYJFUJ6GYvN92yqVlNkOyR5urmAclOHpmAnIWHllPzBO5P+87SSrCsZEaUpaO
         Un1eG3ekjV38P4iV66vbAQUF0dyTW0uTZ4rMIPb3KR8ucfrbTG/v/vzjaMTAkUj88Kvu
         AxUM7UtCeFAChgJ9sgn0NYALTeKoSg9xBfu7HHKhjRKAWl2Pp5+awi+WSA5gtDtJD5Aj
         r1xeYaBwMh581RBNGY+jmb0CBSsgTf+C/w+OwuzK0JQjQ59TNqNxVtwF8DKNmDzw05rs
         fdXiYHKqZku3Rm4P0davBTO9cjag08tvl6vkUA4dj46ImJc+83GS6m/RI7Nq4G8ICcZC
         HS6g==
X-Gm-Message-State: AO0yUKVRbFIYsHnrweyyHyXDTc8Y3ilzfmA3CRfYmuNO2YU9PuAleUKh
        v/zGVBVMboa3Ita5eIPYvNJyQTYE4/5PAa1n1rQvjxAF
X-Google-Smtp-Source: AK7set9vcYOSX5l6mgud8fgzE8JUqk4DUkzH+ZWi+U1jbIq+VbE9nC8KygmQ3cxtQtOiMsmzIWlPynFvftfoLc5ra3o=
X-Received: by 2002:a05:6830:1c69:b0:690:d1dd:f62a with SMTP id
 o41-20020a0568301c6900b00690d1ddf62amr292386otg.7.1677000328646; Tue, 21 Feb
 2023 09:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20230220201916.1822214-1-robdclark@gmail.com> <20230220201916.1822214-10-robdclark@gmail.com>
 <20230221105307.7430c301@eldfell>
In-Reply-To: <20230221105307.7430c301@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Feb 2023 09:25:18 -0800
Message-ID: <CAF6AEGtd_9JYtPU-AGmZY0My_d48rSSWQiD-efbR2KFxD-+tTA@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] drm/syncobj: Add deadline support for syncobj waits
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

On Tue, Feb 21, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Mon, 20 Feb 2023 12:18:56 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a new flag to let userspace provide a deadline as a hint for syncobj
> > and timeline waits.  This gives a hint to the driver signaling the
> > backing fences about how soon userspace needs it to compete work, so it
> > can addjust GPU frequency accordingly.  An immediate deadline can be
> > given to provide something equivalent to i915 "wait boost".
> >
> > v2: Use absolute u64 ns value for deadline hint, drop cap and driver
> >     feature flag in favor of allowing count_handles==0 as a way for
> >     userspace to probe kernel for support of new flag
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_syncobj.c | 59 +++++++++++++++++++++++++++--------
> >  include/uapi/drm/drm.h        |  5 +++
> >  2 files changed, 51 insertions(+), 13 deletions(-)
>
> ...
>
> > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > index 642808520d92..aefc8cc743e0 100644
> > --- a/include/uapi/drm/drm.h
> > +++ b/include/uapi/drm/drm.h
> > @@ -887,6 +887,7 @@ struct drm_syncobj_transfer {
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
> > +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadline based to deadline_nsec/sec */
>
> Hi,
>
> where is the UAPI documentation explaining what is a "fence deadline"
> and what setting it does here?

It's with the rest of the drm_syncobj UAPI docs ;-)

BR,
-R

> btw. no nsec/sec anymore.
>
>
> Thanks,
> pq
>
>
> >  struct drm_syncobj_wait {
> >       __u64 handles;
> >       /* absolute timeout */
> > @@ -895,6 +896,8 @@ struct drm_syncobj_wait {
> >       __u32 flags;
> >       __u32 first_signaled; /* only valid when not waiting all */
> >       __u32 pad;
> > +     /* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC: */
> > +     __u64 deadline_ns;
> >  };
> >
> >  struct drm_syncobj_timeline_wait {
> > @@ -907,6 +910,8 @@ struct drm_syncobj_timeline_wait {
> >       __u32 flags;
> >       __u32 first_signaled; /* only valid when not waiting all */
> >       __u32 pad;
> > +     /* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC: */
> > +     __u64 deadline_ns;
> >  };
> >
> >
>
