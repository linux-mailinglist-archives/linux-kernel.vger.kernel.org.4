Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445DD7339DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbjFPT3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbjFPT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:29:19 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B718A35A7;
        Fri, 16 Jun 2023 12:28:41 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8B2781C0E73; Fri, 16 Jun 2023 21:28:40 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:28:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        sre@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 02/10] power: supply: bq27xxx: Use
 mod_delayed_work() instead of cancel() + schedule()
Message-ID: <ZIy36DQpTDmWpoiW@duo.ucw.cz>
References: <20230531134606.3385210-1-sashal@kernel.org>
 <20230531134606.3385210-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EaxUnMLs5lHj6lcq"
Content-Disposition: inline
In-Reply-To: <20230531134606.3385210-2-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EaxUnMLs5lHj6lcq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Hans de Goede <hdegoede@redhat.com>
>=20
> [ Upstream commit 59dddea9879713423c7b2ade43c423bb71e0d216 ]
>=20
> Use mod_delayed_work() instead of separate cancel_delayed_work_sync() +
> schedule_delayed_work() calls.

AFAICT this is just a cleanup, we should not need it for -stable.

Best regards,
								Pavel
							=09
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -832,10 +832,8 @@ static int poll_interval_param_set(const char *val, =
const struct kernel_param *k
>  		return ret;
> =20
>  	mutex_lock(&bq27xxx_list_lock);
> -	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
> -		cancel_delayed_work_sync(&di->work);
> -		schedule_delayed_work(&di->work, 0);
> -	}
> +	list_for_each_entry(di, &bq27xxx_battery_devices, list)
> +		mod_delayed_work(system_wq, &di->work, 0);
>  	mutex_unlock(&bq27xxx_list_lock);
> =20
>  	return ret;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EaxUnMLs5lHj6lcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy36AAKCRAw5/Bqldv6
8tOGAJ92KfaSYd21/AuA3wj54IX/BTc+aACgkAHtvdlIChNkJ6noZxal400vZdc=
=Y/fx
-----END PGP SIGNATURE-----

--EaxUnMLs5lHj6lcq--
