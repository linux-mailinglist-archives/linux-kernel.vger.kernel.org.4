Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A435BE74B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiITNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiITNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:40:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240ABA44C;
        Tue, 20 Sep 2022 06:40:18 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xowN027936;
        Tue, 20 Sep 2022 13:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b1e3AHVC/0qp/VyT6Kx+8h82x7dGKfCvUhxUV/Y/EOE=;
 b=KDgzzngk6WbDknh/pq/FupkNn2VGr22gzu1UVubtoAW+TZEAscWPklHaSUv57iWL39Sw
 VnxpJSIyBBgH2HnDG0kdKx+cGkT43qmUhDF2DWiLaMnf3hbrzkc0s+Hp5INkvHYzt4fr
 XPUfUKWVfA8W9COhx3hO/eKQPzYf9UcKOG+65gS3EThObvezbQjFT6vFTaSv6saBycvx
 p1ThXULOheVi7XthoeeJWSKU1ijzpGEkP9Qau9vkZCFV8B03gVLW4QJR47dzgavBUlS2
 xX4ocGFNvKc7aOH44pVqaxl8XYQAvTI9O1USYOTv4H7jZ93uvJZP8+fyQbwaT2wPkWzI 2A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpx50b3a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:40:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KDe5Y8014533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:40:05 GMT
Received: from [10.216.12.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 06:40:00 -0700
Message-ID: <096205ee-2c8a-facf-87ce-2309c63d2400@quicinc.com>
Date:   Tue, 20 Sep 2022 19:09:56 +0530
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
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <d813e8a5-9eba-b3f7-2eee-cd721d120a30@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oXxF8KOKMmDWv1zlFj3L9Hbgv8UgGvK-
X-Proofpoint-GUID: oXxF8KOKMmDWv1zlFj3L9Hbgv8UgGvK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_05,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200080
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/2022 6:09 PM, AngeloGioacchino Del Regno wrote:
> Il 20/09/22 13:15, Rajendra Nayak ha scritto:
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
> I think that the safest option is to add a PWRSTS_RET_HW_CTRL flag (or similar),
> used for the specific cases of SC7180 and SC7280 (and possibly others) where the
> GDSC is automatically transitioned to a Retention state by HW control, with no
> required software (kernel driver) intervention.

Having a PWRSTS_RET_HW_CTRL flag would make sense if there was also a
PWRSTS_RET_SW_CTRL way of achieving Retention state, but FWIK there isn't.
I am sure that's the way it is on 8974 as well, I just don't have hardware to
confirm.

> 
>>
>> 2. gpu_gx_gdsc in gpucc-msm8998.c and
>>     gpu_gx_gdsc in gpucc-sdm660.c
>> Both of these seem to add support for 3 power state
>> OFF, RET and ON, however I dont see any logic in gdsc
>> driver to handle 3 different power states.
>> So I am expecting that these are infact just transitioning
>> between ON and OFF and RET state is never really used.
>> The ideal fix for them would be to just update their resp.
>> .pwrsts to PWRSTS_OFF_ON only.
> 
> static int gdsc_init(struct gdsc *sc)
> {
> 
>      ...
> 
>      if (on || (sc->pwrsts & PWRSTS_RET))
>          gdsc_force_mem_on(sc);
>      else
>          gdsc_clear_mem_on(sc);
> 
>      ...
> }
> 
> On MSM8998 and SDM630/636/660, we're reaching that point with a GDSC that is
> left OFF from the bootloader, but we want (at least for 630/660) memretain
> without periph-retain: this is required to make the hypervisor happy.

Ideally setting the memretain bits while the GDSC is OFF should have no affect
at all. Is this for the gpu_gx_gdsc on 630/660? Is this needed only at the init
time (when the bootloader has left it OFF) or is it needed everytime the kernel
turns it OFF too?
How did we come up with this trick to keep the hypervisor happy, was it picked
up from some downstream reference code?

> 
> Regards,
> Angelo
> 
