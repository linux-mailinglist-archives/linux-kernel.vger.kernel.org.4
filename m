Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8386F5B6B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiIMKWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiIMKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:22:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538815C9FC;
        Tue, 13 Sep 2022 03:22:19 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oY33V-00045I-Cl; Tue, 13 Sep 2022 12:22:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianling Shen <cnsztl@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Tue, 13 Sep 2022 12:22:11 +0200
Message-ID: <7426763.EvYhyI6sBW@phil>
In-Reply-To: <20220911040628.13774-1-cnsztl@gmail.com>
References: <20220911040628.13774-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 11. September 2022, 06:06:28 CEST schrieb Tianling Shen:
> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> stores the MAC address.
> 
> FriendlyElec ship two versions of the R4S [1]: The standard as well
> as the enterprise edition with only the enterprise edition including
> the EEPROM chip that stores the unique MAC address.

This needs to go differently.

If the eeprom is only preset on the enterprise-version, you need
a separate devicetree for it, that provides the eeprom node.

Declaring the eeprom "in error" on a device that doesn't have it,
isn't the way to go.

Look for example at rockchip/rk3399-nanopi-m4b.dts for reference
on how to do it - and also remember to add the new binding
for that board. And can also again declare the correct mac-address
cell.


Heiko

> 
> 1. https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R4S#Differences_Between_R4S_Standard_Version_.26_R4S_Enterprise_Version
> 
> Changes in v4:
> - Removed `mac-address` cell as it breaks the standard edition
> 
> Changes in v3:
> - Added address-cells and size-cells
> 
> Changes in v2:
> - Added the size of EEPROM
> - Added `mac-address` cell to pass the MAC address to kernel
> - Removed `read-only` property in EEPROM node
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> index fe5b52610010..42c99573ab27 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> @@ -68,6 +68,17 @@ &emmc_phy {
>  	status = "disabled";
>  };
>  
> +&i2c2 {
> +	eeprom@51 {
> +		compatible = "microchip,24c02", "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;
> +		size = <256>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
>  &i2c4 {
>  	status = "disabled";
>  };
> 




