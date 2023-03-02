Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34466A8AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCBVCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCBVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:02:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBD2DE61;
        Thu,  2 Mar 2023 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KhVHEoAb9JfdAO2DxL948x9Ihcm4qsbUc5kdCrwD8u8=; b=WhSAR761ty2OjAg8YyLpdRDhaH
        Naamu6793d2nTTdzrrkTgYTO5dwD9VyUW0Pir8DDLItM8dwaAMuKq9nN0hkZla7PoZuv8oiX/MLKQ
        HYRmmgVqPInORzair0b/kr2gPGZm/iKZUErPau2XL6+9Ov/DzE2opH8E0iAGKGVRno7oHtYQl5PrI
        QyOASTAvv7ezMIYAPY2HCIp8VLK0m610yDL2TwjxJxzt0NXnPPcHm9Ulbd0a+CBKDeMqIMLwy0101
        j3OhsulzlNaYUnw91t6AfZiC/h7y/n2m+EMY31UKn8aLaQ+PFBKLW17kJdetTQRiG94qispzLs+1a
        jPzSj21Q==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXq4W-003JoZ-4L; Thu, 02 Mar 2023 21:02:40 +0000
Message-ID: <2e5bb985-782b-db43-b555-dabee885a737@infradead.org>
Date:   Thu, 2 Mar 2023 13:02:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] perf: arm_cspmu: Fix variable dereference warning
Content-Language: en-US
To:     Besar Wicaksono <bwicaksono@nvidia.com>, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com
References: <20230302205701.35323-1-bwicaksono@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230302205701.35323-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/23 12:57, Besar Wicaksono wrote:
> Fix warning message from smatch tool:
>   | smatch warnings:
>   | drivers/perf/arm_cspmu/arm_cspmu.c:1075 arm_cspmu_find_cpu_container()
>   |    warn: variable dereferenced before check 'cpu_dev' (see line 1073)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302191227.kc0V8fM7-lkp@intel.com/
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Changes from v1:
>  * Update commit subject and description
>  * Added Reviewed-by from Suzuki
> v1: https://lore.kernel.org/linux-arm-kernel/20230301225657.30211-1-bwicaksono@nvidia.com/T/#u
> 
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e31302ab7e37..a3f1c410b417 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1078,12 +1078,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
>  static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>  {
>  	u32 acpi_uid;
> -	struct device *cpu_dev = get_cpu_device(cpu);
> -	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
> +	struct device *cpu_dev;
> +	struct acpi_device *acpi_dev;
>  
> +	cpu_dev = get_cpu_device(cpu);
>  	if (!cpu_dev)
>  		return -ENODEV;
>  
> +	acpi_dev = ACPI_COMPANION(cpu_dev);
>  	while (acpi_dev) {
>  		if (!strcmp(acpi_device_hid(acpi_dev),
>  			    ACPI_PROCESSOR_CONTAINER_HID) &&
> 
> base-commit: 7f7a8831520f12a3cf894b0627641fad33971221

-- 
~Randy
