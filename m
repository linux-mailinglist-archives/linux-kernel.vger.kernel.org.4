Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239A70A049
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjESUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjESUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:07:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F3FE
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7000365ACA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 20:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AE2C433D2;
        Fri, 19 May 2023 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684526839;
        bh=GueLlvy9I6RxLVBJs0ggqGdT3GA71cYKbBJmwmHLI28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=op4dMPQhhFRa7VChtubvSx0elvgUILi0nibxjtfg8EpcH0v3uxUTdcsHSWvWMPSKU
         EQ53cpqjb4ZYyM/RCGBSWi4pcRCbNTiG7xTU4AK+EycnpF9Wb8qmCpi421X3sGW/0s
         htTl6KhcSlpA72nPv0xj9NiJfsszzrugbUrf0ZlnnTS3YDJqaImehoUQrAAhJkVkxq
         qWREUA8Hlhn9UQj8QQLJR+exbKvcq52u8REdt8NpjeQTg4I0TmHSCLgJu9nVha0qp1
         /tlQbSDRcQBMVlBM/HeeijU38tk2Lg5Q7M6SY9WIsVDtQTjiNuFK33Bexq5A9C/ucS
         73qUhbYoGyZbA==
Date:   Fri, 19 May 2023 21:07:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Song Shuai <suagrfillet@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: Re: [PATCH] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Message-ID: <20230519-roundup-legwarmer-e26b31db3123@spud>
References: <20230519102908.253458-1-suagrfillet@gmail.com>
 <9a274a44b61345e8aba747a44250c4d8@EXMBX066.cuchost.com>
 <20230519-clarinet-collar-ba2c0fa37e11@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uSefXicpntsEBwun"
Content-Disposition: inline
In-Reply-To: <20230519-clarinet-collar-ba2c0fa37e11@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uSefXicpntsEBwun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 12:28:07PM +0100, Conor Dooley wrote:
> Hey,
>=20
> On Fri, May 19, 2023 at 11:14:27AM +0000, JeeHeng Sia wrote:
>=20
> > > The suspend_restore_csrs is called in both __hibernate_cpu_resume
> > > and the `else` of subsequent swsusp_arch_suspend.
> > >=20
> > > Removing the first call makes both suspend_{save,restore}_csrs
> > > left in swsusp_arch_suspend for clean code.

It took me embarrassingly long to wrap my head around the control flow
here again. I'm not sure that I agree with you that splitting the calls
between asm & c is cleaner, but whatever:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> > >=20
> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>=20
> BTW, why the two email addresses? The tinylab one here seems entirely
> redundant - unless it is your employer, in which case should it be the
> only SoB address & also in the author field?

Deja vu with my questioning your email address, but does your
tinylab address actually repeat "shuai"?

> Also, Fixes tag?
>=20
> > > ---
> > >  arch/riscv/kernel/hibernate-asm.S | 1 -
> > >  1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hi=
bernate-asm.S
> > > index 5c76671c7e15..d698dd7df637 100644
> > > --- a/arch/riscv/kernel/hibernate-asm.S
> > > +++ b/arch/riscv/kernel/hibernate-asm.S
> > > @@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
> > >=20
> > >  	REG_L	a0, hibernate_cpu_context
> > >=20
> > > -	suspend_restore_csrs
> > >  	suspend_restore_regs
>=20
> > Good catch. This function is invoked twice to restore the CSRs.
> > I am good with removing this function from here.
>=20
> If that's a review, then please either give an R-b or A-b tag :)
>=20
> Thanks,
> Conor.



--uSefXicpntsEBwun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGfW8gAKCRB4tDGHoIJi
0tw4AQDBfboPqCfJHjV7Ajz/a1GmKu7ftIVfnIVRkMql7569iwD/atGwcUcipdg1
g8k7p+pQvEvpeT4Jk8RmodBPZGOaaAA=
=YRPl
-----END PGP SIGNATURE-----

--uSefXicpntsEBwun--
