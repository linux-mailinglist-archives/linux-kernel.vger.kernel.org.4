Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B406652E28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiLUJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:00:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B85F18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:00:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 040462F4;
        Wed, 21 Dec 2022 01:01:29 -0800 (PST)
Received: from [10.57.44.6] (unknown [10.57.44.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BC293F71A;
        Wed, 21 Dec 2022 01:00:46 -0800 (PST)
Message-ID: <9cfb3356-3e3b-e9f3-1e16-ff02790e5829@arm.com>
Date:   Wed, 21 Dec 2022 10:00:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 1/1] drivers: base: cacheinfo: fix shared_cpu_map
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221219105132.27690-1-yongxuan.wang@sifive.com>
 <20221219105132.27690-2-yongxuan.wang@sifive.com>
Content-Language: en-US
In-Reply-To: <20221219105132.27690-2-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yong-Xuan,
Except for the nit below, I tried the patch and everything seemed ok, so
with that:
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Regards,
Pierre

On 12/19/22 11:51, Yong-Xuan Wang wrote:
> The cacheinfo sets up the shared_cpu_map by checking whether the caches
> with the same index are shared between CPUs. However, this will trigger
> slab-out-of-bounds access if the CPUs do not have the same cache hierarchy.
> Another problem is the mismatched shared_cpu_map when the shared cache does
> not have the same index between CPUs.
> 
> CPU0	I	D	L3
> index	0	1	2	x
> 	^	^	^	^
> index	0	1	2	3
> CPU1	I	D	L2	L3
> 
> This patch checks each cache is shared with all caches on other CPUs.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>   drivers/base/cacheinfo.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 950b22cdb5f7..d38f80f6fff1 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -256,7 +256,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>   {
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	struct cacheinfo *this_leaf, *sib_leaf;
> -	unsigned int index;
> +	unsigned int index, sib_index;
>   	int ret = 0;
>   
>   	if (this_cpu_ci->cpu_map_populated)
> @@ -284,11 +284,12 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>   
>   			if (i == cpu || !sib_cpu_ci->info_list)
>   				continue;/* skip if itself or no cacheinfo */
> -
> -			sib_leaf = per_cpu_cacheinfo_idx(i, index);
> -			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> -				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
> -				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
> +			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
> +				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);;

It seems there are 2 ';' above (same in the block below).

> +				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> +					cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
> +					cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
> +				}
>   			}
>   		}
>   		/* record the maximum cache line size */
> @@ -302,7 +303,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>   static void cache_shared_cpu_map_remove(unsigned int cpu)
>   {
>   	struct cacheinfo *this_leaf, *sib_leaf;
> -	unsigned int sibling, index;
> +	unsigned int sibling, index, sib_index;
>   
>   	for (index = 0; index < cache_leaves(cpu); index++) {
>   		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
> @@ -313,9 +314,13 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
>   			if (sibling == cpu || !sib_cpu_ci->info_list)
>   				continue;/* skip if itself or no cacheinfo */
>   
> -			sib_leaf = per_cpu_cacheinfo_idx(sibling, index);
> -			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
> -			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
> +			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
> +				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);;
> +				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> +					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
> +					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
> +				}
> +			}
>   		}
>   	}
>   }
