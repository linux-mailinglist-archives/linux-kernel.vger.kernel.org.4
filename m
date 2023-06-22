Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB373A4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjFVPTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjFVPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:19:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB019B7;
        Thu, 22 Jun 2023 08:19:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ME8hFi004001;
        Thu, 22 Jun 2023 15:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vYBG66qzmFxp2vLXka/Uf8FXHiZVHAxT1SFVB/3LeFs=;
 b=DItnH4BBWN+4BOe6w4kVwxpRmWnFRpiaeYvVKKGUwQUVQXagat7o9IxH8vth7R8+TAX4
 yhbSDsQnfl0glHpmyMkfDeXnolT4FEza+g0O4ckkTfcmFhyGIcSp9T6vZDXUp9GohzE7
 9Motdbs9tTcLwmLFvtnIhePMXEogHyTVcqoUXO2Xr0kUVD/fMha7oLUV+2UkiWXD+g7n
 M+nGzdBUyHotlvabeL6h84RGlJjvVBexANQB4VIBIZqix2CsBq967vVD0+AID+Tx4HRy
 l8WPWwF0iNbVeaP6OaN/tuC/VLdFQkVBMJ39HJ1X/+veQp8ONoFnzNcxVzAZ+ttFw5Za Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc0sk3aqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 15:19:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35MFJAb2021948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 15:19:10 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 22 Jun
 2023 08:19:09 -0700
Message-ID: <f2ca0d67-25e7-1313-9cea-fddb1ad28c9b@quicinc.com>
Date:   Thu, 22 Jun 2023 09:19:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/9] clk: qcom: gcc-msm8998: Control MMSS and GPUSS GPLL0
 outputs properly
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jami Kettunen <jami.kettunen@somainline.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
 <20230622-topic-8998clk-v1-3-5b7a0d6e98b1@linaro.org>
 <e880bad8-4fcb-97c1-ec9c-9122e1b550e6@quicinc.com>
 <18f508e7-8a7e-162b-4bed-eaef45147a22@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <18f508e7-8a7e-162b-4bed-eaef45147a22@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kf6rLUAL6MzwSABUrYtFGgX5TOYn69Ek
X-Proofpoint-ORIG-GUID: Kf6rLUAL6MzwSABUrYtFGgX5TOYn69Ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220129
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2023 9:05 AM, Konrad Dybcio wrote:
> On 22.06.2023 16:55, Jeffrey Hugo wrote:
>> On 6/22/2023 5:57 AM, Konrad Dybcio wrote:
>>> Up until now, we've been relying on some non-descript hardware magic
>>> to pinkypromise turn the clocks on for us. While new SoCs shine with
>>> that feature, MSM8998 can not always be fully trusted.
>>>
>>> Register the MMSS and GPUSS GPLL0 legs with the CCF to allow for manual
>>> enable voting.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/clk/qcom/gcc-msm8998.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 58 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
>>> index be024f8093c5..cccb19cae481 100644
>>> --- a/drivers/clk/qcom/gcc-msm8998.c
>>> +++ b/drivers/clk/qcom/gcc-msm8998.c
>>> @@ -25,6 +25,9 @@
>>>    #include "reset.h"
>>>    #include "gdsc.h"
>>>    +#define GCC_MMSS_MISC    0x0902C
>>> +#define GCC_GPU_MISC    0x71028
>>> +
>>>    static struct pll_vco fabia_vco[] = {
>>>        { 250000000, 2000000000, 0 },
>>>        { 125000000, 1000000000, 1 },
>>> @@ -1367,6 +1370,22 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
>>>        },
>>>    };
>>>    +static struct clk_branch gcc_mmss_gpll0_div_clk = {
>>> +    .halt_check = BRANCH_HALT_DELAY,
>>> +    .clkr = {
>>> +        .enable_reg = 0x5200c,
>>> +        .enable_mask = BIT(0),
>>> +        .hw.init = &(struct clk_init_data){
>>> +            .name = "gcc_mmss_gpll0_div_clk",
>>> +            .parent_hws = (const struct clk_hw *[]) {
>>> +                &gpll0_out_main.clkr.hw,
>>> +            },
>>> +            .num_parents = 1,
>>> +            .ops = &clk_branch2_ops,
>>> +        },
>>> +    },
>>> +};
>>> +
>>>    static struct clk_branch gcc_mmss_gpll0_clk = {
>>>        .halt_check = BRANCH_HALT_DELAY,
>>>        .clkr = {
>>> @@ -1395,6 +1414,38 @@ static struct clk_branch gcc_mss_gpll0_div_clk_src = {
>>>        },
>>>    };
>>>    +static struct clk_branch gcc_gpu_gpll0_div_clk = {
>>> +    .halt_check = BRANCH_HALT_DELAY,
>>> +    .clkr = {
>>> +        .enable_reg = 0x5200c,
>>> +        .enable_mask = BIT(3),
>>> +        .hw.init = &(struct clk_init_data){
>>> +            .name = "gcc_gpu_gpll0_div_clk",
>>> +            .parent_hws = (const struct clk_hw *[]) {
>>> +                &gpll0_out_main.clkr.hw,
>>> +            },
>>> +            .num_parents = 1,
>>> +            .ops = &clk_branch2_ops,
>>> +        },
>>> +    },
>>> +};
>>> +
>>> +static struct clk_branch gcc_gpu_gpll0_clk = {
>>> +    .halt_check = BRANCH_HALT_DELAY,
>>> +    .clkr = {
>>> +        .enable_reg = 0x5200c,
>>> +        .enable_mask = BIT(4),
>>> +        .hw.init = &(struct clk_init_data){
>>> +            .name = "gcc_gpu_gpll0_clk",
>>> +            .parent_hws = (const struct clk_hw *[]) {
>>> +                &gpll0_out_main.clkr.hw,
>>> +            },
>>> +            .num_parents = 1,
>>> +            .ops = &clk_branch2_ops,
>>> +        },
>>> +    },
>>> +};
>>> +
>>>    static struct clk_branch gcc_blsp1_ahb_clk = {
>>>        .halt_reg = 0x17004,
>>>        .halt_check = BRANCH_HALT_VOTED,
>>> @@ -3080,6 +3131,9 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
>>>        [AGGRE2_SNOC_NORTH_AXI] = &aggre2_snoc_north_axi_clk.clkr,
>>>        [SSC_XO] = &ssc_xo_clk.clkr,
>>>        [SSC_CNOC_AHBS_CLK] = &ssc_cnoc_ahbs_clk.clkr,
>>> +    [GCC_MMSS_GPLL0_DIV_CLK] = &gcc_mmss_gpll0_div_clk.clkr,
>>> +    [GCC_GPU_GPLL0_DIV_CLK] = &gcc_gpu_gpll0_div_clk.clkr,
>>> +    [GCC_GPU_GPLL0_CLK] = &gcc_gpu_gpll0_clk.clkr,
>>>    };
>>>      static struct gdsc *gcc_msm8998_gdscs[] = {
>>> @@ -3235,6 +3289,10 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
>>>        if (ret)
>>>            return ret;
>>>    +    /* Disable the GPLL0 active input to MMSS and GPU via MISC registers */
>>> +    regmap_write(regmap, GCC_MMSS_MISC, 0x10003);
>>> +    regmap_write(regmap, GCC_GPU_MISC, 0x10003);
>>
>> I wonder, does this disrupt a handoff of an active display from the bootloader to Linux?
> My phone's bootloader doesn't initialize the display, if you (or Angelo
> or Jami, +CC) could test this, it'd be wonderful.

Let me carve out some time to try it on the laptop.
