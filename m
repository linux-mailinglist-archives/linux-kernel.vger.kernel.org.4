Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F271666A9A4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjANGiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjANGiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:38:10 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60414ECF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 22:38:07 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Bx7erMTcJjlZoBAA--.5133S3;
        Sat, 14 Jan 2023 14:38:05 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxTuTJTcJj+UwZAA--.11745S3;
        Sat, 14 Jan 2023 14:38:03 +0800 (CST)
Subject: Re: [PATCH 1/4] LoongArch: Use trampoline for exception handlers and
 kill la.abs
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
 <1673255274-18238-2-git-send-email-tangyouling@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <6f1a1f3c-4569-c427-76ae-2f7093cb5e9f@loongson.cn>
Date:   Sat, 14 Jan 2023 14:38:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1673255274-18238-2-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxTuTJTcJj+UwZAA--.11745S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gw45ZFW5XF4Utw1ktr1kKrg_yoW3Kr4rpw
        nxAF4DJa1vgFn5Za4Ut34jvrW5ZwnrWw4aga12krWruFnFgry5X34kt3s7uF97KayxXF40
        9F1rZws2vay5JwUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07jjWlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao and Youling,

I care about the performance when NUMA enabled. We set CSR.EENTRY
for each possible cpus where is NUMA-relative. So, I guess the more
codes in NUMA-relative memory makes more performance. If we just set
handler_trampoline as exception handler, the performance may be
influenced.


Thanks,

Jinyang


On 2023-01-09 17:07, Youling Tang wrote:
> From: Xi Ruoyao <xry111@xry111.site>
>
> Use a trampoline as an exception handlers, which can kill some use of
> la.abs in preparation for the subsequent support of the PIE kernel.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>   arch/loongarch/include/asm/stackframe.h |  8 +++----
>   arch/loongarch/include/asm/uaccess.h    |  1 -
>   arch/loongarch/kernel/entry.S           |  6 +++---
>   arch/loongarch/kernel/genex.S           | 20 +++++++++---------
>   arch/loongarch/kernel/head.S            |  2 +-
>   arch/loongarch/kernel/traps.c           |  4 +++-
>   arch/loongarch/mm/tlbex.S               | 28 +++++++------------------
>   7 files changed, 29 insertions(+), 40 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 4ca953062b5b..96c94035b5d0 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -76,8 +76,8 @@
>    * kernelsp array for it. It stores the current sp in t0 and loads the
>    * new value in sp.
>    */
> -	.macro	get_saved_sp docfi=0
> -	la.abs	  t1, kernelsp
> +	.macro	  get_saved_sp docfi=0
> +	la.pcrel  t1, kernelsp
>   #ifdef CONFIG_SMP
>   	csrrd	  t0, PERCPU_BASE_KS
>   	LONG_ADD  t1, t1, t0
> @@ -89,8 +89,8 @@
>   	LONG_L	  sp, t1, 0
>   	.endm
>   
> -	.macro	set_saved_sp stackp temp temp2
> -	la.abs	  \temp, kernelsp
> +	.macro	  set_saved_sp stackp temp temp2
> +	la.pcrel  \temp, kernelsp
>   #ifdef CONFIG_SMP
>   	LONG_ADD  \temp, \temp, u0
>   #endif
> diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
> index 255899d4a7c3..0d22991ae430 100644
> --- a/arch/loongarch/include/asm/uaccess.h
> +++ b/arch/loongarch/include/asm/uaccess.h
> @@ -22,7 +22,6 @@
>   extern u64 __ua_limit;
>   
>   #define __UA_ADDR	".dword"
> -#define __UA_LA		"la.abs"
>   #define __UA_LIMIT	__ua_limit
>   
>   /*
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> index d53b631c9022..ca01afdbec3f 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -18,9 +18,9 @@
>   	.text
>   	.cfi_sections	.debug_frame
>   	.align	5
> -SYM_FUNC_START(handle_syscall)
> +SYM_FUNC_START(handle_sys)
>   	csrrd	t0, PERCPU_BASE_KS
> -	la.abs	t1, kernelsp
> +	la.pcrel	t1, kernelsp
>   	add.d	t1, t1, t0
>   	move	t2, sp
>   	ld.d	sp, t1, 0
> @@ -66,7 +66,7 @@ SYM_FUNC_START(handle_syscall)
>   	bl	do_syscall
>   
>   	RESTORE_ALL_AND_RET
> -SYM_FUNC_END(handle_syscall)
> +SYM_FUNC_END(handle_sys)
>   
>   SYM_CODE_START(ret_from_fork)
>   	bl	schedule_tail		# a0 = struct task_struct *prev
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 75e5be807a0d..d3df0fa725a2 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -32,9 +32,8 @@ SYM_FUNC_START(__arch_cpu_idle)
>   SYM_FUNC_END(__arch_cpu_idle)
>   
>   SYM_FUNC_START(handle_vint)
> -	BACKUP_T0T1
>   	SAVE_ALL
> -	la.abs	t1, __arch_cpu_idle
> +	la.pcrel	t1, __arch_cpu_idle
>   	LONG_L	t0, sp, PT_ERA
>   	/* 32 byte rollback region */
>   	ori	t0, t0, 0x1f
> @@ -43,8 +42,7 @@ SYM_FUNC_START(handle_vint)
>   	LONG_S	t0, sp, PT_ERA
>   1:	move	a0, sp
>   	move	a1, sp
> -	la.abs	t0, do_vint
> -	jirl	ra, t0, 0
> +	bl	do_vint
>   	RESTORE_ALL_AND_RET
>   SYM_FUNC_END(handle_vint)
>   
> @@ -67,12 +65,10 @@ SYM_FUNC_END(except_vec_cex)
>   	.macro	BUILD_HANDLER exception handler prep
>   	.align	5
>   	SYM_FUNC_START(handle_\exception)
> -	BACKUP_T0T1
>   	SAVE_ALL
>   	build_prep_\prep
>   	move	a0, sp
> -	la.abs	t0, do_\handler
> -	jirl	ra, t0, 0
> +	bl	do_\handler
>   	RESTORE_ALL_AND_RET
>   	SYM_FUNC_END(handle_\exception)
>   	.endm
> @@ -89,7 +85,11 @@ SYM_FUNC_END(except_vec_cex)
>   	BUILD_HANDLER watch watch none
>   	BUILD_HANDLER reserved reserved none	/* others */
>   
> -SYM_FUNC_START(handle_sys)
> -	la.abs	t0, handle_syscall
> +SYM_FUNC_START(handler_trampoline)
> +	csrwr	t0, EXCEPTION_KS0
> +	csrwr	t1, EXCEPTION_KS1
> +	pcaddi	t0, 0
> +	ld.d	t0, t0, 16
>   	jr	t0
> -SYM_FUNC_END(handle_sys)
> +	nop
> +SYM_FUNC_END(handler_trampoline)
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 57bada6b4e93..aa6181714ec3 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -117,7 +117,7 @@ SYM_CODE_START(smpboot_entry)
>   	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
>   	csrwr		t0, LOONGARCH_CSR_EUEN
>   
> -	la.abs		t0, cpuboot_data
> +	la.pcrel	t0, cpuboot_data
>   	ld.d		sp, t0, CPU_BOOT_STACK
>   	ld.d		tp, t0, CPU_BOOT_TINFO
>   
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 7ea62faeeadb..0e8faaca3679 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -61,6 +61,7 @@ extern asmlinkage void handle_lasx(void);
>   extern asmlinkage void handle_reserved(void);
>   extern asmlinkage void handle_watch(void);
>   extern asmlinkage void handle_vint(void);
> +extern asmlinkage void handler_trampoline(void);
>   
>   static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
>   			   const char *loglvl, bool user)
> @@ -716,7 +717,8 @@ void per_cpu_trap_init(int cpu)
>   /* Install CPU exception handler */
>   void set_handler(unsigned long offset, void *addr, unsigned long size)
>   {
> -	memcpy((void *)(eentry + offset), addr, size);
> +	memcpy((void *)(eentry + offset), &handler_trampoline, 24);
> +	memcpy((void *)(eentry + offset + 24), &addr, 8);
>   	local_flush_icache_range(eentry + offset, eentry + offset + size);
>   }
>   
> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> index 58781c6e4191..cfaacdac518c 100644
> --- a/arch/loongarch/mm/tlbex.S
> +++ b/arch/loongarch/mm/tlbex.S
> @@ -24,8 +24,7 @@
>   	move		a0, sp
>   	REG_S		a2, sp, PT_BVADDR
>   	li.w		a1, \write
> -	la.abs		t0, do_page_fault
> -	jirl		ra, t0, 0
> +	bl		do_page_fault
>   	RESTORE_ALL_AND_RET
>   	SYM_FUNC_END(tlb_do_page_fault_\write)
>   	.endm
> @@ -34,20 +33,16 @@
>   	tlb_do_page_fault 1
>   
>   SYM_FUNC_START(handle_tlb_protect)
> -	BACKUP_T0T1
>   	SAVE_ALL
>   	move		a0, sp
>   	move		a1, zero
>   	csrrd		a2, LOONGARCH_CSR_BADV
>   	REG_S		a2, sp, PT_BVADDR
> -	la.abs		t0, do_page_fault
> -	jirl		ra, t0, 0
> +	bl		do_page_fault
>   	RESTORE_ALL_AND_RET
>   SYM_FUNC_END(handle_tlb_protect)
>   
>   SYM_FUNC_START(handle_tlb_load)
> -	csrwr		t0, EXCEPTION_KS0
> -	csrwr		t1, EXCEPTION_KS1
>   	csrwr		ra, EXCEPTION_KS2
>   
>   	/*
> @@ -116,7 +111,7 @@ smp_pgtable_change_load:
>   
>   #ifdef CONFIG_64BIT
>   vmalloc_load:
> -	la.abs		t1, swapper_pg_dir
> +	la.pcrel	t1, swapper_pg_dir
>   	b		vmalloc_done_load
>   #endif
>   
> @@ -187,13 +182,10 @@ tlb_huge_update_load:
>   nopage_tlb_load:
>   	dbar		0
>   	csrrd		ra, EXCEPTION_KS2
> -	la.abs		t0, tlb_do_page_fault_0
> -	jr		t0
> +	b		tlb_do_page_fault_0
>   SYM_FUNC_END(handle_tlb_load)
>   
>   SYM_FUNC_START(handle_tlb_store)
> -	csrwr		t0, EXCEPTION_KS0
> -	csrwr		t1, EXCEPTION_KS1
>   	csrwr		ra, EXCEPTION_KS2
>   
>   	/*
> @@ -263,7 +255,7 @@ smp_pgtable_change_store:
>   
>   #ifdef CONFIG_64BIT
>   vmalloc_store:
> -	la.abs		t1, swapper_pg_dir
> +	la.pcrel	t1, swapper_pg_dir
>   	b		vmalloc_done_store
>   #endif
>   
> @@ -336,13 +328,10 @@ tlb_huge_update_store:
>   nopage_tlb_store:
>   	dbar		0
>   	csrrd		ra, EXCEPTION_KS2
> -	la.abs		t0, tlb_do_page_fault_1
> -	jr		t0
> +	b		tlb_do_page_fault_1
>   SYM_FUNC_END(handle_tlb_store)
>   
>   SYM_FUNC_START(handle_tlb_modify)
> -	csrwr		t0, EXCEPTION_KS0
> -	csrwr		t1, EXCEPTION_KS1
>   	csrwr		ra, EXCEPTION_KS2
>   
>   	/*
> @@ -411,7 +400,7 @@ smp_pgtable_change_modify:
>   
>   #ifdef CONFIG_64BIT
>   vmalloc_modify:
> -	la.abs		t1, swapper_pg_dir
> +	la.pcrel	t1, swapper_pg_dir
>   	b		vmalloc_done_modify
>   #endif
>   
> @@ -483,8 +472,7 @@ tlb_huge_update_modify:
>   nopage_tlb_modify:
>   	dbar		0
>   	csrrd		ra, EXCEPTION_KS2
> -	la.abs		t0, tlb_do_page_fault_1
> -	jr		t0
> +	b		tlb_do_page_fault_1
>   SYM_FUNC_END(handle_tlb_modify)
>   
>   SYM_FUNC_START(handle_tlb_refill)

