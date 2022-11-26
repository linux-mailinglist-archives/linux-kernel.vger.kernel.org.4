Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D2639851
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 22:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKZVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 16:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 16:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F892C2;
        Sat, 26 Nov 2022 13:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587C360B7E;
        Sat, 26 Nov 2022 21:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A697C433D6;
        Sat, 26 Nov 2022 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669499625;
        bh=OWkY+Q2AWHHXFpSYHf6WVJ2BPlgIehXKQ01/N2rvGaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1v53UmAPr8Bf3PvMGy4A8+6b9BD+005Qgy3zdIdZmS55GXSn8lUT/WqsuR+yVoWh
         NPfZCiKmmh+Pmr2zOMAaYsfdhNCeAT5W0ydBKcMrIyutVjIQwteCc5KRevYDfDH9gO
         a9cIi9crJmND0aAgqH4BjwKlSE9SqeVOAqU3HYixofEsYxQ/2bHaxDvNh2SpJY6vRJ
         0Vy4RRawgdZJK5CT8SKTXEuavb/DBwM0ahJOhLw6eDy+6sZnz7xzadI9GhrTXYp/cX
         yn5TR+Trin/61/PPNWy7BgYWir4NukjFrkTErghEBZCKIKM1O50neo73BZxAQLKMV1
         mjkdslwV+3n8A==
Date:   Sat, 26 Nov 2022 16:53:42 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     william.gray@linaro.org, jic23@kernel.org,
        alexandre.torgue@foss.st.com, olivier.moysan@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix the check on arr and cmp
 registers update
Message-ID: <Y4KK5tck2aCdKWXF@ishi>
References: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u770lf6WZ1x5I9rX"
Content-Disposition: inline
In-Reply-To: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u770lf6WZ1x5I9rX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 02:36:09PM +0100, Fabrice Gasnier wrote:
> The ARR (auto reload register) and CMP (compare) registers are
> successively written. The status bits to check the update of these
> registers are polled together with regmap_read_poll_timeout().
> The condition to end the loop may become true, even if one of the register
> isn't correctly updated.
> So ensure both status bits are set before clearing them.
>=20
> Fixes: d8958824cf07 ("iio: counter: Add support for STM32 LPTimer")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to the counter-current branch of counter.git.

William Breathitt Gray

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-=
lptimer-cnt.c
> index d6b80b6dfc28..8439755559b2 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -69,7 +69,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lp=
tim_cnt *priv,
> =20
>  	/* ensure CMP & ARR registers are properly written */
>  	ret =3D regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
> -				       (val & STM32_LPTIM_CMPOK_ARROK),
> +				       (val & STM32_LPTIM_CMPOK_ARROK) =3D=3D STM32_LPTIM_CMPOK_ARRO=
K,
>  				       100, 1000);
>  	if (ret)
>  		return ret;
> --=20
> 2.25.1
>=20

--u770lf6WZ1x5I9rX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY4KK5gAKCRC1SFbKvhIj
K+deAQC6ZXzAa3xdZuWBglzIaSy1YgvjYJNRFUV1M62hbScaawD8CRdlC/3xIFg2
fNtfcSsKjpct2CfSS9TwcuYUKf32ewI=
=xvBl
-----END PGP SIGNATURE-----

--u770lf6WZ1x5I9rX--
