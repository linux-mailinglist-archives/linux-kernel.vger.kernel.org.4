Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2655BA288
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIOWDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOWDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:03:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51288459A6;
        Thu, 15 Sep 2022 15:03:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i26so32546222lfp.11;
        Thu, 15 Sep 2022 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=H5ThD9BKTz5vBT4VzVyJZJQec8PcnYIVup07wh2iD1Q=;
        b=LHyTLGYjynWOWEWcvC/ImquPZ8TIZBoOGaA5Y0VE2YuX7vvpc4Jlqm7lMxuzWpwI3M
         qHFLaaQoCtwgQSPz5igkwfLgUdTk5ndmSr7i7jLwV4Xy+DzUI+rJqeXzCttTDUj2xecl
         WB6mtZVGfSUqDxB/grzZwd85PWXn0G9xO5OL8/I0l/2cGeyWT0iY9WkBZ3EtN397HmFg
         1ar50iHFiRUTn4ZJ024Uw/w730c0XfVrHu4rwI2EbU1cYyNy0KUKWsVgu+tmcwgkUAdR
         sE14OyxamgMPuBatCZPcaVmyCZRs+8jHAI2GOrklTB5H1RoWZlEfJQjqeFtymQUIZlJV
         2mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=H5ThD9BKTz5vBT4VzVyJZJQec8PcnYIVup07wh2iD1Q=;
        b=ubgdzMnybnbgz4aRNLhGTllMHO+g/VY+efCLsWEyyc6fKkc7njrdnUrYj7huylvbg3
         yEpfan5UHTUr7AGaaUBhEGB+BHj3MNUbvnkr09B/osegRJ1LN9CjS5ncCaD0ec1Z/5VZ
         yijHwhkUlQ8jI2mEaBqIkvdhXA2g0isuBkEAKnLM+4qx3MlYonxfrDJte/oTdEPtu1zQ
         4/7EjJAdtVrbll1OXrAa5r4iFMd2scG1qDi9SW88kSuEI0b4M7LSARoO5dRTFQR0svt8
         ssd/HhT+YC9Fl3VW+4bKfbt36QUz2IDVN5pi3ReJNLGJq9R5LNtFYiAS3KBzJDVfSALw
         1E/Q==
X-Gm-Message-State: ACrzQf0KWEkwvjpHNpnE4dCdfec2l42sFn8/LXKiK4drsEKvtkRcvb62
        +t5W5tvKstlu9q4l/up7fpYOLmkg/F84oQ==
X-Google-Smtp-Source: AMsMyM5FeCIP4QXA/+Xr53/EMAn27RC2IYVpcm+aNtsvvkzH4cniuXWBrYCyHdAKtCRi8ODG/zXp0g==
X-Received: by 2002:a05:6512:1107:b0:49a:d211:bb3c with SMTP id l7-20020a056512110700b0049ad211bb3cmr582980lfg.423.1663279380090;
        Thu, 15 Sep 2022 15:03:00 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b0049476667228sm3156957lfr.65.2022.09.15.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:02:59 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
 <cd363d98-74be-b42f-b1e1-c0f7e79f6011@linaro.org>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Date:   Thu, 15 Sep 2022 15:16:24 +0300
In-reply-to: <cd363d98-74be-b42f-b1e1-c0f7e79f6011@linaro.org>
Message-ID: <87zgf0pa7i.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022-09-12 at 12:55 +02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 11/09/2022 22:01, Mikhail Rudenko wrote:
>> Add device-tree binding documentation for OV4689 image sensor driver,
>> and the relevant MAINTAINERS entries.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>
> Too many "media" prefixes in the subject.

I see, will drop the first "media:" in v3.

> Also you duplicated dt
> bindings as prefix and commit msg (skip the latter).

Just to be clear, do you mean dropping "device-tree binding" phrase from
the commit message?

>> ---
>>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
>>  MAINTAINERS                                   |   7 +
>>  2 files changed, 148 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> new file mode 100644
>> index 000000000000..376330b5572a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Omnivision OV4689 CMOS
>> +
>> +maintainers:
>> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
>> +
>> +description: |
>> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
>> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
>> +  at 2688x1520 resolution. It is programmable through an I2C
>> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> +  connection.
>> +
>> +allOf:
>> +  - $ref: /schemas/media/video-interface-devices.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ovti,ov4689
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description:
>> +      External clock (XVCLK) for the sensor, 6-64 MHz
>> +    maxItems: 1
>> +
>> +  clock-names: true
>
> This has to be strictly defined - which name you expect.

Will fix in v3. Or maybe we should drop clock-names altogether and use
devm_clk_get(&client->dev, NULL) in the driver instead (I've seen this
approach in some existing drivers)?

>> +
>> +  dovdd-supply:
>> +    description:
>> +      Digital I/O voltage supply, 1.7-3.0 V
>> +
>> +  avdd-supply:
>> +    description:
>> +      Analog voltage supply, 2.6-3.0 V
>> +
>> +  dvdd-supply:
>> +    description:
>> +      Digital core voltage supply, 1.1-1.3 V
>> +
>> +  powerdown-gpios:
>> +    maxItems: 1
>
> You can skip here maxItems - it is defined by gpio-consumer-common.

Ack, will fix in v3. Does this also apply to reset-gpios?

>> +    description:
>> +      GPIO connected to the powerdown pin (active low)
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the reset pin (active low)
>> +
>
> Best regards,
> Krzysztof

Thanks for review,

--
Best regards,
Mikhail Rudenko
