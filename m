Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F330702F31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjEOOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbjEOOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:04:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892802D4B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:04:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyYnm-0004LX-BA; Mon, 15 May 2023 16:03:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyYnj-000Ne8-Ma; Mon, 15 May 2023 16:03:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyYni-004iKq-Tk; Mon, 15 May 2023 16:03:46 +0200
Date:   Mon, 15 May 2023 16:03:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     thierry.reding@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
Subject: Re: [PATCH] pwm: mtk_disp: Fix the disable flow of disp_pwm
Message-ID: <20230515140346.bxeu6xewi6a446nd@pengutronix.de>
References: <20230515061845.10241-1-shuijing.li@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xy34fhkdf5yx4n7e"
Content-Disposition: inline
In-Reply-To: <20230515061845.10241-1-shuijing.li@mediatek.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xy34fhkdf5yx4n7e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 02:18:45PM +0800, Shuijing Li wrote:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.
>=20
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 79e321e96f56..cb699fa9a5ae 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -80,10 +80,9 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		return -EINVAL;
> =20
>  	if (!state->enabled) {
> -		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
> -					 0x0);
> -
>  		if (mdp->enabled) {
> +			mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
> +						 mdp->data->enable_mask, 0x0);
>  			clk_disable_unprepare(mdp->clk_mm);
>  			clk_disable_unprepare(mdp->clk_main);

Instead of

	if (A) {
		if (B) {
			something();
		}
	}

you can make this

	if (A && B) {
		something();
	}

Otherwise looks ok.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xy34fhkdf5yx4n7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRiO8IACgkQj4D7WH0S
/k4QEAf+JHyksmF99O3MatxvWpRlUB1TuPVQTawSXYmRI+LWvxVsetJ2CF7tEnBF
diKT9cqjr4C9V1pV79GYZxRoRHlGA0AsgWnWusKtSX+4Dk4LWB4vfOSnTnQdHMjr
prAECcJ9nl4om3uzCTpq/yY4j+bZDw71NguLu6qomx7SLIROjCr7dKgC6mJaY8JF
oU7Bdj4LXRLFujZ9hJh1Rt4Sefmsvl59Mo30b938tom9Q1gpONm00k+ou/IY4nfc
fGus4rqaHyuoYE2dyWNdTW2saURDF82BArYXSGonBdDAVZpOpF8VfJRC/NHtiF55
MWFAgU85n/UCoRYhwpUaVnEDb8Q5JA==
=MHoD
-----END PGP SIGNATURE-----

--xy34fhkdf5yx4n7e--
