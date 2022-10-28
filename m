Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDFF6115F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJ1PfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ1PfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:20 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80E5AA01;
        Fri, 28 Oct 2022 08:35:15 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F29EC1C09E5; Fri, 28 Oct 2022 17:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666971313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZ+XC4iEcro/8zXcMRHQx9f6mpwLNOhOuYFKcJdBGUA=;
        b=KyY770jITqm/kV0UkVD96zlokENQ8wQv5fmjhAsHoiAUv3+H95RR1GHp47r6vDXgzAWkoP
        jyKeT/+t7UX+Z1VKq+y8zSA34lBha8BTtH/ooGNPBDrMXmaWGrwCyWZfW0egCLBcRmNbRJ
        4NReokL4i9zkvQbKBEwzwrZ3KlDYiDA=
Date:   Fri, 28 Oct 2022 17:34:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Arne Staessen <a.staessen@televic.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: lp5523: fix out-of-bounds bug in lp5523_selftest()
Message-ID: <20221028153457.GA14936@duo.ucw.cz>
References: <20221028105643.45300-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20221028105643.45300-1-maarten.zanders@mind.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When not all LED channels of the led chip are configured, the
> sysfs selftest functionality gives erroneous results and tries to
> test all channels of the chip.
> There is a potential for LED overcurrent conditions since the
> test current will be set to values from out-of-bound regions.
>=20
> It is wrong to use pdata->led_config[i].led_current to skip absent
> channels as led_config[] only contains the configured LED channels.
>=20
> Instead of iterating over all the physical channels of the device,
> loop over the available LED configurations and use led->chan_nr to
> access the correct i2c registers. Keep the zero-check for the LED
> current as existing users might depend on this to disable a channel.

Thanks, applied, I'll push eventually.

I wonder, should we do these kind of actions on attribute _read_? I'd
preffer some kind of write action to trigger this.

Best regards,
								Pavel

> Reported-by: Arne Staessen <a.staessen@televic.com>
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---
>  drivers/leds/leds-lp5523.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
> index 369d40b0b65b..e08e3de1428d 100644
> --- a/drivers/leds/leds-lp5523.c
> +++ b/drivers/leds/leds-lp5523.c
> @@ -581,8 +581,8 @@ static ssize_t lp5523_selftest(struct device *dev,
>  	struct lp55xx_led *led =3D i2c_get_clientdata(to_i2c_client(dev));
>  	struct lp55xx_chip *chip =3D led->chip;
>  	struct lp55xx_platform_data *pdata =3D chip->pdata;
> -	int i, ret, pos =3D 0;
> -	u8 status, adc, vdd;
> +	int ret, pos =3D 0;
> +	u8 status, adc, vdd, i;
> =20
>  	mutex_lock(&chip->lock);
> =20
> @@ -612,20 +612,21 @@ static ssize_t lp5523_selftest(struct device *dev,
> =20
>  	vdd--;	/* There may be some fluctuation in measurement */
> =20
> -	for (i =3D 0; i < LP5523_MAX_LEDS; i++) {
> -		/* Skip non-existing channels */
> +	for (i =3D 0; i < pdata->num_channels; i++) {
> +		/* Skip disabled channels */
>  		if (pdata->led_config[i].led_current =3D=3D 0)
>  			continue;
> =20
>  		/* Set default current */
> -		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + i,
> +		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + led->chan_nr,
>  			pdata->led_config[i].led_current);
> =20
> -		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + i, 0xff);
> +		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + led->chan_nr,
> +			     0xff);
>  		/* let current stabilize 2 - 4ms before measurements start */
>  		usleep_range(2000, 4000);
>  		lp55xx_write(chip, LP5523_REG_LED_TEST_CTRL,
> -			     LP5523_EN_LEDTEST | i);
> +			     LP5523_EN_LEDTEST | led->chan_nr);
>  		/* ADC conversion time is 2.7 ms typically */
>  		usleep_range(3000, 6000);
>  		ret =3D lp55xx_read(chip, LP5523_REG_STATUS, &status);
> @@ -633,20 +634,22 @@ static ssize_t lp5523_selftest(struct device *dev,
>  			goto fail;
> =20
>  		if (!(status & LP5523_LEDTEST_DONE))
> -			usleep_range(3000, 6000);/* Was not ready. Wait. */
> +			usleep_range(3000, 6000); /* Was not ready. Wait. */
> =20
>  		ret =3D lp55xx_read(chip, LP5523_REG_LED_TEST_ADC, &adc);
>  		if (ret < 0)
>  			goto fail;
> =20
>  		if (adc >=3D vdd || adc < LP5523_ADC_SHORTCIRC_LIM)
> -			pos +=3D sprintf(buf + pos, "LED %d FAIL\n", i);
> +			pos +=3D sprintf(buf + pos, "LED %d FAIL\n",
> +				       led->chan_nr);
> =20
> -		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + i, 0x00);
> +		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + led->chan_nr,
> +			     0x00);
> =20
>  		/* Restore current */
> -		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + i,
> -			led->led_current);
> +		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + led->chan_nr,
> +			     led->led_current);
>  		led++;
>  	}
>  	if (pos =3D=3D 0)
> --=20
> 2.37.3

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1v2oQAKCRAw5/Bqldv6
8j8zAJ4583whUfrj47M9T7qQaBaALIaEiwCcDtOhDGdoDID3q8P0gLhCuvpq/8Y=
=0oRS
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
