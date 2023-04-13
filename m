Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EBA6E0C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:06:32 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C901722;
        Thu, 13 Apr 2023 04:06:31 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E56251C0AB2; Thu, 13 Apr 2023 13:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681383989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXZ0PSYYEUSQM6MUSU71WkUYgkP2oLrJLIzkIBO8434=;
        b=N6WXCJQDiINNrIEwT8U18KBjg96Szyb1Q95VOeDY0uA5RkJFYnQ16GsoiFqv7HyXn0/k5w
        wIcvmF43g2konV7rwQ/43yfMAY0r/3nnVgqm6gvTQK+kZj3/w9Xj4h4AXJjJ9voKaQ3v3n
        4ldD4oBPYcOzBgdCV02juaMF1i9vUno=
Date:   Thu, 13 Apr 2023 13:06:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and
 MT6332
Message-ID: <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CMT5ytgWM88tDRdu"
Content-Disposition: inline
In-Reply-To: <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CMT5ytgWM88tDRdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add basic code to turn on and off WLEDs and wire up MT6332 support
> to take advantage of it.
> This is a simple approach due to to the aforementioned PMIC supporting
> only on/off status so, at the time of writing, it is impossible for me
> to validate more advanced functionality due to lack of hardware.


> @@ -467,14 +590,24 @@ static int mt6323_led_probe(struct platform_device =
*pdev)
>  			goto put_child_node;
>  		}
> =20
> +		is_wled =3D of_property_read_bool(child, "mediatek,is-wled");
> +

This needs documenting in the binding, no?

> +static const struct mt6323_hwspec mt6332_spec =3D {
> +	/* There are no LEDs in MT6332. Only WLEDs are present. */

"Only WLED is present"?=20

> +	.max_leds =3D 0,
> +	.max_wleds =3D 1,
> +	.max_brightness =3D 1024,
> +};
> +

Is there chip with both LED and WLEDs? (I'm wondering if this makes
sense in single driver).

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--CMT5ytgWM88tDRdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfiNQAKCRAw5/Bqldv6
8v6VAJ93zFWTkbyH0IbcZNqsmvmIBiG//gCgqu69T4ZeaIUzp48MojiPkugt8CQ=
=AxkP
-----END PGP SIGNATURE-----

--CMT5ytgWM88tDRdu--
