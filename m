Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183AB6E8DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDTJPs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDTJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:15:45 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B15C5;
        Thu, 20 Apr 2023 02:15:43 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4ec8da7aaf8so416805e87.2;
        Thu, 20 Apr 2023 02:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681982139; x=1684574139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2/e9Dnl7P2o+B8qqamMNBV5IQwfpE3QNjICNgU+vyo=;
        b=XbBM46hspq57fUo/TOu+O/f1byHvHFBsRfMRXXOiLDSlnLaHcKQipeW7+KvYhgFeAq
         XzlVgnGmYGQdCk2PSkd+Re+I/amdUIvrNhyirpRrFwnpiNaWBcUA7WshvCxPMCQMuUhn
         a774h24jb868EPXKveU9XNa7gp1ODGUnmGYJx4AjGM1lZ/FKbb+1dAJn/4QasH1gTGOT
         5TUoeNsuIoz1pn14HKY0Io27tVuQkF4dTsSkPvNR5sd6lwykflAaPaqMAE5baqdiLz99
         vA47qT5mAqqLS0v6T5RgLlOnUAMZaG5mHJGQJiszgxoxUck0GNzTwQEnwt7ZSUHDuDfp
         xceA==
X-Gm-Message-State: AAQBX9fzHM1EHmqx6sjO/AYfiGpXQt0Aw1ALffl+gUopaO9lzrFyoIgm
        +LssEDTpjyVCQk8JBuSxwlAp+QP9TUL5IGRr
X-Google-Smtp-Source: AKy350bGcijv6ZW0ovellOf8n0e/W0662yts4u2cOuqzLdfEh9KEPqS7IDNhJaj6qWHyu7qvPWOaKw==
X-Received: by 2002:ac2:5988:0:b0:4ed:b83a:5a69 with SMTP id w8-20020ac25988000000b004edb83a5a69mr249864lfn.62.1681982139400;
        Thu, 20 Apr 2023 02:15:39 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q17-20020ac24a71000000b004eca18ed506sm150028lfp.306.2023.04.20.02.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 02:15:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id k15so2037862ljq.4;
        Thu, 20 Apr 2023 02:15:38 -0700 (PDT)
X-Received: by 2002:a2e:a17b:0:b0:2a8:baf7:4e60 with SMTP id
 u27-20020a2ea17b000000b002a8baf74e60mr157071ljl.9.1681982137873; Thu, 20 Apr
 2023 02:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <2b6073d9c2d869c6a4eac6edebd616e0568dec91.1681843245.git.geert+renesas@glider.be>
 <ZEAY5Sf/V10ipDZk@phenom.ffwll.local>
In-Reply-To: <ZEAY5Sf/V10ipDZk@phenom.ffwll.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 11:15:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbsFHP7Amoz16o5ge5a=wv5u2x0B+yP7e-0bRJufqrQQ@mail.gmail.com>
Message-ID: <CAMuHMdWbsFHP7Amoz16o5ge5a=wv5u2x0B+yP7e-0bRJufqrQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-helper: Fix height, width, and accel_flags in fb_var
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 19, 2023 at 6:38 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Apr 18, 2023 at 08:42:46PM +0200, Geert Uytterhoeven wrote:
> > Fbtest contains some very simple validation of the fbdev userspace API
> > contract.  When used with shmob-drm, it reports the following warnings
> > and errors:
> >
> >     height changed from 68 to 0
> >     height was rounded down
> >     width changed from 111 to 0
> >     width was rounded down
> >     accel_flags changed from 0 to 1
> >
> > The first part happens because __fill_var() resets the physical
> > dimensions of the first connector, as filled in by drm_setup_crtcs_fb().
> > Fix this by retaining the original values.
> >
> > The last part happens because __fill_var() forces the FB_ACCELF_TEXT
> > flag on, while fbtest disables all acceleration on purpose, so it can
> > draw safely to the frame buffer.  Fix this by setting accel_flags to
> > zero, as DRM does not implement any text console acceleration.
> > Note that this issue can also be seen in the output of fbset, which
> > reports "accel true".
> >
> > Fixes: ee4cce0a8f03a333 ("drm/fb-helper: fix input validation gaps in check_var")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -2066,7 +2068,7 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
> >       info->pseudo_palette = fb_helper->pseudo_palette;
> >       info->var.xoffset = 0;
> >       info->var.yoffset = 0;
> > -     __fill_var(&info->var, fb);
> > +     __fill_var(&info->var, info, fb);
>
> Bit a bikeshed since it zeroed-allocated anyway, but I'd pass NULL here
> for info and catch that in __fill_var and then keep the explicit = 0;

Yeah, it's a bit unfortunate this is done in two places, and
info->var.{height,width} are initialized by drm_setup_crtcs_fb()
only later.

Most of the var contents cannot change as mode changes are not
supported, so drm_fb_helper_check_var() should just do

    if (var->foo > info->var.foo)
            return -EINVAL;
    var->foo = info->var.foo;

For the parts that can change, based on earlier discussions I saw pass
by, I believe there should be a call into atomic try-modesetting at
the end of drm_fb_helper_check_var()?

> Either way Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
