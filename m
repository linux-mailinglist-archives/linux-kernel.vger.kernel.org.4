Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2301B70BF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjEVNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjEVNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:02:39 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323BC4;
        Mon, 22 May 2023 06:02:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba81031424dso9135297276.2;
        Mon, 22 May 2023 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684760551; x=1687352551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz4bQfIt7cNLLI3/bZ4OW8kbHhUS+fQ0VE6AH/7bMg4=;
        b=lYD92GRkYdjfbP3e8fwuaSxDduqy48npOK4Yg9ZaOEmHqS/JPtCrce+EnaTh9VmSna
         RHT7GBkDPyiY/W1+jvLGjxkh51jn+zxmI9OqgHEoEtA6ZjAC30eCAWTw4zIpfk4rWBWy
         A1qvHTQQwDt/NDBe21ApIde4nz/UtIN9QIixfms/Elp7oFDo+K/CLz+WFH9CtzPzcwlv
         rzv+9GIwfuw+VDp4MMJbBA5/iN9yQMMF+KMxRFF3Ge3uNa1QastQ+/BM0jUqgxWGYyfz
         cZTsz43RMk9g0VkTvoP1GJLBnZ9NmdVPAanL5bVUqBvc4fFhRPHb/wZFuV7qE7SuuDXI
         bn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684760551; x=1687352551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oz4bQfIt7cNLLI3/bZ4OW8kbHhUS+fQ0VE6AH/7bMg4=;
        b=QkRWEiO2IIHJOOAEdRBBTBU2e41QUYk0OxJzA+NzLWIPJw3uTLdrdk4g30ukdes91O
         5pgGw8VtSBSebJIC/dTjW09/xQAjrSLdo0xqdfAP/ocpNUCQs6NE8hvIFobqmnArt0fi
         dL0/sd9ldyRxHDOayTJXEtNPq1GYvwVYS7ztGPp4vUvYhX/N8NQRgoLutT+PCzCxpqOu
         OFPFFZvwWnScaohxWijZlmgK5kZcHTHg6Hvj1Vwi2kUfZJHraKeVTskJZVAD4a/j3UI9
         88nYLWN4Kdudvx/Z5wLomJoR23CoF79DTvqziT2tMwdF5OAygz593Tit696N8zjNNEl1
         rU5w==
X-Gm-Message-State: AC+VfDwUUfhOfUoWjeS+HCft6a5OxjOoAGNEVZD/4x1kypr6fSeR8LdB
        GpNKRnHnXaayzOyH9ENBWnvot9vRYzoq4R7wZj0=
X-Google-Smtp-Source: ACHHUZ6H/V3aromhsm0WeKkw3qoE/viYGpCdWeB7qDuWQFt6qRv5I58EjllHW4obHGmBc+ZmdwVtPh7vvXJ6Cb4sGGM=
X-Received: by 2002:a25:cdc5:0:b0:ba6:a445:3317 with SMTP id
 d188-20020a25cdc5000000b00ba6a4453317mr9276789ybf.39.1684760551555; Mon, 22
 May 2023 06:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230521205112.150206-1-dmitry.osipenko@collabora.com> <20230521205112.150206-7-dmitry.osipenko@collabora.com>
In-Reply-To: <20230521205112.150206-7-dmitry.osipenko@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 22 May 2023 14:02:19 +0100
Message-ID: <CACvgo52QvmZw5k_9dmBHPB25rTdLZJzVG_vNFr8or+3f5sVO=Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/shmem-helper: Switch to reservation lock
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Saw v3 fly by, so I had a quick look. Original RB still stands,
although I noticed a couple of non-blocking nitpicks.

On Sun, 21 May 2023 at 22:00, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> -static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  {

Should this getter have a dma_resv_assert_held(shmem->base.resv); like
it's put brethren?


> -void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
> +static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
> +{
> +       int ret;
> +
> +       dma_resv_assert_held(shmem->base.resv);
> +
> +       ret = drm_gem_shmem_get_pages(shmem);
> +
> +       return ret;

With the assert_held in the getter, it would be less confusing to
inline this and the unpin_locked functions.

> +}
> +
> +static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
>  {
> -       mutex_lock(&shmem->pages_lock);
> -       drm_gem_shmem_put_pages_locked(shmem);
> -       mutex_unlock(&shmem->pages_lock);
> +       dma_resv_assert_held(shmem->base.resv);
> +
> +       drm_gem_shmem_put_pages(shmem);

Side note: the putter has an assert_held so the extra one here seems quite odd.

As said at the top - with or w/o these nitpicks, the original RB still stands.

HTH o/
-Emil
