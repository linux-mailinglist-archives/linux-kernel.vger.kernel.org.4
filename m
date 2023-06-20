Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCC7376C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFTVjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFTViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:38:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E40A198C;
        Tue, 20 Jun 2023 14:38:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KLVUi4018994;
        Tue, 20 Jun 2023 21:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kgTqDaiUlU680h1L2l3P5h01iVJRRmxt1P4bBioznLo=;
 b=BreyhlR+POrUrp9Zx8LqQuhPKGhP9tcSlYUOslIu3OGQ/M2gbrTpSfl4cgBFQ1DH1uK2
 kO/8Wx8/akPe/0tbdowrsWwAJANztxu88vSTMcWGDAT4O3QWy/612H4q84Pum9lE+G5G
 oS6ZdWvMSfI5CZRYyRVGZZZsB9C2h+TkzZ+kas/JEoqcGNYZoFHMg+9qnm66QFEBi6xW
 Zlwvvzfxdoaz63knjN+mHnrr5YpfbDQA//t+cnwS/4QrDeSu6VH8d/j4MpwWX2eKkf/L
 k7oIx+Iu8UPRTfy538uaBEbU8+XfZbFhdAfdSmr58jUOxPNQbL9ZiC3ytSZoJD3pM4EC JQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb1dtjjm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 21:38:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KLcZQC007402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 21:38:35 GMT
Received: from [10.71.110.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 14:38:34 -0700
Message-ID: <f14f2c31-38c2-0600-3a29-17e83afececf@quicinc.com>
Date:   Tue, 20 Jun 2023 14:38:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/3] drm/msm/dpu: Set DATABUS_WIDEN on command mode
 encoders
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
CC:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-2-c7069f2efca1@quicinc.com>
 <c74c9e0e-d059-f0e3-4350-03089c37131a@linaro.org>
 <cce68370-3fd9-4c9a-258e-af0d5d057fda@quicinc.com>
 <n2c5qlujxhbbj2aqlgj7fetzoteood5h4hmbwt4mapi77xlvmt@bpourzaideti>
 <81a5e241-ec82-7414-8752-4ce3cb084959@linaro.org>
Content-Language: en-US
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <81a5e241-ec82-7414-8752-4ce3cb084959@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j_juRtT131u30ffz9QIh8PJY3gI1yia3
X-Proofpoint-GUID: j_juRtT131u30ffz9QIh8PJY3gI1yia3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=912 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200195
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2023 5:35 PM, Dmitry Baryshkov wrote:
> On 17/06/2023 00:54, Marijn Suijten wrote:
>> On 2023-06-16 14:18:39, Abhinav Kumar wrote:
>>>
>>>
>>> On 6/14/2023 12:56 AM, Dmitry Baryshkov wrote:
>>>> On 14/06/2023 04:57, Jessica Zhang wrote:
>>>>> Add a DPU INTF op to set the DATABUS_WIDEN register to enable the
>>>>> databus-widen mode datapath.
>>>>>
>>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>>> ---
>>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
>>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 12 
>>>>> ++++++++++++
>>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  3 +++
>>>>>    3 files changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>>> index b856c6286c85..124ba96bebda 100644
>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>>> @@ -70,6 +70,9 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>>>>>        if (intf_cfg.dsc != 0 && 
>>>>> phys_enc->hw_intf->ops.enable_compression)
>>>>>            
>>>>> phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
>>>>> +
>>>>> +    if (phys_enc->hw_intf->ops.enable_widebus)
>>>>> +        phys_enc->hw_intf->ops.enable_widebus(phys_enc->hw_intf);
>>>>
>>>> No. Please provide a single function which takes necessary
>>>> configuration, including compression and wide_bus_enable.
>>>>
>>>
>>> There are two ways to look at this. Your point is coming from the
>>> perspective that its programming the same register but just a different
>>> bit. But that will also make it a bit confusing.
> 
> My point is to have a high-level function that configures the INTF for 
> the CMD mode. This way it can take a structure with necessary 
> configuration bits.

Hi Dmitry,

After discussing this approach with Abhinav, we still have a few 
questions about it:

Currently, only 3 of the 32 bits for INTF_CONFIG2 are being used (the 
rest are reserved with no plans of being programmed in the future). Does 
this still justify the use of a struct to pass in the necessary 
configuration?

In addition, it seems that video mode does all its INTF_CONFIG2 
configuration separately in dpu_hw_intf_setup_timing_engine(). If we 
have a generic set_intf_config2() op, it might be good to have it as 
part of a larger cleanup where we have both video and command mode use 
the generic op. What are your thoughts on this?

Thanks,

Jessica Zhang

> 
>>>
>>> So lets say the function is called intf_cfg2_xxx(..., bool widebus, bool
>>> data_compress)
>>>
>>> Now for the caller who wants to just enable widebus this will be
>>>
>>> intf_cfg2_xxx(....., true, false)
>>>
>>> if we want to do both
>>>
>>> intf_cfg2_xxx(...., true, true)
>>>
>>> the last one where we want to do just data_compress(highly unlikely and
>>> not recommended)
>>>
>>> intf_cfg2_xxx(...., false, true)
>>>
>>> Now someone looking at the code will have to go and find out what each
>>> bool is.
>>>
>>> Whereas with separate ops, its kind of implicit.
>>
>> That's why you never pass bools as function argument (edge-case if it is
>> the only argument, and its meaning becomes clear from the function
>> name).  Use enumerations anywhere else.
>>
>> - Marijn
>>
>>>
>>> For that reason, I dont think this patch is bad at all.
> 
> -- 
> With best wishes
> Dmitry
> 
