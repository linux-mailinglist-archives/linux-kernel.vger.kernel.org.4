Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBFF6CC8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC1RDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjC1RDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:03:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A52F770
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4650CCE1DDD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 17:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0870C433D2;
        Tue, 28 Mar 2023 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680023009;
        bh=in0IdUiQPH3Cv4MI/zIdwXOMEHraRgEvyxAlOWnfFm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvCdDWGuafHDjP2V7kD1KJP+i46DEda3R4GL0p14N49usgSmntPk/iZzrvlnQmvvS
         /MA0UzAkuUzNtGIV3J2rEPtkfyDfEkoGxsWaC6ciejXHgKn3X0BhvwkcHXHxIMdghy
         cZBh4pQ5XeTTY0D7JJ8qbDIyLtOfKb06RtVx0Uzd8/EhARQDXhIYD58OBcaIwppd8G
         l/SKNn3J3Z5ADmDx59y/P+KSge4Z4aaLNsI3skjFni3a+tHMyM0edp4XI/7U+R7G8f
         sTq947L1JruZRGkPDJ5+RMi6RutKeMT62wxwCUSl9iRCWf7BGf/oeuYupngAmGKbM/
         X2hyg29GXuwAw==
Date:   Tue, 28 Mar 2023 18:03:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/fault: Dump user opcode bytes on fatal faults
Message-ID: <d7111158-7e17-4c88-a8c1-a568db5891fa@spud>
References: <20230327115642.1610-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E30cZZlBmncUM56x"
Content-Disposition: inline
In-Reply-To: <20230327115642.1610-1-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E30cZZlBmncUM56x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

riscv/fault: Dump user opcode bytes on fatal faults

I think you can drop the /fault, we don't usually use prefixes that like
for RISC-V.

On Mon, Mar 27, 2023 at 07:56:42PM +0800, Yunhui Cui wrote:
> We encountered such a problem(logs are below). We are more curious about
> which instruction execution caused the exception. After dumping it
> through show_opcodes(), we found that it was caused by a floating-point
> instruction.
>=20
> In this way, we found the problem: in the system bringup , it is
> precisely that we have not enabled the floating point function.

What do you mean by that "have not enabled the floating point function"?

> So when an exception occurs, it is necessary to dump the instruction
> that caused the exception, like x86/fault (ba54d856a9d8).

That's not the usual format for referring to commits, checkpatch should
complain about that.

>=20
> Logs:
> [    0.822481] Run /init as init process
> [    0.837569] init[1]: unhandled signal 4 code 0x1 at 0x000000000005e028=
 in bb[10000+5fe000]
> [    0.932292] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00048-g4a8=
43c9043e8-dirty #138

5.14-rc4?, oof! Need to get yourself onto a released, LTS kernel I
think!

Anyway, this patch doesn't apply to either riscv/for-next, riscv/fixes
or v6.3-rc1. What is the appropriate base to apply this patch?

> [    0.932949] Hardware name:  , BIOS
> [    0.933399] epc : 000000000005e028 ra : 000000000007c7c4 sp : 0000003f=
ffd45da0
> [    0.933855]  gp : ffffffff816ea2d8 tp : 0000000000000000 t0 : 00000000=
00000000
> [    0.934303]  t1 : 0000003fffd35df0 t2 : 0000000000000000 s0 : 00000000=
00000000
> [    0.934734]  s1 : 0000000000000000 a0 : 0000003fffd36190 a1 : 0000003f=
ffd45e18
> [    0.935200]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000=
00000000
> [    0.935622]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000=
00000000
> [    0.936073]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 00000000=
00000000
> [    0.936495]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000000=
00000000
> [    0.936947]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 00000000=
00000000
> [    0.937487]  s11: 0000000000d14980 t3 : 0000000000000000 t4 : 00000000=
00000000
> [    0.937954]  t5 : 0000000000000000 t6 : 0000000000000000
> [    0.938510] status: 0000000200000020 badaddr: 00000000f0028053 cause: =
0000000000000002

I have no idea what the significance of this particular backtrace is,
could you elaborate on what this is demonstrating? (and drop the leading
[###] too as it doesn't exactly add anything!

Thanks,
Conor.

> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/bug.h |  1 +
>  arch/riscv/kernel/process.c  | 30 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c    |  1 +
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index d3804a2f9aad..77655dd10a2c 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -86,6 +86,7 @@ struct pt_regs;
>  struct task_struct;
> =20
>  void __show_regs(struct pt_regs *regs);
> +void show_opcodes(struct pt_regs *regs);
>  void die(struct pt_regs *regs, const char *str);
>  void do_trap(struct pt_regs *regs, int signo, int code, unsigned long ad=
dr);
> =20
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 03ac3aa611f5..759dc74fe160 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -83,6 +83,36 @@ void show_regs(struct pt_regs *regs)
>  		dump_backtrace(regs, NULL, KERN_DEFAULT);
>  }
> =20
> +static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
> +		     unsigned int nbytes)
> +{
> +	if (!user_mode(regs))
> +		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
> +
> +	/* The user space code from other tasks cannot be accessed. */
> +	if (regs !=3D task_pt_regs(current))
> +		return -EPERM;
> +
> +	return copy_from_user_nofault(buf, (void __user *)src, nbytes);
> +}
> +
> +void show_opcodes(struct pt_regs *regs)
> +{
> +	u8 opcodes[4];
> +
> +	switch (copy_code(regs, opcodes, regs->epc, sizeof(opcodes))) {
> +	case 0:
> +		pr_info("Opcode: %4ph", opcodes);
> +		break;
> +	case -EPERM:
> +		pr_err("Unable to access userspace of other tasks");
> +		break;
> +	default:
> +		pr_err("Failed to access opcode");
> +		break;
> +	}
> +}
> +
>  void start_thread(struct pt_regs *regs, unsigned long pc,
>  	unsigned long sp)
>  {
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 0a98fd0ddfe9..a6f6851e4e87 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -68,6 +68,7 @@ void do_trap(struct pt_regs *regs, int signo, int code,=
 unsigned long addr)
>  		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
>  		pr_cont("\n");
>  		__show_regs(regs);
> +		show_opcodes(regs);
>  	}
> =20
>  	force_sig_fault(signo, code, (void __user *)addr);
> --=20
> 2.20.1
>=20

--E30cZZlBmncUM56x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCMd3QAKCRB4tDGHoIJi
0nJKAP9oJW+U6s6WiBG8oDlJhmx8KPX90ULPIfUpYQ1nxxY8IQEAmUowIBaGhB3C
SlrhQD6IrQ8MekBvxWWSBkONCR3A+AM=
=D2JS
-----END PGP SIGNATURE-----

--E30cZZlBmncUM56x--
