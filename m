Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2673CF78
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFYIra convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjFYIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:47:28 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06581AE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:47:27 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5768a7e3adbso19524637b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687682847; x=1690274847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT0thIwO68HESVXBQpbJg4htP276Ynn85luHFgMgvjM=;
        b=TJHbVq65kQ4pi6OPSTgRfwLt/V7TYeyN0x/q564fHQ/C8ph130ua/2nIWKeTBfRmSO
         sDs1/bY5A1ohJz8zffr0jxzbByoe5eyu6bP3KOu9HY2GYtyw0U+L2t8MC3HVkNdBa+2w
         ygi2s4pNmMEAzQOaC0619eC1RcV++uOIOCOVe05GpIUKmFSE7ltYjk9d6NFc75q3v/jg
         NgO9wKrJWMzavqc1rSP65EHkKUq2x1DjX/2cJqagHxUBHfgyrXqhBSLzCr3JhSqMdxPo
         3uyC70Y5mF2S/2tZ2QoxHtXeVwGGQIwbedCFgH87h2OvvbYUKuGS97zTatCkTsr5ALcd
         9X7Q==
X-Gm-Message-State: AC+VfDzm9maGXdFyNzWqaTArqvc3h3EZ54W4B2KiFGwWNpMATY09asK+
        vRm35fitaLOh7D4GoqW/TyJq/zOT95CUqQ==
X-Google-Smtp-Source: ACHHUZ56ZEQVzFKxuY7f9j0WtGPMn/5hE9qVX5Rs/8TOOpfEujmvpljFD4N6zrZo9xnv+DlpPzY08g==
X-Received: by 2002:a0d:d44f:0:b0:56d:3d8d:4f6a with SMTP id w76-20020a0dd44f000000b0056d3d8d4f6amr37174498ywd.10.1687682846760;
        Sun, 25 Jun 2023 01:47:26 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v19-20020a814813000000b0054fba955474sm738338ywa.17.2023.06.25.01.47.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:47:26 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so3450094276.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:47:26 -0700 (PDT)
X-Received: by 2002:a25:1046:0:b0:bc7:7fe4:afbc with SMTP id
 67-20020a251046000000b00bc77fe4afbcmr11054044ybq.20.1687682845949; Sun, 25
 Jun 2023 01:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com> <20230416115237.798604-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230416115237.798604-4-dmitry.osipenko@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jun 2023 10:47:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
Message-ID: <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sun, Apr 16, 2023 at 1:55 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
> support is needed by native context VirtIO-GPU Mesa drivers, it also will
> be used by Venus and Virgl contexts.
>
> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c

> +static int
> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
> +{
> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
> +       size_t syncobj_stride = exbuf->syncobj_stride;
> +       u32 num_in_syncobjs = exbuf->num_in_syncobjs;
> +       struct drm_syncobj **syncobjs;
> +       int ret = 0, i;
> +
> +       if (!num_in_syncobjs)
> +               return 0;
> +
> +       /*
> +        * kvalloc at first tries to allocate memory using kmalloc and
> +        * falls back to vmalloc only on failure. It also uses GFP_NOWARN

GFP_NOWARN does not exist.

> +        * internally for allocations larger than a page size, preventing
> +        * storm of KMSG warnings.
> +        */
> +       syncobjs = kvcalloc(num_in_syncobjs, sizeof(*syncobjs), GFP_KERNEL);
> +       if (!syncobjs)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num_in_syncobjs; i++) {
> +               u64 address = exbuf->in_syncobjs + i * syncobj_stride;
> +               struct dma_fence *fence;
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
