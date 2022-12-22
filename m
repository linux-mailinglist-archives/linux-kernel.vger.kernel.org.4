Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41F96544EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiLVQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiLVQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:10:29 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517731E3E9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:10:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x66so1547898pfx.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LbHWQm/nCfihTHW8c/djSdKPRylgW1zq/mA/hxAzNU=;
        b=faSTzKUXYjlhyqwbeSVyJWqAK7VjdTNPOelw5Sg8T5Ojs6uhhI73zCRE5vapbz+uhQ
         tomGemoBo/ndRpkOr81fq0fBk1iM4mAaFh14Ru1Nt9P/Z+boBe+zYtkvk0ExAo6v1IiI
         3QHMofV0UzIlVflXoGFIc3iVzCxAh7J/zCWI+SXJ3Jt53oOKOIuTpyadKR2YEx17Twct
         qJpgr171j/bF9jfogd7hr13n95BxGyPVeaGLhH2kaGXYtKt9CZ9ZFfSpQlAickXUyZiZ
         ttl4TIQle4SdU1l7pAt9me8nTrnlwbaMIAPq356HpNOGpKCAEsrBnWGgaojbL14fhDSS
         knkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LbHWQm/nCfihTHW8c/djSdKPRylgW1zq/mA/hxAzNU=;
        b=JJ7GXc+UFaZuuDg9bGA0137N6BmBAMCMBfuler9cKzWQ9CrkwQjTcx8E0Y0RwvqUvZ
         B/RCnpI8iSDOYwSxdESpxWiKfJ6EQ1iUzsg4SkcJ4r0SvzmBuaXcnpLkMrSBa9CitSUN
         vkiyfpE5yAQAW43rWB+ssfVezeyxNLJRk9LRwTdGjTYJ06fBkq1nZiGrHtPWQQDQuq9C
         nw/dD0tWtSp8GIsbvzuAODZKjhJ+TBQ7n+fGGhnd0P3RoTb5LbCBYYTpOvEKGlI1w51K
         +qCVeQTL8ydRWhbYug0i4ci3zdZvmA1KUx5cLRub0Vjt9w4ovaGKXkecmxF4VaCC7Bcw
         WRUQ==
X-Gm-Message-State: AFqh2krnbgtLICcOYSKr17Imqk8e92R7te6DLM3njmUgHOLZO4DO9RnE
        spOwgMgwEs7qayRYPMdjUYluUBSqFzKl8u7JP/paKg==
X-Google-Smtp-Source: AMrXdXt4MWTAT4avILmrBPNnvEVTV9+/DvSwBqeCnt+KkZos6X5NyTCN5Ad7ZtQz21CLieDITrVE70FplYJZIEgH+zU=
X-Received: by 2002:a62:ed04:0:b0:577:3e5e:7a4 with SMTP id
 u4-20020a62ed04000000b005773e5e07a4mr448901pfh.57.1671725427726; Thu, 22 Dec
 2022 08:10:27 -0800 (PST)
MIME-Version: 1.0
References: <1671642843-5244-1-git-send-email-quic_akhilpo@quicinc.com> <20221221224338.v4.3.I7f545d8494dcdbe6e96a15fbe8aaf5bb0c003d50@changeid>
In-Reply-To: <20221221224338.v4.3.I7f545d8494dcdbe6e96a15fbe8aaf5bb0c003d50@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Dec 2022 17:09:51 +0100
Message-ID: <CAPDyKFqFrf5qVpsQs-cwYnazBBjG-QkKxFL1szNmz+x3hq27gg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drm/msm/a6xx: Vote for cx gdsc from gpu driver
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 at 18:14, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> When a device has multiple power domains, dev->power_domain is left
> empty during probe. That didn't cause any issue so far because we are
> freeloading on smmu driver's vote on cx gdsc. Instead of that, create
> a device_link between cx genpd device and gmu device to keep a vote from
> gpu driver.
>
> Before this patch:
> localhost ~ # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> gx_gdsc         on              0
>     /devices/genpd:1:3d6a000.gmu                active          0
> cx_gdsc         on              0
>     /devices/platform/soc@0/3da0000.iommu       active          0
>
> After this patch:
> localhost ~ # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> gx_gdsc         on              0
>     /devices/genpd:1:3d6a000.gmu                active          0
> cx_gdsc         on              0
>     /devices/platform/soc@0/3da0000.iommu       active          0
>     /devices/genpd:0:3d6a000.gmu                active          0
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 31 +++++++++++++++++++++++++++----
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 6484b97c5344..1580d0090f35 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1479,6 +1479,12 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
>
>         pm_runtime_force_suspend(gmu->dev);
>
> +       /*
> +        * Since cxpd is a virt device, the devlink with gmu-dev will be removed
> +        * automatically when we do detach
> +        */
> +       dev_pm_domain_detach(gmu->cxpd, false);
> +
>         if (!IS_ERR_OR_NULL(gmu->gxpd)) {
>                 pm_runtime_disable(gmu->gxpd);
>                 dev_pm_domain_detach(gmu->gxpd, false);
> @@ -1605,8 +1611,10 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>
>         if (adreno_is_a650_family(adreno_gpu)) {
>                 gmu->rscc = a6xx_gmu_get_mmio(pdev, "rscc");
> -               if (IS_ERR(gmu->rscc))
> +               if (IS_ERR(gmu->rscc)) {
> +                       ret = -ENODEV;
>                         goto err_mmio;
> +               }
>         } else {
>                 gmu->rscc = gmu->mmio + 0x23000;
>         }
> @@ -1615,8 +1623,22 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>         gmu->hfi_irq = a6xx_gmu_get_irq(gmu, pdev, "hfi", a6xx_hfi_irq);
>         gmu->gmu_irq = a6xx_gmu_get_irq(gmu, pdev, "gmu", a6xx_gmu_irq);
>
> -       if (gmu->hfi_irq < 0 || gmu->gmu_irq < 0)
> +       if (gmu->hfi_irq < 0 || gmu->gmu_irq < 0) {
> +               ret = -ENODEV;
> +               goto err_mmio;
> +       }
> +
> +       gmu->cxpd = dev_pm_domain_attach_by_name(gmu->dev, "cx");
> +       if (IS_ERR(gmu->cxpd)) {
> +               ret = PTR_ERR(gmu->cxpd);
>                 goto err_mmio;
> +       }
> +
> +       if (!device_link_add(gmu->dev, gmu->cxpd,
> +                                       DL_FLAG_PM_RUNTIME)) {
> +               ret = -ENODEV;
> +               goto detach_cxpd;
> +       }
>
>         /*
>          * Get a link to the GX power domain to reset the GPU in case of GMU
> @@ -1634,6 +1656,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>
>         return 0;
>
> +detach_cxpd:
> +       dev_pm_domain_detach(gmu->cxpd, false);
> +
>  err_mmio:
>         iounmap(gmu->mmio);
>         if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
> @@ -1641,8 +1666,6 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>         free_irq(gmu->gmu_irq, gmu);
>         free_irq(gmu->hfi_irq, gmu);
>
> -       ret = -ENODEV;
> -
>  err_memory:
>         a6xx_gmu_memory_free(gmu);
>  err_put_device:
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index e034935b3986..5a42dd4dd31f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -56,6 +56,7 @@ struct a6xx_gmu {
>         int gmu_irq;
>
>         struct device *gxpd;
> +       struct device *cxpd;
>
>         int idle_level;
>
> --
> 2.7.4
>
