Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F49602111
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJRCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJRCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:20:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27054456B;
        Mon, 17 Oct 2022 19:20:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MryHs6dt4z4x1G;
        Tue, 18 Oct 2022 13:20:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666059610;
        bh=D2YrQD6743OFChT+XPGfXNYgm7tOKrWKDP0WxcTqG38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dWNbUgsN86plj64oBssROgAWQYxt7suOVAVFNrLOJCQrZQc4FaFFotiERO4u/I1fb
         W9e9au2nByvQox8XC0mHNYIMrOSLBJG3KitPsW5eD/6SEtNFYsejsXO+YxCJCEzyCN
         d0GDsV+sLZm2b8EB/thr6tAu2nopN9+NW8CpFjqwi7qMaioYj1kSVleIcqGixj/XfZ
         ZacDkjM/AJ6ogVydcWqFNJHpnoK+HbGLKElOSO1MmrIRnN1tBw3CEimlptk8QSvOgH
         mMSg3Ot0nqLu9jnRGRtm/kSIxGG+iC0/DOrX6HEvBSCrgnbGBc3nRwR+/tY2FLpWns
         KNCJWrD6CDW3A==
Date:   Tue, 18 Oct 2022 13:20:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pinctrl-intel tree
Message-ID: <20221018131942.487808a5@oak.ozlabs.ibm.com>
In-Reply-To: <20221018131330.75fc1807@canb.auug.org.au>
References: <20221018131330.75fc1807@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yU8t3dPJWO_Xe_UTBTpMJx6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yU8t3dPJWO_Xe_UTBTpMJx6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 18 Oct 2022 13:13:30 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the pinctrl-intel tree, today's linux-next build (arm64
> defconfig) failed like this:

drivers/pinctrl/pinctrl-zynqmp.c:483:21: error: variable 'zynqmp_pinconf_op=
s' has initializer but incomplete type
  483 | static const struct pinconf_ops zynqmp_pinconf_ops =3D {
      |                     ^~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:484:10: error: 'const struct pinconf_ops' =
has no member named 'is_generic'
  484 |         .is_generic =3D true,
      |          ^~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:484:23: warning: excess elements in struct=
 initializer
  484 |         .is_generic =3D true,
      |                       ^~~~
drivers/pinctrl/pinctrl-zynqmp.c:484:23: note: (near initialization for 'zy=
nqmp_pinconf_ops')
drivers/pinctrl/pinctrl-zynqmp.c:485:10: error: 'const struct pinconf_ops' =
has no member named 'pin_config_get'
  485 |         .pin_config_get =3D zynqmp_pinconf_cfg_get,
      |          ^~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:485:27: warning: excess elements in struct=
 initializer
  485 |         .pin_config_get =3D zynqmp_pinconf_cfg_get,
      |                           ^~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:485:27: note: (near initialization for 'zy=
nqmp_pinconf_ops')
drivers/pinctrl/pinctrl-zynqmp.c:486:10: error: 'const struct pinconf_ops' =
has no member named 'pin_config_set'
  486 |         .pin_config_set =3D zynqmp_pinconf_cfg_set,
      |          ^~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:486:27: warning: excess elements in struct=
 initializer
  486 |         .pin_config_set =3D zynqmp_pinconf_cfg_set,
      |                           ^~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:486:27: note: (near initialization for 'zy=
nqmp_pinconf_ops')
drivers/pinctrl/pinctrl-zynqmp.c:487:10: error: 'const struct pinconf_ops' =
has no member named 'pin_config_group_set'
  487 |         .pin_config_group_set =3D zynqmp_pinconf_group_set,
      |          ^~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:487:33: warning: excess elements in struct=
 initializer
  487 |         .pin_config_group_set =3D zynqmp_pinconf_group_set,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynqmp.c:487:33: note: (near initialization for 'zy=
nqmp_pinconf_ops')
drivers/pinctrl/pinctrl-zynqmp.c:483:33: error: storage size of 'zynqmp_pin=
conf_ops' isn't known
  483 | static const struct pinconf_ops zynqmp_pinconf_ops =3D {
      |                                 ^~~~~~~~~~~~~~~~~~

> Presumably caused by commit
>=20
>   e6b665a1c9ae ("pinctrl: Clean up headers")
>=20
> I have applied the following patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 18 Oct 2022 13:06:39 +1100
> Subject: [PATCH] fix up for "pinctrl: Clean up headers"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pinctrl/pinctrl-zynqmp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-z=
ynqmp.c
> index 1a94db1ffa4f..f2be341f73e1 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -18,6 +18,7 @@
>  #include <linux/firmware/xlnx-zynqmp.h>
> =20
>  #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>

--=20
Cheers,
Stephen Rothwell

--Sig_/yU8t3dPJWO_Xe_UTBTpMJx6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNODVgACgkQAVBC80lX
0Gwjkwf+IMDxAaB6do4F6g1omw7zZGgTZu9zbr6VkzSPogcJHBOAqa2UC/TnFdOi
WY/Hno0QniboMQAvk0hd8T2i8htjQB1yy+gKnlJGlkyk5wqnEVUbXf8n2e/1kVw5
/x91heCpysvqR1Ulo2Ye5I7U4IWjMDIBfUpF4+kh8W9+nQZeLN/o6CLLPs57DSOO
g+GSOqaa5Xel8OYujLIiGt79DCN4NaHiIhHJGR3xN6LATS3WDJAws9hCWCc+jDL8
f3Jj1nF5l8wH+V3FXB0N8eVW6PPyPB9SeMswGvSF8vDFw998SizoK46VdoTcPeOe
xjuvbX0qfOfTqO0MemG3EaaYfzQeHQ==
=8aKH
-----END PGP SIGNATURE-----

--Sig_/yU8t3dPJWO_Xe_UTBTpMJx6--
