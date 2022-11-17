Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83762D651
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiKQJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiKQJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:19:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A01DE1E9;
        Thu, 17 Nov 2022 01:19:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDFC7D6E;
        Thu, 17 Nov 2022 01:19:25 -0800 (PST)
Received: from [10.57.40.76] (unknown [10.57.40.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE8CA3F663;
        Thu, 17 Nov 2022 01:19:17 -0800 (PST)
Message-ID: <1c86647f-a479-cfa9-3ac6-d5001f7843b7@arm.com>
Date:   Thu, 17 Nov 2022 09:19:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] perf: arm_cspmu: Fix module cyclic dependency
To:     Besar Wicaksono <bwicaksono@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, ywan@nvidia.com
References: <20221116203952.34168-1-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221116203952.34168-1-bwicaksono@nvidia.com>
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

On 16/11/2022 20:39, Besar Wicaksono wrote:
> Build on arm64 allmodconfig failed with:
>    | depmod: ERROR: Cycle detected: arm_cspmu -> nvidia_cspmu -> arm_cspmu
>    | depmod: ERROR: Found 2 modules in dependency cycles!
> 
> The arm_cspmu.c provides standard functions to operate the PMU and the
> vendor code provides vendor specific attributes. Both need to be built as
> single kernel module.
> 
> Update the makefile to compile sources under arm_cspmu into one module.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>   drivers/perf/arm_cspmu/Makefile | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> index 641db85c018b..fedb17df982d 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -2,6 +2,5 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0
>   
> -obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
> -	arm_cspmu.o \
> -	nvidia_cspmu.o
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
> +arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
> 

Reviewed-and-Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> base-commit: 9500fc6e9e6077616c0dea0f7eb33138be94ed0c

