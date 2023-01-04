Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D91965D243
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjADMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjADMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:18:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C513F3E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:18:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B90613F8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A91C433D2;
        Wed,  4 Jan 2023 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672834712;
        bh=BBokf/LwUEaFBIuimFzNPIMdoPX5hGYHwIwbb2Xdh90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgOxukepvQDcs1Ov90Jt5SuxeXEfk6vyHOy2vs5XAABo0oUwTsCgpbPW2M+4HTE1i
         f11CKpdGLWUR74sVdwb6P8smyAsS9LOo6tVIZ73i6OIDGxmWKKqhfSXAVFcq64URiT
         15a7rvbDUXRnDTVb+piNL2bVk5jPy3Ai7peTZkCdLAz6H3JoHIS4NbDxwHGYEu2+8o
         gAjCd6rG3o2XvR1rWSTX3u7oh6u08oS2caahKF0u/5CDscXDA1PFSBqOPCrQ1k4pf0
         8yEDb+o04aseO5MSNwTcBse9YxadbUPxMsUHU8j3FsulztCFtjPlrmGXlc4MHAxRzg
         S5Snl3jGKQ9Ig==
Date:   Wed, 4 Jan 2023 12:18:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Message-ID: <Y7VulIcGwuXvBES6@spud>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
 <Y7Rg28suWh1RUbkU@spud>
 <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
 <F86CD957-8B7C-46B9-A14B-AAE67E43CD71@kernel.org>
 <20230104104900.aohsn6zemfllub7r@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E4qsw02zS2eRyVMo"
Content-Disposition: inline
In-Reply-To: <20230104104900.aohsn6zemfllub7r@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E4qsw02zS2eRyVMo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sudeep,

On Wed, Jan 04, 2023 at 10:49:00AM +0000, Sudeep Holla wrote:
> On Wed, Jan 04, 2023 at 09:49:48AM +0000, Conor Dooley wrote:
>=20
> [...]
>=20
> > >> Uhh, so where did this "capacity-dmips-mhz" property actually come f=
rom?
> > >> I had a quick check of qemu with grep & I don't see anything there t=
hat
> > >> would add this property.
> > >> This property should not be valid on anything other than arm AFAICT.
> > >
> > >This DT parameter is not in default Qemu. I've added it for testing (s=
ee test steps in below).=20
> > >This is preparation to support asymmetric CPU topology for RISC-V.
> >=20
> > The property is only valid on arm, so how does arm64 deal with such
> > asymmetric topologies without it?
>=20
> I don't think we can deal with asymmetric topologies without this.
> Yes we can detect the difference in the CPU types but we can only assume
> there are symmetric in terms of performance in absence of this property.


I looked at the bindings for it and forgot that the arm directory of
bindings applies to both arm and arm64. I see now that it is also used
on arm64.

>=20
> > Why should we "fix" something that may never be a valid dts?
> >
>=20
> I would not say invalid. But surely absence of it must be handled and
> we do that for sure. IIRC, here the presence of it is causing the issue.
> And if it is present means someone is trying to build it(I do understand
> this is Qemu but is quite common these days for power and performance
> balance in many SoC)

I said "invalid" as the binding is defined for arm{,64} in arm/cpus.yaml
& documented in the same directory in cpu-capacity.txt, but not yet on
riscv. All bets are off if your cpu node is using invalid properties
IMO, at least this one will fail to boot!

However, I see no reason (at this point) that we should deviate from
what arm{,64} is doing & that documenation should probably move to a
shared location at some point.

> > >>=20
> > >> I know arm64 does this, but there is any real reason for us to do so?
> > >> @Sudeep, do you know why arm64 calls that each time?
> >=20
> > I got myself mixed up between places I fiddled with storing the topolog=
y, so you can ignore that question Sudeep.
> > Clearly it's the one in smp_callin() that gets called for each CPU.
> > Woops.
> >=20
>=20
> Hmm I should have read all the messages in the thread. Doing by date/time
> didn't work well for me =F0=9F=98=84.

Meh, my fault for getting confused ;)

> > >> Or if it is worth "saving" that call on riscv, since arm64 is clearl=
y happily calling
> > >> it for many years & calling it later would likely head off a good fe=
w allocation
> > >> issues (like the one we saw with the topology reworking a few months=
 ago).
> >=20
> > ...but is it still worth moving the function call later to head off any=
 allocation failures if core topology code changes?
> >
>=20
> Agreed, given how we faced similar issues with cacheinfo on few RISC-V
> platforms.

Sweet, sounds like a plan to me. I'll go suggest some commit message
re-wording I think.

Thanks Sudeep!


--E4qsw02zS2eRyVMo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7VulAAKCRB4tDGHoIJi
0hRNAPwOMptZ0yNS8f8cq5EtOM4Weha3qZ4gdjGPHnr/N9TCwQEAiMxFnvGdbNoU
7HCl4PVqXKGo6OOZfHry5a7XDHhfwQ4=
=2bou
-----END PGP SIGNATURE-----

--E4qsw02zS2eRyVMo--
