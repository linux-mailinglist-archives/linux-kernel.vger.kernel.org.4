Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753226774A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAWEbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjAWEbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:31:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D651A949;
        Sun, 22 Jan 2023 20:31:27 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N4TMlU009887;
        Mon, 23 Jan 2023 04:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RGnWmcYmRpDUDAVXudOkcEb+Itdsk4WK80t8GliST8Q=;
 b=iIwSV7A9feszg8qUXHbCenTTe+MIYaa18YSWyvj87cnqp0YN3q9EHlN28iHWYakcvID6
 1ZSW9fH157DrFUuD1C1DbSmRfhBcJJzkcfioBkG9XrdZfFLDcWTM5KwOWw1zx6sW8dgz
 uqojws1YEp0SLwc+YqQILEYoan25jIr8thNfgUBdHhzG1wbvP7aBQEPaPEt2M1eig/hW
 v/sRu3XsPYeF424e3tKCglgudG6cmucdaqUujTBmzmS0361g65mTRQrRUhSblOBHK15N
 cuiafT1htcqQ9JkJDt75S6q0oi0+bwYBhpoThag31pZPNXmk3IbTF3c8EL29U2pJ+Noi Vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89f5a8f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 04:31:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30N4V9XX022834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 04:31:09 GMT
Received: from [10.131.116.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 22 Jan
 2023 20:31:04 -0800
Message-ID: <5c2442d3-1f65-9106-2ef4-d6beec159538@quicinc.com>
Date:   Mon, 23 Jan 2023 10:00:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
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
 <5897497.lOV4Wx5bFT@g550jk>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <5897497.lOV4Wx5bFT@g550jk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jnjnRNsqrBfqY-7WRewipyXRPIjLc5va
X-Proofpoint-GUID: jnjnRNsqrBfqY-7WRewipyXRPIjLc5va
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_02,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230042
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/2023 5:45 AM, Luca Weiss wrote:
> Hi Rajendra,
> 
> On Dienstag, 20. September 2022 13:15:15 CET Rajendra Nayak wrote:
>> GDSCs cannot be transitioned into a Retention state in SW.
>> When either the RETAIN_MEM bit, or both the RETAIN_MEM and
>> RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
>> takes care of retaining the memory/logic for the domain when
>> the parent domain transitions to power collapse/power off state.
>>
>> On some platforms where the parent domains lowest power state
>> itself is Retention, just leaving the GDSC in ON (without any
>> RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
>> it to Retention.
>>
>> The existing logic handling the PWRSTS_RET seems to set the
>> RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
>> but then explicitly turns the GDSC OFF as part of _gdsc_disable().
>> Fix that by leaving the GDSC in ON state.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>> v3:
>> Updated changelog
>>
>> There are a few existing users of PWRSTS_RET and I am not
>> sure if they would be impacted with this change
>>
>> 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
>> gdsc is actually transitioning to OFF and might be left
>> ON as part of this change, atleast till we hit system wide
>> low power state.
>> If we really leak more power because of this
>> change, the right thing to do would be to update .pwrsts for
>> mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
>> I dont have a msm8974 hardware, so if anyone who has can report
>> any issues I can take a look further on how to fix it.
> 
> Unfortunately indeed this patch makes problems on msm8974, at least on
> fairphone-fp2 hardware.
> 
> With this patch in place, the screen doesn't initialize correctly in maybe 80%
> of boots and is stuck in weird states, mostly just becomes completely blue.
> 
> Kernel log at least sometimes includes messages like this:
> [   25.847541] dsi_cmds2buf_tx: cmd dma tx failed, type=0x39, data0=0x51,
> len=8, ret=-110
> 
> Do you have anything I can try on msm8974? For now, reverting this patch makes
> display work again on v6.1

hmm, I was really expecting this to leak more power than break anything functionally,
Did you try moving to PWRSTS_OFF_ON instead of PWRSTS_RET_ON for mdss_gdsc?

> 
> Regards
> Luca
> 
>>
>> 2. gpu_gx_gdsc in gpucc-msm8998.c and
>>     gpu_gx_gdsc in gpucc-sdm660.c
>> Both of these seem to add support for 3 power state
>> OFF, RET and ON, however I dont see any logic in gdsc
>> driver to handle 3 different power states.
>> So I am expecting that these are infact just transitioning
>> between ON and OFF and RET state is never really used.
>> The ideal fix for them would be to just update their resp.
>> .pwrsts to PWRSTS_OFF_ON only.
>>
>>   drivers/clk/qcom/gdsc.c | 10 ++++++++++
>>   drivers/clk/qcom/gdsc.h |  5 +++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index d3244006c661..ccf63771e852 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -368,6 +368,16 @@ static int _gdsc_disable(struct gdsc *sc)
>>   	if (sc->pwrsts & PWRSTS_OFF)
>>   		gdsc_clear_mem_on(sc);
>>
>> +	/*
>> +	 * If the GDSC supports only a Retention state, apart from ON,
>> +	 * leave it in ON state.
>> +	 * There is no SW control to transition the GDSC into
>> +	 * Retention state. This happens in HW when the parent
>> +	 * domain goes down to a Low power state
>> +	 */
>> +	if (sc->pwrsts == PWRSTS_RET_ON)
>> +		return 0;
>> +
>>   	ret = gdsc_toggle_logic(sc, GDSC_OFF);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index 5de48c9439b2..981a12c8502d 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -49,6 +49,11 @@ struct gdsc {
>>   	const u8			pwrsts;
>>   /* Powerdomain allowable state bitfields */
>>   #define PWRSTS_OFF		BIT(0)
>> +/*
>> + * There is no SW control to transition a GDSC into
>> + * PWRSTS_RET. This happens in HW when the parent
>> + * domain goes down to a low power state
>> + */
>>   #define PWRSTS_RET		BIT(1)
>>   #define PWRSTS_ON		BIT(2)
>>   #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
> 
> 
> 
> 
