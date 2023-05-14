Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266D70208B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjENWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:47:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F1A10EA;
        Sun, 14 May 2023 15:47:14 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38EDB660574D;
        Sun, 14 May 2023 23:47:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684104432;
        bh=jzi2W6+T87Paq1k90LpdVJqP6jY5jiBJbfQIOzShu8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ldm1+EthsCVFX0t6RSp4Ly82jfUGZ4x+bZyrpcKdwrrzd3ZOqgpFJQcoKB2vHRlSb
         89iQ3fL12+1eZx5+lIynau6E+52zOo4N0FaHLNJ5Rl1E5x5ZvK/yPntZ8Dziy0wECh
         ZwT6cX30B2h2tm074KfKWoj50IX7th0sizGDONNAe+AbdzdMDQOSYVYYkX3DsAFDni
         +ao0/I22F59j6Fd+g0d4Q5fMhiPgiGgjdqrxgUWP5+AhUHCr4aKqcTSgvQYDrZrH3K
         UByQ+y+B7ycMK8QnaLwSxrH7ZctvfgVZl0n14c269VlK6QVbKjwcpvWIYo/kIx+pOd
         hvz2mT/zN1A9Q==
Received: by mercury (Postfix, from userid 1000)
        id 872C41061381; Mon, 15 May 2023 00:47:09 +0200 (CEST)
Date:   Mon, 15 May 2023 00:47:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 06/10] power: supply: rt5033_charger: Add cable
 detection and USB OTG supply
Message-ID: <20230514224709.ltefid7yvjtzz5nj@mercury.elektranox.org>
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-7-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7y7n3cgahlgabso"
Content-Disposition: inline
In-Reply-To: <20230514123130.41172-7-jahau@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7y7n3cgahlgabso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 14, 2023 at 02:31:26PM +0200, Jakob Hauser wrote:
> Implement cable detection by extcon and handle the driver according to the
> connector type.
>=20
> There are basically three types of action: "set_charging", "set_otg" and
> "set_disconnect".
>=20
> A forth helper function to "unset_otg" was added because this is used in =
both
> "set_charging" and "set_disconnect". In the first case it covers the rath=
er
> rare event that someone changes from OTG to charging without disconnect. =
In
> the second case, when disconnecting, the values are set back to the ones =
=66rom
> initialization to return into a defined state.
>=20
> Additionally, there is "set_mivr". When connecting to e.g. a laptop/PC, t=
he
> minimum input voltage regulation (MIVR) shall prevent a voltage drop if t=
he
> cable or the supply is weak. The MIVR value is set to 4600MV, same as in =
the
> Android driver [1]. When disconnecting, MIVR is set back to DISABLED.
>=20
> In the function rt5033_get_charger_state(): When in OTG mode, the chip
> reports status "charging". Change this to "discharging" because there is
> no charging going on in OTG mode [2].
>=20
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/battery/rt5033_charger.c#L499
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/battery/rt5033_charger.c#L686-L687
>=20
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/rt5033_charger.c | 276 +++++++++++++++++++++++++-
>  1 file changed, 274 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply=
/rt5033_charger.c
> index 1aa346dd0679..7c7fd4cf0623 100644
> --- a/drivers/power/supply/rt5033_charger.c
> +++ b/drivers/power/supply/rt5033_charger.c
> @@ -6,7 +6,10 @@
>   * Author: Beomho Seo <beomho.seo@samsung.com>
>   */
> =20
> +#include <linux/devm-helpers.h>
> +#include <linux/extcon.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> @@ -26,6 +29,14 @@ struct rt5033_charger {
>  	struct regmap			*regmap;
>  	struct power_supply		*psy;
>  	struct rt5033_charger_data	*chg;
> +	struct extcon_dev		*edev;
> +	struct notifier_block		extcon_nb;
> +	struct work_struct		extcon_work;
> +	struct mutex			lock;
> +	bool online;
> +	bool otg;
> +	bool mivr_enabled;
> +	u8 cv_regval;
>  };
> =20
>  static int rt5033_get_charger_state(struct rt5033_charger *charger)
> @@ -56,6 +67,10 @@ static int rt5033_get_charger_state(struct rt5033_char=
ger *charger)
>  		state =3D POWER_SUPPLY_STATUS_UNKNOWN;
>  	}
> =20
> +	/* For OTG mode, RT5033 would still report "charging" */
> +	if (charger->otg)
> +		state =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +
>  	return state;
>  }
> =20
> @@ -147,6 +162,9 @@ static inline int rt5033_init_const_charge(struct rt5=
033_charger *charger)
>  		return -EINVAL;
>  	}
> =20
> +	/* Store that value for later usage */
> +	charger->cv_regval =3D reg_data;
> +
>  	/* Set end of charge current */
>  	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
>  	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
> @@ -330,6 +348,152 @@ static int rt5033_charger_reg_init(struct rt5033_ch=
arger *charger)
>  	return 0;
>  }
> =20
> +static int rt5033_charger_set_otg(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/* Set OTG boost v_out to 5 volts */
> +	ret =3D regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
> +			RT5033_CHGCTRL2_CV_MASK,
> +			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed set OTG boost v_out\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set operation mode to OTG */
> +	ret =3D regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
> +			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to update OTG mode.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* In case someone switched from charging to OTG directly */
> +	if (charger->online)
> +		charger->online =3D false;
> +
> +	charger->otg =3D true;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
> +{
> +	int ret;
> +	u8 data;
> +
> +	/* Restore constant voltage for charging */
> +	data =3D charger->cv_regval;
> +	ret =3D regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
> +			RT5033_CHGCTRL2_CV_MASK,
> +			data << RT5033_CHGCTRL2_CV_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to restore constant voltage\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set operation mode to charging */
> +	ret =3D regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
> +			RT5033_CHGCTRL1_MODE_MASK, RT5033_CHARGER_MODE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to update charger mode.\n");
> +		return -EINVAL;
> +	}
> +
> +	charger->otg =3D false;
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_set_charging(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/* In case someone switched from OTG to charging directly */
> +	if (charger->otg) {
> +		ret =3D rt5033_charger_unset_otg(charger);
> +		if (ret)
> +			return -EINVAL;
> +	}
> +
> +	charger->online =3D true;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/*
> +	 * When connected via USB connector type SDP (Standard Downstream Port),
> +	 * the minimum input voltage regulation (MIVR) should be enabled. It
> +	 * prevents an input voltage drop due to insufficient current provided
> +	 * by the adapter or USB input. As a downside, it may reduces the
> +	 * charging current and thus slows the charging.
> +	 */
> +	ret =3D regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
> +			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to set MIVR level.\n");
> +		return -EINVAL;
> +	}
> +
> +	charger->mivr_enabled =3D true;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	/* Beyond this, do the same steps like setting charging */
> +	rt5033_charger_set_charging(charger);
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/* Disable MIVR if enabled */
> +	if (charger->mivr_enabled) {
> +		ret =3D regmap_update_bits(charger->regmap,
> +				RT5033_REG_CHG_CTRL4,
> +				RT5033_CHGCTRL4_MIVR_MASK,
> +				RT5033_CHARGER_MIVR_DISABLE);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to disable MIVR.\n");
> +			return -EINVAL;
> +		}
> +
> +		charger->mivr_enabled =3D false;
> +	}
> +
> +	if (charger->otg) {
> +		ret =3D rt5033_charger_unset_otg(charger);
> +		if (ret)
> +			return -EINVAL;
> +	}
> +
> +	if (charger->online)
> +		charger->online =3D false;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	return 0;
> +}
> +
>  static enum power_supply_property rt5033_charger_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
> @@ -366,8 +530,7 @@ static int rt5033_charger_get_property(struct power_s=
upply *psy,
>  		val->strval =3D RT5033_MANUFACTURER;
>  		break;
>  	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval =3D (rt5033_get_charger_state(charger) =3D=3D
> -				POWER_SUPPLY_STATUS_CHARGING);
> +		val->intval =3D charger->online;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -402,6 +565,86 @@ static struct rt5033_charger_data *rt5033_charger_dt=
_init(
>  	return chg;
>  }
> =20
> +static void rt5033_charger_extcon_work(struct work_struct *work)
> +{
> +	struct rt5033_charger *charger =3D
> +		container_of(work, struct rt5033_charger, extcon_work);
> +	struct extcon_dev *edev =3D charger->edev;
> +	int connector, state;
> +	int ret;
> +
> +	for (connector =3D EXTCON_USB_HOST; connector <=3D EXTCON_CHG_USB_PD;
> +	     connector++) {
> +		state =3D extcon_get_state(edev, connector);
> +		if (state =3D=3D 1)
> +			break;
> +	}
> +
> +	/*
> +	 * Adding a delay between extcon notification and extcon action. This
> +	 * makes extcon action execution more reliable. Without the delay the
> +	 * execution sometimes fails, possibly because the chip is busy or not
> +	 * ready.
> +	 */
> +	msleep(100);
> +
> +	switch (connector) {
> +	case EXTCON_CHG_USB_SDP:
> +		ret =3D rt5033_charger_set_mivr(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set USB mode\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "USB mode. connector type: %d\n",
> +			 connector);
> +		break;
> +	case EXTCON_CHG_USB_DCP:
> +	case EXTCON_CHG_USB_CDP:
> +	case EXTCON_CHG_USB_ACA:
> +	case EXTCON_CHG_USB_FAST:
> +	case EXTCON_CHG_USB_SLOW:
> +	case EXTCON_CHG_WPT:
> +	case EXTCON_CHG_USB_PD:
> +		ret =3D rt5033_charger_set_charging(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set charging\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "charging. connector type: %d\n",
> +			 connector);
> +		break;
> +	case EXTCON_USB_HOST:
> +		ret =3D rt5033_charger_set_otg(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set OTG\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "OTG enabled\n");
> +		break;
> +	default:
> +		ret =3D rt5033_charger_set_disconnect(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set disconnect\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "disconnected\n");
> +		break;
> +	}
> +
> +	power_supply_changed(charger->psy);
> +}
> +
> +static int rt5033_charger_extcon_notifier(struct notifier_block *nb,
> +					  unsigned long event, void *param)
> +{
> +	struct rt5033_charger *charger =3D
> +		container_of(nb, struct rt5033_charger, extcon_nb);
> +
> +	schedule_work(&charger->extcon_work);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static const struct power_supply_desc rt5033_charger_desc =3D {
>  	.name =3D "rt5033-charger",
>  	.type =3D POWER_SUPPLY_TYPE_USB,
> @@ -414,6 +657,7 @@ static int rt5033_charger_probe(struct platform_devic=
e *pdev)
>  {
>  	struct rt5033_charger *charger;
>  	struct power_supply_config psy_cfg =3D {};
> +	struct device_node *np_conn, *np_edev;
>  	int ret;
> =20
>  	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> @@ -423,6 +667,7 @@ static int rt5033_charger_probe(struct platform_devic=
e *pdev)
>  	platform_set_drvdata(pdev, charger);
>  	charger->dev =3D &pdev->dev;
>  	charger->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	mutex_init(&charger->lock);
> =20
>  	psy_cfg.of_node =3D pdev->dev.of_node;
>  	psy_cfg.drv_data =3D charger;
> @@ -442,6 +687,33 @@ static int rt5033_charger_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * Extcon support is not vital for the charger to work. If no extcon
> +	 * is available, just emit a warning and leave the probe function.
> +	 */
> +	np_conn =3D of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector"=
, 0);
> +	np_edev =3D of_get_parent(np_conn);
> +	charger->edev =3D extcon_find_edev_by_node(np_edev);
> +	if (IS_ERR(charger->edev)) {
> +		dev_warn(&pdev->dev, "no extcon device found in device-tree\n");
> +		goto out;
> +	}
> +
> +	ret =3D devm_work_autocancel(&pdev->dev, &charger->extcon_work,
> +				   rt5033_charger_extcon_work);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize extcon work\n");
> +		return ret;
> +	}
> +
> +	charger->extcon_nb.notifier_call =3D rt5033_charger_extcon_notifier;
> +	ret =3D devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> +						&charger->extcon_nb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register extcon notifier\n");
> +		return ret;
> +	}
> +out:
>  	return 0;
>  }
> =20
> --=20
> 2.39.2
>=20

--l7y7n3cgahlgabso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRhZOkACgkQ2O7X88g7
+pqcPhAAnp3uPbsWZQNLL2PbBdjT1p1aFOojoM08QkeZEdx9qZCMQ7b4IRhWBpXs
kAkrHJ3k1yCZne2iCjV0Z8WtYIbyYNE6XAE89QISBXSpDdbDAjkj/F4EorMF4dV0
Kos6p46ShSJ6w1/B7iBqddq6zR2VtBxEA6XMRMJQolb0+PJowyCk43+qjA4iCu6M
k6P16cF3ngXEH6XqXBy/TOOm7T2Jbxhz3VLiIrB+mCi5YMZwr0CA2nDcJu6IXUTL
qdoPkmVrKF+5yiuhMnnspeOqEvqTn2uWdTZ04kBU57pasDkmlIeL2WJM8iXI8rFe
DW2lBxbdbqJ67OFQ89DXbyNOEvz/w7zisEfq5Lqb4WUomWq1tg/Yh9mD3GEFkZlC
sEBJcLc3WcZ4d7L2PeoedUT/+QUBU4MlsGkyrvK4LciA1VVrq1ksqDpBKcJ+lnzD
e075TQE3kEJEJ7CSy83WOVANCY25EQgTUXGm/HV6ZQ48TCJYN4aiklwm4nJyzy6f
OCcbAvy18f5s4F6jgqTpNxrxk9QnXvf1BBB2gafUdTWoU/OYHQXBV+8q5Uyrkaw8
gKQiJ/zu6zA2vEurPPJ/63wqZa+ZRpX6mITFGHhhQicesvsEGegVso5llSk55DPm
9o1gJ5ITdyrpfDCbMxikk/96MkHrFjQfKsqFC8z7PZv2idbtcOA=
=NXF6
-----END PGP SIGNATURE-----

--l7y7n3cgahlgabso--
