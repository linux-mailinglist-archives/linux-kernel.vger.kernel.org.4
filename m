Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61E86571EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiL1B7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiL1B6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:58:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A2DE9C;
        Tue, 27 Dec 2022 17:58:38 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BS1s9vL019100;
        Wed, 28 Dec 2022 01:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0bN/yWL2tBdPrF0v4drFLgURz1fV6tzmavuK+AhfMaU=;
 b=PVGDk3tw1ys59r1q2HbJ3S7cAbhAODbU+cUOUnrPekNJOL88Vibvg8Wb4TVOp3sn5USN
 mkiieVI/Byh2BxYfS6mU5Wcv3oTETy9MU7eZ0dyQI/WBne0tpCUSv7sgVh2Q4OGCF8Uq
 28CVMb/4nw8v6Cs5XMSAAe/kkF3TFUFcW5WB6AClL8ayfpemTI2zgINxYsoL54Z2UaI+
 itudWfLfHZx1er6HMBlyMhAJ+7r5eQ25WqGSPCE7b4W7RyKVaAPLnpB4BqxVbekTVuQv
 beXTnz/H77uaGhpcITjwBrKIRqSAzcDztvSs7Jw94kJJV04DsmR7vO+Cve+NbvmIH8Ip 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mr1r1h5af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 01:58:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BS1wXqT014462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 01:58:33 GMT
Received: from [10.110.12.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 17:58:32 -0800
Message-ID: <7517fbb0-5ce8-6df0-0c6d-bc904253e334@quicinc.com>
Date:   Tue, 27 Dec 2022 17:58:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/msm/dpu: Fix memory leak in
 msm_mdss_parse_data_bus_icc_path
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221207065922.2086368-1-linmq006@gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221207065922.2086368-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lxbN2vyffXXParmMA4h0_BATU03ywTUS
X-Proofpoint-ORIG-GUID: lxbN2vyffXXParmMA4h0_BATU03ywTUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_18,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212280012
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2022 10:59 PM, Miaoqian Lin wrote:
> of_icc_get() alloc resources for path1, we should release it when not
> need anymore. Early return when IS_ERR_OR_NULL(path0) may leak path1.
> Defer getting path1 to fix this.
> 
> Fixes: b9364eed9232 ("drm/msm/dpu: Move min BW request and full BW disable back to mdss")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> changes in v2:
> - move getting path1 after error check for path0.
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index e13c5c12b775..3b8d6991b04e 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -46,15 +46,17 @@ struct msm_mdss {
>   static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
>   					    struct msm_mdss *msm_mdss)
>   {
> -	struct icc_path *path0 = of_icc_get(dev, "mdp0-mem");
> -	struct icc_path *path1 = of_icc_get(dev, "mdp1-mem");
> +	struct icc_path *path0;
> +	struct icc_path *path1;
>   
> +	path0 = of_icc_get(dev, "mdp0-mem");
>   	if (IS_ERR_OR_NULL(path0))
>   		return PTR_ERR_OR_ZERO(path0);
>   
>   	msm_mdss->path[0] = path0;
>   	msm_mdss->num_paths = 1;
>   
> +	path1 = of_icc_get(dev, "mdp1-mem");
>   	if (!IS_ERR_OR_NULL(path1)) {
>   		msm_mdss->path[1] = path1;
>   		msm_mdss->num_paths++;
