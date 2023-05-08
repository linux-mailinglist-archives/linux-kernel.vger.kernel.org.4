Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF866FAFBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjEHMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjEHMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:14:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A90394B1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:14:46 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pvzlI-0006qX-3S; Mon, 08 May 2023 14:14:40 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B3F361C00AC;
        Mon,  8 May 2023 12:14:38 +0000 (UTC)
Date:   Mon, 8 May 2023 14:14:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org,
        marex@denx.de, linux-kernel@vger.kernel.org
Subject: Re: RE: [PATCH] can: length: add definitions for frame lengths in
 bits
Message-ID: <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhe3bfto7rzywosp"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
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


--rhe3bfto7rzywosp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.05.2023 08:54:18, Thomas.Kopp@microchip.com wrote:
> I was working on the same thing on Friday but didn't get around to
> sending it off, so here are a couple thoughts I had when working on
> the defines in length.h
>=20
> The definitions for IFS in here are called intermission in the
> standard

ACK, and IMF seems to be a common abbreviation.

> and I'd argue they shouldn't be part of the frame at all.

The diagram in https://www.can-cia.org/can-knowledge/can/can-fd/
suggests that IMF is part of the frame.

> To
> quote the ISO: "DFs and RFs shall be separated from preceding frames,
> whatever frame type they are (DF, RF, EF, OF), by a time period called
> inter-frame space."
>=20
> So, my suggestion would be to pull out the 3 bit IFS definition that's
> currently in and introduce 11 bit Bus idle and if necessary 3 bit
> Intermission separately.
>=20
> index 6995092b774ec..62e92c1553376 100644
> --- a/include/linux/can/length.h
> +++ b/include/linux/can/length.h
> @@ -6,6 +6,26 @@
>  #ifndef _CAN_LENGTH_H
>  #define _CAN_LENGTH_H
>=20
> +/*
> + * First part of the Inter Frame Space
> + */
> +#define CAN_INTERMISSION_BITS 3
> +
> +/*
> + * Number of consecutive recessive bits on the bus for integration etc.
> + */
> +#define CAN_IDLE_CONDITION_BITS 11
> +
>=20
> The field currently called Stuff bit count (SBC) is also not correct
> I'd say. I'm not sure about the history but given that this is
> dependent on the DLC I think what's meant is the number of Fixed Stuff
> bits (FSB) . The ISO does not define a term for the Stuff bit Count
> but the CiA did define/document it this way. What's meant though is
> not the number of fixed stuff bits (FSB) which the comment implies
> here but the modulo 8 3 bit gray-code followed by the parity bit. So
> for the FD frame definitions I'd propose something like this: Renaming
> the current SBC to FSB and adding the SBC.

> /*
>   * Size of a CAN-FD Standard Frame
> @@ -69,17 +87,17 @@
>   * Error Status Indicator (ESI)                1
>   * Data length code (DLC)              4
>   * Data field                          0...512
> - * Stuff Bit Count (SBC)               0...16: 4 20...64:5
> + * Stuff Bit Count (SBC)               4

ACK

>   * CRC                                 0...16: 17 20...64:21
>   * CRC delimiter (CD)                  1
> + * Fixed Stuff bits (FSB)              0...16: 6 20...64:7

As far as I understand
https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=3D&arnumber=3D8338047 the FSB
is 5 or 6.

>   * ACK slot (AS)                       1
>   * ACK delimiter (AD)                  1
>   * End-of-frame (EOF)                  7
> - * Inter frame spacing                 3
>   *
> - * assuming CRC21, rounded up and ignoring bitstuffing
> + * assuming CRC21, rounded up and ignoring dynamic bitstuffing
>   */
>=20
> Best Regards,
> Thomas
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rhe3bfto7rzywosp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRY56sACgkQvlAcSiqK
BOjP1AgAo2VKxVkGab/BWPGjlHnmenWeZkqYikbOl54hoC8Mtv4VmnAJpOxprZ4I
jgrEuAnxA/8qDZwsB4lRN4Axd2KZPQPg9AeA/gg+qMyoLUtMwXIB/Rb92RJ+uTW1
BJ++Jv8A930dF9gg42OGRXlkv8BaP8VowazsbVDTaieq8KcfFhjSe99clL722PAT
8Yi2Rt8X+sJ8++FUrKa2XasT7/KrWVTYl62lvavyrCgf03bsUpIwsEOtCwuw7w8p
krR5wkU7jYZVZbzBcORib/m32YlOcJ7fOOWs4vpYjyqHd3AoFal88N5mLgoc54OX
Y7O/MEYDKQ5jKyRRo+BxEN7wiB0cSQ==
=l4SA
-----END PGP SIGNATURE-----

--rhe3bfto7rzywosp--
