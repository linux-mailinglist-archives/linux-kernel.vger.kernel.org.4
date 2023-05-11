Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780B6FF9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbjEKTG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjEKTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:06:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2289E268F;
        Thu, 11 May 2023 12:06:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6438d95f447so6340061b3a.3;
        Thu, 11 May 2023 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831983; x=1686423983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh0AlWIaRVTocXAZe3Ut/aMtQv9svxxRfXfLBBk0Wx4=;
        b=o2ejxLWyLpnih3ioOrAn04UQSQdYjPkDJeiH7zXNuSkUCC+R/d/DMwo+TI/B0IQFrs
         y0mVfUveezUtVnDpk0WrrodhcLJp9nX/4YtPniMCBtbprHKYnUnXA2tP5UM7kqELA2ZH
         CkiujqAmi2MkAAm3V8Uz30FKL6OtL5TK+/P6QgmqhHFOHhHElXYtBMnY/JyM2Q6bDktV
         dMXrmHbab9mjQdJ6s6tv37LDSZ8YJf3oFjLxeChcH8m6GVlgH6gh6KS/HAzgBMd2zERS
         t54iCg7HvJTT9YpQKQxr3tV6HFE6YckRJLTU9xqxFoscU7nugTpBD7rtEOz+RCbkZy8f
         PUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831983; x=1686423983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh0AlWIaRVTocXAZe3Ut/aMtQv9svxxRfXfLBBk0Wx4=;
        b=f6q4SDIZJnu6ZS6dYWmQnWjbwJEDrtQCnM05hae8ZSFvHPbG4ZULBil1BZtsi+1DoP
         U1d9Gr34FUCXL/zH/ZpdGcHguRyYP2ecfPLMqscxtaDzGXa0zHYEVw4iRdj5ya30NBj3
         vXBjzZCfIBVdvuDBrBpP80D5BmO5+yjxqaFGySqca8qVXAFIZkm6+43+mQ9o52K15y3R
         hSY2LnrC30jsKVUzwMUw4s3ol7jrklSRdsKpfXQWirfuYY3QNP8wYkfA3enfBYwB3pnW
         8i+hY/VkcAC7IdZJ2g5M0ir63iV3kkyiM5DHKirQOFs/ZGeJtcdcGXu2mIndYQkH+ne3
         slLg==
X-Gm-Message-State: AC+VfDyV4u5GLFcU9fHYByYZNcbODRJ6D5iodF2ai8nTX8WJldfwNAnZ
        hyKtKsNV3ltcNbtOFeBzCmsRdsFqxEEYAJ7X
X-Google-Smtp-Source: ACHHUZ4YYyStbfG6gTaisJeeitQLhe2xvGF2dGGEW8SzA7MMR0nGB9Cj7Fyyb749sFiyywv7SzDHiQ==
X-Received: by 2002:a05:6a20:a113:b0:104:45df:42d8 with SMTP id q19-20020a056a20a11300b0010445df42d8mr1156157pzk.10.1683831983309;
        Thu, 11 May 2023 12:06:23 -0700 (PDT)
Received: from yoga ([2400:1f00:13:5d8c:a310:6231:d348:af43])
        by smtp.gmail.com with ESMTPSA id r11-20020a63fc4b000000b0050be8e0b94csm5272793pgk.90.2023.05.11.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:06:22 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 12 May 2023 00:36:15 +0530
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, broonie@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: temperature: Add DT bindings for TMP006
Message-ID: <ZF08pzGPyReL1uAf@yoga>
References: <ZFvo2TIiPiMFlbXC@yoga>
 <fc104fdd-3894-aa94-12dc-4c73b26d4159@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc104fdd-3894-aa94-12dc-4c73b26d4159@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:28:50AM +0200, Krzysztof Kozlowski wrote:
> On 10/05/2023 20:56, Anup Sharma wrote:
> > Add devicetree binding document for TMP006, IR thermopile sensor.
> 
> Why? Where is any user of this? DTS? Driver?
> 

The support for TMP006 is available at driver/iio/temperature

> Subject: drop second/last, redundant "DT bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
>

Okay, will take care in v2. 

> > 
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../bindings/iio/temperature/ti,tmp006.yaml   | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> > new file mode 100644
> > index 000000000000..c6c5a4d10898
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/ti,tmp006.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI TMP006 IR thermopile sensor
> > +
> > +maintainers:
> > +  - Peter Meerwald <pmeerw@pmeerw.net>
> > +
> > +description: |
> > +  TI TMP006 - Infrared Thermopile Sensor in Chip-Scale Package.
> > +  https://cdn.sparkfun.com/datasheets/Sensors/Temp/tmp006.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,tmp006
> > +
> > +  reg:
> > +    maxItems: 1
> 
> Missing supply.
>

Will add in v2.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        tmp006@40 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> temperature-sensor?
>

Thanks, I have noticed that out of the 8 temperature sensor bindings,
5 are using 'temp-sensor' as the node name, 2 are using 'temperature-sensor',
and 1 is non-generic. According to this docs generic names recommendation
'temperature-sensor' seems to be ideal node name. Should I also proceed
updating all the temperature sensor's node names to a generic format?

> > +            compatible = "ti,tmp006";
> > +            reg = <0x40>;
> > +        };
> > +    };
> 
> Best regards,
> Krzysztof
> 
