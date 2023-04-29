Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904696F24DD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjD2Ngk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2Ngi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA6198A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB46760A16
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7345C433D2;
        Sat, 29 Apr 2023 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682775396;
        bh=qR5z2S05PO+3Qj7DWNNQjQe9q0aiW2MJANgGn+LsPHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enTorLCTDVjxvuv4kRHNsvkzVUJCSFBqlCcEvNS8dfSuysh6UVBSUy8eLvdHyRk4k
         +aOKGUO6qZLblTpetG6GGrkb3Ro+Fv66ZxDTkQbw/51dxEXaIlR+k15NCmpQ7rtuih
         PHyXlFIQ+EzVUzZziiRDZsOlzgXgW5vh0UPywFrV1WHe2p0tcX8DN3KIASWRTwt5xd
         abb65x3cDqPYR+Ey+4UP7Vi8Ifk5FayVRU28yzBnXyHyj+dXfB+AkWdLB+xYpFur50
         GEMk8GfPCkM3NPitOFT3BuYRB1UPZw0ObL9D4InzqkSRY0mGqRu+9xiZK+h8tLwT/b
         yUwo3pTPnbThA==
Date:   Sat, 29 Apr 2023 14:36:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] RISC-V: Track ISA extensions per hart
Message-ID: <20230429-record-plunder-a21cf40d4cee@spud>
References: <20230428190609.3239486-1-evan@rivosinc.com>
 <20230428190609.3239486-3-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BLU7QsAwGsxIomG5"
Content-Disposition: inline
In-Reply-To: <20230428190609.3239486-3-evan@rivosinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BLU7QsAwGsxIomG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 12:06:07PM -0700, Evan Green wrote:

> @@ -112,14 +116,17 @@ void __init riscv_fill_hwcap(void)
>  	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
> =20
>  	for_each_of_cpu_node(node) {
> +		struct riscv_isainfo *isainfo;
>  		unsigned long this_hwcap =3D 0;
> -		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>  		const char *temp;
> +		unsigned int cpu_id;
> =20
>  		rc =3D riscv_of_processor_hartid(node, &hartid);
>  		if (rc < 0)
>  			continue;
> =20
> +		cpu_id =3D riscv_hartid_to_cpuid(hartid);
> +		isainfo =3D &hart_isa[cpu_id];
>  		if (of_property_read_string(node, "riscv,isa", &isa)) {

Would you mind adding a blank line above the if statement please?
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>  			continue;

--BLU7QsAwGsxIomG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE0dSQAKCRB4tDGHoIJi
0gsnAQD3C7wPGlXJpnjjDLb+5iaR4064+DeCKq1zwwCZmkbK2QEAulHfubOOEb14
bOcIpu2YKL/pjU13yG9aPi38S9/RUwk=
=b/Lb
-----END PGP SIGNATURE-----

--BLU7QsAwGsxIomG5--
