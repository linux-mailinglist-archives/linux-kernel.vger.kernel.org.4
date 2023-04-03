Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685AE6D42FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjDCLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjDCLJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:09:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F9412071
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:09:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pqp4m4llGz6J6lN;
        Mon,  3 Apr 2023 19:07:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 12:08:57 +0100
Date:   Mon, 3 Apr 2023 12:08:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <catalin.marinas@arm.com>, <kernel-team@android.com>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <f.fangjian@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 2/2] drivers/perf: hisi: add NULL check for name
Message-ID: <20230403120856.000027d7@Huawei.com>
In-Reply-To: <20230403081423.62460-3-hejunhao3@huawei.com>
References: <20230403081423.62460-1-hejunhao3@huawei.com>
        <20230403081423.62460-3-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 16:14:23 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> When allocations fails that can be NULL now.
> 
> If the name provided is NULL, then the initialization process of the PMU
> type and dev will be skipped in function perf_pmu_register().
> Consequently, the PMU will not be able to register into the kernel.
> Moreover, in the case of unregister the PMU, the function device_del()
> will need to handle NULL pointers, which potentially can cause issues.

If you could be more specific in what the problem is wrt to a NULL pointer here
that would be great.  Given there is code to skip the device registration
without it being an error, I'd expect the release flow to be safe in that condition.

Seems like a sensible change even without that. So with some more info
feel free to add

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> So move this allocation above the cpuhp_state_add_instance() and directly
> return if it does fail.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 17 ++++++++++-------
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  7 +++++--
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 11 +++++------
>  3 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index 8a3d74ddcd6d..ffb039d05d07 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -499,13 +499,6 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
> -				       &ddrc_pmu->node);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Error %d registering hotplug;\n", ret);
> -		return ret;
> -	}
> -
>  	if (ddrc_pmu->identifier >= HISI_PMU_V2)
>  		name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  				      "hisi_sccl%u_ddrc%u_%u",
> @@ -516,6 +509,16 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
>  				      "hisi_sccl%u_ddrc%u", ddrc_pmu->sccl_id,
>  				      ddrc_pmu->index_id);
>  
> +	if (!name)
> +		return -ENOMEM;
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
> +				       &ddrc_pmu->node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering hotplug;\n", ret);
> +		return ret;
> +	}
> +
>  	hisi_pmu_init(ddrc_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
> diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> index 5701a84edb0e..15caf99e1eef 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> @@ -510,6 +510,11 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
> +			      hha_pmu->sccl_id, hha_pmu->index_id);
> +	if (!name)
> +		return -ENOMEM;
> +
>  	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
>  				       &hha_pmu->node);
>  	if (ret) {
> @@ -517,8 +522,6 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
> -			      hha_pmu->sccl_id, hha_pmu->index_id);
>  	hisi_pmu_init(hha_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index 68596b566344..794dbcd19b7a 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -544,6 +544,11 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
> +			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
> +	if (!name)
> +		return -ENOMEM;
> +
>  	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>  				       &l3c_pmu->node);
>  	if (ret) {
> @@ -551,12 +556,6 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/*
> -	 * CCL_ID is used to identify the L3C in the same SCCL which was
> -	 * used _UID by mistake.
> -	 */
> -	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
> -			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
>  	hisi_pmu_init(l3c_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);

