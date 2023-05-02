Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E186F6F3F50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjEBIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjEBIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:38:49 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74FC1BEF;
        Tue,  2 May 2023 01:38:44 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ptlWm-0006KE-Ld; Tue, 02 May 2023 10:38:28 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/8] dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
Date:   Tue, 02 May 2023 10:38:27 +0200
Message-ID: <16553765.RDIVbhacDa@diego>
In-Reply-To: <20230501084401.765169-2-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-2-cristian.ciocaltea@collabora.com>
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

Am Montag, 1. Mai 2023, 10:43:53 CEST schrieb Cristian Ciocaltea:
> Convert the Rockchip OTP memory bindings to dt-schema.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  .../bindings/nvmem/rockchip-otp.txt           | 25 ------
>  .../bindings/nvmem/rockchip-otp.yaml          | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt b/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
> deleted file mode 100644
> index 40f649f7c2e5..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Rockchip internal OTP (One Time Programmable) memory device tree bindings
> -
> -Required properties:
> -- compatible: Should be one of the following.
> -  - "rockchip,px30-otp" - for PX30 SoCs.
> -  - "rockchip,rk3308-otp" - for RK3308 SoCs.
> -- reg: Should contain the registers location and size
> -- clocks: Must contain an entry for each entry in clock-names.
> -- clock-names: Should be "otp", "apb_pclk" and "phy".
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../../reset/reset.txt for details.
> -- reset-names: Should be "phy".
> -
> -See nvmem.txt for more information.
> -
> -Example:
> -	otp: otp@ff290000 {
> -		compatible = "rockchip,px30-otp";
> -		reg = <0x0 0xff290000 0x0 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
> -			 <&cru PCLK_OTP_PHY>;
> -		clock-names = "otp", "apb_pclk", "phy";
> -	};
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> new file mode 100644
> index 000000000000..658ceed14ee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/rockchip-otp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip internal OTP (One Time Programmable) memory
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,px30-otp
> +      - rockchip,rk3308-otp
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: otp
> +      - const: apb_pclk
> +      - const: phy
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        otp: efuse@ff290000 {
> +            compatible = "rockchip,px30-otp";
> +            reg = <0x0 0xff290000 0x0 0x4000>;
> +            clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
> +                     <&cru PCLK_OTP_PHY>;
> +            clock-names = "otp", "apb_pclk", "phy";
> +            resets = <&cru SRST_OTP_PHY>;
> +            reset-names = "phy";
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            cpu_id: id@7 {
> +                reg = <0x07 0x10>;
> +            };
> +
> +            cpu_leakage: cpu-leakage@17 {
> +                reg = <0x17 0x1>;
> +            };
> +
> +            performance: performance@1e {
> +                reg = <0x1e 0x1>;
> +                bits = <4 3>;
> +            };
> +        };
> +    };
> 




