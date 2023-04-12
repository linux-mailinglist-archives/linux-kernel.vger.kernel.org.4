Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A966DF3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDLLmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:42:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEC61B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:41:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 000EFD75;
        Wed, 12 Apr 2023 04:41:59 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0573F73F;
        Wed, 12 Apr 2023 04:41:13 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:40:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] cacheinfo: Add arm64 early level initializer
 implementation
Message-ID: <20230412114011.4gexyfnl6hu236kp@bogus>
References: <20230406233926.1670094-1-rrendec@redhat.com>
 <20230406233926.1670094-3-rrendec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406233926.1670094-3-rrendec@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:39:26PM -0400, Radu Rendec wrote:
> This patch adds an architecture specific early cache level detection
> handler for arm64. This is basically the CLIDR_EL1 based detection that
> was previously done (only) in init_cache_level().
> 
> This is part of a patch series that attempts to further the work in
> commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> Previously, in the absence of any DT/ACPI cache info, architecture
> specific cache detection and info allocation for secondary CPUs would
> happen in non-preemptible context during early CPU initialization and
> trigger a "BUG: sleeping function called from invalid context" splat on
> an RT kernel.
> 
> This patch does not solve the problem completely for RT kernels. It
> relies on the assumption that on most systems, the CPUs are symmetrical
> and therefore have the same number of cache leaves. The cacheinfo memory
> is allocated early (on the primary CPU), relying on the new handler. If
> later (when CLIDR_EL1 based detection runs again on the secondary CPU)
> the initial assumption proves to be wrong and the CPU has in fact more
> leaves, the cacheinfo memory is reallocated, and that still triggers a
> splat on an RT kernel.
> 
> In other words, asymmetrical CPU systems *must* still provide cacheinfo
> data in DT/ACPI to avoid the splat on RT kernels (unless secondary CPUs
> happen to have less leaves than the primary CPU). But symmetrical CPU
> systems (the majority) can now get away without the additional DT/ACPI
> data and rely on CLIDR_EL1 based detection.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  arch/arm64/kernel/cacheinfo.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index c307f69e9b55..520d17e4ebe9 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -38,21 +38,37 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  	this_leaf->type = type;
>  }
>  
> -int init_cache_level(unsigned int cpu)
> +static void detect_cache_level(unsigned int *level, unsigned int *leaves)
>  {
> -	unsigned int ctype, level, leaves;
> -	int fw_level, ret;
> -	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	unsigned int ctype;
>  
> -	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
> -		ctype = get_cache_type(level);
> +	for (*level = 1, *leaves = 0; *level <= MAX_CACHE_LEVEL; (*level)++) {
> +		ctype = get_cache_type(*level);
>  		if (ctype == CACHE_TYPE_NOCACHE) {
> -			level--;
> +			(*level)--;
>  			break;
>  		}
>  		/* Separate instruction and data caches */
> -		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
> +		*leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
>  	}
> +}

I prefer to use locals and assign the value to keep it simple/easy to follow.
Compiler can/will optimise this anyway. But I am fine either way.

I need Will's(or Catalin's)  ack if I have to take the changes via Greg's tree.

-- 
Regards,
Sudeep
