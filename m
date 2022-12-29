Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A4658EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiL2Pyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiL2Py2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:54:28 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DA167F9;
        Thu, 29 Dec 2022 07:52:42 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1447c7aa004so22057728fac.11;
        Thu, 29 Dec 2022 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vW8MXh4Mn1681f84anrjuU04/GdxNepGDloajKgzfZk=;
        b=iST9t6g3S6A5oY0zCVrxOMlz1aufM0trr1bdCOJ3tv6CL8Ac/BYf/QVAhevqfgKaWx
         wWYDZnSYlIUO1dSYmJO15PoPYnUMggsKu1EFhEuQlQ0mqFg4wRdt93i4CzM/IvlCMuER
         WedrLTWJh6w7qlgwsY95gO/eFy42t6dLkEWDIkwShgt4fUsQrc3ICQanThqJcxufG7zD
         xEvHsFTMGBuQ863fq7L6pjyK9s6fnT0wp/KPYl/tX4lmq5NSfP5FS+DcY5i59tJGT4g5
         xrDOWxAa/Cy4Zq8bm/Wbv6YmvSkwy1MJDKG8o0r3UkDnTQqIqh2dkwNfn1z88U8ckTLa
         Wfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW8MXh4Mn1681f84anrjuU04/GdxNepGDloajKgzfZk=;
        b=X1XHlptZDiiH6UOAcbY4uLHDBf6c+BqSvZIUF18SWrdjx6kjfJexYPVpE6TNAq4WgZ
         FmoFIC4L1+C4fIoIk8Ou6X9UnHYrKDJr2OPMpDq5WYURx7GEmChw7c1LSuglMeW7jtVB
         uok79CP7sd5JVxRmdAzVyQMqyvvI/sjF+C8osZbwedrjNm/4dBG6K0RCJY4wpSVFXybP
         ofR0hL7PjSXfRNRNGRWKuAlDWAiDjGNvnIL5TutOJVLblOncdYi5I+rOscg7OMsNgk91
         ZumIMx91sA5MeDO0xC/Fn0in5PEoFWR3Pvui/FUV1HiaCRe95WvnyDYxh9MTrMCDyMnX
         J3/Q==
X-Gm-Message-State: AFqh2kosL7THvV7cobNgH29OA5UPL7vXvfwG3CevNKACPfvNU8ZU7hjC
        WC1rcts2ap76iRiniuq/Gs0=
X-Google-Smtp-Source: AMrXdXuT0vomwfXAvwp7Bx6QpIpSSp1oqi9iVQAiP34/b5hkljMMUBTku4/UQgxyiOkRDxtkuyGUWg==
X-Received: by 2002:a05:6870:4711:b0:144:49b8:6800 with SMTP id b17-20020a056870471100b0014449b86800mr16565499oaq.58.1672329149252;
        Thu, 29 Dec 2022 07:52:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u3-20020a056871008300b0010d7242b623sm8774842oaa.21.2022.12.29.07.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:52:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 07:52:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sinan Divarci <Sinan.Divarci@analog.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: Add bindings for max31732
Message-ID: <20221229155227.GA22937@roeck-us.net>
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-4-Sinan.Divarci@analog.com>
 <386e3717-a063-a2ea-6028-19d11b5838b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386e3717-a063-a2ea-6028-19d11b5838b0@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 06:00:03PM +0100, Krzysztof Kozlowski wrote:
> On 14/12/2022 15:22, Sinan Divarci wrote:
> > Adding bindings for max31732 quad remote temperature sensor
> 
> Full stop.
> 
> Subject: drop second, redundant "bindings for".
> 
> > 
> > Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>
> > ---
> >  .../bindings/hwmon/adi,max31732.yaml          | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
> > new file mode 100644
> > index 000000000..c701cda95
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/adi,max31732.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX31732 Temperature Sensor Device Driver
> 
> Drop "Device Driver"
> 
> > +
> > +maintainers:
> > +  - Sinan Divarci <Sinan.Divarci@analog.com>
> > +
> > +description: Bindings for the Analog Devices MAX31732 Temperature Sensor Device.
> 
> Drop "Bindings for". Actually, either drop entire description or write
> something else than title.
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max31732
> > +
> > +  reg:
> > +    description: I2C address of the Temperature Sensor Device.
> 
> Drop description.
> 
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    description: Name of the interrupt pin of max31732 used for IRQ.
> 
> Drop description.
> 
> > +    minItems: 1
> > +    items:
> > +      - enum: [ALARM1, ALARM2]
> > +      - enum: [ALARM1, ALARM2]
> 
> This should be fixed, not flexible. Why it's flexible?
> 
> lowercase letters only
> 
> > +
> > +  adi,alarm1-interrupt-mode:
> > +    description: |
> > +      Enables the ALARM1 output to function in interrupt mode.
> > +      Default ALARM1 output function is comparator mode.
> 
> Why this is a property of DT/hardware? Don't encode policy in DT.
> 

I would not call this "policy". Normally it is an implementation
question or decision, since interrupts behave differently depending
on the mode. Impact is difficult to see, though, since the chip
documentation is not available to the public.

> > +    type: boolean
> > +
> > +  adi,alarm2-interrupt-mode:
> > +    description: |
> > +      Enables the ALARM2 output to function in interrupt mode.
> > +      Default ALARM2 output function is comparator mode.
> 
> Same question.
> 
> > +    type: boolean
> > +
> > +  adi,alarm1-fault-queue:
> > +    description: The number of consecutive faults required to assert ALARM1.
> 
> Same question - why this number differs with hardware?
> 

Noisier hardware will require more samples to avoid spurious faults.
Trade-off is speed of reporting a fault. Normally the board designer
would determine a value which is low enough to avoid spurious faults.

Note that the chip (according to patch 2/3) supports resistance
cancellation as well as beta compensation, which are also board specific.
I don't have access to the datasheet, so I don't know for sure if those
are configurable (typically they are). If they are configurable, I would
expect to see respective properties.

Guenter
