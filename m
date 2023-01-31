Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F80682891
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjAaJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAaJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:18:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C710AB3;
        Tue, 31 Jan 2023 01:17:41 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V4OLPA003361;
        Tue, 31 Jan 2023 09:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5nYgaJWsCSJ5rGq768SJ/8y1lpd2DBZK7ktGQOW3ufc=;
 b=OQiALB62RxfP7W6iXXxwqa2CHlXXvDUeP3XUGhQOn5y7OKFuxDqW3mAM8xmpX+EKXpLY
 Mf0ij0yRWR9u5VKyCs41JRQDAYlIJMea2zN9RCTnXJE3Exgb8ugmUAXAXhr129ZVcXt9
 XyXRfFs4jMuoDRrlvzesX1hEoCDQNVhCXlmRzhcmnYVSRtuLksjaFJc578gnCQ0eb1JW
 FWb2CbnqWgcjaC/vddfiWS2ut29sRWUO1pi1tDwiuKB0zzPOvl5Qr/laDqBY1on8s7yw
 TyHsLCrsALw1S1A7fbzj/yWjKS/jmBtzwOb9TqPTXHaHH8JB1pYGz7FSo0DHpGU1HnGD Ug== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neuwc8rky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:17:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V9HFVj026111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:17:15 GMT
Received: from [10.50.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 01:17:07 -0800
Message-ID: <ea0dbbf0-958c-145b-abaa-3bbcb620df5c@quicinc.com>
Date:   Tue, 31 Jan 2023 14:47:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
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
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-7-quic_devipriy@quicinc.com>
 <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TnZPL9HQgdMgllX-CoziRcCUXd3EhTPm
X-Proofpoint-ORIG-GUID: TnZPL9HQgdMgllX-CoziRcCUXd3EhTPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review the patch

On 1/13/2023 8:50 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 15:36, devi priya wrote:
>> Included CLK_IS_CRITICAL flag which helps to properly enable
>> the APSS PLL during bootup.
> Please describe the issue and not only the user-visible impact it
> makes. Does the PLL get shut down by clk_ignore_unused? Maybe you
> would be interested in the sync_state changes that landed in recent
> -next that may solve it for you?
> 
> I don't think it should be always-on, as you have an alternate source
> for low power modes, adding CLK_IS_CRITICAL will keep the PLL enabled
> even if you're not using it.
Yeah, got it. Will drop the critical flag
> 
>> clk_rcg2_ops should be used for APSS clock RCG, as other ops
>> will not configure the RCG register
> RCG register meaning RCG register*s*, meaning in this case M/N/D
> which would be required for proper rate setting and not only input
> switching (which arguably doesn't seem to be of much concern on a
> single-parent clock)? This all is not obvious..
> 
> Konrad
The source selection is done by configuring the RCGR config register 
with the source entry (P_APSS_PLL_EARLY) added to the frequency table. 
Proper rate is achieved by configuring the PLL and hence M/N/D values 
are not configured
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/apss-ipq-pll.c | 1 +
>>   drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index dd0c01bf5a98..75486a124fcd 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
>>   			},
>>   			.num_parents = 1,
>>   			.ops = &clk_alpha_pll_huayra_ops,
>> +			.flags = CLK_IS_CRITICAL,
>>   		},
>>   	},
>>   };
>> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
>> index f2f502e2d5a4..0d0e7196a4dc 100644
>> --- a/drivers/clk/qcom/apss-ipq6018.c
>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>> @@ -33,15 +33,21 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
>>   	{ P_APSS_PLL_EARLY, 5 },
>>   };
>>   
>> +static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
>> +	{ .src = P_APSS_PLL_EARLY, .pre_div = 1 },
>> +	{ }
>> +};
>> +
>>   static struct clk_rcg2 apcs_alias0_clk_src = {
>>   	.cmd_rcgr = 0x0050,
>> +	.freq_tbl = ftbl_apcs_alias0_clk_src,
>>   	.hid_width = 5,
>>   	.parent_map = parents_apcs_alias0_clk_src_map,
>>   	.clkr.hw.init = &(struct clk_init_data){
>>   		.name = "apcs_alias0_clk_src",
>>   		.parent_data = parents_apcs_alias0_clk_src,
>>   		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
>> -		.ops = &clk_rcg2_mux_closest_ops,
>> +		.ops = &clk_rcg2_ops,
>>   		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
Best Regards,
Devi Priya
