Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB366606A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJTVOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:14:01 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42421CD76;
        Thu, 20 Oct 2022 14:13:59 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 131C2100003;
        Thu, 20 Oct 2022 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666300438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4LMS7M24fpjh0kpPQ6wTQki84VuHmXWkbDR03Gia6E=;
        b=d7huTAh7uLOSo8nMo7dzpL+0zLckuH1/c/CLaY2BHtCjfzSsFCJ/PjEhgj2L/2nKki3qOI
        ygkHRiJHyyqCO2V48uv++SuQAzODf0f5L+bEg9ABu79yZLmPfYEvC+BT7TRjKZEu6AI9zy
        UuXP10bJlwGL6se+a5UGwz/1STX7bLKeIFa6DfDaUyxEOZvfluZQpXsumcjKUjslKkkuoc
        1sXc3q3/JJNoKNDpQCOdt0Uz0b6Oz+RlxYR1HMVs+6H++bv2HxFeSgz2hhBwQCOTizu3gs
        BBQmR+TR/qiRCuhHxlQT67DoKwytuxELo9ll3uqSvWheRTN3teZf5wjDWl5JXA==
Date:   Thu, 20 Oct 2022 23:13:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     a.zummo@towertech.it, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Message-ID: <Y1G6FIvS6WD57GXW@mail.local>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019133910.282-2-Ibrahim.Tilki@analog.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 16:39:10+0300, Ibrahim Tilki wrote:
> Devicetree binding documentation for Analog Devices MAX313XX RTCs
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/rtc/adi,max313xx.yaml | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> new file mode 100644
> index 000000000..1aa491799
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX313XX series I2C RTC driver
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: Bindings for the Analog Devices MAX313XX series RTCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31328
> +      - adi,max31329
> +      - adi,max31331
> +      - adi,max31334
> +      - adi,max31341
> +      - adi,max31342
> +      - adi,max31343
> +
> +  reg:
> +    description: I2C address of the RTC
> +    items:
> +      - enum: [0x68, 0x69]
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description: |
> +      Name of the interrupt pin of the RTC used for IRQ. Not required for
> +      RTCs that only have single interrupt pin available. Some of the RTCs
> +      share interrupt pins with clock input/output pins.
> +    minItems: 1
> +    items:
> +      - enum: [INTA, INTB]
> +      - enum: [INTA, INTB]
> +

I don't think this is right, what this is doing is essentially pinmuxing
interrupts versus clocks. What happens if you want INTB but this goes
directly to a PMIC instead of the SoC?
It is not something you can express with your current bindings.


> +  "#clock-cells":
> +    description: |
> +      RTC can be used as a clock source through its clock output pin when
> +      supplied.
> +    const: 0
> +
> +  clocks:
> +    description: |
> +      RTC uses this clock for clock input when supplied. Clock has to provide
> +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> +    maxItems: 1
> +
> +  trickle-diode-disable: true
> +
> +  trickle-resistor-ohms:
> +    description: Enables trickle charger with specified resistor value.
> +    enum: [3000, 6000, 11000]
> +
> +  wakeup-source: true
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max31328
> +              - adi,max31342
> +
> +    then:
> +      properties:
> +        trickle-diode-disable: false
> +        trickle-resistor-ohms: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max31328
> +              - adi,max31331
> +              - adi,max31334
> +              - adi,max31343
> +
> +    then:
> +      properties:
> +        clocks: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max31341
> +              - adi,max31342
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x69
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x68
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@68 {
> +            reg = <0x68>;
> +            compatible = "adi,max31329";
> +            clocks = <&clkin>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INTB";
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@68 {
> +            reg = <0x68>;
> +            compatible = "adi,max31331";
> +            #clock-cells = <0>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>, <26 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INTA", "INTB";
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@69 {
> +            reg = <0x69>;
> +            compatible = "adi,max31341";
> +            #clock-cells = <0>;
> +            clocks = <&clkin>;
> +        };
> +    };
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
