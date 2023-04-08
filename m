Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB316DBBE4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDHP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDHP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:29:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8AC44AA;
        Sat,  8 Apr 2023 08:29:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso994213pjb.2;
        Sat, 08 Apr 2023 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680967743; x=1683559743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/CqlFLSqTlHbIyKxwvXGQ5ogjJykzkwTVvFA5reLrY=;
        b=MRHkIlNVuAzdfLMyOf1KU3dKEl6JGIYPOpOLaz/HH3DtmrUctyXQ6l5ZQJqZgDVhII
         0uMYKnIRjhgXPogcW5LMZ/J4g5sETfrVvjSbPfNusD7z7mi7xhSjgX31uqk8sKhTxbKQ
         bzGsMMYzPZhWqqxuL4p5QStegnHRzjYalYEE21AwRlXaGNiLjGwBvf8hAi7fUdKjTr2W
         XlnaE7GsJKO9h1P8HKm4NmjGXjtFWiAIOdOI7UzPOcJ3CIypeiC8wdx2mxm12KaxB3qm
         OwHYIkTnDjO9VtZjmUrWxupB0IP5+qHJJXQwge+J3xlSUgQeN3H3DXKLZM79LZFqsYli
         A/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680967743; x=1683559743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/CqlFLSqTlHbIyKxwvXGQ5ogjJykzkwTVvFA5reLrY=;
        b=LakrHfLRSEJb47B5QouSD+ub+MnsXGHDliepDjsLSTw8GZJ0uTGwce73maDGluzh7B
         gMspR/GJ3Qz9Pki3bme8RDKQq0ROgS7Yf2S+F2T/IHEz80LkPyRq/TUgMi2NyUeMZUsv
         Q3M7ZHJAm5OTLPWZRzrMNvIBNooghvtoOYMFuWy1CHKLC/Wpf2h4WUpu6Ctq6I6ZYx7b
         NahUX00QGBxZVgDOCw5lqHg7Ypkdwu9dIaJDK+ItEGdBb9jfUEoJ7jQufE6eTGGynTZe
         QAXMLrCzyQ3btNgz9l02R8WbZtSQwPZL0fSU0tDqxVtouUd2T7w5lD55s6YwEj7JlE6g
         7zPg==
X-Gm-Message-State: AAQBX9f2rzNDab5DUdslNJcePJRbm+VKzHU8BiyoN8v/C6bOnDSELnmZ
        tm/6LHe4uHyQoLsYps55JSs=
X-Google-Smtp-Source: AKy350Y+M27wSUr2e2KA/3Osm5k6tDYPZAW3F7SZ5WX9U9qR8HLOaf0b2Pwx1PQHytYXXR2m/tR1vg==
X-Received: by 2002:a17:902:e550:b0:19c:da7f:a234 with SMTP id n16-20020a170902e55000b0019cda7fa234mr7765282plf.67.1680967742844;
        Sat, 08 Apr 2023 08:29:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b00199023c688esm4688711plb.26.2023.04.08.08.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 08:29:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 8 Apr 2023 08:29:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add starfive,jh71x0-temp
Message-ID: <746ae322-f661-4713-8152-1f7b33b1a988@roeck-us.net>
References: <20230321022644.107027-1-hal.feng@starfivetech.com>
 <20230321022644.107027-2-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321022644.107027-2-hal.feng@starfivetech.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:26:43AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the temperature sensor on the StarFive JH7100 and
> JH7110 SoCs.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/starfive,jh71x0-temp.yaml  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml b/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> new file mode 100644
> index 000000000000..f5b34528928d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/starfive,jh71x0-temp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH71x0 Temperature Sensor
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +
> +description: |
> +  StarFive Technology Co. JH71x0 embedded temperature sensor
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7100-temp
> +      - starfive,jh7110-temp
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: "sense"
> +      - const: "bus"
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: "sense"
> +      - const: "bus"
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7100.h>
> +    #include <dt-bindings/reset/starfive-jh7100.h>
> +
> +    temperature-sensor@124a0000 {
> +        compatible = "starfive,jh7100-temp";
> +        reg = <0x124a0000 0x10000>;
> +        clocks = <&clkgen JH7100_CLK_TEMP_SENSE>,
> +                 <&clkgen JH7100_CLK_TEMP_APB>;
> +        clock-names = "sense", "bus";
> +        #thermal-sensor-cells = <0>;
> +        resets = <&rstgen JH7100_RSTN_TEMP_SENSE>,
> +                 <&rstgen JH7100_RSTN_TEMP_APB>;
> +        reset-names = "sense", "bus";
> +    };
