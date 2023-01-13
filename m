Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38E669032
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbjAMIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjAMIMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:12:09 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C29392FF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=5ZU0RPC2jyXj7QCen2sKG5577p/y
        JBKzAJc1g5WaOho=; b=fmZOtK+/oOOCtymGN0hkj/68bYGET5euWgDeXmWqvzTT
        YKV1G0/zoKN1XH1UyYMXCtzhCDyt2JWeI/rKH1sQhqxRJC5PETMKg+eKP/UqtyPW
        ZR6XiKb9vY9S56fKy2xrYw8zqMwMcXKXBiCUm129sfC8n+J/p4BbIpmI0uSC3Js=
Received: (qmail 1183191 invoked from network); 13 Jan 2023 09:10:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jan 2023 09:10:12 +0100
X-UD-Smtp-Session: l3s3148p1@NN1CwyDyzqhehh92
Date:   Fri, 13 Jan 2023 09:10:12 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: renesas-rpc-if: Remove redundant division of
 dummy
Message-ID: <Y8ER5B5D1XCTOOBX@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org
References: <20230112090655.43367-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FTMPRqYA1OHK8Id7"
Content-Disposition: inline
In-Reply-To: <20230112090655.43367-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FTMPRqYA1OHK8Id7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Using Sergei's recent email...

On Thu, Jan 12, 2023 at 10:06:55AM +0100, Wolfram Sang wrote:
> From: Cong Dang <cong.dang.xn@renesas.com>
>=20
> The dummy cycles value was wrongly calculated if dummy.buswidth > 1,
> which affects QSPI, OSPI, HyperFlash on various SoCs. We're lucky in
> Single SPI case since its dummy.buswidth equals to 1, so the result of
> the division is unchanged
>=20
> This issue can be reproduced using something like the following commands
> A. QSPI mode: Mount device with jffs2 format
>     jffs2: CLEANMARKER node found at 0x00000004, not first node in block =
(0x00000000)
>=20
> B. QSPI mode: Write data to mtd10, where mtd10 is a parition on SPI Flash
> storage, defined properly in a device tree
>=20
> [Correct fragment, read from SPI Flash]
>=20
>   root@v3x:~# echo "hello" > /dev/mtd10
>   root@v3x:~# hexdump -C -n100 /dev/mtd10
>   00000000  68 65 6c 6c 6f 0a ff ff  ff ff ff ff ff ff ff ff  |hello.....=
=2E.....|
>   00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..........=
=2E.....|
>=20
> [Incorrect read of the same fragment: see the difference at offsets 0-3]
>=20
>   root@v3x:~# echo "hello" > /dev/mtd10
>   root@v3x:~# hexdump -C -n100 /dev/mtd10
>   00000000  00 00 00 00 68 65 6c 6c  6f 0a ff ff ff ff ff ff  |....hello.=
=2E.....|
>   00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..........=
=2E.....|
>=20
> As seen from the result, 4 NULL bytes were inserted before the test data.
> Wrong calculation in rpcif_prepare() led to miss of some dummy cycle. A
> division by bus width is redundant because it had been performed already
> in spi-rpc-if.c::rpcif_spi_mem_prepare()
>=20
> Fix this by removing the redundant division.
>=20
> Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Sadly, I cannot test this patch myself because I don't have access to
> hardware which uses a buswidth > 1 for the dummy read. However, from
> code review, this patch makes sense. The division by buswidth is done
> twice, once in the SPI driver and once in the RPC core. It should stay
> only in the SPI driver.
>=20
>  drivers/memory/renesas-rpc-if.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc=
-if.c
> index 09cd4318a83d..c36b407851ff 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -430,8 +430,7 @@ void rpcif_prepare(struct rpcif *rpc, const struct rp=
cif_op *op, u64 *offs,
> =20
>  	if (op->dummy.buswidth) {
>  		rpc->enable |=3D RPCIF_SMENR_DME;
> -		rpc->dummy =3D RPCIF_SMDMCR_DMCYC(op->dummy.ncycles /
> -						op->dummy.buswidth);
> +		rpc->dummy =3D RPCIF_SMDMCR_DMCYC(op->dummy.ncycles);
>  	}
> =20
>  	if (op->option.buswidth) {
> --=20
> 2.30.2
>=20

--FTMPRqYA1OHK8Id7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPBEeAACgkQFA3kzBSg
KbbgrQ/8DXighPwWSptl/TiNXROTtn2oqQJuYkwBPcuYLC+bkRvKkyyg6gQHvHpP
tkUJoLsQpv8DmNhYB5aggRjAQnOZfI9jifhxKeMb2nBOvVk0x+69bnphJR9/dumb
bcK58pKzz7LFXBKwpfaDRkuGhztz89Hu09PN3uwVdfnE9GYCFt9mWsgVcGpmlpAm
OTxXrRYkvRWUJhchjZbvgG+3VtcepWuq9Q1TNF9mpBjbxtYBoO7JcByv+wgGDC98
lI2Dnb3TheIsXOxeqL43CMLn9G9LPGN07Wp6Yc41xVKwj3lhn7hEwPbQ16zV0BdN
Cl6H+4ZlA5YlHqAvpMbBL5XSR3xcHVuJIzQDBent5CCHHCFBwYGcq4g4CHCUsHlZ
4PIOETHLbtXtAiWfK1tJ/H9gWU/EtIo+zIyWjWmC2tFpt40wkmUlIWIMmo8uRHpX
tjfgHV7HgJFAW4lqNk2HKIYmMruQiMyQgqX/YaDs1ZEe7xDs9LEe/VNXS6TYGTcI
Yok88CF6ZxosNLHJQ0OsZAUvsb5Exh8MQMYGSdA6giRGtJ4td4dmiBvXyHw28PQ7
qU11oumAZFp1asn/H8wdwSNaqkLxw0pwEqWbnOpuX/oNiNG16Snk032IS5aTpuUj
vA1Yv24XcaWCYcYRa2/4FiHJBHeegVNbPVd7prVYex8rWqFPIcE=
=gi25
-----END PGP SIGNATURE-----

--FTMPRqYA1OHK8Id7--
