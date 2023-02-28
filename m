Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA866A60A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjB1Us5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjB1Usy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:48:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956A34333;
        Tue, 28 Feb 2023 12:48:35 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SFbwrD031707;
        Tue, 28 Feb 2023 20:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cMcsB6IjgClEAqgzly0IrK/kN3Jvv5YLBKrWz3dxJyU=;
 b=b9L5A0xY5hifPDUBjbOK8jMpkk+FX8loiUeMO4bJGry4VhcdwIBK+tV/nckbH0JP/kc2
 Z1jwXNJE6Y7Cqi+dNYY0juuBwdkXq9UsXdj16QDqXw4XAB3zKi+ZOOlh/XEM07ECd5fh
 yInoAVS28rwSIAjwamTfQ+En7Ke3pEAY+jDYR1w65V/GRVioQUOhvUFiEDU8QBblk6gW
 xIxi5TOkpNq1U+6QIKEZdYBdL89ynGKdCaHRh4HRRLhuCE9nmU9tgqdIMhcWPjgzT9pq
 uGRm/hc/yRb5+ckU7aXm4hyN+0objn07zdzyLovY+ghiSIAbyoC3r2fcs+HlcP7m6+PC bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p17ryu10w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 20:48:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31SKmPgG009295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 20:48:25 GMT
Received: from [10.216.38.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 12:48:18 -0800
Message-ID: <5a8a7fa1-bba3-50a2-aa39-83d342ba70c1@quicinc.com>
Date:   Wed, 1 Mar 2023 02:18:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH v3 04/15] drm/msm/a6xx: Extend and explain
 UBWC config
Content-Language: en-US
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Rob Clark <robdclark@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
 <20230223-topic-gmuwrapper-v3-4-5be55a336819@linaro.org>
 <e19b5cd7-9125-a285-accc-ecf530804cfc@quicinc.com>
 <487a6890-4b8f-d541-e074-5d3ab7424678@linaro.org>
 <26953463-dae1-0f07-9e4e-0314ee8ea81a@quicinc.com>
In-Reply-To: <26953463-dae1-0f07-9e4e-0314ee8ea81a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -3SUEj9ZNx1T2QD_JmwOiFrQVvrUeCeH
X-Proofpoint-GUID: -3SUEj9ZNx1T2QD_JmwOiFrQVvrUeCeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280171
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 2:14 AM, Akhil P Oommen wrote:
> On 3/1/2023 2:10 AM, Konrad Dybcio wrote:
>> On 28.02.2023 21:23, Akhil P Oommen wrote:
>>> On 2/23/2023 5:36 PM, Konrad Dybcio wrote:
>>>> Rename lower_bit to hbb_lo and explain what it signifies.
>>>> Add explanations (wherever possible to other tunables).
>>>>
>>>> Sort the variable definition and assignment alphabetically.
>>> Sorting based on decreasing order of line length is more readable, isn't it?
>> I can do that.
>>
>>>> Port setting min_access_length, ubwc_mode and hbb_hi from downstream.
>>>> Set default values for all of the tunables to zero, as they should be.
>>>>
>>>> Values were validated against downstream and will be fixed up in
>>>> separate commits so as not to make this one even more messy.
>>>>
>>>> A618 remains untouched (left at hw defaults) in this patch.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 ++++++++++++++++++++++++++++-------
>>>>  1 file changed, 45 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index c5f5d0bb3fdc..bdae341e0a7c 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -786,39 +786,74 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>>>>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>>>  {
>>>>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>>> -	u32 lower_bit = 2;
>>>> +	/* Unknown, introduced with A640/680 */
>>>>  	u32 amsbc = 0;
>>>> +	/*
>>>> +	 * The Highest Bank Bit value represents the bit of the highest DDR bank.
>>>> +	 * We then subtract 13 from it (13 is the minimum value allowed by hw) and
>>>> +	 * write the lowest two bits of the remaining value as hbb_lo and the
>>>> +	 * one above it as hbb_hi to the hardware. The default values (when HBB is
>>>> +	 * not specified) are 0, 0.
>>>> +	 */
>>>> +	u32 hbb_hi = 0;
>>>> +	u32 hbb_lo = 0;
>>>> +	/* Whether the minimum access length is 64 bits */
>>>> +	u32 min_acc_len = 0;
>>>> +	/* Unknown, introduced with A650 family, related to UBWC mode/ver 4 */
>>>>  	u32 rgb565_predicator = 0;
>>>> +	/* Unknown, introduced with A650 family */
>>>>  	u32 uavflagprd_inv = 0;
>>>> +	/* Entirely magic, per-GPU-gen value */
>>>> +	u32 ubwc_mode = 0;
>>>>  
>>>>  	/* a618 is using the hw default values */
>>>>  	if (adreno_is_a618(adreno_gpu))
>>>>  		return;
>>>>  
>>>> -	if (adreno_is_a640_family(adreno_gpu))
>>>> +	if (adreno_is_a619(adreno_gpu)) {
>>>> +		/* HBB = 14 */
>>>> +		hbb_lo = 1;
>>>> +	}
>>>> +
>>>> +	if (adreno_is_a630(adreno_gpu)) {
>>>> +		/* HBB = 15 */
>>>> +		hbb_lo = 2;
>>>> +	}
>>>> +
>>>> +	if (adreno_is_a640_family(adreno_gpu)) {
>>>>  		amsbc = 1;
>>>> +		/* HBB = 15 */
>>>> +		hbb_lo = 2;
>>>> +	}
>>>>  
>>>>  	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
>>>> -		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>>>> -		lower_bit = 3;
>>>>  		amsbc = 1;
>>>> +		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>>>> +		/* HBB = 16 */
>>>> +		hbb_lo = 3;
>>>>  		rgb565_predicator = 1;
>>>>  		uavflagprd_inv = 2;
>>>>  	}
>>>>  
>>>>  	if (adreno_is_7c3(adreno_gpu)) {
>>>> -		lower_bit = 1;
>>>>  		amsbc = 1;
>>>> +		/* HBB is unset in downstream DTS, defaulting to 0 */
>>> This is incorrect. For 7c3 hbb value is 14. So hbb_lo should be 1. FYI, hbb configurations were moved to the driver from DT in recent downstream kernels.
>> Right, seems to have happened with msm-5.10. Though a random kernel I
>> grabbed seems to suggest it's 15 and not 14?
>>
>> https://github.com/sonyxperiadev/kernel/blob/aosp/K.P.1.0.r1/drivers/gpu/msm/adreno-gpulist.h#L1710
> We override that with 14 in a6xx_init() for LP4 platforms dynamically. Since 7c3 is only supported on LP4, we can hardcode 14 here.
> In the downstream kernel, there is an api (of_fdt_get_ddrtype()) to detect ddrtype. If we can get something like that in upstream, we should implement a similar logic here.
>
> -Akhil.
Also, I haven't closely reviewed other targets configuration you updated, but it is a good idea to leave the existing configurations here as it in this refactor patch. Any update should be a separate patch.

-Akhil.
>> Konrad
>>> -Akhil.
>>>>  		rgb565_predicator = 1;
>>>>  		uavflagprd_inv = 2;
>>>>  	}
>>>>  
>>>>  	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
>>>> -		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
>>>> -	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
>>>> -	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
>>>> -		uavflagprd_inv << 4 | lower_bit << 1);
>>>> -	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
>>>> +		  rgb565_predicator << 11 | hbb_hi << 10 | amsbc << 4 |
>>>> +		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
>>>> +
>>>> +	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, hbb_hi << 4 |
>>>> +		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
>>>> +
>>>> +	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, hbb_hi << 10 |
>>>> +		  uavflagprd_inv << 4 | min_acc_len << 3 |
>>>> +		  hbb_lo << 1 | ubwc_mode);
>>>> +
>>>> +	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, min_acc_len << 23 | hbb_lo << 21);
>>>>  }
>>>>  
>>>>  static int a6xx_cp_init(struct msm_gpu *gpu)
>>>>

