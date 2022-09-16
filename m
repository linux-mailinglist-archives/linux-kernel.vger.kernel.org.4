Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06F5BADEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiIPNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiIPNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:15:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989EA3D3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:15:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c11so35979566wrp.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=i4mPbdPGjHv0um90MutjKinuU1Lx+BVJ0wJv3GWLz84=;
        b=C++7rBhy/Dx+3AP2+vmvjlVXg+zma5e3vfULL2ktwdZCFhIHFUGHTnjuL9vVgLaEvp
         yE0AMK2SVLXMSG80lVSBxNOluZWNVPjCpFnPQfxOnzKkXq0UDHNyhIK69dWwakWdSYrs
         S1zZ9PCbqpPPVY6tXT7B7Mz4fOW1mcu9c2R4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=i4mPbdPGjHv0um90MutjKinuU1Lx+BVJ0wJv3GWLz84=;
        b=nkXhfnVtPd4UAwwfb0cbOd8/7caK0ywcFQiwcKXNZ8BW+BzQlhZmxHsuGyXsT3+GJV
         lyoDaCWexHQplBgki6pY0hmzij3iA1G/yidTR3YffUyidCmiIAXSOdrD2GJ3ciizBslI
         ms5aCSYzT607B721Czzc0+kiJqdTEOccLIlndXyofV3gkpScy/YzFAvEIWQDmkbOAnG5
         8zKrlKNI1njBAshQBdeBYG0MIFLwQVsuyoBI91seCpDdiiQd+y9tQ9tNWkO3Geb37iUg
         mt45ofA7yENxdpjU/sUrpdl8sVUFu1frymucFQBHalaWhDHxE+SG/H6FSM8dmzwE2YJU
         W8EQ==
X-Gm-Message-State: ACrzQf0VaZtyRDdt9LAiNJbKIAIqhqpL/Kqr6/txdGMTu8fVupHtTtJM
        a2A2r/Dj7lDS0zYtvdEn3K0iHA==
X-Google-Smtp-Source: AMsMyM5IvmfdOa/MgpEJ8io6Vb6oRbSe9R4KKpn2BCjc/bvFyBBZEN6kUYYkmGlP7fEneUa8vF+LuA==
X-Received: by 2002:a5d:6488:0:b0:225:f99:338b with SMTP id o8-20020a5d6488000000b002250f99338bmr2911254wri.638.1663334147257;
        Fri, 16 Sep 2022 06:15:47 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i ([89.101.193.68])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003b47581979bsm2344450wmq.33.2022.09.16.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:15:46 -0700 (PDT)
Date:   Fri, 16 Sep 2022 15:15:44 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689
 DT bindings
Message-ID: <20220916131544.GA2701@tom-ThinkPad-T14s-Gen-2i>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
 <20220913140553.GA2735@tom-ThinkPad-T14s-Gen-2i>
 <87sfkspa6b.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfkspa6b.fsf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Thu, Sep 15, 2022 at 11:11:57PM +0300, Mikhail Rudenko wrote:
> 
> Hi Tommaso,
> 
> On 2022-09-13 at 16:05 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> > Hi Mikhail,
> >
> > On Sun, Sep 11, 2022 at 11:01:34PM +0300, Mikhail Rudenko wrote:
> >> Add device-tree binding documentation for OV4689 image sensor driver,
> >> and the relevant MAINTAINERS entries.
> >>
> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> ---
> >>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
> >>  MAINTAINERS                                   |   7 +
> >>  2 files changed, 148 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> >> new file mode 100644
> >> index 000000000000..376330b5572a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> >> @@ -0,0 +1,141 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Omnivision OV4689 CMOS
> >> +
> >> +maintainers:
> >> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
> >> +
> >> +description: |
> >> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
> >> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
> >> +  at 2688x1520 resolution. It is programmable through an I2C
> >> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> >> +  connection.
> >> +
> >> +allOf:
> >> +  - $ref: /schemas/media/video-interface-devices.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: ovti,ov4689
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    description:
> >> +      External clock (XVCLK) for the sensor, 6-64 MHz
> >> +    maxItems: 1
> >> +
> >> +  clock-names: true
> >> +
> >> +  dovdd-supply:
> >> +    description:
> >> +      Digital I/O voltage supply, 1.7-3.0 V
> >> +
> >> +  avdd-supply:
> >> +    description:
> >> +      Analog voltage supply, 2.6-3.0 V
> >> +
> >> +  dvdd-supply:
> >> +    description:
> >> +      Digital core voltage supply, 1.1-1.3 V
> >> +
> >> +  powerdown-gpios:
> >> +    maxItems: 1
> >> +    description:
> >> +      GPIO connected to the powerdown pin (active low)
> >> +
> >> +  reset-gpios:
> >> +    maxItems: 1
> >> +    description:
> >> +      GPIO connected to the reset pin (active low)
> >> +
> >> +  orientation: true
> >> +
> >> +  rotation: true
> >> +
> >> +  port:
> >> +    $ref: /schemas/graph.yaml#/$defs/port-base
> >> +    additionalProperties: false
> >> +    description:
> >> +      Output port node, single endpoint describing the CSI-2 transmitter
> >> +
> >> +    properties:
> >> +      endpoint:
> >> +        $ref: /schemas/media/video-interfaces.yaml#
> >> +        unevaluatedProperties: false
> >> +
> >> +        properties:
> >> +          data-lanes:
> >> +            oneOf:
> >> +              - items:
> >> +                  - const: 1
> >> +                  - const: 2
> >> +                  - const: 3
> >> +                  - const: 4
> >> +              - items:
> >> +                  - const: 1
> >> +                  - const: 2
> >> +              - items:
> >> +                  - const: 1
> >> +          link-frequencies: true
> >> +
> >> +        required:
> >> +          - data-lanes
> >> +          - link-frequencies
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - clocks
> >> +  - clock-names
> >> +  - dovdd-supply
> >> +  - avdd-supply
> >> +  - dvdd-supply
> >> +  - powerdown-gpios
> >> +  - reset-gpios
> >> +  - port
> >
> > I think we don't need all of these entries as required.
> > The only let me say "really" required are:
> >
> > - compatible
> > - reg
> > - clocks
> > - port
> 
> Thanks for the review! I agree that the driver may be modified to work
> without powerdown and reset gpios and they are not required for sensor
> operation. On contrary, supplies are obviously required. Of course, linux
> provides dummy regulators if supplies are missing from device tree, but
> I though the intention was to document hardware, not implementation
> details. What do think of this?

We have already discuss on this on the following thread sometimes ago :)

https://www.patchwork.linux-fancy.com/project/linux-fancy/patch/20220630134835.592521-6-tommaso.merciai@amarulasolutions.com/

Take a look and let me know.

Thanks,
Tommaso
> 
> > Regards,
> > Tommaso
> 
> --
> Best regards,
> Mikhail Rudenko

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
