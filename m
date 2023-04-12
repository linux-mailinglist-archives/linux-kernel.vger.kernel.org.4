Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB206DF43C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDLLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDLLv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E483FC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF8963392
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83743C433D2;
        Wed, 12 Apr 2023 11:51:37 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:51:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDabRr/yyakrrDDO@arm.com>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:32:38AM +0800, Baoquan He wrote:
> On 04/07/23 at 10:24am, Baoquan He wrote:
> ......
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 66e70ca47680..307263c01292 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
> >  
> >  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> >  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> > +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
> >  
> >  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> >  
> > @@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >   */
> >  static void __init reserve_crashkernel(void)
> >  {
> > -	unsigned long long crash_base, crash_size;
> > -	unsigned long long crash_low_size = 0;
> > +	unsigned long long crash_base, crash_size, search_base;
> >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > +	unsigned long long crash_low_size = 0;
> >  	char *cmdline = boot_command_line;
> > -	int ret;
> >  	bool fixed_base = false;
> > +	bool high = false;
> > +	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >  		return;
> > @@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
> >  		else if (ret)
> >  			return;
> >  
> > +		search_base = CRASH_HIGH_SEARCH_BASE;
> 
> Here, I am hesitant if a conditional check is needed as below. On
> special system where both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 
> are disabled, there's only low memory, means its arm64_dma_phys_limit
> equals to (PHYS_MASK + 1). In this case, whatever the crashkernel= is,
> it can search the whole system memory for available crashkernel region.
> Maybe it's fine since it's not big deal, the memory regoin can be found
> anyway.
> 
>   		crash_max = CRASH_ADDR_HIGH_MAX;
> 		if (crash_max != CRASH_ADDR_LOW_MAX)
> 			search_base = CRASH_HIGH_SEARCH_BASE;

Does x86 do anything different here or they just can't disable
ZONE_DMA32? I'd be tempted to instead define CRASH_ADDR_LOW_MAX as
min(SZ_4G, arm64_dma_phys_limit) so that the crashkernel=,high semantics
are still preserved irrespective of how the kernel was built.

There's also the difference between what the current kernel vs the kdump
kernel. I don't think there's a strong requirement that they have the
same config options, in which case it may be safer to just honour the 4G
boundary.

Otherwise the patch looks fine. Whether you want to add the min limit
above:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
