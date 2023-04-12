Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DA6DE91C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDLBum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDLBul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:50:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6272683;
        Tue, 11 Apr 2023 18:50:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0keBK015548;
        Wed, 12 Apr 2023 01:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a2Sk2OO/jA5sTTJNE4j6qslc9o4ud7/nASEjTzby/kg=;
 b=k06ldBsHfCuOUN9bWtG1ybUc57+GvHL4M9Wr3IkfM9W4jDGwOA4jegh8fpqDCqqmmoO3
 tL4dculmqyhWYCDklPxGZqXJaEn6R17zsQnnOsWtj/iYId6xXrt3DjUysRRfZmXZHD4o
 GuDr9QQdipdhjap571oDtYXrCWyknzBrVdNbcdvYSy/wJktQG5VgspiE2fCnG7qC9OV1
 9ISppgEHRlAiLHmMlwsWbrvOAcQPrShCXsI6eSlujKLkdfhqGWwGy0pi9R9Sd3LLWu1t
 jp6lhdlmE76loTu0MaAPeMuP8JmsCEU0/p4BMaUjQboPnoIdpyLbjwihZQUWhvvYIZHz rA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw3cva1k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:50:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33C1oPl9003394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:50:25 GMT
Received: from [10.110.115.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 18:50:24 -0700
Message-ID: <49479b93-b364-d882-7a77-08223a94ed36@quicinc.com>
Date:   Tue, 11 Apr 2023 18:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: add DSC range checking during
 resource reservation
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     <freedreno@lists.freedesktop.org>, <quic_sbillaka@quicinc.com>,
        <airlied@gmail.com>, <andersson@kernel.org>, <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <agross@kernel.org>, <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <swboyd@chromium.org>,
        <sean@poorly.run>, <linux-kernel@vger.kernel.org>
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
 <qvgbm3wimai3jytnikbcixipvwqn2uywqpg4mn6mjh5atergfx@wa4edsrp7y22>
 <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
 <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yuaxNTFyxmKnrkjQkZcIqr8zdsDZ_GJP
X-Proofpoint-ORIG-GUID: yuaxNTFyxmKnrkjQkZcIqr8zdsDZ_GJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120014
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 6:06 PM, Dmitry Baryshkov wrote:
> On 12/04/2023 01:32, Abhinav Kumar wrote:
>> Hi Marijn
>>
>> On 4/11/2023 3:24 PM, Marijn Suijten wrote:
>>> Again, don't forget to include previous reviewers in cc, please :)
>>>
>>> On 2023-04-11 14:09:40, Kuogee Hsieh wrote:
>>>> Perform DSC range checking to make sure correct DSC is requested before
>>>> reserve resource for it.
> 
> nit: reserving
> 
>>>
>>> This isn't performing any range checking for resource reservations /
>>> requests: this is only validating the constants written in our catalog
>>> and seems rather useless.  It isn't fixing any real bug either, so the
>>> Fixes: tag below seems extraneous.
>>>
>>> Given prior comments from Abhinav that "the kernel should be trusted",
>>> we should remove this validation for all the other blocks instead.
>>>
>>
>> The purpose of this check is that today all our blocks in RM use the 
>> DSC_* enum as the size.
>>
>> struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
>>
>> If the device tree ends up with more DSC blocks than the DSC_* enum, 
>> how can we avoid this issue today? Not because its a bug in device 
>> tree but how many static number of DSCs are hard-coded in RM.
> 
> We don't have these blocks in device tree. And dpu_hw_catalog shouldn't 
> use indices outside of enum dpu_dsc.
> 

ah, my bad, i should have said catalog here. Okay so the expectation is 
that dpu_hw_catalog.c will program the indices to match the RM limits.

I still stand by the fact that the hardware capabilities coming from 
catalog should be trusted but this is just the SW index.

> Marijn proposed to pass struct dpu_foo_cfg directly to 
> dpu_hw_foo_init(). This will allow us to drop these checks completely.
> 

Ah okay, sure, would like to see that then uniformly get rid of these 
checks.

> For the time being, I think it might be better to add these checks for 
> DSC for the sake of uniformity.
> 

Yes, i think so too.

>>
>> And like you said, this is not specific to DSC. Such checks are 
>> present for other blocks too.
>>
>>>> Fixes: c985d7bb64ff ("drm/msm/disp/dpu1: Add DSC support in RM")
>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 10 +++++++++-
>>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c 
>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>>> index f4dda88..95e58f1 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>>> @@ -1,6 +1,7 @@
>>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>>   /*
>>>>    * Copyright (c) 2016-2018, The Linux Foundation. All rights 
>>>> reserved.
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>>> reserved.
>>>>    */
>>>>   #define pr_fmt(fmt)    "[drm:%s] " fmt, __func__
>>>> @@ -250,6 +251,11 @@ int dpu_rm_init(struct dpu_rm *rm,
>>>>           struct dpu_hw_dsc *hw;
>>>>           const struct dpu_dsc_cfg *dsc = &cat->dsc[i];
>>>> +        if (dsc->id < DSC_0 || dsc->id >= DSC_MAX) {
>>>> +            DPU_ERROR("skip dsc %d with invalid id\n", dsc->id);
>>>> +            continue;
>>>> +        }
>>>> +
>>>>           hw = dpu_hw_dsc_init(dsc->id, mmio, cat);
>>>>           if (IS_ERR_OR_NULL(hw)) {
>>>>               rc = PTR_ERR(hw);
>>>> @@ -557,8 +563,10 @@ static int _dpu_rm_make_reservation(
>>>>       }
>>>>       ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, 
>>>> &reqs->topology);
>>>> -    if (ret)
>>>> +    if (ret) {
>>>> +        DPU_ERROR("unable to find appropriate DSC\n");
>>>
>>> This, while a nice addition, should go in a different patch.
> 
> I'd agree here, a separate patch.
> 
>>>
>>> Thanks!
>>>
>>> - Marijn
>>>
>>>>           return ret;
>>>> +    }
>>>>       return ret;
>>>>   }
>>>> -- 
>>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>>> Forum,
>>>> a Linux Foundation Collaborative Project
>>>>
> 
