Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598A369127D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBIVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBIVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:13:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023BC5A938;
        Thu,  9 Feb 2023 13:13:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFB261BC4;
        Thu,  9 Feb 2023 21:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64891C433EF;
        Thu,  9 Feb 2023 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675977223;
        bh=DUiPVlHbL2i0BESbk6WD0HB3BwdUtI3zLk+jk/oecSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R99QZlvYfFH5BdG12Odtu+dq7zA3DAXy676GePCzsshtibVimjpNyI1fuj+FQ3TC6
         6e+t/pCXTKUGH0PE2MSqDGMIDyVyrSS/dlrK94DB4cN5MksGMut5jB5ixj7N3GoO6N
         ktTvYmbl5NJ/bALFTKG/HDt9/V7iev1gqSu3ZxlspESouHg0ZHOv654JjRVCBQKmc3
         W96DSJWFVEp22NFG+fpqbV4IdxLnytmsWzs8zEuS1QrAC8VlEh5hEVZjUJjfMBbUxv
         n+0q2N5vuNyOduNVOtMnEX5Z/qNx28UviuCsEU5KFn9f12IncZxnrHKx7MKca85Y1M
         /4DTTCuCA09Fg==
Date:   Thu, 9 Feb 2023 21:13:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 20/24] RISC-V: ACPI: cpu: Enable cpuinfo for ACPI systems
Message-ID: <Y+ViASnch0Fp1rju@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-21-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lYAs3kYMw0C9GEQE"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-21-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lYAs3kYMw0C9GEQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:21PM +0530, Sunil V L wrote:
> On ACPI based platforms, few details like ISA need to be read
> from the ACPI table. Enable cpuinfo on ACPI based systems.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/kernel/cpu.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1b9a5a66e55a..bd6c0fcfe4ce 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2012 Regents of the University of California
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
> @@ -256,26 +257,47 @@ static void c_stop(struct seq_file *m, void *v)
>  {
>  }
> =20
> +#ifdef CONFIG_ACPI
> +void acpi_print_hart_info(struct seq_file *m,
> +			  unsigned long cpu)

Surely this fits on one line?

> +{
> +	const char *isa;
> +
> +	if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu), &isa))
> +		print_isa(m, isa);

Do you really need to guard this function? Aren't there nop'ed versions
of acpi_get_riscv_isa() and get_acpi_id_for_cpu() in acpi.h?

IMO, basically any use of ifdeffery you can cleanly remove from a c file
is a worthwhile change.

> +

Extra blank line here FYI.

> +}
> +#endif
> +
>  static int c_show(struct seq_file *m, void *v)
>  {
>  	unsigned long cpu_id =3D (unsigned long)v - 1;
> -	struct device_node *node =3D of_get_cpu_node(cpu_id, NULL);
>  	struct riscv_cpuinfo *ci =3D per_cpu_ptr(&riscv_cpuinfo, cpu_id);
> +	struct device_node *node;
>  	const char *compat, *isa;
> =20
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	if (!of_property_read_string(node, "riscv,isa", &isa))
> -		print_isa(m, isa);
> +
> +	if (acpi_disabled) {
> +		node =3D of_get_cpu_node(cpu_id, NULL);
> +		if (!of_property_read_string(node, "riscv,isa", &isa))
> +			print_isa(m, isa);
> +		if (!of_property_read_string(node, "compatible", &compat)
> +		    && strcmp(compat, "riscv"))
                    ^^ this should be on the line above
TBH the whole series is in need of a checkpatch --strict run IMO,
there's a bunch of coding style issues throughout.

> +			seq_printf(m, "uarch\t\t: %s\n", compat);
> +		of_node_put(node);
> +	}
> +#ifdef CONFIG_ACPI
> +	else
> +		acpi_print_hart_info(m, cpu_id);

Delete the ifdeffery here too please :)

Cheers,
Conor.

> +#endif
> +
>  	print_mmu(m);
> -	if (!of_property_read_string(node, "compatible", &compat)
> -	    && strcmp(compat, "riscv"))
> -		seq_printf(m, "uarch\t\t: %s\n", compat);
>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
>  	seq_puts(m, "\n");
> -	of_node_put(node);
> =20
>  	return 0;
>  }
> --=20
> 2.38.0
>

--lYAs3kYMw0C9GEQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+ViAQAKCRB4tDGHoIJi
0vwtAPwKUcxsKZbj5EQcYSNTBdh9vOSoaePgBA+etKu/vUSzQAEAgoV/ifyiHBpa
FmQgavvEOHSnPG7rQ97kcJAAxkAmHwg=
=c/EG
-----END PGP SIGNATURE-----

--lYAs3kYMw0C9GEQE--
