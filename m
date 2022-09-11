Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A355B5866
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiILK2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiILK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003B39B85;
        Mon, 12 Sep 2022 03:28:39 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C18846601FE4;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978517;
        bh=7zOI1MOtmrZG1lCJp1V/ZgNBmoqiPfqXovgtGBksErg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLTGj72otW00OUDFqm3GE8QazuKnS++JcAE29OvypOECrRI6rvSCseLfkRd+hs0bC
         ZDObjZuiVkMCraW66LI5C1OCa1InWA1E9kjBg3+hZ6Y2LVt6xI+Y555Fzzwh60R7FK
         UjjrS0fgY1s0shS7ZxjIEbDyXR/NmGRTUOj7bldhI7ATwKhYO5Mpx4RehD1kPHMRcj
         N/RPCJULBqgf0OlgX6pTBHD5h9xihrarXPpaHY8Tix08zBfjzAvxbu3SjVq7G3ZYdj
         +6s+2qRt0OUer/AiumFKMci9eMHp0qaPDob1Rkr2JVE5SzB5YAWB8tBjeVuS9SDBDp
         ef80KZnChSlsw==
Received: by mercury (Postfix, from userid 1000)
        id C3F111063355; Sun, 11 Sep 2022 14:17:58 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:17:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     t.schramm@manjaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cw2015: Use device managed API to
 simplify the code
Message-ID: <20220911121758.ngsuox7sm62edunk@mercury.elektranox.org>
References: <20220717025820.1610091-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6z6xd22ngwgbnmly"
Content-Disposition: inline
In-Reply-To: <20220717025820.1610091-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6z6xd22ngwgbnmly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 17, 2022 at 10:58:20AM +0800, Zheyu Ma wrote:
> Use devm_delayed_work_autocancel() instead of the INIT_DELAYED_WORK() to
> remove the cw_bat_remove() function.
>=20
> And power_supply_put_battery_info() can also be removed because the
> power_supply_get_battery_info() uses device managed memory allocation.
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cw2015_battery.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply=
/cw2015_battery.c
> index 728e2a6cc9c3..6d52641151d9 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -21,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/time.h>
>  #include <linux/workqueue.h>
> +#include <linux/devm-helpers.h>
> =20
>  #define CW2015_SIZE_BATINFO		64
> =20
> @@ -698,7 +699,8 @@ static int cw_bat_probe(struct i2c_client *client)
>  	}
> =20
>  	cw_bat->battery_workqueue =3D create_singlethread_workqueue("rk_battery=
");
> -	INIT_DELAYED_WORK(&cw_bat->battery_delay_work, cw_bat_work);
> +	devm_delayed_work_autocancel(&client->dev,
> +							  &cw_bat->battery_delay_work, cw_bat_work);
>  	queue_delayed_work(cw_bat->battery_workqueue,
>  			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
>  	return 0;
> @@ -725,15 +727,6 @@ static int __maybe_unused cw_bat_resume(struct devic=
e *dev)
> =20
>  static SIMPLE_DEV_PM_OPS(cw_bat_pm_ops, cw_bat_suspend, cw_bat_resume);
> =20
> -static int cw_bat_remove(struct i2c_client *client)
> -{
> -	struct cw_battery *cw_bat =3D i2c_get_clientdata(client);
> -
> -	cancel_delayed_work_sync(&cw_bat->battery_delay_work);
> -	power_supply_put_battery_info(cw_bat->rk_bat, cw_bat->battery);
> -	return 0;
> -}
> -
>  static const struct i2c_device_id cw_bat_id_table[] =3D {
>  	{ "cw2015", 0 },
>  	{ }
> @@ -752,7 +745,6 @@ static struct i2c_driver cw_bat_driver =3D {
>  		.pm =3D &cw_bat_pm_ops,
>  	},
>  	.probe_new =3D cw_bat_probe,
> -	.remove =3D cw_bat_remove,
>  	.id_table =3D cw_bat_id_table,
>  };
> =20
> --=20
> 2.25.1
>=20

--6z6xd22ngwgbnmly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd0fYACgkQ2O7X88g7
+pozUg//UbOpf3SbX4BM5ekfqfGz1znaeZxx494/nUnJnS0iL/NtBvV9mAHsenyu
wHTdkw9lAAfAO4gdpuHBafMXADqv/yx3H9oB67zmQCo0j7wKIr0qCpHG705Bnrr/
XVQ4zSwNsnoeU6EEw/bb9jZZnS47eLZXvl2UWFC/TkKrBD4jSFuk0lEVlPpN3szh
B75PU4Gt0l5Px8SYrWt7I3J+TLAdTOid3iynwEn/YSwPFC66uzRAnWnoILSOT5G5
Lx6UmIU9/Dzc4+KfLLvqUtWDeTUAHZZoNk0aHkjMSyFgOFg4hidFxDVMuRj4Jkuy
TwsOIdcBom5hFKZhxS6uFPRJpF2a2yDoel+eFZcxyVqxb+k+XEDSQFY51ZA6bOIR
V3s5NcMheQhKXa501HM5NA9l6hHW/RMM3spno/ayM92Y04qRl760lPVZIqPa6afl
2Z+0nqOQq98CZmng75QY/+jAAfHDmqu3JyoAaLywa6BM5i+bb+Zxqu3wbwX5U9e+
sKESqgmdQrU8DRzdBI+IW1a/NMHCTz4Y5RZp1zpoibyMPxeL4ppv95uGfwtyN2Bz
79PXrF8YtpXwOvLTtE4elrQoxd9kK7QEAIrD/y1thh3PKJde/+OKetuFZo6piQvw
Ocb5zQC4ieMfGhcXoNU+xQU25CM3+TAVaL2Tc31FnFnv7LFq9DY=
=QGTY
-----END PGP SIGNATURE-----

--6z6xd22ngwgbnmly--
