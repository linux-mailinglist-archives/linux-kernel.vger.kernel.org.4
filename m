Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AE6B7A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCMOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCMOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:21:24 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43DD55BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678717282; x=1710253282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ismnZUXCepfarzPEOqeUUYQq3kwkDm86f+K7irh3FbU=;
  b=LHeuS7xDjutV+U8BDI5vR1y83Q/6fAlzECbMQVsaUOQO75DumM3xDqhS
   D9svZ6SeUmAdpCNOyeuIoyhgK5E41GKXS7zNb32g04nOcpc4t2KkvO34l
   eO7N04WajL7aN06Z9if1esAszY+6wZPF+EVMDJp9X2AKivmDibewLYDOD
   d7n3M+7o38/xINevIsdGuQONdU3nDCTM7QXBd2a0Nw8pg0Kx8AZLJPYeb
   6GPfnsK00NnsbMxVEqP3SfPM64eISoPFXqWht4ZMJLo5AYHqX1fyNGGC2
   pJ9xY8EnGAcEXBrVoKawtHoSFhMG3p96JXRmBkX+HpRyW03dzFEEftd03
   w==;
X-IronPort-AV: E=Sophos;i="5.98,257,1673910000"; 
   d="scan'208";a="29649817"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Mar 2023 15:21:20 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 13 Mar 2023 15:21:20 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 13 Mar 2023 15:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678717280; x=1710253280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ismnZUXCepfarzPEOqeUUYQq3kwkDm86f+K7irh3FbU=;
  b=baEfwFKXtfxOIiXPzInB66abWsytihehbyML3BOBpctN+Vtf0/XX/4Il
   9gM41PRceF+uo71IDznZbUKPTn158SLbEAhOugEgyVuQRsWAkBPonrmF6
   Vh6YlG8IlIFpdwITH6mZ8p0rMGvlsyuELR4ogZkULeOoqF2SYlY41H6NU
   4IlonLpZZ+77b8pWjnY6L267w6MI5WFL2pXzxUi2kS42zfgDso2X0THjb
   +q+biwt45/5F8Ar1HDK3H1Ez+Vcm2hXjH3LVEEinmSfqZ0tFukkya1pE3
   i9Zy9g51CwhgWD3wTJVSMtIBTU7rR+2gvZqLRylcr35PmC5jD8aGpS7NA
   w==;
X-IronPort-AV: E=Sophos;i="5.98,257,1673910000"; 
   d="scan'208";a="29649816"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Mar 2023 15:21:20 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 822FC280056;
        Mon, 13 Mar 2023 15:21:20 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Mon, 13 Mar 2023 15:21:18 +0100
Message-ID: <1848012.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <b7e39919-a94f-3929-8814-ada801365dfe@kontron.de>
References: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com> <b7e39919-a94f-3929-8814-ada801365dfe@kontron.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

thanks for your comments.

Am Montag, 13. M=E4rz 2023, 14:46:08 CET schrieb Frieder Schrempf:
> On 10.03.23 10:28, Alexander Stein wrote:
> > This fixes a copy & paste error.
>=20
> I would mention here, that this doesn't contain any functional changes
> as BUCK1_ENMODE_MASK is equal to BUCK2_ENMODE_MASK.

That's a good idea.

> > Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> > Originally-from: Robin Gong <yibin.gong@nxp.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > This diff is extracted from a downstream commit authored by Robin Gong.
> > I'm not sure if adding Originally-from: is enough here or I do have to
> > change From: as well.
>=20
> I never heard of "Originally-from:". Does this tag exist? Is it
> documented somewhere?

Well, it's not documented, but it pops up occasionally in some commits, e.g.
3fb906e7fabbb ("cgroup/cpuset: Don't filter offline CPUs in=20
cpuset_cpus_allowed() for top cpuset tasks")
I might be something only some maintainers accept though.

> I think that your tooling (git format-patch) should add a From: tag
> automatically if you correctly pick up a patch from someone else.

Well, it's not exactly cherry-picked, but extracted from an existing commit=
=20
[1], so that's maybe why my name has been put into From: while extracting.
As the diff in this patch is not exactly the same as from the origin, I did=
=20
not want to put Robin Gong into Signed-off-by. And I think having an author=
 in=20
=46rom: but not in Signed-off-by: tag should not happen.
Searching how I can still give credit I found Originally-from. If there is =
a=20
better way to handle this, I'm ready to adapt to that.

Best regards,
Alexander

[1] https://github.com/Freescale/linux-fslc/commit/
fe6b4f7a23a79637c6fb182fb1ea9136d953e3f7

> Other than these formal issues the change itself looks good to me.
>=20
> >  drivers/regulator/pca9450-regulator.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/regulator/pca9450-regulator.c
> > b/drivers/regulator/pca9450-regulator.c index c84d95b11e9c..544e741f7108
> > 100644
> > --- a/drivers/regulator/pca9450-regulator.c
> > +++ b/drivers/regulator/pca9450-regulator.c
> > @@ -265,7 +265,7 @@ static const struct pca9450_regulator_desc
> > pca9450a_regulators[] =3D {>=20
> >  			.vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> >  			.vsel_mask =3D BUCK2OUT_DVS0_MASK,
> >  			.enable_reg =3D PCA9450_REG_BUCK2CTRL,
> >=20
> > -			.enable_mask =3D BUCK1_ENMODE_MASK,
> > +			.enable_mask =3D BUCK2_ENMODE_MASK,
> >=20
> >  			.enable_val =3D BUCK_ENMODE_ONREQ_STBYREQ,
> >  			.ramp_reg =3D PCA9450_REG_BUCK2CTRL,
> >  			.ramp_mask =3D BUCK2_RAMP_MASK,
> >=20
> > @@ -509,7 +509,7 @@ static const struct pca9450_regulator_desc
> > pca9450bc_regulators[] =3D {>=20
> >  			.vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> >  			.vsel_mask =3D BUCK2OUT_DVS0_MASK,
> >  			.enable_reg =3D PCA9450_REG_BUCK2CTRL,
> >=20
> > -			.enable_mask =3D BUCK1_ENMODE_MASK,
> > +			.enable_mask =3D BUCK2_ENMODE_MASK,
> >=20
> >  			.enable_val =3D BUCK_ENMODE_ONREQ_STBYREQ,
> >  			.ramp_reg =3D PCA9450_REG_BUCK2CTRL,
> >  			.ramp_mask =3D BUCK2_RAMP_MASK,


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


