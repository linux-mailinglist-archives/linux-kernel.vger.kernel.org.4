Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96B6788CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjAWU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjAWU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:56:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F2360B0;
        Mon, 23 Jan 2023 12:56:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P12Sd5PqXz4y0l;
        Tue, 24 Jan 2023 07:56:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674507362;
        bh=eoK4hX06Tgqi8Ba+YSj4Fdh7a7Ml2qISzbV4BV9AUaI=;
        h=Date:From:To:Cc:Subject:From;
        b=nRguNp00MXTVJKU2+FSUEGYnOoyW6gXoDDdv+oya9dW6kQHQIFD+qd2GaDsHoM1+o
         O35ssULe7r7BJ6vtT6POxsNh4seF9w4jIRTMklc3L+H0fgsEn0i5T9cHxK06uk3U3k
         9TCNw0Xr7MiGdnihKaznq+3K12B5ba8oRbY3KMZFDDC0RbMo7EHfq+ArMfMPIVRkOR
         JO7wpzGT73fX6uMXfVkpWCW66svmJjHXNQ7RyGf44chraw4mne3ahfew84Mgj6uqyq
         dH+n2ttiupWncqfcKjXKPzM5VcZQTNvZvU7mUGtEIQA1J9Dl2ZccMm//vbEiVb0rya
         IxxQl06lm/E1w==
Date:   Tue, 24 Jan 2023 07:56:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio-brgl-fixes tree
Message-ID: <20230124075600.649bd7bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Awt7O9f_eRYXqqNa=3aXwxU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Awt7O9f_eRYXqqNa=3aXwxU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio-brgl-fixes tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/of_gpio.h:14,
                 from drivers/net/phy/mdio_bus.c:27:
include/linux/gpio/driver.h:782:68: error: parameter 4 ('lflags') has incom=
plete type
  782 |                                             enum gpio_lookup_flags =
lflags,
      |                                             ~~~~~~~~~~~~~~~~~~~~~~~=
^~~~~~
include/linux/gpio/driver.h:779:33: error: function declaration isn't a pro=
totype [-Werror=3Dstrict-prototypes]
  779 | static inline struct gpio_desc *gpiochip_request_own_desc(struct gp=
io_chip *gc,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  de5f701724ac ("gpiolib: fix linker errors when GPIOLIB is disabled")

I have used the gpio-brgl-fixes tree from next-20210123 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Awt7O9f_eRYXqqNa=3aXwxU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPO9GAACgkQAVBC80lX
0GxgTwf/ZuwW2iZVbTgRENWUZeD96uL2xieSUDb8XO8XMCQ7VQtg+u1Hg6O/7SD6
SOKTFYgo5NdYbLSd91goMU1a810gOHmAte1fI/FheXmuiEnhtiHKgfSJmPcjcDKf
auPAVYVOeNgieEOvicaztqy431ezATf02Hhje8HsY8IKy01EHL6hzc+sfs7vdFRj
vrODojFaC4V4GI0sYdyIWNGmd0bHXo+Q+8n67VJFxcNKy74l2dklNhe+WaMXawMs
SUw8ov9H0ZE3X8raYYM3rywxqSezMLSjGOsIZX9pR9ChwpOlBes5rVVyDQDNg3Vy
SpSnmOX4HjLQbg2YaXBWLxke4dm42w==
=KkyY
-----END PGP SIGNATURE-----

--Sig_/Awt7O9f_eRYXqqNa=3aXwxU--
