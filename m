Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5905675028
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjATJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:05:32 -0500
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 01:05:26 PST
Received: from zeeaster.vergenet.net (zeeaster.vergenet.net [206.189.110.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04C79EAD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:05:26 -0800 (PST)
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by zeeaster.vergenet.net (Postfix) with ESMTPSA id AFDB420099;
        Fri, 20 Jan 2023 09:04:50 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
        id 4606D94030F; Fri, 20 Jan 2023 10:04:49 +0100 (CET)
Date:   Fri, 20 Jan 2023 10:04:49 +0100
From:   Simon Horman <horms@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y8pZMQoJOdgz+Xba@vergenet.net>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117034921.185150-2-bhe@redhat.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region up down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> This looks very strange because we have two low memory regions
> [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> why that happened.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region above the high and low memory boundary. If failed, try reserving
> the suitable region below the boundary. Like this, the crashkernel high
> region will only exist in high memory, and crashkernel low region only
> exists in low memory. The reservation behaviour for crashkernel=,high is
> clearer and simpler.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/init.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..26a05af2bfa8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_base, crash_size, search_base;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_low_size = 0;
>  	char *cmdline = boot_command_line;
> -	int ret;
>  	bool fixed_base = false;
> +	bool high = false;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_ADDR_LOW_MAX;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
> +		high = true;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
>  		return;
> @@ -166,31 +169,44 @@ static void __init reserve_crashkernel(void)
>  	/* User specifies base address explicitly. */
>  	if (crash_base) {
>  		fixed_base = true;
> +		search_base = crash_base;
>  		crash_max = crash_base + crash_size;
>  	}
>  
>  retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> +					       search_base, crash_max);
>  	if (!crash_base) {
> +		if (fixed_base) {
> +			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
> +				search_base, crash_max);
> +			return;
> +		}
> +
>  		/*
>  		 * If the first attempt was for low memory, fall back to
>  		 * high memory, the minimum required low memory will be
>  		 * reserved later.
>  		 */
> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
>  
> +		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {

nit: unnecessary (and inconsistent with code just above) parentheses.

> +			crash_max = CRASH_ADDR_LOW_MAX;
> +			search_base = 0;
> +			goto retry;
> +		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> +	     reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
