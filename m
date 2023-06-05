Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBA7227BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjFENp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFENpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:45:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4599292;
        Mon,  5 Jun 2023 06:45:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BqBAF017489;
        Mon, 5 Jun 2023 13:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kBqOhmuydtFr41czKlV4NQYxtDMFuOkMZjHrf4V9OOk=;
 b=o2VmQyn7QNUozanChJZh3IUPMRrs7RaH9agsjxTZcEddX0mXmihcqDx5+At6gWK9mHGX
 OKfjq/5zkQqnwLbeB8v81zwJw5kAqJZIukWEEEHxjGKEW3CxTPZtomcExy/0kQz27/A+
 OPpdXENQIU8B5kU7jQQRppqTKZCXeTusFTEdCEmL+Ut7a7Ursv7Ya6YwNj0dvRrhVghb
 lCPHaBAxK/nFcf3Xa8gzRQcSQC9MiQUA6HVpyT48Jt7Qu7P76+BEB8cnF3/aUYPHyvSK
 //JIIKsodPqMHp802tdm+CrVJ3WDHW0W+1+f/nkOWZdvu2RkjjjYGXiv+8CHQjZlxUps tQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1arns0bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 13:45:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355DjGxL022290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 13:45:16 GMT
Received: from [10.50.53.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 06:45:11 -0700
Message-ID: <8156aff1-2e3f-16ee-04b7-844aa4dfed91@quicinc.com>
Date:   Mon, 5 Jun 2023 19:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix regulators for PM8550
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230605115607.921308-1-abel.vesa@linaro.org>
Content-Language: en-US
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20230605115607.921308-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SDUKcedMs4LRpKNZef30loHKs01rDdk5
X-Proofpoint-GUID: SDUKcedMs4LRpKNZef30loHKs01rDdk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_28,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1011 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050119
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 5:26 PM, Abel Vesa wrote:
> The PM8550 uses only NLDOs 515 and the LDO 6 through 8 are low voltage
> type, so fix accordingly.

I was seeing a bunch of LDO initialization's fail while bringing up an
upcoming SoC/Board which uses these same set of PMIC's, some of those
are fixed with this patch, but I still have a couple more failing due
to the voltage that I try to init them to being out of range based on
their voltage range, can you pls check if those are of the right type?

The ones now failing are, ldo12 from pm8550 and smps4 from pm8550ve.

> 
> Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/regulator/qcom-rpmh-regulator.c | 30 ++++++++++++-------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index b0a58c62b1e2..f3b280af0773 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -1057,21 +1057,21 @@ static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
>   };
>   
>   static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
> -	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo,    "vdd-l1-l4-l10"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
>   	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
> -	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,    "vdd-l3"),
> -	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,    "vdd-l1-l4-l10"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
>   	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
> -	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo_lv, "vdd-l6-l7"),
> -	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv, "vdd-l6-l7"),
> -	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv, "vdd-l8-l9"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo, "vdd-l6-l7"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo, "vdd-l6-l7"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo, "vdd-l8-l9"),
>   	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
> -	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,    "vdd-l1-l4-l10"),
> -	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,    "vdd-l11"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo515,    "vdd-l1-l4-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo515,    "vdd-l11"),
>   	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
>   	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
>   	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
> -	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo,    "vdd-l15"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo515,    "vdd-l15"),
>   	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
>   	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
>   	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
> @@ -1086,9 +1086,9 @@ static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
>   	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
>   	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
>   	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
> -	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,   "vdd-l1"),
> -	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,   "vdd-l2"),
> -	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,   "vdd-l3"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,   "vdd-l1"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,   "vdd-l2"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,   "vdd-l3"),
>   	{}
>   };
>   
> @@ -1101,9 +1101,9 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
>   	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
>   	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
>   	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
> -	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo,   "vdd-l1"),
> -	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo,   "vdd-l2"),
> -	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo,   "vdd-l3"),
> +	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
> +	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
> +	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
>   	{}
>   };
>   
