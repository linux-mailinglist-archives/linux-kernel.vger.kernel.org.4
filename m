Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7569A6DE80E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDKXcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDKXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:32:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBC30FD;
        Tue, 11 Apr 2023 16:32:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BMrem3002596;
        Tue, 11 Apr 2023 23:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1npcMitdE8C+9hBfB20mAldu5ItsF3/q/VxffhPNrN8=;
 b=TS2M5n3PsX6IzbaIPvA3uulHV0xK+pEv1VzHJXVB46wRdolYshCAdwQ9fF9AFyS+yNI/
 A7wup5siil+u7FE5SMux3IEj8fH6/uSzv2wPuQtnTCwIRbYjsNFy40BBWuscAU49wCxf
 7Le0hmEX2onYGKQaBKcVNa+jMjGcH670djFlcE+aA9er0o4cOHqCmoVq7a3CSajCr0iS
 sRAHeU7YXsO6m3VoON4N6EyBUCnTiHZbwTbETGjgY4Y7YhK7TVYPr/zymRybLwL9Wg5t
 JcIUWRi3TI/QWREdyV6+5ce6yRR9GEPdYjkLSha1P5k7hbj7PtAmrI8o0p5lRC7DhBjW Sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw9b9h173-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 23:32:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BNW9KM021764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 23:32:09 GMT
Received: from [10.110.115.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 16:32:08 -0700
Message-ID: <ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com>
Date:   Tue, 11 Apr 2023 16:32:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: always program dsc active bits
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
 <30585d08-88ca-e3a9-6f83-128d49d1d1fc@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <30585d08-88ca-e3a9-6f83-128d49d1d1fc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4CMCe5_njPXlNtP7QtoPP0XnnSvcnpyp
X-Proofpoint-ORIG-GUID: 4CMCe5_njPXlNtP7QtoPP0XnnSvcnpyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=554 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110211
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 3:17 PM, Dmitry Baryshkov wrote:
> On 12/04/2023 00:04, Kuogee Hsieh wrote:
>> In current code, the dsc active bits are set only if the cfg->dsc is set.
>> However, for displays which are hot-pluggable, there can be a use-case
>> of disconnecting a DSC supported sink and connecting a non-DSC sink.
>>
>> For those cases we need to clear DSC active bits during teardown.
> 
> Please correct me if I'm wrong here, shouldn't we start using 
> reset_intf_cfg() during teardown / unplug?
> 

This is actually a good point. Since PSR landed this cycle, we are doing 
dpu_encoder_helper_phys_cleanup() even for video mode path,

22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine 
disable")

I was doing it only for writeback path as I had not validated video mode 
enough with the dpu_encoder_helper_phys_cleanup() API.

But looking closely, I think there is an issue with the flush logic in 
that API for video mode.

The reset API, calls a ctl->ops.trigger_flush(ctl); but its getting 
called after timing engine turns off today so this wont take any effect.

We need to improve that API and add the missing pieces for it to work 
correctly with video mode and re-validate the issue for which PSR made 
that change. So needs more work there.

This change works because the timing engine is enabled right after this 
call and will trigger the flush with it.

The only drawback of this change is DSC_ACTIVE will always get written 
to either with 0 or the right value but only once during enable.

I think this change is fine till we finish the rest of the pieces. We 
can add the if (cfg->dsc) back to this when we fix the reset_intf_cfg() 
to handle DSC and dpu_encoder_helper_phys_cleanup() to handle flush 
correctly.

I will take up that work.

>>
>> Fixes: ede3c6bb00c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>> index bbdc95c..88e4efe 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>> @@ -541,10 +541,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
>> dpu_hw_ctl *ctx,
>>       if (cfg->merge_3d)
>>           DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>>                     BIT(cfg->merge_3d - MERGE_3D_0));
>> -    if (cfg->dsc) {
>> -        DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>> -        DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>> -    }
>> +
>> +    DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>> +    DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>   }
>>   static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
> 
