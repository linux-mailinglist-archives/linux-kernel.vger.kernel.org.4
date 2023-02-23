Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD186A010D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBWCJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWCJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:09:34 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B893346A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:09:30 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536e10ae021so116378937b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbYdW/CMgF/JfnnuxHnRpk02gufmOMvNHJ4zCkICzbw=;
        b=KABATLx3ol5lSbON4VucpcXvsQMb43OkNuqb3pDe0SEz78dnqNSEQBS2W7v+WyMa6J
         nqLBgarNICyveVtAPLtEN89NYd2K774BOPE/x8r2HqxYuBQ3ZTD7rS9xDH803jF72YzJ
         +QxL1sC6YoaF29LmVzjd9o9nQNeFAQ/bHXGQvWfiKHxp29+tmAYZI2ea6H0ZCNAe9HSt
         639sIfmENM0CHHj/0MQcwfgVR5S+D3VO4HNm+lgbJYFNqAhsdVflamVG7NHcQICRBZSD
         opxA6eLMj1nizCSXGRehmRqzQbNXhX6JnZ0EQHXUuJ6XbdPMrHjVaEIKjR+TX/mIrc0X
         8rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbYdW/CMgF/JfnnuxHnRpk02gufmOMvNHJ4zCkICzbw=;
        b=jPtJGZ0Pn2AR1F3bVWEyZkcmQpYDetuG/XVu3YyN5xZbLcE4zCtCbhfoY44GODa/i5
         bdA9o9kDzbUEfGUOX9wKD/EyDsrzMZtn6QS8xW6yuet/z0g6oSk6NkzJpJ3d0FzVeeXB
         yqI91iPkNhXYaMFm7yh6eX1OGIYbgKSexkAiX7Jq1/n07c0FnpFRBDb8oWgC+qXz1js5
         ZFTCxur7Orn9TlYyBwjZmPflpV+FxWFx+P8ARrPyg0wesbZK2O3jr7ePU/b0THgC8LFH
         FlZ/QZBAah79u6jZUcLfcyN15qtNnMVNHw52H9p9Gxa9AsIl3pXu2Mzu6USsfN0eneW0
         SQGQ==
X-Gm-Message-State: AO0yUKUZKs3BU1g0iKZgy2aTy04QwmXLThJYnAwd1+wd2PASEMDnBJyq
        7c1Ih1Yb6N62JD+DV/pgT2bGkJNncMXZdbvlxtPuLA==
X-Google-Smtp-Source: AK7set/bMS3BZTkPChCYgDUTiqQu8r7v3lZPx+AN3Yludgn6OW8+Ow5/FesiZx0zsAJZUHbts9E977z481wrO3/Dwy0=
X-Received: by 2002:a81:ac60:0:b0:530:9fa8:74ab with SMTP id
 z32-20020a81ac60000000b005309fa874abmr1466785ywj.3.1677118169993; Wed, 22 Feb
 2023 18:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20230223-topic-opp-v2-0-24ed24cd7358@linaro.org> <20230223-topic-opp-v2-3-24ed24cd7358@linaro.org>
In-Reply-To: <20230223-topic-opp-v2-3-24ed24cd7358@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Feb 2023 04:09:19 +0200
Message-ID: <CAA8EJprAxKCD_bJFdaMGhnwW56u+NLN_qxBV9aSzMTRdzsh07A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/msm/a2xx: Implement .gpu_busy
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 03:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Implement gpu_busy based on the downstream msm-3.4 code [1]. This
> allows us to use devfreq on this old old old hardware!
>
> [1] https://github.com/LineageOS/android_kernel_sony_apq8064/blob/lineage-16.0/drivers/gpu/msm/adreno_a2xx.c#L1975
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Small nit below

> ---
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> index c67089a7ebc1..6f9876b37db5 100644
> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> @@ -481,6 +481,29 @@ a2xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
>         return aspace;
>  }
>
> +/* While the precise size of this field is unknown, it holds at least these three values.. */
> +static u64 a2xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
> +{
> +       u64 busy_cycles;
> +
> +       /* Freeze the counter */
> +       gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_FREEZE);
> +
> +       busy_cycles = gpu_read64(gpu, REG_A2XX_RBBM_PERFCOUNTER1_LO);
> +
> +       /* Reset the counter */
> +       gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_RESET);
> +
> +       /* Re-enable the performance monitors */
> +       gpu_rmw(gpu, REG_A2XX_RBBM_PM_OVERRIDE2, BIT(6), BIT(6));

It's DEBUG_PERF_SCLK_PM_OVERRIDE

See https://github.com/genesi/linux-legacy/blob/master/drivers/mxc/amd-gpu/include/reg/yamato/10/yamato_mask.h#L4428

> +       gpu_write(gpu, REG_A2XX_RBBM_PERFCOUNTER1_SELECT, 1);
> +       gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_ENABLE);
> +
> +       *out_sample_rate = clk_get_rate(gpu->core_clk);
> +
> +       return busy_cycles;
> +}
> +
>  static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  {
>         ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
> @@ -502,6 +525,7 @@ static const struct adreno_gpu_funcs funcs = {
>  #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>                 .show = adreno_show,
>  #endif
> +               .gpu_busy = a2xx_gpu_busy,
>                 .gpu_state_get = a2xx_gpu_state_get,
>                 .gpu_state_put = adreno_gpu_state_put,
>                 .create_address_space = a2xx_create_address_space,
>
> --
> 2.39.2
>


-- 
With best wishes
Dmitry
