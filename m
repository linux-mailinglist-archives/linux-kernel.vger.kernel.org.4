Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21232638D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKYPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:18:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 361FB20361;
        Fri, 25 Nov 2022 07:18:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F5142B;
        Fri, 25 Nov 2022 07:18:59 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CE23F587;
        Fri, 25 Nov 2022 07:18:50 -0800 (PST)
Date:   Fri, 25 Nov 2022 15:18:47 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Rob.Herring@arm.com, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Chen <peter.chen@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ACPI: PPTT: Update acpi_find_last_cache_level()
 to acpi_get_cache_info()
Message-ID: <20221125151847.ortklu4ptaftua6u@bogus>
References: <20221121171217.3581004-1-pierre.gondois@arm.com>
 <20221121171217.3581004-5-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171217.3581004-5-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:12:12PM +0100, Pierre Gondois wrote:
> acpi_find_last_cache_level() allows to find the last level of cache
> for a given CPU. The function is only called on arm64 ACPI based
> platforms to check for cache information that would be missing in
> the CLIDR_EL1 register.
> To allow populating (struct cpu_cacheinfo).num_leaves by only parsing
> a PPTT, update acpi_find_last_cache_level() to get the 'split_levels',
> i.e. the number of cache levels being split in data/instruction
> caches.
> 
> It is assumed that there will not be data/instruction caches above a
> unified cache.
> If a split level consist of one data cache and no instruction cache
> (or opposite), then the missing cache will still be populated
> by default with minimal cache information, and maximal cpumask
> (all non-existing caches have the same fw_token).
> 
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cacheinfo.c |  9 +++--
>  drivers/acpi/pptt.c           | 76 +++++++++++++++++++++++------------
>  include/linux/cacheinfo.h     |  8 ++--
>  3 files changed, 61 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index 97c42be71338..164255651d64 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -46,7 +46,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  int init_cache_level(unsigned int cpu)
>  {
>  	unsigned int ctype, level, leaves;
> -	int fw_level;
> +	int fw_level, ret;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  
>  	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
> @@ -61,8 +61,11 @@ int init_cache_level(unsigned int cpu)
>  
>  	if (acpi_disabled)
>  		fw_level = of_find_last_cache_level(cpu);
> -	else
> -		fw_level = acpi_find_last_cache_level(cpu);
> +	else {

You need to add braces to if as well in such cases. I think checkpatch
might tell you that. Just found this by chance.

Anyways, this looks good to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>


-- 
Regards,
Sudeep
