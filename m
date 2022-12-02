Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4D64065E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiLBMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLBMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:07:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68144CFE50
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:07:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u12so6527521wrr.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ufkksRCnKTyw8dIplA/b/uLD8QaAG4PtkuYozKAX1Z0=;
        b=Z0M6DwF7LCtwmn/juE9eFrYObIzTrdrAjL4bg6fXZ9E6KUOBabZPQY0qTqII5jvLBp
         cMw2Ack4Ouvc5Ma5M8TUMhU5ZFHANZTj+BNojedcmz4qxNKUFGVjoEJ3LG6lXKFzKpHO
         /aJz+K/ZjoCZIEdycG9SH4B2stg9SGb9yEuQUJFBdiqKIWqy4F3Tbsn5D4jmDd42zG8U
         EQwSdpBKOdFIyG0K4vqZ9MXMtn6F8bHyiBN4gsK4jGpR3ydfLSmtyRPo4Lp9CM6XUdlQ
         agajMzxyImZ3PZfXKMjzknUtcFHE13TUbPuNwcAYTGK2t5ysDZK2em3Mvj72Eg05koL5
         ypYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufkksRCnKTyw8dIplA/b/uLD8QaAG4PtkuYozKAX1Z0=;
        b=6GPdMeRrNL8tQtumD0EAn2/S43LIzJdWEwsMvJvceqpftUiAdYDmZtAmtYitsSRUhh
         KPp9Nn67yqIwHxdrLvjU/WPTp3WocJLRo/oMTe+Hd2PXFemSJ7XfOpZcdimro39Y0klS
         i+kN64dNgPlWCT2CJ7U8dnmVicX//3zRmtdP4Ub1VHAdscWWTte9etintH7yaTR3/pMw
         iE+c26f5EPbPg+RdZ7tGWLZnLrWKmqoVJ1X0OYex2rvGy2BmwWd2kVk929g/7innEgyE
         NhvfN2uGv+nz0qwsF9zhpERNnQ/D69XMyVxfRQqMkX20VI8RGIZAufhyuRDpQ8GkZM3t
         s/kA==
X-Gm-Message-State: ANoB5pkUHcXn1VMagdlE2eyzzAOwZdrsLIT1NdDdqOul/Z2rLEJqyvOG
        wMUUr0hXUKD+Vdbe55MTfsTx3A==
X-Google-Smtp-Source: AA0mqf7OMOowsFNaor0Sk6Vwy+31GQ71GxxItMw6BB+vya1kxwo11iMY7T1bzqWILnH0q/SYNXJl2g==
X-Received: by 2002:a05:6000:1b86:b0:241:9606:1123 with SMTP id r6-20020a0560001b8600b0024196061123mr38434943wru.537.1669982826911;
        Fri, 02 Dec 2022 04:07:06 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a23-20020a05600c225700b003cfe1376f68sm8168690wmm.9.2022.12.02.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:07:06 -0800 (PST)
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-12-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 11/11] arm64: dts: meson: a1: introduce PLL and
 Peripherals clk controllers
Date:   Fri, 02 Dec 2022 13:03:59 +0100
In-reply-to: <20221201225703.6507-12-ddrokosov@sberdevices.ru>
Message-ID: <1jlenq6mc7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 02 Dec 2022 at 01:57, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> This patch adds clkc_periphs and clkc_pll dts nodes to A1 SoC main dtsi.
> The first one clk controller is responsible for all SoC peripherals
> clocks excluding audio clocks. The second one clk controller is used by
> A1 SoC PLLs. Actually, there are two different APB heads, so we have two
> different drivers.

Please send this change through a separate patcheset.

One patcheset/series for clk (and bindings)
Another one for the DTS (usually sent after the first one is accepted)

>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 27 ++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index b4000cf65a9a..38e6517c603c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -6,6 +6,8 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/gpio/meson-a1-gpio.h>
> +#include <dt-bindings/clock/a1-pll-clkc.h>
> +#include <dt-bindings/clock/a1-clkc.h>
>  
>  / {
>  	compatible = "amlogic,a1";
> @@ -81,7 +83,6 @@ apb: bus@fe000000 {
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
>  
> -
>  			reset: reset-controller@0 {
>  				compatible = "amlogic,meson-a1-reset";
>  				reg = <0x0 0x0 0x0 0x8c>;
> @@ -124,6 +125,30 @@ uart_AO_B: serial@2000 {
>  				clock-names = "xtal", "pclk", "baud";
>  				status = "disabled";
>  			};
> +
> +			clkc_periphs: periphs-clock-controller@800 {

device name should be generic so

clkc_periphs: clock-controller@800 would be better

> +				compatible = "amlogic,a1-periphs-clkc";
> +				reg = <0 0x800 0 0x104>;
> +				#clock-cells = <1>;
> +				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +					 <&clkc_pll CLKID_FCLK_DIV3>,
> +					 <&clkc_pll CLKID_FCLK_DIV5>,
> +					 <&clkc_pll CLKID_FCLK_DIV7>,
> +					 <&clkc_pll CLKID_HIFI_PLL>,
> +					 <&xtal>;
> +				clock-names = "fclk_div2", "fclk_div3",
> +					      "fclk_div5", "fclk_div7",
> +					      "hifi_pll", "xtal";
> +			};
> +
> +			clkc_pll: pll-clock-controller@7c80 {

Same here

> +				compatible = "amlogic,a1-pll-clkc";
> +				reg = <0 0x7c80 0 0x18c>;
> +				#clock-cells = <1>;
> +				clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
> +					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
> +				clock-names = "xtal_fixpll", "xtal_hifipll";
> +			};
>  		};
>  
>  		gic: interrupt-controller@ff901000 {

