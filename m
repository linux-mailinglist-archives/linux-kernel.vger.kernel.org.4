Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0202710CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjEYNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbjEYNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:00:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E21B9;
        Thu, 25 May 2023 05:59:36 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P9K079010423;
        Thu, 25 May 2023 12:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uWU4Qmab2BHmLrbhbP6NqzbDqIcJ4DyUhfuXt6gAyH8=;
 b=UbYDnWlRWP2jLYC70DbbhzUWIdNUXt44UQmMCvw+eIfeaHIjQ5bLl7luBJ4mxbfgZdO8
 Eh07B6Z713pjz6acMTq2KlGNEyCxidVExLT1V8j6TGHNdrRzKCDBWpNoUpsCmF/XmUXc
 seu84atqskpEu6bNFU1LCcwCMvGevZhYLueMf8UZ0Ge8bdaj7PXR+ErnB58rRJS7fB//
 eKgV3YloUEMXRoIdQKx0g7PVJRwFOVJA92ue/XfoI5XMGiytZxeSw2uOGMsSd2UvBdHZ
 ENPwAZtqXAYgwcWJ+1scBeGfoJVbs+B+i1sydfv2ycSHZZrpv7/5LXgnJRgmDuL/daDE 0w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qstg3smry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:59:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PCx9mR005851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:59:09 GMT
Received: from [10.216.31.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 05:59:04 -0700
Message-ID: <c4a50acd-2c0a-7c18-95d8-e9145fa1ff24@quicinc.com>
Date:   Thu, 25 May 2023 18:28:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 3/5] soc: qcom: smem: introduce qcom_smem_get_msm_id()
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <ansuelsmth@gmail.com>
References: <20230525120956.3095317-1-robimarko@gmail.com>
 <20230525120956.3095317-3-robimarko@gmail.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230525120956.3095317-3-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ojr9q1T-uIqTRYcIiURYy6SBExkdjyD
X-Proofpoint-ORIG-GUID: 8ojr9q1T-uIqTRYcIiURYy6SBExkdjyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250107
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/25/2023 5:39 PM, Robert Marko wrote:
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
> Changes in v3:
> * Change export to EXPORT_SYMBOL_GPL
> * Use an argument for returning SoC ID
> * Update kerneldoc
> ---
>   drivers/soc/qcom/smem.c       | 24 ++++++++++++++++++++++++
>   include/linux/soc/qcom/smem.h |  2 ++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index bc98520c4969..185ed0da11a1 100644
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
> @@ -772,6 +773,29 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>   }
>   EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>   
> +/**
> + * qcom_smem_get_msm_id() - return the SoC ID
> + * @id:	On success, we return the SoC ID here.
> + *
> + * Look up SoC ID from HW/SW build ID and return it.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_smem_get_msm_id(u32 *id)


I think, MSM  is not the only platform which will leverage this API. 
qcom_smem_get_soc_id() / qcom_smem_get_cpu_id() would make more sense 
than qcom_smem_get_msm_id() ?


> +{
> +	size_t len;
> +	struct socinfo *info;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);


len is unused after this, can we just pass NULL? Did a quick check on 
the code, if we pass the address, size of the item will be updated, else no.


> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*id = info->id;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_msm_id);
> +
>   static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>   {
>   	struct smem_header *header;
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index 86e1b358688a..cb204ad6373c 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
>   
>   phys_addr_t qcom_smem_virt_to_phys(void *p);
>   
> +int qcom_smem_get_msm_id(u32 *id);
> +
>   #endif
