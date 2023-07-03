Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E37463A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGCUEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGCUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E9E6E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE21D6102A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22184C433C9;
        Mon,  3 Jul 2023 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688414681;
        bh=IcAfiG8OOKpZDvnjSGgNJHeFNEOo0/ajdloiPrl28ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOrB9I8Vi54BjlJVkPrHXRdks0lQ+yE0MtmdCDiiWhWm8C1/zWOpzWg1RHV79H6sQ
         pwy2pk6PXsl6gx7Y+4jADWloLrXqmQ5ms6oqwniIobcgVOGX0OxFyxfeAbCIJI701m
         VtyVn71ldOZGADPyEEJjD1/YkM9wALYbJx3pum5vLlPPI+LEBg5d9yq+waeMc8W3VE
         N2fvG95amZ6zP5/BvyN0OgrX4xScqKXBsKdvgXeqwNFdyfic5scrQYckloJ7itSSeO
         hy15qo+ZG1Chfg6F1PuLJREGZDzf8qbOJ7KLCJRwJydGKNW8oU3RdXAs1PDpcZi5Jb
         fSXgreQWAWITA==
Date:   Mon, 3 Jul 2023 21:04:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] risc-v: Fix order of IPI enablement vs RCU startup
Message-ID: <20230703-baffling-pesticide-e83e74506d2b@spud>
References: <20230703183126.1567625-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mZHX4r2uUXdT/n9O"
Content-Disposition: inline
In-Reply-To: <20230703183126.1567625-1-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mZHX4r2uUXdT/n9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 07:31:26PM +0100, Marc Zyngier wrote:
> Conor reports that risc-v tries to enable IPIs before telling the
> core code to enable RCU. With the introduction of the mapple tree
> as a backing store for the irq descriptors, this results in
> a very shouty boot sequence, as RCU is legitimately upset.
>=20
> Restore some sanity by moving the risc_ipi_enable() call after
> notify_cpu_starting(), which explicitly enables RCU on the calling
> CPU.
>=20
> Fixes: 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")
> Reported-by: Conor Dooley <conor@kernel.org>

RCU no longer chucks the toys at least, and none of the wheels seem to
have fallen off the pram in the process.
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks guys!

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20230703-dupe-frying-79ae2ccf94eb@spud
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/riscv/kernel/smpboot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index bb0b76e1a6d4..f4d6acb38dd0 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -238,10 +238,11 @@ asmlinkage __visible void smp_callin(void)
>  	mmgrab(mm);
>  	current->active_mm =3D mm;
> =20
> -	riscv_ipi_enable();
> -
>  	store_cpu_topology(curr_cpuid);
>  	notify_cpu_starting(curr_cpuid);
> +
> +	riscv_ipi_enable();
> +
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
>  	probe_vendor_features(curr_cpuid);
> --=20
> 2.34.1
>=20

--mZHX4r2uUXdT/n9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKMp1QAKCRB4tDGHoIJi
0si4AP96MGH5Dcx1wg1Nl3BnBttJga0JE12zbFkTI16bAa77twD/S8vn4w5Qp2xv
u33U0BseMblhaYqyPwlfApckykURmgE=
=DrS2
-----END PGP SIGNATURE-----

--mZHX4r2uUXdT/n9O--
