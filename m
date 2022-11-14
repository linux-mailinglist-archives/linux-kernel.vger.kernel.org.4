Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF56289F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiKNUAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiKNUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:00:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EA2BF1;
        Mon, 14 Nov 2022 12:00:06 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEIo38q032663;
        Mon, 14 Nov 2022 19:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sQ1nJeVmiRxwoa8l/Qgl0ojbQH6TvWVv+gIlJxEaOcU=;
 b=UMdArAdjNcVb1t1a0b0OTYp1rm4JK+N5zF9OwUdEXWsc5wa40V/koRSlGiZbv+qoIKRR
 mDYFxfeHkISseh3b9ivFU9JwT6zDaFJZd48Lc6cQ35D+AWYFBMU2DOxm64OMsFAF6a5i
 pZUbo6D7rrzQe5ZFQUrdv5ruFSW4kKdD/We6eEETNDVg6flrvKzPciPyonwWaQRlVHMj
 6OX1DFHC8Rq58a0VOfQ9BntkX+vdva+THp1L/GRh6EbOIex8ETmDypRuQQ1eva0+mcJx
 ypiH0NVZ8Qa3sOw+MGwBjeX4KBlu0xI4I/mQPeoPs4fus7lbjIYmV1u9bvLGm16NmYh5 +A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kut23gfa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 19:59:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEJxtc5028627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 19:59:55 GMT
Received: from [10.216.50.94] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 14 Nov
 2022 11:59:50 -0800
Message-ID: <97429a67-e763-4226-828c-8381a2abe9f9@quicinc.com>
Date:   Tue, 15 Nov 2022 01:29:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "Rob Clark" <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221114194133.1535178-1-robdclark@gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20221114194133.1535178-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -M5lczxghDAPoBbgTMz1x9Z-AWpRgyJo
X-Proofpoint-ORIG-GUID: -M5lczxghDAPoBbgTMz1x9Z-AWpRgyJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2022 1:11 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> If we get an error (other than -ENOENT) we need to propagate that up the
> stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up with
> whatever OPP(s) are represented by bit zero.
>
> Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 7fe60c65a1eb..96de2202c86c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1956,7 +1956,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
>   		DRM_DEV_ERROR(dev,
>   			      "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
I just noticed and was going to send a similar fix. We should remove ". 
Some OPPs may not be supported by hardware" here.

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

Btw, on msm-next-external-fixes + this fix,  I still see boot up issue 
in herobrine due to drm_dev_alloc() failure with -ENOSPC error.

-Akhil.
>   			      ret);
> -		goto done;
> +		return ret;
>   	}
>   
>   	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);

