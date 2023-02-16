Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6D6998FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjBPPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjBPPfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:35:14 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B81421B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:35:13 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-16cc1e43244so2891471fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ioF/xYzGNQ9HWTwjq17Gz1ixsYLfM4BwYPZHajLvwZA=;
        b=XubF9IpgMUfiaY9LgzOVd0JUI4jSbJbo4k+ayOa1s5YmF/LT/cuDsR4RAsbEHSF85p
         GVcc1hdNSJViDfRCo83WKrWJGW+IhNAovrbGGdTllTHVadQeLKKCvUk95S3X0VQVLghm
         T6OpcaOxdhHqEJ4fd86AkB1gJvFF29uNMDI2GHawG+Tw+2NPr7Y5ijjoxXrhL/LauHbc
         6wREDh0EjLnKXMRMtfwjBeJpC5q6ZooWQHsQjYYjBjOkPOvuoTfnrl2E1h09lgwN7Dyg
         m+7lUatd2WuDDe7l4O44lcVGeJa0xpmymgR2KPIbNQNfBwv2BdSIZnDw+KrQy1q+9jqG
         A2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioF/xYzGNQ9HWTwjq17Gz1ixsYLfM4BwYPZHajLvwZA=;
        b=Ujb6YtYNHwH+DmLn29R6fSi8vSy5laPRf9nL9dmVHwMCtJVpeHlwJYDSEqP+bkiWwF
         hXEm9JKPNsT4cHAeuojKvGIOeGDtvMtDi7HGo1WyuqcVGVOnwiuXYQxs2ybAmwTztR0W
         f0deGZOWa+MnUA0k7ZdYEKP6LkEMmM9XNsisXYKuMrYEeIL9C+30pbVs1WklTTgzNlPa
         c0cbeOtNTgNBx2OjaGtTWU1e0YKT7ZoYx9mcxTTMABUaHyd0nOwhGVEZ90OTLzdBqcQY
         yIKT4vFQiI0MIkH+2t+U/WSU0YeBp8MtFcVtW7M/gNesKM4l9I1iD+E2PtacISHYb9xE
         yUxQ==
X-Gm-Message-State: AO0yUKUnJJxjv+tvi0qEMCzSC3bUKlsw+7d9UvS4Jd6yelTegNv2JTG4
        JTNXMHgsCxlvZtXfPYKc2VgSajqrvzgUy6n+xwo=
X-Google-Smtp-Source: AK7set/288VGegqAcXYDVWUGpg0Co0DIG8CEILOv8kQkp24cT9DVZw9MDpt+HBi4O1fbHgFlBuhdpKFJwfba7uvGIRA=
X-Received: by 2002:a05:6870:808d:b0:16e:8a56:d0d2 with SMTP id
 q13-20020a056870808d00b0016e8a56d0d2mr36507oab.38.1676561712824; Thu, 16 Feb
 2023 07:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20230108211311.3950107-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230108211311.3950107-1-dmitry.osipenko@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 16 Feb 2023 07:35:32 -0800
Message-ID: <CAF6AEGtU_Af=2TJiZytTx3GHryFiefJNkmKzwk569RcJKD+9BA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/shmem-helper: Remove another errant put in error path
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sun, Jan 8, 2023 at 1:13 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> drm_gem_shmem_mmap() doesn't own reference in error code path, resulting
> in the dma-buf shmem GEM object getting prematurely freed leading to a
> later use-after-free.
>
> Fixes: f49a51bfdc8e ("drm/shme-helpers: Fix dma_buf_mmap forwarding bug")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index f21f47737817..8b20b41497e8 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -624,11 +624,14 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>         int ret;
>
>         if (obj->import_attach) {
> -               /* Drop the reference drm_gem_mmap_obj() acquired.*/
> -               drm_gem_object_put(obj);
>                 vma->vm_private_data = NULL;
> +               ret = dma_buf_mmap(obj->dma_buf, vma, 0);
> +
> +               /* Drop the reference drm_gem_mmap_obj() acquired.*/
> +               if (!ret)
> +                       drm_gem_object_put(obj);
>
> -               return dma_buf_mmap(obj->dma_buf, vma, 0);
> +               return ret;
>         }
>
>         ret = drm_gem_shmem_get_pages(shmem);
> --
> 2.38.1
>
