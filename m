Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3876F0AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbjD0R2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjD0R2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC85110
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F64611B4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643E7C433D2;
        Thu, 27 Apr 2023 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682616491;
        bh=fTIHyMELB7P4mMmUO7vjz/67287/XF7r/7KUpvHIaGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raRn+1kXDTM/GzlCJKA+5Te3YPVHdgoUeMtH/pxSm2YmAMNMNlSwpODOL46OGiLdc
         vdLk8IiO24cJnOHdxQwQeHZbmoJHDSTMcfoc2jSFOD/lUI0HtOQMf6tj5TFDfJRddI
         Jx1o81RQ4CeTKj7FCVOpLNChhVWB0Xg303ciZpt3oMbofaMZbv1AFgovB/fnzA4CzX
         XJvtNSwNAxQny7MrssylghZSmifwucnOsPWfuEknqaTquot/qLNwRReWFOK39rJ8G9
         28KvMNuih5oMwx4bzMsc4ex9SaZC348yndTciFdIDEs5wJ6xDXfBK/vPo5OHxwxUzq
         ENv5cOEu9qVvA==
Date:   Thu, 27 Apr 2023 18:28:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu, i@zenithal.me,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, soha@lohu.info,
        twd2.me@gmail.com
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <20230427-duplicate-procedure-2eec53856977@spud>
References: <20230426-porthole-wronged-d5a6a3b89596@spud>
 <tencent_BC64BBD18CAF41904B9BD1510B1739062805@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VTpKZ7gKyqWX7CfH"
Content-Disposition: inline
In-Reply-To: <tencent_BC64BBD18CAF41904B9BD1510B1739062805@qq.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VTpKZ7gKyqWX7CfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 08:47:18PM +0800, Yangyu Chen wrote:
> Hi, Conor
>=20
> Thanks for your meaningful reviews. I agree with most of your advice but
> have a question about the code about checking the first 2 characters are
> "rv" in `arch/riscv/kernel/cpu.c`.
>=20
> On Wed, 26 Apr 2023 19:54:39 +0100, Conor Dooley wrote:
> > > @@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *n=
ode, unsigned long *hart)
> > >  		pr_warn("CPU with hartid=3D%lu has no \"riscv,isa\" property\n", *=
hart);
> > >  		return -ENODEV;
> > >  	}
> > > -	if (isa[0] !=3D 'r' || isa[1] !=3D 'v') {
> > > +	if (tolower(isa[0]) !=3D 'r' || tolower(isa[1]) !=3D 'v') {
> > >  		pr_warn("CPU with hartid=3D%lu has an invalid ISA of \"%s\"\n", *h=
art, isa);
> > >  		return -ENODEV;
> >=20
> > I don't understand why this is even here in the first place. I'd be
> > inclined to advocate for it's entire removal. Checking *only* that there
> > is an "rv" in that string seems pointless to me. If you're on a 64-bit
> > kernel and the node has riscv,isa =3D "rv32ima" it's gonna say it is ok=
ay?
> > Drew what do you think?
>=20
> I think this code could be a workaround for running rv32 S-Mode on rv64
> CPU without changing the DT, although the proper way should be to change
> this field in DT by bootloader or any other software.
>=20
> I have tested a simple rv64imac CPU core and left the `riscv,isa` string
> empty in the DT and removed the above 3 lines check from the kernel, and
> the kernel boots successfully, and using busybox as init is also ok.=20
> However, if this check exists, the kernel will panic at `setup_smp` due to
> `BUG_ON(!found_boot_cpu)` in `setup_smp`.

The initramfs I have fails to boot because it is build with FP support.
Out of curiosity, what shows up in /proc/cpuinfo in that case?

> I am wondering whether this should remove or add a more sufficient
> validation. Although this function will not be called in ACPI as I
> reviewed the recent ACPI patches[1], it will not be a problem if I submit
> this patch for better ACPI support. However, If I just simply remove it
> from my patch and submit patch v2 directly, the ISA string in ACPI mode
> with all uppercase letters will be OK. But in DT mode, the kernel behavior
> will accept the ISA string with all uppercase letters except the first two
> "rv". Do you think this behavior is different between DT and ACPI can be
> OK?

A difference would be fine, if it was that ACPI allowed caps and DT
didn't. But allowing caps everywhere other than the RV just seems a bit
silly to me, so I would rather allow the capitalisation of RV.

> After some investigation, I suggest removing this validation since the
> validation is useless for a proper DT and the recent ACPI patches[1] do
> not validate the ISA strings, so we will have the same behavior between
> DT and ACPI.

I dunno. I'd like to split that function in 2 actually, but I would
like the ACPI stuff to land before doing so. I think for now, what might
be best is checking that it has a sufficient strlen in a separate patch,
earlier in your series, and making the check case-insensitive as you have
done already here.

Cheers,
Conor.

--VTpKZ7gKyqWX7CfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEqwpgAKCRB4tDGHoIJi
0kWfAP9e4VArAxe0AaDHBJoslthiQDLrOA4hOUoJTcqOEXJG/QD+KtBWf2LGLbZs
LZMF2RrjfiA1vdsCUAO1mBtQvGEE/w4=
=/PYG
-----END PGP SIGNATURE-----

--VTpKZ7gKyqWX7CfH--
