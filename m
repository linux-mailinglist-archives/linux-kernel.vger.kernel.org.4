Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFAE711136
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbjEYQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEYQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:43:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0034189;
        Thu, 25 May 2023 09:43:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFXIuO016290;
        Thu, 25 May 2023 16:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l0oOleeTAxSA/9UIXl/0VMHLpUa3foEraPOk8DePxn8=;
 b=RbGDU1Is+P1eHsoTOC/GheKuBmf4pSTswzps692iZvhEZwYTZvpM7HcOAkoJX52CiDxt
 XofNSKSjpxpb6bQNp6tM+EeZ6t7DFtjy0OVR43xWjSkWzUhSm+ByKaYYonHcVxEjLssw
 bR2lYxWt89S1KZ5kiHYbU1BJXXCm5ZbhoJODlszoSKFxH1PQ+x5QzU8/kqPJkBvFZroX
 AfxAF2h1vqKioj2x1hr81foVilpNBOd02dNBYsZ6wbO/pWdW3v7KUk4+ODafk/446wlr
 Lktr77k1P3n0d2vVJ1OLxfhvRNOBxTUCIXdIdWjlcDNj7o9Hb+8ELaVxpXKXFvMtmddz nQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsywfskaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:42:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PGgufQ020250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:42:56 GMT
Received: from [10.216.52.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 09:42:50 -0700
Message-ID: <1d04cc83-a55b-b33b-5fd9-d48634315db5@quicinc.com>
Date:   Thu, 25 May 2023 22:12:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] clk: qcom: clk-alpha-pll: Add support for rivian ole
 pll ops
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-2-quic_jkona@quicinc.com>
 <e62200fb-2398-dcd0-0b25-afa94942bae6@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <e62200fb-2398-dcd0-0b25-afa94942bae6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 16Px9fymXWYdPd0CynudmjCYT6XiX2vY
X-Proofpoint-ORIG-GUID: 16Px9fymXWYdPd0CynudmjCYT6XiX2vY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250138
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for your review!

On 5/19/2023 10:19 PM, Konrad Dybcio wrote:
> 
> 
> On 19.05.2023 17:55, Jagadeesh Kona wrote:
>> Add support for rivian ole pll ops and ole pll registers to
>> configure and control the rivian ole pll.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-alpha-pll.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
>> index 4d9b6d5b7062..e6df398bee6d 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.h
>> +++ b/drivers/clk/qcom/clk-alpha-pll.h
>> @@ -24,6 +24,7 @@ enum {
>>   	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
>>   	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
>>   	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
>> +	CLK_ALPHA_PLL_TYPE_RIVIAN_OLE = CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
> This makes sense
> 
> The rest is just sugar syntax, I don't think it makes sense to keep
> adding meaningless defines..
> 
Yes, will remove these and reuse existing ops in next series.

> Konrad
>>   	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
>>   	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
>>   	CLK_ALPHA_PLL_TYPE_STROMER,
>> @@ -181,6 +182,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
>>   #define clk_alpha_pll_postdiv_lucid_ole_ops clk_alpha_pll_postdiv_lucid_evo_ops
>>   
>>   extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
>> +#define clk_alpha_pll_rivian_ole_ops clk_alpha_pll_rivian_evo_ops
>>   #define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
>>   
>>   void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>> @@ -202,6 +204,8 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>>   			clk_lucid_evo_pll_configure(pll, regmap, config)
>>   void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   				  const struct alpha_pll_config *config);
>> +#define clk_rivian_ole_pll_configure(pll, regmap, config) \
>> +			clk_rivian_evo_pll_configure(pll, regmap, config)
>>   void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   			       const struct alpha_pll_config *config);
>>

Thanks & Regards,
Jagadeesh
