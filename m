Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5001D73FB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF0MCB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF0MB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:01:58 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57A1712
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:01:48 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-57338656a8aso35452247b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687867307; x=1690459307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaDvMAxfFXfyEZM4SJAuMBnx36vSWVo7HcR7XHEqTMs=;
        b=VR2J7WD3LanI6isGAHUshU+JD0fdryajJlpHmd9chx0MAKDGYtfrRUysqi6cI9oVKf
         1FKnO+y/XI6O0AlTR+kfISrdsvCByZ8duVc/7agX/iY669Sl0OfamTMSjLN+htLMQiay
         /DExLBkuAhg5SXJ1VktQ0nZMzeunGBQV9ML1Su6/uT0tD9S3QfCZ06J+rGf2blgehmlX
         /g1CwJpITFGYlhpI1FcdmDxV8NtREmNHodUgBUgEAu+A1sBnqSlXsj+ktjnV4rvsPExC
         F37ob2zZdau32R+5z2I5UbDuss91SeQYAOXekbEuW+L7tZF/H95/iLESM8kp1noh9tyj
         0VHA==
X-Gm-Message-State: AC+VfDw3WMePJsbkjt5wBNB5TMJjmWMT0bTQzE/Lr2yziBC4ZO+er+Nx
        p7o+eiY4xGLD09urOQxfaxfWEHl1Yt64+Ybl
X-Google-Smtp-Source: ACHHUZ67k2/RYhYzFMismqFYvarrKsCGwUbw2ODjWkiXXOYxgmsAzF0Yp39W4P2n6LSUZJldQOegyw==
X-Received: by 2002:a81:4fd7:0:b0:573:9e0a:b8bf with SMTP id d206-20020a814fd7000000b005739e0ab8bfmr16027202ywb.9.1687867307585;
        Tue, 27 Jun 2023 05:01:47 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id x83-20020a816356000000b00569ff2d94f6sm1791012ywb.19.2023.06.27.05.01.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 05:01:46 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso2983813276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:01:46 -0700 (PDT)
X-Received: by 2002:a25:f802:0:b0:b9e:712f:4a17 with SMTP id
 u2-20020a25f802000000b00b9e712f4a17mr22534779ybd.6.1687867306425; Tue, 27 Jun
 2023 05:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com> <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
 <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com> <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
 <2f4d3e96-1e10-3662-bfc5-8c361a4c1366@collabora.com>
In-Reply-To: <2f4d3e96-1e10-3662-bfc5-8c361a4c1366@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jun 2023 14:01:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV924gJs1X1nMUbQ5LEbFe8hrrXgxxvgZ_dXf95O0bK5Q@mail.gmail.com>
Message-ID: <CAMuHMdV924gJs1X1nMUbQ5LEbFe8hrrXgxxvgZ_dXf95O0bK5Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Jun 26, 2023 at 6:11 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> On 6/25/23 18:36, Geert Uytterhoeven wrote:
> > On Sun, Jun 25, 2023 at 2:41 PM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >> On 6/25/23 11:47, Geert Uytterhoeven wrote:
> >>> On Sun, Apr 16, 2023 at 1:55 PM Dmitry Osipenko
> >>> <dmitry.osipenko@collabora.com> wrote:
> >>>> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
> >>>> support is needed by native context VirtIO-GPU Mesa drivers, it also will
> >>>> be used by Venus and Virgl contexts.
> >>>>
> >>>> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
> >>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> >>>> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> >>>
> >>>> +static int
> >>>> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
> >>>> +{
> >>>> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
> >>>> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
> >>>> +       size_t syncobj_stride = exbuf->syncobj_stride;
> >>>> +       u32 num_in_syncobjs = exbuf->num_in_syncobjs;
> >>>> +       struct drm_syncobj **syncobjs;
> >>>> +       int ret = 0, i;
> >>>> +
> >>>> +       if (!num_in_syncobjs)
> >>>> +               return 0;
> >>>> +
> >>>> +       /*
> >>>> +        * kvalloc at first tries to allocate memory using kmalloc and
> >>>> +        * falls back to vmalloc only on failure. It also uses GFP_NOWARN
> >>>
> >>> GFP_NOWARN does not exist.
> >>
> >> https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/gfp_types.h#L38
> >
> > That line defines "__GFP_NOWARN", not "GFP_NOWARN".
> > C is case- and underscore-sensitive. as is "git grep -w" ;-)
>
> The removal of underscores was done intentionally for improving
> readability of the comment

Please don't do that, as IMHO it actually hampers readability:
  1. For some xxx, both GFP_xxx and __GFP_xxx are defined,
     so it does matter which one you are referring to,
  2. After dropping the underscores, "git grep -w" can no longer find
     the definition, nor its users.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
