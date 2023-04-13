Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64D6E0816
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDMHrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDMHrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49B8689
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681371961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVRSyY7qP0no9q+oe8X0C+6WBuNwa4/GmgSpnscCToA=;
        b=TNEw+N02KfjzmrGA8Y1xgHuQK4Xy3bT/yhRQ0ttDYGZK04athIrNMv5Og5jixTg9FD6d5N
        EvWcrGHm1H9xlhk80SvyC/3Iu0UekjsKMkdAas55SyjFAIr6WrzWUCebRBFDUFNueVC3RD
        w4OWxGA1AxofYrYfTf0WrtZ3ekfcTbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-G5gsqHDqMR27jin3hdk7Tg-1; Thu, 13 Apr 2023 03:45:55 -0400
X-MC-Unique: G5gsqHDqMR27jin3hdk7Tg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 408758996E0;
        Thu, 13 Apr 2023 07:45:55 +0000 (UTC)
Received: from localhost (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3FF492B00;
        Thu, 13 Apr 2023 07:45:53 +0000 (UTC)
Date:   Thu, 13 Apr 2023 15:45:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
 <ZDabRr/yyakrrDDO@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDabRr/yyakrrDDO@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/23 at 12:51pm, Catalin Marinas wrote:
> On Fri, Apr 07, 2023 at 10:32:38AM +0800, Baoquan He wrote:
> > On 04/07/23 at 10:24am, Baoquan He wrote:
> > ......
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 66e70ca47680..307263c01292 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
> > >  
> > >  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> > >  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> > > +#define CRASH_HIGH_SEARCH_BASE		SZ_4G
> > >  
> > >  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> > >  
> > > @@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> > >   */
> > >  static void __init reserve_crashkernel(void)
> > >  {
> > > -	unsigned long long crash_base, crash_size;
> > > -	unsigned long long crash_low_size = 0;
> > > +	unsigned long long crash_base, crash_size, search_base;
> > >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > > +	unsigned long long crash_low_size = 0;
> > >  	char *cmdline = boot_command_line;
> > > -	int ret;
> > >  	bool fixed_base = false;
> > > +	bool high = false;
> > > +	int ret;
> > >  
> > >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> > >  		return;
> > > @@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
> > >  		else if (ret)
> > >  			return;
> > >  
> > > +		search_base = CRASH_HIGH_SEARCH_BASE;
> > 
> > Here, I am hesitant if a conditional check is needed as below. On
> > special system where both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 
> > are disabled, there's only low memory, means its arm64_dma_phys_limit
> > equals to (PHYS_MASK + 1). In this case, whatever the crashkernel= is,
> > it can search the whole system memory for available crashkernel region.
> > Maybe it's fine since it's not big deal, the memory regoin can be found
> > anyway.
> > 
> >   		crash_max = CRASH_ADDR_HIGH_MAX;
> > 		if (crash_max != CRASH_ADDR_LOW_MAX)
> > 			search_base = CRASH_HIGH_SEARCH_BASE;
> 
> Does x86 do anything different here or they just can't disable
> ZONE_DMA32? I'd be tempted to instead define CRASH_ADDR_LOW_MAX as
> min(SZ_4G, arm64_dma_phys_limit) so that the crashkernel=,high semantics
> are still preserved irrespective of how the kernel was built.

x86 defaults to have both ZONE_DMA and ZONE_DMA32, and hardcode the zone
upper limit. I think it's not easy to disable ZONE_DMA32. Otherwise, the
device can only grab memory from DMA zone which is only 16MB big. The
rest memory will enter into normal zone. Please see below code snippet.

arch/x86/include/asm/dma.h:
/* 16MB ISA DMA zone */
#define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT) 

/* 4GB broken PCI/AGP hardware bus master zone */
#define MAX_DMA32_PFN (1UL << (32 - PAGE_SHIFT))

arch/x86/mm/init.c
zone_sizes_init()

About CRASH_ADDR_LOW_MAX definition, with min(SZ_4G,
arm64_dma_phys_limit), it's similar to defining it as
arm64_dma_phys_limit directly. 
it's the same as defining CRASH_ADDR_LOW_MAX as arm64_dma_phys_limit.

Because arm64_dma_phys_limit has three kinds of value:
1) 1G on RPi4
2) 4G on normal system
3) (PHYS_MASK + 1) on special system w/o zone DMA and DMA32

For the first two types, min(SZ_4G, arm64_dma_phys_limit) is
arm64_dma_phys_limit. While for the 3rd one, CRASH_ADDR_LOW_MAX is 4G, but
it will make type 3) system not be able to reserve memory across 4G.
However, on type 3) system, all its memory is low memory, the 4G should
not be a boundary. I tried code change with min(SZ_4G, 
arm64_dma_phys_limit), if we can accept this, the v4 patch looks more
appripriate except that RPi4 has inconsistent behaviour when
crashkernel=,high is specified.

> 
> There's also the difference between what the current kernel vs the kdump
> kernel. I don't think there's a strong requirement that they have the
> same config options, in which case it may be safer to just honour the 4G
> boundary.

Yes. In principle, kdump kerel doesn't have to be the same as the current
kernel. However, in reality, we usually take the same kernel for the
current kernel and kdump kernel. In our distros, we do that by default.
While user can choose different kernel as kdump kernel.

But, we may not suggest user to take kernel with different config
options as kdump kernel. E.g on RPi4, the current kernel has ZONE_DMA
and ZONE_DMA32 enabled, then it has DMA zone under 1G, DMA32 zone under
4G. If we take a kernel without ZONE_DMA and ZONE_DMA32 set as kdump
kernel, it's very likely not working because the pci device could get
memory above 1G, even above 4G.

> 
> Otherwise the patch looks fine. Whether you want to add the min limit
> above:

I am OK with this version, or the version with min(SZ_4G,
arm64_dma_phys_limit), or v4. Please help point out if I got your idea
correctly. Thanks a lot.

