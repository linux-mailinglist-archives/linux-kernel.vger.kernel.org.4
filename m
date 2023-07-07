Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A974ABFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGGHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:34:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A91FCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:34:28 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qHfyq-0003Q6-E7; Fri, 07 Jul 2023 09:34:16 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D3E421EAE26;
        Fri,  7 Jul 2023 07:34:14 +0000 (UTC)
Date:   Fri, 7 Jul 2023 09:34:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kumari Pallavi <kumari.pallavi@intel.com>
Cc:     "rcsekar@samsung.com" <rcsekar@samsung.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Nikula, Jarkko" <jarkko.nikula@intel.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: Re: RE: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to
 avoid communication stall
Message-ID: <20230707-breeder-shaft-61b826633b7e-mkl@pengutronix.de>
References: <20230623085920.12904-1-kumari.pallavi@intel.com>
 <20230705-return-slogan-36c499673bb6-mkl@pengutronix.de>
 <SJ1PR11MB608478D62EDFAEDDBE8C0890872DA@SJ1PR11MB6084.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dxld4druqcvwrqfa"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608478D62EDFAEDDBE8C0890872DA@SJ1PR11MB6084.namprd11.prod.outlook.com>
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


--dxld4druqcvwrqfa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.07.2023 05:38:09, Kumari Pallavi wrote:
> > >  			if (netif_queue_stopped(dev) &&
> > >  			    !m_can_tx_fifo_full(cdev))
> > >  				netif_wake_queue(dev);
> > > @@ -1787,6 +1787,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_b=
uff
> > *skb,
> > >  		}
> > >  	} else {
> > >  		cdev->tx_skb =3D skb;
> > > +		m_can_write(cdev, M_CAN_IE, IR_ALL_INT & (IR_TEFN));
> >=20
> > - What's the purpose of  "()" around IR_TEFN?
> > - "IR_ALL_INT & (IR_TEFN)" is equal to IR_TEFN, isn't it?
> > - This basically disables all other interrupts, is this what you want to
> >   do?
> > - What happens if the bus is busy with high prio CAN frames and you want
> >   to send low prio ones? You will not get any RX-IRQ, this doesn't look
> >   correct to me.
> >=20
>=20
> Even though the RX interrupt is disabled (in IE), if there is an TX
> interrupt and the RF0N bit is set (in IR), the RX packet will still be
> serviced because the TX and RX share the same IRQ handler.

If the bus is busy with high prio CAN frames and the m_can wants to send
a low prio frame, the m_can will not be able to send it's CAN frame,
there will be not TX interrupt. If there are enough high prio CAN frames
the RX buffer will overflow.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dxld4druqcvwrqfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSnv/MACgkQvlAcSiqK
BOjdRAf/ev2175DU15TwDRx6naSR7QltyRAabcBHohWJrGf/oDogSB3PYo3V6wFY
fRtr7Dy0JRw2p2jm1oTL+UzfB45Ap3Kp8x6DDA4+4Ca2eok+aK6r7jDE1rWKfod/
iBjQt6x0Plk5PT4ph7M1f1ukGUsJERyFoAQsR1rZQv2n+eT0pqGJZwpWofNtppG5
AQw04M1keRRE6LeMk1aeMdHi3fGiZT8QEJom0i1UEOiERIARuVsL5B3NDFEYkxVF
FXSX8YPH6QZS6hNAbY7x79qEB0qRRX52Uj2FklIsYnl8YeXnFUe7ISp+n+9bFERs
NcnMQ/tGrFAUHZc8ln6jnQOE5jtk0g==
=dHVD
-----END PGP SIGNATURE-----

--dxld4druqcvwrqfa--
