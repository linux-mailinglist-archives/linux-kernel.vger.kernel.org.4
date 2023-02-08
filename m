Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048368F9E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjBHVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBHVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:49:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE406227AC;
        Wed,  8 Feb 2023 13:49:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53578617E9;
        Wed,  8 Feb 2023 21:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3D5C433EF;
        Wed,  8 Feb 2023 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675892985;
        bh=wj5vfzfVr8l+HoJfz2VIJSWnMOX1Qnb2cZ0rsoPxTvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpYB7qcXFmR4rPZWVxTpaWhOmSv3BLrMMPJUfYvmDKZpidFOXxORwDaDoDT+H8NR7
         0pXpttoNAtQs7XDbuAVgs5v0xvbJ3dfFbGgfaAANzreCJBjtrHTWy/nCs9pSTBKbD0
         V9RGcoxfxbzreN1e5nykhO4oDUTB8ljgDUotGPO8/9/01I2tS7m5IbPJJ3limXVhnw
         Z5A1iVpkbI1eBwqcgz6LwCQ1XPac/9/Vnu5X6bnce0pQY5g3/0S928EAZMTF4NxS2O
         q+tib17QgIoRI+fcQIP+ZffRyY2Ho4A+0goqPcP5hE2LkjBCswHOvAUmGULZ0DLczn
         6IYcgfFVt4pFg==
Date:   Wed, 8 Feb 2023 21:49:40 +0000
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
Subject: Re: [PATCH 11/24] RISC-V: ACPI: irqchip/riscv-intc: Add ACPI support
Message-ID: <Y+QY9DCf6JPBNVS7@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-12-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FkTChGvxflSskHE0"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-12-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkTChGvxflSskHE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Mon, Jan 30, 2023 at 11:52:12PM +0530, Sunil V L wrote:
> Add support for initializing the RISC-V INTC driver on ACPI based
> platforms.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

> +static int __init
> +riscv_intc_acpi_init(union acpi_subtable_headers *header,
> +		     const unsigned long end)
> +{
> +	int rc;
> +	struct fwnode_handle *fn;
> +	struct acpi_madt_rintc *rintc;
> +
> +	rintc =3D (struct acpi_madt_rintc *)header;
> +
> +	/*
> +	 * The ACPI MADT will have one INTC for each CPU (or HART)
> +	 * so riscv_intc_acpi_init() function will be called once
> +	 * for each INTC. We only need to do INTC initialization
> +	 * for the INTC belonging to the boot CPU (or boot HART).
> +	 */
> +	if (riscv_hartid_to_cpuid(rintc->hart_id) !=3D smp_processor_id())
> +		return 0;
> +
> +	fn =3D irq_domain_alloc_named_fwnode("RISCV-INTC");
> +	WARN_ON(fn =3D=3D NULL);

Is there a reason that you do not just check this as !fn?

> +	if (!fn) {

This is a repeated check from the WARN_ON(), no?

> +		pr_err("unable to allocate INTC FW node\n");

Why do you need a WARN_ON() & the pr_err() here?

> +		return -1;

Why not an actual ERRNO?

Cheers,
Conor.

> +	}
> +
> +	rc =3D riscv_intc_init_common(fn);
> +	if (rc) {
> +		pr_err("failed to initialize INTC\n");
> +		return rc;
> +	}
> =20
>  	return 0;
>  }
> =20
> -IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC,
> +		     NULL, 1, riscv_intc_acpi_init);
> +#endif
> --=20
> 2.38.0
>=20

--FkTChGvxflSskHE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+QY8wAKCRB4tDGHoIJi
0rhbAP0c5iexcaIlQM8iL+DvYIOwu7IRC087VNqdopdTjepYHQD9GVGT+vN2Psae
gsDMt8FH4tgfoYPmthIAfw3XtOVNQQM=
=lDAG
-----END PGP SIGNATURE-----

--FkTChGvxflSskHE0--
