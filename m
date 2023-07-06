Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE706749657
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjGFH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjGFH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:26:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577C1BDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:25:58 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qHJMf-0004nH-2I; Thu, 06 Jul 2023 09:25:21 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3B9B51EA41D;
        Thu,  6 Jul 2023 07:25:14 +0000 (UTC)
Date:   Thu, 6 Jul 2023 09:25:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Judith Mendez <jm@ti.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH 2/2] can: m_can: Add hrtimer to generate software
 interrupt
Message-ID: <20230706-unstopped-skedaddle-7168f2b12189-mkl@pengutronix.de>
References: <20230705195356.866774-1-jm@ti.com>
 <20230705195356.866774-3-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tmycw3ojonpci4ns"
Content-Disposition: inline
In-Reply-To: <20230705195356.866774-3-jm@ti.com>
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


--tmycw3ojonpci4ns
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.07.2023 14:53:56, Judith Mendez wrote:
> Introduce timer polling method to MCAN since some SoCs may not
> have M_CAN interrupt routed to A53 Linux and do not have
> interrupt property in device tree M_CAN node.
>=20
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use timer polling method.
>=20
> Add an hrtimer to MCAN class device. Each MCAN will have its own
> hrtimer instantiated if there is no hardware interrupt found in
> device tree M_CAN node. The timer will generate a software
> interrupt every 1 ms. In hrtimer callback, we check if there is
> a transaction pending by reading a register, then process by
> calling the isr if there is.
>=20
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Verdin AM=
62
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changelog:
> v9:
> - Change add MS to HRTIMER_POLL_INTERVAL
> - Change syntax from "=3D 0" to "!"
> v8:
> - Cancel hrtimer after interrupts in m_can_stop
> - Move assignment of hrtimer_callback to m_can_class_register()
> - Initialize irq =3D 0 if polling mode is used

This change has been lost :(

> - Add reson for polling mode in commit msg
> - Remove unrelated change
> - Remove polling flag
> v7:
> - Clean up m_can_platform.c if/else section after removing poll-interval
> - Remove poll-interval from patch description
> v6:
> - Move hrtimer stop/start function calls to m_can_open and m_can_close to
> support power suspend/resume
> v5:
> - Change dev_dbg to dev_info if hardware interrupt exists and polling
> is enabled
> v4:
> - No changes
> v3:
> - Create a define for 1 ms polling interval
> - Change plarform_get_irq to optional to not print error msg
> v2:
> - Add functionality to check for 'poll-interval' property in MCAN node=20
> - Add 'polling' flag in driver to check if device is using polling method
> - Check for timer polling and hardware interrupt cases, default to
> hardware interrupt method
> - Change ns_to_ktime() to ms_to_ktime()
> ---
>  drivers/net/can/m_can/m_can.c          | 32 +++++++++++++++++++++++++-
>  drivers/net/can/m_can/m_can.h          |  3 +++
>  drivers/net/can/m_can/m_can_platform.c | 23 +++++++++++++++---
>  3 files changed, 54 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index c5af92bcc9c9..13fd84b2e2dd 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/can/dev.h>
>  #include <linux/ethtool.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -308,6 +309,9 @@ enum m_can_reg {
>  #define TX_EVENT_MM_MASK	GENMASK(31, 24)
>  #define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
> =20
> +/* Hrtimer polling interval */
> +#define HRTIMER_POLL_INTERVAL_MS		1
> +
>  /* The ID and DLC registers are adjacent in M_CAN FIFO memory,
>   * and we can save a (potentially slow) bus round trip by combining
>   * reads and writes to them.
> @@ -1414,6 +1418,12 @@ static int m_can_start(struct net_device *dev)
> =20
>  	m_can_enable_all_interrupts(cdev);
> =20
> +	if (!dev->irq) {
> +		dev_dbg(cdev->dev, "Start hrtimer\n");
> +		hrtimer_start(&cdev->hrtimer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
> +			      HRTIMER_MODE_REL_PINNED);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -1568,6 +1578,11 @@ static void m_can_stop(struct net_device *dev)
>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> =20
> +	if (!dev->irq) {
> +		dev_dbg(cdev->dev, "Stop hrtimer\n");
> +		hrtimer_cancel(&cdev->hrtimer);
> +	}
> +
>  	/* disable all interrupts */
>  	m_can_disable_all_interrupts(cdev);
> =20
> @@ -1793,6 +1808,18 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff=
 *skb,
>  	return NETDEV_TX_OK;
>  }
> =20
> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct m_can_classdev *cdev =3D container_of(timer, struct
> +						   m_can_classdev, hrtimer);
> +
> +	m_can_isr(0, cdev->net);
> +
> +	hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));
> +
> +	return HRTIMER_RESTART;
> +}
> +
>  static int m_can_open(struct net_device *dev)
>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> @@ -1831,7 +1858,7 @@ static int m_can_open(struct net_device *dev)
>  		err =3D request_threaded_irq(dev->irq, NULL, m_can_isr,
>  					   IRQF_ONESHOT,
>  					   dev->name, dev);
> -	} else {
> +	} else if (dev->irq) {
>  		err =3D request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
>  				  dev);
>  	}
> @@ -2027,6 +2054,9 @@ int m_can_class_register(struct m_can_classdev *cde=
v)
>  			goto clk_disable;
>  	}
> =20
> +	if (!cdev->net->irq)
> +		cdev->hrtimer.function =3D &hrtimer_callback;
> +
>  	ret =3D m_can_dev_setup(cdev);
>  	if (ret)
>  		goto rx_offload_del;
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index a839dc71dc9b..2ac18ac867a4 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/freezer.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -93,6 +94,8 @@ struct m_can_classdev {
>  	int is_peripheral;
> =20
>  	struct mram_cfg mcfg[MRAM_CFG_NUM];
> +
> +	struct hrtimer hrtimer;
>  };
> =20
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int =
sizeof_priv);
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index 94dc82644113..76d11ce38220 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -5,6 +5,7 @@
>  //
>  // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.=
com/
> =20
> +#include <linux/hrtimer.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> =20
> @@ -96,12 +97,28 @@ static int m_can_plat_probe(struct platform_device *p=
dev)
>  		goto probe_fail;

Please set "irq" to 0 during declaration.

> =20
>  	addr =3D devm_platform_ioremap_resource_byname(pdev, "m_can");
> -	irq =3D platform_get_irq_byname(pdev, "int0");
> -	if (IS_ERR(addr) || irq < 0) {
> -		ret =3D -EINVAL;
> +	if (IS_ERR(addr)) {
> +		ret =3D PTR_ERR(addr);
>  		goto probe_fail;
>  	}
> =20
> +	if (device_property_present(mcan_class->dev, "interrupts") ||
> +	    device_property_present(mcan_class->dev, "interrupt-names")) {
> +		irq =3D platform_get_irq_byname(pdev, "int0");
> +		if (irq =3D=3D -EPROBE_DEFER) {
> +			ret =3D -EPROBE_DEFER;
> +			goto probe_fail;
> +		}
> +		if (irq < 0) {
> +			ret =3D -EINVAL;

Please return the original error value.

> +			goto probe_fail;
> +		}
> +	} else {
> +		dev_dbg(mcan_class->dev, "Polling enabled, initialize hrtimer");
> +		hrtimer_init(&mcan_class->hrtimer, CLOCK_MONOTONIC,
> +			     HRTIMER_MODE_REL_PINNED);
> +	}
> +
>  	/* message ram could be shared */
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram=
");
>  	if (!res) {
> --=20
> 2.34.1
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tmycw3ojonpci4ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSmbFYACgkQvlAcSiqK
BOgJaQgAhz4eZqUAOMPrcuu3yj+65snWRq39dbNtx7p8P3zynTmJTY/u+/5FcduW
zPjps+bE+c+GKIPZXzsAPqVVJqxUunIFZJUC8kPEtMB1jQE9b6dGFeQlh0ssgrHg
OfGhmKJ6IqDpOOTx5edZgBYphH0rMsoFXTiZK0QKlqjtLny0JC1iq9+zas+/YY4p
/rbDoNFZQLcLwRAubcQHZ2ihhDvSN0kzGk89q3yCKZ489RwtGq4e+h1Ols7Sxp6+
c0gglKT4SAETZtzOSl1O+wiKS/o8A88bPzdnWSOOhCxU2ZdouOzEEMrYyiWhZW3L
1xrmb/4u+8uKcZb0ViUZ+LH26P8pOg==
=mZ8A
-----END PGP SIGNATURE-----

--tmycw3ojonpci4ns--
