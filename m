Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7316E6472D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLHPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLHPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:25:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5BF0C;
        Thu,  8 Dec 2022 07:25:02 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B87MGnZ022615;
        Thu, 8 Dec 2022 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+GeiAgaKJ5dwQ8p3xRF5zkxCVzLbH4UTmNuPbP1LUoc=;
 b=bKb26sWnrvOCkHRtAwjYbKLolu6G3cW46THtYnqOKhQq+cSqjhY/NhlmWbeKz3BRrT0/
 ninrD6fm8JhZ7ixvDjWMV4vFGkfuQhc+MqRENRwmgK3keciR3Z/FFBL8o9Deo3pbEtEj
 AJ7ztIGjozwEue2SvQOvFo+ykt67LFOE/s6apSd9AxQdu/X0Pu8V4zMqaqwlLBMdfWkP
 VF7g4sHEy8y7d4yneSD3bO5TfR+vWh1lEL8mpZ3sJBXdIQi6fpNFDxVb/M0pMawsKqVt
 JdBNNM7TG/C/+dddyFLwprHFY8TfXDMgXlbE7iL52f9hdAOL1fV6AYm9AeAU56Ajxrx6 PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mbbfm9asx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 15:24:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B8FOmef001072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 15:24:48 GMT
Received: from [10.216.54.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 07:24:43 -0800
Message-ID: <76812eb1-ef4a-48b3-7b7a-231adc8c7c36@quicinc.com>
Date:   Thu, 8 Dec 2022 20:54:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v7 4/6] clk: qcom: gpucc-sc7280: Add cx collapse reset
 support
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1664960824-20951-1-git-send-email-quic_akhilpo@quicinc.com>
 <20221005143618.v7.4.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
 <CAPDyKFp8ynYSyMc+gXWuW8dC1j07X+8k3omsKKnLA_u+4X-vvA@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAPDyKFp8ynYSyMc+gXWuW8dC1j07X+8k3omsKKnLA_u+4X-vvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TUlaLqBuIWs5j1VSXPj5QJh5EoJULXTH
X-Proofpoint-ORIG-GUID: TUlaLqBuIWs5j1VSXPj5QJh5EoJULXTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_09,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080127
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2022 9:16 PM, Ulf Hansson wrote:
> On Wed, 5 Oct 2022 at 11:08, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>> Allow a consumer driver to poll for cx gdsc collapse through Reset
>> framework.
> Would you mind extending this commit message, to allow us to better
> understand what part is really the consumer part.
Sure. I can do that.
>
> I was expecting the consumer part to be the GPU (adreno) driver, but I
> may have failed to understand correctly. It would be nice to see an
> example of a typical sequence, where the reset is being
> asserted/deasserted, from the consumer point of view. Would you mind
> explaining this a bit more?
https://elixir.bootlin.com/linux/v6.1-rc8/source/drivers/gpu/drm/msm/adreno/a6xx_gpu.c#L1309
You are correct. The consumer is adreno gpu driver. When there is a gpu fault, these sequences are followed:
1. drop pm_runtime_put() for gpu device which will drops its vote on 'cx' genpd. line: 1306
2. At this point, there could be vote from either smmu driver (smmu is under same power domain too) or from other subsystems (tz/hyp).
3. So we call into gdsc driver through reset interface to poll the gdsc register to ensure it collapsed at least once. Line: 1309
4. Then we turn ON gpu. line:1314.

-Akhil.
>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Kind regards
> Uffe
>
>> ---
>>
>> (no changes since v3)
>>
>> Changes in v3:
>> - Convert 'struct qcom_reset_ops cx_gdsc_reset' to 'static const' (Krzysztof)
>>
>> Changes in v2:
>> - Minor update to use the updated custom reset ops implementation
>>
>>  drivers/clk/qcom/gpucc-sc7280.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
>> index 9a832f2..fece3f4 100644
>> --- a/drivers/clk/qcom/gpucc-sc7280.c
>> +++ b/drivers/clk/qcom/gpucc-sc7280.c
>> @@ -433,12 +433,22 @@ static const struct regmap_config gpu_cc_sc7280_regmap_config = {
>>         .fast_io = true,
>>  };
>>
>> +static const struct qcom_reset_ops cx_gdsc_reset = {
>> +       .reset = gdsc_wait_for_collapse,
>> +};
>> +
>> +static const struct qcom_reset_map gpucc_sc7280_resets[] = {
>> +       [GPU_CX_COLLAPSE] = { .ops = &cx_gdsc_reset, .priv = &cx_gdsc },
>> +};
>> +
>>  static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
>>         .config = &gpu_cc_sc7280_regmap_config,
>>         .clks = gpu_cc_sc7280_clocks,
>>         .num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
>>         .gdscs = gpu_cc_sc7180_gdscs,
>>         .num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
>> +       .resets = gpucc_sc7280_resets,
>> +       .num_resets = ARRAY_SIZE(gpucc_sc7280_resets),
>>  };
>>
>>  static const struct of_device_id gpu_cc_sc7280_match_table[] = {
>> --
>> 2.7.4
>>

