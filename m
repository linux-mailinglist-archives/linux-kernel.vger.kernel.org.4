Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3966BD5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCPQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCPQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:38:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF9B1B06;
        Thu, 16 Mar 2023 09:37:56 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDkWeE006537;
        Thu, 16 Mar 2023 16:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5YnHe0TsPIDAxPLrToTdrq6vXixOvJdvf1Ep+qvpJWQ=;
 b=hPXHZD8XZf7RtYJUzBvc7dSeOTBZL2z8FxE+yxB1x96FfpMfy1Yd2j6RdHK4dmWGeA3G
 tF5sLpZ496783IfMdowp6r0hjUttLwhi1O3dBt7/mnMRZXyWqFOBoxFAHN6wFRVwoc18
 Wc5iFMe6R5SGwFAz0VaBzUidUGlKwNj/SyoVfN/bZQgsCuy5e612I8gSgKaUVo1+BwDC
 mWxGN7WgrVJPC53RsQ+kmwoRmqO2ETy9fr1ZbEWlDe8+g2/vf3EljeWxzEFL5uftAc0j
 Fzto/DhV9EkZOWRJb1UbCchyWPHrNJyk5FExMhiKqmPDQPhJ+/pHBC2QJg+ZBFHoBRVS +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc49u8hrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 16:36:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GGaRRn031040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 16:36:27 GMT
Received: from [10.110.64.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Mar
 2023 09:36:26 -0700
Message-ID: <10b39fab-43a7-40b4-5d11-bc191e2953f3@quicinc.com>
Date:   Thu, 16 Mar 2023 09:36:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [RFC PATCH 1/2] drm/msm/dpu: add dsc helper functions
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
CC:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <quic_sbillaka@quicinc.com>, <sean@poorly.run>,
        <andersson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <agross@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        <marijn.suijten@somainline.org>, <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1677267647-28672-1-git-send-email-quic_khsieh@quicinc.com>
 <741be2a3-0208-2f40-eedf-d439c4e6795b@quicinc.com>
 <F8A4FC18-C64E-4011-BC08-18EB3B95A357@linaro.org>
 <d5ee8233-66c8-9b88-417c-6cf9cc5c84fe@quicinc.com>
 <CAA8EJpro5Q-2ZpnDJt40UhFX7Zp9oBhrto=FDOERzCDR2BDPvQ@mail.gmail.com>
 <f0dfba42-4674-3748-bf5d-39f6e1745f67@quicinc.com>
 <f1a6ee82-9502-7ea5-fe48-f296fc7df497@linaro.org>
 <3e114c0f-a042-6801-69bf-67436cb2a448@quicinc.com>
 <113a10b6-6097-c80e-c29c-6f61b2b2896a@linaro.org>
 <c4c0ebf8-275d-500f-4019-e3d7517a884f@quicinc.com>
 <CAA8EJppxX4haZSwdvVbN7bc6kXAyNO1rg6zWZv9wPFdqGrcXuw@mail.gmail.com>
 <c650e746-64c5-ce6b-933d-057349356b78@quicinc.com>
 <58E03B71-20C4-4F81-96C1-6D8CE517F3FB@linaro.org>
 <fd876ad2-3fd0-eaab-3407-dd32d494f662@quicinc.com>
 <a5d1a74f-1b7a-569d-e487-774720dfae22@quicinc.com>
 <CAA8EJpq_mwUt0+1yGYo6hRx8Vz12DumVdpEjJbPk8gGHhGZ2bA@mail.gmail.com>
 <176c6088-4470-5559-e79e-fd5675db0097@quicinc.com>
 <04156713-3f8e-c29e-322f-259ae163a93a@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <04156713-3f8e-c29e-322f-259ae163a93a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SQ2BBsQqvkDL_p7Hq8CzcpLgC97BB4aU
X-Proofpoint-ORIG-GUID: SQ2BBsQqvkDL_p7Hq8CzcpLgC97BB4aU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 9:23 AM, Dmitry Baryshkov wrote:
> On 16/03/2023 18:13, Abhinav Kumar wrote:
>>
>>
>> On 3/16/2023 9:03 AM, Dmitry Baryshkov wrote:
>>> Hi,
>>>
>>> [removed previous conversation]
>>>
>>>>
>>>> Hi Dmitry and Abhinav,
>>>>
>>>> Just wanted to follow up on this thread. I've gone over the 
>>>> MSM-specific
>>>> DSC params for DP and DSI and have found a few shared calculations and
>>>> variables between both DSI and DP paths:
>>>>
>>>> - (as mentioned earlier in the thread) almost all the calculations in
>>>> dpu_dsc_populate_dsc_config() match dsi_populate_dsc_params() [1]. The
>>>> only difference in the math I'm seeing is initial_scale_value.
>>>
>>> The value in dsi code is valid for initial_offset = 6144. Please use
>>> the formula from the standard (= sde_dsc_populate_dsc_config) and add
>>> it to drm_dsc_helper.c
>>>
>>> If I remember correctly the last remaining item in
>>> dsi_populate_dsc_params() (except mentioned initial_offset) was
>>> line_buf_depth, see [3]. I'm not sure about setting it to bpc+1.
>>> According to the standard it should come from a DSC decoder spec,
>>> which means it should be set by the DSI panel driver or via
>>> drm_dp_dsc_sink_line_buf_depth() in the case of DP output.
>>>
>>>> - dsc_extra_pclk_cycle_cnt and dce_bytes_per_line, which were 
>>>> introduced
>>>> in Kuogee's v1 DSC series [2], are used for DSI, DP, and the DPU timing
>>>> engine. dsc_extra_pclk_cycle_cnt is calculated based on pclk_per_line
>>>> (which is calculated differently between DP and DSI), but
>>>> dce_bytes_per_line is calculated the same way between DP and DSI.
>>>>
>>>> To avoid having to duplicate math in 2 different places, I think it
>>>> would help to have these calculations in some msm_dsc_helper.c file. 
>>>> Any
>>>> thoughts on this?
>>>
>>> dsc_extra_pclk_cycle_cnt and dce_bytes_per_line are used only in DPU
>>> code, so they can stay in DPU driver.
>>>
>>
>> They can stay in the dpu driver is fine but where?
>>
>> Like Jessica wrote, this is computed and used in 3 places today :
>>
>> 1) DSI video engine computation
>> 2) DP controller computation
>> 3) timing engine programming
> 
> Please excuse me if I'm wrong. I checked both vendor techpack and the 
> Kuogee's patches. I see them being used only in the SDE / DPU driver 
> code. Could you please point me to the code path that we are discussing?
> 

DSI code :

https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/msm/dsi/dsi_host.c#L868

DP code:

Refer to dp_panel_dsc_pclk_param_calc in 
https://patchwork.freedesktop.org/patch/519837/?series=113240&rev=1

Timing engine:

refer to https://patchwork.freedesktop.org/patch/519838/?series=113240&rev=1

Probably confusion is due to the naming. bytes_per_line is nothing but 
bytes_per_pkt * pkt_per_line but the concept is common for DP and DSI.

+		if (phys->comp_type == MSM_DISPLAY_COMPRESSION_DSC) {
+			phys->dsc_extra_pclk_cycle_cnt = dsc_info->pclk_per_line;
+			phys->dsc_extra_disp_width = dsc_info->extra_width;
+			phys->dce_bytes_per_line =
+				dsc_info->bytes_per_pkt * dsc_info->pkt_per_line;

> 
>> So either we have a helper in a common location somewhere so that 
>> these 3 modules can call that helper and use it OR each module 
>> duplicates the computation code.
>>
>> What should be the common location is the discussion here.
>>
>> It cannot be dpu_encoder.c as the DSI/DP dont call into the encoder 
>> methods.
>>
>>>>
>>>> Thanks,
>>>>
>>>> Jessica Zhang
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/gpu/drm/msm/dsi/dsi_host.c#L1756 
>>>>
>>>>
>>>> [2] https://patchwork.freedesktop.org/patch/519845/?series=113240&rev=1
>>>
>>> [3] https://patchwork.freedesktop.org/patch/525441/?series=114472&rev=2
>>>
>>>
>>>
> 
