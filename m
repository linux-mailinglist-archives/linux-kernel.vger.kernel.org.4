Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829174A331
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGFRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGFRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE9119;
        Thu,  6 Jul 2023 10:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E70A560B9E;
        Thu,  6 Jul 2023 17:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B1DC433C7;
        Thu,  6 Jul 2023 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688665101;
        bh=Q9uAKJpEAuOc+uNAeFdgPlPrKXJ8f+DWHbbFUYtYJ4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s66akyFbUfrjq/wGF+sJ/4HLjHe3p6ERLHafSiVYe4DeBGpE18QJZQEWJrDbIHI0d
         9zdh1KBVSIktTaBGoUhXMDc5OZZ9+wlWpoYAmB6BiTwCw04IfIsYZp0uXduEvHQrcx
         6gQrnh+TDf9FSNVwBf53cowmUg5Qw950UGRHQ9Jxiz5py1EJUTY7Hrkgr5KkTZDNRg
         tN7zih2PP8sufd549gak71JkK0/zPoc9WqzgA6xOdHbTZhnFezGRlMNtsn4xQoJcdd
         Nav89VibgJc1Ysh+kNNbk9jxdlMJwVcBe4GswSiivhfkXCF0fM7pw35wETXxmEoOo+
         1goRgua907fIg==
Date:   Thu, 6 Jul 2023 18:38:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, evan@rivosinc.com,
        heiko@sntech.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
Message-ID: <20230706-unwed-aeration-d8c7b71eac5e@spud>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/1/P1zz9w9UpMZlo"
Content-Disposition: inline
In-Reply-To: <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/1/P1zz9w9UpMZlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 05, 2023 at 08:30:18PM -0700, Charlie Jenkins wrote:
> Using vendor extensions in hwprobe, add the ability to query if the
> 0.7.1 vector extension is available. It is determined to be available
> only if the kernel is compiled with vector support,

> and the user is
> using the c906.

Heh, unfortunately your patch doesn't apply this limitation.

I'm not really sure where this series is intended to sit in relation to
Heiko's series that adds support for the actual T-Head vector stuff:
https://lore.kernel.org/linux-riscv/20230622231305.631331-1-heiko@sntech.de/

Is this intended to complement that? If so, these patches don't really
seem to integrate with it (and have some of the same flaws unfortunately
as that series does).

Firstly, to my knowledge, all T-Head cpu cores report 0 for impid &
archid. Stefan pointed out:
	C906 supports t-head/0.7.1 vectors as a configuration option.  The C906 in
	the D1 and BL808 has vectors, the recently announced CV1800B has one C906
	with vectors and one without, and I vaguely remember seeing a chip with on=
ly
	a non-vector C906.
=09
	C908 (announced, no manual yet) claims V 1.0 support.  Presumably it will
	not support 0.7.1.
=09
	C910 (exists on evaluation boards) lacks vector support.
=09
	C920 (TH1520, SG2042, etc) has 0.7.1 support, at least superficially
	compatible with C906-with-vectors.  Hopefully we can share errata.
=09
	This probably needs to be handled as an orthogonal "xtheadv" or "v0p7p1"
	extension in whatever replaces riscv,isa.

This makes an approach that does anything w/ their vector implementation
not discernible based on the m*id CSRs. IMO, the only way to make this
stuff work properly is to detect based on a DT or ACPI property whether
this stuff is supported on a given core.

Since the approach just cannot work, I don't have any detailed comments
to make, just a few small ones below.

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig.vendor                       | 11 +++++++++++
>  arch/riscv/include/asm/extensions.h             | 16 ++++++++++++++++
>  arch/riscv/kernel/sys_riscv.c                   | 20 ++++++++++++++++++++
>  arch/riscv/vendor_extensions/Makefile           |  2 ++
>  arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++++++
>  arch/riscv/vendor_extensions/thead/extensions.c | 24 +++++++++++++++++++=
+++++
>  6 files changed, 81 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> index 213ac3e6fed5..b8b9d15153eb 100644
> --- a/arch/riscv/Kconfig.vendor
> +++ b/arch/riscv/Kconfig.vendor
> @@ -1,3 +1,14 @@
>  menu "Vendor extensions selection"
> =20
> +config VENDOR_EXTENSIONS_THEAD
> +	bool "T-HEAD vendor extensions"

> +	depends on RISCV_ALTERNATIVE

Why do you need this?

> +	default n
> +	help
> +	  All T-HEAD vendor extensions Kconfig depend on this Kconfig. Disabling
> +	  this Kconfig will disable all T-HEAD vendor extensions. Please say "Y"
> +	  here if your platform uses T-HEAD vendor extensions.

I don't really like this Kconfig entry. We should just use the one in
Kconfig.errata that enables the actual vector stuff.

> +
> +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> +
>  endmenu # "Vendor extensions selection"
> diff --git a/arch/riscv/include/asm/extensions.h b/arch/riscv/include/asm=
/extensions.h
> new file mode 100644
> index 000000000000..27ce294a3d65
> --- /dev/null
> +++ b/arch/riscv/include/asm/extensions.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 by Rivos Inc.
> + */
> +#ifndef __ASM_EXTENSIONS_H
> +#define __ASM_EXTENSIONS_H
> +
> +#include <asm/hwprobe.h>
> +#include <linux/cpumask.h>
> +
> +#define THEAD_ISA_EXT0 (RISCV_HWPROBE_VENDOR_EXTENSION_SPACE)
> +#define THEAD_ISA_EXT0_V0_7_1 (1 << 0)
> +
> +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pai=
r,
> +		  const struct cpumask *cpus);
> +#endif
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 2351a5f7b8b1..58b12eaeaf46 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -13,6 +13,7 @@
>  #include <asm/vector.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> +#include <asm/extensions.h>
>  #include <asm/unistd.h>
>  #include <asm-generic/mman-common.h>
>  #include <vdso/vsyscall.h>
> @@ -192,6 +193,25 @@ static int hwprobe_vendor(__u64 mvendorid, struct ri=
scv_hwprobe *pair,
>  			 const struct cpumask *cpus)
>  {
>  	switch (mvendorid) {
> +#ifdef CONFIG_VENDOR_EXTENSIONS_THEAD

Please use IS_ENABLED() in code where possible, so that we get compile
time coverage of the code it disables. IMO, this kinda overcomplicates
the switch anyway, and it should be as simple as:
case THEAD_VENDOR_ID:
	return hwprobe_thead(pair, cpus);

and deal with the specific stuff (like impid etc) inside that function.

> +	case THEAD_VENDOR_ID:
> +		struct riscv_hwprobe marchid =3D {
> +			.key =3D RISCV_HWPROBE_KEY_MARCHID,
> +			.value =3D 0
> +		};
> +		struct riscv_hwprobe mimpid =3D {
> +			.key =3D RISCV_HWPROBE_KEY_MIMPID,
> +			.value =3D 0
> +		};
> +
> +		hwprobe_arch_id(&marchid, cpus);
> +		hwprobe_arch_id(&mimpid, cpus);
> +		if (marchid.value !=3D -1ULL && mimpid.value !=3D -1ULL)
> +			hwprobe_thead(marchid.value, mimpid.value, pair, cpus);
> +		else
> +			return -1;
> +		break;
> +#endif
>  	default:
>  		return -1;
>  	}
> diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendor_ex=
tensions/Makefile
> index e815895e9372..38c3e80469fd 100644
> --- a/arch/riscv/vendor_extensions/Makefile
> +++ b/arch/riscv/vendor_extensions/Makefile
> @@ -1,3 +1,5 @@
>  ifdef CONFIG_RELOCATABLE
>  KBUILD_CFLAGS +=3D -fno-pie
>  endif

Again, why do you need this, or...

> +
> +obj-$(CONFIG_VENDOR_EXTENSIONS_THEAD) +=3D thead/
> diff --git a/arch/riscv/vendor_extensions/thead/Makefile b/arch/riscv/ven=
dor_extensions/thead/Makefile
> new file mode 100644
> index 000000000000..7cf43c629b66
> --- /dev/null
> +++ b/arch/riscv/vendor_extensions/thead/Makefile
> @@ -0,0 +1,8 @@
> +ifdef CONFIG_FTRACE
> +CFLAGS_REMOVE_extensions.o =3D $(CC_FLAGS_FTRACE)
> +endif
> +ifdef CONFIG_KASAN
> +KASAN_SANITIZE_extensions.o :=3D n
> +endif

=2E..any of this? Not saying you don't, but I think it should be explained.

> +
> +obj-y +=3D extensions.o
> diff --git a/arch/riscv/vendor_extensions/thead/extensions.c b/arch/riscv=
/vendor_extensions/thead/extensions.c
> new file mode 100644
> index 000000000000..a177501bc99c
> --- /dev/null
> +++ b/arch/riscv/vendor_extensions/thead/extensions.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 by Rivos Inc.
> + */
> +
> +#include <asm/extensions.h>
> +
> +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pai=
r,
> +		  const struct cpumask *cpus)
> +{
> +	pair->value =3D 0;
> +	switch (pair->key) {
> +	case THEAD_ISA_EXT0:
> +#ifdef CONFIG_RISCV_ISA_V

As pointed out by Remi, this doesn't work either.
You should not claim this is supported, just because V is, you also need
the support for their vector "flavour" from Heiko's series.

Plus, it should be IS_ENABLED() too.

Cheers,
Conor.

> +		if (marchid =3D=3D 0 && mimpid =3D=3D 0)
> +			pair->value |=3D THEAD_ISA_EXT0_V0_7_1;
> +#endif
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	return 0;
> +}
>=20
> --=20
> 2.41.0
>=20

--/1/P1zz9w9UpMZlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKb8CAAKCRB4tDGHoIJi
0o1TAP4opDQGSf+1vplQTfo89CtVO17cBP755V6EMPFrQbWQdAEAjaYJPW5ns/M9
6DgOIqGECBG+ipMRikyB8E3HsdHL5g8=
=YAT+
-----END PGP SIGNATURE-----

--/1/P1zz9w9UpMZlo--
