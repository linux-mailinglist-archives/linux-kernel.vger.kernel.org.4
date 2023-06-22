Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C410873A7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFVSCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjFVSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:02:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A11FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:02:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39ecf031271so3929112b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687456930; x=1690048930;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNedEHKdy3Sq2pC4S9lvmkW9ty8TdoFP0ANZLsoNiXM=;
        b=kgiW2yGMlxSjNtXXUYJtQKxtO9ZutniyYhQwFHkRqEhYzFwe/McW6/rMGiWDKSzNgx
         2sIV3jv7538SekcZJwUfXY6dihhmd9d9GCa0jCqZIWYmndXuKNO/aacATc1DtRfoxQjm
         geIavH46RGx1sYBzp6b/GBbyIT2fgbgUEt28rhhWx8B+Io2cdVfp7/wz2FhnKf5Sr2dr
         UHHuqoX9K/CxaLut39MEUELV2t5EfVIQz/fRSml7TJMBXnYpLM8DJ+8DUAd9jocn7zvc
         nIG7CT07w8W0G63uteNdIYyYpc4rfEEBZNq4fnAHZjBbBfbOvgSl+xzpCtYgN1gWtJSj
         IrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456930; x=1690048930;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNedEHKdy3Sq2pC4S9lvmkW9ty8TdoFP0ANZLsoNiXM=;
        b=BFGmydOPKpTo8itHj4XnkEtntSP5RPpZEHsAFBW80GWGVYdIgBKTDswQdwLCqXX98z
         RIfSs4wS7Fwgsi0k8I4dKzv97w5uzcRP1XZLqsIpCjJfy1rkUxYihD3EnRTiJnp8jDqP
         j2WqRmcVtTSLcYXsioaRiaxd7D978XmCxSPw5QREgYk5Pf+du+3hWWaaKiVrSkQpFc6s
         cnPJya1LolRTGDuP8GqV5GmCporwp39s34ElsJ73XnPFgymcAO1y1JIR03FNBxVebNik
         i8H6iePHIC+59MU5Mxm38T02XWo3/NClw5aS772adztBKaTayhLQkmJKDMIo6cIR9azV
         Wtiw==
X-Gm-Message-State: AC+VfDxXkPA9ePYsm54jNR1XsFBD/+w0NZdhaYkem5fakTkJpjF6LH6A
        BKZOo8GGMD0IKTzsnNrsm2Xe5A==
X-Google-Smtp-Source: ACHHUZ7GZe9K4yocGcHPot8NT07229+nMwJFXJ9wGbcZqe8Tc3raEXcoNjEmojmbtt5AvSfzV9g9pw==
X-Received: by 2002:aca:1913:0:b0:39e:cf4c:4556 with SMTP id l19-20020aca1913000000b0039ecf4c4556mr12997557oii.35.1687456929040;
        Thu, 22 Jun 2023 11:02:09 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a6b4400b00260e7c2cedesm18285pjl.57.2023.06.22.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:02:08 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:02:08 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 11:01:27 PDT (-0700)
Subject:     Re: [PATCH] riscv: Discard vector state on syscalls
In-Reply-To: <ZJSLKrB/4xaYB75d@bruce.bluespec.com>
CC:     bjorn@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Bjorn Topel <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, remi@remlab.net, andy.chiu@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Darius Rad <darius@bluespec.com>
Message-ID: <mhng-4c2014dc-5e23-4fb8-b5cc-d70f29d905d5@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 10:55:54 PDT (-0700), Darius Rad wrote:
> On Thu, Jun 22, 2023 at 10:46:31AM -0700, Palmer Dabbelt wrote:
>> On Thu, 22 Jun 2023 10:36:13 PDT (-0700), bjorn@kernel.org wrote:
>> > From: Björn Töpel <bjorn@rivosinc.com>
>> > 
>> > The RISC-V vector specification states:
>> >   Executing a system call causes all caller-saved vector registers
>> >   (v0-v31, vl, vtype) and vstart to become unspecified.
>> > 
>> > The vector registers are cleared, vill is set (invalid), and the
>> > vector status is set to Initial.
>> > 
>> > That way we can prevent userspace from accidentally relying on the
>> > stated save.
>> > 
>> > Rémi pointed out [1] that clearing the registers might be superfluous,
>> > and setting vill is sufficient.
>> > 
>> > Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.remlab.net/ # [1]
>> > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > Suggested-by: Rémi Denis-Courmont <remi@remlab.net>
>> > Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>> > ---
>> > 
>> > I figured I'd sent out a proper patch. I like Andy's optimization
>> > patch, but TBH I think we should do that as a follow up.
>> > 
>> > As Rémi pointed out, the clearing might be opted out, but I left it in
>> > here.
>> 
>> I think we're going to end up with a bunch of uarch-specific stuff here, but
>> for now having the heavy hammer seems safest.  There's no V hardware yet so
>> we can't really tell how anything performs, at least this way we're
>> definately not leaking anything.
>> 
>> So I'm OK with this.  I'd also be fine with clearing to all-1s, I think it's
>> kind of splitting hairs at this point: the 1s are nice because they're what
>> the rest of V does, but setting vill should make everything trap anyway so
>> maybe it doesn't matter -- and it's not clear if 1 or 0 will allow initial,
>> so who knows.
>> 
>> Darius: I'm cool swapping over to the 1s if you feel strongly about it.
>> Bjorn says Sweeden is on vacation, so just LMK and I'll re-spin it with the
>> 1s.
>
> I think all 1s would be preferred, but I don't think it's particularly
> critical (splitting hairs, like you said), so I'll let you make the call.  

OK, I'm just going to take this then as it's the less work option ;)

>
>> 
>> Regardless I'd like to pick up something that blows away V state for this
>> merge window, as it'll make sure the uABI is quite strictly enforced.
>> 
>> > Björn
>> > 
>> > ---
>> >  arch/riscv/include/asm/vector.h | 25 +++++++++++++++++++++++++
>> >  arch/riscv/kernel/traps.c       |  2 ++
>> >  2 files changed, 27 insertions(+)
>> > 
>> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
>> > index 04c0b07bf6cd..692ce55e4a69 100644
>> > --- a/arch/riscv/include/asm/vector.h
>> > +++ b/arch/riscv/include/asm/vector.h
>> > @@ -163,6 +163,30 @@ static inline void __switch_to_vector(struct task_struct *prev,
>> >  void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
>> >  bool riscv_v_vstate_ctrl_user_allowed(void);
>> > 
>> > +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
>> > +{
>> > +	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
>> > +
>> > +	if (!riscv_v_vstate_query(regs))
>> > +		return;
>> > +
>> > +	riscv_v_enable();
>> > +	asm volatile (
>> > +		".option push\n\t"
>> > +		".option arch, +v\n\t"
>> > +		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
>> > +		"vmv.v.i	v0, 0\n\t"
>> > +		"vmv.v.i	v8, 0\n\t"
>> > +		"vmv.v.i	v16, 0\n\t"
>> > +		"vmv.v.i	v24, 0\n\t"
>> > +		"vsetvl		%0, x0, %1\n\t"
>> > +		".option pop\n\t"
>> > +		: "=&r" (vl) : "r" (vtype_inval) : "memory");
>> > +	riscv_v_disable();
>> > +
>> > +	riscv_v_vstate_on(regs);
>> > +}
>> > +
>> >  #else /* ! CONFIG_RISCV_ISA_V  */
>> > 
>> >  struct pt_regs;
>> > @@ -178,6 +202,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
>> >  #define __switch_to_vector(__prev, __next)	do {} while (0)
>> >  #define riscv_v_vstate_off(regs)		do {} while (0)
>> >  #define riscv_v_vstate_on(regs)			do {} while (0)
>> > +#define riscv_v_vstate_discard(regs)		do {} while (0)
>> > 
>> >  #endif /* CONFIG_RISCV_ISA_V */
>> > 
>> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> > index 05ffdcd1424e..00c68b57ff88 100644
>> > --- a/arch/riscv/kernel/traps.c
>> > +++ b/arch/riscv/kernel/traps.c
>> > @@ -295,6 +295,8 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>> >  		regs->epc += 4;
>> >  		regs->orig_a0 = regs->a0;
>> > 
>> > +		riscv_v_vstate_discard(regs);
>> > +
>> >  		syscall = syscall_enter_from_user_mode(regs, syscall);
>> > 
>> >  		if (syscall < NR_syscalls)
>> > 
>> > base-commit: 4681dacadeefa5ca6017e00736adc1d7dc963c6a
>
> -- 
> You received this message because you are subscribed to the Google Groups "linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux+unsubscribe@rivosinc.com.
> To view this discussion on the web visit https://groups.google.com/a/rivosinc.com/d/msgid/linux/ZJSLKrB/4xaYB75d%40bruce.bluespec.com.
> For more options, visit https://groups.google.com/a/rivosinc.com/d/optout.
