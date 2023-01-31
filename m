Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D47683076
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjAaPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjAaPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:01:37 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BDD53B29;
        Tue, 31 Jan 2023 07:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675177240; x=1706713240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQjv9h2KaRO+L3XX5GdqWlB47oyUbZcbGv87/2bekG0=;
  b=Quq/dxi4Wz9HCYVCyNktYIMeEibTmYdrwDU6aLDpI7D8S/h5golVzeRE
   9cVyeDznQtNsMMNgnCvYXSaEBkO58rsdgg/dM7W7DgvfEZu5/I4/nASTH
   wbLVrjb4QjP6X32hCq8o45HW7zIpnxqvTDZ6boTaMQNkcKbL13vgKtSCL
   809jANILKpzw05IoC8lrGlJua4j5NcIhJ91s5ZnXkamvQfLCmUyyeddIE
   vOf55+5S4enmhEKgJdUYh+xtMoN6NfgKQHRMB6vFuNXSmNBQVRgGlX1lT
   o+sCOARspNUykSAquvpmC6qLX9h9K3e/g1OU6Y2PolKZm6McYx3C4FgXa
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28776223"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 16:00:38 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 16:00:38 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 16:00:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675177238; x=1706713238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQjv9h2KaRO+L3XX5GdqWlB47oyUbZcbGv87/2bekG0=;
  b=U5EPu262uJyfi0lzqMgKwonyMjfdC7ahxi4PQWfXim16Su3a5eG5qQ1g
   tcZasCgerm8dPNWzOqA56+pWN3bIKHZnmUEH4hLkVvhL8GyFH4iANGxzY
   9PluWfz2knfu6ju6O4bH2w0F1QCbdxTUO7WX4gtu3tZqFc0Oy8FuZ0+8G
   e+rMEpUIhflFWBS4OIJfoOvtvHaRj+Sf/WZa0I/40sMsipOb49bkaP+wF
   wDLZbi1/iZXWBBTzYhnoNyfHr09J498cjau4p51ILVWKi3DhMWlHkJZZH
   a+GyjBIjaHt8Wgof/cRmZRIMqPmIlqIYtvOatRE8MySHCQiZgLtNGkjOV
   A==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28776221"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 16:00:38 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0F43B280072;
        Tue, 31 Jan 2023 16:00:38 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v5 02/10] arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
Date:   Tue, 31 Jan 2023 16:00:37 +0100
Message-ID: <8183250.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230126110833.264439-3-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com> <20230126110833.264439-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Donnerstag, 26. Januar 2023, 12:08:25 CET schrieb Marcel Ziswiler:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> This commit adds io-channel-cells property to the ADC nodes. This
> property is required in order for an IIO consumer driver to work.
> Especially required for Apalis iMX8 QM, as the touchscreen driver
> uses ADC channels with the ADC driver based on IIO framework.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Yep, that's even required per bindings.
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Fix subject as pointed out by Shawn. Thanks!
> 
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi index
> a943a1e2797f..6e5ef8b69bf8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -270,6 +270,7 @@ i2c3: i2c@5a830000 {
> 
>  	adc0: adc@5a880000 {
>  		compatible = "nxp,imx8qxp-adc";
> +		#io-channel-cells = <1>;
>  		reg = <0x5a880000 0x10000>;
>  		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> @@ -284,6 +285,7 @@ adc0: adc@5a880000 {
> 
>  	adc1: adc@5a890000 {
>  		compatible = "nxp,imx8qxp-adc";
> +		#io-channel-cells = <1>;
>  		reg = <0x5a890000 0x10000>;
>  		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;




