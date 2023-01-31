Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77006828AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjAaJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjAaJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:23:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754642D50;
        Tue, 31 Jan 2023 01:23:50 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V88akb027835;
        Tue, 31 Jan 2023 09:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hxOCwGxpA1TRbKoE7GvTV0+56lZEbEuHNc10QcdY+S8=;
 b=na/69P/AZ1KuUYfIGv6F7B0ZtNLAGf/eyIMN3sCOv+fyXzJN78DQJVobDSy1WiTbadkf
 icJ1JLhVzvEYqhQ+ppnXCjkIB0l52H9eq/DnMPF+7WA9U/10TaagLEoVqvAFhzpifq2c
 RVgyWTjUGHo1TFvlwHXWo8kvlk4qQ+NpF0g51r12agYVoMsgm0Jb1elVIMmTZsTHBH8G
 9s6pywI9laEcjCIHlcw2Z4OlzMhTjcDbkvFDqCZ+PrVAo+X0DAmMNH/iyqofFl+SsqgL
 ek/7Mm6SD+aXoYtkHKdy8hHoKs1RNbGnf6zQ2rDoYUmrbi2wOSwWPWk5r69PzSYK8kq+ ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nexn8g7g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:23:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V9NUIX003411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:23:30 GMT
Received: from [10.50.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 01:23:22 -0800
Message-ID: <c761f718-7dd5-153e-eb1f-a4de0d2ab88a@quicinc.com>
Date:   Tue, 31 Jan 2023 14:53:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-7-quic_devipriy@quicinc.com>
 <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
 <0e5e2d46-3578-678b-5980-ecf68f9a5f18@gmail.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <0e5e2d46-3578-678b-5980-ecf68f9a5f18@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qcR2h1pEbJRC0sCo7WaxhouyyLPtWGd_
X-Proofpoint-ORIG-GUID: qcR2h1pEbJRC0sCo7WaxhouyyLPtWGd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310082
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review the patch!

On 1/13/2023 9:47 PM, Robert Marko wrote:
> 
> On 13. 01. 2023. 16:20, Konrad Dybcio wrote:
>>
>> On 13.01.2023 15:36, devi priya wrote:
>>> Included CLK_IS_CRITICAL flag which helps to properly enable
>>> the APSS PLL during bootup.
>> Please describe the issue and not only the user-visible impact it
>> makes. Does the PLL get shut down by clk_ignore_unused? Maybe you
>> would be interested in the sync_state changes that landed in recent
>> -next that may solve it for you?
>>
>> I don't think it should be always-on, as you have an alternate source
>> for low power modes, adding CLK_IS_CRITICAL will keep the PLL enabled
>> even if you're not using it.
> 
> I have the same opinion, as this is working fine on IPQ6018 and IPQ8074
> and I have not experienced any issues with it.
> 
Sure, will drop the critical flag
>>
>>> clk_rcg2_ops should be used for APSS clock RCG, as other ops
>>> will not configure the RCG register
>> RCG register meaning RCG register*s*, meaning in this case M/N/D
>> which would be required for proper rate setting and not only input
>> switching (which arguably doesn't seem to be of much concern on a
>> single-parent clock)? This all is not obvious..
> Same question from me as well, why do you need clk_rcg2_ops with
> a dummy frequency table since this is just a mux using RCG2 control
> bits?
> 
> Regards,
> Robert
>>
The RCGR is used for source selection whereas the rate setting is done 
by configuring the PLL. The source is configured in the RCGR using the 
source entry (P_APSS_PLL_EARLY) added to the frequency table.

>> Konrad
>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/apss-ipq-pll.c | 1 +
>>>   drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c 
>>> b/drivers/clk/qcom/apss-ipq-pll.c
>>> index dd0c01bf5a98..75486a124fcd 100644
>>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>>> @@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
>>>               },
>>>               .num_parents = 1,
>>>               .ops = &clk_alpha_pll_huayra_ops,
>>> +            .flags = CLK_IS_CRITICAL,
>>>           },
>>>       },
>>>   };
>>> diff --git a/drivers/clk/qcom/apss-ipq6018.c 
>>> b/drivers/clk/qcom/apss-ipq6018.c
>>> index f2f502e2d5a4..0d0e7196a4dc 100644
>>> --- a/drivers/clk/qcom/apss-ipq6018.c
>>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>>> @@ -33,15 +33,21 @@ static const struct parent_map 
>>> parents_apcs_alias0_clk_src_map[] = {
>>>       { P_APSS_PLL_EARLY, 5 },
>>>   };
>>> +static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
>>> +    { .src = P_APSS_PLL_EARLY, .pre_div = 1 },
>>> +    { }
>>> +};
>>> +
>>>   static struct clk_rcg2 apcs_alias0_clk_src = {
>>>       .cmd_rcgr = 0x0050,
>>> +    .freq_tbl = ftbl_apcs_alias0_clk_src,
>>>       .hid_width = 5,
>>>       .parent_map = parents_apcs_alias0_clk_src_map,
>>>       .clkr.hw.init = &(struct clk_init_data){
>>>           .name = "apcs_alias0_clk_src",
>>>           .parent_data = parents_apcs_alias0_clk_src,
>>>           .num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
>>> -        .ops = &clk_rcg2_mux_closest_ops,
>>> +        .ops = &clk_rcg2_ops,
>>>           .flags = CLK_SET_RATE_PARENT,
>>>       },
>>>   };
>>
Best Regards,
Devi Priya
