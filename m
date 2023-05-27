Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1F713262
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjE0D7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjE0D7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:59:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972B125;
        Fri, 26 May 2023 20:58:38 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34R3q8fY008468;
        Sat, 27 May 2023 03:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0QF93uSv/DLQZOFi/xWf93K/LVY+8cfaVZEUODalsG0=;
 b=c925ZmCzzmiFsT4YbXYn7cZOrvf3a4Qf8GLMrw0HTfY2VJ/gFyTeDAKpkvZNsNKofdqG
 cGdTxkO7CS/vvNyU7Q6YYfUK0oriR/cFQeIno/nyv4lo27N3qd9ijnUg8tfN9bHb4SBh
 VugYhQSL2NM4ktNxz+7ensY7p8f8IzSyRT7YSAWCYEJ390pOaV1yxmoSbSCwVNCuQi4c
 OZij5iSJO848oalsMKeEhkH941rdCIltY/VUl/aoK2+G2XV0TVjmhbs+44SJx0fzUyZr
 r+ATZbFKSoGgWa51jEbX5Rxxi9Iq9IGgsYbbhjUBaBFXrM4RAvSuCW0weTXcEVGju/WQ 6Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qu7jn0614-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 03:58:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34R3wSKW009270
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 03:58:28 GMT
Received: from [10.216.21.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 20:58:23 -0700
Message-ID: <353f6b1e-4729-19a8-d792-5acc66cb2a1b@quicinc.com>
Date:   Sat, 27 May 2023 09:28:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v5 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <ansuelsmth@gmail.com>
References: <20230526204802.3081168-1-robimarko@gmail.com>
 <20230526204802.3081168-3-robimarko@gmail.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230526204802.3081168-3-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lpbRshXcyH0KDu74ctXbWJjkzk3B52O0
X-Proofpoint-GUID: lpbRshXcyH0KDu74ctXbWJjkzk3B52O0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305270031
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/2023 2:18 AM, Robert Marko wrote:
> Introduce a helper to return the SoC SMEM ID, which is used to identify the
> exact SoC model as there may be differences in the same SoC family.
>
> Currently, cpufreq-nvmem does this completely in the driver and there has
> been more interest expresed for other drivers to use this information so
> lets expose a common helper to prevent redoing it in individual drivers
> since this field is present on every SMEM table version.


LGTM,

Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>


>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v5:
> * Convert the __le32 ID to CPU endinaness
>
> Changes in v4:
> * Change helper name to qcom_smem_get_soc_id()
> * Remove len and just pass NULL, that is sufficient here
>
> Changes in v3:
> * Change export to EXPORT_SYMBOL_GPL
> * Use an argument for returning SoC ID
> * Update kerneldoc
> ---
>   drivers/soc/qcom/smem.c       | 23 +++++++++++++++++++++++
>   include/linux/soc/qcom/smem.h |  2 ++
>   2 files changed, 25 insertions(+)
>
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index bc98520c4969..b0d59e815c3b 100644
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
> @@ -772,6 +773,28 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>   }
>   EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>   
> +/**
> + * qcom_smem_get_soc_id() - return the SoC ID
> + * @id:	On success, we return the SoC ID here.
> + *
> + * Look up SoC ID from HW/SW build ID and return it.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_smem_get_soc_id(u32 *id)
> +{
> +	struct socinfo *info;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*id = __le32_to_cpu(info->id);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
> +
>   static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>   {
>   	struct smem_header *header;
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index 86e1b358688a..223db6a9c733 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
>   
>   phys_addr_t qcom_smem_virt_to_phys(void *p);
>   
> +int qcom_smem_get_soc_id(u32 *id);
> +
>   #endif
