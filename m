Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4399A72B3FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjFKUpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKUps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:45:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F9FE4F;
        Sun, 11 Jun 2023 13:45:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f620583bc2so4131975e87.1;
        Sun, 11 Jun 2023 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686516345; x=1689108345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SDPR0lN37/Etf4z1x/Vv5z7Cy0H7kYZQC284wUTIpW0=;
        b=i0AfpQbeRHTGPvbhmR7vj1YhJ7wDpiZiAxYZWjj8qv2SGWX0HRvtZgx53Pxq6aeMme
         oknN4v3BbtvZGNUmmjBWJv655/C/Mj8/44wvVtNtiX5Zsv9Ww9ODOmqraM6LY//jyWjg
         ZHJxgBbzaZSUmI1qoeg8GZNN5WoKmbz5rBRL8PlcO9vthFDmCouCAmqzmknOL2DRsOeL
         /Gg39P6pv4x+vaigZ3bZ+cmvMqZ4xIntrLaEhIsKZSOte8ngwebKrAnOb6xrIwqqm3UA
         ENQw4TpGBRGGNMG7i1wPx62qXt2tcpRY6m0cVi+8PGP7Tg/CjUZX4HI1Aj3gRwPLHEKQ
         445w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686516345; x=1689108345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDPR0lN37/Etf4z1x/Vv5z7Cy0H7kYZQC284wUTIpW0=;
        b=VyZnVhtbu1opkGnPU4VAHfQVPxLRNhrrO+Foxbub1YRqB9fn4h1lqdh4026zf8vpAy
         fUgks/jmrUjahsQGNn+GJaeS0Q+P5qp058NuNREk9PzqFoI6j5dQqI0vFx/6ndhov5Si
         m+QivNIiLPsHKkUNvk3TrkOGxs8lYwDz6Gp6PVL6PZ7PKCrdoMuKERcuTpAAv8WjHwE0
         d8i9Td8ieadgoTBlfMSWRM//MJ9XY2s4KgR1O0xAvUHjPF7FFeeVrRotUwIMTrzE8v1p
         WxR22Vv7MWsCrwcZTRqUTd4hQtRn7RtiK+yfqVe8wFsxhU+ydfNN4poI3mqdPoz1fVHP
         KfmQ==
X-Gm-Message-State: AC+VfDz0vUTwakRV0Mx7U+wqm8Jc+3GwPJTQSlYRhtdKt+AZLlH5Z4k1
        /cpgjX0K0nZpOlX6fDXIK3eUBrqOTvI=
X-Google-Smtp-Source: ACHHUZ6PE4nh1WmokN2W3/3wflfgSUrc+lo6azZRPeMKZg2a89HzQF1TLUulutIQKQegouQsi4GtMg==
X-Received: by 2002:ac2:5928:0:b0:4f4:7afe:c36 with SMTP id v8-20020ac25928000000b004f47afe0c36mr3364719lfi.10.1686516344956;
        Sun, 11 Jun 2023 13:45:44 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25930000000b004f63dd1dab0sm1235673lfi.98.2023.06.11.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 13:45:44 -0700 (PDT)
Date:   Sun, 11 Jun 2023 23:45:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Message-ID: <20230611204541.ml3ekvsj4qnlmc2s@mobilestation>
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608162238.50078-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 06:22:35PM +0200, Sebastian Reichel wrote:
> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
> allowed clocks without bloating the generic binding, the description
> of Rockchip's AHCI controllers has been moved to its own file.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/ata/rockchip,dwc-ahci.yaml       | 114 ++++++++++++++++++
>  .../bindings/ata/snps,dwc-ahci.yaml           |  17 ++-
>  2 files changed, 125 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> new file mode 100644
> index 000000000000..86da9bd594a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DWC AHCI SATA controller for Rockchip devices
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description:
> +  This document defines device tree bindings for the Synopsys DWC
> +  implementation of the AHCI SATA controller found in Rockchip
> +  devices.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3588-dwc-ahci
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3588-dwc-ahci
> +      - const: snps,dwc-ahci
> +
> +  ports-implemented:
> +    const: 1
> +
> +patternProperties:

> +  "^sata-port@[0-9a-e]$":
> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
> +

What about adding the "reg" property constraints? Seeing the
"ports-implemented" property is supposed to be "1" the "reg" property
should be zero for all the Rockchip AHCI SATA controllers. Right?

> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - ports-implemented
> +
> +allOf:
> +  - $ref: snps,dwc-ahci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3588-dwc-ahci
> +    then:
> +      properties:

> +        clock-names:
> +          items:
> +            - const: sata
> +            - const: pmalive
> +            - const: rxoob
> +            - const: ref
> +            - const: asic

The "clocks" property constraints could have been added too. Right?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3568-dwc-ahci
> +    then:
> +      properties:

> +        clock-names:
> +          items:
> +            - const: sata
> +            - const: pmalive
> +            - const: rxoob

ditto

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/ata/ahci.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    sata@fe210000 {
> +      compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
> +      reg = <0xfe210000 0x1000>;
> +      clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
> +               <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
> +               <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
> +      clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
> +      interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
> +      ports-implemented = <0x1>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sata-port@0 {
> +        reg = <0>;
> +        hba-port-cap = <HBA_PORT_FBSCP>;
> +        phys = <&combphy0_ps PHY_TYPE_SATA>;
> +        phy-names = "sata-phy";
> +        snps,rx-ts-max = <32>;
> +        snps,tx-ts-max = <32>;
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> index 5afa4b57ce20..55a4bdfa3d9a 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -13,8 +13,14 @@ description:
>    This document defines device tree bindings for the generic Synopsys DWC
>    implementation of the AHCI SATA controller.
>  

> -allOf:
> -  - $ref: snps,dwc-ahci-common.yaml#
> +select:
> +  properties:
> +    compatible:
> +      enum:
> +        - snps,dwc-ahci
> +        - snps,spear-ahci
> +  required:
> +    - compatible

Please don't move the allOf property. It's ok to have it defined above
the object properties clause if it has just a few ref-statements.

* Also make sure please that the "select" property is defined above
the "allOf" schema composition.

-Serge(y)

>  
>  properties:
>    compatible:
> @@ -23,10 +29,6 @@ properties:
>          const: snps,dwc-ahci
>        - description: SPEAr1340 AHCI SATA device
>          const: snps,spear-ahci
> -      - description: Rockhip RK3568 AHCI controller
> -        items:
> -          - const: rockchip,rk3568-dwc-ahci
> -          - const: snps,dwc-ahci
>  
>  patternProperties:
>    "^sata-port@[0-9a-e]$":
> @@ -39,6 +41,9 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - $ref: snps,dwc-ahci-common.yaml#
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.39.2
> 
