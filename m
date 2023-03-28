Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E006CBECD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC1MPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjC1MPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:15:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27D8D900E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:14:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B5E3C14;
        Tue, 28 Mar 2023 05:15:42 -0700 (PDT)
Received: from [10.34.100.129] (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4263F6C4;
        Tue, 28 Mar 2023 05:14:56 -0700 (PDT)
Message-ID: <bda4c7e6-a819-dfa4-7f1d-f9e3f6adbd23@arm.com>
Date:   Tue, 28 Mar 2023 14:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] cacheinfo: Fix LLC is not exported through sysfs
To:     Yicong Yang <yangyicong@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, sudeep.holla@arm.com, palmer@rivosinc.com,
        linux-kernel@vger.kernel.org
Cc:     prime.zeng@hisilicon.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com
References: <20230328114915.33340-1-yangyicong@huawei.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230328114915.33340-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong,
Thanks for the new version,

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

On 3/28/23 13:49, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI
> based arm64 server. This is because the LLC cacheinfo is partly reset
> when secondary CPUs boot up. On arm64 the primary cpu will allocate
> and setup cacheinfo:
> init_cpu_topology()
>    for_each_possible_cpu()
>      fetch_cache_info() // Allocate cacheinfo and init levels
> detect_cache_attributes()
>    cache_shared_cpu_map_setup()
>      if (!last_level_cache_is_valid()) // not valid, setup LLC
>        cache_setup_properties() // setup LLC
> 
> On secondary CPU boot up:
> detect_cache_attributes()
>    populate_cache_leaves()
>      get_cache_type() // Get cache type from clidr_el1,
>                       // for LLC type=CACHE_TYPE_NOCACHE
>    cache_shared_cpu_map_setup()
>      if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
>                                        // leave LLC's type=CACHE_TYPE_NOCACHE
> 
> The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
> test it's valid or not, but populate_cache_leaves() will only reset
> LLC's type, so we won't try to re-setup LLC's type and leave it
> CACHE_TYPE_NOCACHE and won't export it through sysfs.
> 
> This patch tries to fix this by not re-populating the cache leaves if
> the LLC is valid.
> 
> Fixes: 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - Get rid of the goto label, per Pierre
> Link: https://lore.kernel.org/all/20230323122528.16691-1-yangyicong@huawei.com/
> 
>   drivers/base/cacheinfo.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f6573c335f4c..f3903d002819 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -474,12 +474,18 @@ int detect_cache_attributes(unsigned int cpu)
>   
>   populate_leaves:
>   	/*
> -	 * populate_cache_leaves() may completely setup the cache leaves and
> -	 * shared_cpu_map or it may leave it partially setup.
> +	 * If LLC is valid the cache leaves were already populated so just go to
> +	 * update the cpu map.
>   	 */
> -	ret = populate_cache_leaves(cpu);
> -	if (ret)
> -		goto free_ci;
> +	if (!last_level_cache_is_valid(cpu)) {
> +		/*
> +		 * populate_cache_leaves() may completely setup the cache leaves and
> +		 * shared_cpu_map or it may leave it partially setup.
> +		 */
> +		ret = populate_cache_leaves(cpu);
> +		if (ret)
> +			goto free_ci;
> +	}
>   
>   	/*
>   	 * For systems using DT for cache hierarchy, fw_token
