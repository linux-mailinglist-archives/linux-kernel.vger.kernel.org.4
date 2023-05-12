Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7A700B71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbjELPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbjELPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:23:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5A5B83
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:23:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1812436766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683905004; x=1686497004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfQ9FxtPdpC851oVhzEAGMTkMIl0aMvmC/2RqbAkd2s=;
        b=nyMdsmlw1ScV6BDNUHPLdOeR/G1neobRp00csc6jItIUmYyHpHzaaX2gjuNOvj2jON
         6N9b2oykZspNcDSnv0v2eM6lYcdaD7FNLqnFk11MUw9uEyGOaimUPCuxeTvcxg0V2vCh
         DCRn+aBQj7t+XHTZpb2E4b4p2sFomNWVEYrXE3IfTycXl4wTEoOTNACP0EmwQZDSCUD6
         mqYB7v8Keh2Eo1sJlYuYIAQu6MMx5m19l2TExvBFBte+7wNJb+As9vZg82gZQuIQbyIz
         2WRyTXIarLVRJYNqovEYHdcw9xTHSeHeMY6W6jp9/nvIpv4WtbcFl6lzS6QdUhoyEvYY
         5UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905004; x=1686497004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfQ9FxtPdpC851oVhzEAGMTkMIl0aMvmC/2RqbAkd2s=;
        b=VhCVeVFXCMHlo0VrXmGcAikJEQ8vLmhpqUoiaaHVPmsFlcveik8hhKdjGkGGg0KTOj
         5DrKkQTXILv01KRp96ebW+FP7QHJhgQowOocBL8Wud0P3YO3/72B9ireyJfa4cBMv5bP
         SERDSDbVKaKlpJrbLVMI7RuveGGQao7N0EOUvWqzggAohbBTjfw9jpB+JqmeLnPtkZND
         IMAHHFPe3lHN7sYy7GfqVqf81FHXgUTbkcrTXeo0ZiXi7zgDrUZBSgcxXTx+4ULC/R9n
         5wrWH5pFfk+35RxdMsN4QpfxYsxskEX0J+tNE3elQ1lvV4v4F+UwmADfX+TjvLVJlJf/
         T8XQ==
X-Gm-Message-State: AC+VfDy129M49ePFQ2V5O2mzTNXarulfJUAddwhNyTTOYtz02l9xOLfu
        pT7NdZhhdzofUps1Y99PxgoQdg==
X-Google-Smtp-Source: ACHHUZ6nZMMkDDiDxKJfcjw7N3HVq2iQ7vtBFGa+8tadn1RArRXANKKvEhVj4w7QzX4+UHuzGd+Gnw==
X-Received: by 2002:a17:907:80e:b0:94e:9a73:1637 with SMTP id wv14-20020a170907080e00b0094e9a731637mr20678495ejb.75.1683905004574;
        Fri, 12 May 2023 08:23:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id ml17-20020a170906cc1100b009661484e84esm5554723ejb.191.2023.05.12.08.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:23:24 -0700 (PDT)
Message-ID: <25c92476-7bca-90c4-9130-cb765495a783@linaro.org>
Date:   Fri, 12 May 2023 17:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:28, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> Add a YAML DT binding document for this device.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../bindings/mfd/cirrus,cs42l43.yaml          | 212 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml b/Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml
> new file mode 100644
> index 0000000000000..e1fd70e0a3467
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml
> @@ -0,0 +1,212 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/cirrus,cs42l43.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS42L43 Audio CODEC

That's audio codec, so it should be in sound, not MFD.

> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> +  (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> +  for portable applications. It provides a high dynamic range, stereo
> +  DAC for headphone output, two integrated Class D amplifiers for
> +  loudspeakers, and two ADCs for wired headset microphone input or
> +  stereo line input. PDM inputs are provided for digital microphones.
> +
> +required:
> +  - compatible
> +  - reg
> +  - VDD_P-supply
> +  - VDD_A-supply
> +  - VDD_D-supply
> +  - VDD_IO-supply
> +  - VDD_CP-supply

lowercase, no underscores in all property names.

> +
> +additionalProperties: false

This order is quite unexpected... please do not invent your own layout.
Use example-schema as your starting point. I suspect there will be many
things to fix, so limited review follows (not complete).


Missing ref to dai-common

> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,cs42l43
> +
> +  reg:
> +    maxItems: 1
> +
> +  VDD_P-supply:
> +    description:
> +      Power supply for the high voltage interface.
> +
> +  VDD_A-supply:
> +    description:
> +      Power supply for internal analog circuits.
> +
> +  VDD_D-supply:
> +    description:
> +      Power supply for internal digital circuits.
> +
> +  VDD_IO-supply:
> +    description:
> +      Power supply for external interface and internal digital logic.
> +
> +  VDD_CP-supply:
> +    description:
> +      Power supply for the amplifier 3 and 4 charge pump.
> +
> +  VDD_AMP-supply:
> +    description:
> +      Power supply for amplifier 1 and 2.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-ranges:
> +    items:
> +      - description: A phandle to the CODEC pinctrl node
> +        minimum: 0
> +      - const: 0
> +      - const: 0
> +      - const: 3
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: Synchronous audio clock provided on mclk_in.
> +
> +  clock-names:
> +    const: mclk
> +
> +  pinctrl:
> +    type: object

additionalProperties: false

> +
> +    allOf:
> +      - $ref: "../pinctrl/pinctrl.yaml#"

No quotes, absolute path, so /schemas/pinctrl/....

> +
> +    properties:
> +      pin-settings:

What's this node about? pinctrl/pinctrl/pins? One level too much.

> +        type: object
> +
> +        additionalProperties: false
> +
> +        patternProperties:
> +          '-pins$':
> +            type: object
> +
> +            allOf:
> +              - $ref: "../pinctrl/pincfg-node.yaml#"
> +              - $ref: "../pinctrl/pinmux-node.yaml#"

Same comments.

> +
> +            oneOf:
> +              - required: [ groups ]
> +              - required: [ pins ]
> +
> +            unevaluatedProperties: false
> +
> +            properties:
> +              groups:
> +                enum: [ gpio1, gpio2, gpio3, asp, pdmout2, pdmout1, i2c, spi ]
> +
> +              pins:
> +                enum: [ gpio1, gpio2, gpio3,
> +                        asp_dout, asp_fsync, asp_bclk,
> +                        pdmout2_clk, pdmout2_data, pdmout1_clk, pdmout1_data,
> +                        i2c_sda, i2c_scl,
> +                        spi_miso, spi_sck, spi_ssb ]
> +
> +              function:
> +                enum: [ gpio, spdif, irq, mic-shutter, spk-shutter ]
> +
> +              drive-strength:
> +                description: Set drive strength in mA
> +                enum: [ 1, 2, 4, 8, 9, 10, 12, 16 ]
> +
> +              input-debounce:
> +                description: Set input debounce in uS
> +                enum: [ 0, 85 ]
> +
> +  spi:
> +    type: object
> +
> +    allOf:
> +      - $ref: "../spi/spi-controller.yaml#"

Same comments.
> +
> +    unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c@e0004000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0xe0004000 0x1000>;

Drop, just i2c

> +
> +        cs42l43: codec@1a {
> +            compatible = "cirrus,cs42l43";
> +            reg = <0x1a>;
> +
> +            VDD_P-supply = <&vdd5v0>;
> +            VDD_D-supply = <&vdd1v8>;
> +            VDD_A-supply = <&vdd1v8>;
> +            VDD_IO-supply = <&vdd1v8>;
> +            VDD_CP-supply = <&vdd1v8>;
> +            VDD_AMP-supply = <&vdd5v0>;
> +
> +            reset-gpios = <&gpio 0>;

Use proper defines for flags.


Best regards,
Krzysztof

