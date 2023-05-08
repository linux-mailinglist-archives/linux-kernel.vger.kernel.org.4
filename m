Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FE6FAA19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjEHK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjEHK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:58:47 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44A3489E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:57:36 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C177D3F1FF;
        Mon,  8 May 2023 12:57:19 +0200 (CEST)
Date:   Mon, 8 May 2023 12:57:18 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK
Message-ID: <vonnkr34hogk3r54pg5wqw3xv5ood4zkdojehcr5stonvqev6u@nnezyvphwo5k>
References: <20230508-topic-hctl_en-v1-1-0f8b5df60ed5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508-topic-hctl_en-v1-1-0f8b5df60ed5@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 12:29:32, Konrad Dybcio wrote:
> DPU5 and newer targets enable this unconditionally. Move it from the
> SC7280 mask to the SC7180 one.
> 
> Fixes: 7bdc0c4b8126 ("msm:disp:dpu1: add support for display for SC7180 target")

The flag only exists since 591e34a091d17 ("drm/msm/disp/dpu1: add
support for display for SC7280 target"), and I don't know how bad it is
if it was lacking when SC7180 was added?

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I wonder if this needs any Reported-by/Suggested-by, given that I found
the DATA_COMPRESS discrepancy for your SM6375 patch (which was using
SC7280 to have the HCTL mask) and Dmitry pointing out that HCTL needs to
be in SC7180 entirely.

Fortunately none of this affects cmdmode :)

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
> Depends on:
> https://lore.kernel.org/linux-arm-msm/20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com/
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 27420fc863d6..7ea8fd69d5fd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -98,9 +98,12 @@
>  #define INTF_SDM845_MASK (0)
>  
>  #define INTF_SC7180_MASK \
> -	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
> +	(BIT(DPU_INTF_INPUT_CTRL) | \
> +	 BIT(DPU_INTF_TE) | \
> +	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
> +	 BIT(DPU_DATA_HCTL_EN))
>  
> -#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_DATA_COMPRESS)
> +#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_INTF_DATA_COMPRESS)
>  
>  #define WB_SM8250_MASK (BIT(DPU_WB_LINE_MODE) | \
>  			 BIT(DPU_WB_UBWC) | \
> 
> ---
> base-commit: c47189dee0decd9ecc1e65ae376ad6d4b0b7f1f2
> change-id: 20230508-topic-hctl_en-3abb999a6c99
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
