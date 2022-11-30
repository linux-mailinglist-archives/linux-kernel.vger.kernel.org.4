Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCC63CD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiK3C3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiK3C3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:29:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99A6A773
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:29:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so570369pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jstbFvyP0O4grgHUTkEUa75qdwH13vOZyONOc8qvqao=;
        b=hKcG49akw6nka55UlYwOv0vcGgWdTQyqAR6S8QHFnIJWU/gFb1rFbnwJ7xEQdMAlfd
         iC3s0AWpCxM9TxTl/0Y/pR/DG9j3WagJUMrfahBSalvDg/VRP7SLSqw5/4X8j7ygjGtv
         a6lsifCfCFFrTRIUNRaCBINOdiUdCL1hVhV9G0xM9b8MBu0+us+hwujK+bpSDYWdxJId
         z0id5Bkkhww8I2xaOhIuHbaNk96bxP1i9cV6Fpk7J+X99sqc64lxOi6HVT265BL9m5d6
         nSjEN2amHSgzA/DKC5vR2q0BPpvplEuoHPDa2lJ5pLqefvxXBckGdjoE7K0ZuhET2GH4
         qUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jstbFvyP0O4grgHUTkEUa75qdwH13vOZyONOc8qvqao=;
        b=7s8ST+3zKMu2GOi92Ahj/Y10F4aXPYY0VDx2wsILyM80Pc9XyyOTER4WZYCe68A17T
         AVzscDDgCz6seQm57veFvsQ2UZM+TT82d3bIb+ZfUN0XSC2OqA4rHpX5LTc7rSXXln7T
         35N0ioLtxaGmOUpKXJ2FO1PqZCkb4UqS+FlnA1mfnmISEOen4gjsshM1wj6OLtQZQRVW
         yg3QWwDS1SuOpVkIc0Q/fFz2y1M9LstGxQBVCRnp+IKvF2Gk2L7aVww2yDbdqF6Gdm7h
         xW9dFf2v8/LhfmLiAx7+ldNT9h1pZAIhamBRZQg+UyuIMuYc6HqAVEoeg5/3E0zSAW7b
         +C6w==
X-Gm-Message-State: ANoB5pnOJfiV9PjWuv6tlNYEWhp6z7QigbEk9tyFX7IS0mxR4yNss3lF
        4CVjWjhbg1JackncoqCUPnNywn3XMX+s7w==
X-Google-Smtp-Source: AA0mqf4XPEiBxmnuTMRctdKMPwIbDXdSlCROEvR/n5LezQOPoE+xwiQsNMFtY1PKCH+GYrMB6DNzLw==
X-Received: by 2002:a17:90b:1282:b0:214:1804:d96b with SMTP id fw2-20020a17090b128200b002141804d96bmr61403150pjb.90.1669775344112;
        Tue, 29 Nov 2022 18:29:04 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id lj14-20020a17090b344e00b002139459e121sm2005940pjb.27.2022.11.29.18.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 18:29:03 -0800 (PST)
Date:   Tue, 29 Nov 2022 18:29:03 -0800 (PST)
X-Google-Original-Date: Tue, 29 Nov 2022 18:28:36 PST (-0800)
Subject:     Re: [PATCH v3] riscv: fix race when vmap stack overflow
In-Reply-To: <Y347B0x4VUNOd6V7@xhacker>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-868b7b97-c3b9-4c1a-aaed-2fba5b0550ec@palmer-ri-x1c9a>
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

On Wed, 23 Nov 2022 07:23:51 PST (-0800), jszhang@kernel.org wrote:
> On Sun, Oct 30, 2022 at 09:23:51PM +0800, Guo Ren wrote:
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>
>
> Gentle ping? This patch is still missing in mainline.

Sorry, this one took a few looks to figure out.  I just sent out a v4, 
it's pretty much the same thing but by the time I'd figured out what 
this was doing it seemed easier to just write up the comments directly.

https://lore.kernel.org/r/20221130022442.18358-1-palmer@rivosinc.com/

I'll try and watch the threads, LMK if I screwed anything up.  I've 
already got this queued up in staging so it's being tested, should be 
fast to take it onto fixes.

Thanks!

>
>> On Sun, Oct 30, 2022 at 8:54 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>> >
>> > Currently, when detecting vmap stack overflow, riscv firstly switches
>> > to the so called shadow stack, then use this shadow stack to call the
>> > get_overflow_stack() to get the overflow stack. However, there's
>> > a race here if two or more harts use the same shadow stack at the same
>> > time.
>> >
>> > To solve this race, we introduce spin_shadow_stack atomic var, which
>> > will be swap between its own address and 0 in atomic way, when the
>> > var is set, it means the shadow_stack is being used; when the var
>> > is cleared, it means the shadow_stack isn't being used.
>> >
>> > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> > Suggested-by: Guo Ren <guoren@kernel.org>
>> > ---
>> > Since v2:
>> >  - use REG_AMOSWAP
>> >  - add comment to the purpose of smp_store_release()
>> >
>> > Since v1:
>> >  - use smp_store_release directly
>> >  - use unsigned int instead of atomic_t
>> >
>> >
>> >  arch/riscv/include/asm/asm.h | 1 +
>> >  arch/riscv/kernel/entry.S    | 4 ++++
>> >  arch/riscv/kernel/traps.c    | 9 +++++++++
>> >  3 files changed, 14 insertions(+)
>> >
>> > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> > index 1b471ff73178..acf563072b8b 100644
>> > --- a/arch/riscv/include/asm/asm.h
>> > +++ b/arch/riscv/include/asm/asm.h
>> > @@ -23,6 +23,7 @@
>> >  #define REG_L          __REG_SEL(ld, lw)
>> >  #define REG_S          __REG_SEL(sd, sw)
>> >  #define REG_SC         __REG_SEL(sc.d, sc.w)
>> > +#define REG_AMOSWAP    __REG_SEL(amoswap.d, amoswap.w)
>> >  #define REG_ASM                __REG_SEL(.dword, .word)
>> >  #define SZREG          __REG_SEL(8, 4)
>> >  #define LGREG          __REG_SEL(3, 2)
>> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> > index b9eda3fcbd6d..ea6b78dac739 100644
>> > --- a/arch/riscv/kernel/entry.S
>> > +++ b/arch/riscv/kernel/entry.S
>> > @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
>> >
>> >  #ifdef CONFIG_VMAP_STACK
>> >  handle_kernel_stack_overflow:
>> > +1:     la sp, spin_shadow_stack
>> > +       REG_AMOSWAP sp, sp, (sp)
>> > +       bnez sp, 1b
>> > +
>> >         la sp, shadow_stack
>> >         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>> >
>> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> > index f3e96d60a2ff..dea47f329708 100644
>> > --- a/arch/riscv/kernel/traps.c
>> > +++ b/arch/riscv/kernel/traps.c
>> > @@ -221,11 +221,20 @@ asmlinkage unsigned long get_overflow_stack(void)
>> >                 OVERFLOW_STACK_SIZE;
>> >  }
>> >
>> > +unsigned long spin_shadow_stack;
>> > +
>> >  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>> >  {
>> >         unsigned long tsk_stk = (unsigned long)current->stack;
>> >         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>> >
>> > +       /*
>> > +        * to ensure spin flag is set after the sp is used in entry.S:
>> > +        * //load per-cpu overflow stack.
>> > +        * REG_L sp, -8(sp)
>> > +        */
>> > +       smp_store_release(&spin_shadow_stack, 0);
>> > +
>> >         console_verbose();
>> >
>> >         pr_emerg("Insufficient stack space to handle exception!\n");
>> > --
>> > 2.37.2
>> >
>>
>>
>> --
>> Best Regards
>>  Guo Ren
