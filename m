Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E76DBAE9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjDHM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDHM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:29:26 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657FFF00;
        Sat,  8 Apr 2023 05:28:57 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id ch3so1921225ybb.4;
        Sat, 08 Apr 2023 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680956896; x=1683548896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xesmN7ACvFsONZVtIWgg/NPtUmXwqhWd4yT+IAnjfP4=;
        b=qZAg5MBr717O6bx0hgvhFUHBeDocPLLbIuA4KYCL38V8KmSODY3s29neoV0F+KxB+t
         uVdJRLOkJJ/TFr4CqqAFxKHHyIZiAQYiFHOvIpDwZ7RfFS8lTjrA68zg68wyKX3/XOeS
         ils7qUiFHh3I1dzvFQqWhiIgcc3Qk59aHiQA5gqJjP/i1RnyH1bYLu2SiINjgmHZ8l+N
         9cItVocN4nwDjALaZDuOIKRIScblnBOByJbDfHd0sTg3KyBmDPhNTvfGe+2gRsF/ouUn
         XdzsbLap+ojWLYG2FRj8jeLCQ/WaGGKCb7db7/oUCAfwxs8oAJjm3599KC6+fNxRUVkp
         usug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680956896; x=1683548896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xesmN7ACvFsONZVtIWgg/NPtUmXwqhWd4yT+IAnjfP4=;
        b=5X1i6uA/48wHoC58ReukSkhfdeJbf1tXVLf8XWXSBHiBwrxyHXtIMaMSF+9Wncdn4d
         5LnngYTtQZzGb0twBr7Rs3M10gBbJpqscmk8oMsXQjxHGNQ1X9CK7sprrDLI47uwWdeO
         mOlYg9KCc6WsvyxIYBByKvunLkvt/GDRPLvSr2gWEMBPM4xPd3IhzwoPE+qDSNUwlXp1
         d3/tkcHFHlOne7yZ3frOjVGBblJgPxSH52T6NAucPpwbn4rQnnSH9Ep20MnZ0FeA/Cwi
         /lEViatDcymV8yJbSPerAHFh8OpkjZozQcPmzBbma6qXCj6PgeGrZiCLwDsaRO1YcNdr
         xCpw==
X-Gm-Message-State: AAQBX9cN29O2PGpbUbf9MaNRDcwl/Qo+jBuErZA+EIH6FQRMn2zq78vG
        9MM/KRLxONOGNvx4Lv09Y6QMVJcO38K6+PQFLNY=
X-Google-Smtp-Source: AKy350aY3jUZf5q2Y/64Ci72Ay5Sn65XYDDQWcwgFPC3PiVDm2NdvEfKa52juQSG5IL+Fu7hfyN+4JOB9Rn/BlI+5m4=
X-Received: by 2002:a25:d657:0:b0:b76:ae61:b68b with SMTP id
 n84-20020a25d657000000b00b76ae61b68bmr2784453ybg.5.1680956896058; Sat, 08 Apr
 2023 05:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215917.1475704-1-robdclark@gmail.com> <20230406215917.1475704-3-robdclark@gmail.com>
In-Reply-To: <20230406215917.1475704-3-robdclark@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Sat, 8 Apr 2023 13:28:04 +0100
Message-ID: <CACvgo50FEYhdpp3nqX-AyAvLK8hJnK2xynTtLnCb9A+GSeHCvg@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/msm: Add memory stats to fdinfo
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Christopher Healy <healych@amazon.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 at 22:59, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Use the new helper to export stats about memory usage.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 26 +++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.c |  2 --
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 9b6f17b1261f..385776f6a531 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1043,17 +1043,40 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
>         DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
>  };
>
> +enum drm_gem_object_status gem_status(struct drm_gem_object *obj)
> +{
> +       struct msm_gem_object *msm_obj = to_msm_bo(obj);
> +       enum drm_gem_object_status status = 0;
> +
> +       if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true)))
> +               status |= DRM_GEM_OBJECT_ACTIVE;
> +
> +       if (msm_obj->pages)
> +               status |= DRM_GEM_OBJECT_RESIDENT;
> +
> +       if (msm_obj->madv == MSM_MADV_DONTNEED)
> +               status |= DRM_GEM_OBJECT_PURGEABLE;
> +
> +       return status;
> +}
> +
>  static void msm_fop_show_fdinfo(struct seq_file *m, struct file *f)
>  {
>         struct drm_file *file = f->private_data;
>         struct drm_device *dev = file->minor->dev;
>         struct msm_drm_private *priv = dev->dev_private;
> +       struct msm_file_private *ctx = file->driver_priv;
>         struct drm_printer p = drm_seq_file_printer(m);
>
>         if (!priv->gpu)
>                 return;
>
> -       msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, &p);
> +       drm_printf(&p, "drm-driver:\t%s\n", dev->driver->name);
> +       drm_printf(&p, "drm-client-id:\t%u\n", ctx->seqno);
> +
> +       msm_gpu_show_fdinfo(priv->gpu, ctx, &p);
> +
> +       drm_print_memory_stats(file, &p, gem_status);
>  }
>
>  static const struct file_operations fops = {
> @@ -1067,6 +1090,7 @@ static const struct drm_driver msm_driver = {
>                                 DRIVER_RENDER |
>                                 DRIVER_ATOMIC |
>                                 DRIVER_MODESET |
> +                               DRIVER_SYNCOBJ_TIMELINE |

This line should probably be its own patch. AFAICT it was supported
since ab723b7a992a19b843f798b183f53f7472f598c8, although explicitly
kept disabled until there's userspace/turnip support.

With the above line removed, the patch is:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
Emil
