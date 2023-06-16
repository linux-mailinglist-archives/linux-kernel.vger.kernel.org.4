Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862FB732F77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbjFPLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbjFPLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:08:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263A3C28
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:07:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qA7Hy-0001BY-3g; Fri, 16 Jun 2023 13:06:46 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9D4AB1DAC56;
        Fri, 16 Jun 2023 11:06:43 +0000 (UTC)
Date:   Fri, 16 Jun 2023 13:06:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com,
        git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] can: xilinx_can: Add ECC support
Message-ID: <20230616-expenses-regime-50bdd5f78eea-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-3-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uavg33o2ipzoq7yz"
Content-Disposition: inline
In-Reply-To: <1686570177-2836108-3-git-send-email-srinivas.goud@amd.com>
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


--uavg33o2ipzoq7yz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2023 17:12:56, Srinivas Goud wrote:
> Add ECC support for Xilinx CAN Controller, so this driver reports
> 1bit/2bit ECC errors for FIFO's based on ECC error interrupt.
> ECC feature for Xilinx CAN Controller selected through
> 'xlnx,has-ecc' DT property
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
>  drivers/net/can/xilinx_can.c | 109 +++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 104 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 43c812e..311e435 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -63,6 +63,12 @@ enum xcan_reg {
>  	XCAN_RXMSG_2_BASE_OFFSET	=3D 0x2100, /* RX Message Space */
>  	XCAN_AFR_2_MASK_OFFSET	=3D 0x0A00, /* Acceptance Filter MASK */
>  	XCAN_AFR_2_ID_OFFSET	=3D 0x0A04, /* Acceptance Filter ID */
> +
> +	/* only on AXI CAN cores */
> +	XCAN_ECC_CFG_OFFSET	=3D 0xC8,	/* ECC Configuration */
> +	XCAN_TXTLFIFO_ECC_OFFSET	=3D 0xCC, /* TXTL FIFO ECC error counter */
> +	XCAN_TXOLFIFO_ECC_OFFSET	=3D 0xD0, /* TXOL FIFO ECC error counter */
> +	XCAN_RXFIFO_ECC_OFFSET		=3D 0xD4, /* RX FIFO ECC error counter */

Please keep the enum sorted by address.

>  };
> =20
>  #define XCAN_FRAME_ID_OFFSET(frame_base)	((frame_base) + 0x00)
> @@ -135,6 +141,17 @@ enum xcan_reg {
>  #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
>  #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
>  #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
> +#define XCAN_IXR_E2BERX_MASK		BIT(23) /* RX FIFO two bit ECC error */
> +#define XCAN_IXR_E1BERX_MASK		BIT(22) /* RX FIFO one bit ECC error */
> +#define XCAN_IXR_E2BETXOL_MASK		BIT(21) /* TXOL FIFO two bit ECC error */
> +#define XCAN_IXR_E1BETXOL_MASK		BIT(20) /* TXOL FIFO One bit ECC error */
> +#define XCAN_IXR_E2BETXTL_MASK		BIT(19) /* TXTL FIFO Two bit ECC error */
> +#define XCAN_IXR_E1BETXTL_MASK		BIT(18) /* TXTL FIFO One bit ECC error */

Please move the XCAN_IXR next to the other XCAN_IXR.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uavg33o2ipzoq7yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSMQkAACgkQvlAcSiqK
BOjbNgf/RxHDH+YCYClwCOaV6RhP831bA2t6dfotZERv4Ew6yibGZaSoSALn59Yo
SomlFtQ5H80T9iIOM5qQXabM7KsLXiav7RN2hQNThrVFVi5vwk6iO3ZtVXkZ3vqj
4ghQdSIQhwyoneV1RGX19KRTkw+J5/QIdHBU0VyG3ztT8BJB43+JIdAGllF/oBGC
1RlQDYciowHLFiBevP62ZKFlulao2gmunSqad21OCIqbDW0gDGrErgOVqmWr7xG/
J09VVdabpTZUaoJPoT3eGfIcXhA1oUhNaZiFCc0TSTXXdYQf6sf1PWuOblQ+IjTG
2Z9WLAKN2xSAu79s1TTGulBoogS7Bw==
=FHno
-----END PGP SIGNATURE-----

--uavg33o2ipzoq7yz--
