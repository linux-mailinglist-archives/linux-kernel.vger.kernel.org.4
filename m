Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B2737B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFUGPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:15:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E510DA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:15:29 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QmCqY4CnszLmsC;
        Wed, 21 Jun 2023 14:13:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 14:15:26 +0800
Message-ID: <aba31303-e992-9ad7-995f-d159f79a55f7@huawei.com>
Date:   Wed, 21 Jun 2023 14:15:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] riscv: mm: try VMA lock-based page fault handling first
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <20230523165942.2630-1-jszhang@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230523165942.2630-1-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 0:59, Jisheng Zhang wrote:
> Attempt VMA lock-based page fault handling first, and fall back to the
> existing mmap_lock-based handling if that fails.
> 
> A simple running the ebizzy benchmark on Lichee Pi 4A shows that
> PER_VMA_LOCK can improve the ebizzy benchmark by about 32.68%. In
> theory, the more CPUs, the bigger improvement, but I don't have any
> HW platform which has more than 4 CPUs.
> 
> This is the riscv variant of "x86/mm: try VMA lock-based page fault
> handling first".
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> Any performance numbers are welcome! Especially the numbers on HW
> platforms with 8 or more CPUs.
> 
>   arch/riscv/Kconfig    |  1 +
>   arch/riscv/mm/fault.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 62e84fee2cfd..b958f67f9a12 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -42,6 +42,7 @@ config RISCV
>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>   	select ARCH_SUPPORTS_HUGETLBFS if MMU
>   	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> +	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU

no need if mmu，  see PER_VMA_LOCK


config PER_VMA_LOCK
         bool "allow VMA lock-based page fault"
         def_bool y
         depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>   	select ARCH_USE_MEMTEST
>   	select ARCH_USE_QUEUED_RWLOCKS
>   	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 8685f85a7474..eccdddf26f4b 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -286,6 +286,36 @@ void handle_page_fault(struct pt_regs *regs)
>   		flags |= FAULT_FLAG_WRITE;
>   	else if (cause == EXC_INST_PAGE_FAULT)
>   		flags |= FAULT_FLAG_INSTRUCTION;
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!(flags & FAULT_FLAG_USER))
> +		goto lock_mmap;
> +
> +	vma = lock_vma_under_rcu(mm, addr);
> +	if (!vma)
> +		goto lock_mmap;
> +
> +	if (unlikely(access_error(cause, vma))) {
> +		vma_end_read(vma);
> +		goto lock_mmap;
> +	}
> +
> +	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
> +	vma_end_read(vma);
> +
> +	if (!(fault & VM_FAULT_RETRY)) {
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +		goto done;
> +	}
> +	count_vm_vma_lock_event(VMA_LOCK_RETRY);
> +
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			no_context(regs, addr);
> +		return;
> +	}
> +lock_mmap:
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>   retry:
>   	mmap_read_lock(mm);
>   	vma = find_vma(mm, addr);
> @@ -355,6 +385,9 @@ void handle_page_fault(struct pt_regs *regs)
>   
>   	mmap_read_unlock(mm);
>   
> +#ifdef CONFIG_PER_VMA_LOCK
> +done:
> +#endif
>   	if (unlikely(fault & VM_FAULT_ERROR)) {
>   		tsk->thread.bad_cause = cause;
>   		mm_fault_error(regs, addr, fault);
