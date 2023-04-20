Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455BE6E9B33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjDTSBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjDTSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:01:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2BF2690;
        Thu, 20 Apr 2023 11:01:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KApQ79009099;
        Thu, 20 Apr 2023 18:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BrhaDhVfF1uWa6WlFdkk7RLZeN7A1aPmDvaJcsdkg9A=;
 b=XsXqoxjHL+/kzK9Sj4MYqrXa2gGbCwwMJK5dzjjZjo4kEMi1p94jRLaJkhAHsL1vxhcJ
 u/anEHAxYF2aOqB+A+WCwUELRJ55DJPDAdprHLUdvqhJZ8jhziKQaf8mphSkPr8X+U1O
 EmuciL4lEa5aqoeJgTnHJZjiRVXPklayXY+Ug7B3eYDrb96tDORi2njCHAIXfedj/yHk
 8a5SO5q0b6TWQuGUkBkUf7+SYj0pIzAD5lXRR3LSscmIN3KsGJ7b7+8tEh/aUTAcxRxx
 hFhSlH9lrF7jCdnRwzDRjlKM7of+sUaylRtU1EfuJ2x2yd5UEowt2W275zpK7Vt5n1jp ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2uj3t8km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 18:01:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KI15I0014252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 18:01:05 GMT
Received: from [10.71.111.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 11:01:04 -0700
Message-ID: <09477ba6-52e0-f4de-fa8c-5afb66145b58@quicinc.com>
Date:   Thu, 20 Apr 2023 11:01:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Freedreno] [PATCH 03/11] drm/msm/dpu: use hsync/vsync polarity
 set by the encoder
Content-Language: en-US
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-3-d1bac46db075@freebox.fr>
From:   Jeykumar Sankaran <quic_jeykumar@quicinc.com>
In-Reply-To: <20230419-dpu-tweaks-v1-3-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KoOnSi_WSt9CbHH9UTfOBqcmRm9_8Pv7
X-Proofpoint-ORIG-GUID: KoOnSi_WSt9CbHH9UTfOBqcmRm9_8Pv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_14,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200150
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 7:41 AM, Arnaud Vrac wrote:
> Do not override the hsync/vsync polarity passed by the encoder when
> setting up intf timings. The same logic was used in both the encoder and
> intf code to set the DP and DSI polarities, so those interfaces are not
> impacted. However for HDMI, the polarities were overriden to static
> values based on the vertical resolution, instead of using the actual
> mode polarities.
> 
Any idea why vres based static polarity override was in place? Hope you 
had tested HDMI resolutions with yres > and < than 720.

Jeykumar S.

> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 84ee2efa9c664..9f05417eb1213 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -104,7 +104,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>   	u32 active_h_start, active_h_end;
>   	u32 active_v_start, active_v_end;
>   	u32 active_hctl, display_hctl, hsync_ctl;
> -	u32 polarity_ctl, den_polarity, hsync_polarity, vsync_polarity;
> +	u32 polarity_ctl, den_polarity;
>   	u32 panel_format;
>   	u32 intf_cfg, intf_cfg2 = 0;
>   	u32 display_data_hctl = 0, active_data_hctl = 0;
> @@ -191,19 +191,9 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>   	}
>   
>   	den_polarity = 0;
> -	if (ctx->cap->type == INTF_HDMI) {
> -		hsync_polarity = p->yres >= 720 ? 0 : 1;
> -		vsync_polarity = p->yres >= 720 ? 0 : 1;
> -	} else if (ctx->cap->type == INTF_DP) {
> -		hsync_polarity = p->hsync_polarity;
> -		vsync_polarity = p->vsync_polarity;
> -	} else {
> -		hsync_polarity = 0;
> -		vsync_polarity = 0;
> -	}
>   	polarity_ctl = (den_polarity << 2) | /*  DEN Polarity  */
> -		(vsync_polarity << 1) | /* VSYNC Polarity */
> -		(hsync_polarity << 0);  /* HSYNC Polarity */
> +		(p->vsync_polarity << 1) | /* VSYNC Polarity */
> +		(p->hsync_polarity << 0);  /* HSYNC Polarity */
>   
>   	if (!DPU_FORMAT_IS_YUV(fmt))
>   		panel_format = (fmt->bits[C0_G_Y] |
> 
