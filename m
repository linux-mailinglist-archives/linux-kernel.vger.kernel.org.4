Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398CB7308B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjFNTpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbjFNTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:45:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0AB273C;
        Wed, 14 Jun 2023 12:44:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EIhauO028617;
        Wed, 14 Jun 2023 19:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=6pW/u4iW4XUqaxN5ojDqG5II9H8tDZ7nYxUaZ3qg1eA=;
 b=nj7+6yZfbaxEjyzY225FAB/RaXHDeK6/bhEzu23GcgWVz9MR561dUwCb2SCU87jrT33i
 yij3KdF4MXid9d/CKlVHvcKmluMS/16LAIdvs06fKQ4cqC9x8uvWuZQXA16NYTgknY87
 Rfgzoh9/rAaljHgvuFV0bdV7icOkJ4+/RdB/PnAfGXRu1LGF8pEwx6kngBupdQImtyBs
 gpUKPvhULr4JzbgPw+LhOgXpW6VqX6CoKz21AfPga0ydgmEEVHB2SW3fe0gfUV3G+XF6
 PPJDtm2h6GnC6UJqPmjYb21+x2ekGHGb42wbGOkqvAB1Uck0FOa5YxnhMKIp/x299LMC zA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r78c79tmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:44:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EJibVm002951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:44:37 GMT
Received: from akhilpo-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 12:44:32 -0700
Date:   Thu, 15 Jun 2023 01:14:29 +0530
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
Subject: Re: [PATCH v8 14/18] drm/msm/a6xx: Fix some A619 tunables
Message-ID: <aqve5igov3etinkljvs5vza5zky5yssebbk76flomongrzra7u@mjgt7ri2ftkw>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-14-69c68206609e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223-topic-gmuwrapper-v8-14-69c68206609e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eZ6aw8tHRDT1cmsew7SGnabpzxYk0A8m
X-Proofpoint-ORIG-GUID: eZ6aw8tHRDT1cmsew7SGnabpzxYk0A8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=908 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:52:33PM +0200, Konrad Dybcio wrote:
> 
> Adreno 619 expects some tunables to be set differently. Make up for it.
> 
> Fixes: b7616b5c69e6 ("drm/msm/adreno: Add A619 support")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index c0d5973320d9..1a29e7dd9975 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1198,6 +1198,8 @@ static int hw_init(struct msm_gpu *gpu)
>  		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
>  	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
> +	else if (adreno_is_a619(adreno_gpu))
> +		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00018000);
>  	else if (adreno_is_a610(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
>  	else
> @@ -1215,7 +1217,9 @@ static int hw_init(struct msm_gpu *gpu)
>  	a6xx_set_ubwc_config(gpu);
>  
>  	/* Enable fault detection */
> -	if (adreno_is_a610(adreno_gpu))
> +	if (adreno_is_a619(adreno_gpu))
> +		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
> +	else if (adreno_is_a610(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
>  	else
>  		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

-Akhil
> 
> -- 
> 2.40.1
> 
