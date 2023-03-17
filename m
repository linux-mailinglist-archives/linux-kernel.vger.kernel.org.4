Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD056BF1D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCQTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:40:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A428CB8571;
        Fri, 17 Mar 2023 12:40:37 -0700 (PDT)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8181A66030C4;
        Fri, 17 Mar 2023 19:40:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679082035;
        bh=Ez8htNwV6hiCuJJ5bg3KiGn6GZ+ZptFMQp+ghf8/tRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMx97s6DuC6nBEn21eqRlEaiJXEQA0vZUBeZa25ND5MDvYt5JLNjrF8Y6C1NpPkL/
         BwwpvPwOV3hM2mADiyHfHBw/xiUE0tNnV7yWlFMBeuBfEMNFAllg6RtUkEOreS++xC
         G19KpDcz0MsXVj6kAbb+chR71EGjCgUr8ZgIZeMBcHtZaIkPADzBG6OQ6NW/gReoBs
         1LbNGM/WjG47Q53dUC5Pnh0WrJvDhjKW6sc7oR+bpMh1F27Fq3XPn+Mlt6aEAxGPxl
         vu/wKhyneC/T+6KoqDi1YZXx/FBWqueqkTwL9bCPnQjjLMs8z333tpy0xZOgfMRw6l
         GOOQ0MwlQ7k9Q==
Received: by mercury (Postfix, from userid 1000)
        id 8127B10620FB; Fri, 17 Mar 2023 20:40:32 +0100 (CET)
Date:   Fri, 17 Mar 2023 20:40:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Anton Gusev <aagusev@ispras.ru>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] power: supply: generic-adc-battery: remove redundant
 return code assignment
Message-ID: <20230317194032.widpyvv6f4dqapla@mercury.elektranox.org>
References: <20230317170007.25692-1-aagusev@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gqsaijm7pp7dfxxo"
Content-Disposition: inline
In-Reply-To: <20230317170007.25692-1-aagusev@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqsaijm7pp7dfxxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 17, 2023 at 08:00:07PM +0300, Anton Gusev wrote:
> Since any subsequent uses of ret reassign it first and PTR_ERR does not
> have any effect on its own, this line has no effect and can be removed.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Anton Gusev <aagusev@ispras.ru>
> ---

Thanks, but the correct thing to do is using ret, which is WIP:

https://lore.kernel.org/linux-pm/20230314225535.1321736-4-sre@kernel.org/T/=
#u

-- Sebastian

>  drivers/power/supply/generic-adc-battery.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/s=
upply/generic-adc-battery.c
> index 66039c665dd1..b51e5c4b36ff 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -285,7 +285,6 @@ static int gab_probe(struct platform_device *pdev)
>  		adc_bat->channel[chan] =3D iio_channel_get(&pdev->dev,
>  							 gab_chan_name[chan]);
>  		if (IS_ERR(adc_bat->channel[chan])) {
> -			ret =3D PTR_ERR(adc_bat->channel[chan]);
>  			adc_bat->channel[chan] =3D NULL;
>  		} else {
>  			/* copying properties for supported channels only */
> --=20
> 2.39.2
>=20

--gqsaijm7pp7dfxxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQUwikACgkQ2O7X88g7
+poDNQ//ZJVnez02u5/gIUx/p6ANkdpx19bnGMta5LLVb+ycj+fq78Z7rfYHYtbS
JCVCnKy+ciiHO+hHWPNzFqPEDbVoWe0hh8tMiX6cgnIDn4VzWo/mctj1Ib3RwiTC
Sw3uTz5o5mW4uaCzhyGHOjxgzws7DwQZG9FQxKEeTdRURJRgQTwln35mnixUJW8O
VyphZiE8DCKvSsvfz3rlxa2XsCe6lIhLAaz16o1f9jSk/uwVdgOu5XpnqQEBNYON
jnnlRuzffquAtUfkIZhoPkqJ1YF698v4Dk1bWGaCAARTJ7+TFeIpBHLLvTGKkc11
Iu0fuSXDW1P+lSGkq97Do5+9GuHsfhXeCKAqI+8MIffa1BMDteXiL9+ScsfkXSsH
bU6xolg6eZr9BBl7bEEeAzfscUQZzWXKlD3Kh8pu8Klr9JIR7HtNHyO9E40Y5OEv
+8vxOnVM2jNHhaWd+zoe19UjLltOu80s0Kmna+e0r5A9sJapk5h96cp6/VjDPdPc
PRGGsiGdNZtIBMBcz0F0ESjMno+Z69etecGRf4SDcuoRKzkOfl/0jBdbRNex0b+/
cs10HsGRDfyJHl7gDceLBgmtImFZ5oCkzUZDDS5RzZBVz/0MZZTVF5vSf7FY2laP
rrzKLiDwfW7swoUGO9yAZ2QOjyWbvmJqmDLAKskHCR34MpzkxGk=
=ce23
-----END PGP SIGNATURE-----

--gqsaijm7pp7dfxxo--
