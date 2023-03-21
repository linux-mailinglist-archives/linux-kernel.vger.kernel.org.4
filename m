Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA16C3529
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCUPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjCUPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:09:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470319F38;
        Tue, 21 Mar 2023 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CwIHkpepA45mqMWjB5SJ5nGprFOvERonnDnbpco9zTo=; b=i5CeNBAdvc9ZzWdVyCUtUzswZj
        TdfLI5iY1Njbz8NT7gTr9cfbEJSOTpS7E40JgtjIiMJcMvd9CCQvQZNujR01d2fjHsk4cY9KIP0cW
        6cA+oo5u3Gm9T9bji8NL7PfM1lFSJfLvueHKzK2DVZkC4dCdvjT0604lelMNz5jpEJZhfe4l1Fpmx
        TyZ/bzoio2zN1jvD2Zd8ZRfQgPvL6Ta17GVkcO6DQRzLOo6aBYMwVPjjxoSfrEnPMkygkAjc0NiIF
        RKhWnBT06GymTni0O3Yu+shURBxNnpLe+aIJms0DyYYr7e85xcf9y6aCvu9DoYOotbSuqVhpgBxE1
        qbwmA38A==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pedbD-00CrCV-08;
        Tue, 21 Mar 2023 15:08:31 +0000
Message-ID: <f2ac0d80-fab1-8211-1dfe-cea078929e91@infradead.org>
Date:   Tue, 21 Mar 2023 08:08:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/msm/dpu: Fix bit-shifting UB in DPU_HW_VER() macro
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230306090633.65918-1-geert+renesas@glider.be>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230306090633.65918-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/23 01:06, Geert Uytterhoeven wrote:
> With gcc-5 and CONFIG_UBSAN_SHIFT=y:
> 
>     drivers/gpu/drm/msm/msm_mdss.c: In function 'msm_mdss_enable':
>     drivers/gpu/drm/msm/msm_mdss.c:296:2: error: case label does not reduce to an integer constant
>       case DPU_HW_VER_800:
>       ^
>     drivers/gpu/drm/msm/msm_mdss.c:299:2: error: case label does not reduce to an integer constant
>       case DPU_HW_VER_810:
>       ^
>     drivers/gpu/drm/msm/msm_mdss.c:300:2: error: case label does not reduce to an integer constant
>       case DPU_HW_VER_900:
>       ^
> 
> This happens because for major revisions 8 or greather, the non-sign bit
> of the major revision number is shifted into bit 31 of a signed integer,
> which is undefined behavior.
> 
> Fix this by casting the major revision number to unsigned int.
> 
> Fixes: efcd0107727c4f04 ("drm/msm/dpu: add support for SM8550")
> Fixes: 4a352c2fc15aec1e ("drm/msm/dpu: Introduce SC8280XP")
> Fixes: 100d7ef6995d1f86 ("drm/msm/dpu: add support for SM8450")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index ddab9caebb18c40d..bbd3cbdd77956c5d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -19,8 +19,9 @@
>   */
>  #define MAX_BLOCKS    12
>  
> -#define DPU_HW_VER(MAJOR, MINOR, STEP) (((MAJOR & 0xF) << 28)    |\
> -		((MINOR & 0xFFF) << 16)  |\
> +#define DPU_HW_VER(MAJOR, MINOR, STEP)			\
> +		((((unsigned int)MAJOR & 0xF) << 28) |	\
> +		((MINOR & 0xFFF) << 16) |		\
>  		(STEP & 0xFFFF))
>  
>  #define DPU_HW_MAJOR(rev)		((rev) >> 28)

-- 
~Randy
