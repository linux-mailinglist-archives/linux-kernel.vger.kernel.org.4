Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F147645CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiLGOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:46:17 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282385915F;
        Wed,  7 Dec 2022 06:46:14 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so5838067otp.9;
        Wed, 07 Dec 2022 06:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pCx/E76TgK/9YaFBrP8sS3CTQZp59lVD/AHPvEf9LTo=;
        b=hOvi/ppN1s+rwt2vnOeSAFAGsHGLoFSY+ASbI5Kqs5egtVEYsq6csNx2XV/4S5iF+e
         LhY77bBtB03M2NPj9vnMcXYE5vqSO3XcNMEkKbWUfWXJoH0P3IJyjOD2DjcwlbhHgyji
         4aVxsbHjchRcrFRfDIfkk2tP5C5GoJjm1Kzfd+qdBPdUeR50a0VvjRTP6HxW5EqhiiGU
         GiaWEgNA6T/06KhkSClbVg0ZmMbvTc86ID8d5V81EQ1BqgzW4M781QxRxpXlfLzE1tWh
         bOl8+0Ige7/i+uYkhfCiXxpzeKNOIQujl6pXDGctLZsiu6lYUrMR7phFydDsWpx4mW4h
         4e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCx/E76TgK/9YaFBrP8sS3CTQZp59lVD/AHPvEf9LTo=;
        b=WVJVKpPMvqOtzrZaqKi0gZVWIglnGl6nFKUi2TjZypHU8oVu0wVcBXCOqVBKk++pEG
         zlpSO0SUCynA1vFzRULLLbw1Heyl69F10vtonCCK/dHWmtKE9IhCmahKuiXP9G3UCDqN
         LccSJTfgYvSHlu5uI3O0gOYZ1cAJlVah+hfcBLBFdj0w42KeyoT0HLNDwTY7rzb5q0U1
         EECmNkzTPK8pKv/RRdmqfHFuaSBY3aqwKa42bD0JIntIysfivrRqHk7ljWtpWLG5gSqx
         daVp70vAdZQuOi/HGbZOENZbWZvnCYz73/xVgFSYWkYPdFWqrDNj+RPRH3DCCcUJ7u//
         EpBQ==
X-Gm-Message-State: ANoB5pljLfyy3GT2Vf4zFupCrreoz1SDE2uPQ2rNoGxJAC9xcXlZG3f7
        GhRGOpBs195BlbcR84iAk0eGu6treaBqOwUACVo=
X-Google-Smtp-Source: AA0mqf4eof0tNHTw1xsmbn9ySQtKoofw7nwky/Tb+KzP9HTjiiwLw4FWjzKNXXQaSmGg3mwLh5PElZz2fFxLxErXwg0=
X-Received: by 2002:a9d:75d5:0:b0:667:7361:7db5 with SMTP id
 c21-20020a9d75d5000000b0066773617db5mr38441176otl.22.1670424373348; Wed, 07
 Dec 2022 06:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20221206192123.661448-1-robdclark@gmail.com> <d3433e207ff8ea243ff1d4cceeea19e4676c97c5.camel@pengutronix.de>
In-Reply-To: <d3433e207ff8ea243ff1d4cceeea19e4676c97c5.camel@pengutronix.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 7 Dec 2022 06:46:08 -0800
Message-ID: <CAF6AEGtO8hjJocOccsxwWmtLFUfMH7e1EMm-2xLKa2zSr0JCKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Add MSM_SUBMIT_BO_NO_IMPLICIT
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Wed, Dec 7, 2022 at 2:15 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Rob,
>
> Am Dienstag, dem 06.12.2022 um 11:21 -0800 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In cases where implicit sync is used, it is still useful (for things
> > like sub-allocation, etc) to allow userspace to opt-out of implicit
> > sync on per-BO basis.
> >
> Out of curiosity and because I have been thinking about something like
> that for etnaviv for while: do you only use this for immutable buffers
> or do you have some kind of userspace fencing in place for the
> suballocated buffers?

yup, userspace fences.. which is a thing you'd really want for doing
suballocation

BR,
-R

>
> Regards,
> Lucas
>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c        |  3 ++-
> >  drivers/gpu/drm/msm/msm_gem_submit.c | 11 +++++++++++
> >  include/uapi/drm/msm_drm.h           |  4 +++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 017a512982a2..e0e1199a822f 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -45,9 +45,10 @@
> >   * - 1.7.0 - Add MSM_PARAM_SUSPENDS to access suspend count
> >   * - 1.8.0 - Add MSM_BO_CACHED_COHERENT for supported GPUs (a6xx)
> >   * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
> > + * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
> >   */
> >  #define MSM_VERSION_MAJOR    1
> > -#define MSM_VERSION_MINOR    9
> > +#define MSM_VERSION_MINOR    10
> >  #define MSM_VERSION_PATCHLEVEL       0
> >
> >  static const struct drm_mode_config_funcs mode_config_funcs = {
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> > index eb3536e3d66a..8bad07a04f85 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -334,9 +334,20 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
> >               if (ret)
> >                       return ret;
> >
> > +             /* If userspace has determined that explicit fencing is
> > +              * used, it can disable implicit sync on the entire
> > +              * submit:
> > +              */
> >               if (no_implicit)
> >                       continue;
> >
> > +             /* Otherwise userspace can ask for implicit sync to be
> > +              * disabled on specific buffers.  This is useful for internal
> > +              * usermode driver managed buffers, suballocation, etc.
> > +              */
> > +             if (submit->bos[i].flags & MSM_SUBMIT_BO_NO_IMPLICIT)
> > +                     continue;
> > +
> >               ret = drm_sched_job_add_implicit_dependencies(&submit->base,
> >                                                             obj,
> >                                                             write);
> > diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> > index f54b48ef6a2d..329100016e7c 100644
> > --- a/include/uapi/drm/msm_drm.h
> > +++ b/include/uapi/drm/msm_drm.h
> > @@ -222,10 +222,12 @@ struct drm_msm_gem_submit_cmd {
> >  #define MSM_SUBMIT_BO_READ             0x0001
> >  #define MSM_SUBMIT_BO_WRITE            0x0002
> >  #define MSM_SUBMIT_BO_DUMP             0x0004
> > +#define MSM_SUBMIT_BO_NO_IMPLICIT      0x0008
> >
> >  #define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> >                                       MSM_SUBMIT_BO_WRITE | \
> > -                                     MSM_SUBMIT_BO_DUMP)
> > +                                     MSM_SUBMIT_BO_DUMP | \
> > +                                     MSM_SUBMIT_BO_NO_IMPLICIT)
> >
> >  struct drm_msm_gem_submit_bo {
> >       __u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
>
>
