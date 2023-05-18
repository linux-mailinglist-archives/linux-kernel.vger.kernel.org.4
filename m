Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2576707D49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjERJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjERJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:52:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B91A4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:52:03 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzaIW-0000e7-ON; Thu, 18 May 2023 11:51:48 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CDEF01C7B63;
        Thu, 18 May 2023 09:51:46 +0000 (UTC)
Date:   Thu, 18 May 2023 11:51:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] can: ctucanfd: Remove a useless netif_napi_del() call
Message-ID: <20230518-satisfied-smugness-dc5a06faa865-mkl@pengutronix.de>
References: <58500052a6740806e8af199ece45e97cb5eeb1b8.1684393811.git.christophe.jaillet@wanadoo.fr>
 <202305180932.38815.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7emi62ptsndis2qr"
Content-Disposition: inline
In-Reply-To: <202305180932.38815.pisa@cmp.felk.cvut.cz>
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


--7emi62ptsndis2qr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.05.2023 09:32:38, Pavel Pisa wrote:
> Dear Christophe,
>=20
> On Thursday 18 of May 2023 09:10:39 Christophe JAILLET wrote:
> > free_candev() already calls netif_napi_del(), so there is no need to ca=
ll
> > it explicitly. It is harmless, but useless.
> >
> > This makes the code mode consistent with the error handling path of
> > ctucan_probe_common().
>=20
> OK, but I would suggest to consider to keep sequence in sync with
>=20
> linux/drivers/net/can/ctucanfd/ctucanfd_pci.c
>=20
> where is netif_napi_del() used as well
>=20
>         while ((priv =3D list_first_entry_or_null(&bdata->ndev_list_head,=
 struct ctucan_priv,
>                                                 peers_on_pdev)) !=3D NULL=
) {
>                 ndev =3D priv->can.dev;
>=20
>                 unregister_candev(ndev);
>=20
>                 netif_napi_del(&priv->napi);
>=20
>                 list_del_init(&priv->peers_on_pdev);
>                 free_candev(ndev);
>         }
>=20
> On the other hand, if interrupt can be called for device between
> unregister_candev() and free_candev()

At least the case of an "interrupt during ctucan_pci_remove()" is a bug,
as there is no IRQ handler registered. The IRQ handler is registered in
ctucan_open() and freed in ctucan_close().

> or some other callback
> which is prevented by netif_napi_del() now then I would consider
> to keep explicit netif_napi_del() to ensure that no callback
> is activated to driver there.

Napi itself is shut down, too, as there is a call to napi_disable() in
ctucan_close().

> And for PCI integration it is more
> critical because list_del_init(&priv->peers_on_pdev); appears in
> between and I would prefer that no interrupt appears when instance
> is not on the peers list anymore. Even that would not be a problem
> for actual CTU CAN FD implementation, peers are accessed only during
> physical device remove, but I have worked on other controllers
> in past, which required to coordinate with peers in interrupt
> handling...
>=20
> So I would be happy for some feedback what is actual guarantee
> when device is stopped.

After a ifup; ifdown;, which corresponds to ctucan_open(),
ctucan_close() in the driver, the device should be shut down, no
interrupts active. You might even power down the device, although things
get a little more complicated with HW timestamping or even PTP enabled.

> May it be that it would be even more robust to run removal
> with two loop where the first one calls unregister_candev()
> and netif_napi_del() and only the second one removes from peers
> and call free_candev()... But I am not sure there and it is not
> problem in actual driver because peers are not used in any
> other place...

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7emi62ptsndis2qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRl9S8ACgkQvlAcSiqK
BOgDpAgAnI3Osy8Fx5vffOkPSdz+b193idfd/nM1NjJAYnsAaPObGXK3zWGMg58W
Qhxr3+W28VBJU/ucksBHROZIOiAm1a2Y69y92pChXdZd2+Lrhz2xZhw2aqkwQkn8
F1tBieRVWy0T0P3BogFsKXwdLCURMBqhSZmmLRptxx6k+H7QlqPRh21tmqun2+Dm
1KAd4xr97px5EqOha3Jtr3HP4iWiVx7DYS6R7sFRr3ZX7lzu4YkUkO5Xg33R0cwa
yxMOmXM49IKwr59gxjXydCoD6BwOI39fKbCVHkOtG2XRQapuDCRyyDf+uBelFQeQ
X0nEPjuBUVtCexN5ArBdnKNxdEW1Ew==
=rkgc
-----END PGP SIGNATURE-----

--7emi62ptsndis2qr--
