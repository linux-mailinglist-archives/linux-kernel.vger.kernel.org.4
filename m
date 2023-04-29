Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD166F2409
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjD2Ju6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2Ju4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633A173F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BCF60ED0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 09:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16431C4339B;
        Sat, 29 Apr 2023 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682761854;
        bh=3QV0GbV5gWzKWisLdYF7p6lD5dc3jxVmLZ6ZNkHJpNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BY48QoO1Ihbm7bGmZS3hbsdkJjRZjgWnvGrNiYl9zoCgQJwU/TvJYsY3WBAOjr10Y
         S4+rkPcVQPnPhR4lEk1RsuLSWlsLYefVmIZUgQm1G5eDccohUZxcSZvomZ6GZpUsbV
         StzOt59ZP35I8z3cFFUeAWf4eA2fA6EnD8NMWLaLA+omDqVU7QqNrpwbMmzT2sWqva
         /8pqwmdm807CdeCKjeBRk3POGIE2NGB/ahJQ9GhBo6F7OHODhsqaZLVS/s68fgw/5+
         ZMJQtnL4HGV6ercpMToq1hfwf9o9DRUE8nTvoQc/Dr/06D1RMZ+xApuQcQq/8U4/u9
         gBBxYwS1d9ZnA==
Date:   Sat, 29 Apr 2023 10:50:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH] riscv: fix sifive and thead section mismatches in errata
Message-ID: <20230429-exclusion-specimen-f47b03c6d859@spud>
References: <20230429043530.20503-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IcQ4eY/AV7BFjoO1"
Content-Disposition: inline
In-Reply-To: <20230429043530.20503-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IcQ4eY/AV7BFjoO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 09:35:30PM -0700, Randy Dunlap wrote:
> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
> CONFIG_MODULES is not set, __init_or_module becomes __init.
> In the latter case, it causes section mismatch warnings:
>=20
> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cp=
u_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.tex=
t)
> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cp=
u_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.text)
>=20
> It appears that CONFIG_MODULES not set is not tested very much.

I dunno if it the testing is *that* rare, because I'm not sure that the
fixes tags below are correct. I think that it is actually:
Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_featur=
es()")
That was only applied on 20/04.

Cheers,
Conor.

> Fixes: a8e910168bba ("riscv: implement module alternatives")
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/errata/sifive/errata.c |    8 +++-----
>  arch/riscv/errata/thead/errata.c  |    6 +++---
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff -- a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/er=
rata.c
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -82,11 +82,9 @@ static void __init_or_module warn_miss_e
>  	pr_warn("--------------------------------------------------------------=
--\n");
>  }
> =20
> -void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
> -					       struct alt_entry *end,
> -					       unsigned long archid,
> -					       unsigned long impid,
> -					       unsigned int stage)
> +void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry =
*end,
> +			      unsigned long archid, unsigned long impid,
> +			      unsigned int stage)
>  {
>  	struct alt_entry *alt;
>  	u32 cpu_req_errata;
> diff -- a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/erra=
ta.c
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -83,9 +83,9 @@ static u32 thead_errata_probe(unsigned i
>  	return cpu_req_errata;
>  }
> =20
> -void __init_or_module thead_errata_patch_func(struct alt_entry *begin, s=
truct alt_entry *end,
> -					      unsigned long archid, unsigned long impid,
> -					      unsigned int stage)
> +void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *=
end,
> +			     unsigned long archid, unsigned long impid,
> +			     unsigned int stage)
>  {
>  	struct alt_entry *alt;
>  	u32 cpu_req_errata =3D thead_errata_probe(stage, archid, impid);

--IcQ4eY/AV7BFjoO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzoegAKCRB4tDGHoIJi
0neEAQDt7ZWE+zuZ+C9BSkBU7Mx6/aHmGOU/uJDzIBTwvI1PpgD+P0ufRsHpQfWX
jvvcKs6ip23Lvz6kqZ6YMmkMTSpDXAY=
=tmZN
-----END PGP SIGNATURE-----

--IcQ4eY/AV7BFjoO1--
