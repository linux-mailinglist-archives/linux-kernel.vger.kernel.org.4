Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3F711FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbjEZG3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjEZG3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:29:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BF125;
        Thu, 25 May 2023 23:29:06 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q4siMa003620;
        Fri, 26 May 2023 06:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jdSJYlZQykRJBFE4UQDhw70lAK94f2OQzbZK1r0GdIY=;
 b=mmXecgqsYJ+Uv7tAFcGiOnN22EllyH2Cj4Ob2ud4FXzlmnJAfxxK0y6RzUz3YZXjYI11
 RWukYRlp56Ps/aCByl5umQzFkivJFfd05WV4tduQN4ccA4LVzu9kkxoXfRN85sr6Oogt
 NyUQT12sFNmotE73EHxUUn2BM/hBAxzt/O75ZMXxGlxjLAOgShtBXliRC+vYhuXaEcWl
 zwcGWRnOKqxZBTZplZcf+dHZjZ93uINo77FYktDn50iRqCFKPmlcMjH/ZhZQ5Xsck5UE
 zK3GjYVyxJgN2DZsVcUX9UMkNw6yN/MkdcLjWAd2YMZzT5oKSP6/V17R9LSnvWfom6D5 tA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtp4wg6nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 06:28:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q6SZpY020950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 06:28:35 GMT
Received: from [10.50.56.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 23:28:29 -0700
Message-ID: <0907fcc9-2ffd-df0c-2e4f-8d58ff393885@quicinc.com>
Date:   Fri, 26 May 2023 11:58:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 07/17] media: venus: core: Assign registers based on
 VPU version
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
 <20230228-topic-venus-v3-7-6092ae43b58f@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v3-7-6092ae43b58f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oAVTAy8VGxJpUNY694F4H0Opcaj9JRTJ
X-Proofpoint-ORIG-GUID: oAVTAy8VGxJpUNY694F4H0Opcaj9JRTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260053
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 2:44 AM, Konrad Dybcio wrote:
> IRIS2(_1) has a different register map compared to other HFI6XX-
> using VPUs. AR50L uses the same offsets, but doesn't feature vbif_base
> and aon_base. Take care of it.
> 
this patch now replaces V6 with corresponding/supported VPU versions
so update commit text accordingly.

- Dikshita
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 01671dd23888..69c77b2137cc 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -246,7 +246,7 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
>  
>  static void venus_assign_register_offsets(struct venus_core *core)
>  {
> -	if (IS_V6(core)) {
> +	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>  		core->vbif_base = core->base + VBIF_BASE;
>  		core->cpu_base = core->base + CPU_BASE_V6;
>  		core->cpu_cs_base = core->base + CPU_CS_BASE_V6;
> 
