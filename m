Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC36460B5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJXSoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiJXSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:43:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18BC414EC50;
        Mon, 24 Oct 2022 10:25:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C431474;
        Mon, 24 Oct 2022 07:16:54 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91F0C3F792;
        Mon, 24 Oct 2022 07:16:46 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:16:43 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 06/10] ARM: suniv: add USB-related device nodes
Message-ID: <20221024151643.23217a25@donnerap.cambridge.arm.com>
In-Reply-To: <20221012055602.1544944-7-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
        <20221012055602.1544944-7-uwu@icenowy.me>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 13:55:58 +0800
Icenowy Zheng <uwu@icenowy.me> wrote:

Hi,

> The suniv SoC has a USB OTG controller and a USB PHY like other
> Allwinner SoCs.
> 
> Add their device tree node.

Looks alright to me, checked against the manual, also compared against
some other Allwinner USB DT nodes. Also passes the binding and DTB checks.

Just one small question below, but nevertheless:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> No changes since v1.
> 
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> index 0edc1724407b..a01541ba42c5 100644
> --- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -133,6 +133,32 @@ mmc1: mmc@1c10000 {
>  			#size-cells = <0>;
>  		};
>  
> +		usb_otg: usb@1c13000 {
> +			compatible = "allwinner,suniv-f1c100s-musb";
> +			reg = <0x01c13000 0x0400>;
> +			clocks = <&ccu CLK_BUS_OTG>;
> +			resets = <&ccu RST_BUS_OTG>;
> +			interrupts = <26>;
> +			interrupt-names = "mc";
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			extcon = <&usbphy 0>;
> +			allwinner,sram = <&otg_sram 1>;

What is this "1" for? I see it all over the other Allwinner SRAM
properties, but can't find any documentation about that number, nor can I
see that it would be used in the code.

Does anyone know?

Cheers,
Andre

> +			status = "disabled";
> +		};
> +
> +		usbphy: phy@1c13400 {
> +			compatible = "allwinner,suniv-f1c100s-usb-phy";
> +			reg = <0x01c13400 0x10>;
> +			reg-names = "phy_ctrl";
> +			clocks = <&ccu CLK_USB_PHY0>;
> +			clock-names = "usb0_phy";
> +			resets = <&ccu RST_USB_PHY0>;
> +			reset-names = "usb0_reset";
> +			#phy-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		ccu: clock@1c20000 {
>  			compatible = "allwinner,suniv-f1c100s-ccu";
>  			reg = <0x01c20000 0x400>;

