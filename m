Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F6681D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjA3V55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA3V5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:57:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E57EE5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1BC61280
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F72C433EF;
        Mon, 30 Jan 2023 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675115872;
        bh=Z4TGZhf3eHrHCt3Sa0NR85ldZ1ppOQhU87Ok3n+koAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuMZXw+S6txi8srNik0+3PdRXUrC2OQ9fZZiAFTmMCMquLKVKK5FnGLHhZIuNnRTO
         44rjiwzZ7NQz/+Bb/ttMYStgD2JT1ojysyp4DBsY4DMxFQSyL9WWV7PRJ0wlSJcvRS
         EdjKhoW9KOj8E1sfRC99XMlJ3V4zaEV1+v2/l1LXd64xNLEHG/LGBeSxGjpMCs+Lp0
         +vfR2aBaCGbEeYCjjE7yTjat/YwwViKvzt/jqjHmFsJsmlwpZsbnzIpjwtJb/HFcB1
         yR8bKCTv+B2XDLlt32F3yd9uN5cvloPEJ8Yg0T77vM/wB16IUc53uTzXjvAMVQzRaV
         5+ozkN3z/l4fQ==
Date:   Mon, 30 Jan 2023 21:57:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v3 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Message-ID: <Y9g9XGzF/X3OwXdP@spud>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ItMQVOOAgwFH9Aw"
Content-Disposition: inline
In-Reply-To: <20230127091051.1465278-4-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ItMQVOOAgwFH9Aw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Alex

On Fri, Jan 27, 2023 at 05:10:50PM +0800, Sia Jee Heng wrote:
> Currently kernel_page_present() function doesn't support huge page
> detection causes the function to mistakenly return false to the
> hibernation core.

This sounds like a bug & should have a fixes tag, no? I assume for
whatever commit enabled huge page support...
We don't support set_memory, which by the looks of things is the other
usecase for this function, so probably doesn't need backporting.

Alex, does this change look good to you?

> Add huge page detection to the function to solve the problem.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  arch/riscv/mm/pageattr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 86c56616e5de..792b8d10cdfc 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -221,14 +221,20 @@ bool kernel_page_present(struct page *page)
>  	p4d =3D p4d_offset(pgd, addr);
>  	if (!p4d_present(*p4d))
>  		return false;
> +	if (p4d_leaf(*p4d))
> +		return true;
> =20
>  	pud =3D pud_offset(p4d, addr);
>  	if (!pud_present(*pud))
>  		return false;
> +	if (pud_leaf(*pud))
> +		return true;
> =20
>  	pmd =3D pmd_offset(pud, addr);
>  	if (!pmd_present(*pmd))
>  		return false;
> +	if (pmd_leaf(*pmd))
> +		return true;
> =20
>  	pte =3D pte_offset_kernel(pmd, addr);
>  	return pte_present(*pte);
> --=20
> 2.34.1
>=20

--1ItMQVOOAgwFH9Aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9g9XAAKCRB4tDGHoIJi
0pGlAP0bjQRRS6+HAIsKmX7P58Bd2T/oaUv8qKfywJHbG9vAowD+L0RzZBkdA5r9
pc3NRnVRb1tQScs77zx70+bCIz6AWQw=
=aWFx
-----END PGP SIGNATURE-----

--1ItMQVOOAgwFH9Aw--
