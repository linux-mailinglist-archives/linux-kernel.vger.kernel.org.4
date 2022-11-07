Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDD61FAA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKGQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKGQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:55:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF221816
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AB8611B9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39015C433D6;
        Mon,  7 Nov 2022 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667840126;
        bh=xxmitB7YVY1fZlVuHqV6+E2y/y/Yel+cHtpnyZFocU8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iso/bddI2ZtN40cHEiGaPJVQkfSv0MpjSXzMEsmY4oNqHa+at9Rvl+3+SRJ+cz1Uc
         OqKnZLDShZz04kUfNR/Z71pyL7bXI0jNnlQhTVKDTkmdZR3hvtAs84G2kWXpdY2oMD
         O+sZIyZH5YUyujFwnSYz+ezEDWsiEEBJiD6En+sWeUyjxpW6LoW8T4ScV+MndFlVYT
         gv4/C7iDkcPc3hRMk+HTYF1JzcaWdRHEmKmmPlFpBul66tIY5L4ekvtn7Z2buXWTZS
         zVmPm/9SDmexv1FM9lU6+G6+zOPk7PhjeIBi8kV7hiL1o6VmD6zKnBIRHwy+SFupHA
         AKYHRELEUoOmA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v4 5/8] riscv/kprobe: Search free register(s) to clobber
 for 'AUIPC/JALR'
In-Reply-To: <20221106100316.2803176-6-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
 <20221106100316.2803176-6-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 07 Nov 2022 17:55:24 +0100
Message-ID: <87wn861z7n.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaochang1@huawei.com>
>
> From: Liao Chang <liaochang1@huawei.com>
>
> This patch implement the algorithm of searching free register(s) to
> form a long-jump instruction pair.
>
> AUIPC/JALR instruction pair is introduced with a much wider jump range
> (4GB), where auipc loads the upper 20 bits to a free register and jalr
> appends the lower 12 bits to form a 32 bit immediate. Since kprobes can
> be instrumented at anywhere in kernel space, hence the free register
> should be found in a generic way, not depending on the calling convention
> or any other regulations.
>
> The algorithm for finding the free register is inspired by the register
> renaming in modern processors. From the perspective of register renaming,
> a register could be represented as two different registers if two neighbo=
ur
> instructions both write to it but no one ever reads. Extending this fact,
> a register is considered to be free if there is no read before its next
> write in the execution flow. We are free to change its value without
> interfering normal execution.
>
> In order to do jump optimization, it needs to search two free registers,
> the first one is used to form AUIPC/JALR jumping to detour buffer, the
> second one is used to form JR jumping back from detour buffer. If first
> one never been updated by any instructions replaced by 'AUIPC/JALR',
> both register supposes to the same one.
>
> Let's use the example below to explain how the algorithm work. Given
> kernel is RVI and RCV hybrid binary, and one kprobe is instrumented at
> the entry of function idle_dummy.
>
> Before			Optimized		Detour buffer
> <idle_dummy>:					...
>  #1 add  sp,sp,-16	auipc a0, #?		add  sp,sp,-16
>  #2 sd   s0,8(sp)				sd   s0,8(sp)
>  #3 addi s0,sp,16	jalr  a0, #?(a0)	addi s0,sp,16
>  #4 ld   s0,8(sp)				ld   s0,8(sp)
>  #5 li   a0,0		li   a0,0		auipc a0, #?
>  #6 addi sp,sp,16	addi sp,sp,16		jr    x0, #?(a0)
>  #7 ret			ret
>
> For regular kprobe, it is trival to replace the first instruction with
> C.EREABK, no more instruction and register will be clobber, in order to

"C.EBREAK"

> optimize kprobe with long-jump, it used to patch the first 8 bytes with
> AUIPC/JALR, and a0 will be chosen to save the address jumping to,
> because from #1 to #7, a0 is the only one register that satifies two
> conditions: (1) No read before write (2) Never been updated in detour
> buffer. While s0 has been used as the source register at #2, so it is
> not free to clobber.
>
> The searching starts from the kprobe and stop at the last instruction of
> function or the first branch/jump instruction, it decodes out the 'rs'
> and 'rd' part of each visited instruction. If the 'rd' never been read
> before, then record it to bitmask 'write'; if the 'rs' never been
> written before, then record it to another bitmask 'read'. When searching
> stops, the remaining bits of 'write' are the free registers to form
> AUIPC/JALR or JR.
>

AFAIU, the algorithm only tracks registers that are *in use*. You are
already scanning the whole function (next patch). What about the caller
saved registers that are *not* used by the function in the probe range?
Can those, potentially unused, regs be used?

> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> ---
>  arch/riscv/kernel/probes/opt.c | 225 ++++++++++++++++++++++++++++++++-
>  1 file changed, 224 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index e4a619c2077e..6d23c843832e 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c

[...]

> +static void arch_find_register(unsigned long start, unsigned long end,

Nit; When I see "arch_" I think it's functionality that can be
overridden per-arch. This is not the case, but just a helper for RV.

[...]

>  static void find_free_registers(struct kprobe *kp, struct optimized_kpro=
be *op,
> -				int *rd1, int *rd2)
> +				int *rd, int *ra)

Nit; Please get rid of this code churn, just name the parameters
correctly on introduction in the previous patch.

[...]

> +	*rd =3D ((kw | ow) =3D=3D 1UL) ? 0 : __builtin_ctzl((kw | ow) & ~1UL);
> +	*ra =3D (kw =3D=3D 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);

Hmm, __builtin_ctzl is undefined for 0, right? Can that be triggered
here?


Bj=C3=B6rn
