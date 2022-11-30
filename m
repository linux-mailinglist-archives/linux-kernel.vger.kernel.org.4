Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD49A63D14D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiK3JA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiK3JA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:00:27 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E199C429A2;
        Wed, 30 Nov 2022 01:00:25 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Nov 2022 18:00:25 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 536DF205D901;
        Wed, 30 Nov 2022 18:00:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Nov 2022 18:00:25 +0900
Received: from [10.212.156.209] (unknown [10.212.156.209])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D3F3FA855B;
        Wed, 30 Nov 2022 18:00:24 +0900 (JST)
Message-ID: <c9e1ee72-6201-3a1e-307a-d5869a22e01c@socionext.com>
Date:   Wed, 30 Nov 2022 18:00:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/8] dt-bindings: soc: socionext: Add UniPhier DWC3 USB
 glue layer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-8-hayashi.kunihiko@socionext.com>
 <12a98c77-5464-0f25-9081-13217f396484@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <12a98c77-5464-0f25-9081-13217f396484@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/29 23:52, Krzysztof Kozlowski wrote:
> On 29/11/2022 11:35, Kunihiko Hayashi wrote:
>> Add DT binding schema for components belonging to the platform-specific
>> DWC3 USB glue layer implemented in UniPhier SoCs.
>>
>> This USB glue layer works as a sideband logic for the host controller,
>> including core reset, vbus control, PHYs, and some signals to the
>> controller.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
>> new file mode 100644
>> index 000000000000..66f8786dd305
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
>> @@ -0,0 +1,106 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-dwc3-glue.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier SoC DWC3 USB3.0 glue layer
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +description: |+
>> +  DWC3 USB3.0 glue layer implemented on Socionext UniPhier SoCs is
>> +  a sideband logic handling signals to DWC3 host controller inside
>> +  USB3.0 component.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - socionext,uniphier-pro4-dwc3-glue
>> +          - socionext,uniphier-pro5-dwc3-glue
>> +          - socionext,uniphier-pxs2-dwc3-glue
>> +          - socionext,uniphier-ld20-dwc3-glue
>> +          - socionext,uniphier-pxs3-dwc3-glue
>> +          - socionext,uniphier-nx1-dwc3-glue
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^reset-controller@[0-9a-f]+$":
>> +    $ref: /schemas/reset/socionext,uniphier-glue-reset.yaml#
>> +
>> +  "^regulator@[0-9a-f]+$":
>> +    $ref: /schemas/regulator/socionext,uniphier-regulator.yaml#
>> +
>> +  "^phy@[0-9a-f]+$":
>> +    oneOf:
>> +      - $ref: /schemas/phy/socionext,uniphier-usb3hs-phy.yaml#
>> +      - $ref: /schemas/phy/socionext,uniphier-usb3ss-phy.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    usb-controller@65b00000 {
> 
> Node name: usb. There is no usage of "usb-controller".

I'm confusing about that.

This is an interface logic and doesn't have USB functions by itself.
Surely there is a USB host controller node "usb@..." in the same SoC.
Can this node be renamed to "usb"?

I've renamed the dts node name once in commit 4cc752a88ca9
("arm64: dts: uniphier: Rename usb-glue node for USB3 to usb-controller").

>> +        compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
>> +        reg = <0x65b00000 0x400>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0 0x65b00000 0x400>;
>> +
>> +        reset-controller@0 {
>> +            compatible = "socionext,uniphier-ld20-usb3-reset";
>> +            reg = <0x0 0x4>;
> 
> So now I see the unit addresses, which means none of your previous
> patches needed them. This raises next question - why this device is
> special and does not use syscon but own unit address?

The glue layer has a fixed register address for each child unlike
the previous patch.

This layer has also the other registers for USB core outside
the child nodes, however, there is no parent device that manages
these registers, so this layer node itself should take care of these
registers.

> Are the children here - regulator, reset controller and phys - related
> to the USB?

Yes, this "glue layer" is an interface of the USB controller, so these
children are only used for the USB controller.

Thank you,
---
Best Regards
Kunihiko Hayashi
