Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5F68F6D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjBHSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjBHSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:21:19 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78046095;
        Wed,  8 Feb 2023 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1675880478; x=1707416478;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=KBO2VYxNnhi+mYdSb2ex0Tcoin8hOOA965wqenytq3M=;
  b=ta0f7vNn3y46sTvHMfRNOGbg6JR0L3UVV3npQn4AXdIb7my5e+tgWPNJ
   Rs9a4JsC5J+eD4lJ1TamlUICVdFuUV3rNKOvrK8d2j45Mk+fP5uxMO0Qd
   63sgPhWMuLXuwrfyDdERln5yS4FPgcC+c53nxlnu0y2mmDK256o1L5Ike
   A=;
X-IronPort-AV: E=Sophos;i="5.97,281,1669075200"; 
   d="scan'208";a="179809775"
Subject: Re: [Freedreno] [PATCH 09/14] drm/msm/a6xx: Fix some A619 tunables
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:21:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id D2B4C42F67;
        Wed,  8 Feb 2023 18:21:04 +0000 (UTC)
Received: from EX19D047UWB002.ant.amazon.com (10.13.138.34) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Wed, 8 Feb 2023 18:21:03 +0000
Received: from amazon.com (10.43.160.120) by EX19D047UWB002.ant.amazon.com
 (10.13.138.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24; Wed, 8 Feb 2023
 18:21:03 +0000
Date:   Wed, 8 Feb 2023 11:21:01 -0700
From:   Jordan Crouse <jorcrous@amazon.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <freedreno@lists.freedesktop.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
        Chia-I Wu <olvaffe@gmail.com>, <linux-kernel@vger.kernel.org>
Message-ID: <20230208182101.53ykatzah6zvpy76@amazon.com>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        marijn.suijten@somainline.org, Sean Paul <sean@poorly.run>,
        Chia-I Wu <olvaffe@gmail.com>, linux-kernel@vger.kernel.org
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
 <20230126151618.225127-10-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126151618.225127-10-konrad.dybcio@linaro.org>
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D32UWA002.ant.amazon.com (10.43.160.230) To
 EX19D047UWB002.ant.amazon.com (10.13.138.34)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:16:13PM +0100, Konrad Dybcio wrote:
> Adreno 619 expects some tunables to be set differently. Make up for it.
> 
> Fixes: b7616b5c69e6 ("drm/msm/adreno: Add A619 support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 7a480705f407..f34ab3f39f09 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1171,6 +1171,8 @@ static int hw_init(struct msm_gpu *gpu)
>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
>         else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
> +       else if (adreno_is_a619(adreno_gpu))
> +               gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00018000);
>         else if (adreno_is_a610(adreno_gpu))
>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
>         else
> @@ -1188,7 +1190,9 @@ static int hw_init(struct msm_gpu *gpu)
>         a6xx_set_ubwc_config(gpu);
> 
>         /* Enable fault detection */
> -       if (adreno_is_a610(adreno_gpu))
> +       if (adreno_is_a619(adreno_gpu))
> +               gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
> +       else if (adreno_is_a610(adreno_gpu))
>                 gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
>         else
>                 gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);

The number appended to the register is the number of clock ticks to wait
before declaring a hang. 0x3fffff happens to be the largest value that
can be set for the a6xx family (excepting the 610 which, IIRC, used older
hardware that had a smaller field for the counter). Downstream the
number would creep up over time as unexplained hangs were discovered and
diagnosed or covered up as "just wait longer".

So in theory you could leave this with the "default value" or even bump
up the default value to 0x3fffff for all targets if you wanted to. An
alternate solution (that downstream does) is to put this as a
pre-defined configuration in gpulist[].

Jordan
