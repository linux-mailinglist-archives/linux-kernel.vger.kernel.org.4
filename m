Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2351E703EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbjEOUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjEOUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:52:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A154D59DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:52:15 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyfAm-0005zl-2x; Mon, 15 May 2023 22:52:00 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C20C11C5CA7;
        Mon, 15 May 2023 20:51:58 +0000 (UTC)
Date:   Mon, 15 May 2023 22:51:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin Jerabek <martin.jerabek01@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] can: ctucanfd: Fix an error handling path in
 ctucan_probe_common()
Message-ID: <20230515-finisher-plating-8ab57747fea5-mkl@pengutronix.de>
References: <4b78c848826fde1b8a3ccd53f32b80674812cb12.1684182962.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e2jyg7v42mrpg4qu"
Content-Disposition: inline
In-Reply-To: <4b78c848826fde1b8a3ccd53f32b80674812cb12.1684182962.git.christophe.jaillet@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2jyg7v42mrpg4qu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.05.2023 22:36:28, Christophe JAILLET wrote:
> If register_candev() fails, a previous netif_napi_add() needs to be undon=
e.
> Add the missing netif_napi_del() in the error handling path.

What about this path:
free_candev(ndev) -> free_netdev() -> netif_napi_del()

| https://elixir.bootlin.com/linux/v6.3.2/source/net/core/dev.c#L10714

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e2jyg7v42mrpg4qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRim2sACgkQvlAcSiqK
BOjuAwf6A4GauV2RYDb0DKtBocZA6JCTFpxr+DJK7LK19G344FjrZMVvb9Tch5iO
Z280B9XDtr4dERafr3H5Eu7GxJVOvuI15TM09c1W4Rx5lpo4a7pUYnKrsmu8JAdX
2Jl8DCIF61Pzv+5HnFuefw8e+twXjmD3Htie4zFUVUeZ52Bm60+H5reYeMPxUOcV
P27GtPBrEx7N5tJjedlb+E2EqpqLRl3RCNgdpizUBGCoUZqlr7Hv2YXTcyet0SV/
wovJpqmyFDKT3k6r8rXFJuZMp4xBQZibGQJX3f6hYqF7C1QsXcriRUL5h6cRsFCh
jnY6LSzFQSrj7ca6rvFv67dmymX+Dw==
=WizN
-----END PGP SIGNATURE-----

--e2jyg7v42mrpg4qu--
