Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53B95B8B85
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiINPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiINPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:13:11 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779317B2B7;
        Wed, 14 Sep 2022 08:13:09 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h28so11124434qka.0;
        Wed, 14 Sep 2022 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=t/gwaS/IeG3ECHXWYNENfppwW2D3VHRy8N0lefpOrZ4=;
        b=IHxl2Bgz6TXQh0Jg2X0ZrOTZu2jplhpE53FjjAhqEIFdKce3aqlguvyHJ5lzLGsDn4
         sffvdpWDotujoq6bl6XB7P/ibm03y2Gb4Lmvr9vDE/sVhvbWfUarzB75yOuxm3NinAPJ
         ax/jQKfp9RHRG1hd14fdlSKYE1nfjHNuoxyQ9ZAndufb6vl1jR4Z+eK6RENzZqkQ3vq2
         l/KnOCjftAo6ZbrCxAotWVsZ2aCorwwRSW4/BHGDaeSTEpXzMBZjfX1eqsOGpSJnqT/1
         IxmUnJc3250INrlhGLGwgvfbb4phDza/Q4GasDvSCqgoidnw81cTIiMDsROaNhNDVd4Z
         jGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t/gwaS/IeG3ECHXWYNENfppwW2D3VHRy8N0lefpOrZ4=;
        b=Abrp9elurNhHZ18+iHcGUpj9ZsIwZ4/PF7+reOIWlOmEEG1THFZZjyoCOATeykWnZH
         YjHcN2DcEinWnx6xwVbk9OMHurJeHCQ1rJ2ma7s3C2cr2ZGWivWXnsiUypZA3UXzFrfg
         cKlagRf4ADIRXPwpD0/2HYmGFVSY4jqDhyAtynEAGA4Df99C9CqBTX9Rn/4wYMzNkGwV
         kG08zX9LmymSb8ythi7NZ64mGQsPPT41I3RfTfXu6V9CbPTERrPH3/cCJl6nNkpQw/59
         GMTvhlGMerPBOLWsvFPM6HNs+iXZdGDXkV6AwoQP/OP/4tyL+lgpolgFpaI+JS0V8zSl
         C78A==
X-Gm-Message-State: ACgBeo3Cdye3TG6iH4MwrcgkV2IVu7Wp9p+ak9F20QfKfXDY2UEjRoG4
        7tCNlqh1u/j0Ka3dM+ZcMFM=
X-Google-Smtp-Source: AA6agR71uQC0AEGvtTsplBoiYf4OI12u9+tNE07RfZ40Ccr4vRX9rWR1MEYZlV6hbbAfr7l0Q04NCA==
X-Received: by 2002:a05:620a:222f:b0:6cb:dc20:f0c3 with SMTP id n15-20020a05620a222f00b006cbdc20f0c3mr20254826qkh.366.1663168388309;
        Wed, 14 Sep 2022 08:13:08 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bm6-20020a05620a198600b006ce60f5d8e4sm1870304qkb.130.2022.09.14.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:13:07 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:13:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Kristiansson <stefank@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: Fix dual edge triggered wakes
Message-ID: <YyHvfuCGLifv9OX+@orome>
References: <20220906134417.341407-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4xrgjpZSIoA17joh"
Content-Disposition: inline
In-Reply-To: <20220906134417.341407-1-petlozup@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xrgjpZSIoA17joh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 01:44:17PM +0000, Petlozu Pravareshwar wrote:
> When a wake event is defined to be triggered on both positive
> and negative edge of the input wake signal, it is crucial to
> know the current state of the signal when going into suspend.
> The intended way to obtain the current state of the wake
> signals is to read the WAKE_AOWAKE_SW_STATUS register,
> which should contains the raw state of the wake signals.
>=20
> However, this register is edge triggered, an edge will not
> be generated for signals that are already asserted prior to
> the assertion of WAKE_LATCH_SW.
>=20
> To workaround this, change the polarity of the wake level
> from '0' to '1' while latching the signals, as this will
> generate an edge for signals that are set to '1'.
>=20
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 141 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 136 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 495d16a4732c..6a86961477e8 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -182,6 +182,9 @@
>  #define WAKE_AOWAKE_TIER0_ROUTING(x) (0x4b4 + ((x) << 2))
>  #define WAKE_AOWAKE_TIER1_ROUTING(x) (0x4c0 + ((x) << 2))
>  #define WAKE_AOWAKE_TIER2_ROUTING(x) (0x4cc + ((x) << 2))
> +#define WAKE_AOWAKE_SW_STATUS_W_0	0x49c
> +#define WAKE_AOWAKE_SW_STATUS(x)	(0x4a0 + ((x) << 2))
> +#define WAKE_LATCH_SW			0x498
> =20
>  #define WAKE_AOWAKE_CTRL 0x4f4
>  #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
> @@ -191,6 +194,12 @@
>  #define  TEGRA_SMC_PMC_READ	0xaa
>  #define  TEGRA_SMC_PMC_WRITE	0xbb
> =20
> +#define WAKE_NR_EVENTS		96
> +#define WAKE_NR_VECTORS		(WAKE_NR_EVENTS / 32)

Are these always 96? Can they not vary by SoC generation?

> +
> +DECLARE_BITMAP(wake_level_map, WAKE_NR_EVENTS);
> +DECLARE_BITMAP(wake_dual_edge_map, WAKE_NR_EVENTS);

These should not be global variables but rather part of struct pmc.
Might be worth to allocate them dynamically based on a parameterized
per-SoC num_events.

> +
>  struct pmc_clk {
>  	struct clk_hw	hw;
>  	unsigned long	offs;
> @@ -2469,29 +2478,37 @@ static int tegra186_pmc_irq_set_type(struct irq_d=
ata *data, unsigned int type)
>  {
>  	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
>  	u32 value;
> +	unsigned long wake_id;

The usefulness of that local variable is questionable. Might as well
just keep using data->hwirq.

> =20
> -	value =3D readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
> +	wake_id =3D data->hwirq;
> +	value =3D readl(pmc->wake + WAKE_AOWAKE_CNTRL(wake_id));
> =20
>  	switch (type) {
>  	case IRQ_TYPE_EDGE_RISING:
>  	case IRQ_TYPE_LEVEL_HIGH:
>  		value |=3D WAKE_AOWAKE_CNTRL_LEVEL;
> +		set_bit(wake_id, wake_level_map);
> +		clear_bit(wake_id, wake_dual_edge_map);
>  		break;
> =20
>  	case IRQ_TYPE_EDGE_FALLING:
>  	case IRQ_TYPE_LEVEL_LOW:
>  		value &=3D ~WAKE_AOWAKE_CNTRL_LEVEL;
> +		clear_bit(wake_id, wake_level_map);
> +		clear_bit(wake_id, wake_dual_edge_map);
>  		break;
> =20
>  	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
>  		value ^=3D WAKE_AOWAKE_CNTRL_LEVEL;
> +		clear_bit(wake_id, wake_level_map);
> +		set_bit(wake_id, wake_dual_edge_map);
>  		break;
> =20
>  	default:
>  		return -EINVAL;
>  	}
> =20
> -	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
> +	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(wake_id));
> =20
>  	return 0;
>  }
> @@ -3074,28 +3091,142 @@ static int tegra_pmc_probe(struct platform_devic=
e *pdev)
>  	return err;
>  }
> =20
> -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
> +#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_ARM64
> +/*
> + * Ensures that sufficient time is passed for a register write to
> + * serialize into the 32KHz domain.
> + */
> +static void wke_32kwritel(u32 val, u32 reg)
> +{
> +	writel(val, pmc->wake + reg);
> +	udelay(130);
> +}
> +
> +static void wke_write_wake_level(int wake, int level)
> +{
> +	u32 val;
> +	u32 reg =3D WAKE_AOWAKE_CNTRL(wake);
> +
> +	val =3D readl(pmc->wake + reg);
> +	if (level)
> +		val |=3D WAKE_AOWAKE_CNTRL_LEVEL;
> +	else
> +		val &=3D ~WAKE_AOWAKE_CNTRL_LEVEL;
> +	writel(val, pmc->wake + reg);
> +}
> +
> +static void wke_write_wake_levels(unsigned long *lvl)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < WAKE_NR_EVENTS; i++)
> +		wke_write_wake_level(i, test_bit(i, lvl));
> +}
> +
> +static void wke_clear_sw_wake_status(void)
> +{
> +	wke_32kwritel(1, WAKE_AOWAKE_SW_STATUS_W_0);
> +}
> +
> +static void wke_read_sw_wake_status(unsigned long *status_map)
> +{
> +	u32 status[WAKE_NR_VECTORS];
> +	int i;
> +
> +	for (i =3D 0; i < WAKE_NR_EVENTS; i++)
> +		wke_write_wake_level(i, 0);
> +
> +	wke_clear_sw_wake_status();
> +
> +	wke_32kwritel(1, WAKE_LATCH_SW);
> +
> +	/*
> +	 * WAKE_AOWAKE_SW_STATUS is edge triggered, so in order to
> +	 * obtain the current status of the input wake signals, change
> +	 * the polarity of the wake level from 0->1 while latching to force
> +	 * a positive edge if the sampled signal is '1'.
> +	 */
> +	for (i =3D 0; i < WAKE_NR_EVENTS; i++)
> +		wke_write_wake_level(i, 1);
> +
> +	/*
> +	 * Wait for the update to be synced into the 32kHz domain,
> +	 * and let enough time lapse, so that the wake signals have time to
> +	 * be sampled.
> +	 */
> +	udelay(300);
> +
> +	wke_32kwritel(0, WAKE_LATCH_SW);
> +
> +	for (i =3D 0; i < WAKE_NR_VECTORS; i++)
> +		status[i] =3D readl(pmc->wake + WAKE_AOWAKE_SW_STATUS(i));
> +
> +	bitmap_from_arr32(status_map, status, WAKE_NR_EVENTS);
> +}
> +
> +static void wke_clear_wake_status(void)
> +{
> +	u32 status;
> +	int i, wake;
> +	unsigned long ulong_status;
> +
> +	for (i =3D 0; i < WAKE_NR_VECTORS; i++) {
> +		status =3D readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
> +		status =3D status & readl(pmc->wake +
> +				WAKE_AOWAKE_TIER2_ROUTING(i));
> +		ulong_status =3D (unsigned long)status;
> +		for_each_set_bit(wake, &ulong_status, 32)
> +			wke_32kwritel(0x1,
> +				WAKE_AOWAKE_STATUS_W((i * 32) + wake));
> +	}
> +}
> +#endif /* CONFIG_ARM64 */
> +
>  static int tegra_pmc_suspend(struct device *dev)
>  {
> +#ifdef CONFIG_ARM
>  	struct tegra_pmc *pmc =3D dev_get_drvdata(dev);
> =20
>  	tegra_pmc_writel(pmc, virt_to_phys(tegra_resume), PMC_SCRATCH41);

If this code is really no longer needed on 64-bit ARM, this should be a
separate patch. Also, these conditionals are becoming a bit unwieldy, so
I wonder if we should instead move to C conditionals using IS_ENABLED()
to make this a bit more readable and get improved code coverage at
compile time.

> +#else /* CONFIG_ARM64 */

The implied condition here seems a bit broad. I think it might be better
to conditionalize this code on the setting of tegra_pmc_soc.wake_events.
If that's !=3D NULL, then execute all this context store/restore,
otherwise don't.

> +	DECLARE_BITMAP(status, WAKE_NR_EVENTS);
> +	DECLARE_BITMAP(lvl, WAKE_NR_EVENTS);
> +	DECLARE_BITMAP(wake_level, WAKE_NR_EVENTS);
> +	int i;
> +
> +	wke_read_sw_wake_status(status);
> +
> +	/* flip the wakeup trigger for dual-edge triggered pads
> +	 * which are currently asserting as wakeups
> +	 */
> +	for (i =3D 0; i < BITS_TO_LONGS(WAKE_NR_EVENTS); i++) {
> +		lvl[i] =3D ~status[i] & wake_dual_edge_map[i];
> +		wake_level[i] =3D lvl[i] | wake_level_map[i];
> +	}

I think these can be done using:

	bitmap_andnot(lvl, wake_dual_edge_map, status, WAKE_NR_EVENTS);
	bitmap_or(wake_level, lvl, wake_level_map, WAKE_NR_EVENTS);

> +
> +	/* Clear PMC Wake Status registers while going to suspend */
> +	wke_clear_wake_status();
> =20
> +	wke_write_wake_levels(wake_level);
> +#endif
>  	return 0;
>  }
> =20
>  static int tegra_pmc_resume(struct device *dev)
>  {
> +#ifdef CONFIG_ARM
>  	struct tegra_pmc *pmc =3D dev_get_drvdata(dev);
> =20
>  	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
> +#endif
> =20
>  	return 0;
>  }
> =20
>  static SIMPLE_DEV_PM_OPS(tegra_pmc_pm_ops, tegra_pmc_suspend, tegra_pmc_=
resume);
> =20
> -#endif
> +#endif /*CONFIG_PM_SLEEP */

Perhaps we should then also drop the CONFIG_PM_SLEEP conditional and
instead mark tegra_pmc_suspend()/tegra_pmc_resume() as __maybe_unused.
Could also be a separate patch.

Thierry

> =20
>  static const char * const tegra20_powergates[] =3D {
>  	[TEGRA_POWERGATE_CPU] =3D "cpu",
> @@ -4069,7 +4200,7 @@ static struct platform_driver tegra_pmc_driver =3D {
>  		.name =3D "tegra-pmc",
>  		.suppress_bind_attrs =3D true,
>  		.of_match_table =3D tegra_pmc_match,
> -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
> +#if defined(CONFIG_PM_SLEEP)
>  		.pm =3D &tegra_pmc_pm_ops,
>  #endif
>  		.sync_state =3D tegra_pmc_sync_state,
> --=20
> 2.17.1
>=20

--4xrgjpZSIoA17joh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMh73sACgkQ3SOs138+
s6F2HxAAhwh3dc+9VNNN1oeLJrQprYpSyILb66DlkCMcnKfWubAqdKInX56wrWTL
9rdcVhfeGwEzGQnNbKUdc3iB2cQkV5/ixZwTDNgU/8/Si4so2xRtb8nh9R44hgS9
83BmuctXbWc67M1b6LDT4Z7JJxNyUEzoAODDm+fcP3DQVdxq4epY+/wkqhTTtnGl
/ZsdZqrN0Q4lGiWV6adr6qAqBQ26AX06+GZRSynLz3kPZ2Q9w4H8neSH6sRe+rRi
KNPUR8B6B1NK8NQnVzXAVPkx+1ANj308h/voysos29CkqoSTUgGilZ2qxu8iNTzZ
T3MCX9yxQYok3unhXeU/cI4qpZA3kPZGkneKGbgGk2LKFlTNWKAEGUjJh6Shf65m
b9bnpQKy+UJqbyp7ME+E3tubyx716FFq52OUzuRxdAA9Jx3wetToEsS514TF7u/n
T142LiTY4ohhLuP7eRXcUfFPPFgsb94hTM+AF9UWQtqPuCRpglXcJE6fHphlCBwW
BNc5CV7mmTk0VkjpyZbpTkchOMYrC1Sl84aFf3HonqXWERNzaNPWSkOJnPdf4uD6
2pr4/cm2QmYWyecButKPjSqJyPp0A+yBcjZdelhgK23abjOWyy78RVMDCP3emvXf
1x0BuWJSY3eMTRoogRE6tWcMiZ/hE4cMczswtbRIhkJso1U2LCw=
=SOwH
-----END PGP SIGNATURE-----

--4xrgjpZSIoA17joh--
