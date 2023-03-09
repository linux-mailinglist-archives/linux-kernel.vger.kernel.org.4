Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC06B3224
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCIXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCIXkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:40:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C21F8F14;
        Thu,  9 Mar 2023 15:40:10 -0800 (PST)
Received: from mercury (unknown [185.209.196.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6968D6602F6A;
        Thu,  9 Mar 2023 23:40:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678405209;
        bh=yus2n4zT7YL65UzDvwPoMrXAkOB+W5gstntm6QHWC30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFLdcvl9PVt2oBbymAfYwIiHTQc4EWQE7mkSl2iIr4RFn1G7lJbxOwPAmo4fDVf6R
         TxrqkLjqix3dzXUk4n2vZMMjoAJINcT21b5HfiLLdwRw+T35RabcnGSzMPhV8HJ1Sx
         +zGp5rZEGffCjlO09hiuo6lWr/+H+qjID96/fEse7vsAEM9wUEwQcQEW346+LeLV6e
         COfkFwxdzYmO2bDXoaGTQ7gun737o93DbvqFt+pIqXOduko+b/tVNMd4pV7r5XtFFg
         8z+ULGb4WNG9/t6SMPShwmTJb/c9+fP9ELS6Qtrng8/CQbjmw/U53116c7JRr7Q1s/
         nz2s1rn2hxF3g==
Received: by mercury (Postfix, from userid 1000)
        id A9751106083C; Fri, 10 Mar 2023 00:40:06 +0100 (CET)
Date:   Fri, 10 Mar 2023 00:40:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH] power: supply: bq24190: Fix use after free bug in
 bq24190_remove due to race condition
Message-ID: <e5b1ee16-796e-43fe-b703-3ce06aed364d@mercury.local>
References: <20230309174728.233732-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wur4n5pn2pcsi5ms"
Content-Disposition: inline
In-Reply-To: <20230309174728.233732-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wur4n5pn2pcsi5ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 10, 2023 at 01:47:28AM +0800, Zheng Wang wrote:
> In bq24190_probe, &bdi->input_current_limit_work is bound
> with bq24190_input_current_limit_work. When external power
> changed, it will call bq24190_charger_external_power_changed
>  to start the work.
>=20
> If we remove the module which will call bq24190_remove to make
> cleanup, there may be a unfinished work. The possible
> sequence is as follows:
>=20
> CPU0                  CPUc1
>=20
>                     |bq24190_input_current_limit_work
> bq24190_remove      |
> power_supply_unregister  |
> device_unregister   |
> power_supply_dev_release|
> kfree(psy)          |
>                     |
>                     | power_supply_get_property_from_supplier
>                     |   //use
>=20
> Fix it by finishing the work before cleanup in the bq24190_remove
>=20
> Fixes: 97774672573a ("power_supply: Initialize changed_work before callin=
g device_add")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---

Thanks, queued to fixes branch.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index be34b9848450..de67b985f0a9 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1906,6 +1906,7 @@ static void bq24190_remove(struct i2c_client *clien=
t)
>  	struct bq24190_dev_info *bdi =3D i2c_get_clientdata(client);
>  	int error;
> =20
> +	cancel_delayed_work_sync(&bdi->input_current_limit_work);
>  	error =3D pm_runtime_resume_and_get(bdi->dev);
>  	if (error < 0)
>  		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> --=20
> 2.25.1
>=20

--wur4n5pn2pcsi5ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQKblYACgkQ2O7X88g7
+pqTsA/+Og6pqjCTe2UubZ8YbdZXWhRC4T3cM2h5w8pG+wDSmsxIRfyHcqb0rf7t
2YEbjpXi3DSbYvzZ1ceqxv4sJXqE0RpI6J09EYC00RR658QKKR84lSo/RRWLqVej
Lk/9M4yvoy7EA7JTARHJxyNifuAik05jP8c7yiN5OfZWWdwZ40BoshSFvKyFUggS
rU5sGD8yDRfNpOn3m6PDsdHBTusq+wx8XQZtcBh7zexOIMTa6W5hDy9x4xlP8Vuz
sGMETClZfPyQne5oDul/t1rCzekvJ6qIgb6RmS42sYkUb5rm6hxGFMhBgabfakbY
TME3RH7TR9/w5rEkBgjTumxy76TdUEOAtOIcYYez2da+Sg8VVUfXf2HsbtNAp/sf
nD7VxFAUrFmz8cbMAOkjloVx3qOu/Nk90N+0APwBZTY2B0ObVgNFjlXZB6NEywIv
UHrI/V2n3fLMW/nZ1JQXEeUOUTHbg8qqTIy3kc+q+QQ9oDkiXi1Lt5riVmkJfxTm
8uJKVmZ0D+7URdZ/qUNKuueJVA1p30S/kd2pTYibhxIJZztGzXhfR/Fi4xs7YoqA
EM6RJ7A0A6CSZD8lma8kpZ3sNUg+1fjHZF+mGCvU/TVebH/lpTDbchbXDBWbqJzm
uOj51nj5dTnP7xGJub7hwH5h5GnHS6TLc1gaGxKwIT+FgnbsEf8=
=4hNN
-----END PGP SIGNATURE-----

--wur4n5pn2pcsi5ms--
