Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAE5B881A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiINMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:20:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81397804AC;
        Wed, 14 Sep 2022 05:20:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bj12so34199281ejb.13;
        Wed, 14 Sep 2022 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oPmXBjkVR3jE2EKfb211i3vsy5sbXpB5DgfIDb0tj7U=;
        b=fR/cqUuBqqOc8TphBSFtc3hHnZNuhg58rhdXRrfTwtnvBgMtMCj5mEuh/8j2MHGzqz
         6Sd4JYOI3gtUVdBYhUBbbsgW5X1IuFqA6PeO8pBZxo/cSgVtyZjOHh87BiiiQp4Aa3mh
         qJm57TRP02IfwG5SAsS/UDRuFQn4KmLj04D83DhzICyuMiMkqVn5o17bYeXoDtN3BQbO
         qfYt2rlC2VboJnQPJGbraaP6gcUzILd0Kv0/6hpQu6fXrnIa5g10T1Qme3XKFgdG3bwO
         E1uAkwvrlifAOqcEMwyLkfbjHaNvgTdRB8UpoVIF0g7S79bUDbKuU7YSxAkSyHTNcbAy
         lPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oPmXBjkVR3jE2EKfb211i3vsy5sbXpB5DgfIDb0tj7U=;
        b=4RWqT1GG+EoeewEkbaGQObIfHe+fyZgzLAYxlE0hZFNtmLltxx/AEcoNh4TZtbTaVi
         Ffg6CadIcRs1Z64SPEV6fNPuHcu65C4DOL1TIui+VCaKe9dDF8b/loHUqjugM4X0g5Go
         pPNpNLXYIsNP0Ha8XDMrbE5BRprZw6kdQ2gScc1GRs9cZ10QfO85PUhEgrujj/Edjjaf
         lCFsYe9+gQwcw8b4kfzJc1SxEYEJ3GNH8RzopIwfhp2bsqkLnf5BRn6ndAQ1+izrf4Fc
         XdKi7vdmjnXQisQ3pk2ZCq2JuI48Ty6gAftDg4647spU6Dxm1Hts437bpxUJDSMVTfFT
         pYMA==
X-Gm-Message-State: ACgBeo2ORzGkQ2MHJOqI7JHXEfbyOtR6+twnHSOnBKZrimMttE6XOK1v
        UR7kEhdCSF8VBF8FMpgiw8273/okupQ=
X-Google-Smtp-Source: AA6agR6z3Uir2hCPnfxXK3HGcvKxjRYUkQv1BVTr+MYipNcOlS7Fw44xh6LkHTzoSoyulqrS0vJtvA==
X-Received: by 2002:a17:907:2bf4:b0:76f:1053:6e4 with SMTP id gv52-20020a1709072bf400b0076f105306e4mr25328320ejc.443.1663158050780;
        Wed, 14 Sep 2022 05:20:50 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kx25-20020a170907775900b0073d70df6e56sm7491803ejc.138.2022.09.14.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:20:49 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:20:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v2 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Message-ID: <YyHHIPbXnLiPe/vn@orome>
References: <20220914095628.26093-1-pshete@nvidia.com>
 <20220914095628.26093-3-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mT7gJ1KoGt/nhYUh"
Content-Disposition: inline
In-Reply-To: <20220914095628.26093-3-pshete@nvidia.com>
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


--mT7gJ1KoGt/nhYUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 03:26:27PM +0530, Prathamesh Shete wrote:
> In case of error condition to avoid system crash
> Tegra SDMMC controller requires CMD and DAT resets
> issued together.

It might be worth specifying exactly what "system crash" means. Does
this always happen (i.e. do we have a problem right now?) or are there
specific circumstances that cause the crash.

> This is applicable to Tegra186 and later chips.
>=20
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c |  3 ++-
>  drivers/mmc/host/sdhci.c       | 11 ++++++++---
>  drivers/mmc/host/sdhci.h       |  2 ++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index b66b0cc51497..7d16dc41fe91 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1530,7 +1530,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186=
_pdata =3D {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>  	.ops  =3D &tegra186_sdhci_ops,
>  };
> =20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7689ffec5ad1..289fa8ae4866 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3063,9 +3063,14 @@ static bool sdhci_request_done(struct sdhci_host *=
host)
>  		 * Spec says we should do both at the same time, but Ricoh
>  		 * controllers do not like that.
>  		 */

The comment above seems to indicate that the current behavior (i.e.
splitting the CMD and DATA resets) is actually the quirk, so I wonder if
this perhaps should be reversed? I suppose it could be difficult to
track down the exact controllers that need the separate resets, but this
might be worth doing. It's possible that other controllers might run
into the same issue that we are if they work strictly to the spec.

Adrian, any ideas on how much of this is just cargo-culted? Do we play
it safe and do the "double workaround" or do we want to attempt to
rectify this by adding a Ricoh-specific quirk?

Thierry

> -		sdhci_do_reset(host, SDHCI_RESET_CMD);
> -		sdhci_do_reset(host, SDHCI_RESET_DATA);
> -
> +		if (host->quirks2 &
> +			SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
> +			sdhci_do_reset(host, SDHCI_RESET_CMD |
> +					SDHCI_RESET_DATA);
> +		} else {
> +			sdhci_do_reset(host, SDHCI_RESET_CMD);
> +			sdhci_do_reset(host, SDHCI_RESET_DATA);
> +		}
>  		host->pending_reset =3D false;
>  	}
> =20
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 95a08f09df30..8045308f7859 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -480,6 +480,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Issue CMD and DATA reset together */
> +#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER      (1<<19)
> =20
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> --=20
> 2.17.1
>=20

--mT7gJ1KoGt/nhYUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMhxyAACgkQ3SOs138+
s6ELcA//U86GSK/3O35fsKz+/8+HpCYKUHVhHdDMGPFUb1alnivbByn7wdER8kcK
mL8e1VCMsg966yXExj5zRPZmFwLlYAnjFOiYdiYN2hJDYovqF7QBoSv7FQWfB6FN
cD9XiSUnYuiwesdPLDME1ny5zdpmp5Zh+OrVl5WOU39Yby7J//cRDq0Pu44Z0o5g
CxMXZL4XQ+l0fsw+Dokq66tyGMRZspG5O3rSxdP5Yv2cpxJ6X5SUl7f4jnbEPS+Z
KTRGiLuPLMTejecRC9icZLSY6cArIOBzFTatju7aQ8dSabN2KjgKR+kyumV9WAJU
JyF8AusM9x8+c+ObRqtFajvQJzEmXDv2qMlyJK0/Zl4y7rsiFVGbGSSfzGg2sLGU
H0xKye2HNZ5RIa4pMj/IZsySgIWugixS0mUJZe9ztN46qxIM6xvm/Y25nHmT2Xm0
G2c9POaDDz23bK48kq8APuaEYGsBtL9dDs1zzlASpT5fpI9nlFhpqv/qEA43j/ZP
5zHxJQGkEgbBQg3lMgfKGWJMcJrWvRlIfUyo7vKLHmBe94hz2wH9IA+x+9jf6KKi
AtD8GR4Ukqydm6pYBOmGYGRpwJLIwzSD56rlzT2Sqxv8M2bA8SEXrewPdUnBjI+S
IeveP/e+831I+WCrN+NXMglGFilUdPMwm1dmYXqn8NNwQ40qHyU=
=GGJ2
-----END PGP SIGNATURE-----

--mT7gJ1KoGt/nhYUh--
