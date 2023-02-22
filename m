Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C8769FBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjBVTJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBVTJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:09:30 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1BE2BEFD;
        Wed, 22 Feb 2023 11:09:28 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-172663f1956so2014959fac.12;
        Wed, 22 Feb 2023 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKgEA/fOSlXr0CBhdOfob9+bJNSViu9v8V75uikiRi0=;
        b=mmA1Waa626q2PtBdhBbjLGkt3+D1c1xVhIq2gdFpndfuQ+S1Yzn2TGiYh4RR2Xk6IQ
         SsCtHePYIH48La84ApXcvVHy0v6wC/HNCSm5Vh+tP8Wqdpky380BATIhDMlWaJL6p9SF
         ywX7KYnXAyqlo62llKg7robwGs8pdr8CXTtQex3mMS8qcpOCrx5LhuhUZZB5gcFo69Sy
         YrZMhfV18M422GyMYd8/+zlNYasVsv/hToppCwRSV4EJzHKv2YDdRZjYpDhwds+DmOQK
         algUgqhu4SuLnI2ZCO64fcNc0GUej9qxkcR0M81fOpFBzE8ODS8mvCNomc1PPOnZOe/d
         DJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKgEA/fOSlXr0CBhdOfob9+bJNSViu9v8V75uikiRi0=;
        b=zkQUDud1AGYaeloMWERKNULqVu5sogFksMjKJHSJxRC8V/c0GOb8p+fjA+n4lNaG23
         eJH3i1DFYNUxR9tSHNwwzNHN3ixuPEeSkzZikjRRSFRhV9WWwyeqjR6FBXyz8eKSpS8w
         M0L3F1un3tVsYbMi6phF3q6zXPBjJasSMH2dpuA6bHP2kLtudlEuhg4Ns58Rg5U2XAUU
         lTTGez+WIq5fRzKc5nwoPmsN9mIR2MP2LlGDrg9pe/Yrfp4WfZyr2DVHBQO8LYXSMU5k
         g9xgZZzzGhgZGNjm4pYn0t1v3PNDqhPqYrn099/24ahCiwTf+pe9mNGdE93Ki5yIhAZb
         2MLw==
X-Gm-Message-State: AO0yUKUvuPMYUjTyjdjbrVKrwssw788cciDoni+SwlGLAouwfYRBaXnL
        tMXZBhCVxX+rmwC0XGvYZXIzJaPy5pLqKiGjIIc=
X-Google-Smtp-Source: AK7set8OjezVhI9h0uCuF0+UcjamVY/154kO2FAuONaqAaoqamanQONsfK5EGak+6bty3QBuw4+kt7h79uDnvckNzgE=
X-Received: by 2002:a05:6870:808d:b0:16e:8a56:d0d2 with SMTP id
 q13-20020a056870808d00b0016e8a56d0d2mr1408005oab.38.1677092967347; Wed, 22
 Feb 2023 11:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20230221101430.14546-1-johan+linaro@kernel.org> <20230221101430.14546-4-johan+linaro@kernel.org>
In-Reply-To: <20230221101430.14546-4-johan+linaro@kernel.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Feb 2023 11:09:16 -0800
Message-ID: <CAF6AEGsco+h0f5twHz9CRFyCUeiK1WOJWcURW3wPiZx5muio0g@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/msm/adreno: drop redundant pm_runtime_disable()
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 21, 2023 at 2:16 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Since commit 4b18299b3365 ("drm/msm/adreno: Defer enabling runpm until
> hw_init()") runtime PM is no longer enabled at adreno_gpu_init(), which
> means that there are no longer any bind() error paths for which
> adreno_gpu_cleanup() is called with runtime PM enabled.
>
> As the runtime PM enable on first open() is balanced by the
> pm_runtime_force_suspend() call at unbind(), adreno_gpu_cleanup() is now
> always called with runtime PM disabled so that its pm_runtime_disable()
> call can be removed.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index ce6b76c45b6f..1101b8234b49 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1082,15 +1082,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>
>  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>  {
> -       struct msm_gpu *gpu = &adreno_gpu->base;
> -       struct msm_drm_private *priv = gpu->dev ? gpu->dev->dev_private : NULL;
>         unsigned int i;
>
>         for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>                 release_firmware(adreno_gpu->fw[i]);
>
> -       if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
> -               pm_runtime_disable(&priv->gpu_pdev->dev);
> -

Maybe WARN_ON(priv && pm_runtime_enabled(&priv->gpu_pdev->dev))?

BR,
-R

>         msm_gpu_cleanup(&adreno_gpu->base);
>  }
> --
> 2.39.2
>
