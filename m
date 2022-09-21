Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD75BFA20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIUJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIUJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:06:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25BE52FF5;
        Wed, 21 Sep 2022 02:05:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L8dpBx030723;
        Wed, 21 Sep 2022 09:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jiKQKRTHilc+sqjPrmvm2cyR4cPqWK1fimB0Jyspfso=;
 b=I4orHwJEvwnT6UDirvNmCNrJja+gi30EfxzxSYenGAcZnEDyuBBE1BmFSoof0l2BmF45
 XQj00cUBLX3ZtAG95k3UYj5Cbj6z2oAjeKE2q/t0gD17rDlf9Y7RBcTlirJcQPJnxTLF
 MpOoL3brQvzvQeqwnwgrZEtx49aBT/55uXLynwyi66ZssnENczUGhGK4WB3d1qhUPLR3
 3mwaIW3e0FehYWZJNg17XsKsh7lUS1XbC0TKFGJH2cztVsUDvDAwgovnBh3vJF2RDATY
 1IJLtDPLlYjEWdtmJ47zFdqOOAM1RM8RPjQrVWSJZ13vf9s58TQE2GlYP5gO0qvJg6DP Tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jqgvsbg4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 09:05:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28L95lBm013433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 09:05:47 GMT
Received: from [10.216.12.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 02:05:42 -0700
Message-ID: <4aa3c16e-fb5a-980c-feb6-883fcbff077c@quicinc.com>
Date:   Wed, 21 Sep 2022 14:35:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
 <d813e8a5-9eba-b3f7-2eee-cd721d120a30@collabora.com>
 <096205ee-2c8a-facf-87ce-2309c63d2400@quicinc.com>
 <1a845259-fce2-d239-588b-a70ea5b19680@collabora.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <1a845259-fce2-d239-588b-a70ea5b19680@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IdDtZjYO1mFX1jU_jovXSaZsPUB5xqB9
X-Proofpoint-ORIG-GUID: IdDtZjYO1mFX1jU_jovXSaZsPUB5xqB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210061
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/21/2022 1:21 PM, AngeloGioacchino Del Regno wrote:
> Il 20/09/22 15:39, Rajendra Nayak ha scritto:
>>
>> On 9/20/2022 6:09 PM, AngeloGioacchino Del Regno wrote:
>>> Il 20/09/22 13:15, Rajendra Nayak ha scritto:
>>>> GDSCs cannot be transitioned into a Retention state in SW.
>>>> When either the RETAIN_MEM bit, or both the RETAIN_MEM and
>>>> RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
>>>> takes care of retaining the memory/logic for the domain when
>>>> the parent domain transitions to power collapse/power off state.
>>>>
>>>> On some platforms where the parent domains lowest power state
>>>> itself is Retention, just leaving the GDSC in ON (without any
>>>> RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
>>>> it to Retention.
>>>>
>>>> The existing logic handling the PWRSTS_RET seems to set the
>>>> RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
>>>> but then explicitly turns the GDSC OFF as part of _gdsc_disable().
>>>> Fix that by leaving the GDSC in ON state.
>>>>
>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>> v3:
>>>> Updated changelog
>>>>
>>>> There are a few existing users of PWRSTS_RET and I am not
>>>> sure if they would be impacted with this change
>>>>
>>>> 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
>>>> gdsc is actually transitioning to OFF and might be left
>>>> ON as part of this change, atleast till we hit system wide
>>>> low power state.
>>>> If we really leak more power because of this
>>>> change, the right thing to do would be to update .pwrsts for
>>>> mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
>>>> I dont have a msm8974 hardware, so if anyone who has can report
>>>> any issues I can take a look further on how to fix it.
>>>
>>> I think that the safest option is to add a PWRSTS_RET_HW_CTRL flag (or similar),
>>> used for the specific cases of SC7180 and SC7280 (and possibly others) where the
>>> GDSC is automatically transitioned to a Retention state by HW control, with no
>>> required software (kernel driver) intervention.
>>
>> Having a PWRSTS_RET_HW_CTRL flag would make sense if there was also a
>> PWRSTS_RET_SW_CTRL way of achieving Retention state, but FWIK there isn't.
>> I am sure that's the way it is on 8974 as well, I just don't have hardware to
>> confirm.
>>
>>>
>>>>
>>>> 2. gpu_gx_gdsc in gpucc-msm8998.c and
>>>>     gpu_gx_gdsc in gpucc-sdm660.c
>>>> Both of these seem to add support for 3 power state
>>>> OFF, RET and ON, however I dont see any logic in gdsc
>>>> driver to handle 3 different power states.
>>>> So I am expecting that these are infact just transitioning
>>>> between ON and OFF and RET state is never really used.
>>>> The ideal fix for them would be to just update their resp.
>>>> .pwrsts to PWRSTS_OFF_ON only.
>>>
>>> static int gdsc_init(struct gdsc *sc)
>>> {
>>>
>>>      ...
>>>
>>>      if (on || (sc->pwrsts & PWRSTS_RET))
>>>          gdsc_force_mem_on(sc);
>>>      else
>>>          gdsc_clear_mem_on(sc);
>>>
>>>      ...
>>> }
>>>
>>> On MSM8998 and SDM630/636/660, we're reaching that point with a GDSC that is
>>> left OFF from the bootloader, but we want (at least for 630/660) memretain
>>> without periph-retain: this is required to make the hypervisor happy.
>>
>> Ideally setting the memretain bits while the GDSC is OFF should have no affect
>> at all. Is this for the gpu_gx_gdsc on 630/660? Is this needed only at the init
>> time (when the bootloader has left it OFF) or is it needed everytime the kernel
>> turns it OFF too?
> 
> Even though I don't remember the flow in a clear way (this entire thing was done
> years ago), I'm sure that for PWRSTS_OFF memretain can be cleared, so, the current
> flow that we have in gdsc.c does work correctly.
> 
> Ideally, I agree with you that the memretain bits should have no effect at all
> while the GDSC is OFF, but that's the situation on these platforms.

Would you be able to test this patch on these platforms to see if we end up
with regressions?

> 
>> How did we come up with this trick to keep the hypervisor happy, was it picked
>> up from some downstream reference code?
> 
> Yes, it was found in various releases of the downstream kernel for 8998/630/660.
> 
>>
>>>
>>> Regards,
>>> Angelo
>>>
> 
