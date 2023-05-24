Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43D70FD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbjEXSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjEXSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:16:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96D12E;
        Wed, 24 May 2023 11:16:46 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OGnG4U031495;
        Wed, 24 May 2023 18:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NJhzwIdM1BxN04Etl/rJz3AbfoxN539FZSAiRZAPW+g=;
 b=CGWrjTBG8qup/l35niVY9X+MyR8SM0oT+kjFI4CvMkaX7LbIEQflszHHHbpQN8miTHy7
 vKyB1gXoHZRG38vJdHvW3YmqvkFQl7J/vnvOWmADfsppnRQkWivTbwUpNQ44i1/U+0fe
 Z2yab7te8inva1y1MASHxJTZ/EwxtDOjKt6GJsneQN2oOLqi+puILwQmQ/OMxmnRRQXP
 lXPxeL2pVqXlcYm6zvllVXRmpbdTWeAJlZXpA/E6TOpLMnm6q/UJjh1lbxKrSS+6TSeR
 jsMZme7CMsMh4oIZ1TllYurMu2e5H7zOR3KrKT7Krb/ydoR+7XOLPbl2hDT2bOy+WUHq dQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscpmspev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:16:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OIGeM0008093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:16:40 GMT
Received: from [10.110.74.38] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 11:16:40 -0700
Message-ID: <47c0faf0-f855-d3c4-6825-e51a1a1a7c83@quicinc.com>
Date:   Wed, 24 May 2023 11:16:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/4] soc: qcom: smem: introduce qcom_smem_get_msm_id()
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <ansuelsmth@gmail.com>
References: <20230524162329.819770-1-robimarko@gmail.com>
 <20230524162329.819770-2-robimarko@gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230524162329.819770-2-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ezDbxQBj6CWonh-ZhtM3ChyaB8MBfrLj
X-Proofpoint-GUID: ezDbxQBj6CWonh-ZhtM3ChyaB8MBfrLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305240151
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/2023 9:23 AM, Robert Marko wrote:
> Introduce a helper to return the SoC SMEM ID, which is used to identify the
> exact SoC model as there may be differences in the same SoC family.
> 
> Currently, cpufreq-nvmem does this completely in the driver and there has
> been more interest expresed for other drivers to use this information so
> lets expose a common helper to prevent redoing it in individual drivers
> since this field is present on every SMEM table version.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/soc/qcom/smem.c       | 19 +++++++++++++++++++
>   include/linux/soc/qcom/smem.h |  2 ++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 6be7ea93c78c..0d6ba9bce8cb 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -14,6 +14,7 @@
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
>   
>   /*
>    * The Qualcomm shared memory system is a allocate only heap structure that
> @@ -772,6 +773,24 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>   }
>   EXPORT_SYMBOL(qcom_smem_virt_to_phys);
>   
> +/**
> + * qcom_smem_get_msm_id() - return the SoC ID
> + *
> + * Look up SoC ID from HW/SW build ID and return it.
> + */
> +int qcom_smem_get_msm_id(void)
> +{
> +	size_t len;
> +	struct socinfo *info;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	return __le32_to_cpu(info->id);
> +}
> +EXPORT_SYMBOL(qcom_smem_get_msm_id);

EXPORT_SYMBOL_GPL please?

Please change it for other symbols in the driver as well w/ separate patch.

---Trilok Soni


