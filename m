Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D211663A8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiK1NIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiK1NIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:08:21 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4868183B0;
        Mon, 28 Nov 2022 05:08:16 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id u10so1689040qvp.4;
        Mon, 28 Nov 2022 05:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NyJ4oC6Fj5jfuI9pmJZJst2bJ3O+9u6ckzE/ZvDK8M=;
        b=NjRKU81huEF9eu0dk5sq/E0EPhXE6Iyi+YlJj7CJz7u8swjOjII8J3oPyicEdSK4E+
         +06FJGsi6s19cL6duOKC3HqxjsO9R7OjqYxh0v5E5h7i0NqhTWL6Hz11ZkUZ9+9eu1wN
         GqWvso/+Qyu7Xn3xv631qq2qEjJWXSSVfMA9/cVALzDvfylFVaKLtp3kllGDXO7Iped9
         17ZUZPLxL6cVpIqssFAnvFxZMZJzMusBfFqWPz9R97cmBQmKXLzbrvF33W7edmdEBTMQ
         8Mc24M9QeS7lDvXtDMAD+c4TFQC7HNZmjyz7bQQ1oXAE/UydiiX+zJO0imTHfVXCuEWv
         +n9Q==
X-Gm-Message-State: ANoB5pm5D7UHZUr68l44E0z2R5Agwwffe1hcfuBuX9tvAqtGYoHD8nxi
        rKTNAcY7GX2AqLUd0VFIJ7kB+QxVcdsw6Q==
X-Google-Smtp-Source: AA0mqf5hM5QRLexdkJWfBJGQOWq+9NLMBKOQdFiXoCPXgDz7a9GX9W4YTSsz0wWYespqLsWwojaKMw==
X-Received: by 2002:a05:6214:448e:b0:4bb:754f:e974 with SMTP id on14-20020a056214448e00b004bb754fe974mr30627189qvb.2.1669640895439;
        Mon, 28 Nov 2022 05:08:15 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z27-20020ac87cbb000000b00359961365f1sm6846059qtv.68.2022.11.28.05.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:08:14 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id d128so13182147ybf.10;
        Mon, 28 Nov 2022 05:08:14 -0800 (PST)
X-Received: by 2002:a25:7a02:0:b0:6f7:952d:b145 with SMTP id
 v2-20020a257a02000000b006f7952db145mr2006716ybc.604.1669640893818; Mon, 28
 Nov 2022 05:08:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669406380.git.geert@linux-m68k.org> <9ef3ed30a45a367db0231ea2e98f6f37ba860b4c.1669406382.git.geert@linux-m68k.org>
 <488b261a-843e-de94-bace-16364e6f9d92@suse.de>
In-Reply-To: <488b261a-843e-de94-bace-16364e6f9d92@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Nov 2022 14:08:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcY1i-oFKu11Lk-urFi=E3TXinWKBL98hMhkVPzQPfZQ@mail.gmail.com>
Message-ID: <CAMuHMdWcY1i-oFKu11Lk-urFi=E3TXinWKBL98hMhkVPzQPfZQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] drm: atari: Add a DRM driver for Atari graphics hardware
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Nov 26, 2022 at 3:51 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> that's an interesting driver. I left a few comments below.

Thanks for your comments!

> Am 25.11.22 um 21:31 schrieb Geert Uytterhoeven:
> > Supported formats:
> >    - C[1248],
> >    - RG16 (both standard DRM (little-endian) and native (big-endian)),
> >    - XR24.
> >
> > RG16 and XR24 are only supported with the underlying RGB565 hardware
> > mode on Falcon, and are subject to hardware restrictions (limited to
> > e.g. "qvga" and "hvga" modes).
> >
> > All formats use a shadow buffer (TODO: BE RG16 buffers from ST-RAM).
> > Initial mode setting works, later mode changes sometimes fail.

> > --- a/drivers/gpu/drm/tiny/Kconfig
> > +++ b/drivers/gpu/drm/tiny/Kconfig
> > @@ -10,6 +10,14 @@ config DRM_ARCPGU
> >
> >         If M is selected the module will be called arcpgu.
> >
> > +config DRM_ATARI
> > +     tristate "DRM support for Atari native chipset"
> > +     depends on DRM && ATARI
> > +     select DRM_KMS_HELPER
> > +     select DRM_GEM_SHMEM_HELPER
>
> Alphabetical sorting of the select statements.

OK

(I blame the chain of DRM_KMS_CMA_HELPER -> DRM_GEM_CMA_HELPER ->
 DRM_GEM_DMA_HELPER renames ;-)

> > --- a/drivers/video/fbdev/atafb.c
> > +++ b/drivers/gpu/drm/tiny/atari_drm.c

> > @@ -2288,11 +2279,13 @@ static struct fb_hwswitch tt_switch = {
> >   static struct fb_hwswitch falcon_switch = {
> >       .detect         = falcon_detect,
> >       .encode_fix     = falcon_encode_fix,
> > +     .config_init    = falcon_config_init,
> >       .decode_var     = falcon_decode_var,
> >       .encode_var     = falcon_encode_var,
> >       .get_par        = falcon_get_par,
> >       .set_par        = falcon_set_par,
> >       .set_screen_base = set_screen_base,
> > +     .set_col_reg    = falcon_set_col_reg,
> >       .blank          = falcon_blank,
> >       .pan_display    = falcon_pan_display,
> >   };
> > @@ -2302,11 +2295,13 @@ static struct fb_hwswitch falcon_switch = {
> >   static struct fb_hwswitch st_switch = {
> >       .detect         = stste_detect,
> >       .encode_fix     = stste_encode_fix,
> > +     .config_init    = stste_config_init,
> >       .decode_var     = stste_decode_var,
> >       .encode_var     = stste_encode_var,
> >       .get_par        = stste_get_par,
> >       .set_par        = stste_set_par,
> >       .set_screen_base = stste_set_screen_base,
> > +     .set_col_reg    = stste_set_col_reg,
> >       .pan_display    = pan_display
> >   };
> >   #endif
> > @@ -2315,10 +2310,12 @@ static struct fb_hwswitch st_switch = {
> >   static struct fb_hwswitch ext_switch = {
> >       .detect         = ext_detect,
> >       .encode_fix     = ext_encode_fix,
> > +     .config_init    = ext_config_init,
> >       .decode_var     = ext_decode_var,
> >       .encode_var     = ext_encode_var,
> >       .get_par        = ext_get_par,
> >       .set_par        = ext_set_par,
> > +     .set_col_reg    = ext_set_col_reg,
> >   };
> >   #endif
>
> This design is problematic. It recreates fbdev interfaces within DRM and
> makes it very hard to convert the driver to good DRM code. I suggest to
> branch at the outer-most point for each supported model. So each model
> effectively receives it's own mode-config pipeline. Common code can
> still be shared.
>
> For a good example, I'd refer to the latest mgag200 driver, which
> implements this pattern for the variety of revisions of its hardware.

I do not intend to keep this internal API.
It should be reworked by removing all fbdev'isms.

> > +// FIXME helpers from
> > +// "[PATCH v2 5/15] drm/fbconv: Add DRM <-> fbdev pixel-format conversion"
> > +// by Thomas Zimmermann <tzimmermann@suse.de>
>
> All these FIXMEs will need to be resolved.

Definitely.

> > +static void atari_drm_pipe_update(struct drm_simple_display_pipe *pipe,
> > +                               struct drm_plane_state *old_plane_state)
> > +{
> > +     struct atari_drm_device *atari_drm = atari_drm_from_pipe(pipe);
> > +     struct drm_plane_state *plane_state = pipe->plane.state;
> > +     struct drm_shadow_plane_state *shadow_plane_state =
> > +             to_drm_shadow_plane_state(plane_state);
> > +     struct drm_framebuffer *fb = plane_state->fb;
> > +     struct drm_crtc *crtc = &pipe->crtc;

> > +     // FIXME removing the block below triggers WARN_ON(new_crtc_state->event) in drivers/gpu/drm/drm_atomic_helper.c:2475 drm_atomic_helper_commit_hw_done
> > +     // FIXME I still see that warning when running modetest

BTW, do you know why I see that warning?
It happens less when sprinkling debug prints all over the place.

> > +     if (crtc->state->event) {
> > +             spin_lock_irq(&crtc->dev->event_lock);
> > +             drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +             crtc->state->event = NULL;
> > +             spin_unlock_irq(&crtc->dev->event_lock);
> > +     }
> > +}

> > +static struct drm_framebuffer*
> > +atari_drm_fb_create(struct drm_device *dev, struct drm_file *file_priv,
> > +                 const struct drm_mode_fb_cmd2 *mode_cmd)
> > +{
> > +     struct drm_framebuffer *fb;
> > +
> > +     switch (mode_cmd->pixel_format) {
> > +     case DRM_FORMAT_C1:
> > +     case DRM_FORMAT_C2:
> > +     case DRM_FORMAT_C4:
> > +             break;
> > +
> > +     case DRM_FORMAT_C8:
> > +             // FIXME TT & Falcon only
> > +             break;
> > +
> > +     case DRM_FORMAT_RGB565:
> > +     case DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN:
> > +             // FIXME Falcon only
> > +             break;
> > +
> > +     case DRM_FORMAT_XRGB8888:
> > +             // FIXME
> > +             break;
> > +
> > +     default:
> > +             return ERR_PTR(-EINVAL);
> > +     }
>
> The format checks don't belong here. IIRC the format will be validated
> when you try to set the framebuffer for a plane during the atomic commit

OK

> > +
> > +     if (atari_drm_check_size(mode_cmd->width, mode_cmd->height, NULL) < 0)
> > +             return ERR_PTR(-EINVAL);
>
> Same here. The size checks are performed when the framebuffer is used.

FTR, this was based on cirrus_fb_create()...

> > +
> > +     // FIXME allocate C1 and RGB565 in ST-RAM?
> > +     fb = drm_gem_fb_create_with_dirty(dev, file_priv, mode_cmd);

BTW, how do I allocate a buffer from graphics memory?
Any example to point me to?

> > +     drm_WARN_ON_ONCE(dev, fb->pitches[0] > fb->width *
> > +                           drm_format_info_bpp(fb->format, 0) / 8);
> > +     return fb;
> > +}
> > +
> > +static const struct drm_mode_config_funcs atari_drm_mode_config_funcs = {
> > +     .fb_create = atari_drm_fb_create,
> > +     .atomic_check = drm_atomic_helper_check,        // FIXME
> > +     .atomic_commit = drm_atomic_helper_commit,      // FIXME
>
> Why FIXMEs? Thes elines appear correct.

Because I had the feeling I should pass my own functions...

>
> > +};

> > +static int __init atari_drm_probe(struct platform_device *pdev)
> > +{
> > +     struct atari_drm_device *atari_drm;
> > +     int pad, detected_mode, error;
> > +     struct drm_device *dev;
> > +     unsigned long mem_req;
> > +     char *option = NULL;
> > +     int ret;
> > +
> > +     if (fb_get_options("atafb", &option))
> > +             return -ENODEV;
>
> That function is not available here.

It is.

But now I see drm_connector_get_cmdline_mode() already calls
fb_get_options(), and handles this when calling drm_connector_init(),
albeit a bit late (it should bail out before changing any hardware
state)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
