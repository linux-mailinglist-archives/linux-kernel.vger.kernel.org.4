Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D171D6C2123
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCTTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCTTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:18:07 -0400
X-Greylist: delayed 781 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 12:09:56 PDT
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B24C2C;
        Mon, 20 Mar 2023 12:09:56 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl [83.9.32.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E855F3F1F1;
        Mon, 20 Mar 2023 19:56:37 +0100 (CET)
Message-ID: <434caf75-eed1-ac35-f43c-da8c66cb99bc@somainline.org>
Date:   Mon, 20 Mar 2023 19:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] drm/msm/a6xx: Some reg64 conversion
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230320185416.938842-1-robdclark@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20230320185416.938842-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 19:54, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The next generated header update will drop the _LO/_HI suffix, now that
> the userspace tooling properly understands 64b vs 32b regs (and the _LO/
> _HI workarounds are getting cleaned up).  So convert to using the 64b
> reg helpers in prep.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 89049094a242..f26e258c6021 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1053,12 +1053,9 @@ static int hw_init(struct msm_gpu *gpu)
>  	gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
>  
>  	/* Disable L2 bypass in the UCHE */
> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0xffffffc0);
> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_HI, 0x0001ffff);
> -	gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0xfffff000);
> -	gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_HI, 0x0001ffff);
> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
> -	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
> +	gpu_write64(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0x0001ffffffffffc0llu);
> +	gpu_write64(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0x0001fffffffff000llu);
> +	gpu_write64(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0x1fffffffff000llu);
Any reason the last write dropped the leading zeroes?

Otherwise,

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  
>  	if (!adreno_is_a650_family(adreno_gpu)) {
>  		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
