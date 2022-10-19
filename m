Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1295604BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiJSPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiJSPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:39:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D191C77CA;
        Wed, 19 Oct 2022 08:35:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1324e7a1284so21078108fac.10;
        Wed, 19 Oct 2022 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtSXrbk+/YXqmytmSl9HuYJzWOnh4YSqZcLqLVZsnew=;
        b=NT7fT2pZ4nzhKqBvZsFMF97TwqEj1L4ObZboENqb5fY0+x7qzGIy/1EKXbhT/lFc5q
         JV7ll1Zawo/rvn5bpF9Sbo0eqbQobFeSrnzklLD+W2Fg7nFiUYFjP/PhakIgfKDdbX9h
         1yGjhWsDhtc3pQvm2Ox0qIdsF/WOKUl2PnHIcwqc8GWcgtvNT2cxDvwm8mma5L7PrtwW
         kirKJGq+/7lPaYzxWJcjNUi56psujJeFyFWBMGGw/r/7E7JDa2old9CyOHjgyB0FS/R8
         paVIz8VCS7nyDUr5uRQ2X8on1obOXkUhGUJgORuLeHZao/WxJB16J3z+Kr6ekNCihiml
         p3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtSXrbk+/YXqmytmSl9HuYJzWOnh4YSqZcLqLVZsnew=;
        b=YmucRfNhflj4UTf5dl1VYoJRAiTgiASa2lZ3p8GN37ePtrTKpJTqgn9Q14MuhReY0D
         hNJPZ3PY30C3DJR9sFzqqNSlM8eN0u8C8szD3tcaGu6bc7J6yIVSJU+U1i8j8SUO/kHz
         Q7jZUctE3skgCu53YJmH7DMeG201A837EQfQECU56+u7lCyl0bwbFrbEmfyEqyTz6Bf0
         yxjSAQvtB1wcoa2XVFThKdGxntDyt1aK3AeHc5ZoWXY1nd/CL86kWpZnaa4X9IqoQIiu
         bRkdTOVWFssyrkksKvNc6dnHkB4JRrNrn/gJpU+h9jiei8tVQAVV7UN5HTz7PPYryJai
         VBrw==
X-Gm-Message-State: ACrzQf38HkSxPm2kD8ucIf80dI5Xr1xuRF6/EUy7EDm6FjocvmDhuTkR
        XXiv4eWPAOyLb1GTQZ5CuVY=
X-Google-Smtp-Source: AMsMyM4lySCJcZ7kqw7FDWIZF+nYNgOKRKzdVE6hFclXcjnBm4ycOjGnpuoaifyqnP+XsflYrr/ybw==
X-Received: by 2002:a05:6870:d7a4:b0:136:ddff:40c2 with SMTP id bd36-20020a056870d7a400b00136ddff40c2mr5558767oab.134.1666193698612;
        Wed, 19 Oct 2022 08:34:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15-20020a4a450f000000b004767df8f231sm6623348ooa.39.2022.10.19.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:34:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Oct 2022 08:34:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Message-ID: <20221019153456.GD4602@roeck-us.net>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com>
 <3d07998b-f02a-036c-af66-883671ac1730@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d07998b-f02a-036c-af66-883671ac1730@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:34:15AM -0400, Krzysztof Kozlowski wrote:
> On 19/10/2022 09:39, Ibrahim Tilki wrote:
> > Devicetree binding documentation for Analog Devices MAX313XX RTCs
> > 
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > ---
> >  .../devicetree/bindings/rtc/adi,max313xx.yaml | 163 ++++++++++++++++++
> >  1 file changed, 163 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > new file mode 100644
> > index 000000000..1aa491799
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > @@ -0,0 +1,163 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX313XX series I2C RTC driver
> 
> Drop "driver" unless it is some hardware-related term.
> 
> > +
> > +maintainers:
> > +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > +
> > +description: Bindings for the Analog Devices MAX313XX series RTCs.
> 
> Drop "Bindings for"
> 
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
> 
> This looked familiar... and indeed it is.
> 
> https://lore.kernel.org/all/a382fdee-3672-50b8-cd58-85563b9d9079@linaro.org/
> 
> Where is the changelog? What are the differences? How can we understand
> what is happening here?
> 

I hope that other submission was an error; otherwise it tried to sneak in
the bindings for max313xx under an unrelated subject.

Guenter
