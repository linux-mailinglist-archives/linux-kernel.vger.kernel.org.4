Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0B6E1678
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDMV1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378149D1;
        Thu, 13 Apr 2023 14:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71F6615D5;
        Thu, 13 Apr 2023 21:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C27C4339B;
        Thu, 13 Apr 2023 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681421221;
        bh=/jGEJeKLyPMxUtqHp2WZdU/JbdsZD4k1lj6KjaN93IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmMulCtlp7EypunqNuocZRBjfCy0amEU1QBP4kVBLZuoY52IqcaL2Qw+npZEo+4sw
         iz/8Ur/3cNdPQtu9+WFKf9iha5GSSwo8NbMLIGj3hdKjEVPmW8SdlGJO8/7zyWbxva
         3YbQplRpzYnw9/Oji/SDDav6GSvp2vURwt0mo20bfogoALqcNOCEHGu+ax5+ARmgbX
         tfNFPpK0tVtzrx2W2fffnXQng0s7N6Xphu2DAf8vFcAlXSfZzG94lSHkQrnEoak6cG
         iuJLAPc8h/xiQS69sVI5/AsU3YGZrfdFb8q/Hs5UKLTELFlvNqxfCl/inFNKvr1h4y
         kexPkjgQzR5KA==
Date:   Thu, 13 Apr 2023 22:26:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Tommaso Merciai <tomm.merciai@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH] clk: starfive: Avoid casting iomem pointers
Message-ID: <20230413-creamer-overstate-f7ce5a72e437@spud>
References: <20230413205528.4044216-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I1j3s3ZljXJDf82V"
Content-Disposition: inline
In-Reply-To: <20230413205528.4044216-1-sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I1j3s3ZljXJDf82V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 01:55:28PM -0700, Stephen Boyd wrote:
> Let's use a wrapper struct for the auxiliary_device made in
> jh7110_reset_controller_register() so that we can stop casting iomem
> pointers. The casts trip up tools like sparse, and make for some awkward
> casts that are largely unnecessary.

Cool, thanks for doing it!

> While we're here, change the
> allocation from devm and actually free the auxiliary_device memory in
> the release function. This avoids any use after free problems where the
> parent device driver is unbound from the device but the
> auxiliuary_device is still in use accessing devm freed memory.
>=20
> Cc: Tommaso Merciai <tomm.merciai@gmail.com>
> Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Cc: Hal Feng <hal.feng@starfivetech.com>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock dri=
ver")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>=20
> I can take this via clk tree.
>=20
>  drivers/clk/starfive/clk-starfive-jh7110-sys.c | 15 ++++++++++++---
>  drivers/reset/starfive/reset-starfive-jh7110.c |  9 ++++++---
>  include/soc/starfive/reset-starfive-jh71x0.h   | 17 +++++++++++++++++
>  3 files changed, 35 insertions(+), 6 deletions(-)
>  create mode 100644 include/soc/starfive/reset-starfive-jh71x0.h
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk=
/starfive/clk-starfive-jh7110-sys.c
> index 5ec210644e1d..851b93d0f371 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -11,6 +11,9 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <soc/starfive/reset-starfive-jh71x0.h>
> =20
>  #include <dt-bindings/clock/starfive,jh7110-crg.h>
> =20
> @@ -335,26 +338,32 @@ static void jh7110_reset_unregister_adev(void *_ade=
v)
>  	struct auxiliary_device *adev =3D _adev;
> =20
>  	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);

Huh, I think you didn't explicitly mention this one, but it's actually
part of the UAF fix AFAICT?

When I did the aux device stuff for the clk-mpfs driver, I copied from
peci as there were almost no examples of aux dev stuff in-tree.
It looks like subsequently to me starting development, this fix landed:
1c11289b34ab ("peci: cpu: Fix use-after-free in adev_release()")

It similarly moves the uninit() to the release callback...

I think I need the below (whitespace damaged):
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-m=
pfs.c
index 4f0a19db7ed7..cc5d7dee59f0 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -374,14 +374,13 @@ static void mpfs_reset_unregister_adev(void *_adev)
        struct auxiliary_device *adev =3D _adev;
=20
        auxiliary_device_delete(adev);
+       auxiliary_device_uninit(adev);
 }
=20
 static void mpfs_reset_adev_release(struct device *dev)
 {
        struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
=20
-       auxiliary_device_uninit(adev);
-
        kfree(adev);
 }

Anyways, for this patch:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  }
> =20
>  static void jh7110_reset_adev_release(struct device *dev)
>  {
>  	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +	struct jh71x0_reset_adev *rdev =3D to_jh71x0_reset_adev(adev);
> =20
> -	auxiliary_device_uninit(adev);
> +	kfree(rdev);
>  }
> =20
>  int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>  				     const char *adev_name,
>  				     u32 adev_id)
>  {
> +	struct jh71x0_reset_adev *rdev;
>  	struct auxiliary_device *adev;
>  	int ret;
> =20
> -	adev =3D devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
> -	if (!adev)
> +	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
>  		return -ENOMEM;
> =20
> +	rdev->base =3D priv->base;
> +
> +	adev =3D &rdev->adev;
>  	adev->name =3D adev_name;
>  	adev->dev.parent =3D priv->dev;
>  	adev->dev.release =3D jh7110_reset_adev_release;
> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/res=
et/starfive/reset-starfive-jh7110.c
> index c1b3a490d951..2d26ae95c8cc 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7110.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
> @@ -7,6 +7,8 @@
> =20
>  #include <linux/auxiliary_bus.h>
> =20
> +#include <soc/starfive/reset-starfive-jh71x0.h>
> +
>  #include "reset-starfive-jh71x0.h"
> =20
>  #include <dt-bindings/reset/starfive,jh7110-crg.h>
> @@ -33,14 +35,15 @@ static int jh7110_reset_probe(struct auxiliary_device=
 *adev,
>  			      const struct auxiliary_device_id *id)
>  {
>  	struct jh7110_reset_info *info =3D (struct jh7110_reset_info *)(id->dri=
ver_data);
> -	void __iomem **base =3D (void __iomem **)dev_get_drvdata(adev->dev.pare=
nt);
> +	struct jh71x0_reset_adev *rdev =3D to_jh71x0_reset_adev(adev);
> +	void __iomem *base =3D rdev->base;
> =20
>  	if (!info || !base)
>  		return -ENODEV;
> =20
>  	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_=
node,
> -					      *base + info->assert_offset,
> -					      *base + info->status_offset,
> +					      base + info->assert_offset,
> +					      base + info->status_offset,
>  					      NULL,
>  					      info->nr_resets,
>  					      NULL);
> diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/s=
tarfive/reset-starfive-jh71x0.h
> new file mode 100644
> index 000000000000..47b486ececc5
> --- /dev/null
> +++ b/include/soc/starfive/reset-starfive-jh71x0.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_STARFIVE_RESET_JH71X0_H
> +#define __SOC_STARFIVE_RESET_JH71X0_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/compiler_types.h>
> +#include <linux/container_of.h>
> +
> +struct jh71x0_reset_adev {
> +	void __iomem *base;
> +	struct auxiliary_device adev;
> +};
> +
> +#define to_jh71x0_reset_adev(_adev) \
> +	container_of((_adev), struct jh71x0_reset_adev, adev)
> +
> +#endif
>=20
> base-commit: 601e5d464d535d655917c2cfb29c394d367fb676
> --=20
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>=20

--I1j3s3ZljXJDf82V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDhzoAAKCRB4tDGHoIJi
0sA4AP9acYTumlsES3SLIP4sInlMum008L9XCOyMUSPRc2JkWgEAuIObflbqAfRA
A3iplNXu2FBLjFTI/fxjh/RqukwoQwM=
=cB+Y
-----END PGP SIGNATURE-----

--I1j3s3ZljXJDf82V--
