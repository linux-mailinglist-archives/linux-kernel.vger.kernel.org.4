Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8692746B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGDIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGDIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD3BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688458313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/mJg6OCwsNURikAN+36DVOOXzUfGZWJJ1yGnijjdxE=;
        b=Jd8gZCxCYFlsW0xy0U0IGqV3oQuxUz2LfBeG9on3LPbYnoYTRfsnLB62mhb+oWXIESkVcJ
        s1+oPW8s2puRn/iwhpIqUvLlkqjuWzx6gAHc1VzXViwhngK52V0xtsGmWQQQzUU0nRR3xa
        zFLh58e7c7zpIxQ0w15dpKZ02SpwZm4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-b-bAzCV3N_a23obPUt54ng-1; Tue, 04 Jul 2023 04:11:50 -0400
X-MC-Unique: b-bAzCV3N_a23obPUt54ng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41E5028237CA;
        Tue,  4 Jul 2023 08:11:49 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B48F492B01;
        Tue,  4 Jul 2023 08:11:47 +0000 (UTC)
Date:   Tue, 4 Jul 2023 16:11:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v6 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZKPUQFMoDQFrFr2d@MiWiFi-R3L-srv>
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
 <20230701171138.1491206-2-chenjiahao16@huawei.com>
 <ZKD5N+e5DjgyJ5rw@MiWiFi-R3L-srv>
 <6f4c80ba-ec61-2ce8-3034-08162f0ee9fd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4c80ba-ec61-2ce8-3034-08162f0ee9fd@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/23 at 10:18am, chenjiahao (C) wrote:
> 
> On 2023/7/2 12:12, Baoquan He wrote:
> > On 07/01/23 at 05:11pm, Chen Jiahao wrote:
> > > On riscv, the current crash kernel allocation logic is trying to
> > > allocate within 32bit addressible memory region by default, if
> > > failed, try to allocate without 4G restriction.
> > > 
> > > In need of saving DMA zone memory while allocating a relatively large
> > > crash kernel region, allocating the reserved memory top down in
> > > high memory, without overlapping the DMA zone, is a mature solution.
> > > Here introduce the parameter option crashkernel=X,[high,low].
> > > 
> > > One can reserve the crash kernel from high memory above DMA zone range
> > > by explicitly passing "crashkernel=X,high"; or reserve a memory range
> > > below 4G with "crashkernel=X,low".
> > > 
> > > Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> > > Acked-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >   arch/riscv/kernel/setup.c |  5 +++
> > >   arch/riscv/mm/init.c      | 84 +++++++++++++++++++++++++++++++++++----
> > >   2 files changed, 82 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 971fe776e2f8..376f5d49ce85 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -178,6 +178,11 @@ static void __init init_resources(void)
> > >   		if (ret < 0)
> > >   			goto error;
> > >   	}
> > > +	if (crashk_low_res.start != crashk_low_res.end) {
> > > +		ret = add_resource(&iomem_resource, &crashk_low_res);
> > > +		if (ret < 0)
> > > +			goto error;
> > > +	}
> > >   #endif
> > >   #ifdef CONFIG_CRASH_DUMP
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 4b95d8999120..eeb31c2cc843 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -1298,6 +1298,28 @@ static inline void setup_vm_final(void)
> > >   }
> > >   #endif /* CONFIG_MMU */
> > > +/* Reserve 128M low memory by default for swiotlb buffer */
> > > +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> > > +
> > > +static int __init reserve_crashkernel_low(unsigned long long low_size)
> > > +{
> > > +	unsigned long long low_base;
> > > +
> > > +	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
> > > +	if (!low_base) {
> > > +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> > > +		low_base, low_base + low_size, low_size >> 20);
> > > +
> > > +	crashk_low_res.start = low_base;
> > > +	crashk_low_res.end = low_base + low_size - 1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /*
> > >    * reserve_crashkernel() - reserves memory for crash kernel
> > >    *
> > > @@ -1309,8 +1331,12 @@ static void __init reserve_crashkernel(void)
> > >   {
> > >   	unsigned long long crash_base = 0;
> > >   	unsigned long long crash_size = 0;
> > > +	unsigned long long crash_low_size = 0;
> > >   	unsigned long search_start = memblock_start_of_DRAM();
> > > -	unsigned long search_end = memblock_end_of_DRAM();
> > > +	unsigned long search_end = (unsigned long)dma32_phys_limit;
> > > +	char *cmdline = boot_command_line;
> > > +	bool fixed_base = false;
> > > +	bool high = false;
> > >   	int ret = 0;
> > > @@ -1326,14 +1352,36 @@ static void __init reserve_crashkernel(void)
> > >   		return;
> > >   	}
> > > -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > > +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> > >   				&crash_size, &crash_base);
> > > -	if (ret || !crash_size)
> > > +	if (ret == -ENOENT) {
> > > +		/* Fallback to crashkernel=X,[high,low] */
> > > +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> > > +		if (ret || !crash_size)
> > > +			return;
> > > +
> > > +		/*
> > > +		 * crashkernel=Y,low is valid only when crashkernel=X,high
> > > +		 * is passed.
> > > +		 */
> > > +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> > > +		if (ret == -ENOENT)
> > > +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > > +		else if (ret)
> > > +			return;
> > > +
> > > +		search_start = (unsigned long)dma32_phys_limit;
> > > +		search_end = memblock_end_of_DRAM();
> > > +		high = true;
> > > +	} else if (ret || !crash_size) {
> > > +		/* Invalid argument value specified */
> > >   		return;
> > > +	}
> > >   	crash_size = PAGE_ALIGN(crash_size);
> > >   	if (crash_base) {
> > > +		fixed_base = true;
> > >   		search_start = crash_base;
> > >   		search_end = crash_base + crash_size;
> > >   	}
> > > @@ -1346,17 +1394,39 @@ static void __init reserve_crashkernel(void)
> > >   	 * swiotlb can work on the crash kernel.
> > >   	 */
> > >   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > > -					       search_start,
> > > -					       min(search_end, (unsigned long) SZ_4G));
> > > +					       search_start, search_end);
> > >   	if (crash_base == 0) {
> > > -		/* Try again without restricting region to 32bit addressible memory */
> > > +		if (fixed_base) {
> > > +			pr_warn("crashkernel: allocating failed with given size@offset\n");
> > > +			return;
> > > +		}
> > > +
> > > +		if (high) {
> > > +			/* Fall back to lower 32G reservation */
> > > +			search_start = memblock_start_of_DRAM();
> > > +			search_end = (unsigned long)dma32_phys_limit;
> > > +		} else {
> > > +			/* Try again above the region of 32bit addressible memory */
> > > +			search_start = (unsigned long)dma32_phys_limit;
> > > +			search_end = memblock_end_of_DRAM();
> > > +		}
> > > +
> > >   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > > -						search_start, search_end);
> > > +						       search_start, search_end);
> > >   		if (crash_base == 0) {
> > >   			pr_warn("crashkernel: couldn't allocate %lldKB\n",
> > >   				crash_size >> 10);
> > >   			return;
> > >   		}
> > > +
> > > +		if (!crash_low_size)
> > > +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > How do you differentiate the case user specifies crashkernel=0M,low
> > explicitly with the case that user doesn't specify crashkernel=,low, but
> > only specify crsahkernel=xM,high? I saw you don't have the test case
> > crashkernel=xM,high crashkernel=0M,low listed in your cover letter.
> 
> Yes, here is indeed a point not exactly aligned with Arm64 code.
> But testcases below seem to have the same result with Arm64:
> 
> crashkernel=512M,high	//high=512M, low=128M (default)
> crashkernel=512M,high crashkernel=0M,low   //high=512M, low=0M
> crashkernel=512M,high crashkernel=256M,low   //high=512M, low=256M
> 
> 
> When the first allocation succeed, it will not fallback into
> the if (crash_base == 0) case, the allocation result is the same
> as Arm64, both for explicitly given "crashkernel=0M,low" or not.
> 
> The problem you mentioned might occurs when the first allocation
> failed.
> 
> My logic here is when crashkernel=xM,high is specified, no matter
> crashkernel=0M,low is explicitly given or not, "high" flag is set.
> It will fallback to lower 4G allocation, additional lower 4G region
> with "crash_low_size" will never get reserved.

Ah, you are right. I was mistaken. crashkernel=xM,high crashkernel=0,low
works correctly with your v6 patch. I am fine if you want to take a
different code flow to implement, as long as the actual result is the
same. I personally would make the code logic the same as arm64. So this
patches looks good to me.

> 
> So the results between Arm64 and riscv when crashkernel=,low is
> specified or not are the same. Is there any problem with my logic,
> or have I misunderstood your comment above?
> 
> > 
> > > +	}
> > > +
> > > +	if ((crash_base >= dma32_phys_limit) && crash_low_size &&
> > > +	     reserve_crashkernel_low(crash_low_size)) {
> 
> Here, additional lower memory region will not reserve when
> crashkernel=xM,high is given
> 
> > > +		memblock_phys_free(crash_base, crash_size);
> > > +		return;
> > >   	}
> > >   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
> > > -- 
> > > 2.34.1
> > > 
> Thanks,
> 
> Jiahao
> 
> 

