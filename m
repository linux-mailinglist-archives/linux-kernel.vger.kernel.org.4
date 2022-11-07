Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C961FB10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiKGRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiKGRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:18:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC16209BF;
        Mon,  7 Nov 2022 09:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 093D0611C2;
        Mon,  7 Nov 2022 17:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B513C433C1;
        Mon,  7 Nov 2022 17:18:45 +0000 (UTC)
Date:   Mon, 7 Nov 2022 17:18:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <Y2k98lFhtUP2u1VM@arm.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2522b11e593f239..65a2c3a22a4b57d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -843,7 +843,7 @@
>  			available.
>  			It will be ignored if crashkernel=X is specified.
>  	crashkernel=size[KMG],low
> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
>  			above 4G, that cause second kernel crash on system
>  			that require some amount of low memory, e.g. swiotlb
> @@ -857,12 +857,6 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  
> -			[KNL, ARM64] range in low memory.
> -			This one lets the user specify a low range in the
> -			DMA zone for the crash dump kernel.
> -			It will be ignored when crashkernel=X,high is not used
> -			or memory reserved is located in the DMA zones.
> -
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84e5a61a0b..5390f361208ccf7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>  
> +/*
> + * This is an empirical value in x86_64 and taken here directly. Please
> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> + * details.
> + */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> +
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
>  	unsigned long long low_base;
> @@ -147,7 +155,9 @@ static void __init reserve_crashkernel(void)
>  		 * is not allowed.
>  		 */
>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> -		if (ret && (ret != -ENOENT))
> +		if (ret == -ENOENT)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
>  			return;

BTW, since we want a default low allocation, I think we should change
the checking logic slightly. Currently we have:

	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
		...

If crash_base is just below CRASH_ADDR_LOW_MAX, we deem it sufficient
but a crashkernel trying to allocate 64MB of swiotlb may fail. So maybe
change this to crash_base >= CRASH_ADDR_LOW_MAX - crash_low_size.

-- 
Catalin
