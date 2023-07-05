Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34997748471
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGEMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:53:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB3DA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:53:53 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qH20p-000280-Ce; Wed, 05 Jul 2023 14:53:39 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 046461E9A17;
        Wed,  5 Jul 2023 12:17:29 +0000 (UTC)
Date:   Wed, 5 Jul 2023 14:17:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kumari Pallavi <kumari.pallavi@intel.com>
Cc:     rcsekar@samsung.com, mallikarjunappa.sangannavar@intel.com,
        jarkko.nikula@intel.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: Re: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to avoid
 communication stall
Message-ID: <20230705-return-slogan-36c499673bb6-mkl@pengutronix.de>
References: <20230623085920.12904-1-kumari.pallavi@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2r4fdrigq4xuvtru"
Content-Disposition: inline
In-Reply-To: <20230623085920.12904-1-kumari.pallavi@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2r4fdrigq4xuvtru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.06.2023 14:29:20, Kumari Pallavi wrote:
> In bi-directional CAN transfer using M_CAN IP, with
> the frame gap being set to '0', it leads to Protocol
> error in Arbitration phase resulting in communication
> stall.

Is there a (public) erratum describing the problem?

> Discussed with Bosch M_CAN IP team and the stall issue
> can only be overcome by controlling the tx and rx=20
> packets flow as done by the patch.

Please elaborate the suggested workaround.

> Rx packets would also be serviced when there is a tx=20
> interrupt. The solution has been tested extensively for
> more than 10 days, and no issues has been observed.

Can you describe how your patch implements the workaround?

| Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
| instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
| to do frotz", as if you are giving orders to the codebase to change
| its behaviour.

See: https://github.com/torvalds/linux/blob/master/Documentation/process/su=
bmitting-patches.rst#describe-your-changes

> Setup that is used to reproduce the issue:=20
>=20
> +---------------------+		+----------------------+
> |Intel ElkhartLake    |		|Intel ElkhartLake     |	=09
> |	+--------+    |		|	+--------+     |
> |	|m_can 0 |    |<=3D=3D=3D=3D=3D=3D=3D>|	|m_can 0 |     |		   =20
> |	+--------+    |		|	+--------+     |		=20
> +---------------------+		+----------------------+          =20
>=20
> Steps to be run on the two Elkhartlake HW:
>=20
> 1. ip link set can0 type can bitrate 1000000
> 2. ip link set can0 txqueuelen 2048
> 3. ip link set can0 up
> 4. cangen -g 0 can0
> 5. candump can0
>=20
> cangen -g 0 can0 & candump can0 commands are used for transmit and=20
> receive on both the m_can HW simultaneously where -g is the frame gap=20
> between two frames.
>=20
> Signed-off-by: Kumari Pallavi <kumari.pallavi@intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  drivers/net/can/m_can/m_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a5003435802b..94aa0ba89202 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1118,7 +1118,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  			/* New TX FIFO Element arrived */
>  			if (m_can_echo_tx_event(dev) !=3D 0)
>  				goto out_fail;
> -

nitpick: please keep that empty line.

> +			m_can_write(cdev, M_CAN_IE, IR_ALL_INT & ~(IR_TEFN));

- What's the purpose of  "()" around IR_TEFN?
- You enable a lot of interrupts that have not been enabled before. Have
  a look at m_can_chip_config() how the original register value for
  M_CAN_IE is calculated.

>  			if (netif_queue_stopped(dev) &&
>  			    !m_can_tx_fifo_full(cdev))
>  				netif_wake_queue(dev);
> @@ -1787,6 +1787,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff =
*skb,
>  		}
>  	} else {
>  		cdev->tx_skb =3D skb;
> +		m_can_write(cdev, M_CAN_IE, IR_ALL_INT & (IR_TEFN));

- What's the purpose of  "()" around IR_TEFN?
- "IR_ALL_INT & (IR_TEFN)" is equal to IR_TEFN, isn't it?
- This basically disables all other interrupts, is this what you want to
  do?
- What happens if the bus is busy with high prio CAN frames and you want
  to send low prio ones? You will not get any RX-IRQ, this doesn't look
  correct to me.

>  		return m_can_tx_handler(cdev);
>  	}
> =20
> --=20
> 2.17.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2r4fdrigq4xuvtru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSlX1UACgkQvlAcSiqK
BOjz4Af/fuwWzlnPHic3y+9DPHRMCJ8UfsD+t6Laxb+0+h71My4+l+W0qOmboG4S
/g7Z8shDmZnqdOv/EpnQpxdMG5CUMx6w28XDB5Nf868OASn1TiRvHtntd1R5AWwO
6FapQ7jiQJlnaNCLX9swKCx6cNQZNBaN07bX3vsqMV5SSCvVUdoDA49X+xcxPi0h
ZGBi+gi8obue2OzGLEZsOmRABrvksLPJ21vScnc1mVMgSpTyyna+h8AAijPtQV0P
cEL/KM0uJAmGeMBki4D9lF/IBoFzTs+BfQwoPKIWn+sR7EQ3xZLvCITzON5YpHd0
0aEeAwjo3gS2F9HesNl8ccVO9K/zqA==
=ot/V
-----END PGP SIGNATURE-----

--2r4fdrigq4xuvtru--
