Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3526D76C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjDEIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjDEIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:24:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E53526B8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:24:13 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pjyR6-0004QA-P7; Wed, 05 Apr 2023 10:24:08 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3E3E81A7068;
        Wed,  5 Apr 2023 08:24:04 +0000 (UTC)
Date:   Wed, 5 Apr 2023 10:24:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Shuangpeng Bai <sjb7183@psu.edu>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: can: j1939: Fix out-of-bounds memory access in
 j1939_tp_tx_dat_new
Message-ID: <20230405-backlit-unscathed-fab6044bdc4c@pengutronix.de>
References: <20230404073128.3173900-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4l7fptulstbh7cod"
Content-Disposition: inline
In-Reply-To: <20230404073128.3173900-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4l7fptulstbh7cod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.04.2023 09:31:28, Oleksij Rempel wrote:
> In the j1939_tp_tx_dat_new function, an out-of-bounds memory access
> could occur during the memcpy operation if the size of skb->cb is
> larger than the size of struct j1939_sk_buff_cb. This is because the
> memcpy operation uses the size of skb->cb, leading to a read beyond
> the struct j1939_sk_buff_cb.
>=20
> To address this issue, we have updated the memcpy operation to use the
> size of struct j1939_sk_buff_cb instead of the size of skb->cb. This
> ensures that the memcpy operation only reads the memory within the
> bounds of struct j1939_sk_buff_cb, preventing out-of-bounds memory
> access.
>=20
> Additionally, a static_assert has been added to check that the size of
> skb->cb is greater than or equal to the size of struct j1939_sk_buff_cb.
> This ensures that the skb->cb buffer is large enough to hold the
> j1939_sk_buff_cb structure.
>=20
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Reported-by: Shuangpeng Bai <sjb7183@psu.edu>
> Tested-by: Shuangpeng Bai <sjb7183@psu.edu>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4l7fptulstbh7cod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQtMCAACgkQvlAcSiqK
BOjssAf+O9dv5x401qELD8L9Ah8/YlghfKAAA3rx9N8lJHSPIH97AjLbklcPLzTc
Jmxi/SMQm0/RfKMkyFqHNxuv0xM0N41xFNNmjHR22PmS39TFIe5xtOdEEBccMZ2X
22tUOXM7fXGLBQmeTlepA8JJxnoBUXQ2UQlsCAlAQboyQ1HIvAJHd/68jS96jz47
zGVs8clal7jvE5kPVjxckgTotvOePCh/RB/AznSpq5Z1Fhc1sKVnG2InfJbI5QpQ
BMBGU4HbRtQBuV50B5X8HiT2fJzwR05zQJHSQ/2OM+uoFts/yQOwceckWh4qGgjg
cz73S0O0SfIWB/CSNUMWpsD/1j8sIw==
=3uI+
-----END PGP SIGNATURE-----

--4l7fptulstbh7cod--
