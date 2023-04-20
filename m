Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33AE6E9B13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjDTRrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDTRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:47:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE5171D;
        Thu, 20 Apr 2023 10:47:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KHPhYA026906;
        Thu, 20 Apr 2023 17:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=piDta8ozlQhR0tbwvrizGAOrMkZ4zCOT5GG5tQ4IryM=;
 b=RG8lxROtvWoKGcOy6wldR45CLf3DQ6sNtih8ALGCJNV19NJlhaBP13VKpLNypldhXI/D
 75h1VmE42LJmF34CSnhTLSrMQaewtgtBLbaiL+gW0L/mH6AH3f6x7Hni9tFvFJv6CGcy
 dLW9m4U1hCDWgXZDumYH8iHoDCkt/bmH6IMlszme5bVDrPr/1IsTstvFWS2E1BtL9551
 e2o61P8p47MRseC1+EGNugz7tNM5Mb5rZsSys5x8oJQxqcUWZx5BnJhWI6m4kOB05s0Q
 tel/snsMvmu3M77/IP/IV+Jcyu5vTGpUNOlvo2r4/i533OfS6NCMlJ2PeOvtqZ7Vn5TY Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2p7atsdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 17:47:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KHlZSw030194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 17:47:35 GMT
Received: from [10.71.111.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 10:47:34 -0700
Message-ID: <905b4150-6e15-4172-10cf-19aa0ebf817c@quicinc.com>
Date:   Thu, 20 Apr 2023 10:47:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Freedreno] [PATCH 02/11] drm/msm/dpu: use the actual lm maximum
 width instead of a hardcoded value
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnaud Vrac <avrac@freebox.fr>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-2-d1bac46db075@freebox.fr>
 <6e807c05-a990-5692-3f84-2e4153c8c278@linaro.org>
From:   Jeykumar Sankaran <quic_jeykumar@quicinc.com>
In-Reply-To: <6e807c05-a990-5692-3f84-2e4153c8c278@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d5jpEChOYoNeyqH1Qdl_jE4iPKnTc2Ua
X-Proofpoint-ORIG-GUID: d5jpEChOYoNeyqH1Qdl_jE4iPKnTc2Ua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_13,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=901
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200148
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 3:23 PM, Dmitry Baryshkov wrote:
> On 19/04/2023 17:41, Arnaud Vrac wrote:
>> This avoids using two LMs instead of one when the display width is lower
>> than the maximum supported value. For example on MSM8996/MSM8998, the
>> actual maxwidth is 2560, so we would use two LMs for 1280x720 or
>> 1920x1080 resolutions, while one is enough.
>>
>> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> 
> While this looks correct (and following what we have in 4.4), later 
> vendor kernels specify the topology explicitly. Probably we should check 
> this with the hw guys, because it might be the following case: even 
> though a single LM can supply the mode, it will spend more power 
> compared to two LMs.
> 
> 
Yes. 2 LM split will allow the HW to run in lower mdp core clock. Can 
you maintain the split_threshold in the hw catalog until per mode 
topology is available?

Jeykumar S
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 1dc5dbe585723..dd2914726c4f6 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -53,8 +53,6 @@
>>   #define IDLE_SHORT_TIMEOUT    1
>> -#define MAX_HDISPLAY_SPLIT 1080
>> -
>>   /* timeout in frames waiting for frame done */
>>   #define DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES 5
>> @@ -568,10 +566,12 @@ static struct msm_display_topology 
>> dpu_encoder_get_topology(
>>        */
>>       if (intf_count == 2)
>>           topology.num_lm = 2;
>> -    else if (!dpu_kms->catalog->caps->has_3d_merge)
>> -        topology.num_lm = 1;
>> +    else if (dpu_kms->catalog->caps->has_3d_merge &&
>> +         dpu_kms->catalog->mixer_count > 0 &&
>> +         mode->hdisplay > dpu_kms->catalog->mixer[0].sblk->maxwidth)
>> +        topology.num_lm = 2;
>>       else
>> -        topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>> +        topology.num_lm = 1;
>>       if (crtc_state->ctm)
>>           topology.num_dspp = topology.num_lm;
>>
> 
