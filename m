Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158B16CEBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjC2OlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjC2Okw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:40:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA27684;
        Wed, 29 Mar 2023 07:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A55F1B820FE;
        Wed, 29 Mar 2023 14:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95671C4339B;
        Wed, 29 Mar 2023 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680100649;
        bh=L1sqLmIkifE2Q8DXW/e/GjzJNlmt1BIwb5AvVrF0wO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCwHJUPMBB2T0IVu3eU/P+W1JqphqMbb768sdao2TORxURk+WeoyQYAVg+Q+drdj1
         ++BV38HtdQsEpBsufFO+21Lft9t3gt2nXrwkgZ5xbW8gTkacUm5coCLBsxhM+ZQZX6
         gdq2N3yCkBi+jLr44SLjezXhsXVHBlCqF+omci4nnp9IyDPRjJdE6T0O5MTlBGbrj4
         rfviN2WlFprK8I0fqoxEg6aINQRa2Xhq5HK5v7PHhvp6HazGoYpPibeGufWErZBEmo
         8HlHuYfloPLK1SvQcB0mk+5DnvaVNEckdo3PcyEmCp4XZ3MBw4P2M3F02pVdceNWFY
         T/SvmxtvsrjrA==
Date:   Wed, 29 Mar 2023 15:37:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2 2/3] riscv: Do not set initial_boot_params to
 the linear address of the dtb
Message-ID: <179c38d6-4298-4a16-b0d7-8aee49a91f58@spud>
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
 <20230329081932.79831-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UOjzVrvSVXjIViV0"
Content-Disposition: inline
In-Reply-To: <20230329081932.79831-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UOjzVrvSVXjIViV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 10:19:31AM +0200, Alexandre Ghiti wrote:
> early_init_dt_verify() is already called in parse_dtb() and since the dtb
> address does not change anymore (it is now in the fixmap region), no need
> to reset initial_boot_params by calling early_init_dt_verify() again.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/setup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 542eed85ad2c..a059b73f4ddb 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>  	unflatten_and_copy_device_tree();
>  #else
> -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> -		unflatten_device_tree();

Silly question maybe, but since it isn't explicitly mentioned, the
XIP_FIXUP bits no longer matter?
Also, in related news, I assume you don't have a QEMU setup that can do
boot an XIP kernel?

Cheers,
Conor.

> -	else
> -		pr_err("No DTB found in kernel mappings\n");
> +	unflatten_device_tree();
>  #endif
>  	misc_mem_init();
> =20
> --=20
> 2.37.2
>=20

--UOjzVrvSVXjIViV0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCRNJQAKCRB4tDGHoIJi
0gqaAQDSe9gvXHde8jzjSZoWLPBptYoYGaraDZqYua/MYlGe3wEA/9h+58eBSjUH
4VGr3g5fK9KMQFkCCp3A/kRsgdI7bwM=
=B9wY
-----END PGP SIGNATURE-----

--UOjzVrvSVXjIViV0--
