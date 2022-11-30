Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1330D63D77D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiK3OEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiK3ODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:03:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734F4A9E2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:03:27 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 62so16108780pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEv8biCW1DAZ/y5wqGNt797D01bRASY/trErFq6uAMs=;
        b=UOZL9aovBLP3IRsFLyhdKW/pGGv4eOjZaSaB4Y8Ym4ei8ZwypxvOO/uQBS2EZNdZt2
         elUAGrkEtiieGjb0WBfHTFKVLzsC54NVHYRP+rNoBdnNbqT83EK4U73nPT3NwZJ1F5Bx
         NXrw/QoUKUHxH1psiJAry1SfhT2kCu7mcQKIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEv8biCW1DAZ/y5wqGNt797D01bRASY/trErFq6uAMs=;
        b=cfQKbNxwhOZJR4oyBzM6miv6x/EpUmQnCl6yp3AXmxkl8qSJxbGuGsTOEguoZ/xUxn
         Ipqtg1CD8cf2QY4ugqEXwtY+QQfP7NWZeA9pOrpcfGXzXCrUjzpmzvq/Q2F14sMoqfX0
         W/DgvqncyJqe84J23spEk7H8ob1WbWPKxjzfbb+Oahi20HsCl+8bokYAphCR7srW+EfF
         vmE2ltq0gr/sh5gEhyo0QdDV3FkRC/yvcmid7LGTQBMCginu4Ir3TtrkkhHEq8lEvq7P
         lSzfeGNGD5RK+ESxaFxuCbql5ZJ+CBM3CZZg8kx1uhs3CczvP5h/F3GqrbjjxDjOTqhz
         nO3w==
X-Gm-Message-State: ANoB5pkge4WW1Qffz6xY4rPR+vCbkZLf2oDfXch9n0dndB4KXJd2oA9x
        CnqykAahhNU+yW84tNAVASHH0/fiDShtwDoaYiVezw==
X-Google-Smtp-Source: AA0mqf6KeHcENbmOiG7T2E55IFNkSKIPRSOlOP/bSDKNZdIZ7zLoslnx9jPJwCKyZsvAoB4iS0MvnmTEvpKENKWR1xo=
X-Received: by 2002:a63:ff5f:0:b0:46f:b6df:3107 with SMTP id
 s31-20020a63ff5f000000b0046fb6df3107mr36521260pgk.454.1669817003750; Wed, 30
 Nov 2022 06:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20221129200242.298120-1-robdclark@gmail.com> <20221129200242.298120-3-robdclark@gmail.com>
In-Reply-To: <20221129200242.298120-3-robdclark@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 30 Nov 2022 15:03:10 +0100
Message-ID: <CAKMK7uGi7fDC2=3-H5h0e4a0FUOOy_rLB22-DXRoJ2kQEkPeMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/shmem-helper: Avoid vm_open error paths
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>, stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:02:42PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> vm_open() is not allowed to fail.  Fortunately we are guaranteed that
> the pages are already pinned, and only need to increment the refcnt.  So
> just increment it directly.

Please mention hare that the only issue is the mutex_lock_interruptible,
and the only way we've found to hit this is if you send a signal to the
original process in a fork() at _just_ the right time.

With that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>
> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 110a9eac2af8..9885ba64127f 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -571,12 +571,20 @@ static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
>  {
>       struct drm_gem_object *obj = vma->vm_private_data;
>       struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
> -     int ret;
>
>       WARN_ON(shmem->base.import_attach);
>
> -     ret = drm_gem_shmem_get_pages(shmem);
> -     WARN_ON_ONCE(ret != 0);
> +     mutex_lock(&shmem->pages_lock);
> +
> +     /*
> +      * We should have already pinned the pages, vm_open() just grabs
> +      * an additional reference for the new mm the vma is getting
> +      * copied into.
> +      */
> +     WARN_ON_ONCE(!shmem->pages_use_count);
> +
> +     shmem->pages_use_count++;
> +     mutex_unlock(&shmem->pages_lock);
>
>       drm_gem_vm_open(vma);
>  }
> --
> 2.38.1
>

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
