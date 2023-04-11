Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10996DD127
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDKEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKEvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:51:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A400173E;
        Mon, 10 Apr 2023 21:51:10 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B2Zlg2016084;
        Tue, 11 Apr 2023 04:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xEsYMOgDc5UtyBbsPqN6xODbHdfQenujILq3Mlmocak=;
 b=nLYhyyi4X2/9e/u+hd0jNETFE/yZexMOpcgni4ImqArmGK4KNhlaSUGdQmRa7PjeUV3x
 Wp19lQJWIMhCpjMX9aG02iKtdxm+rt6m3nhlSMQAbzmIGkp93koansWRu9EczfPdGC4T
 XvCF7EAlMkH6PSGvwAee4ezz3QRCusrBYDHuysC+LBO69LeuOrjodzmgiItJJVNvvZll
 +wO5GjipGnmtqvfPb0oQ/SrcDuMBlqRtbYaNCGAZAzC3txesfK30E45E3qs/vipOIFhy
 yAkVDqk8dqlu9sWFAyCkdPs6vFrpo3z3SE0bxDLO+VQanlo0+SMCDmuYVqzx4kJZInqL ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvu4srker-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 04:50:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33B4ot7n009765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 04:50:55 GMT
Received: from [10.50.52.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 21:50:50 -0700
Message-ID: <016fd82f-b0a6-d8e8-769f-ddee63d22eb4@quicinc.com>
Date:   Tue, 11 Apr 2023 10:20:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        <angelogioacchino.delregno@collabora.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
 <5c2442d3-1f65-9106-2ef4-d6beec159538@quicinc.com>
 <2619574.X9hSmTKtgW@z3ntu.xyz> <2674085.mvXUDI8C0e@z3ntu.xyz>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <2674085.mvXUDI8C0e@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mAIYpEaSCwc-TZNQqvgkDn2GNvhP0_WH
X-Proofpoint-ORIG-GUID: mAIYpEaSCwc-TZNQqvgkDn2GNvhP0_WH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_02,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110044
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 1:05 AM, Luca Weiss wrote:
> Hi Rajendra,
> 
> On Mittwoch, 1. Februar 2023 19:04:37 CEST Luca Weiss wrote:
>> On Montag, 23. Jänner 2023 05:30:55 CET Rajendra Nayak wrote:
>>> On 1/22/2023 5:45 AM, Luca Weiss wrote:
>>>> Hi Rajendra,
>>>>
>>>> On Dienstag, 20. September 2022 13:15:15 CET Rajendra Nayak wrote:
>>>>> GDSCs cannot be transitioned into a Retention state in SW.
>>>>> When either the RETAIN_MEM bit, or both the RETAIN_MEM and
>>>>> RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
>>>>> takes care of retaining the memory/logic for the domain when
>>>>> the parent domain transitions to power collapse/power off state.
>>>>>
>>>>> On some platforms where the parent domains lowest power state
>>>>> itself is Retention, just leaving the GDSC in ON (without any
>>>>> RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
>>>>> it to Retention.
>>>>>
>>>>> The existing logic handling the PWRSTS_RET seems to set the
>>>>> RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
>>>>> but then explicitly turns the GDSC OFF as part of _gdsc_disable().
>>>>> Fix that by leaving the GDSC in ON state.
>>>>>
>>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>> Cc: AngeloGioacchino Del Regno
>>>>> <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>> v3:
>>>>> Updated changelog
>>>>>
>>>>> There are a few existing users of PWRSTS_RET and I am not
>>>>> sure if they would be impacted with this change
>>>>>
>>>>> 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
>>>>> gdsc is actually transitioning to OFF and might be left
>>>>> ON as part of this change, atleast till we hit system wide
>>>>> low power state.
>>>>> If we really leak more power because of this
>>>>> change, the right thing to do would be to update .pwrsts for
>>>>> mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
>>>>> I dont have a msm8974 hardware, so if anyone who has can report
>>>>> any issues I can take a look further on how to fix it.
>>>>
>>>> Unfortunately indeed this patch makes problems on msm8974, at least on
>>>> fairphone-fp2 hardware.
>>>>
>>>> With this patch in place, the screen doesn't initialize correctly in
>>>> maybe
>>>> 80% of boots and is stuck in weird states, mostly just becomes
>>>> completely
>>>> blue.
>>>>
>>>> Kernel log at least sometimes includes messages like this:
>>>> [   25.847541] dsi_cmds2buf_tx: cmd dma tx failed, type=0x39,
>>>> data0=0x51,
>>>> len=8, ret=-110
>>>>
>>>> Do you have anything I can try on msm8974? For now, reverting this patch
>>>> makes display work again on v6.1
>>>
>>> hmm, I was really expecting this to leak more power than break anything
>>> functionally, Did you try moving to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
>>> for mdss_gdsc?
>>
>> Hi Rajendra,
>>
>> yes with this change the display init works fine again. Do you think this is
>> the intended solution then? I also haven't tested really more than this
>> simple case.
>>
>> Let me know what you think.
> 
> Any feedback on this? Would be great to get this fixed sometime soon, quite
> annoying to carry a patch for this locally.

Hi Luca, really sorry I seem to have completely missed your previous
email. Yes, moving the gdsc from PWRSTS_RET_ON to PWRSTS_OFF_ON seems to
be the right thing to do. The behavior of the RET state was same as that
of OFF prior to my patch, so the change should ideally make display go
back to having the same behavior as before.
I can certainly ack the change if you send in a patch.
thanks,
Rajendra

> 
> Regards
> Luca
> 
>>
>> Regards
>> Luca
>>
>> diff --git a/drivers/clk/qcom/mmcc-msm8974.c
>> b/drivers/clk/qcom/mmcc-msm8974.c index 26f3f8f06edf..f95e38abde13 100644
>> --- a/drivers/clk/qcom/mmcc-msm8974.c
>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
>> @@ -2389,7 +2389,7 @@ static struct gdsc mdss_gdsc = {
>>   	.pd = {
>>   		.name = "mdss",
>>   	},
>> -	.pwrsts = PWRSTS_RET_ON,
>> +	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>
>>   static struct gdsc camss_jpeg_gdsc = {
>>
>>>> Regards
>>>> Luca
>>>>
>>>>> 2. gpu_gx_gdsc in gpucc-msm8998.c and
>>>>>
>>>>>      gpu_gx_gdsc in gpucc-sdm660.c
>>>>>
>>>>> Both of these seem to add support for 3 power state
>>>>> OFF, RET and ON, however I dont see any logic in gdsc
>>>>> driver to handle 3 different power states.
>>>>> So I am expecting that these are infact just transitioning
>>>>> between ON and OFF and RET state is never really used.
>>>>> The ideal fix for them would be to just update their resp.
>>>>> .pwrsts to PWRSTS_OFF_ON only.
>>>>>
>>>>>    drivers/clk/qcom/gdsc.c | 10 ++++++++++
>>>>>    drivers/clk/qcom/gdsc.h |  5 +++++
>>>>>    2 files changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>>>> index d3244006c661..ccf63771e852 100644
>>>>> --- a/drivers/clk/qcom/gdsc.c
>>>>> +++ b/drivers/clk/qcom/gdsc.c
>>>>> @@ -368,6 +368,16 @@ static int _gdsc_disable(struct gdsc *sc)
>>>>>
>>>>>    	if (sc->pwrsts & PWRSTS_OFF)
>>>>>    	
>>>>>    		gdsc_clear_mem_on(sc);
>>>>>
>>>>> +	/*
>>>>> +	 * If the GDSC supports only a Retention state, apart from ON,
>>>>> +	 * leave it in ON state.
>>>>> +	 * There is no SW control to transition the GDSC into
>>>>> +	 * Retention state. This happens in HW when the parent
>>>>> +	 * domain goes down to a Low power state
>>>>> +	 */
>>>>> +	if (sc->pwrsts == PWRSTS_RET_ON)
>>>>> +		return 0;
>>>>> +
>>>>>
>>>>>    	ret = gdsc_toggle_logic(sc, GDSC_OFF);
>>>>>    	if (ret)
>>>>>    	
>>>>>    		return ret;
>>>>>
>>>>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>>>>> index 5de48c9439b2..981a12c8502d 100644
>>>>> --- a/drivers/clk/qcom/gdsc.h
>>>>> +++ b/drivers/clk/qcom/gdsc.h
>>>>> @@ -49,6 +49,11 @@ struct gdsc {
>>>>>
>>>>>    	const u8			pwrsts;
>>>>>    
>>>>>    /* Powerdomain allowable state bitfields */
>>>>>    #define PWRSTS_OFF		BIT(0)
>>>>>
>>>>> +/*
>>>>> + * There is no SW control to transition a GDSC into
>>>>> + * PWRSTS_RET. This happens in HW when the parent
>>>>> + * domain goes down to a low power state
>>>>> + */
>>>>>
>>>>>    #define PWRSTS_RET		BIT(1)
>>>>>    #define PWRSTS_ON		BIT(2)
>>>>>    #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
> 
> 
> 
> 
