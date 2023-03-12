Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AACA6B6BFB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCLWbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCLWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:31:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABBB2C645;
        Sun, 12 Mar 2023 15:31:21 -0700 (PDT)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D05B6602F13;
        Sun, 12 Mar 2023 22:31:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678660279;
        bh=yUmV/Mjx17lxOmMA4cP3sFkL46N/lDYO7FhWwaVfMMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXk2NpVB+8MSoKloqICjnN6RGhm2lWhvfVFKqW54FxHX6/TE+pUSRpPezgnX053/b
         TpodM5kEqvUQ2Hq0wj73THxqekOxAzf67J067G1WqsrjpxwV62KqWsVp5PEFtdgWqp
         JbRUQFTlkKe6W2RgyiB3ykD57kpwIANIGbAFBhsqD3RiMvRx7rnTrS+6cYkvidF3Ys
         FNGEb/ozzX1VqM0MpQ/flBOYqy39n+gU5ikatFt6UfGzUF7FsO6wRJtuli47SkXNcs
         C97Fx13YCB+YbmdaHvVe+fgqE6hFCTQMtQ7o/leWjIES5boL0lfnePso+qEW2Prx+j
         Jt4w64sLzxNIw==
Received: by mercury (Postfix, from userid 1000)
        id 5F99A1060FD4; Sun, 12 Mar 2023 23:31:17 +0100 (CET)
Date:   Sun, 12 Mar 2023 23:31:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH v2] power: supply: da9150: Fix use after free bug in
  da9150_charger_remove due to race condition
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230311174650.3979517-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2apthxtojbiu375y"
Content-Disposition: inline
In-Reply-To: <20230311174650.3979517-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2apthxtojbiu375y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 12, 2023 at 01:46:50AM +0800, Zheng Wang wrote:
> In da9150_charger_probe, &charger->otg_work is bound with
> da9150_charger_otg_work. da9150_charger_otg_ncb may be
> called to start the work.
>=20
> If we remove the module which will call da9150_charger_remove
> to make cleanup, there may be a unfinished work. The possible
> sequence is as follows:
>=20
> Fix it by canceling the work before cleanup in the da9150_charger_remove
>=20
> CPU0                  CPUc1
>=20
>                     |da9150_charger_otg_work
> da9150_charger_remove      |
> power_supply_unregister  |
> device_unregister   |
> power_supply_dev_release|
> kfree(psy)          |
>                     |
>                     | 	power_supply_changed(charger->usb);
>                     |   //use
>=20
> Fixes: c1a281e34dae ("power: Add support for DA9150 Charger")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - fix wrong description in commit message and mov cancel_work_sync
> after usb_unregister_notifier suggested by Sebastian Reichel
> ---

Thanks, queued to power-supply's fixes branch. Please make sure you
send your patches to the correct destination next time (linux-scsi
should be linux-pm).

-- Sebastian

>  drivers/power/supply/da9150-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply=
/da9150-charger.c
> index 14da5c595dd9..a87aeaea38e1 100644
> --- a/drivers/power/supply/da9150-charger.c
> +++ b/drivers/power/supply/da9150-charger.c
> @@ -657,6 +657,7 @@ static int da9150_charger_remove(struct platform_devi=
ce *pdev)
> =20
>  	if (!IS_ERR_OR_NULL(charger->usb_phy))
>  		usb_unregister_notifier(charger->usb_phy, &charger->otg_nb);
> +	cancel_work_sync(&charger->otg_work);
> =20
>  	power_supply_unregister(charger->battery);
>  	power_supply_unregister(charger->usb);
> --=20
> 2.25.1
>=20

--2apthxtojbiu375y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOUrUACgkQ2O7X88g7
+povSw/+MDk1ALJfK5t/+F826SwdME6Ocl1W3YoVM72Xj9NTd41PQleGKapzNrpD
qB3rp8OQw+io3QvJDgk8WfMkdIXe4QwV0YB/k/iVkWeoEXLbg5GsbOD7aS4P4G6K
ANW629FZxD1ZzpWMCQMIw1/oYYTTxH25evgGOUGQMwSqxNbYpUbRwVWY13GFnX5f
qQ7yKIHeHUcIMaKWItPhXNzg+CtLwLjRARHYQHkhSyPvR87W/90fRQbUU62CokYi
qyMEVrAQoeMKjh3SbSnpfG3/CcRXNzIFNnX9+ZPy/14GlJmo5LVvYj8XLYTdQLCT
CfbpbJCPg6RzIpHAukD0TK5LdKvk3jaxafZS4zsWqw2NBFMdAzW+w6rsjsrN7Zag
+1hADykMvh78F+jr4+E9cOcTQlyHNqv+xsUzZq01bN7NUoYdnuUXDII6aUVQN/d+
mrvcR+6Nz0m8axEtYvSF4iwq+eIf3L7wLTzvcSZ0OWxUAbPI0dPNyAzbDXtKjEtE
4tQZxnWlw6Qf+i303/JxCjv8WSpkXpqeh/pdM94b7b7HLAqZr/HfTruz6N+niwOx
NzgR6Xx5pwrXOlflNU/ighnuNOtxtgHaVnbu7Uf6hvEzx7sRtZ05YTSrm4Fxr4ol
a664C/+1N5qyPmvTTKyUpFcZAqCSnT8skK5PeYcZ6oin+GipBZk=
=j4ZU
-----END PGP SIGNATURE-----

--2apthxtojbiu375y--
