Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C665D117
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjADLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjADLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:00:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 493645F43
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:59:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 814A51FB;
        Wed,  4 Jan 2023 03:00:24 -0800 (PST)
Received: from bogus (unknown [10.163.75.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A32793F587;
        Wed,  4 Jan 2023 02:59:39 -0800 (PST)
Date:   Wed, 4 Jan 2023 10:59:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [PATCH -next v3] drivers: base: cacheinfo: fix shared_cpu_map
Message-ID: <20230104105939.vdiq77xbn45agj22@bogus>
References: <20221228032419.1763-1-yongxuan.wang@sifive.com>
 <20221228032419.1763-2-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228032419.1763-2-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:24:19AM +0000, Yong-Xuan Wang wrote:
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

Just curious to know if this is just Qemu config or a real platform.
I had intentionally not supported this to just to get to know when such
h/w appears in the real world 😁.

> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  drivers/base/cacheinfo.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 950b22cdb5f7..dfa804bcf3cc 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -256,7 +256,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf, *sib_leaf;
> -	unsigned int index;
> +	unsigned int index, sib_index;
>  	int ret = 0;
>  
>  	if (this_cpu_ci->cpu_map_populated)
> @@ -284,11 +284,12 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>  
>  			if (i == cpu || !sib_cpu_ci->info_list)
>  				continue;/* skip if itself or no cacheinfo */
> -
> -			sib_leaf = per_cpu_cacheinfo_idx(i, index);
> -			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> -				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
> -				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
> +			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
> +				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);
> +				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> +					cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
> +					cpumask_set_cpu(i, &this_leaf->shared_cpu_map);

Does it make sense to break here once we match as it is unlikely to match
with any other indices ?

> +				}
>  			}
>  		}
>  		/* record the maximum cache line size */
> @@ -302,7 +303,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>  static void cache_shared_cpu_map_remove(unsigned int cpu)
>  {
>  	struct cacheinfo *this_leaf, *sib_leaf;
> -	unsigned int sibling, index;
> +	unsigned int sibling, index, sib_index;
>  
>  	for (index = 0; index < cache_leaves(cpu); index++) {
>  		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
> @@ -313,9 +314,13 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
>  			if (sibling == cpu || !sib_cpu_ci->info_list)
>  				continue;/* skip if itself or no cacheinfo */
>  
> -			sib_leaf = per_cpu_cacheinfo_idx(sibling, index);
> -			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
> -			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
> +			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
> +				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);
> +				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> +					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
> +					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);

Same comment as above.

-- 
Regards,
Sudeep
