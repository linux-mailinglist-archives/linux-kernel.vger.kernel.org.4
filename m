Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0564DF81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLORQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLORQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:16:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C5B7FAE9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:16:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAB5FEC;
        Thu, 15 Dec 2022 09:17:29 -0800 (PST)
Received: from [10.57.88.90] (unknown [10.57.88.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6F673F5A1;
        Thu, 15 Dec 2022 09:16:47 -0800 (PST)
Message-ID: <c10c9742-06d6-f56b-ea55-47f99b06ca32@arm.com>
Date:   Thu, 15 Dec 2022 17:16:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] iommu/renesas: Support riscv compile
Content-Language: en-GB
To:     guoren@kernel.org, palmer@dabbelt.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        iommu@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
References: <20221215073212.1966823-1-guoren@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221215073212.1966823-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 07:32, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> After riscv selects ARCH_RENESAS, we need to add ARM64 || ARM
> dependency here.

This effectively removes all the extra COMPILE_TEST coverage we've been 
enjoying. FWIW I prefer Geert's suggestion to separate the real 
functional dependency from implicit assumptions about ARCH_RENESAS, with 
something like:

	depends on ARCH_RENESAS || COMPILE_TEST
	depends on !GENERIC_ATOMIC64	#for IOMMU_IO_PGTABLE_LPAE

Thanks,
Robin.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5..746b95b9f345 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG
>   
>   config IPMMU_VMSA
>   	bool "Renesas VMSA-compatible IPMMU"
> +	depends on ARM64 || ARM
>   	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_LPAE
