Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104AE5B6BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiIMKpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiIMKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:45:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51C7F13F24;
        Tue, 13 Sep 2022 03:45:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665341063;
        Tue, 13 Sep 2022 03:45:31 -0700 (PDT)
Received: from [10.57.15.170] (unknown [10.57.15.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBCC3F71A;
        Tue, 13 Sep 2022 03:45:22 -0700 (PDT)
Message-ID: <aa96eb55-4925-221f-1fb2-8226ea347c22@arm.com>
Date:   Tue, 13 Sep 2022 11:45:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dma-contiguous: add optional cma_name for cma= kernel
 parameter
To:     Nate Drude <nate.d@variscite.com>, iommu@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eran.m@variscite.com
References: <20220912163805.4113238-1-nate.d@variscite.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220912163805.4113238-1-nate.d@variscite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-12 17:38, Nate Drude wrote:
> When cma is defined in the device tree, the device tree node
> name is used as the cma name. In the following example, the cma
> will be named 'linux,cma':
> 
> linux,cma {
> 	compatible = "shared-dma-pool";
> 	reusable;
> 	size = <0 0x3c000000>;
> 	alloc-ranges = <0 0x40000000 0 0xC0000000>;
> 	linux,cma-default;
> };
> 
> And a device /dev/dma_heap/linux,cma is created.
> 
> However, when cma is provided by command line, a default
> name of 'reserved' is used, and the device path changes to
> /dev/dma_heap/reserved.

If userspace expects the CMA heap driver to expose a consistent name for 
CMA heaps, shouldn't it be the CMA heap driver's responsibility to 
expose a consistent name for CMA heaps? Tinkering with the core CMA code 
doesn't feel like the right approach.

Furthermore, given that DT reserved-memory nodes carrying the 
"linux-cma-default" property equally can (and do) have different names 
as well, that or fixing userspace really are the only robust options.

Thanks,
Robin.

> This is problematic because some user space applications,
> like gstreamer plugins, are expecting /dev/dma_heap/linux,cma.
> 
> This parameter allows overriding the default 'reserved' name.
> 
> Signed-off-by: Nate Drude <nate.d@variscite.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  7 +++++++
>   kernel/dma/contiguous.c                       | 21 ++++++++++++++++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 51397a320f5e..975ec862d071 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -644,6 +644,13 @@
>   			altogether. For more information, see
>   			kernel/dma/contiguous.c
>   
> +	cma_name=	Override the cma heap name
> +			Format: <string>
> +			When passing the cma kernel parameter, the default
> +			cma name is 'reserved'. This parameter allows it to
> +			be overriden to align with the device tree name,
> +			like 'linux,cma'.
> +
>   	cma_pernuma=nn[MG]
>   			[ARM64,KNL,CMA]
>   			Sets the size of kernel per-numa memory area for
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..e89819ec183e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -74,6 +74,7 @@ static const phys_addr_t size_bytes __initconst =
>   static phys_addr_t  size_cmdline __initdata = -1;
>   static phys_addr_t base_cmdline __initdata;
>   static phys_addr_t limit_cmdline __initdata;
> +static char name_cmdline[CMA_MAX_NAME] = "reserved";
>   
>   static int __init early_cma(char *p)
>   {
> @@ -96,6 +97,24 @@ static int __init early_cma(char *p)
>   }
>   early_param("cma", early_cma);
>   
> +static int __init early_cma_name(char *p)
> +{
> +	if (!p) {
> +		pr_err("Config string not provided\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!strlen(p)) {
> +		pr_err("cma_name must have at least one character\n");
> +		return -EINVAL;
> +	}
> +
> +	snprintf(name_cmdline, CMA_MAX_NAME, p);
> +
> +	return 0;
> +}
> +early_param("cma_name", early_cma_name);
> +
>   #ifdef CONFIG_DMA_PERNUMA_CMA
>   
>   static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> @@ -231,7 +250,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   	int ret;
>   
>   	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed,
> -					"reserved", res_cma);
> +					name_cmdline, res_cma);
>   	if (ret)
>   		return ret;
>   
