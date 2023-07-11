Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83E74F674
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGKRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjGKRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:05:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4134B10F1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:05:47 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qJGni-0003hd-JI; Tue, 11 Jul 2023 19:05:22 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 822D71EDE3F;
        Tue, 11 Jul 2023 17:05:20 +0000 (UTC)
Date:   Tue, 11 Jul 2023 19:05:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
Message-ID: <20230711-refusing-derby-9a9d4d255d30-mkl@pengutronix.de>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c7fafffb-93a7-4f4c-9c1e-df959c3ed3bb@emailsignatures365.codetwo.com>
 <20230711152647.28673-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjdidpnmyunubgfu"
Content-Disposition: inline
In-Reply-To: <20230711152647.28673-1-mike.looijmans@topic.nl>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjdidpnmyunubgfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.07.2023 17:26:47, Mike Looijmans wrote:
> When there's an error attempting to store the BER counter, don't abort
> but continue shutting down the chip as required.

If you refer to an error by __mcp251xfd_get_berr_counter(), it's not a
store error, but a failure of regmap_read(priv->map_reg,
MCP251XFD_REG_TREC, &trec). By default the SPI transfers are CRC enabled
and no/wrong data from the chip will be detected and return an error
here (after 3 retires). In out of memory conditions or other kernel
errors might be possible here, too.

Have you seen a problem here? But as we shut down the chip here anyways,
we can ignore the error here.

> After disabling communications, also stop the TX queue with a call to
> netif_stop_queue.

can_bus_off() will call netif_carrier_off(), isn't this sufficient? Have
you enabled automatic restart in case of bus off? I think the netdev
watchdog will kick you, if the interface has a stooped queue for too
long (IIRC 5 seconds).

> When the interface restarts, mcp251xfd_set_mode will
> call netif_wake_queue and resume.
>=20
> This fixes a hangup in either send() or poll() from userspace. To
> reproduce: I ran "cansequence can0 -p" to flood the system with packets.
> While running that, I shorted the CAN signals, causing a bus error.
> Usually communications would resume after the CAN bus restarted, but
> sometimes the system got stuck and refused to send any more packets.
> The sending process would be in either poll() or send(), waiting for
> the queue to resume. To "unstuck" the process from send() it was
> sufficient to send any packet on the can interface from another
> process. To get it out of the poll() hang, only bringing the can
> interface down (and up) would work.
>=20
> After adding the netif_stop_queue call, I was unable to reproduce the
> problem.

The newly added netif_stop_queue() will cause the netif_wake_queue() in
the mcp251xfd_set_mode() to actually wake the queue. If you observe a
problem, I think it's a general problem, so all drivers would be
effected.

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xjdidpnmyunubgfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSti8sACgkQvlAcSiqK
BOhbsgf/ZDCk6kV2bkTAL5hEAJ20qEpn5KsjPtSV3Hg4n07RaxlTSKFbjesUBJYZ
lGLGnIBxPQZE2g4z4pMKkBaG1E3xq1GJ04gEAefbg6u2Q7h5xvsZ8RLtnuT0ODsE
WB7UJd9yAFKC+nlyRwErZdacem0Zni18rm482p5WPQbxItgO+VM9InLOxZxBaEjG
HP7l2VKIxy/7QHm/UNrMZshFZjLAgH1uKnYkhpczxD2AI22XrM69SJZvODGsTqiz
u0/mWRfTpHA7jbH3RrgX1nz5Ne7vxnx9HAey9QMpV4knF3osLFHGnk5AG0mnw8cu
3at2k9pIKa9H/qE5hEF2liMqw+x7LQ==
=e62K
-----END PGP SIGNATURE-----

--xjdidpnmyunubgfu--
