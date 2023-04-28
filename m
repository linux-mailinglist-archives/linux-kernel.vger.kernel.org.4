Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD206F1A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjD1OjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjD1OjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:39:18 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [IPv6:2001:41d0:203:375::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FE4C03
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:39:14 -0700 (PDT)
Date:   Fri, 28 Apr 2023 16:39:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1682692751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMx6OTRIJwaSYCgtTQhYpKMdrEpNqX+maRQV25Yjn0g=;
        b=AmxHRRunYY0A/ohh8FCgGb2ps0vCoSGpStqPEPESelyx9uq6sjy0EkiJVSAC1P+YWsKwmF
        wuRwETVk6yL6MwZMdWkEfW1wawGFnRcL4rv/9w88VBB1Z6BTHt9zuqd8I2NE0S4YVeS4N0
        kVDZ9X01BzPTKZbUChoF+5bZ+DGzvRE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Message-ID: <ZEvaixFJGk/Nr1m2@L14.lan>
References: <cover.1682636929.git.jahau@rocketmail.com>
 <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

One question inline.

On Fri, Apr 28, 2023 at 01:30:11AM +0200, Jakob Hauser wrote:
> Add device tree binding documentation for rt5033 multifunction device, voltage
> regulator and battery charger.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> The patch is based on next-20230413.
> 
> The drivers for rt5033 (mfd) and rt5033-regulator are existing. Whereas the
> the driver rt5033-charger is new in this patchset.
> 
> The extcon phandle is still there, as I didn't know what Rob meant by
> "standard connector bindings".
> 
> Changes in v3:
>  - Removed redundant "documentation" in the commit title.
>  - Squashed regulator into the mfd binding.
>  - Restored the regulator node names to uppercase because it is an existing
>    driver.
>  - In the charger binding replaced the vendor properties by "battery" node
>    style. Accodringly updated the example in the mfd.
> 
>  .../bindings/mfd/richtek,rt5033.yaml          | 105 ++++++++++++++++++
>  .../power/supply/richtek,rt5033-charger.yaml  |  63 +++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> new file mode 100644
> index 000000000000..ee704914201f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/richtek,rt5033.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description:
> +  RT5033 is a multifunction device which includes battery charger, fuel gauge,
> +  flash LED current source, LDO and synchronous Buck converter for portable
> +  applications. It is interfaced to host controller using I2C interface. The
> +  battery fuel gauge uses a separate I2C bus.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt5033
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    description:
> +      The regulators of RT5033 have to be instantiated under a sub-node named
> +      "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO

Is only 4.9 V valid for SAFE_LDO? If I am reading driver found in
vendor kernel for SM-A500F it seems to to allow values between 3.3 and
4.95 V [1]. Same range is also written in the devicetree for the
device [2].

[1] https://github.com/msm8916-mainline/linux-downstream/blob/SM-A500F/drivers/regulator/rt5033_regulator.c#L109-L114
[2] https://github.com/msm8916-mainline/linux-downstream/blob/SM-A500F/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-a5u-eur-r01.dtsi#L148-L149

Best regards,
Henrik Grimler

> +      voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges
> +      from 1.0 V to 3.0 V in 0.1 V steps.
> +    type: object
> +    patternProperties:
> +      "^(SAFE_LDO|LDO|BUCK)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +    additionalProperties: false
> +
> +  charger:
> +    type: object
> +    $ref: /schemas/power/supply/richtek,rt5033-charger.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    battery: battery {
> +        compatible = "simple-battery";
> +        precharge-current-microamp = <450000>;
> +        constant-charge-current-max-microamp = <1000000>;
> +        charge-term-current-microamp = <150000>;
> +        precharge-upper-limit-microvolt = <3500000>;
> +        constant-charge-voltage-max-microvolt = <4350000>;
> +    };
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@34 {
> +            compatible = "richtek,rt5033";
> +            reg = <0x34>;
> +
> +            interrupt-parent = <&msmgpio>;
> +            interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pmic_int_default>;
> +
> +            regulators {
> +                safe_ldo_reg: SAFE_LDO {
> +                    regulator-name = "SAFE_LDO";
> +                    regulator-min-microvolt = <4900000>;
> +                    regulator-max-microvolt = <4900000>;
> +                    regulator-always-on;
> +                };
> +                ldo_reg: LDO {
> +                    regulator-name = "LDO";
> +                    regulator-min-microvolt = <2800000>;
> +                    regulator-max-microvolt = <2800000>;
> +                };
> +                buck_reg: BUCK {
> +                    regulator-name = "BUCK";
> +                    regulator-min-microvolt = <1200000>;
> +                    regulator-max-microvolt = <1200000>;
> +                };
> +            };
> +
> +            charger {
> +                compatible = "richtek,rt5033-charger";
> +                monitored-battery = <&battery>;
> +                extcon = <&muic>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> new file mode 100644
> index 000000000000..bf08e8db365e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 PIMC Battery Charger
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description:
> +  The battery charger of the multifunction device RT5033 has to be instantiated
> +  under sub-node named "charger" using the following format.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt5033-charger
> +
> +  monitored-battery:
> +    description: |
> +      Phandle to the monitored battery according to battery.yaml. The battery
> +      node needs to contain five parameters.
> +
> +      precharge-current-microamp:
> +      Current of pre-charge mode. The pre-charge current levels are 350 mA
> +      to 650 mA programmed by I2C per 100 mA.
> +
> +      constant-charge-current-max-microamp:
> +      Current of fast-charge mode. The fast-charge current levels are 700 mA
> +      to 2000 mA programmed by I2C per 100 mA.
> +
> +      charge-term-current-microamp:
> +      This property is end of charge current. Its level ranges from 150 mA
> +      to 600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and
> +      600 mA in 100 mA steps.
> +
> +      precharge-upper-limit-microvolt:
> +      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
> +      threshold voltage, the charger is in pre-charge mode with pre-charge
> +      current. Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
> +
> +      constant-charge-voltage-max-microvolt:
> +      Battery regulation voltage of constant voltage mode. This voltage levels
> +      from 3.65 V to 4.4 V by I2C per 0.025 V.
> +
> +  extcon:
> +    description:
> +      Phandle to the extcon device.
> +    maxItems: 1
> +
> +required:
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    charger {
> +        compatible = "richtek,rt5033-charger";
> +        monitored-battery = <&battery>;
> +        extcon = <&muic>;
> +    };
> -- 
> 2.39.2
> 
