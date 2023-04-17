Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474116E42D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDQInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDQInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:43:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6E5592
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:42:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5067165726bso385285a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681720958; x=1684312958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlip5XEyfopxeYY6dYtXb4T2DhyFncJYyC75GRGWD18=;
        b=krxbqVqJ5eJkq+3Ix4xzb5zDbIvhAEzyWLufmLKGtJ1GSbIjVbWlPOM64qaid6v1en
         CdQqVgqTRPkkslBT6mU0gA/T8H1DcYfiVo3+FisIg5iTlB5DxasbDAa7QAOsXU8MyZp8
         SD7t7lwr2ceBtl87KRM/eCWPB7lzRz16SFGOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720958; x=1684312958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlip5XEyfopxeYY6dYtXb4T2DhyFncJYyC75GRGWD18=;
        b=d6VzAExARh4UBmEPXJci90PCL0xFuJxJgxcgaaYsBrad/qdizOd91kIx9L+u/TL0tw
         Yh2XTPr7hhvsLtxcrp0+v7yIQh726wDCP1FLiOSqTU+gKdtFf6eGCAV0KRrcxpMeqpjm
         cZuLhiby4s8nyS3j/cK5zBFh84A9vZbbHvVYN+wQBpGuKp4GTgc8KmE56PLkY2wGK4d3
         RWX7HB25eRzEymZq+ONHUPGXVowrHHuXqJGct2XP0sNxg27b2v60cD2bA1+26wES4O2v
         RT7QYOzNtraPFdxIyWI+aM3e47UJ1AT2w34LPIaDv6uFmj8/+eyXqwV7OD3jTIAI/V18
         zvFg==
X-Gm-Message-State: AAQBX9csW9Y+L83D+h+9Fpx/TCoXYZLYWbUUwOSpZnk7uPMUkdNFy6LQ
        Qcx3xZaEl6ND4Vtdo2XdzcJnjAQJULJQbcB6sGc=
X-Google-Smtp-Source: AKy350Z2IkICzZW4vLGnCazx952jTuC+nIsFgIEtilhuIj8V7oaAs+NlKm7fH7IYGWEPTj7Nn5NPYA==
X-Received: by 2002:a05:6402:2691:b0:504:8a10:b699 with SMTP id w17-20020a056402269100b005048a10b699mr10134437edd.4.1681720958185;
        Mon, 17 Apr 2023 01:42:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g25-20020a056402115900b004c4eed3fe20sm5552210edw.5.2023.04.17.01.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:42:37 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:42:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2] drm/fbdev-generic: prohibit potential out-of-bounds
 access
Message-ID: <ZD0Ge6C8GUv9/t1d@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>, Li Yi <liyi@loongson.cn>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230413180622.1014016-1-15330273260@189.cn>
 <fccc494f-0e52-5fdf-0e40-acc29177c73c@suse.de>
 <32a1510e-d38a-ffb6-8e8d-026f8b3aa17a@189.cn>
 <fab85750-dcb7-0eeb-cabc-8fcfcc84b11c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fab85750-dcb7-0eeb-cabc-8fcfcc84b11c@suse.de>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 09:29:07AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 14.04.23 um 12:58 schrieb Sui Jingfeng:
> > Hi,
> > 
> > On 2023/4/14 03:16, Thomas Zimmermann wrote:
> > > Hi,
> > > 
> > > thanks for the patch. This is effectively a revert of commit
> > > 8fbc9af55de0 ("drm/fbdev-generic: Set screen size to size of GEM
> > > buffer"). Please add a Fixes tag.
> > > 
> > > Am 13.04.23 um 20:06 schrieb Sui Jingfeng:
> > > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > 
> > > > The crazy fbdev test of IGT may write after EOF, which lead to
> > > > out-of-bound
> > > 
> > > Please drop 'crazy'. :)
> > 
> > This is OK.
> > 
> > By using the world 'crazy',
> > 
> > I meant that the test is very good and maybe it is written by
> > professional  peoples
> > 
> > with the guidance by  experienced  engineer. So that even the corner get
> > tested.
> > 
> > 
> > > 
> > > > access for the drm drivers using fbdev-generic. For example, run
> > > > fbdev test
> > > > on a x86-64+ast2400 platform with 1680x1050 resolution will
> > > > cause the linux
> > > > kernel hang with following call trace:
> > > > 
> > > >    Oops: 0000 [#1] PREEMPT SMP PTI
> > > >    [IGT] fbdev: starting subtest eof
> > > >    Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> > > >    [IGT] fbdev: starting subtest nullptr
> > > > 
> > > >    RIP: 0010:memcpy_erms+0xa/0x20
> > > >    RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
> > > >    RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
> > > >    RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
> > > >    RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
> > > >    R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
> > > >    R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
> > > >    FS:  0000000000000000(0000) GS:ffff895257380000(0000)
> > > > knlGS:0000000000000000
> > > >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >    CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
> > > >    Call Trace:
> > > >     <TASK>
> > > >     ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
> > > >     drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
> > > >     process_one_work+0x21f/0x430
> > > >     worker_thread+0x4e/0x3c0
> > > >     ? __pfx_worker_thread+0x10/0x10
> > > >     kthread+0xf4/0x120
> > > >     ? __pfx_kthread+0x10/0x10
> > > >     ret_from_fork+0x2c/0x50
> > > >     </TASK>
> > > >    CR2: ffffa17d40e0b000
> > > >    ---[ end trace 0000000000000000 ]---
> > > > 
> > > > The indirect reason is drm_fb_helper_memory_range_to_clip()
> > > > generate damage
> > > > rectangles which partially or completely go out of the active
> > > > display area.
> > > > The second of argument 'off' is passing from the user-space,
> > > > this will lead
> > > > to the out-of-bound if it is large than (fb_height + 1) *
> > > > fb_pitches; while
> > > > DIV_ROUND_UP() may also controbute to error by 1.
> > > > 
> > > > This patch will add code to restrict the damage rect computed go
> > > > beyond of
> > > > the last line of the framebuffer.
> > > > 
> > > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > ---
> > > >   drivers/gpu/drm/drm_fb_helper.c     | 16 ++++++++++++----
> > > >   drivers/gpu/drm/drm_fbdev_generic.c |  2 +-
> > > >   2 files changed, 13 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c
> > > > b/drivers/gpu/drm/drm_fb_helper.c
> > > > index 64458982be40..6bb1b8b27d7a 100644
> > > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > > @@ -641,19 +641,27 @@ static void drm_fb_helper_damage(struct
> > > > drm_fb_helper *helper, u32 x, u32 y,
> > > >   static void drm_fb_helper_memory_range_to_clip(struct fb_info
> > > > *info, off_t off, size_t len,
> > > >                              struct drm_rect *clip)
> > > >   {
> > > > +    u32 line_length = info->fix.line_length;
> > > > +    u32 fb_height = info->var.yres;
> > > >       off_t end = off + len;
> > > >       u32 x1 = 0;
> > > > -    u32 y1 = off / info->fix.line_length;
> > > > +    u32 y1 = off / line_length;
> > > >       u32 x2 = info->var.xres;
> > > > -    u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> > > > +    u32 y2 = DIV_ROUND_UP(end, line_length);
> > > > +
> > > > +    /* Don't allow any of them beyond the bottom bound of
> > > > display area */
> > > > +    if (y1 > fb_height)
> > > > +        y1 = fb_height;
> > > > +    if (y2 > fb_height)
> > > > +        y2 = fb_height;
> > > >         if ((y2 - y1) == 1) {
> > > >           /*
> > > >            * We've only written to a single scanline. Try to reduce
> > > >            * the number of horizontal pixels that need an update.
> > > >            */
> > > > -        off_t bit_off = (off % info->fix.line_length) * 8;
> > > > -        off_t bit_end = (end % info->fix.line_length) * 8;
> > > > +        off_t bit_off = (off % line_length) * 8;
> > > > +        off_t bit_end = (end % line_length) * 8;
> > > 
> > > Please scratch all these changes. The current code should work as
> > > intended. Only the generic fbdev emulation uses this code and it
> > > should really be moved there at some point.
> > 
> > 
> > Are you meant  that we should remove all these changes in
> > drivers/gpu/drm/drm_fb_helper.c ?
> 
> As Daniel mentioned, there's the discussion in the other thread. I don't
> want to reopen it here. Just to summarize: I'm not convinced that this
> should be DRM code because it can be shared with other fbdev drivers.
> 
> [...]
> 
> > > > diff --git a/drivers/gpu/drm/drm_fbdev_generic.c
> > > > b/drivers/gpu/drm/drm_fbdev_generic.c
> > > > index 8e5148bf40bb..b057cfbba938 100644
> > > > --- a/drivers/gpu/drm/drm_fbdev_generic.c
> > > > +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> > > > @@ -94,7 +94,7 @@ static int
> > > > drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper
> > > > *fb_helper,
> > > >       fb_helper->buffer = buffer;
> > > >       fb_helper->fb = buffer->fb;
> > > >   -    screen_size = buffer->gem->size;
> > > > +    screen_size = sizes->surface_height * buffer->fb->pitches[0];
> 
> This has been bothering me over the weekend. And I think it's because what
> we want the screen_size to be heigth * pitch,  but the mmap'ed memory is
> still at page granularity. Therefore...
> 
> [...]
> > > 
> > > >       screen_buffer = vzalloc(screen_size);
> 
> ... this line should explicitly allocate multiples of pages. Something like
> 
>     /* allocate page-size multiples for mmap */
>     vzalloc(PAGE_ALIGN(screen_size))
> 
> It has not been a bug so far because vzalloc() always returns full pages
> IIRC. It's still worth fixing.

So gem_bo are supposed to be at least PAGE_SIZE aligned. So maybe we just
put a comment in here why this assumption holds, and reinforce it with a
WARN_ON? I think that would address the concerns here?

But I concur with Sui that this is a separate issue which should be sorted
out in a separate patch.
-Daniel

> 
> Best regards
> Thomas
> 
> 
> > > >       if (!screen_buffer) {
> > > >           ret = -ENOMEM;
> > > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
