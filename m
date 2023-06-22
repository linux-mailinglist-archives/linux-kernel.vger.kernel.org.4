Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98E73A793
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFVRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjFVRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:46:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718E211E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:46:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25e7fe2fbc9so3727284a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687455992; x=1690047992;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3g1kX5EMD1FCLy8k9DY4HJHEdrclO2Id0GTE8XaK54=;
        b=PGY1iv0lzSAwgaLm8qoo8sV1X1q1+k8lB4e5qt0KpELi1frrWDZTmC/E8L+xpvyKVj
         ThyOdqec1emu2EdcvP7g9wY8/U/Ap1e/93sOqyJ6fiZCYxR5d9Q+QAT2X7Zu7xzWo5Vj
         9oKCsdDx0mE+pnjFpiNHrHf8dwjywv+aL+2KkdBZe5j/6/b+Cu+yAi1cEXEvMP3uG3Cy
         tD6ylVu4s9gr8virKgjz2yaEmndM9lCv5OWjunFTXjAdf8mqBZ6GgRfO7ybFrdGHLziX
         ELxqDAW4/j/r2fYqbMmV2wQzbnD8KkVvWgUMeT/eJwGKa0xF0xojXe9NzpgvVtblTQOp
         vV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455992; x=1690047992;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3g1kX5EMD1FCLy8k9DY4HJHEdrclO2Id0GTE8XaK54=;
        b=lKYOcs1lL4ulyI8GTiqE26WRmiOtqnRd+DMw53bDmJ8NzC5tMtI8YZ7QVIvUu/LeFp
         UeKMBQi8OG0JvWnOCiqO3uslDlSXrhj5/m2X7R7mIcBhsWObQ95LA2hnstSeNqLcQ/XT
         taMcktQUjX94M2N9ii9PUnEQuBtmXqDI2TWl5+TZPxLdaXvdwKpBPmVMUbaSGbGC0WQg
         lLgdlxZhDvbGDQg/vSeF7lg4gyi3+juKHEkJoGJf3w5+Mo//zRb5OVzNzAVfvxjTNfO0
         VUWlepQOZw4piodmX3/Jt41aD+LQ/ejyzUbtGYMZv39DTY++UhoSx5si64jqw5KCvb1o
         EMDg==
X-Gm-Message-State: AC+VfDzyudBLgUfuiwO65ekhQYqlW5pFw58B9WQCXjhFlO9OtAqcWT4A
        LrGoVmfPPUv1bOyXqYNNejXqvA==
X-Google-Smtp-Source: ACHHUZ4AP5ZV62BeieR8PqE8TcpqZtf2tmgORCE7MP8Q7zOL2rv+3UiJ7qvG9NdcdU0pi7xw3gGipw==
X-Received: by 2002:a17:90b:1953:b0:25e:b5b9:c2f1 with SMTP id nk19-20020a17090b195300b0025eb5b9c2f1mr12282340pjb.39.1687455991741;
        Thu, 22 Jun 2023 10:46:31 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id li14-20020a17090b48ce00b00256dff5f8e3sm16139pjb.49.2023.06.22.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 10:46:31 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:46:31 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 10:45:50 PDT (-0700)
Subject:     Re: [PATCH] riscv: Discard vector state on syscalls
In-Reply-To: <20230622173613.30722-1-bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Bjorn Topel <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com, remi@remlab.net,
        Darius Rad <darius@bluespec.com>, andy.chiu@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bjorn@kernel.org
Message-ID: <mhng-5f8ae912-3b56-4eda-bdfa-1de31a7c93e0@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 10:36:13 PDT (-0700), bjorn@kernel.org wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.
>
> The vector registers are cleared, vill is set (invalid), and the
> vector status is set to Initial.
>
> That way we can prevent userspace from accidentally relying on the
> stated save.
>
> Rémi pointed out [1] that clearing the registers might be superfluous,
> and setting vill is sufficient.
>
> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.remlab.net/ # [1]
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: Rémi Denis-Courmont <remi@remlab.net>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>
> I figured I'd sent out a proper patch. I like Andy's optimization
> patch, but TBH I think we should do that as a follow up.
>
> As Rémi pointed out, the clearing might be opted out, but I left it in
> here.

I think we're going to end up with a bunch of uarch-specific stuff here, 
but for now having the heavy hammer seems safest.  There's no V hardware 
yet so we can't really tell how anything performs, at least this way 
we're definately not leaking anything.

So I'm OK with this.  I'd also be fine with clearing to all-1s, I think 
it's kind of splitting hairs at this point: the 1s are nice because 
they're what the rest of V does, but setting vill should make everything 
trap anyway so maybe it doesn't matter -- and it's not clear if 1 or 0 
will allow initial, so who knows.

Darius: I'm cool swapping over to the 1s if you feel strongly about it.  
Bjorn says Sweeden is on vacation, so just LMK and I'll re-spin it with 
the 1s.

Regardless I'd like to pick up something that blows away V state for 
this merge window, as it'll make sure the uABI is quite strictly 
enforced.

> Björn
>
> ---
>  arch/riscv/include/asm/vector.h | 25 +++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c       |  2 ++
>  2 files changed, 27 insertions(+)
>
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> index 04c0b07bf6cd..692ce55e4a69 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -163,6 +163,30 @@ static inline void __switch_to_vector(struct task_struct *prev,
>  void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
>  bool riscv_v_vstate_ctrl_user_allowed(void);
>
> +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> +{
> +	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
> +
> +	if (!riscv_v_vstate_query(regs))
> +		return;
> +
> +	riscv_v_enable();
> +	asm volatile (
> +		".option push\n\t"
> +		".option arch, +v\n\t"
> +		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> +		"vmv.v.i	v0, 0\n\t"
> +		"vmv.v.i	v8, 0\n\t"
> +		"vmv.v.i	v16, 0\n\t"
> +		"vmv.v.i	v24, 0\n\t"
> +		"vsetvl		%0, x0, %1\n\t"
> +		".option pop\n\t"
> +		: "=&r" (vl) : "r" (vtype_inval) : "memory");
> +	riscv_v_disable();
> +
> +	riscv_v_vstate_on(regs);
> +}
> +
>  #else /* ! CONFIG_RISCV_ISA_V  */
>
>  struct pt_regs;
> @@ -178,6 +202,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
>  #define __switch_to_vector(__prev, __next)	do {} while (0)
>  #define riscv_v_vstate_off(regs)		do {} while (0)
>  #define riscv_v_vstate_on(regs)			do {} while (0)
> +#define riscv_v_vstate_discard(regs)		do {} while (0)
>
>  #endif /* CONFIG_RISCV_ISA_V */
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05ffdcd1424e..00c68b57ff88 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -295,6 +295,8 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  		regs->epc += 4;
>  		regs->orig_a0 = regs->a0;
>
> +		riscv_v_vstate_discard(regs);
> +
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>
>  		if (syscall < NR_syscalls)
>
> base-commit: 4681dacadeefa5ca6017e00736adc1d7dc963c6a
