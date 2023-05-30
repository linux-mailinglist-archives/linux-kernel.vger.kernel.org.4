Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4B715474
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjE3ETa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjE3ETZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:19:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0954E4;
        Mon, 29 May 2023 21:19:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVfKw1znBz4x1f;
        Tue, 30 May 2023 14:19:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685420358;
        bh=IgPFSWN81Jg+HN5A3WReGjNgtUf7bYaVyzuBPljjy44=;
        h=Date:From:To:Cc:Subject:From;
        b=s+q4HRV6NN72WOgKgYWC90pj89yF6JZMkGlK0W1VfDaXw9ovUwOXxfquF3+remO16
         5+ISrGJMw6FUisv6Uo5BHR6YVKqzVrYcV+s0/puwwWU3TDRKCsHHBVgHohfoY9LCjp
         W+bHj1Ab9Gr08KrThcbIHnPr8zwD2STjyd/ND3UZvbHpo8cA7nrUvlMI5PDmQXyxdU
         7VqZG6fnvWeOnN7H71jBP0ez1G27Ic4mh6CU344VXFFHxeCipdOWPCJTVqUFbKINTO
         4323wmhdh0dKPd9RapX6xEhUraNmqFNOg/k9g3DhI3tyXR9jtr5XApUUotqNFP12gp
         iropQiUKqLP6g==
Date:   Tue, 30 May 2023 14:19:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the gpio-brgl tree with the arm-soc
 tree
Message-ID: <20230530141914.672a8e59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pQLIuOt+9iItAs.qU.1qTRi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pQLIuOt+9iItAs.qU.1qTRi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio-brgl tree got a conflict in:

  drivers/gpio/gpio-twl4030.c

between commit:

  d5f4fa60d63a ("ARM/gpio: Push OMAP2 quirk down into TWL4030 driver")

from the arm-soc tree and commit:

  fbc8ab2ccd85 ("gpio: twl4030: Use devm_gpiochip_add_data() to simplify re=
move path")

from the gpio-brgl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpio/gpio-twl4030.c
index 446599ac234a,3708ed2314e8..000000000000
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@@ -490,30 -492,9 +490,18 @@@ static struct twl4030_gpio_platform_dat
  	return omap_twl_info;
  }
 =20
- /* Cannot use as gpio_twl4030_probe() calls us */
- static int gpio_twl4030_remove(struct platform_device *pdev)
- {
- 	struct gpio_twl4030_priv *priv =3D platform_get_drvdata(pdev);
-=20
- 	gpiochip_remove(&priv->gpio_chip);
-=20
- 	/* REVISIT no support yet for deregistering all the IRQs */
- 	WARN_ON(!is_module());
- 	return 0;
- }
-=20
 +/* Called from the registered devm action */
 +static void gpio_twl4030_power_off_action(void *data)
 +{
 +	struct gpio_desc *d =3D data;
 +
 +	gpiod_unexport(d);
 +	gpiochip_free_own_desc(d);
 +}
 +
  static int gpio_twl4030_probe(struct platform_device *pdev)
  {
 -	struct twl4030_gpio_platform_data *pdata =3D dev_get_platdata(&pdev->dev=
);
 +	struct twl4030_gpio_platform_data *pdata;
  	struct device_node *node =3D pdev->dev.of_node;
  	struct gpio_twl4030_priv *priv;
  	int ret, irq_base;
@@@ -586,38 -569,19 +574,35 @@@ no_irqs
  	if (ret < 0) {
  		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
  		priv->gpio_chip.ngpio =3D 0;
- 		gpio_twl4030_remove(pdev);
- 		goto out;
+ 		return ret;
  	}
 =20
 -	if (pdata->setup) {
 -		int status;
 +	/*
 +	 * Special quirk for the OMAP3 to hog and export a WLAN power
 +	 * GPIO.
 +	 */
 +	if (IS_ENABLED(CONFIG_ARCH_OMAP3) &&
 +	    of_machine_is_compatible("compulab,omap3-sbc-t3730")) {
 +		struct gpio_desc *d;
 +
 +		d =3D gpiochip_request_own_desc(&priv->gpio_chip,
 +						 2, "wlan pwr",
 +						 GPIO_ACTIVE_HIGH,
 +						 GPIOD_OUT_HIGH);
 +		if (IS_ERR(d))
 +			return dev_err_probe(&pdev->dev, PTR_ERR(d),
 +					     "unable to hog wlan pwr GPIO\n");
 +
 +		gpiod_export(d, 0);
 +
 +		ret =3D devm_add_action_or_reset(&pdev->dev, gpio_twl4030_power_off_act=
ion, d);
 +		if (ret)
 +			return dev_err_probe(&pdev->dev, ret,
 +					     "failed to install power off handler\n");
 =20
 -		status =3D pdata->setup(&pdev->dev, priv->gpio_chip.base,
 -				      TWL4030_GPIO_MAX);
 -		if (status)
 -			dev_dbg(&pdev->dev, "setup --> %d\n", status);
  	}
 =20
- 	platform_set_drvdata(pdev, priv);
- out:
- 	return ret;
+ 	return 0;
  }
 =20
  static const struct of_device_id twl_gpio_match[] =3D {

--Sig_/pQLIuOt+9iItAs.qU.1qTRi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1eUIACgkQAVBC80lX
0Gz+EAf9HqEZqctN4oyGIFxWDtA6uLQSJUr2IVE3nA2eOv//lC8jwLPf9cPvmaEd
tw6+H402lO4OF7BcRvoMzvr0B7Rb47zuBOcM7vwh6JU5Z1SxXYaG9Jd/hnMcBmR/
usaKozanhytXpYrZiAykT9xLw6LB9ysv5yRFz4T0ib2O4zC0hgXzJAjYJaNrsO7X
OOT8LodqXM5xB5qqorIa+CdE2/pKyhifAcXRuHkNz0/H85AV3PIkG54WAAolqVKG
CHmzaO+C3AxPweDtn+utBTiYjvQVZdi3eDAKzuhLKvZ8wrQPU6z+UB/L1FkCZbfS
C52C+txPF45cWp9jeLJqVrfDYwrxMw==
=AQWG
-----END PGP SIGNATURE-----

--Sig_/pQLIuOt+9iItAs.qU.1qTRi--
