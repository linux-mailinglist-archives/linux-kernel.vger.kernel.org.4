Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD176815A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjA3PzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjA3PzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:55:01 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D8483D1;
        Mon, 30 Jan 2023 07:55:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id dr8so11461445ejc.12;
        Mon, 30 Jan 2023 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3sFXOuMqveoRXd7c7rTvCNrAHt/0EUfBDQLk4NsWDU=;
        b=eBDJP3zeF2CAaV0hDs5MvtyoDr/wOEgmEWdDUxKIEuFmRz/dNOcgE6ZHva18qRQVpZ
         C8GCVx3eWCu10vVpwL2r3KutFHUFC55AOTX4PklKY7UxKZd3wRDxT6aKe7cT0XmxgJoX
         Ss4KHwtUNBBjxqJaUukTI4+WgDPL5riWQ4wavqeB+U6gNZjTIrBVCgOzMVi7ht93pmku
         u0V9+44goKViY0qPYTns7eb9Btc/4k7/ED18rCeuJ5PMLq4999ZlHYG8obKkGnqwiXUs
         P027f+Kl+XyyY4LaRmmpbV3BlP13SF9a+hKPYCmBXzknBrW7xZiY0fU7Gk3UqfT8n872
         mzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3sFXOuMqveoRXd7c7rTvCNrAHt/0EUfBDQLk4NsWDU=;
        b=FChlX8KrdP6j48COA6aDN0mcFO/Xf05FN2vqQeLvPCPBCwkqoGyrn/tHhpDJonDlFn
         LYIsOmW3dTotoIMkPmUrJBl2d+IdBKOW0u9daEf4Q4ZcVpZczVYYBy8aP6p/OsqSqCeT
         c3mWFwNqXSQFsF/MD6GXJvJsmYlPNuM7dSa7yKKoYk6n7tS+D+BbFUFsmir/u9BVvSbr
         7CNlHEomvJ2fxOb3lbvcVpOJDlT7WzgwzPJ9/7UiuZ+XES96kdixTUJ0WYGyBuwwtIms
         HzyLRGxUGhfcpkQnt0alruHKZN6GmNydNpSX3o9ATpDtc+rKlmmBMIrLjW+aZYwumX9c
         xsnQ==
X-Gm-Message-State: AO0yUKWfZiPu+6R1OEw2Z7DXbysypF5h2IYcRpGppnoclflht3z+436s
        U9Nm5+9gVoQlXSFUcYCtwcE=
X-Google-Smtp-Source: AK7set9zUUm0Jj+SonyVqg9785v4818CFDmFNQJTFN3ESMX3gDZbsqz/JP7M8gVpqikxOdzMlB1WWQ==
X-Received: by 2002:a17:907:1c0e:b0:87a:6a63:9014 with SMTP id nc14-20020a1709071c0e00b0087a6a639014mr16454978ejc.20.1675094098604;
        Mon, 30 Jan 2023 07:54:58 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b0084d34eec68esm7055612ejm.213.2023.01.30.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:54:57 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:54:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, john@phrozen.org, sean.wang@mediatek.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/2] arm64: dts: mediatek: mt7622: Add missing
 pwm-cells to pwm node
Message-ID: <Y9foUMtlMZfZ18nr@orome>
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
 <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
 <20221202180932.5k3vymrwds5ssivq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tt+4zDA4srW5HLc6"
Content-Disposition: inline
In-Reply-To: <20221202180932.5k3vymrwds5ssivq@pengutronix.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tt+4zDA4srW5HLc6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 07:09:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Nov 28, 2022 at 12:20:27PM +0100, AngeloGioacchino Del Regno wrot=
e:
> > Specify #pwm-cells on pwm@11006000 to make it actually usable.
> >=20
> > Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral relate=
d device nodes")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot=
/dts/mediatek/mt7622.dtsi
> > index 146e18b5b1f4..f321c6d0fd7c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > @@ -435,6 +435,7 @@ uart3: serial@11005000 {
> >  	pwm: pwm@11006000 {
> >  		compatible =3D "mediatek,mt7622-pwm";
> >  		reg =3D <0 0x11006000 0 0x1000>;
> > +		#pwm-cells =3D <2>;
>=20
> 3 should be possible, too. The driver does only support one
> polarity, so it's not really needed, but would be nice for consistency?
>=20
> Thierry, what's your take here?

There's little point in setting this to 3 if the driver doesn't support
it. The core should catch misconfiguration, but that's more of a fail-
safe and if we can just avoid this from the start by not allowing anyone
to specify inversed polarity that seems like a good idea.

Thierry

--Tt+4zDA4srW5HLc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPX6FAACgkQ3SOs138+
s6GHKg//ZEgZo9vAqHU2RnhvwzEqB5Lj0Ga0bH0vzXcHSsZDpr8YSGqWraBHHppV
UJuzylMJGnmJnNkz6YsDWLiZaUgtGcUUxSMHeDC6iYvc+HjlZfvHf4xxEA7IQauE
UwYDyXVHCKxsWtvRR4VO/l93LasCoA1Qt1CP4mfUOZ3gvbiFP6BR1iTKZ8balc6C
izOytiVpiXsIUTiJN4dJvkEcTUgysLuUIRfYtVigBckcf8nmNEvfNHzTUJ2p8QTQ
14PSEIsfJAkcOXIyl2PYajd5L6Nn72rxH8vgoF6aX4PhPSXMknjeIzNtMAebmmd4
2tLGNaB0MliHCRmjDjcd7ELY9dNuzH8drODRsMzoIPG5HLSBftUmVhVC5elZKtjb
xq069ysSwdSKEa2/emVmFWTgt+G7XQ67ZYOhUxPTJXgNq5J3HA7bKffOleXIaUvX
Dqj83mJu6mE+dHsoGYyoIuV+YO74bsaKGqP3CK8xHHZUs2n28h2OIEGxQh2vLkja
CH3d/T0Awdqr7VqUQp5rWGnwylKnx8RkjDC73tyVzTn5ld4NmJMqnfEpatuwvzjG
iSowdQrNiyZIdofe+S8qiNy1vNBPOWio5miVRRfm30678h0hVYMEe+745wSBMkp/
oidl1RGU72RmnK+ySUPPomygTW13jOimthZSfo3DIdpqRdMSJxI=
=g4sq
-----END PGP SIGNATURE-----

--Tt+4zDA4srW5HLc6--
