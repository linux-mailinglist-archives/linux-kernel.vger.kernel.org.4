Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6803A72E1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjFMLa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjFMLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:30:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C1C98
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:30:49 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q92EK-0005Df-2i; Tue, 13 Jun 2023 13:30:32 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0B1161D8969;
        Tue, 13 Jun 2023 11:30:30 +0000 (UTC)
Date:   Tue, 13 Jun 2023 13:30:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com,
        git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] can: xilinx_can: Add ECC support
Message-ID: <20230613-sprinkler-pasta-08ae2bd72ac8-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-3-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x5xvyuil73mjsnjs"
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


--x5xvyuil73mjsnjs
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
> +#define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error count=
ers */
> +#define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error c=
ounters */
> +#define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error c=
ounters */
> +#define XCAN_ECC_1BIT_CNT_MASK		GENMASK(15, 0) /* FIFO ECC 1bit count ma=
sk */
> +#define XCAN_ECC_2BIT_CNT_MASK		GENMASK(31, 16) /* FIFO ECC 2bit count m=
ask */
> =20
>  /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
>  #define XCAN_BRPR_TDC_ENABLE		BIT(16) /* Transmitter Delay Compensation =
(TDC) Enable */
> @@ -198,6 +215,13 @@ struct xcan_devtype_data {
>   * @bus_clk:			Pointer to struct clk
>   * @can_clk:			Pointer to struct clk
>   * @devtype:			Device type specific constants
> + * @ecc_enable:			ECC enable flag
> + * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
> + * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
> + * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
> + * @ecc_1bit_txolfifo_cnt:	TXOLFIFO 1bit ECC count
> + * @ecc_2bit_txtlfifo_cnt:	TXTLFIFO 2bit ECC count
> + * @ecc_1bit_txtlfifo_cnt:	TXTLFIFO 1bit ECC count
>   */
>  struct xcan_priv {
>  	struct can_priv can;
> @@ -215,6 +239,13 @@ struct xcan_priv {
>  	struct clk *bus_clk;
>  	struct clk *can_clk;
>  	struct xcan_devtype_data devtype;
> +	bool ecc_enable;
> +	u32 ecc_2bit_rxfifo_cnt;
> +	u32 ecc_1bit_rxfifo_cnt;
> +	u32 ecc_2bit_txolfifo_cnt;
> +	u32 ecc_1bit_txolfifo_cnt;
> +	u32 ecc_2bit_txtlfifo_cnt;
> +	u32 ecc_1bit_txtlfifo_cnt;
>  };
> =20
>  /* CAN Bittiming constants as per Xilinx CAN specs */
> @@ -517,6 +548,11 @@ static int xcan_chip_start(struct net_device *ndev)
>  		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
>  		XCAN_IXR_ARBLST_MASK | xcan_rx_int_mask(priv);
> =20
> +	if (priv->ecc_enable)
> +		ier |=3D XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
> +			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
> +			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
> +
>  	if (priv->devtype.flags & XCAN_FLAG_RXMNF)
>  		ier |=3D XCAN_IXR_RXMNF_MASK;
> =20
> @@ -1121,6 +1157,56 @@ static void xcan_err_interrupt(struct net_device *=
ndev, u32 isr)
>  		priv->can.can_stats.bus_error++;
>  	}
> =20
> +	if (priv->ecc_enable) {
> +		u32 reg_ecc;
> +
> +		reg_ecc =3D priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
> +		if (isr & XCAN_IXR_E2BERX_MASK) {
> +			priv->ecc_2bit_rxfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: RX FIFO 2bit ECC error count %d\n",
> +				   __func__, priv->ecc_2bit_rxfifo_cnt);
> +		}
> +		if (isr & XCAN_IXR_E1BERX_MASK) {
> +			priv->ecc_1bit_rxfifo_cnt +=3D reg_ecc &
> +				XCAN_ECC_1BIT_CNT_MASK;

Please use FIELD_GET here, too.

> +			netdev_dbg(ndev, "%s: RX FIFO 1bit ECC error count %d\n",
> +				   __func__, priv->ecc_1bit_rxfifo_cnt);
> +		}
> +
> +		reg_ecc =3D priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
> +		if (isr & XCAN_IXR_E2BETXOL_MASK) {
> +			priv->ecc_2bit_txolfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: TXOL FIFO 2bit ECC error count %d\n",
> +				   __func__, priv->ecc_2bit_txolfifo_cnt);
> +		}
> +		if (isr & XCAN_IXR_E1BETXOL_MASK) {
> +			priv->ecc_1bit_txolfifo_cnt +=3D reg_ecc &
> +				XCAN_ECC_1BIT_CNT_MASK;

same here

> +			netdev_dbg(ndev, "%s: TXOL FIFO 1bit ECC error count %d\n",
> +				   __func__, priv->ecc_1bit_txolfifo_cnt);
> +		}
> +
> +		reg_ecc =3D priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
> +		if (isr & XCAN_IXR_E2BETXTL_MASK) {
> +			priv->ecc_2bit_txtlfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: TXTL FIFO 2bit ECC error count %d\n",
> +				   __func__, priv->ecc_2bit_txtlfifo_cnt);
> +		}
> +		if (isr & XCAN_IXR_E1BETXTL_MASK) {
> +			priv->ecc_1bit_txtlfifo_cnt +=3D reg_ecc &
> +				XCAN_ECC_1BIT_CNT_MASK;

same here

> +			netdev_dbg(ndev, "%s: TXTL FIFO 1bit ECC error count %d\n",
> +				   __func__, priv->ecc_1bit_txtlfifo_cnt);
> +		}
> +
> +		/* Reset FIFO ECC counters */
> +		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
> +				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);

This is racy - you will lose events that occur between reading the
register value and clearing the register. You can save the old value and
add the difference between the new and the old value to the total
counter. What happens when the counter overflows? The following
pseudocode should handle the u16 counter rolling over to 0:

    u16 old, new;
    s16 inc;
    u64 total;

    ...

    inc =3D (s16)(new - old);
    if (inc < 0)
        /* error handling */
    total +=3D inc;

BTW: When converting to ethtool statistics, a lock is required to keep
the u64 values correct on 32-bit systems and the individual statistics
consistent.

> +	}
> +
>  	if (cf.can_id) {
>  		struct can_frame *skb_cf;
>  		struct sk_buff *skb =3D alloc_can_err_skb(ndev, &skb_cf);
> @@ -1348,9 +1434,8 @@ static irqreturn_t xcan_interrupt(int irq, void *de=
v_id)
>  {
>  	struct net_device *ndev =3D (struct net_device *)dev_id;
>  	struct xcan_priv *priv =3D netdev_priv(ndev);
> -	u32 isr, ier;
> -	u32 isr_errors;
>  	u32 rx_int_mask =3D xcan_rx_int_mask(priv);
> +	u32 isr, ier, isr_errors, mask;
> =20
>  	/* Get the interrupt status from Xilinx CAN */
>  	isr =3D priv->read_reg(priv, XCAN_ISR_OFFSET);
> @@ -1368,10 +1453,18 @@ static irqreturn_t xcan_interrupt(int irq, void *=
dev_id)
>  	if (isr & XCAN_IXR_TXOK_MASK)
>  		xcan_tx_interrupt(ndev, isr);
> =20
> +	mask =3D XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
> +		XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
> +		XCAN_IXR_RXMNF_MASK;
> +
> +	if (priv->ecc_enable)
> +		mask |=3D XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
> +			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
> +			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
> +
>  	/* Check for the type of error interrupt and Processing it */
> -	isr_errors =3D isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
> -			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
> -			    XCAN_IXR_RXMNF_MASK);
> +	isr_errors =3D isr & mask;
> +

nitpick: don't add this extra newline

>  	if (isr_errors) {
>  		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
>  		xcan_err_interrupt(ndev, isr);
> @@ -1783,6 +1876,7 @@ static int xcan_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> =20
>  	priv =3D netdev_priv(ndev);
> +	priv->ecc_enable =3D of_property_read_bool(pdev->dev.of_node, "xlnx,has=
-ecc");
>  	priv->dev =3D &pdev->dev;
>  	priv->can.bittiming_const =3D devtype->bittiming_const;
>  	priv->can.do_set_mode =3D xcan_do_set_mode;
> @@ -1880,6 +1974,11 @@ static int xcan_probe(struct platform_device *pdev)
>  		   priv->reg_base, ndev->irq, priv->can.clock.freq,
>  		   hw_tx_max, priv->tx_max);
> =20
> +	if (priv->ecc_enable)
> +		/* Reset FIFO ECC counters */
> +		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
> +			XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
> +
>  	return 0;
> =20
>  err_disableclks:
> --=20
> 2.1.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x5xvyuil73mjsnjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSIU1IACgkQvlAcSiqK
BOg4UAf+Nzsctgt3tbAv+7DLje/Eme8+r5w7djNvakpPYt6XSENx1HCHemOw2pe6
i1DhC6kCixnk21dhCUYH4Mf2gzwyk7ZVPAAdtspE7wvLabdby/7En4nRTuDMAm+t
fZ2706Sa2mLNLlEjCGHm1W8bVeUw1Q+jnrEif14suFvPZBXTO6xrM88607C2L4dX
1wpszAMqCGbbTFy1wpfSDhQ0bgenyl9OkHRYiqJ0S1XRNdYrVEEZ8ENcQs/Nlfmu
wdB7UBtbGLzEzTEehZREeI/yqmGxp+M1SPntgSlNBzceOfCWPSz1OKMaEabVv7GV
Uu6+PhY42MT3XYyyq8Es+4cmk4Qodw==
=1wZV
-----END PGP SIGNATURE-----

--x5xvyuil73mjsnjs--
