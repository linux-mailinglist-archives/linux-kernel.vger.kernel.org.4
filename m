Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A976538A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiLUWaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiLUW3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:29:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277427B0D;
        Wed, 21 Dec 2022 14:28:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1788BB81C3B;
        Wed, 21 Dec 2022 22:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FAEC433D2;
        Wed, 21 Dec 2022 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671661639;
        bh=DeE701axTftUD20gtPeSs1lKxbAiPCgvCwAGUnPUotc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oED22h9AA7zhPbiAm+t/bfkORPfkBBplYle9i80ogu2iI0R0hSCNlbuuUrJQXglJq
         VbhwcTVRv0/TUUVp+a9nD7aM1WR0EDmhcJJ4edq/R6SFJf3U/vEQRdvi91VDfygIQy
         1lUJex0/ja206oOC1Pljtm2j+7wOSwuO5HyJ8swczrpICErAPymSVuFIX0/BQngPzO
         DPvnJTgLTl74oraEzLJr7bomNkZfoiFXZBSTYXcrVPDzEj7oeSjAsvv8o/CiOOrjUH
         ZvKS19BjRlb1BNlsP0qaxcVhcT4z28rF6ndGQxQ5iWyZ4Ap4wYr+0LUR3zGkm4H8Qi
         kZ56BRxVt4TOw==
Date:   Wed, 21 Dec 2022 22:27:15 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <Y6OIQ1OzjWRkYxHH@spud>
References: <20221215081948.1256610-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2CgsAwd7ZL+qgvLr"
Content-Disposition: inline
In-Reply-To: <20221215081948.1256610-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2CgsAwd7ZL+qgvLr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Thu, Dec 15, 2022 at 09:19:48AM +0100, Alexandre Ghiti wrote:
> Add 2 early command line parameters called "no5lvl" and "no4lvl" (using
> the same naming as x86) to allow a user to downgrade from sv57 (the
> default mode if the hardware supports it) to sv48 or sv39.

Pardon my innocence here, but does the "no4lvl" option not also allow
downgrading from sv48 to sv39? If that's the case, I assume the message
could be amended on application.

> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>=20
> Also, as those params are treated very early in the boot process and we
> use standard device tree functions that may be kasan instrumented, we
> only enable them for !KASAN configurations.

I don't have a suggestion for you, so I am just airing my thoughts
really - are we likely to end up confusing people as it's not
immediately obvious that these options do not work if KASAN is enabled?
I know KASAN really isn't something you want in a production kernel,
but should we be flagging the incompatibility somewhere that "users"
would see?
kernel-parameters.txt does usually seem to mention config options where
relevant, and in the case of iommu.strict also mentions some arch
specific behaviour. Should we mention it there then?

Thanks,
Conor.

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>=20
> v2:
> - Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Bj=F6rn
>=20
>  .../admin-guide/kernel-parameters.txt         |  5 +-
>  arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
>  2 files changed, 70 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index a465d5242774..6741524aa980 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3548,7 +3548,10 @@
>  			emulation library even if a 387 maths coprocessor
>  			is present.
> =20
> -	no5lvl		[X86-64] Disable 5-level paging mode. Forces
> +	no4lvl		[RISCV] Disable 4-level paging mode. Forces
> +			kernel to use 3-level paging instead.
> +
> +	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
>  			kernel to use 4-level paging instead.
> =20
>  	nofsgsbase	[X86] Disables FSGSBASE instructions.
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b56a0a75533f..d90fbe9ad494 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -746,17 +746,77 @@ static void __init disable_pgtable_l4(void)
>  	satp_mode =3D SATP_MODE_39;
>  }
> =20
> +#ifndef CONFIG_KASAN
> +static __init bool match_noXlvl(const char *cmdline)
> +{
> +	if (strstr(cmdline, "no5lvl")) {
> +		disable_pgtable_l5();
> +	} else if (strstr(cmdline, "no4lvl")) {
> +		disable_pgtable_l5();
> +		disable_pgtable_l4();
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int __init print_no4lvl(char *p)
> +{
> +	pr_info("Disabled 4-level and 5-level paging");
> +	return 0;
> +}
> +early_param("no4lvl", print_no4lvl);
> +
> +static int __init print_no5lvl(char *p)
> +{
> +	pr_info("Disabled 5-level paging");
> +	return 0;
> +}
> +early_param("no5lvl", print_no5lvl);
> +#endif
> +
>  /*
>   * There is a simple way to determine if 4-level is supported by the
>   * underlying hardware: establish 1:1 mapping in 4-level page table mode
>   * then read SATP to see if the configuration was taken into account
>   * meaning sv48 is supported.
>   */
> -static __init void set_satp_mode(void)
> +static __init void set_satp_mode(uintptr_t dtb_pa)
>  {
>  	u64 identity_satp, hw_satp;
>  	uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & PMD_MA=
SK;
> -	bool check_l4 =3D false;
> +
> +#ifndef CONFIG_KASAN
> +	/*
> +	 * The below fdt functions are kasan instrumented, since at this point
> +	 * there is no mapping for the kasan shadow memory, this can't be used
> +	 * when kasan is enabled.
> +	 */
> +	int chosen_node;
> +	unsigned int fdt_cmdline_size =3D 0;
> +
> +	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> +		chosen_node =3D fdt_path_offset((void *)dtb_pa, "/chosen");
> +		if (chosen_node >=3D 0) {
> +			const char *fdt_cmdline;
> +
> +			fdt_cmdline =3D fdt_getprop((void *)dtb_pa, chosen_node,
> +						  "bootargs", NULL);
> +			if (fdt_cmdline) {
> +				if (match_noXlvl(fdt_cmdline))
> +					return;
> +				fdt_cmdline_size =3D strlen(fdt_cmdline);
> +			}
> +		}
> +	}
> +
> +	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> +	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> +	    fdt_cmdline_size =3D=3D 0 /* CONFIG_CMDLINE_FALLBACK */) {
> +		if (match_noXlvl(CONFIG_CMDLINE))
> +			return;
> +	}
> +#endif
> =20
>  	create_p4d_mapping(early_p4d,
>  			set_satp_mode_pmd, (uintptr_t)early_pud,
> @@ -775,7 +835,8 @@ static __init void set_satp_mode(void)
>  retry:
>  	create_pgd_mapping(early_pg_dir,
>  			   set_satp_mode_pmd,
> -			   check_l4 ? (uintptr_t)early_pud : (uintptr_t)early_p4d,
> +			   pgtable_l5_enabled ?
> +				(uintptr_t)early_p4d : (uintptr_t)early_pud,
>  			   PGDIR_SIZE, PAGE_TABLE);
> =20
>  	identity_satp =3D PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
> @@ -786,9 +847,8 @@ static __init void set_satp_mode(void)
>  	local_flush_tlb_all();
> =20
>  	if (hw_satp !=3D identity_satp) {
> -		if (!check_l4) {
> +		if (pgtable_l5_enabled) {
>  			disable_pgtable_l5();
> -			check_l4 =3D true;
>  			memset(early_pg_dir, 0, PAGE_SIZE);
>  			goto retry;
>  		}
> @@ -979,7 +1039,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #endif
> =20
>  #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
> -	set_satp_mode();
> +	set_satp_mode(dtb_pa);
>  #endif
> =20
>  	kernel_map.va_pa_offset =3D PAGE_OFFSET - kernel_map.phys_addr;
> --=20
> 2.37.2
>=20
>=20

--2CgsAwd7ZL+qgvLr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6OIQwAKCRB4tDGHoIJi
0l9pAQD5X/kxAPfoDuAklRSqKRdq2/SSSr4DNDtuvpbT6yKVZQD/eHjqmn5HHG1P
B58VNpyWRtwZkIRPH/BfDEJGzdpAigs=
=usPd
-----END PGP SIGNATURE-----

--2CgsAwd7ZL+qgvLr--
