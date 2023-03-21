Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F26C2E77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCUKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCUKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:14:36 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBEE37B6E;
        Tue, 21 Mar 2023 03:14:33 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L7RnWJ018738;
        Tue, 21 Mar 2023 10:00:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=2dv+4RM71KuzbfohiEivfM/kPLjSREHD07ie47ASFQw=;
 b=zn6CkRMJtoBt61tT3BGCWhezzDiZn2PFiQBxFhjYBuY2kESApWy0dUZQ6g48pRbbhbxL
 t7edCewO9Bcanb5IQqlIlvTsh4F4g8X+RMfNa4HIIPPvJovryVBFgq89C1VWqZ3oBpdh
 yw3/in2V7RMPftaY8I9jdyyREmsVSEYNCVCq0lxTSiFRhGmUIu0ioAtVD4lwzEb3cNQ7
 g21PH9NUuEhtu/1nYPLULm6Y1DAuwWjBkx6MIFeZSoQP0YzUD1gzQ2sZx96vMGCXgcoF
 of7ZcohCyV9iKGhFUMfiKzRYeUheyTMMaVFE3KfPx9u7yuurKN2UCg/whW/06XAUjMRA JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pf875rnsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 10:00:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37DA510002A;
        Tue, 21 Mar 2023 10:00:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2960620FA43;
        Tue, 21 Mar 2023 10:00:05 +0100 (CET)
Received: from [10.252.5.41] (10.252.5.41) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 21 Mar
 2023 10:00:03 +0100
Message-ID: <e3644e19-7453-440b-00dc-781104ca83cf@foss.st.com>
Date:   Tue, 21 Mar 2023 10:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] remoteproc: stm32: Call of_node_put() on iteration
 error
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <andersson@kernel.org>
CC:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <patrice.chotard@foss.st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <arnaud.pouliquen@st.com>,
        <hongxing.zhu@nxp.com>, <peng.fan@nxp.com>,
        <shengjiu.wang@nxp.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
 <20230320221826.2728078-2-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230320221826.2728078-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.5.41]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_06,2023-03-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 3/20/23 23:18, Mathieu Poirier wrote:
> Function of_phandle_iterator_next() calls of_node_put() on the last
> device_node it iterated over, but when the loop exits prematurely it has
> to be called explicitly> 
> Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/stm32_rproc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 7d782ed9e589..23c1690b8d73 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>  	while (of_phandle_iterator_next(&it) == 0) {
>  		rmem = of_reserved_mem_lookup(it.node);
>  		if (!rmem) {
> +			of_node_put(it.node);
>  			dev_err(dev, "unable to acquire memory-region\n");
>  			return -EINVAL;
>  		}
>  
>  		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
> +			of_node_put(it.node);
>  			dev_err(dev, "memory region not valid %pa\n",
>  				&rmem->base);
>  			return -EINVAL;
> @@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>  							   it.node->name);
>  		}
>  
> -		if (!mem)
> +		if (!mem) {
> +			of_node_put(it.node);
>  			return -ENOMEM;
> +		}

Good catch!

Looking in code I don't see that we call of_node_put() when we release the
carveouts. 
Please tell me if I'm wrong but look to me that we should also call of_node_put()
in mem->release() op, in drivers. 

This one remains valid.
reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud


>  
>  		rproc_add_carveout(rproc, mem);
>  		index++;
