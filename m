Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA767133EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjE0KDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjE0KDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBBDF7
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F7A60B9D
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43774C433D2;
        Sat, 27 May 2023 10:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685181779;
        bh=Q2FDhXqVNJHaRjoJtXMk1o3QIJ5qqminjno17UsLNMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrsdLN08Txax+9c2aEGIhrhw/xGdOciRKkLKTo4m+PhnvXrvRx6+/IsGBVnTrPNNw
         jSlehauyk2ww6e4Kp6GHmtVe7Sx1Y5FdTPFTEr/QamLzVByImx/hZ1BZiFP7tBlCrC
         RRZ54pk3WEdkd6nkzaU5Fxo2J2Z3UO/H2HqxobN18EEfGTIKbBNEKVO0rG80tZKlJ5
         lH3BiIYFK8HB2nuuR7Dlco7eg6hz2k731zrEFy2NEjv+4n+EaVd4TWduBvaFVKnxuz
         tGIjxXH64ibSD61yCHSpjc3MIv49A0VnYg440u7W4jGe0BIbxdHqVWgtr4ZKD0JtNe
         l5wgnpFlK0g7w==
Date:   Sat, 27 May 2023 11:02:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud>
 <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jODbkASVMwTCezVU"
Content-Disposition: inline
In-Reply-To: <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jODbkASVMwTCezVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 11:13:18AM +0200, Alexandre Ghiti wrote:
>=20
> On 26/05/2023 18:35, Conor Dooley wrote:
> > On Fri, May 26, 2023 at 05:24:41PM +0100, Conor Dooley wrote:
> > > On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
> > > > Early alternatives are called with the mmu disabled, and then shoul=
d not
> > > > access any global symbols through the GOT since it requires relocat=
ions,
> > > > relocations that we do before but *virtually*. So only use medany c=
ode
> > > > model for this early code.
> > > >=20
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >=20
> > > > Note that I'm not very happy with this fix, I think we need to put =
more
> > > > effort into "harmonizing" this very early code (ie before the mmu is
> > > > enabled) as it is spread between different locations and compiled
> > > > differently.
> > > Totally & I'll happily spend the time trying to review that work.
> > >=20
> > > > I'll work on that later, but for now, this fix does what is
> > > > needed to work (from my testing at least). Any Tested-by on the Unm=
atched
> > > > and T-head boards is welcome!
> > > On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added to =
my
> > > config, my Nezha fails to boot. There is no output whatsoever from the
> > > kernel. Turning off CONFIG_RELOCATABLE boots again.
> > I don't know if this is better or worse news, but same thing happens on
> > an icicle kit. What systems, other than QEMU, has the relocatable
> > eries been tested with, btw?
>=20
>=20
> I tested it on the Unmatched (Andreas did too).

Cool. I cracked out my unmatched and it has the same issue as the
icicle. Ditto my Visionfive v2. Here's my config.
https://raw.githubusercontent.com/ConchuOD/riscv-env/dev/conf/defconfig

A ~default qemu virt doesn't work either. (-m 2G -smp 5)

> Very weird it does not work on the icicle kit, there is no errata for this
> soc, so what gets executed this early for this soc? Do you know where it
> fails to boot? If you can debug, you should break on the address of the
> entry point (usually 0x8020_0000) since this is the stvec address, so when
> you get a trap, you will branch there, and then could you dump $sepc, $ra
> and $stval when you get there?

> Regarding the thead issue, I think the following should fix it:

It did not :/

Cheers,
Conor.


--jODbkASVMwTCezVU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHHVTgAKCRB4tDGHoIJi
0m27AP9bIwI2RQkeOKos/BNDiKvKszT1wMJLWmbV6TKsXrd1kgEA5PTTkXBgM6OO
FsZqMgtJsC/sPnS1ikOmo/vfMb8tNgQ=
=A8Pn
-----END PGP SIGNATURE-----

--jODbkASVMwTCezVU--
