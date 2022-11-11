Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C648625838
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiKKKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiKKKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:25:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE47167EE;
        Fri, 11 Nov 2022 02:25:11 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB6bIQU010553;
        Fri, 11 Nov 2022 10:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D4ev74rNh6aBdUhbqjz831JBd2WeZ4da59FaYDrjdmE=;
 b=MnTz1FofVYu5eKcLGWS3ao4wkSeCGvrnjOZHCSkggUc9QeRRr3XtlGMMlvvjSMoqmjw7
 838VJiNcGbK4b4SQsAhc6t++gun+fAoCo33hHlmC/ZXr5ZDg3Sg+3nwLuorNeAQgT5TN
 oBYT7g9kU4G/cRrw9rBlvWF2n9ZxrO5mAI5E3dFuCjO9iwrW+7+Ejhv+NNyguotHN/Pa
 bt3bqAMA2XLFhbM/HvL5CRpg2DRW92WYof3+N01/RNirBcc819T9hIHaLTw2y3sBNQg0
 FwpxwCcf4xtxWHdIA+uIYx+Bza9XCVmfY2XayghNY45KPv1wDFQ57thbM4dVoPxzeMvN 7A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksh9q0skx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:25:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABAP4gU006687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:25:04 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 02:25:00 -0800
Message-ID: <d7451462-b847-5975-e3b6-b27496162cca@quicinc.com>
Date:   Fri, 11 Nov 2022 15:54:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 03/10] interconnect: qcom: osm-l3: Add per-core EPSS L3
 support
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-4-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fZi2uaXCqSTbUajrQbtK2MsxoysJ46dH
X-Proofpoint-ORIG-GUID: fZi2uaXCqSTbUajrQbtK2MsxoysJ46dH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 08:55, Bjorn Andersson wrote:
> The EPSS instance in e.g. SM8350 and SC8280XP has per-core L3 voting
> enabled. In this configuration, the "shared" vote is done using the
> REG_L3_VOTE register instead of PERF_STATE.
> 
> Rename epss_l3 to clarify that it's affecting the PERF_STATE register
> and add a new L3_VOTE description. Given platform lineage it's assumed
> that the L3_VOTE-based case will be the predominant one, so use this for
> a new generic qcom,epss-l3 compatible.
> 
> While adding the EPSS generic, also add qcom,osm-l3.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> 
> Changes since v1:
> - None
> 
>   drivers/interconnect/qcom/osm-l3.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 7d6844253241..469be732a00b 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -34,6 +34,7 @@
>   
>   /* EPSS Register offsets */
>   #define EPSS_LUT_ROW_SIZE		4
> +#define EPSS_REG_L3_VOTE		0x90
>   #define EPSS_REG_FREQ_LUT		0x100
>   #define EPSS_REG_PERF_STATE		0x320
>   
> @@ -112,7 +113,7 @@ static const struct qcom_osm_l3_desc osm_l3 = {
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -static const struct qcom_osm_l3_desc epss_l3 = {
> +static const struct qcom_osm_l3_desc epss_l3_perf_state = {
>   	.nodes = epss_l3_nodes,
>   	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>   	.lut_row_size = EPSS_LUT_ROW_SIZE,
> @@ -120,6 +121,14 @@ static const struct qcom_osm_l3_desc epss_l3 = {
>   	.reg_perf_state = EPSS_REG_PERF_STATE,
>   };
>   
> +static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
> +	.nodes = epss_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
> +	.lut_row_size = EPSS_LUT_ROW_SIZE,
> +	.reg_freq_lut = EPSS_REG_FREQ_LUT,
> +	.reg_perf_state = EPSS_REG_L3_VOTE,
> +};
> +
>   static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
>   {
>   	struct qcom_osm_l3_icc_provider *qp;
> @@ -285,12 +294,14 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id osm_l3_of_match[] = {
> +	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
> +	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
>   	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
> -	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3 },
> +	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
>   	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
>   	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>   	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
> -	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3 },
> +	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, osm_l3_of_match);
