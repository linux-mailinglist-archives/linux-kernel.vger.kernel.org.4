Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE64F6DFCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDLRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:44:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132B30E0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:44:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so1970255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681321484; x=1683913484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2E0Nnkjs6iVqwiEdn+EifW7LQwJ4sdMIYsZcK2qTBrM=;
        b=Zz4FH4NvcRfFdyp5S5sewPtFadS9p8YCpfkoqjhRUiDQjek6rZF9KLoBKSZtGQO0UN
         8xvH+hMM6jtHRPVF/5/fsTUV4DtrrgoIEEZkRj8LT9GP7frmZyeURDkXwdsVoVf2nd8b
         5RzU1whlc2WCsmvQFNwHgeZ1HfZ3UT2QK7r3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321484; x=1683913484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2E0Nnkjs6iVqwiEdn+EifW7LQwJ4sdMIYsZcK2qTBrM=;
        b=KZJ10qcNUEvZU91hwuz5SDd7T3BP4CwAPrF4z8keBXl5TCRv8WZMX/OlM3Li9G2v+R
         s3mK7Sn/s0U8OXEVUSGhx+LUb6aEVxgjIfh7s0xu26mv8RQWAf0w4FNtF+Ir8XBL4r6c
         11+BAB3F06pnpJntVlLaJx7NgPf/GLZ7MLxKIYFCDaRzpUw94v9QHQJDfMmrWDfGE+Ah
         tpfdgq42tQh6FKYKKk0ReuA5bIS9okBGkzKA3tqQuQedQJk1buuVSW+ABaLYKUKS9gGl
         hk8c9++HhQH8eX51OgHKmlYyg32giXT7PAjRFTmQQrqjiU4o+zWxJfCs5o304IjJ/4Wy
         SaUg==
X-Gm-Message-State: AAQBX9fvVZUOmUxskaNMfUcgeDb28Nsdrmqb59OfGC1kZJIrthP2TtiG
        0xiuQIiEhGJmA/tqwYms+eo0qg==
X-Google-Smtp-Source: AKy350Y+XWemTa+mLbLg/mxf9bQ1L3pmRsAspFQVVFKFppaJ5qUP0XyY8xP4nBnfCCgkjj9Cs7PDtw==
X-Received: by 2002:a5d:664e:0:b0:2c7:1c72:699f with SMTP id f14-20020a5d664e000000b002c71c72699fmr2458605wrw.4.1681321484469;
        Wed, 12 Apr 2023 10:44:44 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id m3-20020adfdc43000000b002c5691f13eesm17760896wrj.50.2023.04.12.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:44:44 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:44:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>, Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
Message-ID: <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
Mail-Followup-To: Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230409132110.494630-1-15330273260@189.cn>
 <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 01:13:37AM +0800, Sui Jingfeng wrote:
> Hi,
> 
> On 2023/4/11 22:53, Daniel Vetter wrote:
> > On Sun, Apr 09, 2023 at 09:21:10PM +0800, Sui Jingfeng wrote:
> > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > 
> > > We should setting the screen buffer size according to the screen's actual
> > > size, rather than the size of the GEM object backing the front framebuffer.
> > > The size of GEM buffer is page size aligned, while the size of active area
> > > of a specific screen is *NOT* necessarily page size aliged. For example,
> > > 1680x1050, 1600x900, 1440x900, 800x6000 etc. In those case, the damage rect
> > > computed by drm_fb_helper_memory_range_to_clip() goes out of bottom bounds
> > > of the display.
> > > 
> > > Run fbdev test of IGT on a x86+ast2400 platform with 1680x1050 resolution
> > > will cause the system hang with the following call trace:
> > > 
> > >    Oops: 0000 [#1] PREEMPT SMP PTI
> > >    [IGT] fbdev: starting subtest eof
> > >    Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> > >    [IGT] fbdev: starting subtest nullptr
> > > 
> > >    RIP: 0010:memcpy_erms+0xa/0x20
> > >    RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
> > >    RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
> > >    RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
> > >    RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
> > >    R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
> > >    R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
> > >    FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
> > >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >    CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
> > >    Call Trace:
> > >     <TASK>
> > >     ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
> > >     drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
> > >     process_one_work+0x21f/0x430
> > >     worker_thread+0x4e/0x3c0
> > >     ? __pfx_worker_thread+0x10/0x10
> > >     kthread+0xf4/0x120
> > >     ? __pfx_kthread+0x10/0x10
> > >     ret_from_fork+0x2c/0x50
> > >     </TASK>
> > >    CR2: ffffa17d40e0b000
> > >    ---[ end trace 0000000000000000 ]---
> > > 
> > > We also add trival code in this patch to restrict the damage rect beyond
> > > the last line of the framebuffer.
> > Nice catch!
>  :)
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > ---
> > >   drivers/gpu/drm/drm_fb_helper.c     | 2 +-
> > >   drivers/gpu/drm/drm_fbdev_generic.c | 2 ++
> > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > > index 64458982be40..a2b749372759 100644
> > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > @@ -645,7 +645,7 @@ static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off,
> > >   	u32 x1 = 0;
> > >   	u32 y1 = off / info->fix.line_length;
> > >   	u32 x2 = info->var.xres;
> > > -	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> > > +	u32 y2 = min_t(u32, DIV_ROUND_UP(end, info->fix.line_length), info->var.yres);
> > So for additional robustness I think it'd be good if we change the entire
> > computation here to use drm_framebuffer data and not fb_info data, because
> > fundamentally that's what the drm kms code consumes. It should all match
> > anyway, but I think it makes the code more obviously correct.
> > 
> > So in the entire function instead of looking at fb_info->fix we should
> > probably look at
> > 
> > 	struct drm_fb_helper *helper = info->par;
> > 
> > And then helper->fb->pitches[0] and helper->fb->height.
> > 
> > If you agree would be great if you can please respin with that (and the
> > commit message augmented to explain why we do the change)?
> 
> Yes, I'm agree.
> 
> Thank you for guidance, I will refine this patch with `helper = info->par`.
> 
> I will send a v2 when I finished.
> 
> > >   	if ((y2 - y1) == 1) {
> > >   		/*
> > > diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> > > index 8e5148bf40bb..a6daecb5f640 100644
> > > --- a/drivers/gpu/drm/drm_fbdev_generic.c
> > > +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> > > @@ -95,6 +95,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
> > >   	fb_helper->fb = buffer->fb;
> > >   	screen_size = buffer->gem->size;
> > I guess you forgot to remove this line here?
> 
> Yes, this line should be removed in this patch. I overlooked this, sorry.
> 
> > Also I'm not understanding
> > why this matters, I think you're fix only needs the above chunk, not this
> > one? If I got this right then please drop this part, there's drivers which
> > only use drm_fb_helper.c but not drm_fbdev_generic.c, and from what I can
> > tell they all still set the gem buffer size here.
> > 
> > If otoh we need this too, then there's a few more places that need to be
> > fixed.
> 
> I think we need this line, otherwise wrapped around will be happen.
> 
> Because I found that the value of variable`y1` will be larger in number than
> the variable `y2` by 1,
> 
> which are computed  in drm_fb_helper_memory_range_to_clip().
> 
> 
> This phenomenon will emerged on platforms with large page size or
> 
> non page size divisiable display resolution case. Take the LoongArch and
> Mips as an example,
> 
> the default page size is 16KB(to avoid cache alias).  Even with the most
> frequently used
> 
> 1920x1080 screen, the screen_size can not be divided exactly.
> 
> The total size of the shadow buffer is 1920x1080x4 bytes, 1920x1080x4 /
> 16384 = 506.25
> 
> TTM manage the vram in the term of pages, so TTM will allocate 507 pages for
> us.
> 
> 507x16384 = 8306688 bytes.
> 
> 
> drm_fb_helper_memory_range_to_clip() will be called when running fbdev eof
> test in the IGT.
> 
> with 8306688 as its second parameter. while 8306688 / (1920x4) = 1081, this
> cause y1 out of bound.
> 
> Simply restrict y2 with a min_t() function yeild 1080 in this case, but y2 -
> y1 cause *wrap around* here.
> 
> because they are both unsigned number.
> 
> 
> drm_rect_init() function cast this unsigned int type to int type in end of
> drm_fb_helper_memory_range_to_clip(),
> 
> but the last argument of drm_fb_helper_damage() function is a u32 type,
> 
> it cast the return value of  drm_rect_height(&damage_area) back to unsigned
> type.
> 
> Yet, another wrapped around with truncation happened in
> drm_fb_helper_add_damage_clip()
> 
> called by subsequent drm_fb_helper_damage() function.
> 
> I finally got reject by drm_fbdev_generic_helper_fb_dirty() with follow
> code:
> 
> ```
> 
>     /* Call damage handlers only if necessary */
>     if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
>         return 0;
> 
> ```
> 
> On x86-64 platform, because 1920x1080x4 dumb buffer is lucky, it be divided
> exactly by 4KB(page size).
> 
> But other resolution will not as luck as this one. Right, fbdev test will be
> pasted, but wrap around
> 
> happens many time.
> 
> Therefore, as long as a larger buffer is allowed to exposed to the
> user-space.
> 
> A chance is given to the user-space,  to go beyond of the bottom bound of
> the actual active display area.
> 
> I not sure if this is intended, I feel it should not be allowable by
> intuition.

Ah yes, thanks for the in-depth explanation. But I think we need a
different fix, by also limiting y1. Otherwise for really big page sizes
(64k on arm64 iirc) and really small screens (there's i2c panels with just
a few lines) we might still run into the issue of y1 being too large.

So we need to limit both y1 and y2. I think it's ok to let y1 == y2 slip
through, since as you point out that's filtered later on.

The userspace api is that we should expose the full fbdev buffer and allow
writes into the entire thing. It's just that for the explicit upload with
damage rects we need to make sure we're staying within the real buffer.
-Daniel

> > > +	screen_size = sizes->surface_height * buffer->fb->pitches[0];
> > > +
> > >   	screen_buffer = vzalloc(screen_size);
> > >   	if (!screen_buffer) {
> > >   		ret = -ENOMEM;
> > Cheers, Daniel
> > 
> > > -- 
> > > 2.25.1
> > > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
