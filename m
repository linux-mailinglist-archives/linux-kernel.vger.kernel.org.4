Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819C6FAFC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjEHMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjEHMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:20:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30E2E3D8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:20:12 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pvzqb-0007PM-Va; Mon, 08 May 2023 14:20:10 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5451C1C00B5;
        Mon,  8 May 2023 12:20:09 +0000 (UTC)
Date:   Mon, 8 May 2023 14:20:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: length: add definitions for frame lengths in bits
Message-ID: <20230508-sprint-cause-80b4172d5a5a-mkl@pengutronix.de>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uabosgyhmp5zyosz"
Content-Disposition: inline
In-Reply-To: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
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


--uabosgyhmp5zyosz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.05.2023 00:55:06, Vincent Mailhol wrote:
> When created in [1], frames length definitions were added to implement
> byte queue limits (bql). Because bql expects lengths in bytes, bit
> length definitions were not considered back then.
>=20
> Recently, a need to refer to the exact frame length in bits, with CAN
> bit stuffing, appeared in [2].
>=20
> Add 9 frames length definitions:
>=20
>  - CAN_FRAME_OVERHEAD_SFF_BITS:
>  - CAN_FRAME_OVERHEAD_EFF_BITS
>  - CANFD_FRAME_OVERHEAD_SFF_BITS
>  - CANFD_FRAME_OVERHEAD_EFF_BITS
>  - CAN_BIT_STUFFING_OVERHEAD
>  - CAN_FRAME_LEN_MAX_BITS_NO_STUFFING
>  - CAN_FRAME_LEN_MAX_BITS_STUFFING
>  - CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING
>  - CANFD_FRAME_LEN_MAX_BITS_STUFFING
>=20
> CAN_FRAME_LEN_MAX_BITS_STUFFING and CANFD_FRAME_LEN_MAX_BITS_STUFFING
> define respectively the maximum number of bits in a classical CAN and
> CAN-FD frame including bit stuffing. The other definitions are
> intermediate values.
>=20
> In addition to the above:
>=20
>  - Include linux/bits.h and then replace the value 8 by BITS_PER_BYTE
>    whenever relevant.
>  - Include linux/math.h because of DIV_ROUND_UP(). N.B: the use of
>    DIV_ROUND_UP() is not new to this patch, but the include was
>    previously omitted.
>  - Update the existing length definitions to use the newly defined values.
>  - Add myself as copyright owner for 2020 (as coauthor of the initial
>    version, c.f. [1]) and for 2023 (this patch).
>=20
> [1] commit 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce
>     function to get data length of frame in data link layer")
> Link: https://git.kernel.org/torvalds/c/85d99c3e2a13
>=20
> [2] RE: [PATCH] can: mcp251xfd: Increase poll timeout
> Link: https://lore.kernel.org/linux-can/BL3PR11MB64846C83ACD04E9330B0FE66=
FB729@BL3PR11MB6484.namprd11.prod.outlook.com/
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> As always, let me know if you have better inspiration than me for the
> naming.
> ---
>  include/linux/can/length.h | 84 ++++++++++++++++++++++++++++++++------
>  1 file changed, 72 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/can/length.h b/include/linux/can/length.h
> index 6995092b774e..60492fcbe34d 100644
> --- a/include/linux/can/length.h
> +++ b/include/linux/can/length.h
> @@ -1,13 +1,17 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
>   * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
> + * Copyright (C) 2020, 2023 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
> =20
>  #ifndef _CAN_LENGTH_H
>  #define _CAN_LENGTH_H
> =20
> +#include <linux/bits.h>
> +#include <linux/math.h>
> +
>  /*
> - * Size of a Classical CAN Standard Frame
> + * Size of a Classical CAN Standard Frame in bits
>   *
>   * Name of Field			Bits
>   * ---------------------------------------------------------
> @@ -25,12 +29,19 @@
>   * End-of-frame (EOF)			7
>   * Inter frame spacing			3
>   *
> - * rounded up and ignoring bitstuffing
> + * ignoring bitstuffing
>   */
> -#define CAN_FRAME_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
> +#define CAN_FRAME_OVERHEAD_SFF_BITS 47
> =20
>  /*
> - * Size of a Classical CAN Extended Frame
> + * Size of a Classical CAN Standard Frame
> + * (rounded up and ignoring bitstuffing)
> + */
> +#define CAN_FRAME_OVERHEAD_SFF \
> +	DIV_ROUND_UP(CAN_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
> +
> +/*
> + * Size of a Classical CAN Extended Frame in bits
>   *
>   * Name of Field			Bits
>   * ---------------------------------------------------------
> @@ -50,12 +61,19 @@
>   * End-of-frame (EOF)			7
>   * Inter frame spacing			3
>   *
> - * rounded up and ignoring bitstuffing
> + * ignoring bitstuffing
>   */
> -#define CAN_FRAME_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
> +#define CAN_FRAME_OVERHEAD_EFF_BITS 67
> =20
>  /*
> - * Size of a CAN-FD Standard Frame
> + * Size of a Classical CAN Extended Frame
> + * (rounded up and ignoring bitstuffing)
> + */
> +#define CAN_FRAME_OVERHEAD_EFF \
> +	DIV_ROUND_UP(CAN_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
> +
> +/*
> + * Size of a CAN-FD Standard Frame in bits
>   *
>   * Name of Field			Bits
>   * ---------------------------------------------------------
> @@ -77,12 +95,19 @@
>   * End-of-frame (EOF)			7
>   * Inter frame spacing			3
>   *
> - * assuming CRC21, rounded up and ignoring bitstuffing
> + * assuming CRC21 and ignoring bitstuffing
>   */
> -#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
> +#define CANFD_FRAME_OVERHEAD_SFF_BITS 61
> =20
>  /*
> - * Size of a CAN-FD Extended Frame
> + * Size of a CAN-FD Standard Frame
> + * (assuming CRC21, rounded up and ignoring bitstuffing)
> + */
> +#define CANFD_FRAME_OVERHEAD_SFF \
> +	DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
> +
> +/*
> + * Size of a CAN-FD Extended Frame in bits
>   *
>   * Name of Field			Bits
>   * ---------------------------------------------------------
> @@ -106,9 +131,32 @@
>   * End-of-frame (EOF)			7
>   * Inter frame spacing			3
>   *
> - * assuming CRC21, rounded up and ignoring bitstuffing
> + * assuming CRC21 and ignoring bitstuffing
> + */
> +#define CANFD_FRAME_OVERHEAD_EFF_BITS 80
> +
> +/*
> + * Size of a CAN-FD Extended Frame
> + * (assuming CRC21, rounded up and ignoring bitstuffing)
> + */
> +#define CANFD_FRAME_OVERHEAD_EFF \
> +	DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
> +
> +/* CAN bit stuffing overhead multiplication factor */
> +#define CAN_BIT_STUFFING_OVERHEAD 1.2
> +
> +/*
> + * Maximum size of a Classical CAN frame in bits, ignoring bitstuffing
>   */
> -#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
> +#define CAN_FRAME_LEN_MAX_BITS_NO_STUFFING \
> +	(CAN_FRAME_OVERHEAD_EFF_BITS + CAN_MAX_DLEN * BITS_PER_BYTE)
> +
> +/*
> + * Maximum size of a Classical CAN frame in bits, including bitstuffing
> + */
> +#define CAN_FRAME_LEN_MAX_BITS_STUFFING				\
> +	((unsigned int)(CAN_FRAME_LEN_MAX_BITS_NO_STUFFING *	\
> +			CAN_BIT_STUFFING_OVERHEAD))

The 1.2 overhead doesn't apply to the whole frame, according to
https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=3D&arnumber=3D8338047.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uabosgyhmp5zyosz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRY6PYACgkQvlAcSiqK
BOhO+gf/apC8fM4dkkLelSSMAduJ4D0siAbWcbAA3IlVAMmm3ukEDvGngpci52tk
qX3z5vGJ+mqBqCOO046wnqSAu9f+ee77b77t6rtu2LF3dQRzzc0zfaf9v9EQ+tg2
MtsRD+2Zde7Il1w06KZgc+yFR0/aSMUllrICctcZ6vXtmyC82jU6ByU3r9SqVAJF
iZ7grREqYiqfRPw554Sdnzxv52//FX6H7Ld/7bTmhMSoe/vsqq+VBADc6BMrraYp
rbU/XuLrj5sVE43sj4D40fv1p4KN3DEGZJEQINFKY+/rXM+XDTdP4VSWx1Ie00ld
ImbeJwAaCLMd6lL6ck6B1RF01EGLRw==
=VPxl
-----END PGP SIGNATURE-----

--uabosgyhmp5zyosz--
