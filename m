Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1F64728F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLHPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiLHPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:11:54 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BAC0A13D5;
        Thu,  8 Dec 2022 07:11:52 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:11:52 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 832162058B4F;
        Fri,  9 Dec 2022 00:11:52 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:11:52 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 193481DA8;
        Fri,  9 Dec 2022 00:11:52 +0900 (JST)
Message-ID: <1e93d1b9-dfb1-dc4f-79e9-40dfbd23b1c7@socionext.com>
Date:   Fri, 9 Dec 2022 00:11:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 16/16] dt-bindings: soc: socionext: Add UniPhier AHCI
 glue layer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-17-hayashi.kunihiko@socionext.com>
 <77f3dea3-7009-eccc-6bac-66309e15a767@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <77f3dea3-7009-eccc-6bac-66309e15a767@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:24, Krzysztof Kozlowski wrote:
> On 07/12/2022 06:54, Kunihiko Hayashi wrote:
>> Add DT binding schema for components belonging to the platform-specific
>> AHCI glue layer implemented in UniPhier SoCs.
>>
>> This AHCI glue layer works as a sideband logic for the host controller,
>> including core reset, PHYs, and some signals to the controller.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext,uniphier-ahci-glue.yaml         | 78 +++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
>> new file mode 100644
>> index 000000000000..bf37be8a778d
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-ahci-glue.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier SoC AHCI glue layer
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +description: |+
>> +  AHCI glue layer implemented on Socionext UniPhier SoCs is a sideband
>> +  logic handling signals to AHCI host controller inside AHCI component.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - socionext,uniphier-pro4-ahci-glue
>> +          - socionext,uniphier-pxs2-ahci-glue
>> +          - socionext,uniphier-pxs3-ahci-glue
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
> 
> use consistent quotes

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
>> +  "phy@[0-9a-f]+$":
>> +    $ref: /schemas/phy/socionext,uniphier-ahci-phy.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties:
>> +  type: object
> 
> What is the additional object? It's not in your example, not in DTS. Why
> do you need to allow it?

Sorry, I forgot to drop it. I'll replace it with:

    additionalProperties: false

Thank you,

---
Best Regards
Kunihiko Hayashi
