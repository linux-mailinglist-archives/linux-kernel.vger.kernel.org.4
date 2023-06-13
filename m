Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C972E924
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbjFMRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFMRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:15:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30C10FE;
        Tue, 13 Jun 2023 10:15:22 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5039E66003AF;
        Tue, 13 Jun 2023 18:15:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686676521;
        bh=ea9y0y4+Ed8zGdoUAyX2osAZo4+AuOqYHjrelnRLp1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNpPgcNSj4ts6Dd0RIAzCfSOYRLGg4PkpnAXxjOLzTp5e0VtM9m2FCEJqFlEEV+jm
         q8BL5UWF3O1BORogrx91RV9DZmCY8yaZAwcJJmAgbdO7i2J+GZzy+A6pOwuuy+ojRx
         86/hutK3kvT04+xMews7TqWiPRVHhmZyRgFYwZYO/4DwJWK5+Qt7e+kKoM+ao9FtPy
         G8N0wHwfon/f7bq0Y3D1UkebuxCzzxsl7DB+x47FncmXJGoU6aMXWGoUxSe6Xf4vhi
         5xo0mh4DkS8orRYMRrOBENt38f98etBBX8n0Opfyqngrkay205KitXZJX2JZMYQqNt
         IeXs4uJa2vXrg==
Received: by mercury (Postfix, from userid 1000)
        id E44E31066FC6; Tue, 13 Jun 2023 19:15:18 +0200 (CEST)
Date:   Tue, 13 Jun 2023 19:15:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 14/25] PM / devfreq: rockchip-dfi: Prepare for
 multiple users
Message-ID: <20230613171518.l4icucem5oq6eryu@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-15-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngrrzj37mxuwswuk"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-15-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ngrrzj37mxuwswuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:42AM +0200, Sascha Hauer wrote:
> When adding perf support later the DFI must be enabled when
> either of devfreq-event or perf is active. Prepare for that
> by adding a usage counter for the DFI. Also move enabling
> and disabling of the clock away from the devfreq-event specific
> functions to which the perf specific part won't have access.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 57 +++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index d39db5de7f19c..8a7af7c32ae0d 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -68,13 +68,28 @@ struct rockchip_dfi {
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
>  	struct clk *clk;
> +	int usecount;
> +	struct mutex mutex;
>  	u32 ddr_type;
>  	unsigned int channel_mask;
>  };
> =20
> -static void rockchip_dfi_start_hardware_counter(struct rockchip_dfi *dfi)
> +static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs =3D dfi->regs;
> +	int ret =3D 0;
> +
> +	mutex_lock(&dfi->mutex);
> +
> +	dfi->usecount++;
> +	if (dfi->usecount > 1)
> +		goto out;
> +
> +	ret =3D clk_prepare_enable(dfi->clk);
> +	if (ret) {
> +		dev_err(&dfi->edev->dev, "failed to enable dfi clk: %d\n", ret);
> +		goto out;
> +	}
> =20
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_=
SOFTWARE_EN |
> @@ -99,14 +114,30 @@ static void rockchip_dfi_start_hardware_counter(stru=
ct rockchip_dfi *dfi)
>  	/* enable count, use software mode */
>  	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTW=
ARE_EN),
>  		       dfi_regs + DDRMON_CTRL);
> +out:
> +	mutex_unlock(&dfi->mutex);
> +
> +	return ret;
>  }
> =20
> -static void rockchip_dfi_stop_hardware_counter(struct rockchip_dfi *dfi)
> +static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs =3D dfi->regs;
> =20
> +	mutex_lock(&dfi->mutex);
> +
> +	dfi->usecount--;
> +
> +	WARN_ON_ONCE(dfi->usecount < 0);
> +
> +	if (dfi->usecount > 0)
> +		goto out;
> +
>  	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
>  		       dfi_regs + DDRMON_CTRL);
> +	clk_disable_unprepare(dfi->clk);
> +out:
> +	mutex_unlock(&dfi->mutex);
>  }
> =20
>  static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct =
dmc_count *count)
> @@ -124,29 +155,20 @@ static void rockchip_dfi_read_counters(struct rockc=
hip_dfi *dfi, struct dmc_coun
>  	}
>  }
> =20
> -static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
> +static int rockchip_dfi_event_disable(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> =20
> -	rockchip_dfi_stop_hardware_counter(dfi);
> -	clk_disable_unprepare(dfi->clk);
> +	rockchip_dfi_disable(dfi);
> =20
>  	return 0;
>  }
> =20
> -static int rockchip_dfi_enable(struct devfreq_event_dev *edev)
> +static int rockchip_dfi_event_enable(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(dfi->clk);
> -	if (ret) {
> -		dev_err(&edev->dev, "failed to enable dfi clk: %d\n", ret);
> -		return ret;
> -	}
> =20
> -	rockchip_dfi_start_hardware_counter(dfi);
> -	return 0;
> +	return rockchip_dfi_enable(dfi);
>  }
> =20
>  static int rockchip_dfi_set_event(struct devfreq_event_dev *edev)
> @@ -190,8 +212,8 @@ static int rockchip_dfi_get_event(struct devfreq_even=
t_dev *edev,
>  }
> =20
>  static const struct devfreq_event_ops rockchip_dfi_ops =3D {
> -	.disable =3D rockchip_dfi_disable,
> -	.enable =3D rockchip_dfi_enable,
> +	.disable =3D rockchip_dfi_event_disable,
> +	.enable =3D rockchip_dfi_event_enable,
>  	.get_event =3D rockchip_dfi_get_event,
>  	.set_event =3D rockchip_dfi_set_event,
>  };
> @@ -272,6 +294,7 @@ static int rockchip_dfi_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(dfi->regmap_pmu);
> =20
>  	dfi->dev =3D dev;
> +	mutex_init(&dfi->mutex);
> =20
>  	desc =3D &dfi->desc;
>  	desc->ops =3D &rockchip_dfi_ops;
> --=20
> 2.39.2
>=20

--ngrrzj37mxuwswuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIpCYACgkQ2O7X88g7
+pq6rw//R2cZCPEqSABeFIaVk6Gmh7baDhTAJFf+5S43NTiIuND9UU7r8bwfqoMW
WZHfb0BhtAknPphgNwg1TN1wQKXq7v/cbgd0ZGfephnxJPQiCwCaq2GvSBq59f4N
RU9r+u+/Wz4Da3EOrlyDoL3ypo94XD5dTIU6bgWGdUaBi+SmSdo1NBrY4P/8RRnH
c1q56EJk4uSETMVz9qo4tuWLYRl6njfDJ1B86BZmH8Silna4HDWGU9N/6O6DapBL
gFDZgBepyY2AVPfTd5/kRI+yyvGIFzh6wlntq5SIjHBeu/bhgvW7Zq/M228FiPYv
/QXo26NZX01hM0+bPo3ZB7Bm693uvWmTxPagkdPcNxR19GrbAK5X456h5kGWnt8e
CwQIR5JhXGxJ62zhK91RcFXn8I/elB0fxRa777V3PsUD+WpZW/RY5B1jCgWlJs7w
ExgO2mqLxqgqaeF0Xdl3ByAnYiYQibkYy5vQxdVoOyW61EPjSognWBKJ8i4DoXHf
AgbrAflMyVRHcdthoTa/p15H/TMBdwBbMTNxAhJiXkREe6rF+0jtbrhZMXlsUIOw
MIuY6ASRa5SCfR+/s+aMypTSSwQdFuB6jJFsxiNpVsDkGD3/ex3tJCVoEMXEjXpe
l80lYt3wlY/oD0SX5vxb2Wjmb7fuXh0rFCoKlsBoBIHUAHPw5r0=
=pDhV
-----END PGP SIGNATURE-----

--ngrrzj37mxuwswuk--
