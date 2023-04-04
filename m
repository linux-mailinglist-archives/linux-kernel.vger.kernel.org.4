Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6406D5934
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjDDHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjDDHKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:10:12 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158B1FC7;
        Tue,  4 Apr 2023 00:10:10 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5666A240009;
        Tue,  4 Apr 2023 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680592208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OP0iRBaTco+27ngdp+QSWqtD+GFqYRtr/VgMJw0Ie+Q=;
        b=OYbr9XK2eveEiOf5gzVGPdIAXbExDi5jqHGKGbTJzUGMgjgdvefDm2bjxBpjaJ3ZSY4Spg
        +A8rivHQMW3QGC+fL+1PN1xpk7qWaOGztzHwQms0soD/dih/OPDPUyFsMcYhIFW2h1a9Vg
        mdHxCwxHOBv/R1zhj1wc9Mjp0+jIXeVs7BalTU5lrXFiuC73BbrOuf4FW1Vzu7wTHagHo9
        Ezq4F4wNFS9ocy6C5w1TRQFIuiM7IM8QbUTfQJSIrxAWBW25R7Y8eIjnHHBFcanqGgSN+6
        o0PL04fuaqqWq/T4QLC7s/B+rK3xq1mGei6mvK0roOwn3JfKYkY1ZIrrRlIhKw==
Date:   Tue, 4 Apr 2023 09:10:04 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <202304040710049c9cc01a@mail.local>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 08:17:40+0200, Krzysztof Kozlowski wrote:
> On 03/04/2023 17:43, Ibrahim Tilki wrote:
> > Devicetree binding documentation for Analog Devices MAX313XX RTCs
> > 
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > ---
> >  .../devicetree/bindings/rtc/adi,max313xx.yaml | 144 ++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > new file mode 100644
> > index 000000000..0c17a395e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > @@ -0,0 +1,144 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX313XX series I2C RTCs
> > +
> > +maintainers:
> > +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > +
> > +description: Analog Devices MAX313XX series I2C RTCs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max31328
> > +      - adi,max31329
> > +      - adi,max31331
> > +      - adi,max31334
> > +      - adi,max31341
> > +      - adi,max31342
> > +      - adi,max31343
> > +
> > +  reg:
> > +    description: I2C address of the RTC
> > +    items:
> > +      - enum: [0x68, 0x69]
> > +
> > +  interrupts:
> > +    description: |
> 
> Do not need '|'.
> 
> > +      Alarm1 interrupt line of the RTC. Some of the RTCs have two interrupt
> > +      lines and alarm1 interrupt muxing depends on the clockin/clockout
> > +      configuration.
> > +    maxItems: 1
> > +
> > +  "#clock-cells":
> > +    description: |
> 
> Do not need '|'.
> 
> > +      RTC can be used as a clock source through its clock output pin when
> > +      supplied.
> > +    const: 0
> > +
> > +  clocks:
> > +    description: |
> 
> Do not need '|'.
> 
> > +      RTC uses this clock for clock input when supplied. Clock has to provide
> > +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> > +    maxItems: 1
> > +
> > +  aux-voltage-chargeable:
> > +    enum: [0, 1, 2]
> > +    description: |
> > +      Enables trickle charger.
> > +      0: Charger is disabled (default)
> > +      1: Charger is enabled
> > +      2: Charger is enabled with a diode
> 
> 2 is not an allowed value. I asked to drop this property. It is coming
> from rtc.yaml. I also do not understand "with a diode". So otherwise it
> is charging with, I don't know, FET?

No, what is not explained here (and maybe not unsterstood by the
submitter) is that the RTC has an extra diode so, charging will always
enable a diode, select a resistor and then have or not an extra diode.
Figure2 of the MAX31329 datasheet is great.

> 
> > +
> > +  trickle-resistor-ohms:
> > +    description: Selected resistor for trickle charger.
> > +    enum: [3000, 6000, 11000]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> Best regards,
> Krzysztof
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
