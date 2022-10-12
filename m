Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7429C5FC9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJLRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJLRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:31:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5600A87A5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:31:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy4so3040896ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7g3dd5oDblHSvi18BkA/g8g+g7bbmFZJfYmI1TEETpo=;
        b=NynZaqiW8iZBWr74bVjdNFWdXcRTfSd282NrBTXL3fuag703GobvYOkLPxqyhXQS48
         7VZKSimGgc+CFlVqetGlUZZYWlECy91Xqw7ymAjZ0OdCsKsqKEqOOmqji6hO182aNtjB
         47eFZ3fudM9qwmG2j9liKzxFKIPGKZquutDxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g3dd5oDblHSvi18BkA/g8g+g7bbmFZJfYmI1TEETpo=;
        b=uADfLI+fVraIlLw7ZMq2Pmz2vOAIx3IeVl0Jun1XzxdBU3DdSlFJ60i2b3jNIeiNBz
         ZsSQ1lUYqSqro/7zyh4IprfFB3WHFIlngS5a3XLptonAk4qThBUmOY2Wn/lTxUYAPwou
         1Hg+DN60Sj5oN5TtWv6sgkR9vaas6fFK5omiVGhFgYfv8KkJGt9ztMZY6SOUXHhKtLSk
         d9/vl3oVv9zOxwrKVO1gB9tcvFGl6b3R8PkwkR54hf4mbTE7lq2TqJmVURnOdc+xwOGa
         oB9lnSpBtZJx3Qk0IvVeY8CATnDSzxXJ3dlSCdO4gvwd6XBaFT2pLAr8UuwxY285JZv/
         keSw==
X-Gm-Message-State: ACrzQf33iTS6wkoLi1Im4OmwjaF7CGhZ2du5RVVksUlu0MyoozHxm/wa
        LVf/KadG1SfdgyYYDVM1tyvTX45ZvoBvvzpk
X-Google-Smtp-Source: AMsMyM5ShYiK25NEWy8NYyD7yQ/J7+YT81pWFWbZK5PbuBj3i8ThO3Ncc7fqZdFm3jJWI9jFDWvNAA==
X-Received: by 2002:a17:907:2beb:b0:78d:9b56:12b4 with SMTP id gv43-20020a1709072beb00b0078d9b5612b4mr17341294ejc.237.1665595914791;
        Wed, 12 Oct 2022 10:31:54 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id la8-20020a170907780800b0077f20a722dfsm1590588ejc.165.2022.10.12.10.31.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 10:31:53 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bv10so23698689wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:31:52 -0700 (PDT)
X-Received: by 2002:adf:dfc1:0:b0:22f:edf7:b11b with SMTP id
 q1-20020adfdfc1000000b0022fedf7b11bmr12498392wrn.583.1665595912117; Wed, 12
 Oct 2022 10:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145116.46554-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007145116.46554-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Oct 2022 10:31:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UAcn=yeCZ_jum9kGgqsdKsPpya-FPumYUWO=iyp-kKYw@mail.gmail.com>
Message-ID: <CAD=FV=UAcn=yeCZ_jum9kGgqsdKsPpya-FPumYUWO=iyp-kKYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 7, 2022 at 7:51 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Merge subnodes named 'pinconf' and 'pinmux' into one entry, add function
> where missing (required by bindings for GPIOs) and reorganize overriding
> pins by boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware.

I applied these two patches to the top of mainline today and booted up
a sc7180-trogdor-coachz. I didn't do any stress testing, but at least
it boots up and basic smoke tests pass.

> Doug,
>
> I think this implements our conclusion from SDM845 patches (alignment of
> pinctrl with DT schema).

Yeah, it looks really great! Hopefully others agree that this scheme
looks great and it also validates nicely with your schema changes.
Sorry for taking a few days to get back--your email coincided with a
few vacation days for me.

I have a few nits and there's at least one problem (the glitching of
the SPI chip select at boot).


> Cc: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 211 +++---
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  41 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
>  .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
>  .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
>  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 655 +++++++-----------
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 410 +++++------
>  18 files changed, 613 insertions(+), 1108 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 9dee131b1e24..3e93b13d275e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts

[ ...cut... ]

> @@ -642,126 +596,131 @@ pinconf-rts {
>                          * pulling RX low (by sending wakeup bytes).
>                          */
>                          pins = "gpio39";
> +                       function = "gpio";
>                          bias-pull-down;

optional nit: your new addition makes it obvious that the indentation of the
surrounding lines is wrong. Maybe fix it as part of this patch?


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index 1bd6c7dcd9e9..c66568a882b3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -180,30 +180,19 @@ &wifi {
>  /* PINCTRL - modifications to sc7180-trogdor.dtsi */
>
>  &en_pp3300_dx_edp {
> -       pinmux {
> -               pins = "gpio67";
> -       };
> -
> -       pinconf {
> -               pins = "gpio67";
> -       };
> +       pins = "gpio67";
>  };
>
>  &sec_mi2s_active{
> -       pinmux {
> -               pins = "gpio49", "gpio50", "gpio51", "gpio52";
> -               function = "mi2s_1";
> -       };
> +       pins = "gpio49", "gpio50", "gpio51", "gpio52";

Looks like the point of the homestar override is to add an extra pin
(gpio52) but it forgot to update the list in the "pinconf" as well so
gpio52 wasn't getting a drive strength and bias set. Your patch
has the side effect of fixing this. That looks right to me (match
GPIO51) given that the name of GPIO51 is AMP_DIN and GPIO52 AMP_DIN2.

Assuming my analysis is correct, it's probably worth mentioning this
behavior change in the commit message.


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index eae22e6e97c1..d923ddca8b8b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -880,17 +880,17 @@ &sdhc_2 {
>  };
>
>  &spi0 {
> -       pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_cs_gpio>;
> +       pinctrl-0 = <&qup_spi0_cs_gpio>;

I think this is going to cause a problem. This is pretty much a direct
revert of commit e440e30e26dd ("arm64: dts: qcom: sc7180: Avoid glitching
SPI CS at bootup on trogdor").

I was never crazy about the solution in the patch, but I really couldn't
find another great way to solve it. I think the problem is fairly well
described in that commit message, at least, and I'm certainly open to
alternate solutions. Until then, I think this prevents landing your
patch.

[ ... cut ... ]

> @@ -1467,197 +1315,174 @@ pinconf-rts {
>                          * pulling RX low (by sending wakeup bytes).
>                          */
>                          pins = "gpio39";
> +                       function = "gpio";
>                          bias-pull-down;

optional nit: your new addition makes it obvious that the indentation of the
surrounding lines is wrong. Maybe fix it as part of this patch?


> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 58976a1ba06b..8f7845fa669c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1486,410 +1486,336 @@ tlmm: pinctrl@3500000 {

[ ... cut ... ]

> -                       qup_spi0_default: qup-spi0-default {
> -                               pinmux {
> -                                       pins = "gpio34", "gpio35",
> -                                              "gpio36", "gpio37";
> -                                       function = "qup00";
> -                               };
> +                       qup_spi0_default: qup-spi0-default-state {
> +                               pins = "gpio34", "gpio35", "gpio36", "gpio37";
> +                               function = "qup00";
>                         };
>
> -                       qup_spi0_cs_gpio: qup-spi0-cs-gpio {
> -                               pinmux {
> +                       qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
> +                               qup_spi0_spi: spi-pins {
>                                         pins = "gpio34", "gpio35",
>                                                "gpio36";
>                                         function = "qup00";
>                                 };
>
> -                               pinmux-cs {
> +                               qup_spi0_cs: cs-pins {
>                                         pins = "gpio37";
>                                         function = "gpio";
>                                 };
>                         };

The way that the cs_gpio ended up after your patch series threw me for
a loop. It's counterintutive that we have labels "qup_spi0_spi" and
"qup_spi0_cs" and they're _not_ under "qup_spi0_default".

Here are two proposals and I'd be happy with either of them:

a) Get rid of the gpio nodes. Instead in the dtsi file do:

  qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
    qup_spi0_spi: spi-pins {
      pins = "gpio34", "gpio35", "gpio36";
      function = "qup00";
    };

    qup_spi0_cs: cs-pins {
      pins = "gpio37";
      function = "qup00";
    };
  };

In the board file just:

  &qup_spi0_cs {
    function = "gpio";
  };

b) Split the whole thing up. In the dtsi file pinctrl section:

  qup_spi0_spi: qup-spi0-spi-state {
    pins = "gpio34", "gpio35", "gpio36";
    function = "qup00";
  };

  qup_spi0_cs: qup-spi0-cs-state {
    pins = "gpio37";
    function = "qup00";
  };

  qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
    pins = "gpio37";
    function = "gpio";
  };

...in the dtsi file SPI section:

  pinctrl-0 = <&qup_spi0_spi> <&qup_spi0_cs>;

...in the board SPI section:

  pinctrl-0 = <&qup_spi0_spi> <&qup_spi0_cs_gpio>;

[ ... cut ... ]
> -                       qup_uart0_default: qup-uart0-default {
> -                               pinmux {
> -                                       pins = "gpio34", "gpio35",
> -                                              "gpio36", "gpio37";
> -                                       function = "qup00";
> -                               };
> +                       qup_uart0_default: qup-uart0-default-state {
> +                               pins = "gpio34", "gpio35", "gpio36", "gpio37";
> +                               function = "qup00";
>                         };

It feels like all of the UARTs should be split up like uart3/uart8 are
If any board actually uses these they will likely want different pulls
and configs for the different pins.
