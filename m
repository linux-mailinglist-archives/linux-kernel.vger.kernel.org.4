Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AE63556B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiKWJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiKWJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:20:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A52189F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:20:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so27239337lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/uGIrK5/QpagY3HfNVJOY+gWJKGB/HD78CMIt9WOjU=;
        b=KC/uAbtf/fpzdr8ScJNAcu/GE5frX/DdXyCvUQIscDw5gJP8G2QOgt54qmPjjAGPOk
         UKJ5um2ExWJWPFtLH+P3I16ylTheDritPYFQYauSKtJyxZvI9QKZR/6eUExCIqyZBoZA
         yHsJqo7QSdwTFjhmnErKDXzvfwXZATR8JqOz1wioWU0n6bcDuCcQq5hQbID2ZVYowatV
         1WRYgc76BIKrn/9kuRjGUIvd1VENoLXRD1psfZwCgS+1tSQL8qNsuXhg0EDOvOswnHM8
         AqaESGgqr6bQHSrRib9itEfpgyUKQGdU6baXbengOVgLm+Tm8PjxzKETzJItsDg7GVXk
         /B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/uGIrK5/QpagY3HfNVJOY+gWJKGB/HD78CMIt9WOjU=;
        b=uh+JzL//66XzmzTL6DPxsRDjuiCa7YBKlNtC9x7/czdgp7TqQN483dt1veK6qm/5k+
         FQxUY6WB4Zmx18++7NhtrHxOz0+mMowEQTx06WzLoIv79Fe3H/VF2MnaNXYADz4kMfMc
         cMWNKGsKt//7bOoYim2jSk7OaKqdOMxqV6fXQ3Vp/hHSTZQTew/PR4027vEb1pT9y+vs
         c/2DV3jZYFyNY0asLafPCX8OslfyMw/tx0I1/TRimN5H5CiRJFD/1p4xYJNbt839Uyjd
         N4VSOPvBTqHy36zr0BIwnJzJklARZywhNeH/ZqO7kAdaQ6SlKPaSyvBwU86mvHOOGxs8
         6wsw==
X-Gm-Message-State: ANoB5pl8Gaf+WFHAssRvkcDcSeQ5zhIu5hKC3PhfxhxOxaBJQnP8Skqx
        uleAeK7b9KS6eIKDkYe78niR/xEoxrg=
X-Google-Smtp-Source: AA0mqf6s02c3rpau1p+PHdEzgNituFoGKGjD/O4Wan68VIGdGqHC8jjUpqHwhuKKcq6GgWEnYg5Scg==
X-Received: by 2002:ac2:58d9:0:b0:4b3:ccea:9b2e with SMTP id u25-20020ac258d9000000b004b3ccea9b2emr10242849lfo.379.1669195206971;
        Wed, 23 Nov 2022 01:20:06 -0800 (PST)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m19-20020a195213000000b004a46f92a15bsm2850935lfb.41.2022.11.23.01.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:20:06 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:19:49 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: rohm-bd*: Use dev_err_probe()
Message-ID: <Y33lte0PKd2u6dyR@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vdHUOjEUZjKFGKRe"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vdHUOjEUZjKFGKRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The dev_err_probe() has (at least) following benefits over dev_err()
when printing an error print for a failed function call at a device
driver probe:
	- Omit error level print if error is 'EPRBE_DEFER'
	- Standardized print format for returned error
	- return the error value allowing shortening calls like:

	if (ret) {
		dev_err(...);
		return ret;
	}

	to

	if (ret)
		return dev_err_probe(...);

Convert the ROHM BD71828, ROHM BD718x7 and ROHM BD9576 core drivers to
use the dev_err_probe() when returned error is not hard-coded constant.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd71828.c | 23 ++++++++++-------------
 drivers/mfd/rohm-bd718x7.c | 21 ++++++++-------------
 drivers/mfd/rohm-bd9576.c  | 17 ++++++++---------
 3 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 714d9fcbf07b..ae5430500599 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -515,27 +515,24 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	}
=20
 	regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "Failed to initialize Regmap\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
=20
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
 				       IRQF_ONESHOT, 0, irqchip, &irq_data);
-	if (ret) {
-		dev_err(&i2c->dev, "Failed to add IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to add IRQ chip\n");
=20
 	dev_dbg(&i2c->dev, "Registered %d IRQs for chip\n",
 		irqchip->num_irqs);
=20
 	if (button_irq) {
 		ret =3D regmap_irq_get_virq(irq_data, button_irq);
-		if (ret < 0) {
-			dev_err(&i2c->dev, "Failed to get the power-key IRQ\n");
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&i2c->dev, ret,
+					     "Failed to get the power-key IRQ\n");
=20
 		button.irq =3D ret;
 	}
@@ -547,7 +544,7 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
 				   NULL, 0, regmap_irq_get_domain(irq_data));
 	if (ret)
-		dev_err(&i2c->dev, "Failed to create subdevices\n");
+		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
=20
 	return ret;
 }
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index bfd81f78beae..1c0f6419ee4f 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -158,18 +158,15 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
=20
 	regmap =3D devm_regmap_init_i2c(i2c, &bd718xx_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
=20
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
 				       IRQF_ONESHOT, 0, &bd718xx_irq_chip,
 				       &irq_data);
-	if (ret) {
-		dev_err(&i2c->dev, "Failed to add irq_chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to add irq_chip\n");
=20
 	ret =3D bd718xx_init_press_duration(regmap, &i2c->dev);
 	if (ret)
@@ -177,10 +174,8 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
=20
 	ret =3D regmap_irq_get_virq(irq_data, BD718XX_INT_PWRBTN_S);
=20
-	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to get the IRQ\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&i2c->dev, ret, "Failed to get the IRQ\n");
=20
 	button.irq =3D ret;
=20
@@ -188,7 +183,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 				   mfd, cells, NULL, 0,
 				   regmap_irq_get_domain(irq_data));
 	if (ret)
-		dev_err(&i2c->dev, "Failed to create subdevices\n");
+		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
=20
 	return ret;
 }
diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index f37cd4f27aeb..c421867af6c9 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -122,10 +122,9 @@ static int bd957x_i2c_probe(struct i2c_client *i2c,
 	}
=20
 	regmap =3D devm_regmap_init_i2c(i2c, &bd957x_regmap);
-	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "Failed to initialize Regmap\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
=20
 	/*
 	 * BD9576 behaves badly. It kepts IRQ line asserted for the whole
@@ -146,10 +145,10 @@ static int bd957x_i2c_probe(struct i2c_client *i2c,
 		ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
 					       IRQF_ONESHOT, 0,
 					       &bd9576_irq_chip, &irq_data);
-		if (ret) {
-			dev_err(&i2c->dev, "Failed to add IRQ chip\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret,
+					     "Failed to add IRQ chip\n");
+
 		domain =3D regmap_irq_get_domain(irq_data);
 	} else {
 		ret =3D regmap_update_bits(regmap, BD957X_REG_INT_MAIN_MASK,
@@ -163,7 +162,7 @@ static int bd957x_i2c_probe(struct i2c_client *i2c,
 	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, cells,
 				   num_cells, NULL, 0, domain);
 	if (ret)
-		dev_err(&i2c->dev, "Failed to create subdevices\n");
+		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
=20
 	return ret;
 }

base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
--=20
2.38.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--vdHUOjEUZjKFGKRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN95agACgkQeFA3/03a
ocWb4Af9HokFcphcnvoevA62CuYL24TGDnxlx8uuU5OqwyPJA7em3IWIbmnYLiAH
EcasPiFfIVAtYmVlEolBvMG1xLjfK7xs41mTVcYmqYKLxnd10e9kUpPXByMhTWx8
H+am3Sss1T7HW7jVuCwdEIVdjWg2T2eRQkWrDudchTzy5UtIgg7o5b3wIlLub3VL
mSA5RKuH4n1w+cde7XZSe5N0xKB4cbkTql5eLtZQzKlFFucAi7SseNz685OUxrWl
EwV/mPoTKbdaP0PdWbbiLbX1g8PqXWI8BPUGvv9nISnO1FgXlq60q8XVDtgOu1Ry
+04bOvQYBiKi0KcD7fW5wceKUALySA==
=yJyz
-----END PGP SIGNATURE-----

--vdHUOjEUZjKFGKRe--
