Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8136DB1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDGRnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603C11D;
        Fri,  7 Apr 2023 10:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BD763F57;
        Fri,  7 Apr 2023 17:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E19C433D2;
        Fri,  7 Apr 2023 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889422;
        bh=vZCY3vWqhnV/znGFdnyCODHfQSKhgHz1S2DYLWPOqYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VZ5byXXtG+h3HYdpQ+Wsg6iPq3cNOvRUq/xwy6nOA/smdWag7D6cl9FAvr4JdfkKu
         ZzM6evYJ8IsDtN6kwpYk/yqndr15AGlIjYtvCX+WEBl4BHFwAQ0NOlcJRF0yTCT65e
         QGyOx0U9bimHexh9ZFxUd3exXoaYJ+Encajz3pA40n0TDm5O2unGYU+JJzPncifSl5
         WG7RCJaa416FosrHDOk03+hAkUuY/rX727/9nxOyFZZHvSI5r7VIOK7CePFapjqD0c
         +YZ5rR1bz3mR4MIk4OcOS+ukBYnTdjQwqsFs2zjSizoPVcs84xUh7ggr1X0OPteaJo
         ytp45vasbBqHw==
Date:   Fri, 7 Apr 2023 18:58:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document TI OPT4001 light sensor
 bindings
Message-ID: <20230407185858.1cd624e0@jic23-huawei>
In-Reply-To: <20230323-add-opt4001-driver-v1-1-1451dcc1bc8a@axis.com>
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
        <20230323-add-opt4001-driver-v1-1-1451dcc1bc8a@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 11:07:42 +0200
Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com> wrote:

> Add devicetree bindings for opt4001 ambient light sensor.
> 
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>

Hi Stefan,

Please add the VDD regulator and interrupt pin to the DT binding.
Whilst the driver might not use them, the binding should describe the device
fully anyway both so that we can potentially enable control of the regulator
and use of interrupt in Linux and because other software picks up these
bindings and might need them.

The regulator is easy to handle in the driver now we have
devm_regulator_get_enable() so that probably is worth supporting from the start
even if your board has it hard wired on.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/light/ti,opt4001.yaml  | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> new file mode 100644
> index 000000000000..cfd6b8b92c17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OPT4001 Ambient Light Sensor
> +
> +maintainers:
> +  - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> +
> +description: |
> +  Ambient light sensor with an i2c interface.
> +  https://www.ti.com/lit/gpn/opt4001
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,opt4001-picostar
> +      - ti,opt4001-sot-5x3
> +
> +  reg:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@44 {
> +            compatible = "ti,opt4001-picostar";
> +            reg = <0x44>;
> +        };
> +    };
> +...
> 

