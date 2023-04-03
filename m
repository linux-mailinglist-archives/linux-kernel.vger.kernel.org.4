Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A106D4D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjDCQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjDCQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F3170C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D916211C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723CBC433EF;
        Mon,  3 Apr 2023 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680538891;
        bh=s/h9BxcKiHCWDLpRMf/OxHcfV+3/cmpO+wdtHk8dx9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItTLRmpc/AKSD7fGCTzArFPVOVs1SdvwB4iP5dIPOx7YxjQFjLCxCB6H5P757Z28V
         UJeH1fNjndM2vu0bFuSlGA99VEslIY01Vznl2H+fqiGQR//nBIG+MyMVnqC7IdwuSk
         S2GDdtpfhKhCx6OzrhJfwOF7rl24AzReK4x7Lm24JO96e0P6iAR5RKPc7R7idrIDiH
         CeSFMBuXf6GPzVwDaFJ3wBiRrY9WvNuRHFSRhlb7BQPVCZ0ApSiZG0AYoXswhe5CKM
         G3TKTVXi9WoVP0LsqpUM7aLMnbz6eVwgsqUAbh62Essc/tl4GVwhBLUJaOxi21w0qB
         2sadR7e3s7Uuw==
Date:   Mon, 3 Apr 2023 17:21:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Yipeng Zou <zouyipeng@huawei.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH] riscv: entry: Save a0 prior
 syscall_enter_from_user_mode()
Message-ID: <20230403-crisping-animosity-04ed8a45c625@spud>
References: <20230403065207.1070974-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R7iREP1gQeGxJksL"
Content-Disposition: inline
In-Reply-To: <20230403065207.1070974-1-bjorn@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R7iREP1gQeGxJksL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 08:52:07AM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> The RISC-V calling convention passes the first argument, and the
> return value in the a0 register. For this reason, the a0 register
> needs some extra care; When handling syscalls, the a0 register is
> saved into regs->orig_a0, so a0 can be properly restored for,
> e.g. interrupted syscalls.
>=20
> This functionality was broken with the introduction of the generic
> entry patches. Here, a0 was saved into orig_a0 after calling
> syscall_enter_from_user_mode(), which can change regs->a0 for some
> paths, incorrectly restoring a0.
>=20
> This is resolved, by saving a0 prior doing the
> syscall_enter_from_user_mode() call.
>=20
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>

As you pointed out, v12 did indeed have this ordering, so *deep breath*
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/linux-riscv/60ee7c26-1a70-427d-beaf-92e2989fc=
479@spud/
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for fixing this Bj=F6rn!
> ---
>  arch/riscv/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 1f4e37be7eb3..8c258b78c925 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -270,11 +270,11 @@ asmlinkage __visible __trap_section void do_trap_ec=
all_u(struct pt_regs *regs)
>  	if (user_mode(regs)) {
>  		ulong syscall =3D regs->a7;
> =20
> -		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> -
>  		regs->epc +=3D 4;
>  		regs->orig_a0 =3D regs->a0;
> =20
> +		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> +
>  		if (syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
>  		else
>=20
> base-commit: d34a6b715a23ccd9c9d0bc7a475bea59dc3e28b2
> --=20
> 2.37.2
>=20

--R7iREP1gQeGxJksL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCr9AwAKCRB4tDGHoIJi
0uChAP9U8xmkAUQFANUtusPF/nQKVwoeUIJlqkQQzmUlIl6dZQEA2Rg5robA6oPH
5h312z8HKnb5QE9lXkT3WQea0531eQA=
=Ks/G
-----END PGP SIGNATURE-----

--R7iREP1gQeGxJksL--
