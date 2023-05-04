Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0696F6AD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjEDMFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjEDMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F875FCE;
        Thu,  4 May 2023 05:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A6D633C0;
        Thu,  4 May 2023 12:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4AEC4339C;
        Thu,  4 May 2023 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683201890;
        bh=AQVjob/5f+sN7+xlipG3xZlIavAHmNeW1nlxRjdKY0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RamKx6oCJf5udMicwJnw8+gVS3U9LmDiOry8Tbeo5kbRPnJrFSRVFnKIiKHzcSh91
         LSpHhqb0NJ79GK5q8SPujt2nz9y0WnbjnUTquZyWC+zoUrAg1zW6az8ess2vPY8LrE
         QLOFkZsGs9B/VQInluK9+hxdeLx+hL1oeLGyCH2XyyFG+87oS19PUgUUiIl6D2B+iU
         9xID3FCXKro5WNTGyzOzg3CQPSfVZqpAgGcdAVI8P7WWbyxm5KenMVo5SuigfbRsrk
         l7FLSYcpnZRqOak6y2JZqjtRT9xFKC7EfzeusLLap9eVAMz1FCC81FG1ZTJ0UNf3SM
         ZpH6wR7Gf1LjQ==
Date:   Thu, 4 May 2023 21:04:47 +0900
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2 2/2] regulator: Add support for TI TPS6287x regulators
Message-ID: <ZFOfX+PTsmA35TsC@finisterre.sirena.org.uk>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-2-fb5419d46c49@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fPur/hBqaL3u1Si"
Content-Disposition: inline
In-Reply-To: <20230502-tps6287x-driver-v2-2-fb5419d46c49@axis.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fPur/hBqaL3u1Si
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 10:30:27AM +0200, M=E5rten Lindahl wrote:

> +static int tps6287x_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct device *dev =3D rdev_get_dev(rdev);
> +	struct tps6287x_chip *chip =3D
> +	    i2c_get_clientdata(to_i2c_client(dev->parent));
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(rdev->regmap, TPS6287X_VSET, &val);
> +	if (ret !=3D 0)
> +		return -ENOTRECOVERABLE;
> +
> +	return (val * chip->uv_step) + rdev->constraints->min_uV;
> +}

Don't open code the voltage conversion, just use selectors - in which
case you can simply describe the bitfield that the device has and use
the generic regmap helpers.

The driver should also never be referring to constraints to figure out
what the register values mean, this is just not going to work - boards
will typically be able to use far fewer voltages than the regulator
supports.

Also try to avoid squashing error codes, just pass the result back.

> +static int tps6287x_set_voltage(struct regulator_dev *rdev, int min_uv,
> +				int max_uv, unsigned int *selector)

Similarly here, describe the bitfield and use the generic helpers.

> +static int tps6287x_setup_vrange(struct tps6287x_chip *chip)
> +{
> +	struct regulator_dev *rdev =3D chip->rdev;
> +	unsigned int val, r;
> +	bool found =3D false;
> +	int ret;
> +
> +	/*
> +	 * Match DT voltage range to one of the predefined ranges,
> +	 * and configure the regulator with the selected range.
> +	 */
> +	for (r =3D 0; r < ARRAY_SIZE(tps6287x_voltage_table); r++) {
> +		if (tps6287x_voltage_table[r][0] =3D=3D rdev->constraints->min_uV &&
> +		    tps6287x_voltage_table[r][1] =3D=3D rdev->constraints->max_uV) {
> +			found =3D true;
> +			break;
> +		}
> +	}

No, as I said above the driver should just know what the device
supports based on the device ID.  In general if a regulator driver is
looking at the constraints that indicates that it's doing something
wrong, the purpose of constraints is to grant permission for the
features of the regulator to be used on the board.

> +static const struct of_device_id tps6287x_dt_ids[] =3D {
> +	{ .compatible =3D "ti,tps62870", },
> +	{ .compatible =3D "ti,tps62871", },
> +	{ .compatible =3D "ti,tps62872", },
> +	{ .compatible =3D "ti,tps62873", },
> +	{ }
> +};

Use the .data field here...

> +static const struct i2c_device_id tps6287x_i2c_id[] =3D {
> +	{ "tps62870", 0 },
> +	{ "tps62871", 0 },
> +	{ "tps62872", 0 },
> +	{ "tps62873", 0 },
> +	{},
> +};

=2E..and here to enumerate which of the variants is being used and hence
which voltage range is required.

--7fPur/hBqaL3u1Si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRTn14ACgkQJNaLcl1U
h9AYswf/QHQLzxn3Fis4kjKIRfIdHfO6913zQeqLZTBAVfI55azO4zetB/QZTl9x
Z2XW79tJp6znoFvL+MZttVyqCAOKE7Aczydo0xZ8IBhPUKzKIEfQZtd1q/8gJmiH
owuAoucBUrrTNn+U4EGrnAnvOPH2ER9m29kD1un1PWmzs24X/OneWCWtQPOdcHlX
Oxc9nwoUVJA5fhpGK26QVgh080oQrdu2nZblGZLmkTCYW9uRj90LLf16JmsAvSfO
ls1xWpUXzpmbO/+BOrUj7ysdqCYf52ZoNm6CXo3Q38fjJiVnH6loqjutPqjvV5TR
tw31NiK8dpeLojbZWnGj7TkVHd2Csg==
=+kH3
-----END PGP SIGNATURE-----

--7fPur/hBqaL3u1Si--
