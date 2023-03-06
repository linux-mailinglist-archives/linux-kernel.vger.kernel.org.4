Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6636AD1B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCFWfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCFWfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:35:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADF72D76;
        Mon,  6 Mar 2023 14:35:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0FEEB80EB9;
        Mon,  6 Mar 2023 22:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E32C433D2;
        Mon,  6 Mar 2023 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678142106;
        bh=AaKFvPAhK4yNUKY1AwEa3TApIy5qdHabYFMN/Z1jxYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtKUhs85+91yUOeihxb6gOzKdl1rkMoYVdtYwI7zGwtFFDeGyXL4prr0/l7muZp/b
         7Ac9RVU46iJ8TXSUyDHFoNgw4XLHlwNp3mgwysLRV0ubOyKhUeGk3jJXErmQUDRvKq
         HbvFeGkpNWVIqXQZfBL6erQOoTwwl2RpmdKVKDPagDLDLiyUHAb4LiwjKi8LbuEPPL
         UWrNuJUdtOfFdxb4l12Y92R9yHrNlzxadMQ8/Q6VQmW5P+7aHQbEfUP3QWmIQutMZe
         bSVv9TRYF+MCkSTQL4LXMmqW7eAJkOGQ6x1ebovw6Qo78c6rT2HOB4rcO0PcZHyHgX
         EAG/2yWzXOdzQ==
Date:   Mon, 6 Mar 2023 22:35:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/3] clk: k210: remove an implicit 64-bit division
Message-ID: <be589843-dfc1-47dc-a488-a4fad645c638@spud>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <20230301002657.352637-2-Mr.Bossman075@gmail.com>
 <3b0a1481873a2a7c26015fcedcc673b3.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ERan6PsFUqxi69zE"
Content-Disposition: inline
In-Reply-To: <3b0a1481873a2a7c26015fcedcc673b3.sboyd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ERan6PsFUqxi69zE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 02:31:00PM -0800, Stephen Boyd wrote:
> Quoting Jesse Taube (2023-02-28 16:26:55)
> > diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> > index 67a7cb3503c3..4eed667eddaf 100644
> > --- a/drivers/clk/clk-k210.c
> > +++ b/drivers/clk/clk-k210.c
> > @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_h=
w *hw,
> >         f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
> >         od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> > =20
> > -       return (u64)parent_rate * f / (r * od);
> > +       return div_u64((u64)parent_rate * f, r * od);
>=20
> The equation 'r * od' can't overflow 32-bits, right?

Yah, I checked that when writing the patch. They're 4-bit fields:
> /*
>  * PLL control register bits.
>  */
> #define K210_PLL_CLKR		GENMASK(3, 0)
> #define K210_PLL_CLKF		GENMASK(9, 4)
> #define K210_PLL_CLKOD		GENMASK(13, 10)

Cheers,
Conor.


--ERan6PsFUqxi69zE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZqlQAKCRB4tDGHoIJi
0iy3AQDEyhSWt9luWK3hsRaGF9IFqJJ5Zv5go86VrRKa8gRWBAEAsE83tegQ4VhX
XtAnn+tuUHde9besO1Nnwd7yn9BQ2AE=
=cLk4
-----END PGP SIGNATURE-----

--ERan6PsFUqxi69zE--
