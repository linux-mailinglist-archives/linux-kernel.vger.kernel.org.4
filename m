Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F76F3F63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjEBInB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEBIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:42:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9A469D;
        Tue,  2 May 2023 01:42:55 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ptlay-0006Md-K6; Tue, 02 May 2023 10:42:48 +0200
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
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: rockchip-otp: Add compatible for RK3588
Date:   Tue, 02 May 2023 10:42:47 +0200
Message-ID: <5471965.k3LOHGUjKi@diego>
In-Reply-To: <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
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

Am Montag, 1. Mai 2023, 10:43:54 CEST schrieb Cristian Ciocaltea:
> Document the OTP memory found on Rockchip RK3588 SoC.

nit: I guess the changed clock and resets configuration for rk3588 variants
could be mentioned in the commit message.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../bindings/nvmem/rockchip-otp.yaml          | 71 ++++++++++++++++---
>  1 file changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> index 658ceed14ee2..84a11382c6e7 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> @@ -9,34 +9,31 @@ title: Rockchip internal OTP (One Time Programmable) memory
>  maintainers:
>    - Heiko Stuebner <heiko@sntech.de>
>  
> -allOf:
> -  - $ref: nvmem.yaml#
> -
>  properties:
>    compatible:
>      enum:
>        - rockchip,px30-otp
>        - rockchip,rk3308-otp
> +      - rockchip,rk3588-otp
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
>      minItems: 3
> -    maxItems: 3
> +    maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: otp
> -      - const: apb_pclk
> -      - const: phy
> +    minItems: 3
> +    maxItems: 4
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    reset-names:
> -    items:
> -      - const: phy
> +    minItems: 1
> +    maxItems: 3
>  
>  required:
>    - compatible
> @@ -46,6 +43,58 @@ required:
>    - resets
>    - reset-names
>  
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-otp
> +              - rockchip,rk3308-otp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: otp
> +            - const: apb_pclk
> +            - const: phy
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: phy
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3588-otp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: otpc
> +            - const: apb
> +            - const: arb
> +            - const: phy
> +        resets:
> +          minItems: 1
> +          maxItems: 3
> +        reset-names:
> +          items:
> +            - const: otpc
> +            - const: apb
> +            - const: arb
> +
>  unevaluatedProperties: false
>  
>  examples:
> 




