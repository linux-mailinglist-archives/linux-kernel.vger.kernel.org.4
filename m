Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E596F01C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbjD0Har (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbjD0Hap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:30:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B37BA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:30:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC8972F4;
        Thu, 27 Apr 2023 00:31:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 840A63F64C;
        Thu, 27 Apr 2023 00:30:41 -0700 (PDT)
Date:   Thu, 27 Apr 2023 08:30:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
Message-ID: <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
References: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 27, 2023 at 11:26:50AM +0800, Gang Li wrote:
> Hi all,
> 
> I have encountered a performance issue on our ARM64 machine, which seems
> to be caused by the flush_tlb_kernel_range.

Can you please provide a few more details on what you're seeing?

What does your performance issue look like?

Are you sure that the performance issue is caused by flush_tlb_kernel_range()
specifically?

> Here is the stack on the ARM64 machine:
> 
> # ARM64:
> ```
>     ghes_unmap
>     clear_fixmap
>     __set_fixmap
>     flush_tlb_kernel_range
> ```
> 
> As we can see, the ARM64 implementation eventually calls
> flush_tlb_kernel_range, which flushes the TLB on all cores. However, on
> AMD64, the implementation calls flush_tlb_one_kernel instead.
> 
> # AMD64:
> ```
>     ghes_unmap
>     clear_fixmap
>     __set_fixmap
>     mmu.set_fixmap
>     native_set_fixmap
>     __native_set_fixmap
>     set_pte_vaddr
>     set_pte_vaddr_p4d
>     __set_pte_vaddr
>     flush_tlb_one_kernel
> ```
> 
> On our ARM64 machine, flush_tlb_kernel_range is causing a noticeable
> performance degradation.

As above, could you please provide more details on this?

> This arm64 patch said:
> https://lore.kernel.org/all/20161201135112.15396-1-fu.wei@linaro.org/
> (commit 9f9a35a7b654e006250530425eb1fb527f0d32e9)
> 
> ```
> /*
>  * Despite its name, this function must still broadcast the TLB
>  * invalidation in order to ensure other CPUs don't end up with junk
>  * entries as a result of speculation. Unusually, its also called in
>  * IRQ context (ghes_iounmap_irq) so if we ever need to use IPIs for
>  * TLB broadcasting, then we're in trouble here.
>  */
> static inline void arch_apei_flush_tlb_one(unsigned long addr)
> {
>     flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> }
> ```
> 
> 1. I am curious to know the reason behind the design choice of flushing
> the TLB on all cores for ARM64's clear_fixmap, while AMD64 only flushes
> the TLB on a single core. Are there any TLB design details that make a
> difference here?

I don't know why arm64 only clears this on a single CPU.

On arm64 we *must* invalidate the TLB on all CPUs as the kernel page tables are
shared by all CPUs, and the architectural Break-Before-Make rules in require
the TLB to be invalidated between two valid (but distinct) entries.

> 2. Is it possible to let the ARM64 to flush the TLB on just one core,
> similar to the AMD64?

No. If we omitted the broadcast TLB invalidation, then a different CPU may
fetch the old value into a TLB, then fetch the new value. When this happens,
the architecture permits "amalgamation", with UNPREDICTABLE results, which
could result in memory corruption, taking SErrors, etc.

> 3. If so, would there be any potential drawbacks or limitations to
> making such a change?

As above, we must use broadcast TLB invalidation here.

Thanks,
Mark.
