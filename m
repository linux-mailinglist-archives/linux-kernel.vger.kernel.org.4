Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A724D636203
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiKWOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiKWOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:40:33 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FBC42F57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:40:31 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id g10so12512600qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz0LuQHYwR1IVYCnxnd6r23v7LzIiHX/ImxeAU/8TJU=;
        b=e4uJ8SZmd27oXyqnenMSBkCujFM8krETeCDV1SNB714vs/5368IIzrdTppiYRYYBeA
         Dedarg1r757+xNiNE94WxWKdW1LpFsBFQGS0n664AtH1M4tFzF/rzF6MEsd7NWeGs84o
         dSyK2JSYTq2cwlALHnwKkGYGqnM+7GVKbCko3twE9b6rdT1gKNDnnPxH4lNx3HDaAZ4Q
         5eigcz6HADLpQ2uQS/rDbGRFxdi4NiPNfEZo1osyLl3Zu+0CN10IRDmNbPU51/J9S3os
         LG9iKBDLnm/L17WTu+R007fedMLxZIS+lLM1juWpNhuTNY9UKTM/bEPRJHWEIbjy6ywz
         OYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz0LuQHYwR1IVYCnxnd6r23v7LzIiHX/ImxeAU/8TJU=;
        b=L/ldTmy9/IeY1JE1YQXIhp8jrlaBfHK2Ou4kTvjLtpesTZjuuHQxcBh9Bp7I9xv9C9
         1263YGyMvNHEATVuqSODxKZiPVy4UJpcQiiPigjL4t2pbVq1ESnc2P83Po7RVTwgsCxu
         dhHbtRxirV0hmr7qAB+7RsRbeM+0tWhwxUb+SRc6PGc3r/wCY3PO5uU4pM1RMRGKvPEv
         2LER4f7IRmG6/OEGBtHCgzv+UO12y/i2/QoLvxcxYvgdYnh4LMPD87f5ESrb+bqviNb6
         ADgv+jUCEjAWo5PGpEmXc97kai4LLY+BcfA4jl1363p5CgeMBN4nPNDm4r81oelx+rey
         x+wA==
X-Gm-Message-State: ANoB5pkE/CYOdPdMCAZzRj7AqiGx7UeKPYyInZ7CG2JoA4gw4KQVc859
        b2/WvZEP/w5pLGmdSU7lr2rTwA==
X-Google-Smtp-Source: AA0mqf6f0MDPV/iuxooMGg51/bf6XxMqtUg/KS/WCIylcctIF7X6pHS1ru7KSKKhkZxwGrIuUW1xEg==
X-Received: by 2002:a37:94c6:0:b0:6fa:2ff9:e9ca with SMTP id w189-20020a3794c6000000b006fa2ff9e9camr10506670qkd.29.1669214430309;
        Wed, 23 Nov 2022 06:40:30 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm11642208qkd.57.2022.11.23.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:40:29 -0800 (PST)
Date:   Tue, 22 Nov 2022 02:27:50 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, alexandre.torgue@foss.st.com,
        olivier.moysan@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix the check on arr and cmp
 registers update
Message-ID: <Y3x59hNekCDuOFXT@fedora>
References: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0mgwEUJf1fyfHdJ1"
Content-Disposition: inline
In-Reply-To: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0mgwEUJf1fyfHdJ1
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

This is a reasonable fix, but I don't like seeing so much happening in
an argument list -- it's easy to misunderstand what's going on which can
lead to further bugs the future. Pull out this condition to a dedicated
bool variable with a comment explaining why we need the equivalence
check (i.e. to ensure both status bits are set and not just one).

William Breathitt Gray

--0mgwEUJf1fyfHdJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3x59gAKCRC1SFbKvhIj
K6m4AQDYJtNkjZVyUJNcrrWZaOlUfodLz2Yx1BuFjg5YDeGpZAEA7CMFKO+r2JFh
jyelDpd6Evs3sxh1gwWAWDB4cv5E1gk=
=eIOy
-----END PGP SIGNATURE-----

--0mgwEUJf1fyfHdJ1--
