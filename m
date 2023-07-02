Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C8744D9F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGBMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41B12A;
        Sun,  2 Jul 2023 05:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB6C60B45;
        Sun,  2 Jul 2023 12:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8435AC433C8;
        Sun,  2 Jul 2023 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688301702;
        bh=MzFfhuAG+VymhJO6OuEtkAVuc0UL6+wBGYNRcyIrtUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQ+inEyIjXKsQfARv+xnZNIhFtV6huj6XOuKM/mthYK5yObf6PFBN0mKybkK542lt
         o7GNGzHthSPzMlyQQCsRycgN1K+V3iuE5dp0vqhnbHxmPv7vkFrEH2EV6yJkNd3vjl
         FPyuXypccjWcqgzFJ2rIdQJABX+jJcZ5ImLpfW5nxdgwPdwwH/w09rb0KBSxwxX82g
         wK4WTtSkTsuKF4Xln6RPfu6njojjhxeLc9amLiUSO9kSUCcBv7eEt7CT/khLiVsMxL
         WEzKpndRYmZ71n6kdRRjXE561VcCnCklHV6gJfT2nLc+DlVm3n18/vGdEAm4rnFAjq
         eyl7Bxh2hcEmg==
Date:   Sun, 2 Jul 2023 13:41:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [PATCH v2 2/3] firmware: introduce FFI for SMBIOS entry.
Message-ID: <20230702-collide-rumor-f0d915a4f1b2@spud>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702095735.860-2-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3b97CWPMBjIqlO+K"
Content-Disposition: inline
In-Reply-To: <20230702095735.860-2-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3b97CWPMBjIqlO+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sun, Jul 02, 2023 at 05:57:33PM +0800, Yunhui Cui wrote:
> 1. Some bootloaders do not support EFI, and the transfer of
> firmware information can only be done through DTS,
> such as Coreboot.
>=20
> 2. Some arches do not have a reserved address segment that
> can be used to pass firmware parameters like x86.
>=20
> 3. Based on this, we have added an interface to obtain firmware
> information through FDT, named FFI.
>=20
> 4. We not only use FFI to pass SMBIOS entry,
> but also pass other firmware information as an extension.

nit: please don't write your commit messages as bullet lists

> +FDT FIRMWARE INTERFACE (FFI)
> +M:	Yunhui Cui cuiyunhui@bytedance.com
> +S:	Maintained
> +F:	drivers/firmware/ffi.c
> +F:	include/linux/ffi.h

Are you going to apply patches for this, or is someone else?

>  EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)
>  M:	MyungJoo Ham <myungjoo.ham@samsung.com>
>  M:	Chanwoo Choi <cw00.choi@samsung.com>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..ea0149fb4683 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -303,6 +303,17 @@ config TURRIS_MOX_RWTM
>  	  other manufacturing data and also utilize the Entropy Bit Generator
>  	  for hardware random number generation.
> =20
> +config FDT_FW_INTERFACE
> +       bool "An interface for passing firmware info through FDT"
> +       depends on OF && OF_FLATTREE
> +       default n
> +       help
> +         When some bootloaders do not support EFI, and the arch does not
> +         support SMBIOS_ENTRY_POINT_SCAN_START, then you can enable this=
 option
> +         to support the transfer of firmware information, such as smbios=
 tables.

Could you express this dependency on !SMBIOS_ENTRY_POINT_SCAN_START in
Kconfig & then simply the text to:
"Enable this option to support the transfer of firmware information,
such as smbios tables, for bootloaders that do not support EFI."
since it would not even appear if the arch supports scanning for the
entry point?
If I was was a punter trying to configure my kernel in menuconfig or
whatever, I should be able to decide based on the help text if I need
this, not going grepping for #defines in headers.

>  static void __init dmi_scan_machine(void)
> @@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
>  	char __iomem *p, *q;
>  	char buf[32];
> =20
> +#ifdef CONFIG_FDT_FW_INTERFACE
> +	if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))

"dmi_sacn_smbios"

> +		goto error;
> +#endif

Does this not mean that if FDT_FW_INTERFACE is enabled, but the platform
wants to use EFI, it won't be able to? The `goto error;` makes this look
mutually exclusive to my efi-unaware eyes.

>  	if (efi_enabled(EFI_CONFIG_TABLES)) {
> -		/*
> -		 * According to the DMTF SMBIOS reference spec v3.0.0, it is
> -		 * allowed to define both the 64-bit entry point (smbios3) and
> -		 * the 32-bit entry point (smbios), in which case they should
> -		 * either both point to the same SMBIOS structure table, or the
> -		 * table pointed to by the 64-bit entry point should contain a
> -		 * superset of the table contents pointed to by the 32-bit entry
> -		 * point (section 5.2)
> -		 * This implies that the 64-bit entry point should have
> -		 * precedence if it is defined and supported by the OS. If we
> -		 * have the 64-bit entry point, but fail to decode it, fall
> -		 * back to the legacy one (if available)
> -		 */
> -		if (efi.smbios3 !=3D EFI_INVALID_TABLE_ADDR) {
> -			p =3D dmi_early_remap(efi.smbios3, 32);
> -			if (p =3D=3D NULL)
> -				goto error;
> -			memcpy_fromio(buf, p, 32);
> -			dmi_early_unmap(p, 32);
> -
> -			if (!dmi_smbios3_present(buf)) {
> -				dmi_available =3D 1;
> -				return;
> -			}
> -		}
> -		if (efi.smbios =3D=3D EFI_INVALID_TABLE_ADDR)
> +		if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
>  			goto error;
> -
> -		/* This is called as a core_initcall() because it isn't
> -		 * needed during early boot.  This also means we can
> -		 * iounmap the space when we're done with it.
> -		 */
> -		p =3D dmi_early_remap(efi.smbios, 32);
> -		if (p =3D=3D NULL)
> -			goto error;
> -		memcpy_fromio(buf, p, 32);
> -		dmi_early_unmap(p, 32);
> -
> -		if (!dmi_present(buf)) {
> -			dmi_available =3D 1;
> -			return;
> -		}
> diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
> new file mode 100644
> index 000000000000..169802b4a7a8
> --- /dev/null
> +++ b/drivers/firmware/ffi.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
> +#include <linux/ffi.h>
> +
> +#define FFI_INVALID_TABLE_ADDR	(~0UL)
> +
> +struct ffi __read_mostly ffi =3D {
> +	.smbios	=3D FFI_INVALID_TABLE_ADDR,
> +	.smbios3 =3D FFI_INVALID_TABLE_ADDR,
> +};

> +EXPORT_SYMBOL(ffi);

> +// SPDX-License-Identifier: GPL-2.0-only

Why not EXPORT_SYMBOL_GPL? But also, who is the user of this export?

> +
> +void __init ffi_smbios_root_pointer(void)
> +{
> +	int cfgtbl, len;
> +	fdt64_t *prop;
> +
> +	cfgtbl =3D fdt_path_offset(initial_boot_params, "/cfgtables");

These DT properties need to be documented in a binding.

> +	if (cfgtbl < 0) {
> +		pr_info("firmware table not found.\n");

Isn't it perfectly valid for a DT not to contain this table? This print
should be, at the very least, a pr_debug().

> +		return;
> +	}
> +	prop =3D fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy_ptr", &=
len);

Again, undocumented DT property. Please document them in a binding.

> +	if (!prop || len !=3D sizeof(u64))
> +		pr_info("smbios entry point not found.\n");
> +	else
> +		ffi.smbios =3D fdt64_to_cpu(*prop);
> +
> +	pr_info("smbios root pointer: %lx\n", ffi.smbios);

ffi.smbios is not set if (!prop || len !=3D sizeof(u64)), looks like your
"if" should return and the contents of the else become unconditional?
Otherwise, this print seems wrong.

> +}
> +
> diff --git a/include/linux/ffi.h b/include/linux/ffi.h
> new file mode 100644
> index 000000000000..95298a805222
> --- /dev/null
> +++ b/include/linux/ffi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_FFI_H
> +#define _LINUX_FFI_H
> +
> +extern struct ffi {
> +	unsigned long smbios;  /* SMBIOS table (32 bit entry point) */
> +	unsigned long smbios3;  /* SMBIOS table (64 bit entry point) */
> +	unsigned long flags;
> +
> +} ffi;
> +
> +void ffi_smbios_root_pointer(void);

Please provide a stub for !FDT_FW_INTERFACE so that we don't need
ifdeffery at callsites.

Cheers,
Conor.

--3b97CWPMBjIqlO+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKFwfAAKCRB4tDGHoIJi
0gUUAP9qKjbw3OZeSzh3tzcTkqzGw6y5vGWZi/uJAGBWK49o/QD8Dv62DEZ39txs
Awm1rhzZxUbEDSpYIQO81oRVur1dUQQ=
=MAej
-----END PGP SIGNATURE-----

--3b97CWPMBjIqlO+K--
