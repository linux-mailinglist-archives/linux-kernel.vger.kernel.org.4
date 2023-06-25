Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4473D163
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFYOTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFYOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98977E43;
        Sun, 25 Jun 2023 07:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBF66098A;
        Sun, 25 Jun 2023 14:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E25C433C0;
        Sun, 25 Jun 2023 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687702735;
        bh=eELfk8BQQe7CSBA1iViJovL7FyC1t3NJ0tuD7vTmyyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNXdu/oCbHxoBS+wFq3/5UImorTTdWG2vHm2+aiAyQ3F+c4thmF5h7y1s0Z/sqCEL
         r6oCgQWbH9xBIWkZyMUfsKMGV6+7qW7BF6rj4BmUV8bc6IGe0BEqjRMVHPtwz5MGsK
         4jwICroWdLTP2blCrg9TFA3u4BxmHa/uUlITI7BtPgdFd+N0peZuqpoaJZtz1H2seE
         CJrBc4t/6mozEt46hA1+veLpWtwABU1dZU2T1WPupvcwvxyq8pae+31n0w1aRs0T5j
         8MUR0o/yRahFEVBF2ixv+l75TsRm2C3Vy5JBU4b7K46jDmUtC8K9wEVDxnJXEuoWb9
         TxSZ6WirPDFfw==
Date:   Sun, 25 Jun 2023 15:18:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
Message-ID: <20230625-multiple-diaper-1db88a75314e@spud>
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
 <20230625140931.1266216-2-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5rU6R4tPsIYzsO+l"
Content-Disposition: inline
In-Reply-To: <20230625140931.1266216-2-songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5rU6R4tPsIYzsO+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 10:09:29PM +0800, Song Shuai wrote:
> This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.
>=20
> With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
> linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
> load address which was placed at a PMD boundary.

> And firmware always
> correctly mark resident memory, or memory protected with PMP as
> per the devicetree specification and/or the UEFI specification.

But this is not true? The versions of OpenSBI that you mention in your
cover letter do not do this.
Please explain.

> So those regions will not be mapped in the linear mapping and they
> can be safely saved/restored by hibernation.
>=20
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/Kconfig | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5966ad97c30c..17b5fc7f54d4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -800,11 +800,8 @@ menu "Power management options"
> =20
>  source "kernel/power/Kconfig"
> =20
> -# Hibernation is only possible on systems where the SBI implementation h=
as
> -# marked its reserved memory as not accessible from, or does not run
> -# from the same memory as, Linux
>  config ARCH_HIBERNATION_POSSIBLE
> -	def_bool NONPORTABLE
> +	def_bool y
> =20
>  config ARCH_HIBERNATION_HEADER
>  	def_bool HIBERNATION
> --=20
> 2.20.1
>=20

--5rU6R4tPsIYzsO+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJhMyQAKCRB4tDGHoIJi
0ilaAP4rih3tvcajCwDW0SHvhQ9DqWJq0Zn2Vm8HAQG/CfO9vgEAmBEyl28RPpUW
ZzBaowc8mzQh7JPK2GtFXOBJBQKwxwE=
=/uWn
-----END PGP SIGNATURE-----

--5rU6R4tPsIYzsO+l--
