Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C263DB14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiK3Qyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiK3Qyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:54:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38528138C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:54:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d3so12292136plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANjMZAC+UVlc4xlhh9ouU1Q5ZftFpTXUZxrwqOK5jUA=;
        b=7Q3xMFFUgY9TBO52plAUw2tADB7mj9cL5TwfCqlI1UEkzggxjIQbvQ/9/1kQkiRPSu
         B0vcZuytkwjv8Yuf1Gh7Qeue2zLuVQ83P5VzezJqUlGHMdBm74w4Lm8yXnoK26Rx3swP
         VucaKmbXXUFCP1qfa3NQ5/Mh0scri+k3ns82F40PiHqOJQTRZ2ojXpiHE7NBsXxGlQOS
         aknmHT0dz+bDqmHAOevVKdD6aw6Pvw+i6kxDbmmQwFwJbvkW0RM0le0dlProTPCPIhLh
         84RBhdefk6qwq0L9C9Z2FkDNijY1WNQuOSr1NGrozG1GCiFAP0ZlaSVbPOpwo3t1IvMs
         74sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANjMZAC+UVlc4xlhh9ouU1Q5ZftFpTXUZxrwqOK5jUA=;
        b=Y2+7UD6/UWeQ9QBCaNLeCR5MtWS7b0SJMtS4nxhrBPS6TWvi1HRdjSDO9lJ9cBkdEy
         srwJmH5f2yKDNN5jxXTv82nT825+30EeUuEKb5s4NuKRCH8HQB7/JAJU/PFyqeEZX7mi
         Ukc7SAizhL5Yoc4XGMF9SzaehCqwfx1WyPN+NNhrUwz1MX8M1n6ddTez4tRM88rQcz+u
         3ieYMhrwAGPFDhZNK28jm/grO2Ghr76AD6ZpMFqu+m+wOGHIK/i9zTA6/EJIzfoo7VXf
         6fv8WMT/Z5t0lLrFmjwM4V08YeNuF16s/RK0Ie1/n46EpUiIJghlvJMOK63ZrB9CwaYa
         NEsg==
X-Gm-Message-State: ANoB5pnNpt4VrHiJeJ8Jk1NpNScQNKBm1Mqn2cIrcZ+Eooz/dbrAifTa
        zcq1nqbCDDUsBzMShkkPp43kTQ==
X-Google-Smtp-Source: AA0mqf6iOHGYwJeTaqFNoD+6LG/bquEgcI2HiLvk3VIdZaNS9spQJ+90fiZtEaKZVqIGYPMBBudCUw==
X-Received: by 2002:a17:90a:bb16:b0:200:2d7f:18c2 with SMTP id u22-20020a17090abb1600b002002d7f18c2mr65895870pjr.106.1669827284041;
        Wed, 30 Nov 2022 08:54:44 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b00186b7443082sm1712991plb.195.2022.11.30.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:54:43 -0800 (PST)
Date:   Wed, 30 Nov 2022 08:54:43 -0800 (PST)
X-Google-Original-Date: Wed, 30 Nov 2022 08:54:39 PST (-0800)
Subject:     Re: [PATCH v4] riscv: fix race when vmap stack overflow
In-Reply-To: <CAJF2gTQ0xuJo6uzB+8SudZOFiZ2_o1sLB=Hn5XuCw6g2tXUtkQ@mail.gmail.com>
CC:     jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org, Andrea Parri <andrea@rivosinc.com>
Message-ID: <mhng-72408cf8-cbde-489b-9042-379b5aa8624f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 23:15:40 PST (-0800), guoren@kernel.org wrote:
> The comment becomes better. Thx.
>
> On Wed, Nov 30, 2022 at 10:29 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Jisheng Zhang <jszhang@kernel.org>
>>
>> Currently, when detecting vmap stack overflow, riscv firstly switches
>> to the so called shadow stack, then use this shadow stack to call the
>> get_overflow_stack() to get the overflow stack. However, there's
>> a race here if two or more harts use the same shadow stack at the same
>> time.
>>
>> To solve this race, we introduce spin_shadow_stack atomic var, which
>> will be swap between its own address and 0 in atomic way, when the
>> var is set, it means the shadow_stack is being used; when the var
>> is cleared, it means the shadow_stack isn't being used.
>>
>> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> Suggested-by: Guo Ren <guoren@kernel.org>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> Link: https://lore.kernel.org/r/20221030124517.2370-1-jszhang@kernel.org
>> [Palmer: Add AQ to the swap, and also some comments.]
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> Sorry to just re-spin this one without any warning, but I'd read patch a
>> few times and every time I'd managed to convice myself there was a much
>> simpler way of doing this.  By the time I'd figured out why that's not
>> the case it seemed faster to just write the comments.
>>
>> I've stashed this, right on top of the offending commit, at
>> palmer/riscv-fix_vmap_stack.
>>
>> Since v3:
>>  - Add AQ to the swap.
>>  - Add a bunch of comments.
>>
>> Since v2:
>>  - use REG_AMOSWAP
>>  - add comment to the purpose of smp_store_release()
>>
>> Since v1:
>>  - use smp_store_release directly
>>  - use unsigned int instead of atomic_t
>> ---
>>  arch/riscv/include/asm/asm.h |  1 +
>>  arch/riscv/kernel/entry.S    | 13 +++++++++++++
>>  arch/riscv/kernel/traps.c    | 18 ++++++++++++++++++
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index 618d7c5af1a2..e15a1c9f1cf8 100644
>> --- a/arch/riscv/include/asm/asm.h
>> +++ b/arch/riscv/include/asm/asm.h
>> @@ -23,6 +23,7 @@
>>  #define REG_L          __REG_SEL(ld, lw)
>>  #define REG_S          __REG_SEL(sd, sw)
>>  #define REG_SC         __REG_SEL(sc.d, sc.w)
>> +#define REG_AMOSWAP_AQ __REG_SEL(amoswap.d.aq, amoswap.w.aq)
> Below is the reason why I use the relax version here:
> https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com/T/#u

Sorry, I hadn't seen that one.  Adding Andrea.  IMO the acquire/release 
pair is necessary here, with just relaxed the stack stores inside the 
lock could show up on the next hart trying to use the stack.

>>  #define REG_ASM                __REG_SEL(.dword, .word)
>>  #define SZREG          __REG_SEL(8, 4)
>>  #define LGREG          __REG_SEL(3, 2)
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 98f502654edd..5fdb6ba09600 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -387,6 +387,19 @@ handle_syscall_trace_exit:
>>
>>  #ifdef CONFIG_VMAP_STACK
>>  handle_kernel_stack_overflow:
>> +       /*
>> +        * Takes the psuedo-spinlock for the shadow stack, in case multiple
>> +        * harts are concurrently overflowing their kernel stacks.  We could
>> +        * store any value here, but since we're overflowing the kernel stack
>> +        * already we only have SP to use as a scratch register.  So we just
>> +        * swap in the address of the spinlock, as that's definately non-zero.
>> +        *
>> +        * Pairs with a store_release in handle_bad_stack().
>> +        */
>> +1:     la sp, spin_shadow_stack
>> +       REG_AMOSWAP_AQ sp, sp, (sp)
>> +       bnez sp, 1b
>> +
>>         la sp, shadow_stack
>>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index bb6a450f0ecc..be54ccea8c47 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -213,11 +213,29 @@ asmlinkage unsigned long get_overflow_stack(void)
>>                 OVERFLOW_STACK_SIZE;
>>  }
>>
>> +/*
>> + * A pseudo spinlock to protect the shadow stack from being used by multiple
>> + * harts concurrently.  This isn't a real spinlock because the lock side must
>> + * be taken without a valid stack and only a single register, it's only taken
>> + * while in the process of panicing anyway so the performance and error
>> + * checking a proper spinlock gives us doesn't matter.
>> + */
>> +unsigned long spin_shadow_stack;
>> +
>>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>>  {
>>         unsigned long tsk_stk = (unsigned long)current->stack;
>>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>>
>> +       /*
>> +        * We're done with the shadow stack by this point, as we're on the
>> +        * overflow stack.  Tell any other concurrent overflowing harts that
>> +        * they can proceed with panicing by releasing the pseudo-spinlock.
>> +        *
>> +        * This pairs with an amoswap.aq in handle_kernel_stack_overflow.
>> +        */
>> +       smp_store_release(&spin_shadow_stack, 0);
>> +
>>         console_verbose();
>>
>>         pr_emerg("Insufficient stack space to handle exception!\n");
>> --
>> 2.38.1
>>
