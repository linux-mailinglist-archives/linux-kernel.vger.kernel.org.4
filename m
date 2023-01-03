Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24565C901
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbjACVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjACVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:37:33 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A626218A;
        Tue,  3 Jan 2023 13:37:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s187so28134593oie.10;
        Tue, 03 Jan 2023 13:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWYmbDDxiEAE9Ra4ABbhImLoE8Nikm2avfzKxOnXaCQ=;
        b=XKOF0vJ3P44KwqQuJux/hhsDcU0Z6TAe0EnhxRIPwsYK6e1kBMl6fGdunMgz49rMUS
         ddlvQ56V2yNNfm85ZR6NWYgsESu9S3gj0Airc6INSul2jJ0WPXbzfjfHuGdClin96U33
         PrmG/A66zWOG0V8PzGEClBg/duDa+ILYkz+nVJxSpYTWQqbckSxw5EzGNTOq0VLoDrl1
         cH7U97UaJsCw9NflKmgowVcR05eJnMzt4V3DLmRH2RMvMijjLRfXAwKwFn53CSq0Dvr1
         t4o1OWbJl2VjS2yady8Zr3yqJOoSxW0Ndo6Hf4ZO2fvYtPtlD74ssnUIiTjr3Gi/19aU
         tOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWYmbDDxiEAE9Ra4ABbhImLoE8Nikm2avfzKxOnXaCQ=;
        b=6QlKzf4bKbe38e8hANVODeWvrh/u9GgpRbhDRHdv/vc4q/NthE8rh34ccdGpFWJko3
         0JEHvfhK62nQwWflE0J5fVix7u0mydDtxHyoXXIcJYiWBJY93VMWvSORS5i45DB3GbKd
         aljqcBUdVrCEOUxdLMPDVgWb6gl1mycesOmNoBpYycqydBLuZ4wrqywIi/i3vDBYQ9dS
         7Qek66HPo0GXJdNpMdVCLebaDkjbpkJbNyaeZ3u+NxtROcFlGNkyOGbgd+NokQrWK9Vj
         F1zdfSRF9AmvpQsUJ66OhRXG8l7uuYvIoeUjlslVxi4iU1RQdVeX/1ESBjP1M+686WyJ
         Kvsw==
X-Gm-Message-State: AFqh2kq7X8OfBPfFiZR3EsEpp2oiUoKrTYrNkfQOwm/Oj0kc/RJJJXdg
        lVRalGXtjkzU42s6s/4uKKs=
X-Google-Smtp-Source: AMrXdXvl8YYaZrODmKyi1zh4A/W9ZT+xYCnOy8LNMVM7Y+3EZEz3CeTvV+XgvWsW06rhLByLmVlK9g==
X-Received: by 2002:a05:6808:1a09:b0:35e:bc7b:20ea with SMTP id bk9-20020a0568081a0900b0035ebc7b20eamr33528330oib.57.1672781851356;
        Tue, 03 Jan 2023 13:37:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be15-20020a056808218f00b0035e7c48d08esm13513731oib.15.2023.01.03.13.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:37:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:37:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Message-ID: <20230103213729.GA216474@roeck-us.net>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103203654.59322-4-nick.hawkins@hpe.com>
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

On Tue, Jan 03, 2023 at 02:36:52PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Reorganize the base address of AHB to accommodate the SPI and fan driver
> register requirements. Add the hpe,gxp-spifi and hpe,gxp-fan-ctrl
> compatibles. Add comments to make the register range more clear.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Note that I can not apply this patch; it will have to be applied through
the arm tree.

Guenter

> ---
> v4:
>  *No change
> v3:
>  *No change
> v2:
>  *Changed fn2reg to fn2
>  *Changed plreg to pl
>  *Changed fanctrl to fan-controller
>  *Adjusted base register range to elminate need for defines in code
> ---
>  arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 58 +++++++++++++++++++++
>  arch/arm/boot/dts/hpe-gxp.dtsi           | 64 +++++++++++++++++-------
>  2 files changed, 103 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> index 3a7382ce40ef..d49dcef95c5c 100644
> --- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> @@ -24,3 +24,61 @@
>  		reg = <0x40000000 0x20000000>;
>  	};
>  };
> +
> +&spifi {
> +	status = "okay";
> +	flash@0 {
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			u-boot@0 {
> +				label = "u-boot";
> +				reg = <0x0 0x60000>;
> +			};
> +
> +			u-boot-env@60000 {
> +				label = "u-boot-env";
> +				reg = <0x60000 0x20000>;
> +			};
> +
> +			kernel@80000 {
> +				label = "kernel";
> +				reg = <0x80000 0x4c0000>;
> +			};
> +
> +			rofs@540000 {
> +				label = "rofs";
> +				reg = <0x540000 0x1740000>;
> +			};
> +
> +			rwfs@1c80000 {
> +				label = "rwfs";
> +				reg = <0x1c80000 0x250000>;
> +			};
> +
> +			section@1ed0000{
> +				label = "section";
> +				reg = <0x1ed0000 0x130000>;
> +			};
> +		};
> +	};
> +	flash@1 {
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			host-prime@0 {
> +				label = "host-prime";
> +				reg = <0x0 0x02000000>;
> +			};
> +
> +			host-second@2000000 {
> +				label = "host-second";
> +				reg = <0x02000000 0x02000000>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> index cf735b3c4f35..b73b22a93716 100644
> --- a/arch/arm/boot/dts/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Device Tree file for HPE GXP
> + * Device Tree for HPE
>   */
>  
>  /dts-v1/;
> @@ -52,76 +52,102 @@
>  			cache-level = <2>;
>  		};
>  
> -		ahb@c0000000 {
> +		ahb@80000000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x0 0xc0000000 0x30000000>;
> +			ranges = <0x0 0x80000000 0xf000000>, /* 0x80000000 - 0x8f000000 */
> +				 <0x40000000 0xc0000000 0x7fffffff>; /* 0xc0000000 - 0xffffffff */
>  			dma-ranges;
>  
> -			vic0: interrupt-controller@eff0000 {
> +			spifi: spi@40000200 { /* 0xc0000200 */
> +				compatible = "hpe,gxp-spifi";
> +				reg = <0x40000200 0x80>, <0x4000c000 0x100>, <0x78000000 0x7ff0000>;
> +				interrupts = <20>;
> +				interrupt-parent = <&vic0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +				flash@0 {
> +					reg = <0>;
> +					compatible = "jedec,spi-nor";
> +				};
> +
> +				flash@1 {
> +					reg = <1>;
> +					compatible = "jedec,spi-nor";
> +				};
> +			};
> +
> +			vic0: interrupt-controller@4eff0000 { /* 0xceff0000 */
>  				compatible = "arm,pl192-vic";
> -				reg = <0xeff0000 0x1000>;
> +				reg = <0x4eff0000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
>  
> -			vic1: interrupt-controller@80f00000 {
> +			vic1: interrupt-controller@f00000 { /* 0x80f00000 */
>  				compatible = "arm,pl192-vic";
> -				reg = <0x80f00000 0x1000>;
> +				reg = <0xf00000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
>  
> -			uarta: serial@e0 {
> +			uarta: serial@400000e0 { /* 0xc00000e0 */
>  				compatible = "ns16550a";
> -				reg = <0xe0 0x8>;
> +				reg = <0x400000e0 0x8>;
>  				interrupts = <17>;
>  				interrupt-parent = <&vic0>;
>  				clock-frequency = <1846153>;
>  				reg-shift = <0>;
>  			};
>  
> -			uartb: serial@e8 {
> +			uartb: serial@400000e8 { /* 0xc00000e8 */
>  				compatible = "ns16550a";
> -				reg = <0xe8 0x8>;
> +				reg = <0x400000e8 0x8>;
>  				interrupts = <18>;
>  				interrupt-parent = <&vic0>;
>  				clock-frequency = <1846153>;
>  				reg-shift = <0>;
>  			};
>  
> -			uartc: serial@f0 {
> +			uartc: serial@400000f0 { /* 0xc00000f0 */
>  				compatible = "ns16550a";
> -				reg = <0xf0 0x8>;
> +				reg = <0x400000f0 0x8>;
>  				interrupts = <19>;
>  				interrupt-parent = <&vic0>;
>  				clock-frequency = <1846153>;
>  				reg-shift = <0>;
>  			};
>  
> -			usb0: usb@efe0000 {
> +			usb0: usb@4efe0000 { /* 0xcefe0000 */
>  				compatible = "hpe,gxp-ehci", "generic-ehci";
> -				reg = <0xefe0000 0x100>;
> +				reg = <0x4efe0000 0x100>;
>  				interrupts = <7>;
>  				interrupt-parent = <&vic0>;
>  			};
>  
> -			st: timer@80 {
> +			st: timer@40000080 { /* 0xc0000080 */
>  				compatible = "hpe,gxp-timer";
> -				reg = <0x80 0x16>;
> +				reg = <0x40000080 0x16>;
>  				interrupts = <0>;
>  				interrupt-parent = <&vic0>;
>  				clocks = <&iopclk>;
>  				clock-names = "iop";
>  			};
>  
> -			usb1: usb@efe0100 {
> +			usb1: usb@4efe0100 { /* 0xcefe0100 */
>  				compatible = "hpe,gxp-ohci", "generic-ohci";
> -				reg = <0xefe0100 0x110>;
> +				reg = <0x4efe0100 0x110>;
>  				interrupts = <6>;
>  				interrupt-parent = <&vic0>;
>  			};
> +
> +			fan-controller@40000c10 { /* 0xc0000c10 */
> +				compatible = "hpe,gxp-fan-ctrl";
> +				reg = <0x40000c10 0x8>, <0x51000027 0x06>, <0x200070 0x04>;
> +				reg-names = "base", "pl", "fn2";
> +			};
>  		};
>  	};
>  };
