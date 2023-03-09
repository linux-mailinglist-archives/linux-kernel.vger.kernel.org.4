Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A56B3220
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCIXjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCIXjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:39:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78610F5A9E;
        Thu,  9 Mar 2023 15:39:18 -0800 (PST)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C6146602FA9;
        Thu,  9 Mar 2023 23:39:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678405156;
        bh=sw0SP7znHcbMaYLFlrdtC+IVpzQcmnkAonuPK990SE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/ma3Reoeh8jLwaUGRS9wce6nvdmXYeStCA5md3BjcboEUIUZGvGMcUWjHE61klfl
         fwe9TpoJLed6W5IVb87jIBPbJYCG39yahdxjZ+o1mcU2uDSLDaUTc3jQHfvfvxkiZj
         JK6AX4xafOn2sKLIswsp9qL464cRuK+Oz8IE6Vnku8l6/wE9sVB7saE1Nq0LfUpgfU
         4wQT4YAoKpXpZWt9HzQspN7j7KdlcGu6IEKbg3QjcShVaOb8j7vOfj0DMKeftw0OdT
         TSPMZoJwqtncjVZWgkcKHi4v1duRLXmjapqPhaXf+juBDWji2gMmg347q6J7w3jA4g
         yX2ou+i8OAWjg==
Received: by mercury (Postfix, from userid 1000)
        id 1E448106083C; Fri, 10 Mar 2023 00:39:13 +0100 (CET)
Date:   Fri, 10 Mar 2023 00:39:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     support.opensource@diasemi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH] power: supply: da9150: Fix use after free bug in
 da9150_charger_remove due to race condition
Message-ID: <e5b1ee16-796e-43fe-b703-3ce06aed364d@mercury.local>
References: <20230309181036.262674-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yn5uwxsqlu5pcour"
Content-Disposition: inline
In-Reply-To: <20230309181036.262674-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yn5uwxsqlu5pcour
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 10, 2023 at 02:10:36AM +0800, Zheng Wang wrote:
> In da9150_charger_probe, &charger->otg_work is bound with
> da9150_charger_otg_work. da9150_charger_otg_ncb may be
> called to start the work.
>=20
> If we remove the module which will call da9150_charger_remove
>  to make cleanup, there may be a unfinished work. The possible
>   sequence is as follows:
>=20
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove

mtk_jpeg_remove?

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
> Fixes: c1a281e34dae ("power: Add support for DA9150 Charger")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---

Looks correct to me, but the cancel_work_sync should happen after
usb_unregister_notifier(), otherwise there is still a race
condition.

-- Sebastian

>  drivers/power/supply/da9150-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply=
/da9150-charger.c
> index 14da5c595dd9..41b68f2f6ed8 100644
> --- a/drivers/power/supply/da9150-charger.c
> +++ b/drivers/power/supply/da9150-charger.c
> @@ -642,6 +642,7 @@ static int da9150_charger_remove(struct platform_devi=
ce *pdev)
>  	struct da9150_charger *charger =3D platform_get_drvdata(pdev);
>  	int irq;
> =20
> +	cancel_work_sync(&charger->otg_work);
>  	/* Make sure IRQs are released before unregistering power supplies */
>  	irq =3D platform_get_irq_byname(pdev, "CHG_VBUS");
>  	free_irq(irq, charger);
> --=20
> 2.25.1
>=20

--yn5uwxsqlu5pcour
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQKbhUACgkQ2O7X88g7
+pozKRAAkt+cogTU0OitcVOC7xKmnQ9usa1JLlbQavCplC7OB37jUPNmMwexLRdn
Y+KXwUPBV6RtIAUzqpqfRy5DRxbtTt5j4n1Ibs3l5gV/iuprncTI3tnGC/YMaJrM
u89V5+BTW6A6qy1HjcQNFewwwC6GglBy4Upgk6h0rb4MZQxboqZzgRzv8mCmuHZl
7yMQtmrgd7EmSrcPSkevrnVSKaKzHGmSt8KBmgAuMD9Cewhubg9cmr2gg8tHfhAs
11zDQWBIy529qH7zgiwTFssRJ7RTcYrlobEtWKTKvOy/j9ah4s+anB4i/VGmP+lK
DjdnBTz63sXZ+eFPqhe0Po96uRlBmGbznP3v9cXtCyWuXdVj1zzsOMUacjJ3RGwj
4o6xlg90id5xKshOyOYF3nHSUYNSz4pOZw+DgdtVMBN/Z/VLVfRVttG2Tf3RzOoW
/jR2wqB5FmMWgoxbtDmdCGr62KPOC8Mie22Oklr3IEZaB365CJ9Zwk8uquZJaPdy
i2syS0mHxis5n4q7F6B2olckwDLPxYvYrXXcp/cM1HG68ixvWhHsAakyVsHxa9t8
xnaj5fM72lK9SQhL37oFrV15nQ20nwxFhNXlGH0uA3gq5sHI2EDqJuuwkBK/X//A
4PdQ7iJKNADN8ScFnJMwEL3eumT3MhGzWAvw4vzSP9hawR2XEzY=
=x/P3
-----END PGP SIGNATURE-----

--yn5uwxsqlu5pcour--
