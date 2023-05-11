Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D06FECA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjEKHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbjEKHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C88A60;
        Thu, 11 May 2023 00:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D30664B1F;
        Thu, 11 May 2023 07:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF67C433D2;
        Thu, 11 May 2023 07:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683789574;
        bh=RldIo1naMhWsjg+eblgYl0fqvCmzAXd9XT2gYmTJlYY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TCHeOcbFHEFBlnfvO2DcVzeUngNfP9qkTplOBwpJtXXFm9ai6OdBnNDT9v2KbJldH
         GSKdJOlY20kYo0JrPMQ2XgkAFVs57BEzQ42lZst5p2ifzeNZ7VwJi6VWWM+pRJoXvc
         luYYyULNuHr2AYM9rq9TfPfl/4j7N3zOiDwABp1n+b2N5KVKOQ62R2Xvd9ZeOmW6a0
         wmINNZvpe1S+4QkmnGCbzBhPCJgRNmWc2lFoa4Z5Hd7q91FjRrBOIJDfIRb3zck7wP
         Nfr1vK3OlwFDEm3utEc61YVW68cxEaekwQSEfBg35kihDnjzGjRk/t9WlrwPHI4DQP
         TsO/jDqPF2aeg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, guoren@kernel.org,
        suagrfillet@gmail.com, jszhang@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH V9 3/4] riscv: ftrace: Add
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
In-Reply-To: <20230510101857.2953955-4-suagrfillet@gmail.com>
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
 <20230510101857.2953955-4-suagrfillet@gmail.com>
Date:   Thu, 11 May 2023 09:19:31 +0200
Message-ID: <87ttwjjpx8.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> writes:

> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>
> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> register_ftrace_direct[_multi] interfaces allowing users to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modifying direct_caller.
>
> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> store the address of direct_caller in ftrace_regs_caller. After the
> setting of the address direct_caller by direct_ops->func and the
> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ftrace.h |  8 ++++++++
>  arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e0632493482f..fdf0b219a02c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -144,6 +144,7 @@ config RISCV
>  	select UACCESS_MEMCPY if !MMU
>  	select ZONE_DMA32 if 64BIT
>  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYN=
AMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 84f856a3286e..84904c1e4369 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -114,6 +114,14 @@ struct ftrace_regs;
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs);
>  #define ftrace_graph_func ftrace_graph_func
> +
> +static inline void
> +__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
> +{
> +		regs->t1 =3D addr;
> +}
> +#define arch_ftrace_set_direct_caller(fregs, addr) \
> +	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>=20=20
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dy=
n.S
> index f26e9f6e2fed..9d405baedb52 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -231,6 +231,7 @@ ENDPROC(ftrace_caller)
>=20=20
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  ENTRY(ftrace_regs_caller)
> +	move	t1, zero

Please use "mv", and not "move" [1].

>  	SAVE_ABI_REGS 1
>  	PREPARE_ARGS
>=20=20
> @@ -239,7 +240,10 @@ ftrace_regs_call:
>  	call	ftrace_stub
>=20=20
>  	RESTORE_ABI_REGS 1
> +	bnez	t1,.Ldirect
>  	jr t0
> +.Ldirect:
> +	jr t1

Again, while you're doing changes here, please try to align op/operands.

Wearing my BPF hat, I'm happy to finally get DIRECT_CALLS support!

This does not take the WITH_CALL_OPS approach Mark suggested in the v7
threads, but given that text patching story on RISC-V is still a bit sad
(inconsistency in the RV tree, no specification, cannot work with
preempt, ...) I'd say this approach is OK for now, and we can change to
WITH_CALL_OPS later in a wider "let's improve RISC-V textpatching" work.

Thoughts?


Bj=C3=B6rn

[1] https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm=
.md#-a-listing-of-standard-risc-v-pseudoinstructions
