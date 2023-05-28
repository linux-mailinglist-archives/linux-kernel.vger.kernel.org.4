Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C9713985
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjE1NMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1NMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597BAB2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D530760C8F
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 13:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC8FC433EF;
        Sun, 28 May 2023 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685279548;
        bh=tXAneUa9eRcOOQKvqJN2lCiMBLnizozwHm51nLfdFHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP917D8CgFOt53zOzDwT2fwELKsGN6DE6F4zgLwEK84Fr3ZZFqkvF75xW8VVMtDCw
         /bOtC9GTvXEATQjn4kqYRNr4AA3CSrauW9ByKCXLaXvQiV92mzwrLjbbdMl5hAyjtm
         4/zrQXAlYS4B+FDxOWvWQsaAWbmD7JJdB1VHVyakExz1XYla4a2ln6gMsJW3MZTCrW
         EnMnfVSeL3cPIC/u7ICx0a611YZSAUQnwkGwDnPBnBlnRxheQMmteinYVafsX4xPDx
         h8AMVyu4CSZ6YzfXitcesiDAa5I8grtrSKCzp2WlhuI4KUo5+aPgwTWlLr4ZkmEuve
         fYZJ9X9cFth5Q==
Date:   Sun, 28 May 2023 14:12:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230528-darkness-grandly-6cb9e014391d@spud>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud>
 <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
 <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bGjg/yhHrLL/5/o3"
Content-Disposition: inline
In-Reply-To: <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGjg/yhHrLL/5/o3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 03:00:57PM +0200, Alexandre Ghiti wrote:
> On Sat, May 27, 2023 at 12:02=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Sat, May 27, 2023 at 11:13:18AM +0200, Alexandre Ghiti wrote:
> > >
> > > On 26/05/2023 18:35, Conor Dooley wrote:
> > > > On Fri, May 26, 2023 at 05:24:41PM +0100, Conor Dooley wrote:
> > > > > On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
> > > > > > Early alternatives are called with the mmu disabled, and then s=
hould not
> > > > > > access any global symbols through the GOT since it requires rel=
ocations,
> > > > > > relocations that we do before but *virtually*. So only use meda=
ny code
> > > > > > model for this early code.
> > > > > >
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > ---
> > > > > >
> > > > > > Note that I'm not very happy with this fix, I think we need to =
put more
> > > > > > effort into "harmonizing" this very early code (ie before the m=
mu is
> > > > > > enabled) as it is spread between different locations and compil=
ed
> > > > > > differently.
> > > > > Totally & I'll happily spend the time trying to review that work.
> > > > >
> > > > > > I'll work on that later, but for now, this fix does what is
> > > > > > needed to work (from my testing at least). Any Tested-by on the=
 Unmatched
> > > > > > and T-head boards is welcome!
> > > > > On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added=
 to my
> > > > > config, my Nezha fails to boot. There is no output whatsoever fro=
m the
> > > > > kernel. Turning off CONFIG_RELOCATABLE boots again.
> > > > I don't know if this is better or worse news, but same thing happen=
s on
> > > > an icicle kit. What systems, other than QEMU, has the relocatable
> > > > eries been tested with, btw?
> > >
> > >
> > > I tested it on the Unmatched (Andreas did too).
> >
> > Cool. I cracked out my unmatched and it has the same issue as the
> > icicle. Ditto my Visionfive v2. Here's my config.
> > https://raw.githubusercontent.com/ConchuOD/riscv-env/dev/conf/defconfig
> >
> > A ~default qemu virt doesn't work either. (-m 2G -smp 5)
>=20
> I can boot with this config using:
>=20
> $ sudo ~/qemu/build/qemu-system-riscv64 -machine virt -cpu
> rv64,sv48=3Doff -nographic -m 2G -smp 5 -kernel
> build_conor/arch/riscv/boot/Image -s

Just in case, that is my normal config that I use for testing random
stuff on LKML, I added CONFIG_RELOCATABLE in addition to that.

> I noticed when trying to add this to our internal CI that I had local
> failures that did not happen in the CI because the CI was not using
> the same toolchain: can you give me the full .config? So that I can
> see if the compiler added stack guards or some other things I did not
> think of.

https://gist.githubusercontent.com/ConchuOD/655f9cc19fb3be63f1c9da7e7e3ab71=
7/raw/a1aad3c0d307609b2062fd3a66705166aede9f9f/.config

90% of what I test for upstream stuff uses clang, since clang appears to
be a minority choice - but I could reproduce this with gcc-12 as well,
using the same defconfig as linked above + CONFIG_RELOCATABLE.

Cheers,
Conor.

--bGjg/yhHrLL/5/o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHNTNAAKCRB4tDGHoIJi
0iFPAQDdXNjvT9Ni4RBWFipUnBI7Dgveb3bDL9oZ909N0O3OywD/QTvz7SNfn1gv
Wg9Fp0HrHHBkaRMAHPGwbeAdhEPKaQw=
=jMEN
-----END PGP SIGNATURE-----

--bGjg/yhHrLL/5/o3--
