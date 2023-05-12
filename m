Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B80700C95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbjELQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbjELQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:06:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF33139;
        Fri, 12 May 2023 09:06:46 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDJooE006467;
        Fri, 12 May 2023 16:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PC6iz5Tv4pUlmIOmjQR6WhEShG9zU4vP3ocDwH9k1go=;
 b=ioLCab4JRNg0LWF5GbpZRfp6CYJV/++Mdt3Z0qMyVPCcHHSAghL/AxSHRIwnVGsamNIJ
 mR6ulWehIkFBBwhmye6F3t908TXM8i5QW3x90gHfWcApWIEzhMak2WvgMJZjv6PUrawQ
 WMhLHWa0o+mseOBYWg2e8UMVI1R781bWhdkdwhdjprtGV9Kt88+42XA1F4qVrml7Aw9C
 AkGojt+f1VtRwN0oyYLadr4SvG95jbnYDf6dzd4RY2s47Z0+kc9jmEdPfUBo43jncqqS
 bGxM1DdlkOIEcygXqqITDSk1V2oPH2T4I74vDshTXBqDVXqVTRM6x95nvTjJAj5SkHAM IA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhh39135k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:06:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CG6fJB016871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:06:41 GMT
Received: from [10.216.40.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 09:06:38 -0700
Message-ID: <7da331ea-28ce-120f-a261-b7a695aabe66@quicinc.com>
Date:   Fri, 12 May 2023 21:34:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2] clk: qcom: ipq5332: fix the order of SLEEP_CLK and XO
 clock
Content-Language: en-US
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230417105607.4091-1-quic_kathirav@quicinc.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230417105607.4091-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aDFaD8vRz85K9p_FOdTlw5GfPibKVRpe
X-Proofpoint-ORIG-GUID: aDFaD8vRz85K9p_FOdTlw5GfPibKVRpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=939
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120133
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2023 4:26 PM, Kathiravan T wrote:
> The order of DT_SLEEP_CLK and DT_XO are swapped and it is incorrect.
> Due to which the clocks for which the parent should be XO is having parent
> as SLEEP_CLK and vice versa. So fix the same by re-ordering the entries.


Gentle Reminder...


>
> Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
> Reported-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- Added the Reported-by and Fixes tag
>
>   drivers/clk/qcom/gcc-ipq5332.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index 8cacbfb10c72..14096887d436 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -20,8 +20,8 @@
>   #include "reset.h"
>   
>   enum {
> -	DT_SLEEP_CLK,
>   	DT_XO,
> +	DT_SLEEP_CLK,
>   	DT_PCIE_2LANE_PHY_PIPE_CLK,
>   	DT_PCIE_2LANE_PHY_PIPE_CLK_X1,
>   	DT_USB_PCIE_WRAPPER_PIPE_CLK,
