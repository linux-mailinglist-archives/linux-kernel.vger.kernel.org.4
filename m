Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049356DDE87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDKOxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDKOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:53:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF71FF3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:53:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2efbab42639so249112f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681224784;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wYfQRjYQR6KiiVsiMP38j6p1H2avcNgJgbhRyR77o0=;
        b=Xrye9L6+egunrS8ZViLvX9DoIvxBqXggrm776aN7Ob4wJVwBFrhEKLj4opV8fDjSBz
         mOMPeojKmV34tE4YLN/oXHAoXqd9bgqOi85L5Nk6eWgQ8brYD5hLYdpNXHoWjBGIi4nI
         NVtFnxcPtBnYlgYJVn1ID3/1mQkNEPTeVKZQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224784;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wYfQRjYQR6KiiVsiMP38j6p1H2avcNgJgbhRyR77o0=;
        b=a1IvOL3yLtuL+AD7D3Yxn77jMZGMU6ZRsPJBUTsPNMBk9DbBVVHVZrA95apon20ojA
         EizaodRpYeIm+d8WozLUkcGPc6/DFhocbIVeZWxpATS4+nxuAYDBbEitEzXXhW2rv/4I
         mB8xsC5/YiqjfeRt0uUxf6rS7wumFOtKx9rE2/YIx3+Zx4H7hV/10vOsTycMpOjLZ5rq
         haFXnKiaB6l8B6xbTyOtSgqZYLGdE93qbZ5Vb8yrtUVZdfwljGo4APeoG9huQklxXZPf
         Z0nLgBk5fCQNocysVsNFkQlSZMm0eOof/8/S4EYtCd4ANl+EKLse/3A9f3A3IBT/89sX
         gyJQ==
X-Gm-Message-State: AAQBX9ffVwInv1Lz02na1cw2Lb+KhOfiooxycGxlgNctxmQT//I7dwhi
        qKFwezCuXZO9+LuyM9ouluS2EneV0gWAysf5sRc=
X-Google-Smtp-Source: AKy350Z0+iYl0S2VFbfg+ISrGECyQpMtKqiE6vrnqkgiYcvblOEzIXfyXFOcNul0uFsvGltqNUYovw==
X-Received: by 2002:a05:600c:3b06:b0:3f0:7652:dbb8 with SMTP id m6-20020a05600c3b0600b003f07652dbb8mr7978122wms.2.1681224783935;
        Tue, 11 Apr 2023 07:53:03 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c471200b003ef71d7d64asm21446444wmo.6.2023.04.11.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:53:03 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:53:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>, Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
Message-ID: <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409132110.494630-1-15330273260@189.cn>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 09:21:10PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> We should setting the screen buffer size according to the screen's actual
> size, rather than the size of the GEM object backing the front framebuffer.
> The size of GEM buffer is page size aligned, while the size of active area
> of a specific screen is *NOT* necessarily page size aliged. For example,
> 1680x1050, 1600x900, 1440x900, 800x6000 etc. In those case, the damage rect
> computed by drm_fb_helper_memory_range_to_clip() goes out of bottom bounds
> of the display.
> 
> Run fbdev test of IGT on a x86+ast2400 platform with 1680x1050 resolution
> will cause the system hang with the following call trace:
> 
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   [IGT] fbdev: starting subtest eof
>   Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
>   [IGT] fbdev: starting subtest nullptr
> 
>   RIP: 0010:memcpy_erms+0xa/0x20
>   RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
>   RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
>   RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
>   RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
>   R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
>   R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
>   FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
>   Call Trace:
>    <TASK>
>    ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
>    drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
>    process_one_work+0x21f/0x430
>    worker_thread+0x4e/0x3c0
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0xf4/0x120
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x2c/0x50
>    </TASK>
>   CR2: ffffa17d40e0b000
>   ---[ end trace 0000000000000000 ]---
> 
> We also add trival code in this patch to restrict the damage rect beyond
> the last line of the framebuffer.

Nice catch!

> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/drm_fb_helper.c     | 2 +-
>  drivers/gpu/drm/drm_fbdev_generic.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 64458982be40..a2b749372759 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -645,7 +645,7 @@ static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off,
>  	u32 x1 = 0;
>  	u32 y1 = off / info->fix.line_length;
>  	u32 x2 = info->var.xres;
> -	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> +	u32 y2 = min_t(u32, DIV_ROUND_UP(end, info->fix.line_length), info->var.yres);

So for additional robustness I think it'd be good if we change the entire
computation here to use drm_framebuffer data and not fb_info data, because
fundamentally that's what the drm kms code consumes. It should all match
anyway, but I think it makes the code more obviously correct.

So in the entire function instead of looking at fb_info->fix we should
probably look at

	struct drm_fb_helper *helper = info->par;

And then helper->fb->pitches[0] and helper->fb->height.

If you agree would be great if you can please respin with that (and the
commit message augmented to explain why we do the change)?
>  
>  	if ((y2 - y1) == 1) {
>  		/*
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index 8e5148bf40bb..a6daecb5f640 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -95,6 +95,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  	fb_helper->fb = buffer->fb;
>  
>  	screen_size = buffer->gem->size;

I guess you forgot to remove this line here? Also I'm not understanding
why this matters, I think you're fix only needs the above chunk, not this
one? If I got this right then please drop this part, there's drivers which
only use drm_fb_helper.c but not drm_fbdev_generic.c, and from what I can
tell they all still set the gem buffer size here.

If otoh we need this too, then there's a few more places that need to be
fixed.

> +	screen_size = sizes->surface_height * buffer->fb->pitches[0];
> +
>  	screen_buffer = vzalloc(screen_size);
>  	if (!screen_buffer) {
>  		ret = -ENOMEM;

Cheers, Daniel

> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
