Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB735B8B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiINOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiINOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:51:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8BBE00;
        Wed, 14 Sep 2022 07:51:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 29so22637010edv.2;
        Wed, 14 Sep 2022 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=eKVQAdjfkHV03dSaIdo7Ryv9nXId0COhlXmLsLzg0OA=;
        b=KIl5V2BDMzo4SoXOnyHTVZggu9PJ3erYrtrXaGHvo20D/PbElfF4BzTt2WdnbNozXo
         0vHsC7KLJAWh5DDbtBglKVXaHkbSdKNKYN2BjWKjff033lnblSL6QIuUeE8zIHEoTLgT
         beR7VsgZyadY6vPbofde4mh6DFsSAyOua2u1puRybu8sTgjyc3Wnqyjmlc0kdJx4vaXN
         ABC+wm0OXM8V5VA8vUDKExN73SSErHrtaVDpSjRlOySWB/DKql+1n/9tiLuyvjRYD+z9
         llMsA9rKJXuXPX05I8EutjLHLK027UTvDtyPq0+oFxxH8pYVi9c2HHf/tIkKjpXyT0ao
         y6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eKVQAdjfkHV03dSaIdo7Ryv9nXId0COhlXmLsLzg0OA=;
        b=ZXWmTbHpu9Fs3ndQyOOChmHpgqzf/kzc+1ViWsnsWjJf/cU6daJnro07SyqsCs26iD
         4WBJi8ZK3FSHqAJzqMrg30eMRqlJcuB2hqt5fv6bAO9xb8rWijupYgacUiw7Nf11h2WL
         xKGDQfxac1FQjSd3MxaXSnlu4Cv+pvLBDnUCWD22T2rui0ufbJ2H0Fz04ly78USUTkpN
         P/OHn1yVRw/vq0gKeki6buVvcd5BK6tPZG/eKof1D17jnGzPlP/GkyXHoW2iiIIUu0P1
         cCWcaapkG14dTJLRKWNwpQO7hZFmHJfDvWbIhx89iD1ea8SZ5GdWgU34a1nadmz+N8ne
         15rQ==
X-Gm-Message-State: ACgBeo3xRgxeOaGTixUftrHM0hYBguBYo6SedvjtRxPld9HtaagKW4LF
        Vy+xE+TYZyXWn8P3JpU+ShU=
X-Google-Smtp-Source: AA6agR6w+ZcjwfRhsjwY/V8SvxGtUjH+VyEB0B959h8/X1aovepeUM7DySid1fKyme7Y+fFbWXCo5w==
X-Received: by 2002:a05:6402:2554:b0:450:28d2:2152 with SMTP id l20-20020a056402255400b0045028d22152mr26801996edb.303.1663167073549;
        Wed, 14 Sep 2022 07:51:13 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b007778c9b7629sm7664217ejh.34.2022.09.14.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:51:03 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:51:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] soc/tegra: pmc: Add IO Pad table for tegra234
Message-ID: <YyHqVj9b7JxWInkF@orome>
References: <20220824202723.3340035-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RG6ZG42KnPUXsFpt"
Content-Disposition: inline
In-Reply-To: <20220824202723.3340035-1-petlozup@nvidia.com>
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


--RG6ZG42KnPUXsFpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 08:27:23PM +0000, Petlozu Pravareshwar wrote:
> Add IO PAD table for tegra234 to allow configuring dpd mode
> and switching the pins to 1.8V or 3.3V as needed.
>=20
> In tegra234, DPD registers are reorganized such that there is
> a DPD_REQ register and a DPD_STATUS register per pad group.
> This change accordingly updates the PMC driver.
>=20
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
> v3:
> * Update to make the code more readable and avoid using extra flags.
> ---
>  drivers/soc/tegra/pmc.c | 163 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 151 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 5611d14d3ba2..495d16a4732c 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -266,11 +266,23 @@ struct tegra_powergate {
>  	struct reset_control *reset;
>  };
> =20
> +enum tegra_io_pad_dpd {
> +	TEGRA_PMC_IO_LEGACY_DPD,
> +	TEGRA_PMC_IO_CSI_DPD,
> +	TEGRA_PMC_IO_DISP_DPD,
> +	TEGRA_PMC_IO_QSPI_DPD,
> +	TEGRA_PMC_IO_UFS_DPD,
> +	TEGRA_PMC_IO_EDP_DPD,
> +	TEGRA_PMC_IO_SDMMC1_HV_DPD,
> +	TEGRA_PMC_IO_INVALID_DPD,
> +};
> +
>  struct tegra_io_pad_soc {
>  	enum tegra_io_pad id;
>  	unsigned int dpd;
>  	unsigned int voltage;
>  	const char *name;
> +	enum tegra_io_pad_dpd dpd_index;
>  };
> =20
>  struct tegra_pmc_regs {
> @@ -284,6 +296,18 @@ struct tegra_pmc_regs {
>  	unsigned int rst_source_mask;
>  	unsigned int rst_level_shift;
>  	unsigned int rst_level_mask;
> +	unsigned int csi_dpd_req;
> +	unsigned int csi_dpd_status;
> +	unsigned int disp_dpd_req;
> +	unsigned int disp_dpd_status;
> +	unsigned int qspi_dpd_req;
> +	unsigned int qspi_dpd_status;
> +	unsigned int ufs_dpd_req;
> +	unsigned int ufs_dpd_status;
> +	unsigned int edp_dpd_req;
> +	unsigned int edp_dpd_status;
> +	unsigned int sdmmc1_hv_dpd_req;
> +	unsigned int sdmmc1_hv_dpd_status;

This seems a bit complicated because there's an extra level of
indirection (via that dpd_index variable). I think it'd be a bit more
trivial to directly add offsets for the req and status registers to the
I/O pad entry definitions. So I'm thinking something like this:

	struct tegra_io_pad_soc {
		enum tegra_io_pad id;
		unsigned int dpd;
		unsigned int request; /* these two are the new */
		unsigned int status;  /* register offsets */
		unsigned int voltage;
		const char *name;
	};

And then...

>  };
> =20
>  struct tegra_wake_event {
> @@ -1536,6 +1560,7 @@ static int tegra_io_pad_get_dpd_register_bit(struct=
 tegra_pmc *pmc,
>  					     u32 *mask)
>  {
>  	const struct tegra_io_pad_soc *pad;
> +	int ret =3D 0;
> =20
>  	pad =3D tegra_io_pad_find(pmc, id);
>  	if (!pad) {
> @@ -1546,17 +1571,63 @@ static int tegra_io_pad_get_dpd_register_bit(stru=
ct tegra_pmc *pmc,
>  	if (pad->dpd =3D=3D UINT_MAX)
>  		return -ENOTSUPP;
> =20
> -	*mask =3D BIT(pad->dpd % 32);
> =20
> -	if (pad->dpd < 32) {
> -		*status =3D pmc->soc->regs->dpd_status;
> -		*request =3D pmc->soc->regs->dpd_req;
> -	} else {
> -		*status =3D pmc->soc->regs->dpd2_status;
> -		*request =3D pmc->soc->regs->dpd2_req;
> +	switch (pad->dpd_index) {
> +	case TEGRA_PMC_IO_LEGACY_DPD:
> +		*mask =3D BIT(pad->dpd % 32);
> +
> +		if (pad->dpd < 32) {
> +			*status =3D pmc->soc->regs->dpd_status;
> +			*request =3D pmc->soc->regs->dpd_req;
> +		} else {
> +			*status =3D pmc->soc->regs->dpd2_status;
> +			*request =3D pmc->soc->regs->dpd2_req;
> +		}
> +		break;
> +
> +	case TEGRA_PMC_IO_CSI_DPD:
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->csi_dpd_status;
> +		*request =3D pmc->soc->regs->csi_dpd_req;
> +		break;
> +
> +	case TEGRA_PMC_IO_DISP_DPD:
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->disp_dpd_status;
> +		*request =3D pmc->soc->regs->disp_dpd_req;
> +		break;
> +
> +	case TEGRA_PMC_IO_QSPI_DPD:
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->qspi_dpd_status;
> +		*request =3D pmc->soc->regs->qspi_dpd_req;
> +		break;
> +
> +	case TEGRA_PMC_IO_UFS_DPD:
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->ufs_dpd_status;
> +		*request =3D pmc->soc->regs->ufs_dpd_req;
> +		break;
> +
> +	case TEGRA_PMC_IO_EDP_DPD:
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->edp_dpd_status;
> +		*request =3D pmc->soc->regs->edp_dpd_req;
> +		break;
> +
> +	case TEGRA_PMC_IO_SDMMC1_HV_DPD:
> +		*mask =3D BIT(pad->dpd);
> +		*status =3D pmc->soc->regs->sdmmc1_hv_dpd_status;
> +		*request =3D pmc->soc->regs->sdmmc1_hv_dpd_req;
> +		break;
> +
> +	default:
> +		dev_err(pmc->dev, "invalid DPD reg index %u\n", pad->dpd_index);
> +		ret =3D -ENOENT;
> +		break;
>  	}

All of these can simply become:

	*request =3D pad->request;
	*status =3D pad->status;
	*mask =3D BIT(pad->dpd);

At which point it might even be worth dropping that helper function
altogether and inlining the values there. Perhaps do the pad lookup at a
level higher up, such as in tegra_io_pad_power_enable() and pass a const
struct tegra_io_pad_soc * to tegra_io_pad_prepare() and
tegra_io_pad_poll().

This has the disadvantage that it requires existing tables to be
reworked a little and they will grow somewhat because of the extra
fields, but ultimately the code becomes much simpler and decreases in
size to compensate for the extra data. We also won't need special I/O
pad initialization macros like TEGRA234_IO_PAD below.

If there's a *big* concern about the data size, we could avoid the worst
by special-casing the legacy cases like you've done here. But I think it
is really not worth it. On the plus side, the new version will be
flexible enough to handle any additions and/or changes to the set of
request and status registers in future SoCs.

Thierry

> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad=
 id,
> @@ -3291,6 +3362,7 @@ static const u8 tegra124_cpu_powergates[] =3D {
>  		.dpd	=3D (_dpd),			\
>  		.voltage =3D (_voltage),			\
>  		.name	=3D (_name),			\
> +		.dpd_index =3D TEGRA_PMC_IO_LEGACY_DPD,	\
>  	})
> =20
>  #define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> @@ -3791,6 +3863,61 @@ static const struct tegra_pmc_soc tegra194_pmc_soc=
 =3D {
>  	.has_usb_sleepwalk =3D false,
>  };
> =20
> +#define TEGRA234_IO_PAD(_id, _dpd, _voltage, _name, _dpd_index)	\
> +	((struct tegra_io_pad_soc) {				\
> +		.id		=3D (_id),			\
> +		.dpd		=3D (_dpd),			\
> +		.voltage	=3D (_voltage),			\
> +		.name		=3D (_name),			\
> +		.dpd_index	=3D (_dpd_index),			\
> +	})
> +
> +#define TEGRA234_IO_PIN_DESC(_id, _dpd, _voltage, _name, _dpd_index)	\
> +	((struct pinctrl_pin_desc) {					\
> +		.number =3D (_id),					\
> +		.name	=3D (_name)					\
> +	})
> +
> +#define TEGRA234_IO_PAD_TABLE(_pad) {                                   =
       \
> +	/* (id, dpd, voltage, name, dpd_index) */                              \
> +	_pad(TEGRA_IO_PAD_CSIA,           0,         UINT_MAX,	"csia",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_CSIB,           1,         UINT_MAX,  "csib",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_HDMI_DP0,       0,         UINT_MAX,  "hdmi-dp0",    \
> +		TEGRA_PMC_IO_DISP_DPD),                                        \
> +	_pad(TEGRA_IO_PAD_CSIC,           2,         UINT_MAX,  "csic",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_CSID,           3,         UINT_MAX,  "csid",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_CSIE,           4,         UINT_MAX,  "csie",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_CSIF,           5,         UINT_MAX,  "csif",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_UFS,            0,         UINT_MAX,  "ufs",         \
> +		TEGRA_PMC_IO_UFS_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_EDP,            1,         UINT_MAX,  "edp",         \
> +		TEGRA_PMC_IO_EDP_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_SDMMC1_HV,      0,         4,         "sdmmc1-hv",   \
> +		TEGRA_PMC_IO_SDMMC1_HV_DPD),                                   \
> +	_pad(TEGRA_IO_PAD_SDMMC3_HV,      UINT_MAX,  6,         "sdmmc3-hv",   \
> +		TEGRA_PMC_IO_INVALID_DPD),                                     \
> +	_pad(TEGRA_IO_PAD_AUDIO_HV,       UINT_MAX,  1,         "audio-hv",    \
> +		TEGRA_PMC_IO_INVALID_DPD),                                     \
> +	_pad(TEGRA_IO_PAD_AO_HV,          UINT_MAX,  0,         "ao-hv",       \
> +		TEGRA_PMC_IO_INVALID_DPD),                                     \
> +	_pad(TEGRA_IO_PAD_CSIG,           6,         UINT_MAX,  "csig",        \
> +		TEGRA_PMC_IO_CSI_DPD),                                         \
> +	_pad(TEGRA_IO_PAD_CSIH,           7,         UINT_MAX,  "csih",        \
> +		TEGRA_PMC_IO_CSI_DPD)                                          \
> +	}
> +
> +static const struct tegra_io_pad_soc tegra234_io_pads[] =3D
> +	TEGRA234_IO_PAD_TABLE(TEGRA234_IO_PAD);
> +
> +static const struct pinctrl_pin_desc tegra234_pin_descs[] =3D
> +	TEGRA234_IO_PAD_TABLE(TEGRA234_IO_PIN_DESC);
> +
>  static const struct tegra_pmc_regs tegra234_pmc_regs =3D {
>  	.scratch0 =3D 0x2000,
>  	.dpd_req =3D 0,
> @@ -3802,6 +3929,18 @@ static const struct tegra_pmc_regs tegra234_pmc_re=
gs =3D {
>  	.rst_source_mask =3D 0xfc,
>  	.rst_level_shift =3D 0x0,
>  	.rst_level_mask =3D 0x3,
> +	.csi_dpd_req =3D 0xe0c0,
> +	.csi_dpd_status =3D 0xe0c4,
> +	.disp_dpd_req =3D 0xe0d0,
> +	.disp_dpd_status =3D 0xe0d4,
> +	.qspi_dpd_req =3D 0xe074,
> +	.qspi_dpd_status =3D 0xe078,
> +	.ufs_dpd_req =3D 0xe064,
> +	.ufs_dpd_status =3D 0xe068,
> +	.edp_dpd_req =3D 0xe05c,
> +	.edp_dpd_status =3D 0xe060,
> +	.sdmmc1_hv_dpd_req =3D 0xe054,
> +	.sdmmc1_hv_dpd_status =3D 0xe058,
>  };
> =20
>  static const char * const tegra234_reset_sources[] =3D {
> @@ -3861,10 +4000,10 @@ static const struct tegra_pmc_soc tegra234_pmc_so=
c =3D {
>  	.needs_mbist_war =3D false,
>  	.has_impl_33v_pwr =3D true,
>  	.maybe_tz_only =3D false,
> -	.num_io_pads =3D 0,
> -	.io_pads =3D NULL,
> -	.num_pin_descs =3D 0,
> -	.pin_descs =3D NULL,
> +	.num_io_pads =3D ARRAY_SIZE(tegra234_io_pads),
> +	.io_pads =3D tegra234_io_pads,
> +	.num_pin_descs =3D ARRAY_SIZE(tegra234_pin_descs),
> +	.pin_descs =3D tegra234_pin_descs,
>  	.regs =3D &tegra234_pmc_regs,
>  	.init =3D NULL,
>  	.setup_irq_polarity =3D tegra186_pmc_setup_irq_polarity,
> --=20
> 2.17.1
>=20

--RG6ZG42KnPUXsFpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMh6lMACgkQ3SOs138+
s6EJYw//T9yRGZK3IN4xAgaQ+9iBoShk7OzBrz5emPmO97Ryxj66jJHMBCYXPh96
aJmfPv4duVkfDvc9xVhZO8iT8UA7auTLK4U8hntuPukJs2/CDBhyPzDTS1WZcHEF
pg2kn9DHL2MKEoPle6O3jYIdpvYC6n6BWfeQJlvh6Q/PWHqKOGSynQwBHUsKq11X
0hk7HaQyFNv2IYr1YqAvLARb5wVs3ZwKs7Y4JFViEAy1URifjiFSjW1jODa1jipa
dIrk4/WqdxNrd4ZHwVLk3kJEPvYONgp9MpvW4xvMxjH31Z1sSe5aNpvJoT6xz7kG
NMBYKn5wkTbOWKYb6P0UnZgLWyuCAEL7MHurNOQfk1ABxChzcjFEbNx3KTSATceM
DZosBOWiui36V/BnqmDAwcIcPBX1dVWbs2gCD5WOJzUJ9CBZIvY8uHQviGIKqHEt
FYVbikCaHRRvc1yaiwMqT8frp7N2la/vGv71T2R0jflcahQg3B9QbG1U0HiIBlp0
TUoAqOojtkhMEmZZgaK5J4iNQ9Cj07z6DsBdbBu0RvJJGZoInzFuZjS5DEXWhoIf
FSitcAHII8EUdz2ShG+ozHyiYabbox68NuwfnToKIdE5czL4oUh5utUxCrYa0HPJ
/79VQUxef3nITTCeq+/UHWscoU4Pmqnxwsk59Pe7RSv2x0sFCzM=
=vw2I
-----END PGP SIGNATURE-----

--RG6ZG42KnPUXsFpt--
