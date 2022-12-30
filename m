Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD16659B25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiL3RzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbiL3RzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:55:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020B1C90C;
        Fri, 30 Dec 2022 09:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBC25B81CE7;
        Fri, 30 Dec 2022 17:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E6C433EF;
        Fri, 30 Dec 2022 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672422891;
        bh=n26j3UNEBWhnst1Oo9v8s52C4KD49fhyEge2J4vzAmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mzqd2UgN5mNYi2ZRQozGDhqjfBuD6TjIX+dV/JNT/N+/DTkzRqDdGSw9BiUyKGAYM
         KsZYneFe0OmEFn5LhB8boWiTMgaKAnOdXJeMKW/NlvhbJnLMmDcOt7QCTRLoNtx5Sz
         BohFSRe++CrN0yTtaklYUKypwsd9zqxHBxnER+am3OymXkeK447j3e3DGOy6/kcXz2
         hBxBqYb1Gu0buKUl0s6bjN7G2sTlWIihvYOWgzEV+isQiI/HM544kYR7kRLujrYUEf
         b4b9sjOQMAwdrAnqbpuKeHTxbuYRpCfx+Vmq7HTGh5PUELXbU8pxyxMcpqfnSwu16K
         eqvl7Jf2gtBEQ==
Date:   Fri, 30 Dec 2022 18:08:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ep93xx: Add
 cirrus,ep9301-adc description
Message-ID: <20221230180809.051fc6bd@jic23-huawei>
In-Reply-To: <20221223162636.6488-1-alexander.sverdlin@gmail.com>
References: <20221223162636.6488-1-alexander.sverdlin@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 17:26:35 +0100
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
> block.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Whilst we are looking at this driver, Alexander, would you mind if we relaxed
the Kconfig dependencies to:

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 46c4fc2fc534..fd1d68dce507 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -441,7 +441,7 @@ config ENVELOPE_DETECTOR
 
 config EP93XX_ADC
        tristate "Cirrus Logic EP93XX ADC driver"
-       depends on ARCH_EP93XX
+       depends on ARCH_EP93XX || COMPILE_TEST
        help
          Driver for the ADC module on the EP93XX series of SoC from Cirrus Logic.
          It's recommended to switch on CONFIG_HIGH_RES_TIMERS option, in this

I end up doing that locally to build test patches like this one and it doesn't
seem to cause any problems.

Jonathan

> ---
> Changelog:
> v2: removed clock-names property, soc node and include as Krzysztof suggested
> 
>  .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> new file mode 100644
> index 000000000000..6d4fb3e1d2a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/cirrus,ep9301-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP930x internal ADC
> +
> +description: |
> +  Cirrus Logic EP9301/EP9302 SoCs' internal ADC block.
> +
> +  User's manual:
> +  https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc: adc@80900000 {
> +        compatible = "cirrus,ep9301-adc";
> +        reg = <0x80900000 0x28>;
> +        clocks = <&syscon 24>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <30>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 69565ac0c224..4a914d5bc2e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2027,8 +2027,10 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
>  M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
>  F:	arch/arm/mach-ep93xx/
>  F:	arch/arm/mach-ep93xx/include/mach/
> +F:	drivers/iio/adc/ep93xx_adc.c
>  
>  ARM/CLKDEV SUPPORT
>  M:	Russell King <linux@armlinux.org.uk>

