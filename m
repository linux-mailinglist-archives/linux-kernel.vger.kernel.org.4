Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8D6A7BB0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCBHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCBHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:13:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766F15895;
        Wed,  1 Mar 2023 23:13:39 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322764aT017753;
        Thu, 2 Mar 2023 07:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WRnmOy6SPEEI0wiZ8BxnOq065Eef41p4iv9sy6LyECE=;
 b=ezsshGZXxEcTQx6u0FesTc/A6Fq1fcKZNbpWH+OkGD+zT7PrYoAszH1o42o4+BQ0tfPG
 32I4yV5U8K2GnK/inpbO6g3oJgDNO92/rcNiu9788L59tMfaklccXazl9JmnfHZhm0fI
 uTDEqXgLYxTuDpyzeOIQ8gAPmHistDsHFh5ejx7zJtD4aZ1rEYoPNRVIzJnI59z6/mLY
 gSuGJ7IO8J2X7Z6RODqMG0L60ZQagxPBVjEE/B04gQQsg4y2XYZHIQL0nDuPslcUaoFf
 A/MBHrqh0oLU1YSRF4zi2nmA42rykB/HRlE01jB9rCNWIW5GNt+k3le+UvmpJTCBcAc3 FA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2q3jg0ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 07:13:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3227D26G009483
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 07:13:02 GMT
Received: from [10.50.55.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 23:12:56 -0800
Message-ID: <cf2eee18-a6c9-2a9b-84fa-3e2351c413e8@quicinc.com>
Date:   Thu, 2 Mar 2023 12:42:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/18] media: venus: Introduce VPU version distinction
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Vikash Garodia" <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-2-58c2c88384e9@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v1-2-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F7uEGemVDWcHX1smOVpW--IWTnjYLdkc
X-Proofpoint-GUID: F7uEGemVDWcHX1smOVpW--IWTnjYLdkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_03,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020060
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
> The Video Processing Unit hardware version is the differentiator,
> based on which we should decide which code paths to take in hw
> init. Up until now, we've relied on HFI versions, but that was
> just a happy accident between recent SoCs. Add a field in the
> res struct and add correlated definitions that will be used to
> account for the aforementioned differences.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2602a9..4b785205c5b1 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -48,6 +48,14 @@ struct bw_tbl {
>   	u32 peak_10bit;
>   };
>   
> +enum vpu_version {
> +	VPU_VERSION_AR50, /* VPU4 */
> +	VPU_VERSION_AR50_LITE, /* VPU4.4 */
> +	VPU_VERSION_IRIS1, /* VPU5 */
> +	VPU_VERSION_IRIS2,
> +	VPU_VERSION_IRIS2_1,
> +};
> +
>   struct venus_resources {
>   	u64 dma_mask;
>   	const struct freq_tbl *freq_tbl;
> @@ -71,6 +79,7 @@ struct venus_resources {
>   	const char * const resets[VIDC_RESETS_NUM_MAX];
>   	unsigned int resets_num;
>   	enum hfi_version hfi_version;
> +	enum vpu_version vpu_version;
>   	u8 num_vpp_pipes;
>   	u32 max_load;
>   	unsigned int vmem_id;
> @@ -473,6 +482,12 @@ struct venus_inst {
>   #define IS_V4(core)	((core)->res->hfi_version == HFI_VERSION_4XX)
>   #define IS_V6(core)	((core)->res->hfi_version == HFI_VERSION_6XX)
>   
> +#define IS_AR50(core)		((core)->res->vpu_version == VPU_VERSION_AR50)
> +#define IS_AR50_LITE(core)	((core)->res->vpu_version == VPU_VERSION_AR50_LITE)
> +#define IS_IRIS1(core)		((core)->res->vpu_version == VPU_VERSION_IRIS1)
> +#define IS_IRIS2(core)		((core)->res->vpu_version == VPU_VERSION_IRIS2)
> +#define IS_IRIS2_1(core)	((core)->res->vpu_version == VPU_VERSION_IRIS2_1)
> +
>   #define ctrl_to_inst(ctrl)	\
>   	container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
>   

Adding VPU version check seems a good idea to me. Can we remove HFI 
Version checks now?

