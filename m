Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0858E672793
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjARS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjARS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:58:02 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1C53E5C;
        Wed, 18 Jan 2023 10:58:01 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id g2-20020a9d6b02000000b006864bf5e658so2985092otp.1;
        Wed, 18 Jan 2023 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYsc2+3T1xktHmEGqYpeNbCSoOWAz0PsmebBy6Jtlfo=;
        b=lybLpshjz/9o2vjEwrtnbLckYmezJA8Vot9YklAh26z7TEkT1IKNxwTz+ksdVLjvYz
         xqvKMehfzB1V58BRUDJpf4eKZkQby0h3TlFZxhI6rjBUqy7fCoLVt6c3MM5l2bSZXxGB
         m2wOFiJBaw/vJwN9ZZrDRcqh1XpenEVeHkia4Hx8G1gFn3NUjBHhVSFFakAWpOwG+LUF
         obweiG/0panIF1Im6r1Rybj67c9tBzgCYbpfZWrRimFBcVBNBrQgyLJkdovrhnai6tNO
         tLqWyLvP/y3/QnkKAmx97YE4H5GmiwbXHAzaA9ybeg0OApTAOlMYpcHNeLKEHGPezMBN
         cc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYsc2+3T1xktHmEGqYpeNbCSoOWAz0PsmebBy6Jtlfo=;
        b=aQ6e4EL1qvjCD8UcHi3BA0/rO0XIo9S/g9fPNVtk7KVt6qCEBL0Us2e3lQ2gpesaoL
         ndThUalOs8j7CzPDetWMEIdmj/HulfvXSbFmM4w0ght09Ofypf/RpmxFdckX5MXybihO
         LunK4yJz0Si99kYTw53VYQvY04tIy5M/P+3U+lHYm3f2iDaLFzBd9vuBT7NBmX5RmOlv
         PVId25y2Wfi/ukaB+27lRKqDPX3olv4rmi9oCVhoxOGSud/0nldNApf09kejxwVrFmd8
         LWj41ovYmbcBcoG9WFCszHDSxNQ9D/Eaw+IueWp4CPgrfmcxTy9gaJMz169FzQ54YvT2
         vDpQ==
X-Gm-Message-State: AFqh2kqmfy6YMqCr1WytmxdqkTxj/ll0FfB2xC6zzAA16Hc8ATWc8gsx
        teCwXyDPx8jLtqLJ0QGB/Fs=
X-Google-Smtp-Source: AMrXdXuuJAHJ8jka3XV+FLXGoeK6UEDC3PedNR8kOJJkMz7GdrNb31x+zEBS6g5C73+2CdrKlBhDRQ==
X-Received: by 2002:a05:6830:280f:b0:684:c3ad:962f with SMTP id w15-20020a056830280f00b00684c3ad962fmr3861005otu.7.1674068280373;
        Wed, 18 Jan 2023 10:58:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d6e12000000b00684c5211c58sm10141786otr.60.2023.01.18.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:57:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 18 Jan 2023 10:57:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>, Kun Yi <kunyi@google.com>,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: correct indentation and style
 in examples
Message-ID: <20230118185758.GA965196@roeck-us.net>
References: <20230118172237.349111-1-krzysztof.kozlowski@linaro.org>
 <20230118172237.349111-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118172237.349111-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:22:37PM +0100, Krzysztof Kozlowski wrote:
> Fix mixed indentation to 4-spaces, remove unnecessary suffix from
> i2c node name and use lower-case hex.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Changes since v1:
> 1. Add Rb tag
> 2. Reorder patches to silence warnings.
> ---
>  .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
>  .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
>  .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
>  .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
>  .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
>  .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
>  .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
>  .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
>  .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
>  .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
>  .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
>  13 files changed, 102 insertions(+), 102 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> index d794deb08bb7..ca2b47320689 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> @@ -52,16 +52,16 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> -    i2c0 {
> +    i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
>          pwmon@5a {
> -                compatible = "adi,adm1177";
> -                reg = <0x5a>;
> -                shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
> -                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
> -                adi,vrange-high-enable;
> +            compatible = "adi,adm1177";
> +            reg = <0x5a>;
> +            shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
> +            adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
> +            adi,vrange-high-enable;
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> index 43b4f4f57b49..4f8e11bd5142 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> @@ -39,13 +39,13 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    i2c0 {
> +    i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
>          adm1266@40 {
> -                compatible = "adi,adm1266";
> -                reg = <0x40>;
> +            compatible = "adi,adm1266";
> +            reg = <0x40>;
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> index f2f99afb3a3b..0cf3ed6212a6 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> @@ -49,15 +49,15 @@ additionalProperties: false
>  examples:
>    - |
>      fpga_axi: fpga-axi {
> -            #address-cells = <0x2>;
> -            #size-cells = <0x1>;
> -
> -            axi_fan_control: axi-fan-control@80000000 {
> -                    compatible = "adi,axi-fan-control-1.00.a";
> -                    reg = <0x0 0x80000000 0x10000>;
> -                    clocks = <&clk 71>;
> -                    interrupts = <0 110 0>;
> -                    pulses-per-revolution = <2>;
> -            };
> +        #address-cells = <0x2>;
> +        #size-cells = <0x1>;
> +
> +        axi_fan_control: axi-fan-control@80000000 {
> +            compatible = "adi,axi-fan-control-1.00.a";
> +            reg = <0x0 0x80000000 0x10000>;
> +            clocks = <&clk 71>;
> +            interrupts = <0 110 0>;
> +            pulses-per-revolution = <2>;
> +        };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
> index bf04151b63d2..152935334c76 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
> @@ -87,15 +87,15 @@ additionalProperties: false
>  examples:
>    - |
>      spi {
> -           #address-cells = <1>;
> -           #size-cells = <0>;
> -
> -           ltc2947_spi: ltc2947@0 {
> -                   compatible = "adi,ltc2947";
> -                   reg = <0>;
> -                   /* accumulation takes place always for energ1/charge1. */
> -                   /* accumulation only on positive current for energy2/charge2. */
> -                   adi,accumulator-ctl-pol = <0 1>;
> -           };
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ltc2947_spi: ltc2947@0 {
> +            compatible = "adi,ltc2947";
> +            reg = <0>;
> +            /* accumulation takes place always for energ1/charge1. */
> +            /* accumulation only on positive current for energy2/charge2. */
> +            adi,accumulator-ctl-pol = <0 1>;
> +        };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> index ec984248219e..dba74f400bc2 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> @@ -55,26 +55,26 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    i2c1 {
> +    i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
>          ltc2992@6f {
> -                #address-cells = <1>;
> -                #size-cells = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
>  
> -                compatible = "adi,ltc2992";
> -                reg = <0x6f>;
> +            compatible = "adi,ltc2992";
> +            reg = <0x6f>;
>  
> -                channel@0 {
> -                        reg = <0x0>;
> -                        shunt-resistor-micro-ohms = <10000>;
> -                };
> +            channel@0 {
> +                reg = <0x0>;
> +                shunt-resistor-micro-ohms = <10000>;
> +            };
>  
> -                channel@1 {
> -                        reg = <0x1>;
> -                        shunt-resistor-micro-ohms = <10000>;
> -                };
> +            channel@1 {
> +                reg = <0x1>;
> +                shunt-resistor-micro-ohms = <10000>;
> +            };
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml b/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
> index 7598b083979c..353d81d89bf5 100644
> --- a/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
> @@ -41,13 +41,13 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    i2c0 {
> +    i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
>          sbrmi@3c {
> -                compatible = "amd,sbrmi";
> -                reg = <0x3c>;
> +            compatible = "amd,sbrmi";
> +            reg = <0x3c>;
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> index 446b09f1ce94..75088244a274 100644
> --- a/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> @@ -42,13 +42,13 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    i2c0 {
> +    i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
>          sbtsi@4c {
> -                compatible = "amd,sbtsi";
> -                reg = <0x4c>;
> +            compatible = "amd,sbtsi";
> +            reg = <0x4c>;
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> index e1ccbd30e0eb..c54b5986b365 100644
> --- a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> @@ -31,7 +31,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -      iio-hwmon {
> -          compatible = "iio-hwmon";
> -          io-channels = <&adc 1>, <&adc 2>;
> -      };
> +    iio-hwmon {
> +        compatible = "iio-hwmon";
> +        io-channels = <&adc 1>, <&adc 2>;
> +    };
> diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> index e1719839faf0..7b9d48d6d6da 100644
> --- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> @@ -198,30 +198,30 @@ examples:
>      };
>    - |
>      i2c {
> -      #address-cells = <1>;
> -      #size-cells = <0>;
> -
> -      sensor@4c {
> -        compatible = "adi,adt7481";
> -        reg = <0x4c>;
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        channel@0 {
> -          reg = <0x0>;
> -          label = "local";
> -        };
> -
> -        channel@1 {
> -          reg = <0x1>;
> -          label = "front";
> -          temperature-offset-millicelsius = <4000>;
> -        };
> -
> -        channel@2 {
> -          reg = <0x2>;
> -          label = "back";
> -          temperature-offset-millicelsius = <750>;
> +        sensor@4c {
> +            compatible = "adi,adt7481";
> +            reg = <0x4c>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0x0>;
> +                label = "local";
> +            };
> +
> +            channel@1 {
> +                reg = <0x1>;
> +                label = "front";
> +                temperature-offset-millicelsius = <4000>;
> +            };
> +
> +            channel@2 {
> +                reg = <0x2>;
> +                label = "back";
> +                temperature-offset-millicelsius = <750>;
> +            };
>          };
> -      };
>      };
> diff --git a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> index 6a1920712fb9..3d0146e20d3e 100644
> --- a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> @@ -131,7 +131,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    thermistor0 {
> +    thermistor {
>        compatible = "murata,ncp18wb473";
>        io-channels = <&gpadc 0x06>;
>        pullup-uv = <1800000>;
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> index 2f0620ecccc9..cd8dcd797031 100644
> --- a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -123,23 +123,23 @@ examples:
>              #size-cells = <0>;
>  
>              channel@0 { /* LTD */
> -              reg = <0>;
> +                reg = <0>;
>              };
>  
>              channel@1 { /* RTD1 */
> -              reg = <1>;
> -              sensor-type = "voltage";
> +                reg = <1>;
> +                sensor-type = "voltage";
>              };
>  
>              channel@2 { /* RTD2 */
> -              reg = <2>;
> -              sensor-type = "temperature";
> -              temperature-mode = "thermal-diode";
> +                reg = <2>;
> +                sensor-type = "temperature";
> +                temperature-mode = "thermal-diode";
>              };
>  
>              channel@3 { /* RTD3 */
> -              reg = <3>;
> -              sensor-type = "temperature";
> +                reg = <3>;
> +                sensor-type = "temperature";
>              };
>          };
>      };
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
> index 1502b22c77cc..fde5225ce012 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
> @@ -77,15 +77,15 @@ additionalProperties: false
>  examples:
>    - |
>      i2c {
> -          #address-cells = <1>;
> -          #size-cells = <0>;
> -
> -          tmp513@5c {
> -              compatible = "ti,tmp513";
> -              reg = <0x5C>;
> -              shunt-resistor-micro-ohms = <330000>;
> -              ti,bus-range-microvolt = <32000000>;
> -              ti,pga-gain = <8>;
> -              ti,nfactor = <0x1 0xF3 0x00>;
> -          };
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tmp513@5c {
> +            compatible = "ti,tmp513";
> +            reg = <0x5c>;
> +            shunt-resistor-micro-ohms = <330000>;
> +            ti,bus-range-microvolt = <32000000>;
> +            ti,pga-gain = <8>;
> +            ti,nfactor = <0x1 0xf3 0x00>;
> +        };
>      };
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> index 3bc8e73dfbf0..bce68a326919 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -40,12 +40,12 @@ additionalProperties: false
>  examples:
>    - |
>      i2c {
> -          #address-cells = <1>;
> -          #size-cells = <0>;
> -
> -          tps23861@30 {
> -              compatible = "ti,tps23861";
> -              reg = <0x30>;
> -              shunt-resistor-micro-ohms = <255000>;
> -          };
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tps23861@30 {
> +            compatible = "ti,tps23861";
> +            reg = <0x30>;
> +            shunt-resistor-micro-ohms = <255000>;
> +        };
>      };
