Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9457403CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF0TJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjF0TJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29971FFB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FEE86120F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE33C433C0;
        Tue, 27 Jun 2023 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892953;
        bh=wNMX3aP5XR3S7iBMp1cCSWTrwm/mBA7zbug2fhOXtME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uz9KYxy1OzzWgv5CzwT80Y0rZ8EIgrNifZjt+JBMj31w5RQVGG4JitEWfpjjai4uX
         gVikuJQ9563VCX8foCUiLPPd0u7fFYJx/Edii69eOXE1oFYPRmppVAVVnTYautshTj
         jiRPiwK72sSQ/U0cUdJDa+8Q5TiSXD3yVeteaFCQXOy9F6w7y5WP3P0OKWHXpYVUfA
         NIgrk4t6o5LDWiV6iKKlDjdj+1dqxWKiOqJMcX8S10c0bDZlyQjAtHRavAxgAgPdXt
         eGRzoJx+VY5pf8ype2xY+Mf+RexyT/1OBpBoO6xaM8zOAX/VkXerLOJ304Un0Ktqy4
         VvvOpxWUFkS3w==
Date:   Tue, 27 Jun 2023 20:09:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH 3/3] RISC-V: Implement archrandom when Zkr is available
Message-ID: <20230627-grinning-droop-bfbb327f6164@spud>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-4-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0uAcHobi8KSxnYu+"
Content-Disposition: inline
In-Reply-To: <20230627143747.1599218-4-sameo@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0uAcHobi8KSxnYu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Samuel,

On Tue, Jun 27, 2023 at 04:37:44PM +0200, Samuel Ortiz wrote:
> The Zkr extension is ratified and provides 16 bits of entropy seed when
> reading the SEED CSR.
>=20
> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> that CSR and filling an unsigned long with valid entropy bits.
>=20
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  arch/riscv/include/asm/archrandom.h | 66 +++++++++++++++++++++++++++++
>  arch/riscv/include/asm/csr.h        |  9 ++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/include/asm/archrandom.h
>=20
> diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm=
/archrandom.h
> new file mode 100644
> index 000000000000..3d01aab2800a
> --- /dev/null
> +++ b/arch/riscv/include/asm/archrandom.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Kernel interface for the RISCV arch_random_* functions
> + *
> + * Copyright (c) 2022 by Rivos Inc.
> + *
> + */
> +
> +#ifndef ASM_RISCV_ARCHRANDOM_H
> +#define ASM_RISCV_ARCHRANDOM_H
> +
> +#include <asm/csr.h>
> +
> +#define PR_PREFIX "Zkr Extension: "

Does pr_fmt() not work for you?
Also, "Zkr Extension" doesn't really seem super helpful to a punter if
they saw it in a log. Why not s/Zkr Extension/archrandom/, or similar?

> +#define SEED_RETRY_LOOPS 10
> +
> +static inline bool __must_check csr_seed_long(unsigned long *v)
> +{
> +	unsigned int retry =3D SEED_RETRY_LOOPS;
> +	unsigned int needed_seeds =3D sizeof(unsigned long) / 2, valid_seeds =
=3D 0;
> +	u16 *entropy =3D (u16 *)v;
> +
> +	do {
> +		/*
> +		 * The SEED CSR (0x015) must be accessed with a read-write
> +		 * instruction. Moreover, implementations must ignore the write
> +		 * value, its purpose is to signal polling for new seed.
> +		 */

What relevance does the second half of this comment have to the kernel?

> +		unsigned long csr_seed =3D csr_swap(CSR_SEED, 0);
> +
> +		switch (csr_seed & SEED_OPST_MASK) {
> +		case SEED_OPST_ES16:
> +			entropy[valid_seeds++] =3D csr_seed & SEED_ENTROPY_MASK;
> +			if (valid_seeds =3D=3D needed_seeds)
> +				return true;
> +			break;
> +
> +		case SEED_OPST_DEAD:
> +			pr_err_once(PR_PREFIX "Unrecoverable error\n");
> +			return false;
> +
> +		case SEED_OPST_BIST:
> +			pr_info(PR_PREFIX "On going Built-in Self Test\n");

tiny nit, "On-going"? My OCD is bother by the capitalisation otherwise.

> +			fallthrough;
> +
> +		case SEED_OPST_WAIT:
> +		default:
> +			continue;
> +		}
> +
> +	} while (--retry);
> +
> +	return false;
> +}
> +
> +static inline size_t __must_check arch_get_random_longs(unsigned long *v=
, size_t max_longs)
> +{
> +	return 0;
> +}
> +
> +static inline size_t __must_check arch_get_random_seed_longs(unsigned lo=
ng *v, size_t max_longs)
> +{
> +	return max_longs && riscv_isa_extension_available(NULL, ZKR) && csr_see=
d_long(v) ? 1 : 0;

Could you please write this in a more readable way, even if that is
going to be a lot more verbose? I know you copied it from x86, but
that's not really an excuse ;)

Also, is there a reason that you opted not to use the alternative-backed
riscv_has_extension_[un]likely() here? The ones backed by alternatives
are preferred if you are not checking on a per-cpu, or once-off basis.

Cheers,
Conor.

> +}
> +
> +#endif /* ASM_RISCV_ARCHRANDOM_H */
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index b98b3b6c9da2..7d0ca9082c66 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -389,6 +389,15 @@
>  #define CSR_VTYPE		0xc21
>  #define CSR_VLENB		0xc22
> =20
> +/* Scalar Crypto Extension - Entropy */
> +#define CSR_SEED		0x015
> +#define SEED_OPST_MASK		_AC(0xC0000000, UL)
> +#define SEED_OPST_BIST		_AC(0x00000000, UL)
> +#define SEED_OPST_WAIT		_AC(0x40000000, UL)
> +#define SEED_OPST_ES16		_AC(0x80000000, UL)
> +#define SEED_OPST_DEAD		_AC(0xC0000000, UL)
> +#define SEED_ENTROPY_MASK	_AC(0xFFFF, UL)
> +
>  #ifdef CONFIG_RISCV_M_MODE
>  # define CSR_STATUS	CSR_MSTATUS
>  # define CSR_IE		CSR_MIE
> --=20
> 2.41.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--0uAcHobi8KSxnYu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJsz1AAKCRB4tDGHoIJi
0sxhAQDmKCMwEhoSJKUvyKnvQfNciXr+UHg5OCQ+1yvbjABEoQD9GDHrlTxqptdc
PFMLpDuthQReCZpm9B3yw/ECerIzfQA=
=LE75
-----END PGP SIGNATURE-----

--0uAcHobi8KSxnYu+--
