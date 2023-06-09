Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A594729F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbjFIPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbjFIPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:50:08 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E623A96
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:49:58 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a15ce37b39so833669fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686325796; x=1688917796;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrgoKXBwHUX7WEq9UMaUcmVG2l73/fiJgyEmMbnqlYc=;
        b=wumVhPyiGuTYNfJupdHd62oH9GAZ2PCLmUDDwKDcX/P3q7ZJiv7dip83Lt1lbaCuHM
         MigaIh4WrBk9OKrbyKNNNXa0kd/dwOrpTT9ewxlQGzS5PVLgpxmnzvdjmt7gq9owAdIF
         9No7pVaKOYTtteE7AuLn0IsS5+Xu5qlHWkUdHDiQeLZDF5LdwKv8BkJDPevN5830rw6d
         u8klF0jeWIRK2Mn54o9QDGIG5w7G6IFXIYMMQlFrZNpO61n39uEAV1uE+vjS4IG+auji
         0O0mdkM1esVd84qo3mkpBegd7uuXID4I2Ay5go7S5hNkWWY7wITiJ9+OCtJRZXy0VjBp
         g4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325796; x=1688917796;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrgoKXBwHUX7WEq9UMaUcmVG2l73/fiJgyEmMbnqlYc=;
        b=jRem82+qaxo0SMmdMKjmp8pPAtwfvCSHayKeJPGuPLLuF4p1HlwlcWydOnwMpACeRQ
         HY4HyWBnjvckR87yknZjL/L27/bB7H6zCBSmKXgb2ApIDjqtuHLci3csOVadjcvvr9Gr
         u6BU6Q0PBQjikHPuj5KffSwDxfWjcwltSDSjDVPbR6J60t0LOYRSH0O8kwejujqtu3pB
         sOkbB6EhNRF4JHNlWjx+2DpBIeJ8a+4W5N3GUetCauaJnB52ErH/awDXYHd3N/JzEAR+
         cU5cFUSiE1D7RiMkeCWJyfVO/nhXk2rOaFg9GEgAITG4FiLmctK63iHzlVYT2kCER1+x
         m7cg==
X-Gm-Message-State: AC+VfDyimlWgLOnb1Xd1EOT7cISRyl0O82wcVnJDcikwMo76QvA33QNa
        S9KeShU6rIC80fNspqGX1MuoRwximeboTWBR7V9H9Q==
X-Google-Smtp-Source: ACHHUZ7xTLHhpKmBrjq1Rs7OSGnlzQSAus+GRPqqwKhHhI3913poqD6cqJyhGqkdmWsDuT1tIxGttok8cQaWzMIomls=
X-Received: by 2002:a05:6870:988c:b0:1a1:d1c1:f69b with SMTP id
 eg12-20020a056870988c00b001a1d1c1f69bmr1331796oab.55.1686325796513; Fri, 09
 Jun 2023 08:49:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Jun 2023 08:49:55 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v4-0-687f09a06dd9@baylibre.com> <20220919-v4-1-687f09a06dd9@baylibre.com>
 <20230608210504.GA3436215-robh@kernel.org>
In-Reply-To: <20230608210504.GA3436215-robh@kernel.org>
MIME-Version: 1.0
Date:   Fri, 9 Jun 2023 08:49:55 -0700
Message-ID: <CABnWg9tvBLH7R2Yqd_4=AOCdcHzw7Y-rigHN1jjoHe0EUGk1Bw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: display: mediatek: add MT8195 hdmi bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023 23:05, Rob Herring <robh@kernel.org> wrote:
>On Mon, May 29, 2023 at 04:30:58PM +0200, Guillaume Ranquet wrote:
>> Add mt8195 SoC bindings for hdmi and hdmi-ddc
>>
>> On mt8195 the ddc i2c controller is part of the hdmi IP block and thus has no
>> specific register range, power domain or interrupt, making it simpler
>> than the legacy "mediatek,hdmi-ddc" binding.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>  .../bindings/display/mediatek/mediatek,hdmi.yaml   | 59 ++++++++++++++++++----
>>  .../display/mediatek/mediatek,mt8195-hdmi-ddc.yaml | 45 +++++++++++++++++
>>  2 files changed, 93 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> index b90b6d18a828..4f62e6b94048 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> @@ -21,6 +21,7 @@ properties:
>>        - mediatek,mt7623-hdmi
>>        - mediatek,mt8167-hdmi
>>        - mediatek,mt8173-hdmi
>> +      - mediatek,mt8195-hdmi
>>
>>    reg:
>>      maxItems: 1
>> @@ -29,18 +30,10 @@ properties:
>>      maxItems: 1
>>
>>    clocks:
>> -    items:
>> -      - description: Pixel Clock
>> -      - description: HDMI PLL
>> -      - description: Bit Clock
>> -      - description: S/PDIF Clock
>> +    maxItems: 4
>>
>>    clock-names:
>> -    items:
>> -      - const: pixel
>> -      - const: pll
>> -      - const: bclk
>> -      - const: spdif
>> +    maxItems: 4
>>
>>    phys:
>>      maxItems: 1
>> @@ -58,6 +51,9 @@ properties:
>>      description: |
>>        phandle link and register offset to the system configuration registers.
>>
>> +  power-domains:
>> +    maxItems: 1
>> +
>>    ports:
>>      $ref: /schemas/graph.yaml#/properties/ports
>>
>> @@ -86,9 +82,50 @@ required:
>>    - clock-names
>>    - phys
>>    - phy-names
>> -  - mediatek,syscon-hdmi
>>    - ports
>>
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: mediatek,mt8195-hdmi
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: APB
>> +            - description: HDCP
>> +            - description: HDCP 24M
>> +            - description: Split HDMI
>> +        clock-names:
>> +          items:
>> +            - const: hdmi_apb_sel
>> +            - const: hdcp_sel
>> +            - const: hdcp24_sel
>> +            - const: split_hdmi
>> +
>> +      required:
>> +        - power-domains
>> +    else:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: Pixel Clock
>> +            - description: HDMI PLL
>> +            - description: Bit Clock
>> +            - description: S/PDIF Clock
>> +
>> +        clock-names:
>> +          items:
>> +            - const: pixel
>> +            - const: pll
>> +            - const: bclk
>> +            - const: spdif
>
>I don't understand how the same h/w block can have completely different
>clocks. If not the same h/w or evolution of the same h/w, then do a
>separate schema.
>

Hi Rob,

I'm not entirely sure what's the best approach here.
The IPs are different enough to warrant a separate schema IMHO.
Though CK asked me to merge both IPs together (for both schema and code).

CK might want to chime in and advocate his point of view?

>> +
>> +      required:
>> +        - mediatek,syscon-hdmi
>> +
>>  additionalProperties: false
>>
>>  examples:
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
>> new file mode 100644
>> index 000000000000..84c096835b47
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek HDMI DDC for mt8195
>> +
>> +maintainers:
>> +  - CK Hu <ck.hu@mediatek.com>
>> +  - Jitao shi <jitao.shi@mediatek.com>
>> +
>> +description: |
>> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt8195-hdmi-ddc
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  mediatek,hdmi:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      A phandle to the mt8195 hdmi controller
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    hdmiddc0: i2c {
>> +      compatible = "mediatek,mt8195-hdmi-ddc";
>> +      mediatek,hdmi = <&hdmi0>;
>> +      clocks = <&clk26m>;
>
>How does one access this h/w device? There is nothing described to
>access it.
>

The device is embedded into the HDMI block and thus uses the
mediatek,hdmi phandle to access its sets of registers in the middle of
the mediatek,hdmi register range.

Hope this clarifies things,
Guillaume.

>Rob
