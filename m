Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D82712839
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbjEZO3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbjEZO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:29:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9892199;
        Fri, 26 May 2023 07:29:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QCOWbv024951;
        Fri, 26 May 2023 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FIrAKK0SP3S9Vtg+fQ1R7z9TsCYK5iVOuEvaSHL5B3I=;
 b=EHygjGLdAxiyef9GAzL8lhyUEiWkB0xhGmMLu9fv+AIbFQR+qEe/8EYD44rK/ht3u56f
 3Ea1eSf2Z2KLw63lvKbmk30SyNCdcjYkRM8x7Eyz8JQAd7fmMJaWcVBKCAiZBXQJIODT
 2gpZJRTFmObwxZ4E2WXdppQDGkabzs8JqlpWFxAE2FLgwP6vID62Bex0sa9hsPdcRE8K
 T9SCAGqpSqEdZvOtpRFzLP1xqhCKNgej5bvFfC58pOgWQb/1tut8zWtCwV6Yce9qyM6Z
 jje15YhfPayT2J2efW6XX9Vca2rauRZQTRSJX12LThaeNt/Xag0R5JTm+pObkiidPGR0 Pg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtp4wh41e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 14:29:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QETCtq006340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 14:29:12 GMT
Received: from [10.216.41.197] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 07:29:09 -0700
Message-ID: <24d32753-c769-02f6-0ece-a3e69761f400@quicinc.com>
Date:   Fri, 26 May 2023 19:57:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix unconditional call to
 scm_pas_mem_setup
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Robert Marko <robimarko@gmail.com>, <stable@vger.kernel.org>
References: <20230526115511.3328-1-ansuelsmth@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230526115511.3328-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c9lP6biKlxIBBrqZ6_UgiC0hC7k6U5I4
X-Proofpoint-ORIG-GUID: c9lP6biKlxIBBrqZ6_UgiC0hC7k6U5I4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260121
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2023 5:25 PM, Christian Marangi wrote:
> Commit ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS
> mem_setup") dropped the relocate check and made pas_mem_setup run
> unconditionally. The code was later moved with commit f4e526ff7e38
> ("soc: qcom: mdt_loader: Extract PAS operations") to
> qcom_mdt_pas_init() effectively losing track of what was actually
> done.
> 
> The assumption that PAS mem_setup can be done anytime was effectively
> wrong, with no good reason and this caused regression on some SoC
> that use remoteproc to bringup ath11k. One example is IPQ8074 SoC that
> effectively broke resulting in remoteproc silently die and ath11k not
> working.
> 
> On this SoC FW relocate is not enabled and PAS mem_setup was correctly
> skipped in previous kernel version resulting in correct bringup and
> function of remoteproc and ath11k.
> 
> To fix the regression, reintroduce the relocate check in
> qcom_mdt_pas_init() and correctly skip PAS mem_setup where relocate is
> not enabled.
> 
> Fixes: ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS mem_setup")
> Tested-by: Robert Marko <robimarko@gmail.com>
> Co-developed-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Cc: stable@vger.kernel.org

Thanks.

> ---
>   drivers/soc/qcom/mdt_loader.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 33dd8c315eb7..46820bcdae98 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -210,6 +210,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>   	const struct elf32_hdr *ehdr;
>   	phys_addr_t min_addr = PHYS_ADDR_MAX;
>   	phys_addr_t max_addr = 0;
> +	bool relocate = false;
>   	size_t metadata_len;
>   	void *metadata;
>   	int ret;
> @@ -224,6 +225,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>   		if (!mdt_phdr_valid(phdr))
>   			continue;
>   
> +		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
> +			relocate = true;
> +
>   		if (phdr->p_paddr < min_addr)
>   			min_addr = phdr->p_paddr;
>   
> @@ -246,11 +250,13 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>   		goto out;
>   	}
>   
> -	ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
> -	if (ret) {
> -		/* Unable to set up relocation */
> -		dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
> -		goto out;
> +	if (relocate) {
> +		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
> +		if (ret) {
> +			/* Unable to set up relocation */
> +			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
> +			goto out;
> +		}
>   	}
>   
>   out:

LGTM, We still carry this in our downstream kernel for legacy reason.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh
