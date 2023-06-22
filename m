Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150373A7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFVR4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFVRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:55:58 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85A1BE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:55:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6237faa8677so51927226d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20221208.gappssmtp.com; s=20221208; t=1687456556; x=1690048556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evqKVHDxZVe269Q8IjFyi7APZlufQLmWyv9A9ica0X0=;
        b=4FnsJO8nFBUrK7Bi46lBU9t37xrGt2OAxxu0++Hyfk+a025ya7U9gKSnKhX5lH0qWU
         J3+IsooPyIVKfAnLcPuCFhjfYsXxphQ5qCEz6c0PbH//F7aX1pwBkI5rJf5CXF/OgYIO
         Y6we+BTlve3wn1ZygGn0PQtV3sLxgumTZT330G7Q3+EvLj7AtvJ39lGqylem8o7Yodnr
         cwVxvo3d5Rt0TbcOJSh4LnsXkRrhaCQtlzQzTxAq4CIexiFHYu4gXmrOYEE5oQjEYMZR
         sYcW3qq0/rCfgHvy4D7DfHd766z5s7sfMWKUXR7BJNcFKuWbbPo6gz4XVDQFq3RunPON
         uafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456556; x=1690048556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evqKVHDxZVe269Q8IjFyi7APZlufQLmWyv9A9ica0X0=;
        b=k3EhkwezQa7ImnJwUow6GIKN8B2jPCX/qAeugKH5rGD278xNF6MPDMvtvkCsn3xsau
         6aj425Za+b5VvUncM8OsZ3bsOZU4vhIC23KSLWUjZ8O3cQnkiVjKGVqFytvwOkzA5EAu
         T7eddSHy6ONOpX4cXjARVpe1yXyrgpDYS8GPZ/VP81aEPb6YhvwsqYyETLCGiKT1XVMk
         cfBIrBJhTd207SFm1NXicR6igHMu/B0b53ZQVCRCdCU/M4Ibd8c0Y7iHPEp6ON9imwAv
         d8/5/qp9dniKScimv6It6zDCaayVDmEPIgE0AocPGeGnI5antUXg0JpXyqZ6Q6zqTfW+
         6fvA==
X-Gm-Message-State: AC+VfDyacnHr9H2iH7Jn/MWY3zoZn0eLeVqrU8kStYKZ+oKQQxkFICcQ
        sYLcBrFohvfUhkFpm9/dwsw5
X-Google-Smtp-Source: ACHHUZ672wytMhHXqClrZpIjlI3Xprxy1741urngUGKi8XGsFRiYqE81j5g8t+8LEy52M3W78Cy5/g==
X-Received: by 2002:ad4:5966:0:b0:629:58a7:9a98 with SMTP id eq6-20020ad45966000000b0062958a79a98mr21498437qvb.53.1687456556289;
        Thu, 22 Jun 2023 10:55:56 -0700 (PDT)
Received: from bruce.bluespec.com ([102.129.235.90])
        by smtp.gmail.com with ESMTPSA id e4-20020a0cb444000000b00630007aa8d6sm4068379qvf.34.2023.06.22.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 10:55:55 -0700 (PDT)
Date:   Thu, 22 Jun 2023 13:55:54 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     bjorn@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Bjorn Topel <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, remi@remlab.net, andy.chiu@sifive.com
Subject: Re: [PATCH] riscv: Discard vector state on syscalls
Message-ID: <ZJSLKrB/4xaYB75d@bruce.bluespec.com>
Mail-Followup-To: Palmer Dabbelt <palmer@dabbelt.com>, bjorn@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Bjorn Topel <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com, remi@remlab.net,
        andy.chiu@sifive.com
References: <20230622173613.30722-1-bjorn@kernel.org>
 <mhng-5f8ae912-3b56-4eda-bdfa-1de31a7c93e0@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-5f8ae912-3b56-4eda-bdfa-1de31a7c93e0@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:46:31AM -0700, Palmer Dabbelt wrote:
> On Thu, 22 Jun 2023 10:36:13 PDT (-0700), bjorn@kernel.org wrote:
> > From: Björn Töpel <bjorn@rivosinc.com>
> > 
> > The RISC-V vector specification states:
> >   Executing a system call causes all caller-saved vector registers
> >   (v0-v31, vl, vtype) and vstart to become unspecified.
> > 
> > The vector registers are cleared, vill is set (invalid), and the
> > vector status is set to Initial.
> > 
> > That way we can prevent userspace from accidentally relying on the
> > stated save.
> > 
> > Rémi pointed out [1] that clearing the registers might be superfluous,
> > and setting vill is sufficient.
> > 
> > Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.remlab.net/ # [1]
> > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Suggested-by: Rémi Denis-Courmont <remi@remlab.net>
> > Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> > ---
> > 
> > I figured I'd sent out a proper patch. I like Andy's optimization
> > patch, but TBH I think we should do that as a follow up.
> > 
> > As Rémi pointed out, the clearing might be opted out, but I left it in
> > here.
> 
> I think we're going to end up with a bunch of uarch-specific stuff here, but
> for now having the heavy hammer seems safest.  There's no V hardware yet so
> we can't really tell how anything performs, at least this way we're
> definately not leaking anything.
> 
> So I'm OK with this.  I'd also be fine with clearing to all-1s, I think it's
> kind of splitting hairs at this point: the 1s are nice because they're what
> the rest of V does, but setting vill should make everything trap anyway so
> maybe it doesn't matter -- and it's not clear if 1 or 0 will allow initial,
> so who knows.
> 
> Darius: I'm cool swapping over to the 1s if you feel strongly about it.
> Bjorn says Sweeden is on vacation, so just LMK and I'll re-spin it with the
> 1s.

I think all 1s would be preferred, but I don't think it's particularly
critical (splitting hairs, like you said), so I'll let you make the call.  

> 
> Regardless I'd like to pick up something that blows away V state for this
> merge window, as it'll make sure the uABI is quite strictly enforced.
> 
> > Björn
> > 
> > ---
> >  arch/riscv/include/asm/vector.h | 25 +++++++++++++++++++++++++
> >  arch/riscv/kernel/traps.c       |  2 ++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> > index 04c0b07bf6cd..692ce55e4a69 100644
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -163,6 +163,30 @@ static inline void __switch_to_vector(struct task_struct *prev,
> >  void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
> >  bool riscv_v_vstate_ctrl_user_allowed(void);
> > 
> > +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> > +{
> > +	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
> > +
> > +	if (!riscv_v_vstate_query(regs))
> > +		return;
> > +
> > +	riscv_v_enable();
> > +	asm volatile (
> > +		".option push\n\t"
> > +		".option arch, +v\n\t"
> > +		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> > +		"vmv.v.i	v0, 0\n\t"
> > +		"vmv.v.i	v8, 0\n\t"
> > +		"vmv.v.i	v16, 0\n\t"
> > +		"vmv.v.i	v24, 0\n\t"
> > +		"vsetvl		%0, x0, %1\n\t"
> > +		".option pop\n\t"
> > +		: "=&r" (vl) : "r" (vtype_inval) : "memory");
> > +	riscv_v_disable();
> > +
> > +	riscv_v_vstate_on(regs);
> > +}
> > +
> >  #else /* ! CONFIG_RISCV_ISA_V  */
> > 
> >  struct pt_regs;
> > @@ -178,6 +202,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
> >  #define __switch_to_vector(__prev, __next)	do {} while (0)
> >  #define riscv_v_vstate_off(regs)		do {} while (0)
> >  #define riscv_v_vstate_on(regs)			do {} while (0)
> > +#define riscv_v_vstate_discard(regs)		do {} while (0)
> > 
> >  #endif /* CONFIG_RISCV_ISA_V */
> > 
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 05ffdcd1424e..00c68b57ff88 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -295,6 +295,8 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> >  		regs->epc += 4;
> >  		regs->orig_a0 = regs->a0;
> > 
> > +		riscv_v_vstate_discard(regs);
> > +
> >  		syscall = syscall_enter_from_user_mode(regs, syscall);
> > 
> >  		if (syscall < NR_syscalls)
> > 
> > base-commit: 4681dacadeefa5ca6017e00736adc1d7dc963c6a
