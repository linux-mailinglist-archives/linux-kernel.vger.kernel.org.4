Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D825A643A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiLFBNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLFBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:13:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C31C43A;
        Mon,  5 Dec 2022 17:13:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NR2VV0gmnz4xG6;
        Tue,  6 Dec 2022 12:13:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670289219;
        bh=XZaVH3uav8QW5c1zAbnSpShdGDyJPaS5c3+u/jlf+zw=;
        h=Date:From:To:Cc:Subject:From;
        b=CWcGf68Om5ueioQ7Ijp1+P0OaWg+hDkusBofES08YSKgwjpHcXoCRYozNfeXNAOtk
         inGI+SaV9xch2gm909qWGfhQQHUu+lhrrJw1tPGQJ4+54XT59HJgBv0znbSoX5XXtV
         U2SldrGIgeidAtG/K2q3G+wAW/uPTWIKpS1qfRNDbAwqq4a4aY3xGR65JoCdfVsqIR
         VNT5lDWDakaXs5LzGmItR8+iwPyLnHyohTPnc0csRaBti+75Km3Dz2vJ4Sd/KgZYfA
         l0LBZuj9oapQcLJX1KjhwhH3lxlx8Mjt+5nTbylIa4U3tRZlCKLPzS5G9RKVAU0KfI
         kcl1cxD1cfeVw==
Date:   Tue, 6 Dec 2022 12:13:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the arm-soc tree
Message-ID: <20221206121336.474457bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KOqh2lCuC6HEK63tLTN+oxC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KOqh2lCuC6HEK63tLTN+oxC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  drivers/soc/fsl/qe/gpio.c

between commits:

  84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
  66310b5a0fc1 ("soc: fsl: qe: request pins non-exclusively")

from the arm-soc tree and commit:

  c9eb6e546a23 ("soc: fsl: qe: Switch to use fwnode instead of of_node")

from the pinctrl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/soc/fsl/qe/gpio.c
index 1440922341d8,9abb45ab138b..000000000000
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@@ -13,11 -13,14 +13,13 @@@
  #include <linux/err.h>
  #include <linux/io.h>
  #include <linux/of.h>
 -#include <linux/of_gpio.h>
 +#include <linux/of_gpio.h>	/* for of_mm_gpio_chip */
 +#include <linux/gpio/consumer.h>
  #include <linux/gpio/driver.h>
 -/* FIXME: needed for gpio_to_chip() get rid of this */
 -#include <linux/gpio.h>
  #include <linux/slab.h>
  #include <linux/export.h>
+ #include <linux/property.h>
+=20
  #include <soc/fsl/qe/qe.h>
 =20
  struct qe_gpio_chip {
@@@ -187,16 -181,8 +189,16 @@@ struct qe_pin *qe_pin_request(struct de
  		goto err0;
  	}
 =20
 +	qe_pin->controller =3D gpiochip_get_data(gc);
 +	/*
 +	 * FIXME: this gets the local offset on the gpio_chip so that the driver
 +	 * can manipulate pin control settings through its custom API. The real
 +	 * solution is to create a real pin control driver for this.
 +	 */
 +	qe_pin->num =3D gpio_num - gc->base;
 +
- 	if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
+ 	if (!fwnode_device_is_compatible(gc->fwnode, "fsl,mpc8323-qe-pario-bank"=
)) {
 -		pr_debug("%s: tried to get a non-qe pin\n", __func__);
 +		dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
  		err =3D -EINVAL;
  		goto err0;
  	}

--Sig_/KOqh2lCuC6HEK63tLTN+oxC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOOl0EACgkQAVBC80lX
0GwtkQf+Ji/VPu3RB70iKdaEN1TUyi8Xpd9nQtFKNNvGVVASlamI/IRH2MgBwCRz
OOxgB88Rul1PjAHme5ar8Mil6tsSwCSH9/f8Q7fOjfZjv6Gbt3MqAIjN+D/WvGCQ
Zwqql07hjnUEdf5yRuOllLX6zwwf3jH1z7QRz7+LIgypiG/GrAdRtfRyovQW8QTe
k4xCpLuwRAhE7PGiEqB1V0zELfTvhjwbEWbURPT89NBGkECXdiCooO8uNkKt+eTt
GYzLZmg87cpo2pbtIt/s3Vy8bvwqG5Ct/HVfBDbxMYtllKlchVR/FD7LmWuVnnp6
P8wWhK52Oii83+e1OokEk4x8pFWRaQ==
=IzJa
-----END PGP SIGNATURE-----

--Sig_/KOqh2lCuC6HEK63tLTN+oxC--
