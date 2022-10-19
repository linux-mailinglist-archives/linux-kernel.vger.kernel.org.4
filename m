Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C656F603E61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiJSJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiJSJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:10:33 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54045BE2F1;
        Wed, 19 Oct 2022 02:02:31 -0700 (PDT)
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id CA10CC049B;
        Wed, 19 Oct 2022 08:46:41 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 51F08FF810;
        Wed, 19 Oct 2022 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666169161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpjsMDZZWLSjwamawi4W6gxlBloXg84sXExvFeg4K/8=;
        b=iezAfH7r21jpqg79JquZu7Os2NUXwJAeYQbkXDDDX0U8xQlaaNaaBbBxcQqwogS6kG/jwk
        tPO4oh50tIIHRqqyHlgg5vZV44E9+FA31EwYpK0Ufne26lgp0o1hL6JweuQFG0HfKhZKpV
        aXUIpOE6xulg+rQfgkOVB1+jVVmGHsN2DVdlunkQs6nB0qCi8+a+P3en5gYT1bcBe7CZtf
        x03u5/iD5jJbMBkzUbS+kgu/CJcdSr/4RsE0XqSbw9j9Boo8zJ8e/xuhQIiNfZQ1ZO04lO
        Bf7pKiMYJh/O3xxisInOfU+k1cPDUxtQ8XN4thmzBpWOBZQKyHhdasCmgQ+a/A==
Date:   Wed, 19 Oct 2022 10:45:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Liang Yang <liang.yang@amlogic.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH 3/3] mtd: rawnand: marvell: add support for AC5 SoC
Message-ID: <20221019104558.062ebf9f@xps-13>
In-Reply-To: <20221019082046.30160-4-vadym.kochan@plvision.eu>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
        <20221019082046.30160-4-vadym.kochan@plvision.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

vadym.kochan@plvision.eu wrote on Wed, 19 Oct 2022 11:20:40 +0300:

> From: Aviram Dali <aviramd@marvell.com>
>=20
> The following changes were made to add AC5 support:
>=20
>    1) Modify Marvell nand NFC timing set for mode 0
>=20
>    2) fix validation in AC5 Nand driver for ONFI timings values modes 1 a=
nd 3
>=20
>    3) remove unnecessary nand timing-mode in device tree of ac5.dtsi
>=20
>    4) add nand missing AC5X layouts , add option to use ndtr predefined v=
alues
>=20
>    5) Zero steps and total fields of ecc in ecc controller initialization=
 so
>       nand_scan_tail() will calculate these two fields, otherwise
>       NAND initialization will fail with kernel 5.15 and above.
>=20
> Signed-off-by: Aviram Dali <aviramd@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  drivers/mtd/nand/raw/Kconfig        |   2 +-
>  drivers/mtd/nand/raw/marvell_nand.c | 277 ++++++++++++++++++++++++----
>  2 files changed, 246 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 4cd40af362de..b7bb62f27e02 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -160,7 +160,7 @@ config MTD_NAND_MARVELL
>  	  including:
>  	  - PXA3xx processors (NFCv1)
>  	  - 32-bit Armada platforms (XP, 37x, 38x, 39x) (NFCv2)
> -	  - 64-bit Aramda platforms (7k, 8k) (NFCv2)
> +	  - 64-bit Aramda platforms (7k, 8k, ac5) (NFCv2)
> =20
>  config MTD_NAND_SLC_LPC32XX
>  	tristate "NXP LPC32xx SLC NAND controller"
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
> index b9d1e96e3334..940a89115782 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -226,6 +226,20 @@
>  #define XTYPE_COMMAND_DISPATCH	6
>  #define XTYPE_MASK		7
> =20
> +/* use tRP_min, tWC_min and tWP_min to distinct across timings modes */
> +#define IS_TIMINGS_EQUAL(t1, t2) \
> +		((t1->tRP_min =3D=3D t2->tRP_min &&\
> +		t1->tWC_min =3D=3D t2->tWC_min &&\
> +		t1->tWP_min =3D=3D t2->tWP_min) ? true : false)
> +
> +/*  ndtr0,1 set , each set has few modes level */
> +typedef enum marvell_nfc_timing_mode_set {
> +	MARVELL_NFC_NDTR_SET_0,		/* tested with ac5 */
> +
> +	MARVELL_NFC_NDTR_NUM_OF_SET,
> +	MARVELL_NFC_NDTR_SET_NON =3D MARVELL_NFC_NDTR_NUM_OF_SET
> +} marvell_nfc_timing_mode_set_t;
> +
>  /**
>   * struct marvell_hw_ecc_layout - layout of Marvell ECC
>   *
> @@ -283,14 +297,21 @@ struct marvell_hw_ecc_layout {
> =20
>  /* Layouts explained in AN-379_Marvell_SoC_NFC_ECC */
>  static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] =3D {
> -	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
> -	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
> -	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
> +	MARVELL_LAYOUT(512,   512,  1,  1,  1,  512,  8,  8,  0,   0,  0),
> +	MARVELL_LAYOUT(2048,   512,  1,  1,  1, 2048, 40, 24,  0,   0,  0),
> +	MARVELL_LAYOUT(2048,   512,  4,  1,  1, 2048, 32, 30,  0,   0,  0),
> +	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30,  1024, 32, 30),
> +	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30,  1024, 64, 30),
> +	MARVELL_LAYOUT(2048,   512,  12, 3,  2, 704,   0, 30,  640, 0,  30),
> +	MARVELL_LAYOUT(2048,   512,  16, 5,  4, 512,   0, 30,  0,   32, 30),
> +	MARVELL_LAYOUT(4096,   512,  4,  2,  2, 2048, 32, 30,  0,   0,  0),
> +	MARVELL_LAYOUT(4096,   512,  8,  5,  4, 1024,  0, 30,  0,   64, 30),
> +	MARVELL_LAYOUT(4096,   512,  12, 6,  5, 704,   0, 30,  576, 32, 30),
> +	MARVELL_LAYOUT(4096,   512,  16, 9,  8, 512,   0, 30,  0,   32, 30),
> +	MARVELL_LAYOUT(8192,   512,  4,  4,  4, 2048,  0, 30,  0,   0,  0),
> +	MARVELL_LAYOUT(8192,   512,  8,  9,  8, 1024,  0, 30,  0,  160, 30),
> +	MARVELL_LAYOUT(8192,   512,  12, 12, 11, 704,  0, 30,  448, 64, 30),
> +	MARVELL_LAYOUT(8192,   512,  16, 17, 16, 512,  0, 30,  0,   32, 30),
>  };

If you don't like the layout, it's fine, but you must do it in a
separate commit.

[...]

> +/*
> + * get nand timing-mode from device tree
> + */
> +static int get_nand_timing_mode(struct device_node *np)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret =3D of_property_read_u32(np, "nand-timing-mode", &val);
> +	return ret ? ret : val;
> +}
> +
>  /*
>   * Internal helper to conditionnally apply a delay (from the above struc=
ture,
>   * most of the time).
> @@ -2257,9 +2399,21 @@ static int marvell_nand_hw_ecc_controller_init(str=
uct mtd_info *mtd,
>  	}
> =20
>  	mtd_set_ooblayout(mtd, &marvell_nand_ooblayout_ops);
> -	ecc->steps =3D l->nchunks;
>  	ecc->size =3D l->data_bytes;
> =20
> +	/* nand_scan_tail func perform  validity tests for ECC strength, and it
> +	 * assumes that all chunks are with same size. in our case when ecc is =
12
> +	 * the chunk size is 704 but the last chunk is with different size so
> +	 * we cheat it nand_scan_tail validity tests by set info->ecc_size valu=
e to
> +	 * 512.

The driver already supports this, trying to cheat the core is bad. See
the last members of struct marvell_hw_ecc_layout.

> +	 */
> +	if (ecc->strength =3D=3D 12)
> +		ecc->size =3D 512;
> +
> +	/* let nand_scan_tail() calculate these two fields */
> +	ecc->steps =3D 0;
> +	ecc->total =3D 0;
> +
>  	if (ecc->strength =3D=3D 1) {
>  		chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;
>  		ecc->read_page_raw =3D marvell_nfc_hw_ecc_hmg_read_page_raw;
> @@ -2360,9 +2514,11 @@ static int marvell_nfc_setup_interface(struct nand=
_chip *chip, int chipnr,
>  	struct marvell_nand_chip *marvell_nand =3D to_marvell_nand(chip);
>  	struct marvell_nfc *nfc =3D to_marvell_nfc(chip->controller);
>  	unsigned int period_ns =3D 1000000000 / clk_get_rate(nfc->core_clk) * 2;
> -	const struct nand_sdr_timings *sdr;
> +	const struct nand_sdr_timings *sdr, *timings;
>  	struct marvell_nfc_timings nfc_tmg;
>  	int read_delay;
> +	marvell_nfc_timing_mode_set_t modes_set;
> +	int mode =3D 0;
> =20
>  	sdr =3D nand_get_sdr_timings(conf);
>  	if (IS_ERR(sdr))
> @@ -2421,32 +2577,71 @@ static int marvell_nfc_setup_interface(struct nan=
d_chip *chip, int chipnr,
>  			nfc_tmg.tR =3D 0;
>  	}
> =20
> -	if (chipnr < 0)
> -		return 0;
> =20
> -	marvell_nand->ndtr0 =3D
> -		NDTR0_TRP(nfc_tmg.tRP) |
> -		NDTR0_TRH(nfc_tmg.tRH) |
> -		NDTR0_ETRP(nfc_tmg.tRP) |
> -		NDTR0_TWP(nfc_tmg.tWP) |
> -		NDTR0_TWH(nfc_tmg.tWH) |
> -		NDTR0_TCS(nfc_tmg.tCS) |
> -		NDTR0_TCH(nfc_tmg.tCH);
> +	/* get the timing modes from predefined values according to its compati=
bility */
> +	if (nfc->caps->is_marvell_timing_modes) {
> +		/* get the mode set */
> +		modes_set =3D nfc->caps->timing_mode_set;
> +		if (modes_set >=3D MARVELL_NFC_NDTR_SET_NON) {
> +			dev_warn(nfc->dev,
> +				"Warning: not supported timing registers set,use set number 0 by def=
ault\n");
> =20
> -	marvell_nand->ndtr1 =3D
> -		NDTR1_TAR(nfc_tmg.tAR) |
> -		NDTR1_TWHR(nfc_tmg.tWHR) |
> -		NDTR1_TR(nfc_tmg.tR);
> +			modes_set =3D MARVELL_NFC_NDTR_SET_0;
> +		}
> =20
> -	if (nfc->caps->is_nfcv2) {
> -		marvell_nand->ndtr0 |=3D
> -			NDTR0_RD_CNT_DEL(read_delay) |
> -			NDTR0_SELCNTR |
> -			NDTR0_TADL(nfc_tmg.tADL);
> +		/* find the caller mode according to timings values */
> +		/* if exit on error it means no more modes; not suppose to happen */
> +		do {
> +			timings =3D onfi_async_timing_mode_to_sdr_timings(mode);

The timing negotiation is handled by the core, I don't see why you
would need this.

> +			if (IS_TIMINGS_EQUAL(timings, sdr))
> +				break;
> +			mode++;
> +		} while (!IS_ERR(timings));
> +
> +		/* if mode is not supported by NFC, return false or if nand-timing-mod=
e that
> +		 * exists in device tree greater then caller mode also return false an=
d wait
> +		 * for caller to try with next mode (mode-1). we want the nand feature=
 to be
> +		 * configured with nand-timing-mode value.
> +		 */
> +		if (mode > nfc->caps->max_mode_number ||
> +			 ((marvell_nand->nand_timing_mode) >=3D 0 &&
> +			 (mode > marvell_nand->nand_timing_mode)))
> +			return -EOPNOTSUPP;

[...]

> @@ -2681,6 +2877,10 @@ static int marvell_nand_chip_init(struct device *d=
ev, struct marvell_nfc *nfc,
>  	if (of_property_read_bool(np, "marvell,nand-keep-config"))
>  		chip->options |=3D NAND_KEEP_TIMINGS;
> =20
> +	/* read the mode from device tree */
> +	dn =3D nand_get_flash_node(chip);
> +	marvell_nand->nand_timing_mode =3D get_nand_timing_mode(dn);

I'm sorry but unless you give me a really convincing explanation, this
is not gonna work. The timing mode should be negotiated between the
controller and the chip, then the controller needs to configure its own
registers to fit these timings. There is no way the timing mode should
be hardcoded in the device tree.
=20
> +
>  	mtd =3D nand_to_mtd(chip);
>  	mtd->dev.parent =3D dev;
> =20

Thanks,
Miqu=C3=A8l
