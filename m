Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9B62D8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiKQLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiKQLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A36B237;
        Thu, 17 Nov 2022 02:57:45 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH6nwhY000845;
        Thu, 17 Nov 2022 10:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F0pGU1BlNM79za83vEB5fdDsZRyTyENXL11lu+0vAWI=;
 b=XnKTGrX5RA3CffErTysra0/6A8G5d11s16zOCoGIxx4eVBEhps9KX0LmTBXUCzyLFtHc
 6DDsR1ON+HaoAqtLbfoX2R2Fn9auQpcG3MYWJBoNVkR4NSMy46v6b/94niuqQuyQ85gZ
 HwXXy/fNNsPQPb+udjW7xGjAvI/y6Ycev0K+AITeweBw0xobn/pFZizlCUtidkegOi82
 m5hdjsrSUI7qB6W2pUcH1qJWd3JysP3n4xEGuB4L4DSfQsr6TAGxGdqT3PAccDIYYGff
 JC0GsysjYG0LYHRtbO3ccA2PVXsjSwVRQ5LR+qCom5qZD3GTo9idq9wCd6DCg68SFUMC 4A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwg1mrt8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:57:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHAvcFd011626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:57:38 GMT
Received: from [10.216.1.87] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 17 Nov
 2022 02:57:32 -0800
Message-ID: <ee436c31-6b38-4c1c-8d40-865e57750e6f@quicinc.com>
Date:   Thu, 17 Nov 2022 16:27:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "Rob Clark" <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221115154637.1613968-1-robdclark@gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20221115154637.1613968-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UL_coQY-6jlE9drln0tJpKU__dSx8ogz
X-Proofpoint-ORIG-GUID: UL_coQY-6jlE9drln0tJpKU__dSx8ogz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2022 9:16 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> If we get an error (other than -ENOENT) we need to propagate that up the
> stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up
> end up claiming that we support all the OPPs which is not likely to be
> true (and on some generations impossible to be true, ie. if there are
> conflicting OPPs).
>
> v2: Update commit msg, gc unused label, etc
> v3: Add previously missing \n's
>
> Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 7fe60c65a1eb..ebe9599a8316 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1931,7 +1931,7 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>   
>   	if (val == UINT_MAX) {
>   		DRM_DEV_ERROR(dev,
> -			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware",
> +			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
>   			fuse);
>   		return UINT_MAX;
>   	}
> @@ -1941,7 +1941,7 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>   
>   static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
>   {
> -	u32 supp_hw = UINT_MAX;
> +	u32 supp_hw;
>   	u32 speedbin;
>   	int ret;
>   
> @@ -1953,15 +1953,13 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
>   	if (ret == -ENOENT) {
>   		return 0;
>   	} else if (ret) {
> -		DRM_DEV_ERROR(dev,
> -			      "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
> -			      ret);
> -		goto done;
> +		dev_err_probe(dev, ret,
> +			      "failed to read speed-bin. Some OPPs may not be supported by hardware\n");
> +		return ret;
>   	}
>   
>   	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
>   
> -done:
>   	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
>   	if (ret)
>   		return ret;

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>


-Akhil.
