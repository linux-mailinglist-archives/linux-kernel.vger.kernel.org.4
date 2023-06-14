Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579D7304AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjFNQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjFNQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B52101;
        Wed, 14 Jun 2023 09:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE013641FA;
        Wed, 14 Jun 2023 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78FBC433C0;
        Wed, 14 Jun 2023 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686759300;
        bh=osSAHvFKMIO/cCPOuijjFPZuIw7zTc4XSarO6SeGtKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOZXkpqughP+6yDHDr/iXuYUQQVJN3FV81lEUSxOLXPgZr7XkgKHHFKmFC6h5hPbD
         +stzTnoz+dtAuXrVeNO69NJyimoBs9NwtQfmOvfSOpZGi5Tpz1RHXSeLp5sTwOX5CL
         UHEb5HYyLr5+iWPros+latdXJOEtb3kPyf9YkF8WS6rIpGviBS8f9HB/gdRBqkPaLa
         Ol0w7bPpAbVl8IqcAQTymTp2/hiVSzUTVIRVDcVRFX7nY7Gkc3sg8kgtNbCervw3JH
         AUjZm/1v/l5uuIc1m+wbQ7se7ZDg4ELVWsu9fjrz2i5ryUkepRCIUpo1RmDZ+tpNNk
         dzz017m2frKFA==
Date:   Wed, 14 Jun 2023 17:14:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] regulator: mt6358: Add output voltage fine tuning to
 fixed regulators
Message-ID: <a5c00706-dc23-4561-8bcf-729fd10e74ef@sirena.org.uk>
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-8-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FVyTKi8Xrk+toeDA"
Content-Disposition: inline
In-Reply-To: <20230609083009.2822259-8-wenst@chromium.org>
X-Cookie: MS-DOS must die!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FVyTKi8Xrk+toeDA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 04:30:04PM +0800, Chen-Yu Tsai wrote:
> The "fixed" LDO regulators found on the MT6358 and MT6366 PMICs have
> either no voltage selection register, or only one valid setting.
> However these do have a fine voltage calibration setting that can
> slightly boost the output voltage from 0 mV to 100 mV, in 10 mV
> increments.

This and the followup patch break the build on both arm64 and x86_64:

/build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =E2=
=80=98MT6358_VFE28_ANA_CON0=E2=80=99 undeclared here (not in a function); d=
id you mean =E2=80=98MT6358_VIO28_ANA_CON0=E2=80=99?
  127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
      |                             ^~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:525:9: note: in exp=
ansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
  525 |         MT6358_REG_FIXED("ldo_vfe28", VFE28, MT6358_LDO_VFE28_CON0,=
 0, 2800000),
      |         ^~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =E2=
=80=98MT6358_VCN28_ANA_CON0=E2=80=99 undeclared here (not in a function); d=
id you mean =E2=80=98MT6358_VCN18_ANA_CON0=E2=80=99?
  127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
      |                             ^~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:526:9: note: in exp=
ansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
  526 |         MT6358_REG_FIXED("ldo_vcn28", VCN28, MT6358_LDO_VCN28_CON0,=
 0, 2800000),
      |         ^~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =E2=
=80=98MT6358_VXO22_ANA_CON0=E2=80=99 undeclared here (not in a function); d=
id you mean =E2=80=98MT6358_VIO28_ANA_CON0=E2=80=99?
  127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
      |                             ^~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:527:9: note: in exp=
ansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
  527 |         MT6358_REG_FIXED("ldo_vxo22", VXO22, MT6358_LDO_VXO22_CON0,=
 0, 2200000),
      |         ^~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =E2=
=80=98MT6358_VAUX18_ANA_CON0=E2=80=99 undeclared here (not in a function); =
did you mean =E2=80=98MT6358_VRF18_ANA_CON0=E2=80=99?
  127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
      |                             ^~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:528:9: note: in exp=
ansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
  528 |         MT6358_REG_FIXED("ldo_vaux18", VAUX18,
      |         ^~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =E2=
=80=98MT6358_VBIF28_ANA_CON0=E2=80=99 undeclared here (not in a function); =
did you mean =E2=80=98MT6358_VIO28_ANA_CON0=E2=80=99?
  127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
      |                             ^~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:530:9: note: in exp=
ansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
  530 |         MT6358_REG_FIXED("ldo_vbif28", VBIF28,
      |         ^~~~~~~~~~~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =E2=
=80=98MT6358_VAUD28_ANA_CON0=E2=80=99 undeclared here (not in a function); =
did you mean =E2=80=98MT6358_VA12_ANA_CON0=E2=80=99?
  127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
      |                             ^~~~~~~
/build/stage/linux/drivers/regulator/mt6358-regulator.c:535:9: note: in exp=
ansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
  535 |         MT6358_REG_FIXED("ldo_vaud28", VAUD28,
      |         ^~~~~~~~~~~~~~~~

--FVyTKi8Xrk+toeDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJ530ACgkQJNaLcl1U
h9DhkAf9EVYQutfKyk5zzsMdyzKxxy1jBQx4nck+rXG0YrNyCWLNpIvxcyZNwDfP
GTkol0LepOtpOfVQVKnL3keDcs/vaP+q9Wy3++ZQHszZJWn6RapeZwNNfPQh03Ah
hS0U8RTVbgfQ2fNSdw9he638sRwNQ5nX7WOT6EcW5EIPa1hy2tIiXryQ0MX+0T0I
g7x2RANQx+Bbo1paDbHiF/38ZpR+RcfFhi/ZuLDCmhBTzenNht40NKGPbP8ZBrR1
xwyr1BMOyi++ISZ37nwUjpDL5o7PHdwLFYnEcXqNp2DsmeebwqbP3WXHA63dYB8r
RXqDQFtdb7J4Dvh0ErXLr/Oj/+8bWQ==
=w5A8
-----END PGP SIGNATURE-----

--FVyTKi8Xrk+toeDA--
