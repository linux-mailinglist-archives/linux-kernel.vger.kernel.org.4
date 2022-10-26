Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC460DC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiJZH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJZH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:27:12 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBACB8C16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1666769226; bh=8nQhIKwZpGizurT7gT/3D9X5nZ5p3lzIb7aYR9El3aI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gtJDDZYfUvPwRCJxLQK0iPEvMovLBRO0IXt9CqzDubj/aJvdYCEUXcgTRrRQZgG0X
         SojJC3o7oJtEIKbaG6I4IY+YmU+J3yq1+C50pam77ucbdWpvzFDetZ+vsYf/swHKu2
         KmkM0qK8QVjy6n1Uq/5APwj2HCEIRZ+KJGVJD9g4=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3FA94600CF;
        Wed, 26 Oct 2022 15:27:06 +0800 (CST)
Message-ID: <43126fe8-9040-a574-a149-273844d3073f@xen0n.name>
Date:   Wed, 26 Oct 2022 15:27:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:108.0)
 Gecko/20100101 Thunderbird/108.0a1
Subject: Re: [PATCH v2 RESEND] LoongArch: Remove unused kernel stack padding
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221026035501.11986-1-hejinyang@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20221026035501.11986-1-hejinyang@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/26 11:55, Jinyang He wrote:
> Kernel stack padding looks like obey MIPS o32 Calling Convention, as
> LoongArch is inspired by MIPS and keep it. Remove it avoid not clear
> code.

Just some improvement to the commit message so it's clearer:

"The current LoongArch kernel stack is padded as if obeying the MIPS o32 
calling convention, signifying the port's MIPS lineage but no longer 
making sense. Remove the padding for clarity."

> 
> Link: https://lore.kernel.org/loongarch/1662130897-13156-1-git-send-email-hejinyang@loongson.cn/
> 

I think this blank line between the "Link" and S-o-b tags could be removed.

> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
> v2: Remove TOP_OF_KERNEL_STACK_PADDING
>      Remove 'init stack pointer' in head.S
> 
>   arch/loongarch/include/asm/processor.h | 2 +-
>   arch/loongarch/include/asm/ptrace.h    | 2 +-
>   arch/loongarch/kernel/head.S           | 3 +--
>   arch/loongarch/kernel/process.c        | 4 ++--
>   arch/loongarch/kernel/switch.S         | 2 +-
>   5 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 6954dc5d24e9..7184f1dc61f2 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -191,7 +191,7 @@ static inline void flush_thread(void)
>   unsigned long __get_wchan(struct task_struct *p);
>   
>   #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
> -			 THREAD_SIZE - 32 - sizeof(struct pt_regs))
> +			 THREAD_SIZE - sizeof(struct pt_regs))
>   #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
>   #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
>   #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 7437b9366c3b..59c4608de91d 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -133,7 +133,7 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
>   #define current_pt_regs()						\
>   ({									\
>   	unsigned long sp = (unsigned long)__builtin_frame_address(0);	\
> -	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;	\
> +	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1) - 1;		\
>   })
>   
>   /* Helpers for working with the user stack pointer */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 97425779ce9f..84970e266658 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -84,10 +84,9 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>   
>   	la.pcrel	tp, init_thread_union
>   	/* Set the SP after an empty pt_regs.  */
> -	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
> +	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
>   	PTR_ADD		sp, sp, tp
>   	set_saved_sp	sp, t0, t1
> -	PTR_ADDI	sp, sp, -4 * SZREG	# init stack pointer
>   
>   	bl		start_kernel
>   	ASM_BUG()
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index 1256e3582475..2526b68f1c0f 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   	unsigned long clone_flags = args->flags;
>   	struct pt_regs *childregs, *regs = current_pt_regs();
>   
> -	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
> +	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
>   
>   	/* set up new TSS. */
>   	childregs = (struct pt_regs *) childksp - 1;
> @@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
>   			struct stack_info *info)
>   {
>   	unsigned long begin = (unsigned long)task_stack_page(task);
> -	unsigned long end = begin + THREAD_SIZE - 32;
> +	unsigned long end = begin + THREAD_SIZE;
>   
>   	if (stack < begin || stack >= end)
>   		return false;
> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
> index 43ebbc3990f7..202a163cb32f 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
> @@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
>   	move	tp, a2
>   	cpu_restore_nonscratch a1
>   
> -	li.w		t0, _THREAD_SIZE - 32
> +	li.w		t0, _THREAD_SIZE
>   	PTR_ADD		t0, t0, tp
>   	set_saved_sp	t0, t1, t2
>   

Otherwise LGTM, assuming you have tested it before sending (I don't 
currently have the capacity to immediately test this for you)...

Reviewed-by: WANG Xuerui <git@xen0n.name>


-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

