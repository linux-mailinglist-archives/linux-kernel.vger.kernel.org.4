Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6A72758A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjFHDSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjFHDSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:18:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F11FEB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:18:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so221456276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686194309; x=1688786309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwc6mr2r66yO+R5nODwj7/lU18A/4J2eFRpjFzGkqug=;
        b=VaeTuAgYgLsecxvVPssPOWgo1sp2wNekGxhFy3iiwXqvq1zCJ12gzmsq9YNV23SJ2p
         zpQNGpUR5dz9+/eS2XIv69onMv9PtK9BT3Tec7cdQ5MvKknXHMWwQ55tJ4WSVONQXiqw
         fijgkeHS+i7zcHGwvEoTPMC9K0qfBpRIfblYeOHCKrC1v5SOBtB/RGlmYQFQJvAjDOml
         36EiAPW8PPDjFJ12OxmaQkLLFy2FK2/gz/7nIDDRRX8CW5vH4mUEsRNDlkGN9V0YE8G3
         1V3kELCdBugSmjpoDSqfflyGuYv+gnV9+ANujB3mvbc5WVNotikc6U9IXEfNjxAA8WiQ
         ejJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686194309; x=1688786309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwc6mr2r66yO+R5nODwj7/lU18A/4J2eFRpjFzGkqug=;
        b=hJF8PHLsRKpd/QwOVcPqzTEU9xRwOGtjWQXCD7bkL5wHNV9CJ1EJxFeYYS5E+w0Hs7
         FT8cb362Q2PKdIf+A1ARfCGGfV77KaTjLbASPf/yLIN3NuU03YZsSxYfFw8U6o/7SXg1
         a02IQ/uNDtkxp6xykrja2BljtOhksUtgfAH4Vqt0+PVV0+uNymvJqU2iDByLK4hAZi9C
         32pR4YLWky3xsM8nrDbIXLE2yTTCCxj4Wu/29XhNiOFhAhLcysm6cMZJWPp5MxNV0ZLA
         NrNGmEkOf4DWaYdfjigPDLjQn3SHT3KOer5YdZ5OyPtajKzwCc2uT5oTEZr53jXg0djo
         G5IQ==
X-Gm-Message-State: AC+VfDw2syC9gJxuO1HeidlaafOtYoGvQJSUk3enH1PvlXyo1mjfAFcK
        UZMv/wY1lPk2+T7F9ZrUJFoD0Yus9z6cE7cyPg==
X-Google-Smtp-Source: ACHHUZ6uZ6vg9jT7+/EDn6fcB6hMpnV3J5VTaF0D1m8ll3MrrHaRriubHRS9DP18YPp7RAA2QC3cBTqXcnYbY7WxXj0=
X-Received: by 2002:a0d:cd04:0:b0:568:f405:cbfe with SMTP id
 p4-20020a0dcd04000000b00568f405cbfemr8265867ywd.47.1686194309459; Wed, 07 Jun
 2023 20:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-3-nik.borisov@suse.com> <87o7lrk568.ffs@tglx>
In-Reply-To: <87o7lrk568.ffs@tglx>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 7 Jun 2023 23:18:18 -0400
Message-ID: <CAMzpN2ir7OCppX0WvbCsabH=1U5kToDeeHq69i-ze3WhTnWDew@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/entry: Disable IA32 syscalls in the presence of ia32_disabled
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 5:23=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Wed, Jun 07 2023 at 10:29, Nikolay Borisov wrote:
> > diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> > index ab97b22ac04a..618b428586d1 100644
> > --- a/arch/x86/include/asm/desc.h
> > +++ b/arch/x86/include/asm/desc.h
> > @@ -8,6 +8,7 @@
> >  #include <asm/fixmap.h>
> >  #include <asm/irq_vectors.h>
> >  #include <asm/cpu_entry_area.h>
> > +#include <asm/traps.h>
> >
> >  #include <linux/debug_locks.h>
> >  #include <linux/smp.h>
> > @@ -429,6 +430,10 @@ static inline void idt_init_desc(gate_desc *gate, =
const struct idt_data *d)
> >       gate->offset_high       =3D (u32) (addr >> 32);
> >       gate->reserved          =3D 0;
> >  #endif
> > +#ifdef CONFIG_IA32_EMULATION
> > +     if (ia32_disabled && d->vector =3D=3D IA32_SYSCALL_VECTOR)
> > +             gate->bits.p =3D 0;
> > +#endif
>
> Why installing the IDT vector in the first place? This is completely
> inconsistent with the CONFIG_IA32_EMULATION=3Dn behaviour.
>
> Just slapping this conditional into some random place is really not
> cutting it.
>
> The obvious solution is to remove IA32_SYSCALL_VECTOR from def_idts[]
> and handle it separately.
>
> >  extern unsigned long system_vectors[];
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.=
c
> > index 80710a68ef7d..71f8b55f70c9 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -2054,17 +2054,24 @@ void syscall_init(void)
> >       wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
> >
> >  #ifdef CONFIG_IA32_EMULATION
> > -     wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
> > -     /*
> > -      * This only works on Intel CPUs.
> > -      * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSE=
NTER_EIP.
> > -      * This does not cause SYSENTER to jump to the wrong location, be=
cause
> > -      * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit)=
.
> > -      */
> > -     wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
> > -     wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
> > -                 (unsigned long)(cpu_entry_stack(smp_processor_id()) +=
 1));
> > -     wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
> > +     if (ia32_disabled) {
> > +             wrmsrl_cstar((unsigned long)ignore_sysret);
> > +             wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_=
SEG);
> > +             wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
> > +             wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
> > +     } else {
> > +             wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
> > +             /*
> > +              * This only works on Intel CPUs.
> > +              * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_I=
A32_SYSENTER_EIP.
> > +              * This does not cause SYSENTER to jump to the wrong loca=
tion, because
> > +              * AMD doesn't allow SYSENTER in long mode (either 32- or=
 64-bit).
> > +              */
> > +             wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
> > +             wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
> > +                         (unsigned long)(cpu_entry_stack(smp_processor=
_id()) + 1));
> > +             wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_co=
mpat);
> > +     }
> >  #else
> >       wrmsrl_cstar((unsigned long)ignore_sysret);
> >       wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
>
> So this ends up with two copies of the same code for invalidating
> compat. Why?
>
>    if (IS_ENABLED(CONFIG_IA32_EMULATION) && !ia32_disabled)) {
>         wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
>         ...
>    } else {
>         wrmsrl_cstar((unsigned long)ignore_sysret);
>         ...
>    }
>
> All it requires is
>
> #ifdef CONFIG_IA32_EMULATION
> void entry_SYSCALL_compat(void);
> #else
> #define entry_SYSCALL_compat NULL
> #endif
>
> in the header which declares entry_SYSCALL_compat.
>
> No?

SYSCALL from 32-bit mode can't be disabled like that.  That's why
ignore_sysret() exists for the !CONFIG_IA32_EMULATION case.

Brian Gerst
