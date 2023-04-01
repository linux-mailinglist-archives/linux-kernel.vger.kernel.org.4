Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14D6D31E5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDAPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjDAPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228EE2C9E4;
        Sat,  1 Apr 2023 08:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE4960EF4;
        Sat,  1 Apr 2023 15:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC00C433D2;
        Sat,  1 Apr 2023 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680361913;
        bh=wTscgcXld0H4clYFfNpFQFdLK6SrhrlxTfvXICUjKsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dNgxNHjtjKcbrscEJe0kuyflYLy9AnJRLmOu5qqggRokpF/hGRgUZrI56vmZuRTgz
         5R5oooMIcc5pQppPy1bYhHhIsDgmczrpovhxmfZf+ceaynN5vG3wZsYIe4oj5DHIuo
         9v5+Z/I7TIMM3GPbGxoFAZrR5TcvAWJJDFQhsZKPpxSmlUhaKglzUoHFVrRbqXJ29i
         EX+QZvpynqsidiIpA6WAjjI/cC77J/3yiHup70KdES4j241d26yzS3yJzufFln4E1w
         8/tAoefQzXIuX25g9RoSJZUFgQg5e6O8W9EWO0J3v50C+PMudc1+771Uazyn595sKN
         zw4Aci4Uc8ZRA==
Date:   Sat, 1 Apr 2023 16:27:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Message-ID: <20230401162701.1d3caebc@jic23-huawei>
In-Reply-To: <27a1d0f4-3a02-c7fd-36a0-07729a136e20@linaro.org>
References: <ZCf01btsJRXcIOce@arbad>
        <27a1d0f4-3a02-c7fd-36a0-07729a136e20@linaro.org>
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

On Sat, 1 Apr 2023 11:42:15 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 01/04/2023 11:09, Andreas Klinger wrote:
> > Honeywell mpr is a pressure sensor family. There are many different
> > types with different pressure ranges. The range needs to be set up in
> > the dt. Therefore new properties honeywell,pmin and honeywell,pmax are
> > introduced.
> > 
> > Add dt-bindings.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/pressure/honeywell,mpr.yaml  | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> > new file mode 100644
> > index 000000000000..d6fad6f841cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mpr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Honeywell mpr pressure sensor
> > +
> > +maintainers:
> > +  - Andreas Klinger <ak@it-klinger.de>
> > +
> > +description: |
> > +  Honeywell pressure sensor of type mpr. This sensor has an I2C and SPI interface. Only the I2C  
> 
> Doesn't look wrapped according to Linux coding style (see Coding style).
> 
> > +  interface is implemented.
> > +
> > +  There are many subtypes with different pressure ranges available. Therefore the minimum and
> > +  maximum pressure values of the specific sensor needs to be specified in Pascal.
> > +
> > +  Specifications about the devices can be found at:
> > +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
> > +      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
> > +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf  
> 
> Lines are not continued, so drop \
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: honeywell,mpr  
> 
> You need device specific compatible, not some generic one. Rename also
> then the filename (should match the compatible).
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      Optional GPIO for resetting the device. If not present the device is not resetted.  
> 
> Are you sure it is wrapped properly?
> 
> > +    maxItems: 1
> > +
> > +  honeywell,pmin:
> > +    description:
> > +      Minimum pressure value the sensor can measure in pascal.  
> 
> Use standard unit suffix:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  honeywell,pmax:
> > +    description:
> > +      Maximum pressure value the sensor can measure in pascal.
> > +    $ref: /schemas/types.yaml#/definitions/uint32  
> 
> Same.
> 
> Why these values are suitable for DT? Does it depend on type of sensor
> (thus it is implied from compatible) or on system setup?

I think we'll end up with a lot of compatibles, but that's still better
than free form description.  May still need these as well though given
the datasheet helpfully adds a foot note.

1. Custom pressure ranges are available.

Might not be worth including all the details though but unhelpfully the
bits we care about are after details like is the gel food grade or the port long.
Definitely can ignore the encoding of i2c address / spi in the last few bits but
may need the transfer function.


mpr-0025GA-A maybe as a form?

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - honeywell,pmin
> > +  - honeywell,pmax
> > +  
> 
> 
> Best regards,
> Krzysztof
> 

