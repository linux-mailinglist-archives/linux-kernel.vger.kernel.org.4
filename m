Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5864BE95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiLMVhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiLMVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:37:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74AE096;
        Tue, 13 Dec 2022 13:37:51 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDJL4cK021414;
        Tue, 13 Dec 2022 21:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mEJGbVQ4YAj8MitwrH5vAkyQVtyHiP0YPpO4KnP5Thg=;
 b=ceM5FcYNszAw1YE5UkIPSf0DuxcBpqO/KUXUfXPGXjbIzyEmb33sjLAY3RiRfeheuREN
 BfsLcdd4Ccc4EOczIQyPnSBC6DH6+eGk4SClf55lvnMtPLRYqIUunv6m4Ya0/+j0H0EK
 nSDFZytW6VaAVttAxwWzqGOfyHLdnRlw0wbbz51lzw+Jq/lGH6VdPK0mtggo5LR7Fyuk
 yvFPfu2P5o1TmDMnvcSV3418Ct62QzFEJTxw4T+ONmtFcKAiVL3YHivLVZhHr1KWvTIG
 JwqQonswZ1KmDQg62N3ff52Ytq23OJtqUHREjbHA6LiRR9J+KbiE1fMffjn3XbKSIh69 Uw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meyfkgctt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 21:37:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDLbH4b014410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 21:37:17 GMT
Received: from [10.111.167.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 13:37:15 -0800
Message-ID: <e055af1a-908c-2628-fd7b-531210163789@quicinc.com>
Date:   Tue, 13 Dec 2022 13:37:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Add check for pstates
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <quic_jesszhan@quicinc.com>, <ville.syrjala@linux.intel.com>,
        <yang.lee@linux.alibaba.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221206080236.43687-1-jiasheng@iscas.ac.cn>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221206080236.43687-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1VEralEEiHfngy7W9tqwnK9KYxi7n8EW
X-Proofpoint-ORIG-GUID: 1VEralEEiHfngy7W9tqwnK9KYxi7n8EW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212130187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2022 12:02 AM, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer,
> it should be better to check pstates
> in order to avoid the NULL pointer dereference.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Once again, your lines are wrapped around too early, please use the full 
character limit for the commit text.

With that fixed,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 13ce321283ff..f51cb46ecfd6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1150,6 +1150,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>   	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
>   
>   	pstates = kzalloc(sizeof(*pstates) * DPU_STAGE_MAX * 4, GFP_KERNEL);
> +	if (!pstates)
> +		return -ENOMEM;
>   
>   	if (!crtc_state->enable || !crtc_state->active) {
>   		DRM_DEBUG_ATOMIC("crtc%d -> enable %d, active %d, skip atomic_check\n",
