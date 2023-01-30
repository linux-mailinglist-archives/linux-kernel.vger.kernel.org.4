Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25D681D30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjA3Vt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3VtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:49:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC0C72B0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB8D8B8169F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA69BC433D2;
        Mon, 30 Jan 2023 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675115361;
        bh=CeFUjt1qi5cKN9n5135B7q6JriZX4WQ5PfaYh6IzHlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSGnSoSJmHmWMBcJL26Y/a/Qjynrpse+xHoQ1tZddfwIMjmAyA4aXHxAUILnJVrhb
         ocS7+ydtWz02tmR36c6QURDWz8ciMBGcuOgo1oUN8Ft0dj3AalzCDjWHFpcsnXZHHO
         j3yYxikggkmbFVub5fNafgWrsVsYF930niOqj6ialkRAZb6dtAt6rhL9PBvhLhz0Hp
         zVmE4/exYbDVayHy2FAJZf1jyJU7tzjycHRD1zPlsEvTyuEDzvRltMlNTcvJ38lbYi
         ekE4ZOdQAeNLFXTeFKtXk2BtOoEhq3wMem3WHs3pFKW6nhFwGN+Oc33aWs8e6VQzxp
         sn1YFg4qHiM9w==
Date:   Mon, 30 Jan 2023 21:49:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v3 2/4] RISC-V: Factor out common code of
 __cpu_resume_enter()
Message-ID: <Y9g7XeTbWjCxB3BT@spud>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hb+0kK26SmitlXYB"
Content-Disposition: inline
In-Reply-To: <20230127091051.1465278-3-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hb+0kK26SmitlXYB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 05:10:49PM +0800, Sia Jee Heng wrote:
> The cpu_resume() function is very similar for the suspend to disk and
> suspend to ram cases. Factor out the common code into restore_csr macro
> and restore_reg macro.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  arch/riscv/include/asm/assembler.h | 62 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/suspend_entry.S  | 34 ++--------------
>  2 files changed, 65 insertions(+), 31 deletions(-)
>  create mode 100644 arch/riscv/include/asm/assembler.h
>=20
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/=
assembler.h
> new file mode 100644
> index 000000000000..ef1283d04b70
> --- /dev/null
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#ifndef __ASSEMBLY__
> +#error "Only include this from assembly code"
> +#endif
> +
> +#ifndef __ASM_ASSEMBLER_H
> +#define __ASM_ASSEMBLER_H
> +
> +#include <asm/asm.h>
> +#include <asm/csr.h>
> +#include <asm/asm-offsets.h>
> +
> +/**
> + * restore_csr - restore hart's CSR value
> + */
> +	.macro restore_csr
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> +		csrw	CSR_EPC, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> +		csrw	CSR_STATUS, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> +		csrw	CSR_TVAL, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> +		csrw	CSR_CAUSE, t0
> +	.endm
> +
> +/**
> + * restore_reg - Restore registers (except A0 and T0-T6)

arch/riscv/include/asm/assembler.h:34: warning: Incorrect use of kernel-doc=
 format:  * restore_reg - Restore registers (except A0 and T0-T6)

Otherwise, LGTM.

> + */
> +	.macro restore_reg
> +		REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> +		REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> +		REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> +		REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> +		REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> +		REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> +		REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> +		REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> +		REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> +		REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> +		REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> +		REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> +		REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> +		REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> +		REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> +		REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> +		REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> +		REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> +		REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> +		REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> +		REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> +		REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> +		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +	.endm
> +
> +#endif	/* __ASM_ASSEMBLER_H */
> diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspen=
d_entry.S
> index aafcca58c19d..74a8fab8e0f6 100644
> --- a/arch/riscv/kernel/suspend_entry.S
> +++ b/arch/riscv/kernel/suspend_entry.S
> @@ -7,6 +7,7 @@
>  #include <linux/linkage.h>
>  #include <asm/asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
>  #include <asm/csr.h>
>  #include <asm/xip_fixup.h>
> =20
> @@ -83,39 +84,10 @@ ENTRY(__cpu_resume_enter)
>  	add	a0, a1, zero
> =20
>  	/* Restore CSRs */
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> -	csrw	CSR_EPC, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> -	csrw	CSR_STATUS, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> -	csrw	CSR_TVAL, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> -	csrw	CSR_CAUSE, t0
> +	restore_csr
> =20
>  	/* Restore registers (except A0 and T0-T6) */
> -	REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> -	REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> -	REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> -	REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> -	REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> -	REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> -	REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> -	REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> -	REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> -	REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> -	REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> -	REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> -	REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> -	REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> -	REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> -	REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> -	REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> -	REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> -	REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> -	REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> -	REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> -	REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> -	REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +	restore_reg
> =20
>  	/* Return zero value */
>  	add	a0, zero, zero
> --=20
> 2.34.1
>=20

--Hb+0kK26SmitlXYB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9g7XQAKCRB4tDGHoIJi
0gfTAP94o9Bp9hjJ9nyX1uAV0kJl3St5aJLTOE4jHIfw7w0AbQEA36tFzpX/hj8T
eFWNhYi0dCzk90b9EkfBFpnoG3Zr8gs=
=San3
-----END PGP SIGNATURE-----

--Hb+0kK26SmitlXYB--
