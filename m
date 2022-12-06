Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C65644963
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiLFQgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiLFQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:35:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD60FC10;
        Tue,  6 Dec 2022 08:34:53 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6CocaG002924;
        Tue, 6 Dec 2022 16:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LW1f2IGMYZaNZzh1IJS2Bnc7VQ7uiD6eYe+j3zm60ns=;
 b=CJbxX3s+Ay54pAxxfKwTvFQdncVC6EBS1Cu5SkAjoMUfd92FQryHILIGGTG73p1n+iJM
 dhm22ErIksRopV9xXIMxaJ/+8ktG6TxyC6t/JrWYFuJEI/OvGAysSRAQy9sc8npV0AUB
 nFbMiXN1M2FNZjTSS6lJ4mN7144TeLEvRwZZbA5I15nvvSVIuzuL0yi5OfVqdYLN1+gL
 Ro2UV6F5aYgHpkDpoWB9H4KrzRKrsie+1GD75YD/orSmHBR2Qd5kCAzi6Yh29jveCI5q
 aNvBRbW8mvzSSp/QAQgu6Cvbele1SV2neL0lbD5w6gVmsgl86t1O/DB5rvzY+oQAe1V5 Kw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ma21us03v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 16:34:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B6GYKev032197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 16:34:20 GMT
Received: from [10.38.242.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:34:16 -0800
Message-ID: <339d9ec4-a554-d468-51f4-498d785685b6@quicinc.com>
Date:   Tue, 6 Dec 2022 08:32:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Add check for cstate
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <quic_jesszhan@quicinc.com>, <ville.syrjala@linux.intel.com>,
        <yang.lee@linux.alibaba.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W-0oiKh5bFbTd5KjY0sWwCZq1_tqM6nB
X-Proofpoint-GUID: W-0oiKh5bFbTd5KjY0sWwCZq1_tqM6nB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_10,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2022 12:05 AM, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer,
> it should be better to check cstate
> in order to avoid the NULL pointer dereference
> in __drm_atomic_helper_crtc_reset.

You have wrapped around your lines too short. Please try to utilize the 
full word limit for each line.

With that fixed,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> 
> Fixes: 1cff7440a86e ("drm/msm: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 13ce321283ff..22c2787b7b38 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -968,7 +968,10 @@ static void dpu_crtc_reset(struct drm_crtc *crtc)
>   	if (crtc->state)
>   		dpu_crtc_destroy_state(crtc, crtc->state);
>   
> -	__drm_atomic_helper_crtc_reset(crtc, &cstate->base);
> +	if (cstate)
> +		__drm_atomic_helper_crtc_reset(crtc, &cstate->base);
> +	else
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);
>   }
>   
>   /**
