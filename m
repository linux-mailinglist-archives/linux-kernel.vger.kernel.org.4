Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C609658BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiL2Krj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiL2Krg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:47:36 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4938B12753
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:47:34 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D92023F114;
        Thu, 29 Dec 2022 11:47:31 +0100 (CET)
Date:   Thu, 29 Dec 2022 11:47:30 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: Make adreno quirks not overwrite each
 other
Message-ID: <20221229104730.guopbgyleb6hif4h@SoMainline.org>
References: <20221229101846.981223-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229101846.981223-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-29 11:18:45, Konrad Dybcio wrote:
> So far the adreno quirks have all been assigned with an OR operator,
> which is problematic, because they were assigned consecutive integer
> values, which makes checking them with an AND operator kind of no bueno..
> 
> Switch to using BIT(n) so that only the quirks that the programmer chose
> are taken into account when evaluating info->quirks & ADRENO_QUIRK_...
> 
> Fixes: b5f103ab98c7 ("drm/msm: gpu: Add A5XX target support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Nice catch!

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Not sure if it's the right Fixes commit though, as it would have worked
when ADRENO_QUIRK_LMLOADKILL_DISABLE was added with constant 4 instead
of 3 in 370063ee427a ("drm/msm/adreno: Add A540 support"), but then
using bitflags in an enum value type is invalid anyway, AFAIK.

- Marijn

> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index c85857c0a228..5eb254c9832a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -29,11 +29,9 @@ enum {
>  	ADRENO_FW_MAX,
>  };
>  
> -enum adreno_quirks {
> -	ADRENO_QUIRK_TWO_PASS_USE_WFI = 1,
> -	ADRENO_QUIRK_FAULT_DETECT_MASK = 2,
> -	ADRENO_QUIRK_LMLOADKILL_DISABLE = 3,
> -};
> +#define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
> +#define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
> +#define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
>  
>  struct adreno_rev {
>  	uint8_t  core;
> @@ -65,7 +63,7 @@ struct adreno_info {
>  	const char *name;
>  	const char *fw[ADRENO_FW_MAX];
>  	uint32_t gmem;
> -	enum adreno_quirks quirks;
> +	u64 quirks;
>  	struct msm_gpu *(*init)(struct drm_device *dev);
>  	const char *zapfw;
>  	u32 inactive_period;
> -- 
> 2.39.0
> 
