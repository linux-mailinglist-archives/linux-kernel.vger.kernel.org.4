Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A67339E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjFPTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjFPTcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:32:25 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D0412B;
        Fri, 16 Jun 2023 12:32:24 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DBCBD1C0E73; Fri, 16 Jun 2023 21:32:22 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:32:22 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        ahplka19@gmail.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.1 20/33] ASoC: Intel: avs: Account for UID of
 ACPI device
Message-ID: <ZIy4xhk+kbe01gio@duo.ucw.cz>
References: <20230531134159.3383703-1-sashal@kernel.org>
 <20230531134159.3383703-20-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SOvNzeeURu6eDnYe"
Content-Disposition: inline
In-Reply-To: <20230531134159.3383703-20-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SOvNzeeURu6eDnYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Configurations with multiple codecs attached to the platform are
> supported but only if each from the set is different. Add new field
> representing the 'Unique ID' so that codecs that share Vendor and Part
> IDs can be differentiated and thus enabling support for such
> configurations.

Apparently this is preparation for something, but we should not need
it in AUTOSEL as noone will write the uid here.

Best regards,
								Pavel

> +++ b/include/sound/soc-acpi.h
> @@ -170,6 +170,7 @@ struct snd_soc_acpi_link_adr {
>  /* Descriptor for SST ASoC machine driver */
>  struct snd_soc_acpi_mach {
>  	u8 id[ACPI_ID_LEN];
> +	const char *uid;
>  	const struct snd_soc_acpi_codecs *comp_ids;
>  	const u32 link_mask;
>  	const struct snd_soc_acpi_link_adr *links;
> diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/=
board_selection.c
> index 87f9c18be238d..87353b4b0cd73 100644
> --- a/sound/soc/intel/avs/board_selection.c
> +++ b/sound/soc/intel/avs/board_selection.c
> @@ -394,7 +394,7 @@ static int avs_register_i2s_boards(struct avs_dev *ad=
ev)
>  	}
> =20
>  	for (mach =3D boards->machs; mach->id[0]; mach++) {
> -		if (!acpi_dev_present(mach->id, NULL, -1))
> +		if (!acpi_dev_present(mach->id, mach->uid, -1))
>  			continue;
> =20
>  		if (mach->machine_quirk)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SOvNzeeURu6eDnYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy4xgAKCRAw5/Bqldv6
8ol8AJ4uOFHJoMuMDzFPzmANHZBI9FyppgCfZF4s1exUHQZ/vAe9UVyPThqJntQ=
=Csam
-----END PGP SIGNATURE-----

--SOvNzeeURu6eDnYe--
