Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1A612C8A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ3UFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3UFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:05:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1812A95B3;
        Sun, 30 Oct 2022 13:05:31 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1opEYb-0005bW-Cr; Sun, 30 Oct 2022 21:05:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCHv2 6/6] dt-bindings: rtc: convert hym8563 bindings to json-schema
Date:   Sun, 30 Oct 2022 21:05:19 +0100
Message-ID: <9218219.T7Z3S40VBb@phil>
In-Reply-To: <20221024165549.74574-7-sebastian.reichel@collabora.com>
References: <20221024165549.74574-1-sebastian.reichel@collabora.com> <20221024165549.74574-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Oktober 2022, 18:55:49 CET schrieb Sebastian Reichel:
> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> Schema format.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
>  .../bindings/rtc/haoyu,hym8563.yaml           | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> deleted file mode 100644
> index a8934fe2ab4c..000000000000
> --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Haoyu Microelectronics HYM8563 Real Time Clock
> -
> -The HYM8563 provides basic rtc and alarm functionality
> -as well as a clock output of up to 32kHz.
> -
> -Required properties:
> -- compatible: should be: "haoyu,hym8563"
> -- reg: i2c address
> -- #clock-cells: the value should be 0
> -
> -Optional properties:
> -- clock-output-names: From common clock binding
> -- interrupts: rtc alarm/event interrupt
> -
> -Example:
> -
> -hym8563: hym8563@51 {
> -	compatible = "haoyu,hym8563";
> -	reg = <0x51>;
> -
> -	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> -
> -	#clock-cells = <0>;
> -};
> -
> -device {
> -...
> -	clocks = <&hym8563>;
> -...
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> new file mode 100644
> index 000000000000..0b9f39ef0edc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Haoyu Microelectronics HYM8563 RTC
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: haoyu,hym8563
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    description: From common clock binding to override the default output clock name.
> +    maxItems: 1
> +
> +  wakeup-source:
> +    description: Enables wake up of host system on alarm.
> +
> +allOf:
> +  - $ref: rtc.yaml
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@51 {
> +            compatible = "haoyu,hym8563";
> +            reg = <0x51>;
> +            interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +            #clock-cells = <0>;
> +        };
> +    };
> 




