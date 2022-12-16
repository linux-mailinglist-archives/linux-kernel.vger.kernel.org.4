Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C819E64F56C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLPX7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiLPX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:59:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E8557B59
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:59:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vv4so9769444ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIKXv0RMSOh4Zj5JXJ0H7+d/0M4R06dAaYKh+BMHd2A=;
        b=juvIkT8vcatHsAuX5x/9pLyDEsPoOL7IqGfGxQxp6rjBVO4P/tlEBTqvfVLkkNKYGv
         3CEaP8RDEXyHYSAi+1pUD1n+RTt0ogvvYz3AYEtllQKtJPlB3YwxLqHkaVku92HXBPr5
         OJAS83LHruNjFBDASNQkVdRo7uNHrmFOhWWLJNlSn1UFXP6HSHn6iAHH76LFkysVK2iS
         NqEeUicB6AO8M/MZpRezry/sYvEu8rsW+19+sJCRjDx102ABSOlasQ4qnabMXUYHoueq
         xJH2tHVUZOY6KIs+JzPQxEWWZOgSkkHx0iBuZh4lZwrOjsA1gkyUurc0zHAWZaE7dmr9
         hJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIKXv0RMSOh4Zj5JXJ0H7+d/0M4R06dAaYKh+BMHd2A=;
        b=f+aZRY3O5kWfoW/lT2liHoC7zAwnR+zYnazwhPOPUYJ8De9cCKMcByzTMziGAd4Iod
         2fYHqIdMqM4Ut0MPm6U5oLGB8KBNyC+6cs5jJBbjlAaTq7EzfDUq+Jbl9yhiiZIR8cm7
         3C6hnxwBJm/4br81Wf+wumO402A6Vi+R0zq3i3jqV21QVOaVB2rkM6muxWdtBAYK4cK8
         VuunAo8btoJJPxl7Bj2lychZ842Hfh+Hmw+KZYCr8lwdfdC8NR2HYTiZ1CbkTGCOYIUA
         kVRl9QEM1ATsGcqAlRLBebcUcUHRvgRyjurNusVQfYXHKPJTM4W+LfM2b92+KGWQ/i/y
         cJZA==
X-Gm-Message-State: ANoB5pmUZWWGpjgUN/UIJUjUuVEmqvgdKfD4g+jJehE+41031wvGLHEx
        cHQS0+qIq7IWvRCjJog9HskC5D/9nKORRYTHAYNDG2jLftFRbA==
X-Google-Smtp-Source: AA0mqf6wIOamTnfqwHnHk7jBVTZApRrd3OSb9bKxdGI5zvUlM4wOFJiCeCifrb0GpusvxsjJ/sAFf4y8ghxYFJLgfUM=
X-Received: by 2002:a17:906:840e:b0:7c0:d94c:7384 with SMTP id
 n14-20020a170906840e00b007c0d94c7384mr23051046ejx.109.1671235165720; Fri, 16
 Dec 2022 15:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com>
In-Reply-To: <20221216233355.542197-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 16 Dec 2022 15:59:14 -0800
Message-ID: <CAPaKu7RP281inKJKNWWTnETCU+giwU2YajzwH6AUVeTDXQoWWg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Fix GEM handle creation UAF
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
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

On Fri, Dec 16, 2022 at 3:34 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Relying on an unreturned handle to hold a reference to an object we
> dereference is not safe.  Userspace can guess the handle and race us
> by closing the handle from another thread.  The _create_with_handle()
> that returns an object ptr is pretty much a pattern to avoid.  And
> ideally creating the handle would be done after any needed dererencing.
> But in this case creation of the mapping is tied to the handle creation.
> Fortunately the mapping is refcnt'd and holds a reference to the object,
> so we can drop the handle's reference once we hold a mapping reference.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  7 +++++++
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 10 +++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 2fa5afe21288..aa5848de647c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -98,6 +98,13 @@ static int panfrost_ioctl_create_bo(struct drm_device *dev, void *data,
>                 return PTR_ERR(bo);
>
>         mapping = panfrost_gem_mapping_get(bo, priv);
> +
> +       /*
> +        * Now that the mapping holds a reference to the bo until we no longer
> +        * need it, we can safely drop the handle's reference.
> +        */
Not too familiar with panfrost, but I don't see
panfrost_gem_mapping_get hold a reference to the bo?

> +       drm_gem_object_put(&bo->base.base);
> +
>         if (!mapping) {
>                 drm_gem_object_put(&bo->base.base);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 293e799e2fe8..e3e21c500d24 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -234,6 +234,10 @@ struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t
>         return &obj->base.base;
>  }
>
> +/*
> + * NOTE: if this succeeds, both the handle and the returned object have
> + * an outstanding reference.
> + */
I might suggest dropping the "_with_handle" suffix.

The naming convention is used in several drivers.  I think we should
make it the case that the _with_handle variants always return the
handle without the pointer.  (And with the change, it immediately
becomes clear that qxl and vmwgfx also have similar issues).

>  struct panfrost_gem_object *
>  panfrost_gem_create_with_handle(struct drm_file *file_priv,
>                                 struct drm_device *dev, size_t size,
> @@ -261,10 +265,10 @@ panfrost_gem_create_with_handle(struct drm_file *file_priv,
>          * and handle has the id what user can see.
>          */
>         ret = drm_gem_handle_create(file_priv, &shmem->base, handle);
> -       /* drop reference from allocate - handle holds it now. */
> -       drm_gem_object_put(&shmem->base);
> -       if (ret)
> +       if (ret) {
> +               drm_gem_object_put(&shmem->base);
>                 return ERR_PTR(ret);
> +       }
>
>         return bo;
>  }
> --
> 2.38.1
>
