Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04455EDC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiI1L7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiI1L7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:59:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8F6555C;
        Wed, 28 Sep 2022 04:59:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a26so26653753ejc.4;
        Wed, 28 Sep 2022 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=WX1fGcDrRa8LUBuvI4gWJ/xa1ZpUTYVL+K0YkgByt8g=;
        b=XYAN7/uZmVVhvxch5PURlfz9TnlYdYDQ6iNKya3QJZ1U5nWTMBi/azONQ/u8lrUUBb
         NN2pxycnoOuiblKkFRbdvVriQmsW8VaCZa4hVQRE5RwLXfluBNq4BGRjKQcmEQufLTcy
         vi146TBxLZmM6RWiRSfsab+7w+vBlawcRzq9+y0snvycnW3kydVMKtDEhMdyrVHI/uBX
         7FF5P6CjaI2aNx2fDtVj9Hi80LEuuZiSSoiMx8TkJBUiPPihFel63FMhX0gfWJl2dFH5
         Ee2z80GlO/DJYWMDvH4vOIHnQH10EOejXeocv3Ln4HyI76+XC9HcOHT5X5xolrc4T8f/
         9ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WX1fGcDrRa8LUBuvI4gWJ/xa1ZpUTYVL+K0YkgByt8g=;
        b=px1xCuy5WKGW1LSdr/3v2lkyBmmFncMEQ4nFaPkfYfL6rJnGr6cVd67KEA/IYQujpJ
         42WxiGrFZXvWxBE2rm2KlTkmUWNYgSydWG8F1AOEMYVuEDXsOnGqXX9Sk8tHFPHxT/Px
         8hmkksW0rKcDErNBMnt9ajPzXsd60BIXAFIly0v6WJOazEUygN6SuOdE9shbLCDu2C/T
         HUMVtvJ3hsD0q4Ph8QePOmhZGwdqNpQyuI8ETyRZEHGMc+GabX+VaLOVQhkHuLXRvt83
         YZ1DohbnBuKDUU396zkeidfO3sxSaxRwW2qv8K+Sm7Q2zUJ/Q/LE2u8cWcUhstW1PpM2
         6fgw==
X-Gm-Message-State: ACrzQf34gd6Qj2lnVhlZDOSCCbIoMTE9e1FxGbFQB63SAuhgeVYu4VCr
        0luKMtC/eW8Q6o2p/8xohrY=
X-Google-Smtp-Source: AMsMyM4804Wv3dL9z7KIntSLwdAYgKLAjLvRcnZRK/+D28zGiFuNedfZJE6svXgWXDzao+/bFh0mwQ==
X-Received: by 2002:a17:907:8a0b:b0:783:be41:40b4 with SMTP id sc11-20020a1709078a0b00b00783be4140b4mr10902923ejc.111.1664366367932;
        Wed, 28 Sep 2022 04:59:27 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y4-20020aa7d504000000b00456d2721d93sm3145234edq.64.2022.09.28.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:59:26 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:59:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, u.kleine-koenig@pengutronix.de,
        linux-rockchip@lists.infradead.org, philipp.tomsich@vrull.eu,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, kever.yang@rock-chips.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        heiko@sntech.de
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Message-ID: <YzQ3He2wyD2bgxz1@orome>
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
 <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
 <20220912162159.GA1397560-robh@kernel.org>
 <37fd8d4b-3a66-bc51-c2dc-76c9e756fed8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="znR/AMl6swXutvbU"
Content-Disposition: inline
In-Reply-To: <37fd8d4b-3a66-bc51-c2dc-76c9e756fed8@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--znR/AMl6swXutvbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 04:38:32PM +0200, Johan Jonker wrote:
>=20
>=20
> On 9/12/22 18:21, Rob Herring wrote:
> > On Sat, Sep 10, 2022 at 09:48:04PM +0200, Johan Jonker wrote:
> >> Reduced CC.
> >>
> >> Hi Rob,
> >>
> >=20
> > Seemed like a simple enough warning to fix...
>=20
> Some examples for comment.
> Let us know what would be the better solution?
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> option1:
>=20
> 	combpwm0: combpwm0 {
> 		compatible =3D "rockchip,rv1108-combpwm";
> 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 		#address-cells =3D <2>;
> 		#size-cells =3D <2>;
>=20
> 		pwm0: pwm@20040000 {
> 			compatible =3D "rockchip,rv1108-pwm";
> 			reg =3D <0x20040000 0x10>;
> 		};
>=20
> 		pwm1: pwm@20040010 {
> 			compatible =3D "rockchip,rv1108-pwm";
> 			reg =3D <0x20040010 0x10>;
> 		};
>=20
> 		pwm2: pwm@20040020 {
> 			compatible =3D "rockchip,rv1108-pwm";
> 			reg =3D <0x20040020 0x10>;
> 		};
>=20
> 		pwm3: pwm@20040030 {
> 			compatible =3D "rockchip,rv1108-pwm";
> 			reg =3D <0x20040030 0x10>;
> 		};
> 	};
>=20
> PRO:
> - Existing driver might still work.
> CON:
> - New compatible needed to service the combined interrupts.
> - Driver change needed.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> option 2:
>=20
> 	combpwm0: pwm@10280000 {
> 		compatible =3D "rockchip,rv1108-pwm";
> 		reg =3D <0x10280000 0x40>;
> 		interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		pwm4: pwm-4@0 {
> 			reg =3D <0x0>;
> 		};
>=20
> 		pwm5: pwm-5@10 {
> 			reg =3D <0x10>;
> 		};
>=20
> 		pwm6: pwm-6@20 {
> 			reg =3D <0x20>;
> 		};
>=20
> 		pwm7: pwm-7@30 {
> 			reg =3D <0x30>;
> 		};
> 	};
>=20
> CON:
> - Driver change needed.
> - Not compatible with current drivers.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> Current situation:
>=20
> 	pwm0: pwm@20040000 {
> 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> 		reg =3D <0x20040000 0x10>;
> 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
> 	pwm1: pwm@20040010 {
> 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> 		reg =3D <0x20040010 0x10>;
> 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
> 	pwm2: pwm@20040020 {
> 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> 		reg =3D <0x20040020 0x10>;
> 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
> 	pwm3: pwm@20040030 {
> 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> 		reg =3D <0x20040030 0x10>;
> 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
> CON:
> - The property "interrupts 39" can only be claimed ones by one probe func=
tion at the time.
> - Has a fall-back string for rk3288, but unknown identical behavior for i=
nterrupts ???

To be honest, all three descriptions look wrong to me. From the above it
looks like this is simply one PWM controller with four channels, so it
should really be described as such, i.e.:

	pwm@20040030 {
		compatible =3D "rockchip,rv1108-pwm";
		reg =3D <0x20040030 0x40>;
		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
	};

Looking through existing Rockchip SoC DTSI files, though, it looks like
this has been done the wrong way since the beginning, so not sure if you
still want to fix it up.

This whole problem of dealing with a shared interrupt wouldn't be a
problem if this was described properly.

Thierry

--znR/AMl6swXutvbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0NxoACgkQ3SOs138+
s6F2DQ//SNItqjUD13hctOIu27Mgc1QlCOleIYcIh+Tvc1QSG838jZzQPNzG2+Ft
ZuWfVO3UfsF3Ny3OA+GvfTEJTCj5bZAFKb/HkoDlmAXDeYqteLREoO/jo8eVDPYx
Yyqs1l1UxpnJJIurdJtYWwyMVlzxXkVHH6+ZCidaf3oUvWCsrfFMbo/6V7YZmasU
22bjdfqqWexG86xbVsML6y2WNzMLiBlWxGwRPBEkOXwyJ7AcEk0KV7RiENxOERs7
zwI6rePM0V9CDUStIcO1mlhljgk/6h64v+yNFlTiDwgG3GjBSQGw5M0JyuvzYzWF
dj+62s4HnAwYWWldLJpR0RooYiW3GMXUHizY+KnevRcaLhMRwe/D4PFmZyuxumzN
ywnSDS6yIGN3DGKmz8/+YjvLLitmCvCzffNNlAMXnz29pz7RlirRhfCJylsPMs4R
VxCZFX6P7saeLzJn0jNBbZck2KcMWFK+uZJQ7hezYt81Z1vdRahymS6SelDlbQEA
fAkU1tudRbu062RNVnI9okSaLafrXVUdnhWdxuD+hCJWLv/2DYCKuEHmTXMTkCo5
GLtjPULz1Cz/GyHYBAAcKPXp/VcTVMm3sUXwHYlaJ67YyxFpZgQGfLej5y1+oJfU
cSFQu91Ek+ZogUFWckR/+oA0tq6VrZqG52O0tj8iMsS7JoB/Cz8=
=s0oH
-----END PGP SIGNATURE-----

--znR/AMl6swXutvbU--
