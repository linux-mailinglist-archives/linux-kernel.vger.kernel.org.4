Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F36E14AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDMS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDMS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:56:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E91BE6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:56:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso3471135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681412190; x=1684004190;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkJNTvo612O3fWPNxDWPyC+FD+8b0uBSCjcq43SbtsE=;
        b=YiUfmAiJM2xaeT7CytI2caKY70Osw04D9HzW1DTEH2IGvYMYJ7cVIh+hWKEm/YPtYs
         sE+pqMCfcvmg3BGr33SJZpahD/md3CAWd6uDZ/9n6hq7LWjmXK+MdVBcjFXve5NqVX1a
         Fc9XBEe0bPmUBeQYenQG39TSzDlpGHeN54n0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681412190; x=1684004190;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkJNTvo612O3fWPNxDWPyC+FD+8b0uBSCjcq43SbtsE=;
        b=eva+YbfWq5ae0eSgkIYy7L/qgBQqczwCIy05PYcDhWTZOKVONHZ5T5avwLwU7ph17L
         GyrqDqgjW9rpwtSDuFiY9xF7/AY4htDDFfzNCe5JaB+PqFGuJhvxFVfHJdSwi3oWNWxy
         /EiDYp4D0VtLbGi/FNI+XVljcVo9uLy4wnY6MGqARe+/8AFN6FgWam4cotaXWbziy3za
         cvC6ci3vUMVZXpkBxSvnBR3AnSoV5Ul7CpdAPC4MX4DtdSIR9IyfIWX+/q9uk5Pn0QC9
         xxfUAJhEdmIO6IXirWrnvmh8S1kcpGdk8UUvgc7u/jaBRGMUAVvg0TecRdDvhfiBwY8f
         k54Q==
X-Gm-Message-State: AAQBX9cRrNK9qzAf4FnSHxdfttLw7dWEMf1Eyod8aFNlthltbhGxrMkZ
        O94mT6ENNuTd2EPni2Wl8U8L3g==
X-Google-Smtp-Source: AKy350Z+Pymx86muavguR0EXMVTzX6DncBOK2+EuJpP1eStBdguGNte0pXr9DSRj/ZSjARALqxBwDQ==
X-Received: by 2002:adf:e98f:0:b0:2c9:8b81:bd04 with SMTP id h15-20020adfe98f000000b002c98b81bd04mr2046863wrm.0.1681412189731;
        Thu, 13 Apr 2023 11:56:29 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b002e5ff05765esm1853474wru.73.2023.04.13.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:56:29 -0700 (PDT)
Date:   Thu, 13 Apr 2023 20:56:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
Message-ID: <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
Mail-Followup-To: Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230409132110.494630-1-15330273260@189.cn>
 <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
 <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
 <dbac96b2-0fea-591b-517d-2a23cc36b8de@189.cn>
 <CAKMK7uG_h7htCDARudZpHOOMG4iOOLZmz0_WskvWGf+DKGwU1w@mail.gmail.com>
 <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:00:07AM +0800, Sui Jingfeng wrote:
> 
> On 2023/4/13 23:56, Daniel Vetter wrote:
> > On Thu, 13 Apr 2023 at 17:35, Sui Jingfeng <15330273260@189.cn> wrote:
> > > Hi,
> > > 
> > > On 2023/4/13 01:44, Daniel Vetter wrote:
> > > > On Thu, Apr 13, 2023 at 01:13:37AM +0800, Sui Jingfeng wrote:
> > > > > Hi,
> > > > > 
> > > > > On 2023/4/11 22:53, Daniel Vetter wrote:
> > > > > > On Sun, Apr 09, 2023 at 09:21:10PM +0800, Sui Jingfeng wrote:
> > > > > > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > > > > 
> > > > > > > We should setting the screen buffer size according to the screen's actual
> > > > > > > size, rather than the size of the GEM object backing the front framebuffer.
> > > > > > > The size of GEM buffer is page size aligned, while the size of active area
> > > > > > > of a specific screen is *NOT* necessarily page size aliged. For example,
> > > > > > > 1680x1050, 1600x900, 1440x900, 800x6000 etc. In those case, the damage rect
> > > > > > > computed by drm_fb_helper_memory_range_to_clip() goes out of bottom bounds
> > > > > > > of the display.
> > > > > > > 
> > > > > > > Run fbdev test of IGT on a x86+ast2400 platform with 1680x1050 resolution
> > > > > > > will cause the system hang with the following call trace:
> > > > > > > 
> > > > > > >      Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > > >      [IGT] fbdev: starting subtest eof
> > > > > > >      Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> > > > > > >      [IGT] fbdev: starting subtest nullptr
> > > > > > > 
> > > > > > >      RIP: 0010:memcpy_erms+0xa/0x20
> > > > > > >      RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
> > > > > > >      RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
> > > > > > >      RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
> > > > > > >      RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
> > > > > > >      R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
> > > > > > >      R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
> > > > > > >      FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
> > > > > > >      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > >      CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
> > > > > > >      Call Trace:
> > > > > > >       <TASK>
> > > > > > >       ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
> > > > > > >       drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
> > > > > > >       process_one_work+0x21f/0x430
> > > > > > >       worker_thread+0x4e/0x3c0
> > > > > > >       ? __pfx_worker_thread+0x10/0x10
> > > > > > >       kthread+0xf4/0x120
> > > > > > >       ? __pfx_kthread+0x10/0x10
> > > > > > >       ret_from_fork+0x2c/0x50
> > > > > > >       </TASK>
> > > > > > >      CR2: ffffa17d40e0b000
> > > > > > >      ---[ end trace 0000000000000000 ]---
> > > > > > > 
> > > > > > > We also add trival code in this patch to restrict the damage rect beyond
> > > > > > > the last line of the framebuffer.
> > > > > > Nice catch!
> > > > >    :)
> > > > > > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > > > > ---
> > > > > > >     drivers/gpu/drm/drm_fb_helper.c     | 2 +-
> > > > > > >     drivers/gpu/drm/drm_fbdev_generic.c | 2 ++
> > > > > > >     2 files changed, 3 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > > > > > > index 64458982be40..a2b749372759 100644
> > > > > > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > > > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > > > > > @@ -645,7 +645,7 @@ static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off,
> > > > > > >             u32 x1 = 0;
> > > > > > >             u32 y1 = off / info->fix.line_length;
> > > > > > >             u32 x2 = info->var.xres;
> > > > > > > -  u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> > > > > > > +  u32 y2 = min_t(u32, DIV_ROUND_UP(end, info->fix.line_length), info->var.yres);
> > > > > > So for additional robustness I think it'd be good if we change the entire
> > > > > > computation here to use drm_framebuffer data and not fb_info data, because
> > > > > > fundamentally that's what the drm kms code consumes. It should all match
> > > > > > anyway, but I think it makes the code more obviously correct.
> > > > > > 
> > > > > > So in the entire function instead of looking at fb_info->fix we should
> > > > > > probably look at
> > > > > > 
> > > > > >      struct drm_fb_helper *helper = info->par;
> > > > > > 
> > > > > > And then helper->fb->pitches[0] and helper->fb->height.
> > > > > > 
> > > > > > If you agree would be great if you can please respin with that (and the
> > > > > > commit message augmented to explain why we do the change)?
> > > > > Yes, I'm agree.
> > > > > 
> > > > > Thank you for guidance, I will refine this patch with `helper = info->par`.
> > > > > 
> > > > > I will send a v2 when I finished.
> > > > > 
> > > > > > >             if ((y2 - y1) == 1) {
> > > > > > >                     /*
> > > > > > > diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> > > > > > > index 8e5148bf40bb..a6daecb5f640 100644
> > > > > > > --- a/drivers/gpu/drm/drm_fbdev_generic.c
> > > > > > > +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> > > > > > > @@ -95,6 +95,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
> > > > > > >             fb_helper->fb = buffer->fb;
> > > > > > >             screen_size = buffer->gem->size;
> > > > > > I guess you forgot to remove this line here?
> > > > > Yes, this line should be removed in this patch. I overlooked this, sorry.
> > > > > 
> > > > > > Also I'm not understanding
> > > > > > why this matters, I think you're fix only needs the above chunk, not this
> > > > > > one? If I got this right then please drop this part, there's drivers which
> > > > > > only use drm_fb_helper.c but not drm_fbdev_generic.c, and from what I can
> > > > > > tell they all still set the gem buffer size here.
> > > > > > 
> > > > > > If otoh we need this too, then there's a few more places that need to be
> > > > > > fixed.
> > > > > I think we need this line, otherwise wrapped around will be happen.
> > > > > 
> > > > > Because I found that the value of variable`y1` will be larger in number than
> > > > > the variable `y2` by 1,
> > > > > 
> > > > > which are computed  in drm_fb_helper_memory_range_to_clip().
> > > > > 
> > > > > 
> > > > > This phenomenon will emerged on platforms with large page size or
> > > > > 
> > > > > non page size divisiable display resolution case. Take the LoongArch and
> > > > > Mips as an example,
> > > > > 
> > > > > the default page size is 16KB(to avoid cache alias).  Even with the most
> > > > > frequently used
> > > > > 
> > > > > 1920x1080 screen, the screen_size can not be divided exactly.
> > > > > 
> > > > > The total size of the shadow buffer is 1920x1080x4 bytes, 1920x1080x4 /
> > > > > 16384 = 506.25
> > > > > 
> > > > > TTM manage the vram in the term of pages, so TTM will allocate 507 pages for
> > > > > us.
> > > > > 
> > > > > 507x16384 = 8306688 bytes.
> > > > > 
> > > > > 
> > > > > drm_fb_helper_memory_range_to_clip() will be called when running fbdev eof
> > > > > test in the IGT.
> > > > > 
> > > > > with 8306688 as its second parameter. while 8306688 / (1920x4) = 1081, this
> > > > > cause y1 out of bound.
> > > > > 
> > > > > Simply restrict y2 with a min_t() function yeild 1080 in this case, but y2 -
> > > > > y1 cause *wrap around* here.
> > > > > 
> > > > > because they are both unsigned number.
> > > > > 
> > > > > 
> > > > > drm_rect_init() function cast this unsigned int type to int type in end of
> > > > > drm_fb_helper_memory_range_to_clip(),
> > > > > 
> > > > > but the last argument of drm_fb_helper_damage() function is a u32 type,
> > > > > 
> > > > > it cast the return value of  drm_rect_height(&damage_area) back to unsigned
> > > > > type.
> > > > > 
> > > > > Yet, another wrapped around with truncation happened in
> > > > > drm_fb_helper_add_damage_clip()
> > > > > 
> > > > > called by subsequent drm_fb_helper_damage() function.
> > > > > 
> > > > > I finally got reject by drm_fbdev_generic_helper_fb_dirty() with follow
> > > > > code:
> > > > > 
> > > > > ```
> > > > > 
> > > > >       /* Call damage handlers only if necessary */
> > > > >       if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
> > > > >           return 0;
> > > > > 
> > > > > ```
> > > > > 
> > > > > On x86-64 platform, because 1920x1080x4 dumb buffer is lucky, it be divided
> > > > > exactly by 4KB(page size).
> > > > > 
> > > > > But other resolution will not as luck as this one. Right, fbdev test will be
> > > > > pasted, but wrap around
> > > > > 
> > > > > happens many time.
> > > > > 
> > > > > Therefore, as long as a larger buffer is allowed to exposed to the
> > > > > user-space.
> > > > > 
> > > > > A chance is given to the user-space,  to go beyond of the bottom bound of
> > > > > the actual active display area.
> > > > > 
> > > > > I not sure if this is intended, I feel it should not be allowable by
> > > > > intuition.
> > > > Ah yes, thanks for the in-depth explanation. But I think we need a
> > > > different fix, by also limiting y1. Otherwise for really big page sizes
> > > > (64k on arm64 iirc) and really small screens (there's i2c panels with just
> > > > a few lines) we might still run into the issue of y1 being too large.
> > > > 
> > > > So we need to limit both y1 and y2. I think it's ok to let y1 == y2 slip
> > > > through, since as you point out that's filtered later on.
> > > > 
> > > > The userspace api is that we should expose the full fbdev buffer and allow
> > > > writes into the entire thing. It's just that for the explicit upload with
> > > > damage rects we need to make sure we're staying within the real buffer.
> > > > -Daniel
> > > > 
> > > Limiting y1 is easy, and this is necessary, because it is the crazy
> > > fbdev test of IGT writing after EOF intentionally.
> > > 
> > > But there some difficulties for me to avoid using info->fix and info->var ,
> > > 
> > > I found all other functions are surrounding the info->fix and info-var.
> > > 
> > > There seems no good variable to replace info->var related data structure.
> > > 
> > > Partially replacement may introduce confusion, this somewhat beyond my
> > > ability.
> > > 
> > > I'm afraid of introducing out-of-bound in horizontal direction for
> > > multi-screen case.
> > > 
> > > Using fb_info->fix is still more safe.
> > > 
> > > Can I  respin my patch by still using fb_info->fix here?
> > Which one do you have an issue with finding the right drm variable? I
> > can help with that.
> > -Daniel
> 
> The info->var.xres and info->var.bits_per_pixel in
> drm_fb_helper_memory_range_to_clip() function.

This should switch the existing code over to using drm_framebuffer instead
of fbdev:


diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ef4eb8b12766..99ca69dd432f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -647,22 +647,26 @@ static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
 static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
 					       struct drm_rect *clip)
 {
+	struct drm_fb_helper *helper = info->par;
+
 	off_t end = off + len;
 	u32 x1 = 0;
 	u32 y1 = off / info->fix.line_length;
-	u32 x2 = info->var.xres;
-	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
+	u32 x2 = helper->fb->height;
+	unsigned stride = helper->fb->pitches[0];
+	u32 y2 = DIV_ROUND_UP(end, stride);
+	int bpp = drm_format_info_bpp(helper->fb->format, 0);
 
 	if ((y2 - y1) == 1) {
 		/*
 		 * We've only written to a single scanline. Try to reduce
 		 * the number of horizontal pixels that need an update.
 		 */
-		off_t bit_off = (off % info->fix.line_length) * 8;
-		off_t bit_end = (end % info->fix.line_length) * 8;
+		off_t bit_off = (off % stride) * 8;
+		off_t bit_end = (end % stride) * 8;
 
-		x1 = bit_off / info->var.bits_per_pixel;
-		x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
+		x1 = bit_off / bpp;
+		x2 = DIV_ROUND_UP(bit_end, bpp);
 	}
 
 	drm_rect_init(clip, x1, y1, x2 - x1, y2 - y1);

> 
> > > > > > > +  screen_size = sizes->surface_height * buffer->fb->pitches[0];
> > > > > > > +
> > > > > > >             screen_buffer = vzalloc(screen_size);
> > > > > > >             if (!screen_buffer) {
> > > > > > >                     ret = -ENOMEM;
> > > > > > Cheers, Daniel
> > > > > > 
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > > 
> > 
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
