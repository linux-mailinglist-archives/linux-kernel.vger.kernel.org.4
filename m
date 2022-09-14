Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB155B8BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiINPZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiINPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:25:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8647A755;
        Wed, 14 Sep 2022 08:25:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l14so35577104eja.7;
        Wed, 14 Sep 2022 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lH2140K96mHqHo96zL1gkhRwW5qvUiNGb4DdKfszY10=;
        b=I87YKB+NEs/lubBuEoZjWaXEinMdvSD3raR53/IC3ly0muppO4c+XhYQ6xGb2MBkze
         mKwmgh9djHKLKlh9drPi19ntkaLPbJP6WY/1fcb5qP9kYGFYvhAKz1m+8+Dy+dENRflK
         VCUM8zFNzvpZqG5OdZBT1SD8ypp9TRTRp36RKd++S5KGJnjPlJV5E9Sr0CaDS9EjH4dm
         IehwuyL+41kfuwRl/Pkdc5r9q1m8H0VD3B62FhKOW2hSuRGb1qJ9kkl0zeMqE2hMyAUF
         PIIlUNW84Ib96hQhIAxHd7fqZtFr4fkzJTUDIfphUeb3sidNhrZ0merU5sVlyOZIVM1J
         pg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lH2140K96mHqHo96zL1gkhRwW5qvUiNGb4DdKfszY10=;
        b=OpZ0ECProkOzbgPhYd7+lVKF+1qNpfli2l1hPLeY1bVaiVfsW6QiKo60UaEgG6XgI8
         0w48eoK6tPuweMvguvtI3wTmSKzio6ZJ7HqrCimKoKjKt8b3ajrtSItgXJU1ImK9UvJf
         KVYbB18pvKuXmTdEscrqsMs/GbDwp9mfJEMeo0yaF29OycaglnYo1LIMpbazQJQM1V1U
         I/ayIifPvmIgyHtouizMPEZ6MbYpW/Ak+FLsYWxclDX6x/iLRcO3p4gfXj2ATQawWKCs
         Om3+aBHjEb9G8xLYuwnjGsNKDmvRcgBCWNSjYgkMKx+5ijWW8mWfJDYrZpo071GUHNwm
         Ds7w==
X-Gm-Message-State: ACgBeo2UoOf8EASA2xOuBgN7zHZdxGWm19IyZkzPhlvtHStZIEh0+hJX
        ibLiM/xf/jgRPB8X4+aPpw0eve77MNk=
X-Google-Smtp-Source: AA6agR6DO3lQNrngPrUCJbFOK5Wd6vxBf8GRKoNUesyjVab5EUNCa09Qf03EnlFBGI1/2hKcov0P8Q==
X-Received: by 2002:a17:907:7290:b0:77a:27ef:18d3 with SMTP id dt16-20020a170907729000b0077a27ef18d3mr17429241ejc.42.1663169145371;
        Wed, 14 Sep 2022 08:25:45 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b007386a8b90c9sm7905564ejm.13.2022.09.14.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:25:44 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:25:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prathamesh Shete <pshete@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: Process wake events during resume
Message-ID: <YyHydhlIP4FcP7zj@orome>
References: <20220914043831.654836-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2XxEfJff6dFw+gRa"
Content-Disposition: inline
In-Reply-To: <20220914043831.654836-1-petlozup@nvidia.com>
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


--2XxEfJff6dFw+gRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 04:38:31AM +0000, Petlozu Pravareshwar wrote:
> During PMC resume, translate tier2 SC7 wake sources back into
> irqs and do generic_handle_irq() to invoke the interrupt handlers
> for edge triggered wake events such as sw-wake.
>=20
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 8c7b46ac6ad6..f275af15f2d0 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -27,6 +27,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/irqdomain.h>
>  #include <linux/irq.h>
> +#include <linux/interrupt.h>

This should be sorted alphabetically.

>  #include <linux/kernel.h>
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
> @@ -3181,6 +3182,40 @@ static void wke_clear_wake_status(void)
>  				WAKE_AOWAKE_STATUS_W((i * 32) + wake));
>  	}
>  }
> +
> +/* translate sc7 wake sources back into irqs to catch edge triggered wak=
eups */
> +static void process_wake_event(int index, u32 status)
> +{
> +	int irq;

Interrupts are usually unsigned int. The index parameter can also be
unsigned int because it will never be negative.

> +	irq_hw_number_t hwirq;
> +	int wake;

Can be unsigned int as well. Also, it's usually best to define variables
of the same time on a single line to make the code a bit shorter.

> +	unsigned long flags;
> +	struct irq_desc *desc;
> +	unsigned long ulong_status =3D (unsigned long)status;

Why not just make the status parameter an unsigned long to avoid this
clumsy construct?

> +
> +	dev_info(pmc->dev, "Wake[%d:%d]  status=3D0x%x\n", (index + 1) * 32,
> +		index * 32, status);

At most these should be dev_dbg().

> +	for_each_set_bit(wake, &ulong_status, 32) {
> +		hwirq =3D wake + 32 * index;
> +
> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> +		irq =3D irq_find_mapping(pmc->domain, hwirq);

We already use irq_domain_add_hierarchy(), and so the assumption is that
IRQ_DOMAIN_HIERARCHY will always be enabled. You can drop this check. We
may even want to make it explicit by selecting it from SOC_TEGRA_PMC.

> +#else
> +		irq =3D hwirq;
> +#endif
> +		desc =3D irq_to_desc(irq);
> +		if (!desc || !desc->action || !desc->action->name) {
> +			dev_info(pmc->dev, "Resume caused by WAKE%d, irq %d\n",
> +				(wake + 32 * index), irq);
> +			continue;
> +		}
> +		dev_info(pmc->dev, "Resume caused by WAKE%d, %s\n",
> +			(wake + 32 * index), desc->action->name);

Same here.

> +		local_irq_save(flags);
> +		generic_handle_irq(irq);
> +		local_irq_restore(flags);
> +	}
> +}
>  #endif /* CONFIG_ARM64 */
> =20
>  static int tegra_pmc_suspend(struct device *dev)
> @@ -3219,6 +3254,15 @@ static int tegra_pmc_resume(struct device *dev)
>  	struct tegra_pmc *pmc =3D dev_get_drvdata(dev);
> =20
>  	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
> +#else /* CONFIG_ARM64 */
> +	int i;

unsigned int, please.

Thierry

> +	u32 status;
> +
> +	for (i =3D 0; i < WAKE_NR_VECTORS; i++) {
> +		status =3D readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
> +		status =3D status & readl(pmc->wake + WAKE_AOWAKE_TIER2_ROUTING(i));
> +		process_wake_event(i, status);
> +	}
>  #endif
> =20
>  	return 0;
> --=20
> 2.17.1
>=20

--2XxEfJff6dFw+gRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMh8nQACgkQ3SOs138+
s6GGig/+JcmRHHAABf+2uRka1kwAZZCDvejIzUSHvcUJsIjmHSla4ZiW0qyK7SMb
nTTIBM7TDZigzeJf2qpwgy0Ix4EB/GQfhUVfUiNX643kSkbkUOzKeOo3mDLreouy
cEjrQqZax/mMXywKznGKtFqCGWRBIHYdZ7yvROKOtVNOXjeoix95dnCkBptddwbM
DyLslXemicy/2AJo510wqf5oL9jgQS1jBgOmqe5PpZHs2CtQKN3xWqBGo8wWZ/gv
sUKtqTJTzsfQ6l2Up9rDv4b4GSgLwXFjw+3wEqaGboRR03vduzBfXhmgJQCToWCE
xFhK1+CcXPaEScmpCbRDW1/Xe3nMHMg0kyLzCoV2lIMuCR6FAxKgrv/YdlS0MyGW
X8UJp1mKNzm1/CHPotIK79RhC6xYDIY+nLKuWQan+lSevLrYyUCQZ2IlIgD3AlEn
1q1T5bEpW5fOvWDVoocmqdLsU55qaUpWVHxYCPp6R0+FGVdeyHe2rWy95s7vwYF/
lPKAk3Nlo8KxwBXrGXormEVx96br8JoZ82euxanFFkS6ysoioYqszINqG3bH6/Ax
4kaFUs7XxjpLqIv3n0BauhcIV6Fnb57CHfU0F+XyamzAW8nweY55FKouqx4ALb31
bOUIDqUgyCsEyNAIq6Dz287kZByDYMjyHoF03UWryaM0MVgmPuM=
=48j9
-----END PGP SIGNATURE-----

--2XxEfJff6dFw+gRa--
