Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACCA665F16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbjAKP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjAKP2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:28:51 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7E63B5;
        Wed, 11 Jan 2023 07:28:51 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r205so12990169oib.9;
        Wed, 11 Jan 2023 07:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4sF9h6AYZZ9s9l5isulzAYtAnPwM/o7/+dNoOtQdd7k=;
        b=jCfjWEPy76z0U6Zi4tXKqIT2iG2oWVhqA22BBBU/5rgt0jvil+CKwT1n+yThem7vaq
         qyh74PFrGus/RRZN60oOIXMcXNh7/CJV/Pvf3OdWY1mM4lGtexdF0UIpIIWRYdG5b1VX
         PLut62M4sIVtjfPAfJc1rk8ey0/lSQrd+SYSPPxXaVY+uQEstJvAbDi5u5xzZ6ks6cls
         uV8wrZNpApvwyCJN6mw7HiWCPsuCPJoNUVErIToueQQZnYa5yqDB/yKaYadt23ikIEbN
         CgkwXv7Rsk3XICFrW3c1nGU6+HzuxlpQfBcL3NQt1Ey2opE4Zo7HVmWI6YAZvpv8GS/E
         7ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sF9h6AYZZ9s9l5isulzAYtAnPwM/o7/+dNoOtQdd7k=;
        b=lqhAbgzRyUGE39jKT9adiOkrRmB5vdm12XsXR+8ieUVpaysbD0L1W2a2whJX4CEulh
         UWT8mZ6A88nRHgt6L80clfctURbiM9cN979tm+8z7LasfEmDabekztctIwbTMyBHyBei
         Ndl2Cjlk3C25YJ8zx9PokkK/GCt5rF4LMXb3X/5Pvz15PtprbjhCeX8OYkRLtMgPOVLl
         Xx3sEoCZgRIRh49oPVir8aSgFOHO/D/RprgPtmN0LUiBgwC3Iuv8FFeFAxI6bMXtNgtR
         qZEPKiK4mrpVKrsd/NlKI2k7KgdL593AAgCpnLc/3kk5ozQ9N2NDKRfIx9wb+SK1pEiS
         ji6A==
X-Gm-Message-State: AFqh2koIwx77sMmPe2JpkkOHwxOvH8SNreu1LooKHdEErzXD3gyd+21B
        6cpIUFqwQF59l8jtFBhxt9mf4kxhU6LvwVEBmmQ=
X-Google-Smtp-Source: AMrXdXuXROjZ0MWVSMSHb3c1hKspO7uvkZCFoKujUD3ng5FA/3eJ481QFUqk2kWBDyIW1WB1IIHK4eFbVUfCBAtaGbk=
X-Received: by 2002:a05:6808:409a:b0:360:ffcc:3685 with SMTP id
 db26-20020a056808409a00b00360ffcc3685mr3737807oib.183.1673450930270; Wed, 11
 Jan 2023 07:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20230110212903.1925878-1-robdclark@gmail.com>
In-Reply-To: <20230110212903.1925878-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 11 Jan 2023 07:28:45 -0800
Message-ID: <CAF6AEGsivdz-e+sCRQto1_WBZ80bv8b4xDbYvzX-4sVo9kM7Yw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix potential double-free
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Emma Anholt <emma@anholt.net>,
        Dan Carpenter <error27@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, Jan 10, 2023 at 1:29 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> If userspace was calling the MSM_SET_PARAM ioctl on multiple threads to
> set the COMM or CMDLINE param, it could trigger a race causing the
> previous value to be kfree'd multiple times.  Fix this by serializing on
> the gpu lock.
>

Fixes: d4726d770068 ("drm/msm: Add a way to override processes comm/cmdline")

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++++
>  drivers/gpu/drm/msm/msm_gpu.c           |  2 ++
>  drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 57586c794b84..3605f095b2de 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -352,6 +352,8 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>                 /* Ensure string is null terminated: */
>                 str[len] = '\0';
>
> +               mutex_lock(&gpu->lock);
> +
>                 if (param == MSM_PARAM_COMM) {
>                         paramp = &ctx->comm;
>                 } else {
> @@ -361,6 +363,8 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>                 kfree(*paramp);
>                 *paramp = str;
>
> +               mutex_unlock(&gpu->lock);
> +
>                 return 0;
>         }
>         case MSM_PARAM_SYSPROF:
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index bfef659d3a5c..7537e7b3a452 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -336,6 +336,8 @@ static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **
>         struct msm_file_private *ctx = submit->queue->ctx;
>         struct task_struct *task;
>
> +       WARN_ON(!mutex_is_locked(&submit->gpu->lock));
> +
>         /* Note that kstrdup will return NULL if argument is NULL: */
>         *comm = kstrdup(ctx->comm, GFP_KERNEL);
>         *cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index a771f56ed70f..fc1c0d8611a8 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -375,10 +375,18 @@ struct msm_file_private {
>          */
>         int sysprof;
>
> -       /** comm: Overridden task comm, see MSM_PARAM_COMM */
> +       /**
> +        * comm: Overridden task comm, see MSM_PARAM_COMM
> +        *
> +        * Accessed under msm_gpu::lock
> +        */
>         char *comm;
>
> -       /** cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE */
> +       /**
> +        * cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE
> +        *
> +        * Accessed under msm_gpu::lock
> +        */
>         char *cmdline;
>
>         /**
> --
> 2.38.1
>
