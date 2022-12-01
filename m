Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535C63E75F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLAB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLABz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:55:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07BE16
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:55:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m19so122056wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVK3ULZTcb0au9s6tD0+rsGIi+YBqkDmsXXuv1DWTqI=;
        b=e5E78mOpsZAh8ucA2XfQ4zuMG3rg7wruI86IC7FoBgdb3Zob0RGDWdYgYy4pOx1Dj/
         Sj0e5D/Iltvg2WwBrxDQ8/G4VtaNhq7J2Il6qdB370Tx455QczGyATy+QsQ05EDkUv0c
         H0pewg1o/1vKK3+c4sB3MB7FMaqjqg7nHKsaJ7nq/pB74j5C5n5WmtgJ4pxbqgy+iqkI
         6BO4je1S0hXH/bXH5fXN1OQBAtMHRCjA5vrQJ2ho/eOPf62XTLBWcRfXjuOmNIXyEDTz
         inS79PSQLZFu9n1/efQsc5cONwxNFSfYn3btu9yol+7goSCzStQsBODbARzX7xUWtLXg
         w19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVK3ULZTcb0au9s6tD0+rsGIi+YBqkDmsXXuv1DWTqI=;
        b=rM5mXYMoYuiGdArTWR0xVOODnIz4SkhQPNVL3PCARqhCd2uKQMrZjDb2sYluouvFP2
         DOzmz+I7lujUKECLqIfG2tdRfqSxVhFkxbYiXW+nAvOewosmA3p6yP/2TApVhlYMWPa6
         nLgENT6RSfCnOLdBHyO6TsMQ4yaLFf9jKPJN4axzKuXkO3/b6AGRwRfvjgiKgOnefwr+
         ksILLZRwXJhpYj0i97IOrcp0czaTQAmzC+0irQlAiWvz/K+h/o8NveTNFMINHQUgpGxf
         v7A71fsy9rZr+AuDQVv0Pyi8NSF//Em1b7oJx881S3pGbkbIBV58oL2SS2m3isxqpf/7
         E5mg==
X-Gm-Message-State: ANoB5plkFKxLQch4VM71lAakSxD98R+v5MvHvzYmKBoinK7O/VDRe2ju
        pEZQERA3dQntElLHs8lNw5CAyypc6gwkYR/Y
X-Google-Smtp-Source: AA0mqf7yQecK90jt93Vsi3pQwMkDiEr+ewSjgzUcNA55D7KBXUPMcvTZWJPUFwL6Zz1kjNGIhsp/qA==
X-Received: by 2002:a05:600c:4e09:b0:3cf:55bd:4944 with SMTP id b9-20020a05600c4e0900b003cf55bd4944mr49267861wmq.64.1669859755928;
        Wed, 30 Nov 2022 17:55:55 -0800 (PST)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id n29-20020a05600c3b9d00b003c21ba7d7d6sm4284802wms.44.2022.11.30.17.55.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2022 17:55:55 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4] riscv: fix race when vmap stack overflow
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <mhng-72408cf8-cbde-489b-9042-379b5aa8624f@palmer-ri-x1c9>
Date:   Thu, 1 Dec 2022 01:55:54 +0000
Cc:     guoren@kernel.org, Andrea Parri <andrea@rivosinc.com>,
        jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F84A2656-5938-45F7-A097-58CE348B7119@jrtc27.com>
References: <mhng-72408cf8-cbde-489b-9042-379b5aa8624f@palmer-ri-x1c9>
To:     Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2022, at 16:54, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>=20
> On Tue, 29 Nov 2022 23:15:40 PST (-0800), guoren@kernel.org wrote:
>> The comment becomes better. Thx.
>>=20
>> On Wed, Nov 30, 2022 at 10:29 AM Palmer Dabbelt <palmer@rivosinc.com> =
wrote:
>>>=20
>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>=20
>>> Currently, when detecting vmap stack overflow, riscv firstly =
switches
>>> to the so called shadow stack, then use this shadow stack to call =
the
>>> get_overflow_stack() to get the overflow stack. However, there's
>>> a race here if two or more harts use the same shadow stack at the =
same
>>> time.
>>>=20
>>> To solve this race, we introduce spin_shadow_stack atomic var, which
>>> will be swap between its own address and 0 in atomic way, when the
>>> var is set, it means the shadow_stack is being used; when the var
>>> is cleared, it means the shadow_stack isn't being used.
>>>=20
>>> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> Suggested-by: Guo Ren <guoren@kernel.org>
>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>> Link: =
https://lore.kernel.org/r/20221030124517.2370-1-jszhang@kernel.org
>>> [Palmer: Add AQ to the swap, and also some comments.]
>>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>> ---
>>> Sorry to just re-spin this one without any warning, but I'd read =
patch a
>>> few times and every time I'd managed to convice myself there was a =
much
>>> simpler way of doing this.  By the time I'd figured out why that's =
not
>>> the case it seemed faster to just write the comments.
>>>=20
>>> I've stashed this, right on top of the offending commit, at
>>> palmer/riscv-fix_vmap_stack.
>>>=20
>>> Since v3:
>>> - Add AQ to the swap.
>>> - Add a bunch of comments.
>>>=20
>>> Since v2:
>>> - use REG_AMOSWAP
>>> - add comment to the purpose of smp_store_release()
>>>=20
>>> Since v1:
>>> - use smp_store_release directly
>>> - use unsigned int instead of atomic_t
>>> ---
>>> arch/riscv/include/asm/asm.h |  1 +
>>> arch/riscv/kernel/entry.S    | 13 +++++++++++++
>>> arch/riscv/kernel/traps.c    | 18 ++++++++++++++++++
>>> 3 files changed, 32 insertions(+)
>>>=20
>>> diff --git a/arch/riscv/include/asm/asm.h =
b/arch/riscv/include/asm/asm.h
>>> index 618d7c5af1a2..e15a1c9f1cf8 100644
>>> --- a/arch/riscv/include/asm/asm.h
>>> +++ b/arch/riscv/include/asm/asm.h
>>> @@ -23,6 +23,7 @@
>>> #define REG_L          __REG_SEL(ld, lw)
>>> #define REG_S          __REG_SEL(sd, sw)
>>> #define REG_SC         __REG_SEL(sc.d, sc.w)
>>> +#define REG_AMOSWAP_AQ __REG_SEL(amoswap.d.aq, amoswap.w.aq)
>> Below is the reason why I use the relax version here:
>> =
https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=3DC+v+OL_=
_GQam4A@mail.gmail.com/T/#u
>=20
> Sorry, I hadn't seen that one.  Adding Andrea.  IMO the =
acquire/release pair is necessary here, with just relaxed the stack =
stores inside the lock could show up on the next hart trying to use the =
stack.

I think what you really want is a *consume* barrier, and since you have
the data dependency between the amoswap and the memory accesses (and
this isn=E2=80=99t Alpha) you=E2=80=99re technically fine without the =
acquire, since
you=E2=80=99re writing assembly and have the data dependency as =
syntactic.
Though you may still want (need?) the acquire so loads/stores unrelated
to the stack pointer that happen later in program order get ordered
after the load of the new stack pointer in case there could be weird
issues *there*.

Jess

>>> #define REG_ASM                __REG_SEL(.dword, .word)
>>> #define SZREG          __REG_SEL(8, 4)
>>> #define LGREG          __REG_SEL(3, 2)
>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>> index 98f502654edd..5fdb6ba09600 100644
>>> --- a/arch/riscv/kernel/entry.S
>>> +++ b/arch/riscv/kernel/entry.S
>>> @@ -387,6 +387,19 @@ handle_syscall_trace_exit:
>>>=20
>>> #ifdef CONFIG_VMAP_STACK
>>> handle_kernel_stack_overflow:
>>> +       /*
>>> +        * Takes the psuedo-spinlock for the shadow stack, in case =
multiple
>>> +        * harts are concurrently overflowing their kernel stacks.  =
We could
>>> +        * store any value here, but since we're overflowing the =
kernel stack
>>> +        * already we only have SP to use as a scratch register.  So =
we just
>>> +        * swap in the address of the spinlock, as that's definately =
non-zero.
>>> +        *
>>> +        * Pairs with a store_release in handle_bad_stack().
>>> +        */
>>> +1:     la sp, spin_shadow_stack
>>> +       REG_AMOSWAP_AQ sp, sp, (sp)
>>> +       bnez sp, 1b
>>> +
>>>        la sp, shadow_stack
>>>        addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>>>=20
>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>> index bb6a450f0ecc..be54ccea8c47 100644
>>> --- a/arch/riscv/kernel/traps.c
>>> +++ b/arch/riscv/kernel/traps.c
>>> @@ -213,11 +213,29 @@ asmlinkage unsigned long =
get_overflow_stack(void)
>>>                OVERFLOW_STACK_SIZE;
>>> }
>>>=20
>>> +/*
>>> + * A pseudo spinlock to protect the shadow stack from being used by =
multiple
>>> + * harts concurrently.  This isn't a real spinlock because the lock =
side must
>>> + * be taken without a valid stack and only a single register, it's =
only taken
>>> + * while in the process of panicing anyway so the performance and =
error
>>> + * checking a proper spinlock gives us doesn't matter.
>>> + */
>>> +unsigned long spin_shadow_stack;
>>> +
>>> asmlinkage void handle_bad_stack(struct pt_regs *regs)
>>> {
>>>        unsigned long tsk_stk =3D (unsigned long)current->stack;
>>>        unsigned long ovf_stk =3D (unsigned =
long)this_cpu_ptr(overflow_stack);
>>>=20
>>> +       /*
>>> +        * We're done with the shadow stack by this point, as we're =
on the
>>> +        * overflow stack.  Tell any other concurrent overflowing =
harts that
>>> +        * they can proceed with panicing by releasing the =
pseudo-spinlock.
>>> +        *
>>> +        * This pairs with an amoswap.aq in =
handle_kernel_stack_overflow.
>>> +        */
>>> +       smp_store_release(&spin_shadow_stack, 0);
>>> +
>>>        console_verbose();
>>>=20
>>>        pr_emerg("Insufficient stack space to handle exception!\n");
>>> --
>>> 2.38.1
>>>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

