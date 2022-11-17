Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5F62D649
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiKQJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiKQJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:18:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F97F6B388;
        Thu, 17 Nov 2022 01:18:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061A4D6E;
        Thu, 17 Nov 2022 01:18:24 -0800 (PST)
Received: from [10.57.40.76] (unknown [10.57.40.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23443F663;
        Thu, 17 Nov 2022 01:18:15 -0800 (PST)
Message-ID: <5bdfe519-e6fe-7fed-2731-40d490e1f9bb@arm.com>
Date:   Thu, 17 Nov 2022 09:18:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] perf: arm_cspmu: Fix build failure on x86_64
To:     Besar Wicaksono <bwicaksono@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sfr@canb.auug.org.au,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        ywan@nvidia.com
References: <20221116190455.55651-1-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221116190455.55651-1-bwicaksono@nvidia.com>
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

On 16/11/2022 19:04, Besar Wicaksono wrote:
> Building on x86_64 allmodconfig failed:
>    | drivers/perf/arm_cspmu/arm_cspmu.c:1114:29: error: implicit
>    |    declaration of function 'get_acpi_id_for_cpu'
> 
> get_acpi_id_for_cpu is a helper function from ARM64.
> Fix by adding ARM64 dependency.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

nit: Not sure if we have a stable commit id to mark "fixes".
May be that is not needed until it hits upstream.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/perf/arm_cspmu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> index 058223bef661..0b316fe69a45 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -4,7 +4,7 @@
>   
>   config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>   	tristate "ARM Coresight Architecture PMU"
> -	depends on ACPI
> +	depends on ARM64 && ACPI
>   	depends on ACPI_APMT || COMPILE_TEST
>   	help
>   	  Provides support for performance monitoring unit (PMU) devices
> 
> base-commit: 9500fc6e9e6077616c0dea0f7eb33138be94ed0c

