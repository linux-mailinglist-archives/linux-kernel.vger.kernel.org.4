Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1474D966
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjGJPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:00:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0527CC7;
        Mon, 10 Jul 2023 08:00:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso46930945e9.3;
        Mon, 10 Jul 2023 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689001250; x=1691593250;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgNdvy7uBnfZ8sTtRYFpvd6zr2uVUWJePVfQlfDzojU=;
        b=bXJzF+0WK4hy8edm+VUdlxl2XMIn4gkHlW3DKi9vihtiOUEzQxI2Geg3vE5BypWU/3
         MLOC8mXf0fh9Eg8twutCgkitXArObFz5py6tBrg2TgFrNNJ3B5ZYNRMONcRja7U1WCKZ
         bqU2IV3W3Vipzb9PefuUGGwGylT3CO4X12BaOIwqtHzpSE2GyIbfiglfKeYf7Z3x4dpw
         F5Lih3IBOYoGkFD/gmgcDyijn9wzPtU+wpBpltye9Ash8OcsOxuhQKa4cBcMI4YCtYzh
         oWG5W5E6TyIOgkhlXCgZ7ULcLGkREERUpeD0lgckpsLRemFVw4dyoDVC8MVDd4IR6WKB
         Z8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001250; x=1691593250;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgNdvy7uBnfZ8sTtRYFpvd6zr2uVUWJePVfQlfDzojU=;
        b=DrLBBtToc4vCWQk26FRRi0g6TJAAqlNLRxo06x71nLvvA41MVNZLajDEPORJaJ4Uay
         6zP4UcmeQeMsVnsEul1iDHpHi2B9eBVXSXSsNQ2H5BMf079zgxPygQPCBUZcIlEI6jP4
         CYqUhEJU9+VfdhN7FSbteb6WzwoJ6by34JrafEy/ktdRV6LTiUbxhzWLQqJxHMG/sFeZ
         e2GSe4mOTi7gmSEMrsSB5tOG2x2DDhe7gVS4cauVc3I06YDj/ETpe5GLFFui7ySMroR8
         Md2icNxIBB7kuCR1OL4c+qKHcE6LzFWbwHTllAyduXmnwSZZLLk8Bf04PYTaBeT40YyN
         EBFA==
X-Gm-Message-State: ABy/qLa7gp1Bu4TuS7o7lIfZJhd6NFjJamr8EmIur2hsMqKkpcD486mJ
        gQig7yWQrp/EDv7tkTlh/Y4=
X-Google-Smtp-Source: APBJJlEX8JLpKQSEd99lR/7Bk9da7qPOghYmxpxRE8rZSkfWd02375ITt1K8F7nZZzeh0BJJzIA6xA==
X-Received: by 2002:a7b:c413:0:b0:3fb:ffba:cd76 with SMTP id k19-20020a7bc413000000b003fbffbacd76mr8787621wmi.11.1689001248658;
        Mon, 10 Jul 2023 08:00:48 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q21-20020a7bce95000000b003fc06169abdsm129848wmj.2.2023.07.10.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:00:48 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:00:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     claudiu.beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: enable clk when pwm already enabled in
 bootloader
Message-ID: <ZKwdHUWzXujfVk0R@orome>
References: <20230710144214.63343-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PpEzny3LgeSzGCEI"
Content-Disposition: inline
In-Reply-To: <20230710144214.63343-1-aarongt.shen@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PpEzny3LgeSzGCEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 10:42:14PM +0800, Guiting Shen wrote:
> The driver would never call clk_eanble() if the pwm channel already
> enable in bootloader which lead to dump the warning message of "the pwm
> clk already disabled" when poweroff the pwm channel.
>=20
> Add atmel_pwm_enanle_clk_if_on() in probe function to enable clk if the
> pwm channel already enabled in bootloader.

You've got multiple spelling errors in the commit message. Also, PWM is
an abbreviation and so should be all uppercase (except for the subject
prefix). I also prefer spelling out terms like "clock" in the commit
message. This is text that is supposed to be readable. It's not code.

>=20
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index cdbc23649032..385f12eb604c 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -464,6 +464,29 @@ static const struct of_device_id atmel_pwm_dt_ids[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
> =20
> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
> +{
> +	u32 sr, i;

Maybe make i an unsigned int since you use it to iterate over npwm,
which is unsigned int as well.

> +	int err;
> +
> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR);
> +	if (!sr)
> +		return 0;
> +
> +	for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> +		if (!(sr & (1 << i)))

We would usually write this as BIT(i), but I see that the rest of the
driver uses this notation, so it's fine to keep this as-is.

> +			continue;
> +
> +		err =3D clk_enable(atmel_pwm->clk);
> +		if (err) {
> +			dev_err(atmel_pwm->chip.dev, "enable clock error\n");

Might be worth to include the error code in the error message to make it
easier to diagnose where the issue is. Something like:

	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %d\n", err);

> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int atmel_pwm_probe(struct platform_device *pdev)
>  {
>  	struct atmel_pwm_chip *atmel_pwm;
> @@ -504,6 +527,10 @@ static int atmel_pwm_probe(struct platform_device *p=
dev)
> =20
>  	platform_set_drvdata(pdev, atmel_pwm);
> =20
> +	ret =3D atmel_pwm_enable_clk_if_on(atmel_pwm);
> +	if (ret < 0)
> +		goto unprepare_clk;

This is not correct. You call this after pwmchip_add(), so you need to
make sure to also remove the PWM chip on error. Preferably, though, you
should call this before adding the PWM chip in the first place.

> +
>  	return ret;
> =20
>  unprepare_clk:
> --=20
> 2.25.1
>=20

--PpEzny3LgeSzGCEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSsHRoACgkQ3SOs138+
s6HwcA/7BFd9ge/azWqrQpQcrEonM4lx7ehmrULQvoO7zYkybxukrb6mzYne8MuM
4Cw4Nw9wUGCglxP2L7epAXLhTQVmZIS16Q+jMSkAHTOshLXuuoqJpifsgTuLz7zk
4aMu4NtZ4dFjDvq3850Y5qbXMRjLUEDMxgpn05TzBQYX1OPO8N4vgk//69NoyaZU
8nqT7TrjOUNHCE9RIrQxzH1YOAonPn3ke5B6CCllxnG4hk9xMQNSQHHwvqgJpZ9n
Kz6CQc44taCP4ERcVjyqG+PTJWEOZUSC1QuWMsDcW2AWiPjzeRdpC44MSoPyFT16
o30TIbIR5Jc1nOpy73Ohku/BWt18T6wqg2xVhacYoT8JdkUuQr7BDCXQeDa4xpg2
MfkRxQU6eTY/RuOfionH0H/XG+M8WIijD0Qtysxkh6c6PMM5Wgr6ES9XiWIco0rJ
KNBDDkVdA57QtozTKIUwYTfWp4IKpwFXA/sHsu8x0tCxsHR/Gn/p7RwByPHXvZVZ
dBDHqbxc0PWY/SqSswi2Zm46dWo0dDBztt42KcQ3fLerHiGFDUno+7YZjSE90O0g
sU+KaXmukBIHiNelpy9gGY5NmwEP2DfRnigDWULRjf5Hen4cCdIwqstLldGk1bS4
BzIowyhBBwrvx2oPPeLYcGD3pKoitpqj9hIwfOrxHOMxMQ3mpjg=
=SrRC
-----END PGP SIGNATURE-----

--PpEzny3LgeSzGCEI--
