Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E463CBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiK2XXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2XXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:23:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED885289E;
        Tue, 29 Nov 2022 15:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFC06195D;
        Tue, 29 Nov 2022 23:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A426C433C1;
        Tue, 29 Nov 2022 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669764188;
        bh=0fdNX9QhucmvGYsJWGOg9jQeFn+znvsZsA3GeeD73CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oBPkt6FJJWfvsgtGvs6SjxHs/2kYEDb40oxeDjWBuNGLbmZH0jVfpuraJ/TrV9+F4
         hqoAFA2+L/RlQ1wICENr1s9GsmPkIDc9zBUGenqCJRgb4PHm3qYEnMhYXx+xLEakLb
         I+GNCiUTX4XFglOckyjmCJUxKp2DIu33twwtFObY=
Date:   Tue, 29 Nov 2022 15:23:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <x86@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, Barry Song <21cnbao@gmail.com>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v7 1/2] mm/tlbbatch: Introduce
 arch_tlbbatch_should_defer()
Message-Id: <20221129152306.54b6d439e2a0ca7ece1d1afa@linux-foundation.org>
In-Reply-To: <20221117082648.47526-2-yangyicong@huawei.com>
References: <20221117082648.47526-1-yangyicong@huawei.com>
        <20221117082648.47526-2-yangyicong@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 16:26:47 +0800 Yicong Yang <yangyicong@huawei.com> wrote:

> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> The entire scheme of deferred TLB flush in reclaim path rests on the
> fact that the cost to refill TLB entries is less than flushing out
> individual entries by sending IPI to remote CPUs. But architecture
> can have different ways to evaluate that. Hence apart from checking
> TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
> architecture specific.
> 
> ...
>
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>  	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
>  }
>  
> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	bool should_defer = false;
> +
> +	/* If remote CPUs need to be flushed then defer batch the flush */
> +	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> +		should_defer = true;
> +	put_cpu();
> +
> +	return should_defer;
> +}
> +
>  static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>  {
>  	/*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2ec925e5fa6a..a9ab10bc0144 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -685,17 +685,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>   */
>  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>  {
> -	bool should_defer = false;
> -
>  	if (!(flags & TTU_BATCH_FLUSH))
>  		return false;
>  
> -	/* If remote CPUs need to be flushed then defer batch the flush */
> -	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> -		should_defer = true;
> -	put_cpu();
> -
> -	return should_defer;
> +	return arch_tlbbatch_should_defer(mm);
>  }

I think this conversion could have been done better.

should_defer_flush() is compiled if
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.  So the patch implicitly
assumes that only x86 implements
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.  Presently true, but what
happens if sparc (for example) wants to set
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH?  Now sparc needs its private
version of arch_tlbbatch_should_defer(), even if that is identical to
x86's.

Wouldn't it be better to make arch_tlbbatch_should_defer() a __weak
function in rmap.c, or a static inline inside #ifndef
ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER, or whatever technique best fits?

