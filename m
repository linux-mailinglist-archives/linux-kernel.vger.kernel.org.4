Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1762E625841
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKKK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:26:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BADA6;
        Fri, 11 Nov 2022 02:26:44 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB7Msw2006121;
        Fri, 11 Nov 2022 10:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0u0kriP058rTSEu3Pl7bKe+8OsD1dv6ROcLimdNIEAo=;
 b=LqDmF5Op+PEwwDk9WQY60/gYetTkrAsQlUVllTM86NsRsOtKOIoRe8jONMpuih8vEwkB
 iBJluhs7w1bT9vovXwR7H/3JT2ETcM8fNgOmieMJ3C7Fz1a8yuVpaHqzhNS6JCoqR2Q5
 TqwRvleVtR7jMKnljnbYvE6Roj1USSq/J9+JRiB2Dldn4HfiA0xWSwVdBQ3C1A2eWKoX
 ITLT+cRIOxcf7EZ5Vcs8eQ009SZhXu79BtwbtkmMvmnEHN3mTQhaMxhyQKs9igYup7Yy
 EEkXd/dJzr83HoCH/MY769iZL8TPcbvcWzTgnAzCifaID7isD22+3V0BqAPUVHF4tvm4 GA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksada1j0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:26:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABAQbNK023449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 10:26:37 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 02:26:33 -0800
Message-ID: <a31571c8-a2f0-5de6-a11a-0f65c46de98f@quicinc.com>
Date:   Fri, 11 Nov 2022 15:56:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 04/10] interconnect: qcom: osm-l3: Simplify
 osm_l3_set()
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
 <20221111032515.3460-5-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-5-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WEVzSI0VMcy_fLNr5C-BIwcyaGTi2iL8
X-Proofpoint-GUID: WEVzSI0VMcy_fLNr5C-BIwcyaGTi2iL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 08:55, Bjorn Andersson wrote:
> The aggregation over votes for all nodes in the provider will always
> only find the bandwidth votes for the destination side of the path.
> Further more, the average kBps value will always be 0.
> 
> Simplify the logic by directly looking at the destination node's peak
> bandwidth request.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> 
> Changes since v1:
> - None
> 
>   drivers/interconnect/qcom/osm-l3.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 469be732a00b..5fa171087425 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -134,22 +134,14 @@ static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
>   	struct qcom_osm_l3_icc_provider *qp;
>   	struct icc_provider *provider;
>   	const struct qcom_osm_l3_node *qn;
> -	struct icc_node *n;
>   	unsigned int index;
> -	u32 agg_peak = 0;
> -	u32 agg_avg = 0;
>   	u64 rate;
>   
>   	qn = src->data;
>   	provider = src->provider;
>   	qp = to_osm_l3_provider(provider);
>   
> -	list_for_each_entry(n, &provider->nodes, node_list)
> -		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> -				    &agg_avg, &agg_peak);
> -
> -	rate = max(agg_avg, agg_peak);
> -	rate = icc_units_to_bps(rate);
> +	rate = icc_units_to_bps(dst->peak_bw);
>   	do_div(rate, qn->buswidth);
>   
>   	for (index = 0; index < qp->max_state - 1; index++) {
