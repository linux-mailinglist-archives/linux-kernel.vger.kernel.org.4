Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9352063C557
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiK2Qkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiK2Qko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:40:44 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB560EB3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:40:43 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a7-20020a056830008700b0066c82848060so9472327oto.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K78waBDJGkif7za6gqKCFTtsu32p8+QANMOHhvDlwsw=;
        b=nSB5KCiZI7DAGDSJaDYZqmduGMY2KQVyAFKkhuk3fFegPUfW1cDr+c1iUFeyyJz/of
         gIWXnGnR80+eiA1FXqAvuTvQFwSGl32+QZIarxtgRB1b06ZV8BJSTW3MakSo1H1ldSmX
         vzIooVJwV5nLyqyf/vSwBCdafTX4Ltdwjdf1ZrjQy7SXEFleHcvIuE/MwVSk+lV2k63+
         ibOed6JWKqfobTPF/hiIb5IY5u6nMCD5qA5qLJDwlPdNUaRyoGrvROGiYm1aS64qJoG9
         chgwMiLL4DBl11hNz6JjP1H75mAeEECPuwTwuzX5Kcx0nZAiIcxP6iQpuvq4LuPme1lC
         likA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K78waBDJGkif7za6gqKCFTtsu32p8+QANMOHhvDlwsw=;
        b=08UNWaMzYjMcmQdRUspu0LlO1KFo+utMLNtheH5F3GDrfx35bHqWiZ7ZqgFv2Pr8Jh
         MhU16Cn+RgPABx3RUfCLHGqDlR0sBhMjNQMUMLO6qTfPWiK2EbwCkGUy1QRw+SMqIyth
         6/j6IjcQMHnoRiGyy+Pyzcv/xm4dKwdRIQzMnfa8onzrKggCUMpmGUoUSBJpqmsokB2D
         7zwtQH45lI+r+hslpUfUzWmBgaOnGecOAZ368wKhLM0T5a3YwMp7Q3A0kqKIxYVNELGg
         6bm9hYubgPXY0F9pY/DupoTw/2OVa1+OYZNwpG4NTl26r+/ZO1gDeNw0qYx1i/F8/nfn
         Tx8Q==
X-Gm-Message-State: ANoB5pnI87NquJgZfAY8sGMLvans2qZ8gvWf7fCoGwznsNxBvdlFkFJ4
        zd/TFMG1jjOx/EV8/V7ThS7YfA3kxbsxsBxe8y8=
X-Google-Smtp-Source: AA0mqf6QNn+q3W6OtufOMJC0QkPzO9jSHQOngL9Jsl3MZqmgQD8IOdpUGysoS6cLjUDNBXcPEr/LpqoksrOxBBV2mwI=
X-Received: by 2002:a9d:75d5:0:b0:667:7361:7db5 with SMTP id
 c21-20020a9d75d5000000b0066773617db5mr21623192otl.22.1669740042594; Tue, 29
 Nov 2022 08:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20221123025723.695075-1-dmitry.osipenko@collabora.com> <20221123025723.695075-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20221123025723.695075-2-dmitry.osipenko@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 29 Nov 2022 08:40:33 -0800
Message-ID: <CAF6AEGv832O8m-7pP8qaDChA3=Y6TmBZrwf-NYwvHkvH6sVMkw@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] drm/msm/gem: Prevent blocking within shrinker loop
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 7:00 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Consider this scenario:
>
> 1. APP1 continuously creates lots of small GEMs
> 2. APP2 triggers `drop_caches`
> 3. Shrinker starts to evict APP1 GEMs, while APP1 produces new purgeable
>    GEMs
> 4. msm_gem_shrinker_scan() returns non-zero number of freed pages
>    and causes shrinker to try shrink more
> 5. msm_gem_shrinker_scan() returns non-zero number of freed pages again,
>    goto 4
> 6. The APP2 is blocked in `drop_caches` until APP1 stops producing
>    purgeable GEMs
>
> To prevent this blocking scenario, check number of remaining pages
> that GPU shrinker couldn't release due to a GEM locking contention
> or shrinking rejection. If there are no remaining pages left to shrink,
> then there is no need to free up more pages and shrinker may break out
> from the loop.
>
> This problem was found during shrinker/madvise IOCTL testing of
> virtio-gpu driver. The MSM driver is affected in the same way.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/drm_gem.c              | 9 +++++++--
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 8 ++++++--
>  include/drm/drm_gem.h                  | 4 +++-
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index b8db675e7fb5..299bca1390aa 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1375,10 +1375,13 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail);
>   *
>   * @lru: The LRU to scan
>   * @nr_to_scan: The number of pages to try to reclaim
> + * @remaining: The number of pages left to reclaim
>   * @shrink: Callback to try to shrink/reclaim the object.
>   */
>  unsigned long
> -drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
> +drm_gem_lru_scan(struct drm_gem_lru *lru,
> +                unsigned int nr_to_scan,
> +                unsigned long *remaining,
>                  bool (*shrink)(struct drm_gem_object *obj))
>  {
>         struct drm_gem_lru still_in_lru;
> @@ -1417,8 +1420,10 @@ drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
>                  * hit shrinker in response to trying to get backing pages
>                  * for this obj (ie. while it's lock is already held)
>                  */
> -               if (!dma_resv_trylock(obj->resv))
> +               if (!dma_resv_trylock(obj->resv)) {
> +                       *remaining += obj->size >> PAGE_SHIFT;
>                         goto tail;
> +               }
>
>                 if (shrink(obj)) {
>                         freed += obj->size >> PAGE_SHIFT;
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 1de14e67f96b..4c8b0ab61ce4 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -116,12 +116,14 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>         };
>         long nr = sc->nr_to_scan;
>         unsigned long freed = 0;
> +       unsigned long remaining = 0;
>
>         for (unsigned i = 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
>                 if (!stages[i].cond)
>                         continue;
>                 stages[i].freed =
> -                       drm_gem_lru_scan(stages[i].lru, nr, stages[i].shrink);
> +                       drm_gem_lru_scan(stages[i].lru, nr, &remaining,
> +                                        stages[i].shrink);
>                 nr -= stages[i].freed;
>                 freed += stages[i].freed;
>         }
> @@ -132,7 +134,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>                                      stages[3].freed);
>         }
>
> -       return (freed > 0) ? freed : SHRINK_STOP;
> +       return (freed > 0 && remaining > 0) ? freed : SHRINK_STOP;
>  }
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -182,10 +184,12 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
>                 NULL,
>         };
>         unsigned idx, unmapped = 0;
> +       unsigned long remaining = 0;
>
>         for (idx = 0; lrus[idx] && unmapped < vmap_shrink_limit; idx++) {
>                 unmapped += drm_gem_lru_scan(lrus[idx],
>                                              vmap_shrink_limit - unmapped,
> +                                            &remaining,
>                                              vmap_shrink);
>         }
>
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index a17c2f903f81..b46ade812443 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -475,7 +475,9 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
>  void drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock);
>  void drm_gem_lru_remove(struct drm_gem_object *obj);
>  void drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *obj);
> -unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
> +unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
> +                              unsigned int nr_to_scan,
> +                              unsigned long *remaining,
>                                bool (*shrink)(struct drm_gem_object *obj));
>
>  #endif /* __DRM_GEM_H__ */
> --
> 2.38.1
>
