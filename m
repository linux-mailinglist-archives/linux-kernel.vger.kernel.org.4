Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6B724A03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjFFRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbjFFRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:18:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B210CB;
        Tue,  6 Jun 2023 10:18:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356GMikk010241;
        Tue, 6 Jun 2023 17:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=gnindeRLNZKTMXVxO0DpWemKDr0YT7u/bKnQKJpKVcM=;
 b=oxHGeB1yVlM9Hu4yADv2Z5weFiaIObwH2EsNZVDtpcrYwYK1LoJyy7PqRUjTQ3INfJZ0
 3i3p1S14OB+fkNkCjU069KVUKFIR9WuqP1CCtwcwvdGq2uSWeaUVcph56TPYALKq3d6g
 ejw5SpdO74f3scc+/0fWQTQ3LVdE1kyM+YmyGIKv9Ez9Z/UuELMusBAgXlf4fgqdZLuw
 pyBJ1vkraQI51aozux/ZtVpJD44g2A8h8FPWR9EKZufLeckgkR3lg2ZRsNFb7tXJFNa3
 aRIZVAZy+gOy6hdpd8yVy13ysRY4WO5JqA91cw0dUCDL88hM/vqM5ERZGCcnxFVGAC7n gA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r249n0rkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 17:18:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356HIXGx009133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 17:18:33 GMT
Received: from akhilpo-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 10:18:27 -0700
Date:   Tue, 6 Jun 2023 22:48:24 +0530
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v8 07/18] drm/msm/a6xx: Add a helper for
 software-resetting the GPU
Message-ID: <jplt5g5xuphbnci73pdtaxd63fguxtgtp4c37kc7ehavzrjbau@kamshezxnvgy>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-7-69c68206609e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223-topic-gmuwrapper-v8-7-69c68206609e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vPruQmnWhNh65WTVEKYL6qztw-R3__Mw
X-Proofpoint-GUID: vPruQmnWhNh65WTVEKYL6qztw-R3__Mw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=762 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060149
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:52:26PM +0200, Konrad Dybcio wrote:
> 
> Introduce a6xx_gpu_sw_reset() in preparation for adding GMU wrapper
> GPUs and reuse it in a6xx_gmu_force_off().
> 
> This helper, contrary to the original usage in GMU code paths, adds
> a write memory barrier which together with the necessary delay should
> ensure that the reset is never deasserted too quickly due to e.g. OoO
> execution going crazy.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  3 +--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 11 +++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index b86be123ecd0..5ba8cba69383 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -899,8 +899,7 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
>  	a6xx_bus_clear_pending_transactions(adreno_gpu, true);
>  
>  	/* Reset GPU core blocks */
> -	gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, 1);
> -	udelay(100);
> +	a6xx_gpu_sw_reset(gpu, true);
>  }
>  
>  static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index e3ac3f045665..083ccb5bcb4e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1634,6 +1634,17 @@ void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
>  	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
>  }
>  
> +void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert)
> +{
> +	gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, assert);
> +	/* Add a barrier to avoid bad surprises */
Can you please make this comment a bit more clear? Highlight that we
should ensure the register is posted at hw before polling.

I think this barrier is required only during assert.

-Akhil.
> +	mb();
> +
> +	/* The reset line needs to be asserted for at least 100 us */
> +	if (assert)
> +		udelay(100);
> +}
> +
>  static int a6xx_pm_resume(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 9580def06d45..aa70390ee1c6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -89,5 +89,6 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu);
>  int a6xx_gpu_state_put(struct msm_gpu_state *state);
>  
>  void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
> +void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
>  
>  #endif /* __A6XX_GPU_H__ */
> 
> -- 
> 2.40.1
> 
