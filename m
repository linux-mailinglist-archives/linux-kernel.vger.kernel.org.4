Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20D7685F23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBAFpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBAFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:45:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C548552A6;
        Tue, 31 Jan 2023 21:45:38 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114gXdo019410;
        Wed, 1 Feb 2023 05:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JyvcgZJvPpHOvJZoeZOsWXV+mQa+8kcrFAUne2hmzH8=;
 b=mo/HliPpUKpJxg2ALeO5jVsyMKue0TDfJLdwOnfxAHqCsZeQIGOL3Py7ZCAjbRxQ0po6
 TSzFjLBGFj3t1ifoTRxaaZ38EOanfVWP3R0Gjq134SAap5pINg2AkS4XAL0uGTdtyoAV
 qxvj3SvEY2ETCFx5ohDx+1OM+kZC8cWGditgxwku68zPdSycBze0S2LruVUz/iISwicH
 DPZ20e13Dwl/+Bioh3XEzAmngQPWy9WLp02BifkVpFGMj+jdPO7jLm3l7Hq0I3IQwzs/
 hZOZYkZxi7LEAZe4uUQuHt7YXJ7kcfAmk5Y5896d1YL8ECXLZmlHn3SF1pQTrSBLbtZx gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfg9t86y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 05:45:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3115jMdV028370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 05:45:22 GMT
Received: from [10.50.28.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 21:45:15 -0800
Message-ID: <ba598cad-f127-eae3-22db-e8428b2d125e@quicinc.com>
Date:   Wed, 1 Feb 2023 11:15:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 5/9] clk: qcom: add Global Clock controller (GCC)
 driver for IPQ5332 SoC
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel.ziswiler@toradex.com>, <mturquette@baylibre.com>,
        <nfraprado@collabora.com>, <quic_gurus@quicinc.com>,
        <robh+dt@kernel.org>, <robimarko@gmail.com>, <shawnguo@kernel.org>,
        <will@kernel.org>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
 <20230130114702.20606-6-quic_kathirav@quicinc.com>
 <84f68577f5629e6ef6d6b14357a79f84.sboyd@kernel.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <84f68577f5629e6ef6d6b14357a79f84.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EO3Pe-aUUW65NZDgGx5lQcrf9ZxVjsct
X-Proofpoint-GUID: EO3Pe-aUUW65NZDgGx5lQcrf9ZxVjsct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010048
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 2:39 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2023-01-30 03:46:58)
>> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
>> new file mode 100644
>> index 000000000000..a8ce618bb81b
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-ipq5332.c
>> @@ -0,0 +1,3954 @@
> [...]
>> +
>> +static const struct clk_parent_data gcc_parent_data_xo = { .index = DT_XO };
>> +
>> +static struct clk_alpha_pll gpll0_main = {
> [...]
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_3[] = {
>> +       { P_XO, 0 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_3[] = {
> Isn't this the same as gcc_parent_data_xo?
>
>> +       { .index = DT_XO },
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_4[] = {
>> +       { P_XO, 0 },
>> +       { P_GPLL0_OUT_MAIN, 1 },
>> +       { P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC, 4 },
>> +       { P_SLEEP_CLK, 6 },
>> +};
>> +
>> +static const struct clk_parent_data gcc_parent_data_4[] = {
>> +       { .index = DT_XO },
>> +       { .hw = &gpll0.clkr.hw },
>> +       { .hw = &gpll0_div2.hw },
> [..]
>> +
>> +static int gcc_ipq5332_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = qcom_cc_map(pdev, &gcc_ipq5332_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       return qcom_cc_really_probe(pdev, &gcc_ipq5332_desc, regmap);
> If you don't need to write anything in probe you can simply use
> qcom_cc_probe().


Thanks Stephen, will move to qcom_cc_probe in V3.


