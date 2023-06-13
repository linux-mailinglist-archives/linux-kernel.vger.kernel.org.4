Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF072E88F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjFMQcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:32:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC3A1;
        Tue, 13 Jun 2023 09:32:53 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A28B06606F36;
        Tue, 13 Jun 2023 17:32:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686673971;
        bh=3E8zkb0kE7pVcBiP+qR+z/XL4CNAs3GSCCkgndQ57mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCwM9+sdcv6Rel+3e8SPmUq8zyZUEwI+thPrcoDzWP9RDSIsMeieSz50qOL/5hi8r
         19cXJzjxu9PB8YKtZp1QhYk00bSuhIA6vuZ3DoobIeBCU3+MyJa/opLB5qc5CZBruh
         pAAYxlgMZ/cpTnunasJJC1z6zbWuDnSVWNENHS+KVHNvIwGcd1+l41UMaodrkwdMtn
         nvGywFpk7GwQJcNUX6PynP4kWDslGbPzdi0y5qbDlFZFlmazWZMBr8zeNTuN8ENHV6
         0qJkknunuIR2Ql+hinEJgAvBpe9fsnwhun8W98EzHP6SMmSG3WF2hUCYjZfkMT2FxR
         QxCZWgYoZaXUw==
Received: by mercury (Postfix, from userid 1000)
        id 04BF01066FC6; Tue, 13 Jun 2023 18:32:49 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:32:48 +0200
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
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 06/25] PM / devfreq: rockchip-dfi: Use free running
 counter
Message-ID: <20230613163248.f6w5plluidqjmrzs@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-7-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wkhvxquv7cdcrlth"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-7-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wkhvxquv7cdcrlth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:34AM +0200, Sascha Hauer wrote:
> The DDR_MON counters are free running counters. These are resetted to 0
> when starting them over like currently done when reading the current
> counter values.
>=20
> Resetting the counters becomes a problem with perf support we want to
> add later, because perf needs counters that are not modified elsewhere.
>=20
> This patch removes resetting the counters and keeps them running
> instead. That means we no longer use the absolute counter values but
> instead compare them with the counter values we read last time. Not
> stopping the counters also has the impact that they are running while
> we are reading them. We cannot read multiple timers atomically, so
> the values do not exactly fit together. The effect should be negligible
> though as the time between two measurements is some orders of magnitude
> bigger than the time we need to read multiple registers.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Notes:
>     Changes since v4:
>     - rephrase commit message
>     - Drop unused variable
>=20
>  drivers/devfreq/event/rockchip-dfi.c | 52 ++++++++++++++++------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 680f629da64fc..126bb744645b6 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -38,11 +38,15 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
> =20
> -struct dmc_usage {
> +struct dmc_count_channel {
>  	u32 access;
>  	u32 total;
>  };
> =20
> +struct dmc_count {
> +	struct dmc_count_channel c[RK3399_DMC_NUM_CH];
> +};
> +
>  /*
>   * The dfi controller can monitor DDR load. It has an upper and lower th=
reshold
>   * for the operating points. Whenever the usage leaves these bounds an e=
vent is
> @@ -51,7 +55,7 @@ struct dmc_usage {
>  struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
>  	struct devfreq_event_desc desc;
> -	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
> +	struct dmc_count last_event_count;
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
> @@ -85,30 +89,18 @@ static void rockchip_dfi_stop_hardware_counter(struct=
 devfreq_event_dev *edev)
>  	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
>  }
> =20
> -static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
> +static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, s=
truct dmc_count *count)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> -	u32 tmp, max =3D 0;
> -	u32 i, busier_ch =3D 0;
> +	u32 i;
>  	void __iomem *dfi_regs =3D dfi->regs;
> =20
> -	rockchip_dfi_stop_hardware_counter(edev);
> -
> -	/* Find out which channel is busier */
>  	for (i =3D 0; i < RK3399_DMC_NUM_CH; i++) {
> -		dfi->ch_usage[i].access =3D readl_relaxed(dfi_regs +
> +		count->c[i].access =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> -		dfi->ch_usage[i].total =3D readl_relaxed(dfi_regs +
> +		count->c[i].total =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
> -		tmp =3D dfi->ch_usage[i].access;
> -		if (tmp > max) {
> -			busier_ch =3D i;
> -			max =3D tmp;
> -		}
>  	}
> -	rockchip_dfi_start_hardware_counter(edev);
> -
> -	return busier_ch;
>  }
> =20
>  static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
> @@ -145,12 +137,28 @@ static int rockchip_dfi_get_event(struct devfreq_ev=
ent_dev *edev,
>  				  struct devfreq_event_data *edata)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> -	int busier_ch;
> +	struct dmc_count count;
> +	struct dmc_count *last =3D &dfi->last_event_count;
> +	u32 access =3D 0, total =3D 0;
> +	int i;
> +
> +	rockchip_dfi_read_counters(edev, &count);
> +
> +	/* We can only report one channel, so find the busiest one */
> +	for (i =3D 0; i < RK3399_DMC_NUM_CH; i++) {
> +		u32 a =3D count.c[i].access - last->c[i].access;
> +		u32 t =3D count.c[i].total - last->c[i].total;
> +
> +		if (a > access) {
> +			access =3D a;
> +			total =3D t;
> +		}
> +	}
> =20
> -	busier_ch =3D rockchip_dfi_get_busier_ch(edev);
> +	edata->load_count =3D access * 4;
> +	edata->total_count =3D total;
> =20
> -	edata->load_count =3D dfi->ch_usage[busier_ch].access * 4;
> -	edata->total_count =3D dfi->ch_usage[busier_ch].total;
> +	dfi->last_event_count =3D count;
> =20
>  	return 0;
>  }
> --=20
> 2.39.2
>=20

--wkhvxquv7cdcrlth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSImjAACgkQ2O7X88g7
+ppeXQ//akAzpEi2vBWYuXm319dcwadvM2a/misSsVJSb/PNJhvD9A3jQDiPILF4
I9DKDxIns/7Y41tclhaBvCdWJNmyo0hFGEaaNNrEE4j5/ptbZqUO/Z/ZU4laA4MS
ZRFKUITfAWyvBEbJCpoQr6SyAQWwIskmaCa96pvqYsNSlqqC0uPVl7sUAIH+Wo5a
3q4tDz5iYNBhlsuhU/Wsg2JAwy4IByVf/c/73M5rXe4qkbnl0V4gNWca5zt+6BAU
Dcq5c8NhuugzX3b/EV/TJP4o2dQS5GacUKRTO9OOvSGW9KxYSmw1xJTTEZM+aWOJ
JpljmvKKvvfGx3JsfkAfpkJhnjWeAB8kp4XhX1YWkDo8gBgRJsIZG8MCdB9KH4+R
UfkoYA+LYqb0ADyVEK4C13FCHKBiLZ86016zdhbh+cBwdlOybJeQUvvZV6bdjoBm
nHFhEN6DOhf4HILiEB+aCbpgUolQ6QL/6YQ+PRRjlYxgbQg9tUIss8JOa/foVsCx
PrCyxlXSDJFG4aYhta866HhPldF/tI5jnHaPR0eRNKZxWcPGdt1pshd9kAHOraCy
KsJY4wrnRb66Fi0HlevcG01xfxX42YaharnV+seojNfxBM+efCgPjno7YBrGtxXS
9xQ7/bd1EncCOMt8zBdGHn/99XlBO1O9Ln+iz2dcwkSFTrmnbhM=
=RfZP
-----END PGP SIGNATURE-----

--wkhvxquv7cdcrlth--
