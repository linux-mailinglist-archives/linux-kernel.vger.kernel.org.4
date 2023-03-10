Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00D6B3868
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCJIUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:20:20 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F090FAEE9;
        Fri, 10 Mar 2023 00:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678436418; x=1709972418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8oqli5ELwyYuRk8iiNob0FAh7UhCXeB2HZSbIH+mCQ=;
  b=cZgRn3fOpTwCpNCYs/4y7o10AtjvtykWQCiFPRZfLX7uFWwLgdv8r9wu
   b3S/HpEvL5jpSfRA4fHJ8NAL+25XxgEbwyJUy/XX2Kzzk1aQzSAAm2lN+
   nVU6UUgR+Mro1b8id+mepm28HZ0pbhBtf/klAz4572lX8mi5y7WTgb8o1
   rVPnmWCvIZTKvJoqxsUER8Ui8h7UspVZa0+Zy8ZxivuYW9lxt+9kFJuoL
   bcdFRu1s6Kqb8MLLJ55Lz7i2ekN22vagb8fYO+Mepzhs7AT823uuNS7GG
   SrrcdzOBgXoug5DOAMpLvlXJQZ7iwqGi1oGbudv/3g+346NFH3QWX7gmu
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29598345"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Mar 2023 09:20:16 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Mar 2023 09:20:15 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Mar 2023 09:20:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678436416; x=1709972416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8oqli5ELwyYuRk8iiNob0FAh7UhCXeB2HZSbIH+mCQ=;
  b=THOtUyexuD+3MbeRSYciBiFd4eCMd6/Wo5pHQKUSg/0tZ+9zJPekus0y
   sGkAhznCAruCItvtwOknymut6Cv81zaIJPh6Q1K/Wo6tqp2BNwJqExwlF
   5OEfpEBhFV7js2XhHfCFRAiVcVy04IUFNVcEdArzWG/rryAVA4eFckpyt
   dbjT2YbHMtsefqRXva0gCZ17DGE6vhoI+78UQANcFWiLtVyEHsZ1KVJo/
   uSsdcMHtF9eEMvgJyvvw4NGLxKbNrdvx1HjW8Fvet3LuR1qi5QyTr3o/4
   o3qSC+mcxorc6Bfw25MpoC23w56LRYZpzNlw39DB0UMxqBJxuyvFmD9QU
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29598344"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 09:20:16 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 872F8280056;
        Fri, 10 Mar 2023 09:20:15 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: imx93: Add CPU thermal zone
Date:   Fri, 10 Mar 2023 09:20:11 +0100
Message-ID: <112132134.nniJfEyVGO@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230105101748.6714-5-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com> <20230105101748.6714-5-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 5. Januar 2023, 11:17:48 CET schrieb Alice Guo (OSS):
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Add CPU thermal zone and attach it to the TMU which monitors the CPU
> temperature.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 48 ++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> b/arch/arm64/boot/dts/freescale/imx93.dtsi index 6808321ed809..60306f3c5e=
7f
> 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/fsl,imx93-power.h>
> +#include <dt-bindings/thermal/thermal.h>
>=20
>  #include "imx93-pinfunc.h"
>=20
> @@ -116,6 +117,38 @@
>  		interrupt-parent =3D <&gic>;
>  	};
>=20
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <2000>;
> +
> +			thermal-sensors =3D <&tmu 0>;
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature =3D <80000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu_crit: cpu-crit {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +		};

This brace needs an additional indent.

Best regards,
Alexander

> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_alert>;
> +					cooling-device =3D
> +						<&A55_0=20
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_1=20
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
>  	soc@0 {
>  		compatible =3D "simple-bus";
>  		#address-cells =3D <1>;
> @@ -280,6 +313,21 @@
>  				compatible =3D "fsl,imx93-anatop",=20
"syscon";
>  				reg =3D <0x44480000 0x10000>;
>  			};
> +
> +			tmu: tmu@44482000 {
> +				compatible =3D "fsl,imx93-tmu";
> +				reg =3D <0x44482000 0x1000>;
> +				clocks =3D <&clk IMX93_CLK_TMC_GATE>;
> +				little-endian;
> +				fsl,tmu-calibration =3D <0x0000000e=20
0x800000da
> +						       0x00000029=20
0x800000e9
> +						       0x00000056=20
0x80000102
> +						       0x000000a2=20
0x8000012a
> +						       0x00000116=20
0x80000166
> +						       0x00000195=20
0x800001a7
> +						       0x000001b2=20
0x800001b6>;
> +				#thermal-sensor-cells =3D <1>;
> +			};
>  		};
>=20
>  		aips2: bus@42000000 {


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


