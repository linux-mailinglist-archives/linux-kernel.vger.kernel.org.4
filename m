Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091256DB1A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDGReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDGReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF4B463;
        Fri,  7 Apr 2023 10:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21A9652AB;
        Fri,  7 Apr 2023 17:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0044C433EF;
        Fri,  7 Apr 2023 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680888853;
        bh=k39ojLugdZzlydji/uAprODGtjuwBnxp5qDd/32ojsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HOFnsOX28/9Fgo47FkYTcewM/vmizzt11vguHO4KUobFRITA8GIMnl+DofpKHj55y
         M4ELJNfszyfEB1FSOD6tm+fErdIuVcgjAiog1wJ/JMzjdeVvM6FPFoh7hZfomkWdB0
         4xgZuzkvtYSe6XlyPPLXdDirYf4gXUVmaWfrORraBfRIRaDfsqa5sbxm/nmDjFLRUU
         YBkCYAvyqqspcPLPZnEkhSdoeSM6Y6l/PyEM1hsckv0IDZmDiU5LGa1d4dOIwbizbl
         E5AXs27B3EgQq3zeSKk55A5KyfqvV3vb0m3jFRJ8ADB7auUdQZnfqTUBZlysTYoKTI
         umpsbjRulrmew==
Date:   Fri, 7 Apr 2023 18:49:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: ltc2983: Fix child
 node unevaluated properties
Message-ID: <20230407184928.43f6d730@jic23-huawei>
In-Reply-To: <20230404205014.644336-1-robh@kernel.org>
References: <20230404205014.644336-1-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Apr 2023 15:50:13 -0500
Rob Herring <robh@kernel.org> wrote:

> The child node schemas are missing 'unevaluatedProperties' constraints,
> so any unknown properties are allowed. The current structure with
> multiple patternProperties schemas doesn't work for
> unevaluatedProperties as each sub-schema is evaluated independently. To
> fix this, move the sub-schema for all child nodes to a $defs entry and
> reference it from each named child node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Nice. Series applied to the togreg branch of iio.git and pushed out as
testing so 0-day can poke at it.

Thanks,

Jonathan

> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 65 +++++++++++--------
>  1 file changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index f44fc32ce87e..e04f961ab92c 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -18,6 +18,28 @@ description: |
>    https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
>  
> +$defs:
> +  sensor-node:
> +    type: object
> +    description: Sensor node common constraints
> +
> +    properties:
> +      reg:
> +        description:
> +          Channel number. Connects the sensor to the channel with this number
> +          of the device.
> +        minimum: 1
> +        maximum: 20
> +
> +      adi,sensor-type:
> +        description: Type of sensor connected to the device.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    required:
> +      - reg
> +      - adi,sensor-type
> +
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -64,28 +86,10 @@ properties:
>      const: 0
>  
>  patternProperties:
> -  "@([0-9a-f]+)$":
> -    type: object
> -    description: Sensor.
> -
> -    properties:
> -      reg:
> -        description:
> -          Channel number. Connects the sensor to the channel with this number
> -          of the device.
> -        minimum: 1
> -        maximum: 20
> -
> -      adi,sensor-type:
> -        description: Type of sensor connected to the device.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -
> -    required:
> -      - reg
> -      - adi,sensor-type
> -
>    "^thermocouple@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +
>      description: Thermocouple sensor.
>  
>      properties:
> @@ -141,7 +145,9 @@ patternProperties:
>              - adi,custom-thermocouple
>  
>    "^diode@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +
>      description: Diode sensor.
>  
>      properties:
> @@ -184,7 +190,8 @@ patternProperties:
>          default: 0
>  
>    "^rtd@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
>      description: RTD sensor.
>  
>      properties:
> @@ -282,7 +289,8 @@ patternProperties:
>              - adi,custom-rtd
>  
>    "^thermistor@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
>      description: Thermistor sensor.
>  
>      properties:
> @@ -383,7 +391,8 @@ patternProperties:
>              - adi,custom-thermistor
>  
>    "^adc@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
>      description: Direct ADC sensor.
>  
>      properties:
> @@ -397,7 +406,8 @@ patternProperties:
>          type: boolean
>  
>    "^temp@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
>      description: Active analog temperature sensor.
>  
>      properties:
> @@ -426,7 +436,8 @@ patternProperties:
>        - adi,custom-temp
>  
>    "^rsense@":
> -    type: object
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
>      description: Sense resistor sensor.
>  
>      properties:

