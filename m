Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABB65C4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjACRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbjACRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:10:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0572140DC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B90561488
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDCCC433D2;
        Tue,  3 Jan 2023 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672765663;
        bh=UGU0wQk5Rz5vpjfRCrgvNQs/jjE9iD1PMT5uCeHYMMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0uNLLry+2HwoJmCXdR6Z42NvUWGrrgkKdsrP2OJcwlJE512QrP/hlGqRBc+QjhZH
         q6plqSawA0hKQwDKO4I2qVkuAcgltCtbGFpzU4UzZb7gAcUq5ubJ/xZGpnWdiSptvj
         WTdrFwfe4dIe+FzDvqhA/cyZLegojGc1AO/pA0DiLz2stvw6nPQ5rhYRtkkbkba6yq
         9YXeqVeC3Mkmy7BrnA5OknE/j8z8TxYvZzUFu8Cis+ypV93aWDzTMlvpOo1KS5ktvj
         GLL2oAElQ41l6ziZ2+FdLLjmtXOD1bCjPqh6SndEfkNRc/YR+sTUaD8FsLmiLFA8BN
         4AHJU6bxU/r+g==
Date:   Tue, 3 Jan 2023 17:07:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Message-ID: <Y7Rg28suWh1RUbkU@spud>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bFhWM6tuHAs59VuW"
Content-Disposition: inline
In-Reply-To: <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bFhWM6tuHAs59VuW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Couple comments for you.

+CC Sudeep: I've got a question for you below.

On Tue, Jan 03, 2023 at 07:53:38AM +0000, Leyfoon Tan wrote:
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
> > initialization stage
> > On Tue, Jan 03, 2023 at 11:53:16AM +0800, Ley Foon Tan wrote:
> > > topology_parse_cpu_capacity() is failed to allocate memory with
> > > kcalloc() after read "capacity-dmips-mhz" DT parameter in CPU DT

Uhh, so where did this "capacity-dmips-mhz" property actually come from?
I had a quick check of qemu with grep & I don't see anything there that
would add this property.
This property should not be valid on anything other than arm AFAICT.

> > > nodes. This
> > > topology_parse_cpu_capacity() is called from init_cpu_topology(), move
> > > call to init_cpu_topology() to later initialization  stage (after
> > > memory allocation is available).
> > >
> > > Note, this refers to ARM64 implementation, call init_cpu_topology() in
> > > smp_prepare_cpus().
> > >
> > > Tested on Qemu platform.
> >=20
> > Hi Ley,
> >=20
> > Can you provide the topologies (command lines) tested?
> 2 clusters with 2 CPU cores each.

What's the actual commandline for this? I'm not the best with QEMU, so
it'd really be appreciated, given the above.

> > > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> >=20
> > Fixes tag?
> Okay, will send out next revision with Fixes tag.

Please don't just send versions to add tags, Palmer can pick them up
if/when he applies the patch.

> Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot. ")

> > >  arch/riscv/kernel/smpboot.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > index 3373df413c88..ddb2afba6d25 100644
> > > --- a/arch/riscv/kernel/smpboot.c
> > > +++ b/arch/riscv/kernel/smpboot.c
> > > @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
> > >
> > >  void __init smp_prepare_boot_cpu(void)  {
> > > -	init_cpu_topology();
> > >  }
> > >
> > >  void __init smp_prepare_cpus(unsigned int max_cpus) @@ -48,6 +47,8
> > @@
> > > void __init smp_prepare_cpus(unsigned int max_cpus)
> > >  	int ret;
> > >  	unsigned int curr_cpuid;
> > >
> > > +	init_cpu_topology();

I know arm64 does this, but there is any real reason for us to do so?
@Sudeep, do you know why arm64 calls that each time?
Or if it is worth "saving" that call on riscv, since arm64 is clearly
happily calling it for many years & calling it later would likely head
off a good few allocation issues (like the one we saw with the topology
reworking a few months ago).

Thanks,
Conor.

> > > +
> > >  	curr_cpuid =3D smp_processor_id();
> > >  	store_cpu_topology(curr_cpuid);
> > >  	numa_store_cpu_info(curr_cpuid);
> > > --
> > > 2.25.1
> > >
> >=20
> > Otherwise,
> >=20
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


--bFhWM6tuHAs59VuW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7RgvQAKCRB4tDGHoIJi
0jhvAPwPJ7Hk0k4PcWgouMMd1dWjyjc6Brvu/ySku6YDn2yYQQD/d1s8Kfw0bmSy
Gly1ylo9G9DKJfyp8U6AnamulIqamQI=
=5tyW
-----END PGP SIGNATURE-----

--bFhWM6tuHAs59VuW--
