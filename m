Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39CE64728C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiLHPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:11:39 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DC6599525;
        Thu,  8 Dec 2022 07:11:38 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:11:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D5BD52059054;
        Fri,  9 Dec 2022 00:11:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:11:37 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 609441DA8;
        Fri,  9 Dec 2022 00:11:37 +0900 (JST)
Message-ID: <00ead078-f7a7-6858-905c-80e538237967@socionext.com>
Date:   Fri, 9 Dec 2022 00:11:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 15/16] dt-bindings: soc: socionext: Add UniPhier DWC3
 USB glue layer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-16-hayashi.kunihiko@socionext.com>
 <1ceecc45-43bd-49bd-68f5-57294093d731@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <1ceecc45-43bd-49bd-68f5-57294093d731@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:23, Krzysztof Kozlowski wrote:
> On 07/12/2022 06:54, Kunihiko Hayashi wrote:
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
>> index 000000000000..1b5585a5a3a2
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
> 
> Use consistent quotes - either ' or "

I'll change it.

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
> 
> You need to fix
> Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> example. I propose to drop usb-glue@65b00000 from that file. It's not
> relevant to that example.

I already fixed usb3-phy example in PATCH 6/16, however, it's better
to drop the parent node from the example not to avoid the effect of the changes.

Thank you,

---
Best Regards
Kunihiko Hayashi
