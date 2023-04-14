Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3116E1BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDNFgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:36:48 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74133AA7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:36:46 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1879502e2afso4622991fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681450606; x=1684042606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o53Ppz6NZcU37xVTZUVRtByt/0ke8sUTMMek2QrzwKE=;
        b=FSjVM05I0ApxhJqbteEjBl2Bp36eX21Cb4WifR2YmXPCSuquAnHovbEB9VtcBvpdZF
         GkOVyBWgZpDR1WxBTe5/2S0JLT5Ig5gu29qy/MmYWU3PI29CA77L7t5hLx86fmWg1SoX
         vIMBveRKf+8nryi23v82xdsIHTW8bF1XYZwpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681450606; x=1684042606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o53Ppz6NZcU37xVTZUVRtByt/0ke8sUTMMek2QrzwKE=;
        b=k1xCxTf9q4ASkcYWf37SXGGyTbjH46vl6ziZYrFQf3vJHSckjeaD8xrJUpjUsrBhWd
         nmPjAjKfC7JwOTl1RqFnCDRq+OFMg3UDN0PR5QI8dJWkD/Dg3roK6VFyfF8n4xH6PYBP
         migzBBsrYZfzo1EKEz5zYqR3VyDc5HwdxANLH0sJeoXHb1ju2ikHUbbrpaY0gHdRSyHx
         5gU1daNaGKmLx40PFEJ65Vi8W+l6mQOZ7AjuwjlI0zcSgpxnAC3Wu9hYvroqmXZ6wQiM
         7DElHsy+NepkS5rdyMmodqaBiZg+Xq5KUviMXVrhNw5kGGLro5AUAU8rtk4cnYj0IHu6
         YQ3w==
X-Gm-Message-State: AAQBX9d9cqNBT7CzDYoKWUMm31CO9MOX03sT+uXF1W6PW97gmrnTRhR/
        8pERihCEGJx9FUKRdt3qDfwV4hAE576S0mBpab8kb5gwtrKLATMr
X-Google-Smtp-Source: AKy350ZZ15f1qHCswOjx4ytld5O7vtI4SR8Rr/cCYug8550zr1o0RVzjbIhhBzFSX89ILgqQ9x1jWYgASjXEfpgGVlo=
X-Received: by 2002:a05:6870:40c1:b0:184:7e3c:e33e with SMTP id
 l1-20020a05687040c100b001847e3ce33emr2078381oal.8.1681450606092; Thu, 13 Apr
 2023 22:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230409132110.494630-1-15330273260@189.cn> <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn> <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
 <dbac96b2-0fea-591b-517d-2a23cc36b8de@189.cn> <CAKMK7uG_h7htCDARudZpHOOMG4iOOLZmz0_WskvWGf+DKGwU1w@mail.gmail.com>
 <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn> <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
 <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de> <ZDhfkq92hbGc630z@phenom.ffwll.local>
 <1b44a3b5-5053-f121-ee62-de83d505759e@189.cn>
In-Reply-To: <1b44a3b5-5053-f121-ee62-de83d505759e@189.cn>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 14 Apr 2023 07:36:34 +0200
Message-ID: <CAKMK7uHRWy=7m3=eEQz324kKOh9AM8J3Rma=KgBic0pRmW1NBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 at 06:24, Sui Jingfeng <15330273260@189.cn> wrote:
>
> Hi,
>
> On 2023/4/14 04:01, Daniel Vetter wrote:
> > On Thu, Apr 13, 2023 at 09:20:23PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 13.04.23 um 20:56 schrieb Daniel Vetter:
> >> [...]
> >>> This should switch the existing code over to using drm_framebuffer instead
> >>> of fbdev:
> >>>
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> >>> index ef4eb8b12766..99ca69dd432f 100644
> >>> --- a/drivers/gpu/drm/drm_fb_helper.c
> >>> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >>> @@ -647,22 +647,26 @@ static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
> >>>    static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
> >>>                                            struct drm_rect *clip)
> >>>    {
> >>> +   struct drm_fb_helper *helper = info->par;
> >>> +
> >>>     off_t end = off + len;
> >>>     u32 x1 = 0;
> >>>     u32 y1 = off / info->fix.line_length;
> >>> -   u32 x2 = info->var.xres;
> >>> -   u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> >>> +   u32 x2 = helper->fb->height;
> >>> +   unsigned stride = helper->fb->pitches[0];
> >>> +   u32 y2 = DIV_ROUND_UP(end, stride);
> >>> +   int bpp = drm_format_info_bpp(helper->fb->format, 0);
> >> Please DONT do that. The code here is fbdev code and shouldn't bother about
> >> DRM data structures. Actually, it shouldn't be here: a number of fbdev
> >> drivers with deferred I/O contain similar code and the fbdev module should
> >> provide us with a helper. (I think I even had some patches somewhere.)
> > Well my thinking is that it's a drm driver,
>
> Yes, I actually agree with this, and the code looks quite good. And I
> really want to adopt it.
>
> Because here is DRM, we should emulate the fbdev in the DRM's way.
>
> The DRM is really the big brother on the behind of emulated fbdev,
>
> who provide the real displayable backing memory and scant out engine to
> display such a buffer.
>
>
> But currently, the fact is,  drm_fb_helper.c still initializes lots of
> data structure come from fbdev world.
>
> For example, the drm_fb_helper_fill_fix() and drm_fb_helper_fill_var()
> in drm_fb_helper_fill_info() function.
>
> This saying implicitly that the fbdev-generic is a glue layer which copy
> damage frame buffer data
>
> from the front end(fbdev layer) to its drm backend.  It's not a 100%
> replacement its fbdev front end,
>
> rather, it relay on it.
>
>
> > so if we have issue with limit
> > checks blowing up it makes more sense to check them against drm limits.
> > Plus a lot more people understand those than fbdev. They should all match
> > anyway, or if they dont, we have a bug.
>
> Yes, this is really what I'm worry about.
>
> I see that  members of struct fb_var_screeninfo can be changed by
> user-space. For example, xoffset and yoffset.
>
> There is no change about 'info->var.xres' and 'info->var.yres' from the
> userspace,
>
> therefore, they should all match in practice.
>
>
> User-space can choose a use a smaller dispaly area than 'var.xres x
> var.yres',
>
> but that is implemented with 'var.xoffset' and 'var.xoffset'.
>
> But consider that the name 'var', which may stand for 'variation' or
> 'vary'. This is terrifying.
>
> I imagine, with a shadow buffer, the front end can do any modeset on the
> runtime freely,
>
> including change the format of frame buffer on the runtime.  Just do not
> out-of-bound.
>
> The middle do the conversion on the fly.
>
>
> We might also create double shadow buffer size to allow the front end to
> pan?

Yeah so the front should be able to pan. And the front-end can
actually make xres/yres smalle than drm_fb->height/width, so we _have_
to use the fb side of things. Otherwise it's a bug I just realized.

The xres_virtual/yres_virtual should always match drm_fb sizes (but
we've had bugs in the past for that, only recently fixed all in
linux-next), because that's supposed to be the max size. And since we
never reallocate the fbdev emulation fb (at least with the current
code) this should never change.

But fundamentally you're bringing up a very good point, we've had
piles of bugs in the past with not properly validating the fbdev side
information in info->var, and a bunch of resulting bugs. So validating
against the drm side of things should be a bit more robust.

It's kinda the same we do for legacy kms ioctls: We translate that to
atomic kms as fast as possible, and then do the entire subsequent
validation with atomic kms data structures.
-Daniel

> > The thing is, if you change this
> > further to just pass the drm_framebuffer, then this 100% becomes a drm
> > function, which could be used by anything in drm really.
>
> I agree with you.
>
> If I use fb_width/fb_height directly and bypassing 'info->var.xres" and
> "info->var.yres",
>
> the code style diverged then. As far as I am understanding,  the clip
> happen on the front end,
>
> the actual damage update happen at back end.
>
> Using the data structure come with the front end is more reasonable for
> current implement.
>
> > But also *shrug*.
>
> I can convert this single function to 100% drm with another patch.
>
> But, maybe there also have other functions are not 100% drm
>
> I would like do something to help achieve this in the future,
>
> let me help to fix this bug first?
>
> > -Daniel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
