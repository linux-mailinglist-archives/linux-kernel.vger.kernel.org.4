Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095C1639274
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKYXxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:52:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DCC1DA68;
        Fri, 25 Nov 2022 15:52:51 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 384D96602B72;
        Fri, 25 Nov 2022 23:52:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669420370;
        bh=tNb/Byxv+XfP3SsenGloDIQ1IxNNx5zlya+c7RliDy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URwB0snqpYeWAIz8pJzMN5fkbQmeXKAn0DGdk453QnUgdjjNJLi3cGtTwWAkyYrJq
         eX2t3OcfwdRwXdmiXJRyS5EKnsetuljG6liX7vQn03WUVMVrtOFOEb3YWv6WvV9FMk
         KAxp3ZVrVzvlbaLNumQ9VK9G3h85LzB+MZbUo0YXTAP+mYOotxl4RmSOIlULb+ZHGj
         wZZ1WPRKpj+JOFjhKeMwemkwNceVWS1ogP9+bsrq9l49yGQdZ1Yf4korD84Fw2jB9x
         vkuVWDeZdKm0FSOg07TK97GQrJDOt62WpQO6cTu3XVUoQ3FSBwIl5gVmzeDEbA/nOb
         gonKKNJPp/t+g==
Received: by mercury (Postfix, from userid 1000)
        id 2C92B10613A9; Sat, 26 Nov 2022 00:52:48 +0100 (CET)
Date:   Sat, 26 Nov 2022 00:52:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 03/13] rtc: rk808: reduce 'struct rk808' usage
Message-ID: <20221125235248.in6g5ynxmjm2zoc5@mercury.elektranox.org>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
 <20221020204251.108565-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="swyl53gknpslotjl"
Content-Disposition: inline
In-Reply-To: <20221020204251.108565-4-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--swyl53gknpslotjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Thu, Oct 20, 2022 at 10:42:41PM +0200, Sebastian Reichel wrote:
> Reduce usage of 'struct rk808' (driver data of the parent MFD), so
> that only the chip variant field is still being accessed directly.
> This allows restructuring the MFD driver to support SPI based
> PMICs.
>=20
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

You can take this patch. I don't think it makes sense to send
another version of this series before the merge window considering
it involves so many subystems. If the RTC patch is merged now it
does not need to become part of the immutable branch later :)

Thanks,

-- Sebastian

>  drivers/rtc/rtc-rk808.c | 47 ++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
> index e920da8c08da..2d9bcb3ce1e3 100644
> --- a/drivers/rtc/rtc-rk808.c
> +++ b/drivers/rtc/rtc-rk808.c
> @@ -14,7 +14,6 @@
>  #include <linux/bcd.h>
>  #include <linux/mfd/rk808.h>
>  #include <linux/platform_device.h>
> -#include <linux/i2c.h>
> =20
>  /* RTC_CTRL_REG bitfields */
>  #define BIT_RTC_CTRL_REG_STOP_RTC_M		BIT(0)
> @@ -51,7 +50,7 @@ struct rk_rtc_compat_reg {
>  };
> =20
>  struct rk808_rtc {
> -	struct rk808 *rk808;
> +	struct regmap *regmap;
>  	struct rtc_device *rtc;
>  	struct rk_rtc_compat_reg *creg;
>  	int irq;
> @@ -97,12 +96,11 @@ static void gregorian_to_rockchip(struct rtc_time *tm)
>  static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  {
>  	struct rk808_rtc *rk808_rtc =3D dev_get_drvdata(dev);
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
>  	u8 rtc_data[NUM_TIME_REGS];
>  	int ret;
> =20
>  	/* Force an update of the shadowed registers right now */
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
>  				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
>  				 BIT_RTC_CTRL_REG_RTC_GET_TIME);
>  	if (ret) {
> @@ -116,7 +114,7 @@ static int rk808_rtc_readtime(struct device *dev, str=
uct rtc_time *tm)
>  	 * 32khz. If we clear the GET_TIME bit here, the time of i2c transfer
>  	 * certainly more than 31.25us: 16 * 2.5us at 400kHz bus frequency.
>  	 */
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
>  				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
>  				 0);
>  	if (ret) {
> @@ -124,7 +122,7 @@ static int rk808_rtc_readtime(struct device *dev, str=
uct rtc_time *tm)
>  		return ret;
>  	}
> =20
> -	ret =3D regmap_bulk_read(rk808->regmap, rk808_rtc->creg->seconds_reg,
> +	ret =3D regmap_bulk_read(rk808_rtc->regmap, rk808_rtc->creg->seconds_re=
g,
>  			       rtc_data, NUM_TIME_REGS);
>  	if (ret) {
>  		dev_err(dev, "Failed to bulk read rtc_data: %d\n", ret);
> @@ -148,7 +146,6 @@ static int rk808_rtc_readtime(struct device *dev, str=
uct rtc_time *tm)
>  static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct rk808_rtc *rk808_rtc =3D dev_get_drvdata(dev);
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
>  	u8 rtc_data[NUM_TIME_REGS];
>  	int ret;
> =20
> @@ -163,7 +160,7 @@ static int rk808_rtc_set_time(struct device *dev, str=
uct rtc_time *tm)
>  	rtc_data[6] =3D bin2bcd(tm->tm_wday);
> =20
>  	/* Stop RTC while updating the RTC registers */
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M);
>  	if (ret) {
> @@ -171,14 +168,14 @@ static int rk808_rtc_set_time(struct device *dev, s=
truct rtc_time *tm)
>  		return ret;
>  	}
> =20
> -	ret =3D regmap_bulk_write(rk808->regmap, rk808_rtc->creg->seconds_reg,
> +	ret =3D regmap_bulk_write(rk808_rtc->regmap, rk808_rtc->creg->seconds_r=
eg,
>  				rtc_data, NUM_TIME_REGS);
>  	if (ret) {
>  		dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
>  		return ret;
>  	}
>  	/* Start RTC again */
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
>  	if (ret) {
>  		dev_err(dev, "Failed to update RTC control: %d\n", ret);
> @@ -191,12 +188,11 @@ static int rk808_rtc_set_time(struct device *dev, s=
truct rtc_time *tm)
>  static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *al=
rm)
>  {
>  	struct rk808_rtc *rk808_rtc =3D dev_get_drvdata(dev);
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
>  	u8 alrm_data[NUM_ALARM_REGS];
>  	uint32_t int_reg;
>  	int ret;
> =20
> -	ret =3D regmap_bulk_read(rk808->regmap,
> +	ret =3D regmap_bulk_read(rk808_rtc->regmap,
>  			       rk808_rtc->creg->alarm_seconds_reg,
>  			       alrm_data, NUM_ALARM_REGS);
>  	if (ret) {
> @@ -212,7 +208,7 @@ static int rk808_rtc_readalarm(struct device *dev, st=
ruct rtc_wkalrm *alrm)
>  	alrm->time.tm_year =3D (bcd2bin(alrm_data[5] & YEARS_REG_MSK)) + 100;
>  	rockchip_to_gregorian(&alrm->time);
> =20
> -	ret =3D regmap_read(rk808->regmap, rk808_rtc->creg->int_reg, &int_reg);
> +	ret =3D regmap_read(rk808_rtc->regmap, rk808_rtc->creg->int_reg, &int_r=
eg);
>  	if (ret) {
>  		dev_err(dev, "Failed to read RTC INT REG: %d\n", ret);
>  		return ret;
> @@ -228,10 +224,9 @@ static int rk808_rtc_readalarm(struct device *dev, s=
truct rtc_wkalrm *alrm)
> =20
>  static int rk808_rtc_stop_alarm(struct rk808_rtc *rk808_rtc)
>  {
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
>  	int ret;
> =20
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->int_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->int_reg,
>  				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M, 0);
> =20
>  	return ret;
> @@ -239,10 +234,9 @@ static int rk808_rtc_stop_alarm(struct rk808_rtc *rk=
808_rtc)
> =20
>  static int rk808_rtc_start_alarm(struct rk808_rtc *rk808_rtc)
>  {
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
>  	int ret;
> =20
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->int_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->int_reg,
>  				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M,
>  				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
> =20
> @@ -252,7 +246,6 @@ static int rk808_rtc_start_alarm(struct rk808_rtc *rk=
808_rtc)
>  static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alr=
m)
>  {
>  	struct rk808_rtc *rk808_rtc =3D dev_get_drvdata(dev);
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
>  	u8 alrm_data[NUM_ALARM_REGS];
>  	int ret;
> =20
> @@ -272,7 +265,7 @@ static int rk808_rtc_setalarm(struct device *dev, str=
uct rtc_wkalrm *alrm)
>  	alrm_data[4] =3D bin2bcd(alrm->time.tm_mon + 1);
>  	alrm_data[5] =3D bin2bcd(alrm->time.tm_year - 100);
> =20
> -	ret =3D regmap_bulk_write(rk808->regmap,
> +	ret =3D regmap_bulk_write(rk808_rtc->regmap,
>  				rk808_rtc->creg->alarm_seconds_reg,
>  				alrm_data, NUM_ALARM_REGS);
>  	if (ret) {
> @@ -313,20 +306,18 @@ static int rk808_rtc_alarm_irq_enable(struct device=
 *dev,
>  static irqreturn_t rk808_alarm_irq(int irq, void *data)
>  {
>  	struct rk808_rtc *rk808_rtc =3D data;
> -	struct rk808 *rk808 =3D rk808_rtc->rk808;
> -	struct i2c_client *client =3D rk808->i2c;
>  	int ret;
> =20
> -	ret =3D regmap_write(rk808->regmap, rk808_rtc->creg->status_reg,
> +	ret =3D regmap_write(rk808_rtc->regmap, rk808_rtc->creg->status_reg,
>  			   RTC_STATUS_MASK);
>  	if (ret) {
> -		dev_err(&client->dev,
> +		dev_err(&rk808_rtc->rtc->dev,
>  			"%s:Failed to update RTC status: %d\n", __func__, ret);
>  		return ret;
>  	}
> =20
>  	rtc_update_irq(rk808_rtc->rtc, 1, RTC_IRQF | RTC_AF);
> -	dev_dbg(&client->dev,
> +	dev_dbg(&rk808_rtc->rtc->dev,
>  		 "%s:irq=3D%d\n", __func__, irq);
>  	return IRQ_HANDLED;
>  }
> @@ -404,10 +395,12 @@ static int rk808_rtc_probe(struct platform_device *=
pdev)
>  		break;
>  	}
>  	platform_set_drvdata(pdev, rk808_rtc);
> -	rk808_rtc->rk808 =3D rk808;
> +	rk808_rtc->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!rk808_rtc->regmap)
> +		return -ENODEV;
> =20
>  	/* start rtc running by default, and use shadowed timer. */
> -	ret =3D regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
> +	ret =3D regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M |
>  				 BIT_RTC_CTRL_REG_RTC_READSEL_M,
>  				 BIT_RTC_CTRL_REG_RTC_READSEL_M);
> @@ -417,7 +410,7 @@ static int rk808_rtc_probe(struct platform_device *pd=
ev)
>  		return ret;
>  	}
> =20
> -	ret =3D regmap_write(rk808->regmap, rk808_rtc->creg->status_reg,
> +	ret =3D regmap_write(rk808_rtc->regmap, rk808_rtc->creg->status_reg,
>  			   RTC_STATUS_MASK);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> --=20
> 2.35.1
>=20

--swyl53gknpslotjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOBVU8ACgkQ2O7X88g7
+ppxwA/+Lv/unAz8u9jb/2tRuBfZnMgzjlDrcSm/vyVk7ywy1+5yQ3Zq7rHkgEsC
0ADE+/X8s8j30oSNV/tk+erosqaiKTcoR04pFFuP02h482Z128W0HaEQyudCR17S
mJroMh4oAFxJ2nyV2hokuTYRAV7cy7x4bOORV95Y44n5JEqraHa2fSlKge3EnBJg
/iRTSK0yPFm3DVi8p8dLh9Qd+FFOctSzbht4MTIwllva3T9SyxASMmHO9rUyNrCA
mQEMcumiUI3bDKJH7LPEqkkCZvDnsmFaCkAUagecUSDM3LB5Nj6kTtdOq2sEOd0G
ijc4jNQHHVAJbWwol5sJ/zzHdVgLsvKROkL2xsCCx7zaeXxgz/mcS0ZhR7x3KNle
cm1L4gLrb6vbt2OmxVzoqAaN7QmnDorEUaa0/NCj50DpZ+8AuEoaa7YHGYqTlOqI
StLCzLe/ETsWsuG5169/s12umsI2ITgGastL8zKraXWGOF14FzeHCoizCPOqDr6D
qGwFRPptMJ9PkHnKjxZF/1upD97bdv4P/6hsJf6qUOoHxf4TXIjBgyOen5QiXwP9
yPBVnBg7yDWOqw4JMju3HqL2tOBhQqQLOFp6/WH2bNH4GYmkMMsAiea7NBrH2UZL
oko6ST1mYkjStYatd4OsZqzseN7pVyh7fG07M6agK9l/s314uX0=
=Thkw
-----END PGP SIGNATURE-----

--swyl53gknpslotjl--
