Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710FB6C5BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCWB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DE26B2;
        Wed, 22 Mar 2023 18:29:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Phnn62h0sz4x4r;
        Thu, 23 Mar 2023 12:29:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679534954;
        bh=+VFAB2pMsm05yxN6D2aQPmwkIZna1h6eOO+0BZM5wYk=;
        h=Date:From:To:Cc:Subject:From;
        b=Nb7Ys4y/iTXep9YbrWk5JqeGLgXHu6bDIVPWec1nCE+d9VlKJnyBUc8KFEaspCzrq
         Ojnmm0oA+kpr+Fhk4ZF9ubgkZznJWqsdJzcbP5UDGL9fW6wK+DHuIjAvBUGDzIKvm0
         4ao1Wt5buwf9Tb9X9Xb/34XC8LvydKeWw8GJ9vU3IDrsx9NC5rSIAQ7XoGM5xszmvc
         B3blP7yT46sGJADEO7koDYiVaOH5WSo3XL8NWX96FZD9AiaAleKYwT240ftTcZEcje
         tzDCmv1GUS1ibTpiQVFLTBgvSuzu9osRETkIrcNW3EGZsSMlOgEAVFF0YOOqpHv0WO
         MBaMbinLarnVw==
Date:   Thu, 23 Mar 2023 12:29:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20230323122913.4f0410b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sg8vRiHpwKXiOwck02eqFc4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sg8vRiHpwKXiOwck02eqFc4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio-brgl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpio/gpio-pci-idio-16.c:32:30: error: field 'state' has incomplete =
type
   32 |         struct idio_16_state state;
      |                              ^~~~~
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_direction':
drivers/gpio/gpio-pci-idio-16.c:39:13: error: implicit declaration of funct=
ion 'idio_16_get_direction'; did you mean 'idio_16_gpio_get_direction'? [-W=
error=3Dimplicit-function-declaration]
   39 |         if (idio_16_get_direction(offset))
      |             ^~~~~~~~~~~~~~~~~~~~~
      |             idio_16_gpio_get_direction
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get':
drivers/gpio/gpio-pci-idio-16.c:62:16: error: implicit declaration of funct=
ion 'idio_16_get'; did you mean 'idio_16_gpio_get'? [-Werror=3Dimplicit-fun=
ction-declaration]
   62 |         return idio_16_get(idio16gpio->reg, &idio16gpio->state, off=
set);
      |                ^~~~~~~~~~~
      |                idio_16_gpio_get
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_multiple':
drivers/gpio/gpio-pci-idio-16.c:70:9: error: implicit declaration of functi=
on 'idio_16_get_multiple'; did you mean 'idio_16_gpio_get_multiple'? [-Werr=
or=3Dimplicit-function-declaration]
   70 |         idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, m=
ask, bits);
      |         ^~~~~~~~~~~~~~~~~~~~
      |         idio_16_gpio_get_multiple
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_set':
drivers/gpio/gpio-pci-idio-16.c:79:9: error: implicit declaration of functi=
on 'idio_16_set'; did you mean 'idio_16_gpio_set'? [-Werror=3Dimplicit-func=
tion-declaration]
   79 |         idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, va=
lue);
      |         ^~~~~~~~~~~
      |         idio_16_gpio_set
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_set_multiple':
drivers/gpio/gpio-pci-idio-16.c:87:9: error: implicit declaration of functi=
on 'idio_16_set_multiple'; did you mean 'idio_16_gpio_set_multiple'? [-Werr=
or=3Dimplicit-function-declaration]
   87 |         idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, m=
ask, bits);
      |         ^~~~~~~~~~~~~~~~~~~~
      |         idio_16_gpio_set_multiple
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_mask':
drivers/gpio/gpio-pci-idio-16.c:106:45: error: invalid use of undefined typ=
e 'struct idio_16'
  106 |                 iowrite8(0, &idio16gpio->reg->irq_ctl);
      |                                             ^~
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_unmask':
drivers/gpio/gpio-pci-idio-16.c:129:41: error: invalid use of undefined typ=
e 'struct idio_16'
  129 |                 ioread8(&idio16gpio->reg->irq_ctl);
      |                                         ^~
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_handler':
drivers/gpio/gpio-pci-idio-16.c:164:46: error: invalid use of undefined typ=
e 'struct idio_16'
  164 |         irq_status =3D ioread8(&idio16gpio->reg->irq_status);
      |                                              ^~
drivers/gpio/gpio-pci-idio-16.c:178:37: error: invalid use of undefined typ=
e 'struct idio_16'
  178 |         iowrite8(0, &idio16gpio->reg->in0_7);
      |                                     ^~
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_irq_init_hw':
drivers/gpio/gpio-pci-idio-16.c:198:37: error: invalid use of undefined typ=
e 'struct idio_16'
  198 |         iowrite8(0, &idio16gpio->reg->irq_ctl);
      |                                     ^~
drivers/gpio/gpio-pci-idio-16.c:199:37: error: invalid use of undefined typ=
e 'struct idio_16'
  199 |         iowrite8(0, &idio16gpio->reg->in0_7);
      |                                     ^~
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_probe':
drivers/gpio/gpio-pci-idio-16.c:232:37: error: invalid use of undefined typ=
e 'struct idio_16'
  232 |         iowrite8(0, &idio16gpio->reg->filter_ctl);
      |                                     ^~
drivers/gpio/gpio-pci-idio-16.c:248:9: error: implicit declaration of funct=
ion 'idio_16_state_init'; did you mean 'file_ra_state_init'? [-Werror=3Dimp=
licit-function-declaration]
  248 |         idio_16_state_init(&idio16gpio->state);
      |         ^~~~~~~~~~~~~~~~~~
      |         file_ra_state_init
drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get':
drivers/gpio/gpio-pci-idio-16.c:63:1: error: control reaches end of non-voi=
d function [-Werror=3Dreturn-type]
   63 | }
      | ^

Caused by commit

  473b79057bbd ("gpio: idio-16: Remove unused legacy interface")

I have used the gpio-brgl tree from next-20230322 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sg8vRiHpwKXiOwck02eqFc4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbq2kACgkQAVBC80lX
0GwBmAf9FN9KTFSYvy8Yj//my0QFXnFGjK7oA9+s9RbcD6dm8hhGy8IQWaWO2Tfm
JI+/xyqSfufwIumXb5mH5dslIatiE8+meR1hrvaGQ9o/ASd5uwQorCrwJwvEfyqt
SeEZx0GYJ6SJmpLsGlqzpTExe9stsPKtHDtmVYgIHk13gPdZNlTOvOT6ePKpS53E
xDFwI287t3GxNsDHsh2tmtR7igl4ZYgPy6VYQxePRtTDw6ExKTeI27Is5EYRjOZk
43L6lKxPIGkY/hznVBY3iHSq5o6FK5WxcMvU7WhOgRJ7hqAZtM54ACPl8ueeYZmi
tIT5chxLE07dUEPc90lBNwt6HbBeFA==
=E1vA
-----END PGP SIGNATURE-----

--Sig_/Sg8vRiHpwKXiOwck02eqFc4--
