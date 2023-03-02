Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2E6A81D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCBMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:01:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71220A261;
        Thu,  2 Mar 2023 04:01:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73D731FB;
        Thu,  2 Mar 2023 04:02:38 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026B73F587;
        Thu,  2 Mar 2023 04:01:53 -0800 (PST)
Message-ID: <7db8f057-e1d8-101d-19f4-1d4efb900f1f@arm.com>
Date:   Thu, 2 Mar 2023 12:01:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] perf: arm_cspmu: Fix compiler warning
Content-Language: en-US
To:     Besar Wicaksono <bwicaksono@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com
References: <20230301225657.30211-1-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230301225657.30211-1-bwicaksono@nvidia.com>
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

On 01/03/2023 22:56, Besar Wicaksono wrote:
> Fix following compiler warning message
>    | smatch warnings:
>    | drivers/perf/arm_cspmu/arm_cspmu.c:1075 arm_cspmu_find_cpu_container()
>    |    warn: variable dereferenced before check 'cpu_dev' (see line 1073)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302191227.kc0V8fM7-lkp@intel.com/
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e31302ab7e37..a3f1c410b417 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1078,12 +1078,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
>   static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>   {
>   	u32 acpi_uid;
> -	struct device *cpu_dev = get_cpu_device(cpu);
> -	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
> +	struct device *cpu_dev;
> +	struct acpi_device *acpi_dev;
>   
> +	cpu_dev = get_cpu_device(cpu);
>   	if (!cpu_dev)
>   		return -ENODEV;
>   
> +	acpi_dev = ACPI_COMPANION(cpu_dev);
>   	while (acpi_dev) {
>   		if (!strcmp(acpi_device_hid(acpi_dev),
>   			    ACPI_PROCESSOR_CONTAINER_HID) &&
> 
> base-commit: 7f7a8831520f12a3cf894b0627641fad33971221

