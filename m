Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE36FA002
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEHGek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjEHGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:34:36 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58FE2
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683527675; x=1715063675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=suMr6SybvprQpCGrVdRBApWqSn9ir2oFjeWB/dINGJ4=;
  b=pVQMU8CzRt2lVYGB79VWSF7NmIyR5hLBLBePQ9TgODr1drPH/E8kt1LA
   b/jCBfOyi32Je1eD5+SK2VTC+HEUOzPmE3oR2AOu//WRd0T8M8uQ4GQJF
   42FLkjRcJSws4Y1GiwlnTw/RqorO/ziXYX5G/47nqxqQKeMKGbMAslrFo
   Wby87ZPwx4jkTiL6+/mDpcSBLI91q4H7XgFLIHgmzkhKodBcXJyBWVYLZ
   vkaWzTmw6I2lI3TSzWfM5xkOYRcULWmFh2DBVMxPNjBTR8i/PMm+vL6C9
   yo3+1ovq0DXJQ6Oy6MTnn34wiylPK/FWId1tunGu9v9zjjjLc9CBDntK2
   g==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677538800"; 
   d="scan'208";a="30764582"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 May 2023 08:34:32 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 08 May 2023 08:34:32 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 08 May 2023 08:34:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683527672; x=1715063672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=suMr6SybvprQpCGrVdRBApWqSn9ir2oFjeWB/dINGJ4=;
  b=liQBTFg3br+JMOjHOmcYUhz5p0DVt5/Vxat9b6ovmQZPgQtqDA54Dhzo
   +X1IHK8OvURjxXoUFmfe0Fk3Igkh6yT5Zsxj4tyeaTtSMy/hEgz0fkwAy
   YQbYib23Aw0CvWEZgAARGNu+zz+HEekOzFSqyCx8QmJJEbLslt4NX2Adu
   6qwQAkuKaI7y0aoRhTBiZlh52/fcnDqdkzTSFdCKPyn98V+//XZpbcori
   wSXIMdyFbP8l9NYmMX8E0vhnO1ZYPsrLyUiQ8cIWBsnFr0o/E1Q1Jsiu3
   N/igFODbrRxLzFg36EjmMi2HxU/ln4YmsrVK5YLSPPVbE+DiiBTMi816B
   g==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677538800"; 
   d="scan'208";a="30764581"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 May 2023 08:34:32 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 43724280056;
        Mon,  8 May 2023 08:34:32 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH] arm64: dts: imx93: add wdog3 node
Date:   Mon, 08 May 2023 08:34:31 +0200
Message-ID: <2682988.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230505093130.1834861-1-peng.fan@oss.nxp.com>
References: <20230505093130.1834861-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks for the patch.

Am Freitag, 5. Mai 2023, 11:31:30 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add wdog3 node, then watchdog could be used.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> b/arch/arm64/boot/dts/freescale/imx93.dtsi index e8d49660ac85..73ecd953ec=
8d
> 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -344,6 +344,14 @@ mu2: mailbox@42440000 {
>  				status =3D "disabled";
>  			};
>=20
> +			wdog3: wdog@42490000 {

I think this should be called 'watchdog@42490000'

> +				compatible =3D "fsl,imx93-wdt";
> +				reg =3D <0x42490000 0x10000>;
> +				interrupts =3D <GIC_SPI 79=20
IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clk IMX93_CLK_WDOG3_GATE>;
> +				timeout-sec =3D <40>;

Should it be disabled it by default?

> +			};
> +
>  			tpm3: pwm@424e0000 {
>  				compatible =3D "fsl,imx7ulp-pwm";
>  				reg =3D <0x424e0000 0x1000>;

Is there a reason you just add watchdog3? There are 5 in total.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


