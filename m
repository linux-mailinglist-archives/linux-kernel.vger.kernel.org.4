Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE16D8D22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDFCBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFCBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:01:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38B49CA;
        Wed,  5 Apr 2023 19:01:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsPqG3J9sz4xDt;
        Thu,  6 Apr 2023 12:00:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680746458;
        bh=607S+2cLm7jn5sIpFzj5mU4PWCdG+/tkOtlmiB072Bk=;
        h=Date:From:To:Cc:Subject:From;
        b=mqlDValoONH2hHkdpU6TIBefJscNKb8g+3vesYG1EhHdXdSe32sOC8RXoDKmWOZhR
         4NODFygIOb3tzp0oHoT5qfxFqHC37Ximj985n19fPsVRiEBuslRN214kY6gD5kwFxa
         tPvYF12LDu2xrALw1o4q+8tx/cDhi3QUO9KdtIelzY+YEy59Bo6Lb1G1haDb/TNr6l
         928r3FxWxKgs2Q4L26cogEvkC005f2xsmAMsXLIKogdsC8c+dsSq8d8JHZRgY9XqrA
         Lj51E8NcHKcVGL8+3O2CdGTZTNFQSLaRTheeCyWXK1+6BY2ROAPdT+otrO6cXr5+Gg
         VWdvj9h4JfK7Q==
Date:   Thu, 6 Apr 2023 12:00:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mfd tree
Message-ID: <20230406120055.11fcfe5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mvKyDBugPa/ArnB/8ZWRUbo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mvKyDBugPa/ArnB/8ZWRUbo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/mfd/qcom-pm8008.c:135:35: error: initialization of 'int (*)(unsigne=
d int **, unsigned int,  const struct regmap_irq *, int,  void *)' from inc=
ompatible pointer type 'int (*)(unsigned int **, unsigned int,  const struc=
t regmap_irq *, int)' [-Werror=3Dincompatible-pointer-types]
  135 |         .set_type_config        =3D pm8008_set_type_config,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/qcom-pm8008.c:135:35: note: (near initialization for 'pm8008_ir=
q_chip.set_type_config')

Caused by commit

  72a8a08b0c62 ("mfd: qcom-pm8008: Convert irq chip to config regs")

interacting with commit

  7697c64b9e49 ("regmap: Pass irq_drv_data as a parameter for set_type_conf=
ig()")

from the regmap tree.

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 6 Apr 2023 11:37:44 +1000
Subject: [PATCH] fixup for "mfd: qcom-pm8008: Convert irq chip to config re=
gs"

interacting with "regmap: Pass irq_drv_data as a parameter for set_type_con=
fig()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mfd/qcom-pm8008.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index a33fbc42ac8e..e60c838a78c1 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -85,7 +85,8 @@ static unsigned int pm8008_get_irq_reg(struct regmap_irq_=
chip_data *data,
 }
=20
 static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
-				  const struct regmap_irq *irq_data, int idx)
+				  const struct regmap_irq *irq_data, int idx,
+				  void *irq_drv_data)
 {
 	switch (type) {
 	case IRQ_TYPE_EDGE_FALLING:
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/mvKyDBugPa/ArnB/8ZWRUbo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQuJ9cACgkQAVBC80lX
0GxjxAf/Vc1lKpnpAQaX8Tfo8qUzyWqESkMVIzryq16rPMpQFBSGcCJhaOtn6YHg
cvClXHZ/eICToNzt/tzcyjda2zg/xxPDWChpjzck9czst9m33EfM0NfOHR0Bvvhb
kFLoZH/qFfYfVEjLc0V7iVSwv5W2/tsYfzQvxKI9Kzw3A7Oq2MyO38+e9qMyi/cy
zDbsV/4wiBmPeRAVP4Yjgqpz+SlsRXWueKLj/EymZUxYJ9c+yE1pDxDirkeefuHS
YXGVTtj/gJEfmyOoszY59JXAbwMp6A0XSpOJWGkpWQgmLmt7oVpW+CxjJn1y8/0N
klYtMkR47enCKyvVJkSoOPzAxA0PIg==
=dupP
-----END PGP SIGNATURE-----

--Sig_/mvKyDBugPa/ArnB/8ZWRUbo--
