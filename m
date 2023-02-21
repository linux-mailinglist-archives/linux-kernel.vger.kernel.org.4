Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4465869DFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjBUL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjBUL5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:57:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B92F02915D;
        Tue, 21 Feb 2023 03:57:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54A3BFEC;
        Tue, 21 Feb 2023 03:57:24 -0800 (PST)
Received: from [10.57.13.181] (unknown [10.57.13.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833D73F703;
        Tue, 21 Feb 2023 03:56:36 -0800 (PST)
Message-ID: <4cc935e2-8b24-8060-5070-fd6eb85f07b6@arm.com>
Date:   Tue, 21 Feb 2023 11:56:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v8 2/7] iommu/arm-smmu-v3: support ops registration for
 CDX bus
Content-Language: en-GB
To:     Nipun Gupta <nipun.gupta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com, will@kernel.org,
        joro@8bytes.org, masahiroy@kernel.org, ndesaulniers@google.com,
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
References: <20230217132830.3140439-1-nipun.gupta@amd.com>
 <20230217132830.3140439-3-nipun.gupta@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230217132830.3140439-3-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-17 13:28, Nipun Gupta wrote:

Nit: subject should be "iommu: Support ops registration for CDX bus", 
since this is no longer a driver-specific thing.

Thanks,
Robin.

> With new CDX bus supported for AMD FPGA devices on ARM
> platform, the bus requires registration for the SMMU v3
> driver.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>   drivers/iommu/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1fbe53354532..c2ff7754a4b3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -28,6 +28,7 @@
>   #include <linux/fsl/mc.h>
>   #include <linux/module.h>
>   #include <linux/cc_platform.h>
> +#include <linux/cdx/cdx_bus.h>
>   #include <trace/events/iommu.h>
>   #include <linux/sched/mm.h>
>   #include <linux/msi.h>
> @@ -129,6 +130,9 @@ static struct bus_type * const iommu_buses[] = {
>   #ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>   	&host1x_context_device_bus_type,
>   #endif
> +#ifdef CONFIG_CDX_BUS
> +	&cdx_bus_type,
> +#endif
>   };
>   
>   /*
