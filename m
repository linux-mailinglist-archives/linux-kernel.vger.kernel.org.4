Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E56E5C17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDRIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjDRIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:32:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D59083F1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:32:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f16f792384so5112825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681806726; x=1684398726;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WLSH8gwfIPleEeUUt5WgJYFcEuj6q3wMvZ3h+Vy7zo=;
        b=DTErbNOZ6G5TtRTr1+Lqoa3G5VNpvbkPZ5Y2ydixzoTjpc+cB5ykDY4fhGum1tkO7W
         vUdDjH4tSMqLMG4ES4s5sI5zyELRrWLUfYP/iJvG4KnD22STeHJl1MgahB2bnOSLoByV
         xW5mxiKTI9dwC4XWOmpDDTJBqpi/nnKIaxl7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806726; x=1684398726;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WLSH8gwfIPleEeUUt5WgJYFcEuj6q3wMvZ3h+Vy7zo=;
        b=imUYe7O48WwyHt1yRA8K+NBBu7PL31XTjjmyeL8urrZP/c7wjWWar0jeHc8XvY7Ejg
         IFySA+UMuJ5JwUEqwpQ6R7cYOjRtXyXpj2Q6AMO21mq0XlGpitvoWzX9CrpVf5zYIKs4
         6Ent6BTpuuoAaG1q6HP+J1F+qC+aqY8H/RSElTr3Q4QojWcdHjJQJfva/XFd44VAmOaM
         NKr/xyigfHFYzvnl5m9QhH5qwE+RGXofOeMqQR2QHuXIWNipGroAtK5PviWp2Ek1rq43
         UbcQYYQE8KDh4Kq6pOHkak3Lf5C55ld/I5NVSJf+RNRlZ25RD+N2/jouPIbHGFxwI59m
         KR1A==
X-Gm-Message-State: AAQBX9fj1xgnJMyOPcHAv/Gl6TwJE6w/9X8kJlZHP0y3ZWLqH7wcozhY
        ReHV/zjPFJBJup0gd7sjxdYxjBK6n/aYor9oWFk=
X-Google-Smtp-Source: AKy350Zb3S0UjaCxbuQFx+pYjJEjeuZKam0MNlGMGdZ51RvByjcZnxHf0dc3aGErX2sxXyBWXrQ6Vw==
X-Received: by 2002:a05:600c:1e12:b0:3f1:727f:1967 with SMTP id ay18-20020a05600c1e1200b003f1727f1967mr5443586wmb.4.1681806726244;
        Tue, 18 Apr 2023 01:32:06 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003f17848673fsm1806427wmi.27.2023.04.18.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:32:05 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:32:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3] drm/fbdev-generic: prohibit potential out-of-bounds
 access
Message-ID: <ZD5Vgx9Txaiz7Bun@phenom.ffwll.local>
Mail-Followup-To: Sui Jingfeng <suijingfeng@loongson.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230417113219.1354078-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417113219.1354078-1-suijingfeng@loongson.cn>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:32:19PM +0800, Sui Jingfeng wrote:
> The fbdev test of IGT may write after EOF, which lead to out-of-bound
> access for the drm drivers using fbdev-generic. For example, on a x86
> + aspeed bmc card platform, with a 1680x1050 resolution display, running
> fbdev test if IGT will cause the linux kernel hang with the following
> call trace:
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
> The direct reason is that damage rectange computed by
> drm_fb_helper_memory_range_to_clip() does not guaranteed to be in-bound.
> It is already results in workaround code populate to elsewhere. Another
> reason is that exposing a larger buffer size than the actual needed help
> to trigger this bug intrinsic in drm_fb_helper_memory_range_to_clip().
> 
> Others fbdev emulation solutions write to the GEM buffer directly, they
> won't reproduce this bug because the .fb_dirty function callback do not
> being hooked, so no chance is given to drm_fb_helper_memory_range_to_clip()
> to generate a out-of-bound when drm_fb_helper_sys_write() is called.
> 
> This patch break the trigger condition of this bug by shrinking the shadow
> buffer size to sizes->surface_height * buffer->fb->pitches[0].
> 
> Fixes: '8fbc9af55de0 ("drm/fbdev-generic: Set screen size to size of GEM
> buffer")'
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/drm_fbdev_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index 8e5148bf40bb..b057cfbba938 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -94,7 +94,7 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  	fb_helper->buffer = buffer;
>  	fb_helper->fb = buffer->fb;
>  
> -	screen_size = buffer->gem->size;
> +	screen_size = sizes->surface_height * buffer->fb->pitches[0];

So I read core some more and stumbled over drm_fb_helper_deferred_io().
Which has all the code and comments about this, including limiting.

I think it would be clearer if we fix the issue there, instead of passing
limits around in obscure places that then again get broken? The thing is,
Thomas both authored the limit checks in drm_fb_helper_deferred_io() and
the patch which broken them again, so clearly this isn't very obvious. I'm
thinking of something like this:


diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ef4eb8b12766..726dab67c359 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -697,10 +697,7 @@ void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagerefli
 	 * of the screen and account for non-existing scanlines. Hence,
 	 * keep the covered memory area within the screen buffer.
 	 */
-	if (info->screen_size)
-		total_size = info->screen_size;
-	else
-		total_size = info->fix.smem_len;
+	total_size = helper->fb->height * helper->fb->pitches[0];
 	max_off = min(max_off, total_size);
 
 	if (min_off < max_off) {


I think that would make it utmost clear on what we're doing and why.
Otherwise we're just going to re-create the same bug again, like we've
done already :-)
-Daniel

>  	screen_buffer = vzalloc(screen_size);
>  	if (!screen_buffer) {
>  		ret = -ENOMEM;
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
