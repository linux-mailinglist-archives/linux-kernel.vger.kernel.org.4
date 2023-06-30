Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233A4744355
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjF3UkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjF3UkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:40:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856A3C00;
        Fri, 30 Jun 2023 13:40:08 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIHP1K001799;
        Fri, 30 Jun 2023 20:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7MxM46J9CM0+AqYa4V5JbjXZQE9iUNyouKdVrgAp87o=;
 b=MPnmn4PFLRI0tGALA5VMF9qJClkufvAw8GpZNm/RDEd2CXE6qfubYuAYHjfCxT3GiOsY
 PmBbbRq7LKiJ3AKPLj0qo8lKyRlB8S79vsJ5DvEKyeaKAUklSixYtJ9WlMZTcAM5UZQZ
 pPVXeXJRWNlrTXS3X+nTygnUk0EtEsycjUyBgt87r2by/TnFAkF9TqdVQJGUQnesPESl
 N/Vs8vfzv6SRdC0fcc30ZUdJkj2IszGV8r6ugdEZPumzl2j2sK2DvIQfA5T9/xPGHjao
 rErDfgSTLjWz8bkkVxdBWtQi04+7Ivv0XL+pcVKFeijeUO9zh0Dm9CgoSJosIJUqIeKA Nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhfewawvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:40:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UKe3Sd008669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:40:03 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Fri, 30 Jun 2023 13:40:02 -0700
Date:   Fri, 30 Jun 2023 13:40:01 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Message-ID: <20230630204001.GC1059662@hu-bjorande-lv.qualcomm.com>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-6-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230623141806.13388-6-quic_kbajaj@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: StUFaU-3uJpu3CBFtTw6ETc0UYW2wh8j
X-Proofpoint-GUID: StUFaU-3uJpu3CBFtTw6ETc0UYW2wh8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=924 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:48:05PM +0530, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configuration
> based on a feature register. Reading DDR channel
> confiuration uses nvmem framework, so select the
> dependency in Kconfig. Without this, there will be
> errors while building the driver with COMPILE_TEST only.

You may drop the last sentence, I don't think it's entirely correct.

> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig     |  2 ++
>  drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..cc9ad41c63aa 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -64,6 +64,8 @@ config QCOM_LLCC
>  	tristate "Qualcomm Technologies, Inc. LLCC driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	select REGMAP_MMIO
> +	select NVMEM
> +	select QCOM_SCM

I don't see anything your patch that warrants adding QCOM_SCM here,
is it needed, should it be a separate commit?

>  	help
>  	  Qualcomm Technologies, Inc. platform specific
>  	  Last Level Cache Controller(LLCC) driver for platforms such as,
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 6cf373da5df9..3c29612da1c5 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
> +{
> +	int ret;
> +
> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
> +	if (ret == -ENOENT) {
> +		*cfg_index = 0;
> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int qcom_llcc_remove(struct platform_device *pdev)
>  {
>  	/* Set the global pointer to a error code to avoid referencing it */
> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret, i;
>  	struct platform_device *llcc_edac;
> -	const struct qcom_llcc_config *cfg;
> +	const struct qcom_llcc_config *cfg, *entry;
>  	const struct llcc_slice_config *llcc_cfg;
>  	u32 sz;
> +	u8 cfg_index;
>  	u32 version;
>  	struct regmap *regmap;
> +	u32 num_entries = 0;
>  
>  	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  
>  	drv_data->version = version;
>  
> -	llcc_cfg = cfg[0]->sct_data;
> -	sz = cfg[0]->size;
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
> +	if (ret)
> +		goto err;
> +
> +	for (entry = cfg; entry->sct_data; entry++, num_entries++)
> +		;

This is still unnecessarily "clever":
"For each valid entry, do nothing, while incrementing num_entries".

How about just writing:
"For each valid entry, increment num_entries"

	for (entry = cfg; entry->sct_data; entry++)
		num_entries++;


> +	if (cfg_index >= num_entries || cfg_index < 0) {

cfg_index is an unsiged number, so it's unlikely to be negative.

Also, "cfg_index" and "num_entries" are values in the same domain, so
keeping their names related is beneficial - i.e. rename num_entries to
num_cfgs.

Regards,
Bjorn

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	llcc_cfg = cfg[cfg_index].sct_data;
> +	sz = cfg[cfg_index].size;
>  
>  	for (i = 0; i < sz; i++)
>  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
> -- 
> 2.40.1
> 
