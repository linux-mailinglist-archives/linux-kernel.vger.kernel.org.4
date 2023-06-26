Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2D73DE59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjFZMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:00:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32962E44;
        Mon, 26 Jun 2023 05:00:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QAYCuE024933;
        Mon, 26 Jun 2023 12:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6DRLqzPUZZ+XglBXAvaJTmUVYlu8d6+SvRU0rRU1AqY=;
 b=GDaIJYXlnCS0TxJT2PdUNKmuQtZTlDfoEAj1IALmcxVDLxofUMp9qX2oiqJeX/ueznFd
 IfjzCN8/g5OFK9VJOM5KFf+42nXRZBvcQYjiGPcJgreOmssnHwVXEAg7KIb06ihsl0nL
 karDdGHfXjxMcFa0LesxPq1n7k4RLpMgolXI79FtznVxkbaD5kI5zwstO/Vn5M79hEp/
 praLr/0gFWEN4O8lL+NTEfWJkXzi85QGUQlaLpHlHoiG/tOIR6T9aDwEqGUlPp4Dgykg
 0bSOqEyuVE4RoPmy1TR1m03OfvMdo5sUD8rZoxNmyAKD5dUvHPlef/nlgFNRxp4QLdAh oA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqtr3wwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 12:00:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QC0AWs000701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 12:00:11 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 05:00:05 -0700
Message-ID: <99aebcb3-89d4-993b-5bc1-abc475b94843@quicinc.com>
Date:   Mon, 26 Jun 2023 17:29:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V5 4/5] clk: qcom: camcc-sm8550: Add support for qdss,
 sleep and xo clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230623164619.11464-1-quic_jkona@quicinc.com>
 <20230623164619.11464-5-quic_jkona@quicinc.com>
 <11b3058c-2261-95a4-2347-b0a33fdeb1e3@linaro.org>
Content-Language: en-US
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <11b3058c-2261-95a4-2347-b0a33fdeb1e3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eSYt05f620-QocfIb6sGF8p6LqJ5BxkE
X-Proofpoint-ORIG-GUID: eSYt05f620-QocfIb6sGF8p6LqJ5BxkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_08,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306260107
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2023 5:49 PM, Konrad Dybcio wrote:
> On 23.06.2023 18:46, Jagadeesh Kona wrote:
>> Add support for camera qdss, sleep and xo clocks.
>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes since v4:
>>   - No changes.
>> Changes since v3:
>>   - No changes.
>> Changes since v2:
>>   - No changes.
>> Changes since v1:
>>   - Newly added.
>>
>>   drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
>>   1 file changed, 180 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
>> index 075bea32087c..7b4882444d58 100644
>> --- a/drivers/clk/qcom/camcc-sm8550.c
>> +++ b/drivers/clk/qcom/camcc-sm8550.c
>> @@ -22,6 +22,8 @@
>>   enum {
>>   	DT_IFACE,
>>   	DT_BI_TCXO,
>> +	DT_BI_TCXO_AO,
>> +	DT_SLEEP_CLK,
>>   };
>>   
>>   enum {
>> @@ -43,6 +45,7 @@ enum {
>>   	P_CAM_CC_PLL10_OUT_EVEN,
>>   	P_CAM_CC_PLL11_OUT_EVEN,
>>   	P_CAM_CC_PLL12_OUT_EVEN,
>> +	P_SLEEP_CLK,
>>   };
>>   
>>   static const struct pll_vco lucid_ole_vco[] = {
>> @@ -881,6 +884,22 @@ static const struct clk_parent_data cam_cc_parent_data_11[] = {
>>   	{ .hw = &cam_cc_pll7_out_even.clkr.hw },
>>   };
>>   
>> +static const struct parent_map cam_cc_parent_map_12[] = {
>> +	{ P_SLEEP_CLK, 0 },
>> +};
>> +
>> +static const struct clk_parent_data cam_cc_parent_data_12[] = {
>> +	{ .index = DT_SLEEP_CLK },
>> +};
>> +
>> +static const struct parent_map cam_cc_parent_map_13[] = {
>> +	{ P_BI_TCXO, 0 },
>> +};
>> +
>> +static const struct clk_parent_data cam_cc_parent_data_13_ao[] = {
>> +	{ .index = DT_BI_TCXO_AO },
>> +};
>> +
>>   static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
>>   	F(19200000, P_BI_TCXO, 1, 0, 0),
>>   	F(200000000, P_CAM_CC_PLL8_OUT_EVEN, 1, 0, 0),
>> @@ -1565,6 +1584,29 @@ static struct clk_rcg2 cam_cc_mclk7_clk_src = {
>>   	},
>>   };
>>   
>> +static const struct freq_tbl ftbl_cam_cc_qdss_debug_clk_src[] = {
>> +	F(19200000, P_BI_TCXO, 1, 0, 0),
>> +	F(75000000, P_CAM_CC_PLL0_OUT_EVEN, 8, 0, 0),
>> +	F(150000000, P_CAM_CC_PLL0_OUT_EVEN, 4, 0, 0),
>> +	F(300000000, P_CAM_CC_PLL0_OUT_MAIN, 4, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 cam_cc_qdss_debug_clk_src = {
>> +	.cmd_rcgr = 0x13f24,
>> +	.mnd_width = 0,
>> +	.hid_width = 5,
>> +	.parent_map = cam_cc_parent_map_0,
>> +	.freq_tbl = ftbl_cam_cc_qdss_debug_clk_src,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>> +		.name = "cam_cc_qdss_debug_clk_src",
>> +		.parent_data = cam_cc_parent_data_0,
>> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +		.ops = &clk_rcg2_shared_ops,
>> +	},
>> +};
>> +
>>   static const struct freq_tbl ftbl_cam_cc_sfe_0_clk_src[] = {
>>   	F(466000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>>   	F(594000000, P_CAM_CC_PLL6_OUT_EVEN, 1, 0, 0),
>> @@ -1611,6 +1653,26 @@ static struct clk_rcg2 cam_cc_sfe_1_clk_src = {
>>   	},
>>   };
>>   
>> +static const struct freq_tbl ftbl_cam_cc_sleep_clk_src[] = {
>> +	F(32000, P_SLEEP_CLK, 1, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 cam_cc_sleep_clk_src = {
>> +	.cmd_rcgr = 0x141a0,
>> +	.mnd_width = 0,
>> +	.hid_width = 5,
>> +	.parent_map = cam_cc_parent_map_12,
>> +	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>> +		.name = "cam_cc_sleep_clk_src",
>> +		.parent_data = cam_cc_parent_data_12,
>> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_12),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +		.ops = &clk_rcg2_shared_ops,
>> +	},
>> +};
>> +
>>   static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] = {
>>   	F(19200000, P_BI_TCXO, 1, 0, 0),
>>   	F(80000000, P_CAM_CC_PLL0_OUT_EVEN, 7.5, 0, 0),
>> @@ -1632,6 +1694,26 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
>>   	},
>>   };
>>   
>> +static const struct freq_tbl ftbl_cam_cc_xo_clk_src[] = {
>> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> You're overloading P_BI_TCXO with a different parent clock (XO_A).
> 

This RCG just requires active only voting, hence using XO_A as its parent.

Both XO and XO_A are same clock in HW (BI_TCXO), hence we can reuse 
P_BI_TCXO in frequency table for XO_A parent as well.

Thanks,
Jagadeesh

> The rest lgtm
> 
> Konrad
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 cam_cc_xo_clk_src = {
>> +	.cmd_rcgr = 0x14070,
>> +	.mnd_width = 0,
>> +	.hid_width = 5,
>> +	.parent_map = cam_cc_parent_map_13,
>> +	.freq_tbl = ftbl_cam_cc_xo_clk_src,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>> +		.name = "cam_cc_xo_clk_src",
>> +		.parent_data = cam_cc_parent_data_13_ao,
>> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_13_ao),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +		.ops = &clk_rcg2_shared_ops,
>> +	},
>> +};
>> +
>>   static struct clk_branch cam_cc_bps_ahb_clk = {
>>   	.halt_reg = 0x10274,
>>   	.halt_check = BRANCH_HALT,
>> @@ -1704,6 +1786,42 @@ static struct clk_branch cam_cc_camnoc_axi_clk = {
>>   	},
>>   };
>>   
>> +static struct clk_branch cam_cc_camnoc_dcd_xo_clk = {
>> +	.halt_reg = 0x13f18,
>> +	.halt_check = BRANCH_HALT,
>> +	.clkr = {
>> +		.enable_reg = 0x13f18,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "cam_cc_camnoc_dcd_xo_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&cam_cc_xo_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_ops,
>> +		},
>> +	},
>> +};
>> +
>> +static struct clk_branch cam_cc_camnoc_xo_clk = {
>> +	.halt_reg = 0x13f1c,
>> +	.halt_check = BRANCH_HALT,
>> +	.clkr = {
>> +		.enable_reg = 0x13f1c,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "cam_cc_camnoc_xo_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&cam_cc_xo_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_ops,
>> +		},
>> +	},
>> +};
>> +
>>   static struct clk_branch cam_cc_cci_0_clk = {
>>   	.halt_reg = 0x13a2c,
>>   	.halt_check = BRANCH_HALT,
>> @@ -2370,6 +2488,24 @@ static struct clk_branch cam_cc_drv_ahb_clk = {
>>   	},
>>   };
>>   
>> +static struct clk_branch cam_cc_drv_xo_clk = {
>> +	.halt_reg = 0x142d4,
>> +	.halt_check = BRANCH_HALT,
>> +	.clkr = {
>> +		.enable_reg = 0x142d4,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "cam_cc_drv_xo_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&cam_cc_xo_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_ops,
>> +		},
>> +	},
>> +};
>> +
>>   static struct clk_branch cam_cc_icp_ahb_clk = {
>>   	.halt_reg = 0x138fc,
>>   	.halt_check = BRANCH_HALT,
>> @@ -2910,6 +3046,42 @@ static struct clk_branch cam_cc_mclk7_clk = {
>>   	},
>>   };
>>   
>> +static struct clk_branch cam_cc_qdss_debug_clk = {
>> +	.halt_reg = 0x14050,
>> +	.halt_check = BRANCH_HALT,
>> +	.clkr = {
>> +		.enable_reg = 0x14050,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "cam_cc_qdss_debug_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&cam_cc_qdss_debug_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_ops,
>> +		},
>> +	},
>> +};
>> +
>> +static struct clk_branch cam_cc_qdss_debug_xo_clk = {
>> +	.halt_reg = 0x14054,
>> +	.halt_check = BRANCH_HALT,
>> +	.clkr = {
>> +		.enable_reg = 0x14054,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "cam_cc_qdss_debug_xo_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&cam_cc_xo_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_ops,
>> +		},
>> +	},
>> +};
>> +
>>   static struct clk_branch cam_cc_sbi_clk = {
>>   	.halt_reg = 0x10540,
>>   	.halt_check = BRANCH_HALT,
>> @@ -3133,6 +3305,8 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>>   	[CAM_CC_BPS_FAST_AHB_CLK] = &cam_cc_bps_fast_ahb_clk.clkr,
>>   	[CAM_CC_CAMNOC_AXI_CLK] = &cam_cc_camnoc_axi_clk.clkr,
>>   	[CAM_CC_CAMNOC_AXI_CLK_SRC] = &cam_cc_camnoc_axi_clk_src.clkr,
>> +	[CAM_CC_CAMNOC_DCD_XO_CLK] = &cam_cc_camnoc_dcd_xo_clk.clkr,
>> +	[CAM_CC_CAMNOC_XO_CLK] = &cam_cc_camnoc_xo_clk.clkr,
>>   	[CAM_CC_CCI_0_CLK] = &cam_cc_cci_0_clk.clkr,
>>   	[CAM_CC_CCI_0_CLK_SRC] = &cam_cc_cci_0_clk_src.clkr,
>>   	[CAM_CC_CCI_1_CLK] = &cam_cc_cci_1_clk.clkr,
>> @@ -3184,6 +3358,7 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>>   	[CAM_CC_CSIPHY6_CLK] = &cam_cc_csiphy6_clk.clkr,
>>   	[CAM_CC_CSIPHY7_CLK] = &cam_cc_csiphy7_clk.clkr,
>>   	[CAM_CC_DRV_AHB_CLK] = &cam_cc_drv_ahb_clk.clkr,
>> +	[CAM_CC_DRV_XO_CLK] = &cam_cc_drv_xo_clk.clkr,
>>   	[CAM_CC_FAST_AHB_CLK_SRC] = &cam_cc_fast_ahb_clk_src.clkr,
>>   	[CAM_CC_ICP_AHB_CLK] = &cam_cc_icp_ahb_clk.clkr,
>>   	[CAM_CC_ICP_CLK] = &cam_cc_icp_clk.clkr,
>> @@ -3260,6 +3435,9 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>>   	[CAM_CC_PLL11_OUT_EVEN] = &cam_cc_pll11_out_even.clkr,
>>   	[CAM_CC_PLL12] = &cam_cc_pll12.clkr,
>>   	[CAM_CC_PLL12_OUT_EVEN] = &cam_cc_pll12_out_even.clkr,
>> +	[CAM_CC_QDSS_DEBUG_CLK] = &cam_cc_qdss_debug_clk.clkr,
>> +	[CAM_CC_QDSS_DEBUG_CLK_SRC] = &cam_cc_qdss_debug_clk_src.clkr,
>> +	[CAM_CC_QDSS_DEBUG_XO_CLK] = &cam_cc_qdss_debug_xo_clk.clkr,
>>   	[CAM_CC_SBI_CLK] = &cam_cc_sbi_clk.clkr,
>>   	[CAM_CC_SBI_FAST_AHB_CLK] = &cam_cc_sbi_fast_ahb_clk.clkr,
>>   	[CAM_CC_SFE_0_CLK] = &cam_cc_sfe_0_clk.clkr,
>> @@ -3268,7 +3446,9 @@ static struct clk_regmap *cam_cc_sm8550_clocks[] = {
>>   	[CAM_CC_SFE_1_CLK] = &cam_cc_sfe_1_clk.clkr,
>>   	[CAM_CC_SFE_1_CLK_SRC] = &cam_cc_sfe_1_clk_src.clkr,
>>   	[CAM_CC_SFE_1_FAST_AHB_CLK] = &cam_cc_sfe_1_fast_ahb_clk.clkr,
>> +	[CAM_CC_SLEEP_CLK_SRC] = &cam_cc_sleep_clk_src.clkr,
>>   	[CAM_CC_SLOW_AHB_CLK_SRC] = &cam_cc_slow_ahb_clk_src.clkr,
>> +	[CAM_CC_XO_CLK_SRC] = &cam_cc_xo_clk_src.clkr,
>>   };
>>   
>>   static struct gdsc *cam_cc_sm8550_gdscs[] = {
