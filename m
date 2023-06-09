Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329DC729697
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjFIKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjFIKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:14:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6849C1;
        Fri,  9 Jun 2023 03:04:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso2819625a12.0;
        Fri, 09 Jun 2023 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686305073; x=1688897073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaEOt4XM83bcgTUl952dFzJXXohH3a20NDWkUA1Lwqw=;
        b=ZGPJVAX5Dm0GqZV9T+trCFw6APuwd+DXkTXyohWbj3OSGCTDDhHu2vIiiRmbaJUD8o
         JffW4+eHUUoRhICUCKz7j0nDTI2TNJ1GMTZERZSgCuz0I60bK0weeFXbhSxnKiY++UBe
         im4jTU5k5jO2deD+ZIV6iBQgV94czGvDjDdx1UdNor3Ja1+dVqJeCITVZP6F/e+D01QF
         5lmGKIyHL2G+FlOIn4oaJ4gVKxLqKApjVIWJZH6VTsHmDXWv0GJ2OgJiJN1l/gswD6u9
         TIAUrEEwKdbtd+o/Pfoe6OJAz1JsoxUuJmouJO5h63/1CWu7PunXU473hMlPzzrk4VX+
         LPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686305073; x=1688897073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaEOt4XM83bcgTUl952dFzJXXohH3a20NDWkUA1Lwqw=;
        b=Csd0MkPhmqdm8v8zw22yJCAPH9b62VbJwpoz/aXfQ33Oa7J9ZIt85+22rT9OIn8wHm
         dJOSfitwfpe/fAxnK5hNrFo/4htVwbvu27uXJCnfMVpXm8PbMc2nNSLP1zbAEz7sBzX1
         79vn9Wa53QY19+mwzhdiFTrKzYBnZfBuUm4FhQcJudHTNv8R3Y+UVcOOYLgDJXhu2gOD
         i0Ux/9Fw4cNcZW7ymluIva5rriXpyZ4aF4yPfCZYUu+cXeRXeNWat6cyM3fV+AUH4uT2
         RZgw8GnrfwKfPt+kL4PDFdZd09ExIO75OSc60p0hjQAMXZYfp5fMTuWDOEng6ivff/hz
         9O3A==
X-Gm-Message-State: AC+VfDzEH/A9noYSrRTEVgy9kOKu2A+TPs5xW68rg5LgxUJ5YNsKvMzq
        ELoaEDeagEMtawAt117BJvo=
X-Google-Smtp-Source: ACHHUZ6T9XpKX7C+YVnNnwrrtcMhO+rsOoqD5ufFaM+e7L3FyvxWmZK/uEFvybhpSND/8HDLqG9PSQ==
X-Received: by 2002:a17:907:9342:b0:973:8198:bbfb with SMTP id bv2-20020a170907934200b009738198bbfbmr1492263ejc.31.1686305073102;
        Fri, 09 Jun 2023 03:04:33 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709064d4e00b00974638e4a98sm1090501ejv.24.2023.06.09.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:04:32 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:04:29 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIL5LcXFCzWM9qtM@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
 <20230608083127.545750-3-tomm.merciai@gmail.com>
 <ZILkSEllSfSGD8XK@kekkonen.localdomain>
 <ZILzvMBCXfde3COF@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZIL0ctohCl5181gJ@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIL0ctohCl5181gJ@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Fri, Jun 09, 2023 at 09:44:18AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Fri, Jun 09, 2023 at 11:41:16AM +0200, Tommaso Merciai wrote:
> > Hi Sakari,
> > Thanks for your feedback.
> > 
> > On Fri, Jun 09, 2023 at 08:35:20AM +0000, Sakari Ailus wrote:
> > > Hi Tommaso,
> > > 
> > > On Thu, Jun 08, 2023 at 10:31:15AM +0200, Tommaso Merciai wrote:
> > > > Add documentation of device tree in YAML schema for the ALVIUM
> > > > Camera from Allied Vision Inc.
> > > > 
> > > > References:
> > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > 
> > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> > > > Changes since v1:
> > > >  - Fixed build error as suggested by RHerring bot
> > > > 
> > > > Changes since v2:
> > > >  - Fixed License as suggested by KKozlowski/CDooley
> > > >  - Removed rotation property as suggested by CDooley/LPinchart
> > > >  - Fixed example node name as suggested by CDooley
> > > >  - Fixed title as suggested by LPinchart
> > > >  - Fixed compatible name as suggested by LPinchart
> > > >  - Removed clock as suggested by LPinchart
> > > >  - Removed gpios not as suggested by LPinchart
> > > >  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
> > > >  - Fixed vendor prefix, unit append as suggested by KKozlowski
> > > >  - Fixed data-lanes
> > > >  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
> > > >  - Dropped status into example  as suggested by KKozlowski
> > > >  - Added vcc-ext-in supply as suggested by LPinchart
> > > >  - Dropped pinctrl into example as suggested by LPinchart
> > > > 
> > > > Changes since v3:
> > > >  - Fixed vcc-ext-in-supply description as suggested by LPinchart
> > > >  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
> > > >  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
> > > >  - Collected Reviewed-by tag from LPinchart
> > > > 
> > > > Changes since v4:
> > > >  - Fixed id as reported by RHerring bot and LPinchart
> > > >  - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
> > > >  - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml
> > > > 
> > > >  .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
> > > >  1 file changed, 97 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > > new file mode 100644
> > > > index 000000000000..c771e5039641
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > > @@ -0,0 +1,97 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Allied Vision Alvium Camera
> > > > +
> > > > +maintainers:
> > > > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > > > +  - Martin Hecht <martin.hecht@avnet.eu>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: alliedvision,alvium-csi2
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  vcc-ext-in-supply:
> > > > +    description: |
> > > > +      The regulator that supplies power to the VCC_EXT_IN pins.
> > > > +
> > > > +  alliedvision,lp2hs-delay-us:
> > > > +    minimum: 1
> > > > +    maximum: 150000
> > > > +    description: |
> > > > +      Low power to high speed delay time.
> > > > +
> > > > +      If the value is larger than 0, the camera forces a reset of all
> > > > +      D-PHY lanes for the duration specified by this property. All lanes
> > > > +      will transition to the low-power state and back to the high-speed
> > > > +      state after the delay. Otherwise the lanes will transition to and
> > > > +      remain in the high-speed state immediately after power on.
> > > > +
> > > > +      This is meant to help CSI-2 receivers synchronizing their D-PHY
> > > > +      RX.
> > > 
> > > Why do you need this? D-PHY TX is obviously controlled by the driver.
> > > Explicit control of PHY initialisation is of course best option when
> > > combined with some receivers, done via driver's pre_streamon and s_stream
> > > callbacks. Can't your hardware do that?
> > 
> > You mean calculate this time in some dynamical way and program this
> > during pre_streamon or s_stream?
> > 
> > If yes, unfortunately hw can't do this.
> 
> This shouldn't be based on timing but rather progress of the bus
> initialisation sequence. That's how it works on most sensors nowadays.

Just to clarify, this is not a sensor:

"The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2."

> 
> The description is also lacking details on what delay this exactly is. What
> is the bus state during that delay?

Previously we have a brief thread with Laurent about
the behaviour of this reg/property, I repost here:

"Thanks to Martin Hecht I'm able to provide you a clearer description:

Alvium normally delivers a continous clock even when it is not streaming.
The purpose of this reg is force a DPhy reset for the period described by
the us on the reg before it starts streaming. To be clear, with that value
bigger than 0 the Alvium forces a dphy-reset on all lanes for that period.
That means all lanes go up into low power state.
This may help a csi2 rx ip to reset if that IP can't deal with a continous clock."


Hope these infos can clarify.
Let me know.

Thanks,
Tommaso

> 
> -- 
> Regards,
> 
> Sakari Ailus
