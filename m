Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055D5BEA81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiITPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:49:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71766120
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:49:00 -0700 (PDT)
Received: from mercury (dyndsl-091-096-056-222.ewe-ip-backbone.de [91.96.56.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31DA16601FB8;
        Tue, 20 Sep 2022 16:48:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663688939;
        bh=1cJdei1wKjC+6amXTIk3jEO0feNqmjSNtSnqcqw4pGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf3dgg+RG4YHjpEUCWpS4vOAzt3CxDqy1TNEut8r7jdtYG3JwiuLmejY6CGgRjbzJ
         PC5DcKH99dh/I0+EEHnV6dJ6DW/YikzjQrV6zpzyYN0yYY10q3LPPloC6u8OwPRtnJ
         KNqildqUpGCeJS0PMKJzAKbecz+v4FidB4NBzoL/QBN3J3/+mW38iKmJFlkyzKZcIY
         aPgC7HW69Zn34kfzBtXr6YkTkvJS90oxrrrlbYpj7VGRyEBDaPNTZdm1TVljjwnjXO
         +icFvJt4Y9aFungijg7MVzuaUbk1M4BWL6Z1UTtMNS/zaTbQiuMZ+A+mXSHwDuhMiB
         tmkAzOYXnAnWg==
Received: by mercury (Postfix, from userid 1000)
        id A33D310607CF; Tue, 20 Sep 2022 17:48:56 +0200 (CEST)
Date:   Tue, 20 Sep 2022 17:48:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HSI: ssi_protocol: fix potential resource leak in
 ssip_pn_open()
Message-ID: <20220920154856.4s675wv7koivvpgb@mercury.elektranox.org>
References: <20220905074801.46167-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="evlazoyrppugj4l4"
Content-Disposition: inline
In-Reply-To: <20220905074801.46167-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--evlazoyrppugj4l4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 05, 2022 at 03:48:01PM +0800, Jianglei Nie wrote:
> ssip_pn_open() claims the HSI client's port with hsi_claim_port(). When
> hsi_register_port_event() gets some error and returns a negetive value,
> the HSI client's port should be released with hsi_release_port().
>=20
> Fix it by calling hsi_release_port() when hsi_register_port_event() fails.
>=20
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/hsi/clients/ssi_protocol.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi=
_protocol.c
> index 21f11a5b965b..49ffd808d17f 100644
> --- a/drivers/hsi/clients/ssi_protocol.c
> +++ b/drivers/hsi/clients/ssi_protocol.c
> @@ -931,6 +931,7 @@ static int ssip_pn_open(struct net_device *dev)
>  	if (err < 0) {
>  		dev_err(&cl->device, "Register HSI port event failed (%d)\n",
>  			err);
> +		hsi_release_port(cl);
>  		return err;
>  	}
>  	dev_dbg(&cl->device, "Configuring SSI port\n");

Thanks, queued.

-- Sebastian

--evlazoyrppugj4l4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMp4NQACgkQ2O7X88g7
+ponFRAAkqXj33I9pMg7pk8MlREeWZlbFSjx83m8YR7nLSgfFAMXt4qI01QJa5/k
3FbQwp9Gf13eCvauBbvzb9jXg2OukD/6GrCeVbUsxmbr8IQ9zuV3di2yzI5nCLiM
2cBaugH56SGD9PZHbrLH0Uxgh0fJEnB7ntjzfp8s1aPwscem4HZyYXxpnc+5HZGm
DrthxjWd4RpA/TgjywnPHoom9Z6v/IGQVwe2CzJmz77lWSzeCbOWVUy3ccSHSyb/
rrdiYvlrlsxh1eJYoDN+FmzBjwIFI2vn60ECtSyBpXRmDXUm6gmt4Dr7Nl+cAUes
IaBeSeJm5kqTFN39aD1xpPBqpEj+jDS2yLBye1HejPrdJrvKd9tucBmIKkGvFXoH
seBMOW+hyzrXGWA4HUxCsfk+WIjNg6RbkEqv1Q4nFjVnsaZH6vBd2oscfM4JT3mU
0Wjtk31KDgoTb1WqNl2zotkuwoLbUP7n/2c2YL1iZNLz4s2RvqQ/DSJjHjB/wyZM
aWBcQNyuSmEfklr6zrBfIkUZDQt1zUzIllk9ayFSsfxmtjS1AreeVyF4ttCn8Q9z
TGic1A7H1lq5T991sadtB2A943MT428E6zQz6g4ddO5cQ6q9KsdpMyoYVM6UpXUH
hfkmKFVEJpcJHUksYYssXkOVm3E4xFsDnDSoGxWfiNieIXlksDs=
=QnIh
-----END PGP SIGNATURE-----

--evlazoyrppugj4l4--
