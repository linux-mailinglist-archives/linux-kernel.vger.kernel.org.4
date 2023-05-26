Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA2712AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjEZQfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjEZQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DFDF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9179565029
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B209C433EF;
        Fri, 26 May 2023 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685118915;
        bh=dDtcjo2khBi8ymoa90ET2UZ26pR1HJAdtcLCQJ44+f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqgpkTpUOTSS7G21efDm78STIdWUG7tTVfcYM5JvNx8fxyqCL0w5sqiZYWDWGP6nl
         iX678eZOZ9o4f66IuHfni5SfYzUyIzNmcT+mWm13ZS/48DL8La86KBl+atyw1zJvzm
         0lV15AL9AF/jS+nKH9Pob8MLWG+0YIfXbGbD42jGUljLrP/srHgwdLwPqgwKpWRNMy
         ZYtz6pUIbyLu0OLqIib6FZJjWvoxoIIBNgsY6SCSY81tk0qM2TaP04dm5geOMJKNlY
         1wB3fM5DZEyJSnBJFa6lNL789Yf4D4ktKmnPF0Iviepc7ao39CxG7v2ZkkbueZ4UG8
         uf1pFaHAbEctQ==
Date:   Fri, 26 May 2023 17:35:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230526-rockfish-moody-f6d3e71f9d24@spud>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="REENGAGNHgcCpbL0"
Content-Disposition: inline
In-Reply-To: <20230526-clergyman-wriggly-accc659a3fad@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--REENGAGNHgcCpbL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:24:41PM +0100, Conor Dooley wrote:
> On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
> > Early alternatives are called with the mmu disabled, and then should not
> > access any global symbols through the GOT since it requires relocations,
> > relocations that we do before but *virtually*. So only use medany code
> > model for this early code.
> >=20
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >=20
> > Note that I'm not very happy with this fix, I think we need to put more
> > effort into "harmonizing" this very early code (ie before the mmu is
> > enabled) as it is spread between different locations and compiled
> > differently.
>=20
> Totally & I'll happily spend the time trying to review that work.
>=20
> > I'll work on that later, but for now, this fix does what is
> > needed to work (from my testing at least). Any Tested-by on the Unmatch=
ed
> > and T-head boards is welcome!
>=20
> On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added to my
> config, my Nezha fails to boot. There is no output whatsoever from the
> kernel. Turning off CONFIG_RELOCATABLE boots again.

I don't know if this is better or worse news, but same thing happens on
an icicle kit. What systems, other than QEMU, has the relocatable
eries been tested with, btw?

Cheers,
Conor.

>=20
> I didn't test on my unmatched.
>=20
> Thanks,
> Conor.



--REENGAGNHgcCpbL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHDfvgAKCRB4tDGHoIJi
0o5PAP4kGp6TYrXzx+SgO893FhzdwG2Eq5HmFYhREfw4DJSsfQD9GAf/u9yn78RL
UejivzEp0vJSvQvVYzpd1U7jAPQTkgc=
=Sb9T
-----END PGP SIGNATURE-----

--REENGAGNHgcCpbL0--
