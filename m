Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B365D422
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjADNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbjADNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:30:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303A3753E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74BEFB81643
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36082C433D2;
        Wed,  4 Jan 2023 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672838689;
        bh=YpYR2GonCLztWkI2c4G09bee7KvC/CLcpqPv7HvDuwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iu2X7jUmxgJ/of/VU0GSilr6CgXjd3TeOXz5nsB3sYgXa/qbpcHsBieFfErATV8CD
         OPJy69/EecNUi9WCdtMFlx7IbgLXFO/QFyW7lzn1gvlVR/SySBy5DCM0iVn7/1Fp79
         2mktgAxJ9bui4kygHL8pbui+O5QRdrr1RfThBU/d0XXwotGFQ/NsadZrrtrz/UAxBC
         q+txTAvgvE+P2B9Bx/5ZK9JfT53hM+6ERmKj2ebmpDi4v5DmUXiFQ/8o9sVku3h1or
         //eBbdpQa7m+KMJrxMeJ56NyNiqBBWY55ygS92Aywl9IIMD72ua48CagvoZv142fKU
         MEnrw2d+0UY0A==
Date:   Wed, 4 Jan 2023 13:24:44 +0000
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
Message-ID: <Y7V+HJk8twZXcdcf@spud>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
 <Y7Rg28suWh1RUbkU@spud>
 <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
 <F86CD957-8B7C-46B9-A14B-AAE67E43CD71@kernel.org>
 <20230104104900.aohsn6zemfllub7r@bogus>
 <Y7VulIcGwuXvBES6@spud>
 <20230104125632.ktoyt7mxjjxq5udm@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H1G8jhfASj+O0pW2"
Content-Disposition: inline
In-Reply-To: <20230104125632.ktoyt7mxjjxq5udm@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H1G8jhfASj+O0pW2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2023 at 12:56:32PM +0000, Sudeep Holla wrote:
> On Wed, Jan 04, 2023 at 12:18:28PM +0000, Conor Dooley wrote:

> > On Wed, Jan 04, 2023 at 10:49:00AM +0000, Sudeep Holla wrote:
> > > On Wed, Jan 04, 2023 at 09:49:48AM +0000, Conor Dooley wrote:

> > > > Why should we "fix" something that may never be a valid dts?
> > > >
> > >=20
> > > I would not say invalid. But surely absence of it must be handled and
> > > we do that for sure. IIRC, here the presence of it is causing the iss=
ue.
> > > And if it is present means someone is trying to build it(I do underst=
and
> > > this is Qemu but is quite common these days for power and performance
> > > balance in many SoC)
> >=20
> > I said "invalid" as the binding is defined for arm{,64} in arm/cpus.yaml
> > & documented in the same directory in cpu-capacity.txt, but not yet on
> > riscv. All bets are off if your cpu node is using invalid properties
> > IMO, at least this one will fail to boot!
> >=20
> > However, I see no reason (at this point) that we should deviate from
> > what arm{,64} is doing & that documenation should probably move to a
> > shared location at some point.
> >
>=20
> I prefer making this binding generic rather than patching to handle RISC-V
> differently in the generic code. Since it is optional, the platform
> need not use it if it is not needed.

Oh yeah, I was not suggesting making changes in the generic code. We
just need to change our cpu binding to match the arm cpu binding so that
having this property is accepted.

I shall go do that at some point today probably.

Thanks,
Conor.


--H1G8jhfASj+O0pW2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7V+HAAKCRB4tDGHoIJi
0sqnAQD+Kw88kORg+w9/4qunCf0eOuyAhDu9FkXM7x6v7jV7UAEA0H965UPe35Zi
7tkByuA1+8dQQgAkMyAinm0vPGPCJwI=
=ebrI
-----END PGP SIGNATURE-----

--H1G8jhfASj+O0pW2--
