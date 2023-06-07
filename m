Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C48725D7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbjFGLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbjFGLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFF1BC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442EE616C0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93ADC433D2;
        Wed,  7 Jun 2023 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686138270;
        bh=ZIzmANL6SzlLASO7Q6YwNLFjhy6kknyeRB+38H5mVuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWCItiznTaIjXPD6oJgZdZ+a/+EUA7wwfpWE7eAQS+ozAXjokQoQv5JTGniOJ/3VT
         QWqvvHqY2XnmQNRxi2FTyxwIqhgCp/HPrlsQx5Wao+umGdzrC34kHupiQrg8Kp8hAZ
         KSlGv73cPqhN5FbpKRKMP81G3u0DkkgaJZwJnVg4Fs3Gm9W4NqKMq/yK8GN5VM9LUn
         T1tid/FXlzl7436fSVkftHFdoQSgO1gRrIdyvIKcfbmsv5E5cyRSU1kmt8MeEYHVc/
         MIL0j4yZj/RcTnkJdYa4WKV6cwTRGyV5RbLab9Sj4NaZc0VMqEjgNPqyE6UmNX0hzK
         UBZMnDoCACm+Q==
Date:   Wed, 7 Jun 2023 12:44:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: starfive: Cleanup and fix error check for
 JH7110 TDM
Message-ID: <3eb7ffc5-a16a-4ac2-93a0-260f7cb1f81c@sirena.org.uk>
References: <20230607081439.1517-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LfKPoAKPg/endcMK"
Content-Disposition: inline
In-Reply-To: <20230607081439.1517-1-walker.chen@starfivetech.com>
X-Cookie: Keep away from edge.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LfKPoAKPg/endcMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 04:14:39PM +0800, Walker Chen wrote:

> Some minor issues were found during addtional testing and static
> analysis. The patch fixed these minor issues.
> 1.Use BIT() macro to indicate configuration for TDM registers.
>=20
> 2.Fix the check for devm_reset_control_array_get_exclusive return
> value. The devm_reset_control_array_get_exclusive() function may return
> NULL if it's an optional request. If optional is intended then NULL
> should not be treated as an error case, but as a special kind of success
> case. So here the IS_ERR() is used to check better.

As covered in submitting-patches.rst please submit one patch per change
rather than combining multiple changes into a single patch, it makes
things much easier to review and handle.

> -	datarx =3D (tdm->rx.ifl << IFL_BIT) |
> -		  (tdm->rx.wl << WL_BIT) |
> -		  (tdm->rx.sscale << SSCALE_BIT) |
> -		  (tdm->rx.sl << SL_BIT) |
> -		  (tdm->rx.lrj << LRJ_BIT);
> +	datarx =3D (tdm->rxwl << 8) |
> +		  (tdm->rxsscale << 4) |
> +		  (tdm->rxsl << 2) |
> +		  TDM_PCMRXCR_LEFT_J;

I'm not sure this change to use numbers here is a win - the _BIT
definitions look fine (I might've called them _SHIFT but whatever).

> -static const struct of_device_id jh7110_tdm_of_match[] =3D {
> +static const struct of_device_id jh7110_tdm_match[] =3D {
>  	{ .compatible =3D "starfive,jh7110-tdm", },
>  	{}
>  };
> =20
> -MODULE_DEVICE_TABLE(of, jh7110_tdm_of_match);
> +MODULE_DEVICE_TABLE(of, jh7110_tdm_match);

This rename wasn't mentioned in the changelog.

--LfKPoAKPg/endcMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSAbZgACgkQJNaLcl1U
h9A99wf+NSaIxGIf4YZKSPJ7aahCikFSJ8QzZ93+jeCBXfB3MhCCrzVLVzFnUrv3
SQWddp2m5MWKBSt4icNmTEmweGEtv2Ec6FtXgo8dRimVUCd6W1EFxtT4UvzKJbiT
oFA3XyST93OE3gZxQpNehPIf6pXrgvtVfBlZLoqk4FdL1YS1VpD7EeOh5Y+afwYD
rWilBo5XnXxhx8a0rexNC9N/aDx6m3JGItGftPghXqQpGutTp0mRse92+pCiH79A
tfaG4ZEI9ugOXFuk+4uDhr5N2/6so5mS/ND5AHaFFSPLZ0AW0Q0Gr33vggAzxGCe
2QvWgXdAEkJikvqwETOVosS0KMHehA==
=CVs9
-----END PGP SIGNATURE-----

--LfKPoAKPg/endcMK--
