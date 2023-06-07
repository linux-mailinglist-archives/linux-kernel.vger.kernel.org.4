Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1FE726849
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFGSSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFGSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E870268C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6FC615E8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BFDC433D2;
        Wed,  7 Jun 2023 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686161852;
        bh=Ag8b6jclnIS3ni+j5UQhwSXc0W17dRqILjpn9E7ZUQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiouR0Ej+H6nlg65fXSk7tiRWif1fAW7Ennjo+mAK1TmLYnAab6SBxOgeJsmqVJq9
         GJTVt+c+vq9rwo3fHcxIQqWUDvY6Q/w8mZZ5DxlFEhaS70Af5vhFhNtXlOeYxyDmyN
         +UDyF+s2LcemwyStZaTNGlqRod6/i+LSWJSeqcun/w7kds9e3j26Rz7hV8Ky5jDN87
         MlIThW7UjApWMoP7K137joHNb0A9ToQ6Yb1ZoKaOCzkEeAGyngppBcVKM0ugb4amDM
         wh6z0JjCXnuTQBcSwMbCPwNXk5vN3pYrAmLvfbiGjuFZ9USlahQv+5cQXMpKu5gQr5
         7LU+4L4VaAPdQ==
Date:   Wed, 7 Jun 2023 19:17:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
Message-ID: <20230607-jogging-grudging-70dede86bc53@spud>
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J+jihW930ktvqPjh"
Content-Disposition: inline
In-Reply-To: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J+jihW930ktvqPjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Alex, you should take a look at this patch.

On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
> It's possible that early_init_fdt_scan_reserved_mem() allocates memory
> from memblock for dynamic reserved memory in `/reserved-memory` node.
> Any fixed reservation must be done before that to avoid potential
> conflicts.
>=20
> Reserve the DTB in memblock just after early scanning it.

The rationale makes sense to me, I am just wondering what compelling
reason there is to move it away from the memblock_reserve()s for the
initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
should be the sufficient minimum & would keep things together.

Cheers,
Conor.

>=20
> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> ---
>  arch/riscv/kernel/setup.c | 10 ++++++++++
>  arch/riscv/mm/init.c      |  9 ---------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 36b026057503..c147fa8da929 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -16,6 +16,7 @@
>  #include <linux/console.h>
>  #include <linux/screen_info.h>
>  #include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
>  #include <linux/sched/task.h>
>  #include <linux/smp.h>
>  #include <linux/efi.h>
> @@ -256,6 +257,15 @@ static void __init parse_dtb(void)
>  		pr_err("No DTB passed to the kernel\n");
>  	}
> =20
> +	/*
> +	 * If DTB is built in, no need to reserve its memblock.
> +	 * Otherwise, do reserve it but avoid using
> +	 * early_init_fdt_reserve_self() since __pa() does
> +	 * not work for DTB pointers that are fixmap addresses
> +	 */
> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> +		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +
>  #ifdef CONFIG_CMDLINE_FORCE
>  	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>  	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c6bb966e4123..f8c9a79acd94 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -254,15 +254,6 @@ static void __init setup_bootmem(void)
>  	 */
>  	early_init_fdt_scan_reserved_mem();
> =20
> -	/*
> -	 * If DTB is built in, no need to reserve its memblock.
> -	 * Otherwise, do reserve it but avoid using
> -	 * early_init_fdt_reserve_self() since __pa() does
> -	 * not work for DTB pointers that are fixmap addresses
> -	 */
> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> -		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> -
>  	dma_contiguous_reserve(dma32_phys_limit);
>  	if (IS_ENABLED(CONFIG_64BIT))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> --=20
> 2.39.2
>=20

--J+jihW930ktvqPjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDJtwAKCRB4tDGHoIJi
0pCXAP99xsCphB3DBvIziKavjWB1iLOkD+X3H97tW1E7cMtkzAEArXHyHtW6kTX/
gRag6vi2QGqXh4hG1YvtqvIpp1G2MQE=
=yaX+
-----END PGP SIGNATURE-----

--J+jihW930ktvqPjh--
