Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855315F3327
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJCQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJCQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:14:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A632EC2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:14:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kg6so7892259ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yk7oJZLDXyhhoAd4r8V1DWsPQGI8oxapkOedmVfTAZ4=;
        b=kFihQmQbZXO9UYogepj/ySvEsxsGhYeu7Ektj+T7aQ+R/Q1s/fxax3OVMwZM8a5vZ8
         n/Vqdm0iF0eiCCyuLeV9JHPnjhMFQbdca0nWnDxvZDjI7omMrNeVdzwBWxYXo2z7CLdu
         LdungS03nYGtagU0cqFvFiSojQZEXuApykW1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yk7oJZLDXyhhoAd4r8V1DWsPQGI8oxapkOedmVfTAZ4=;
        b=38bWbbj+yqy49YmXMPXQh3S04bqboUkAnj+ytP/VLa4KVVES3h2aY5HKV5596VTBVx
         HdtEnQ/0KH8bQdgo72Ag50YqhIAHO+iDrsQ9+yvCIEPlTHb3MOIDoz5xW138Kii3MuQ5
         AQXgb5rfDF1lL81cCeLrJD0o2bPDCb1GFEqwNmmYYxb8uw3FtXUmn1IZdxHMTDRWDvtb
         NXtm+/AXvJVR2cPFBvXapSu4+o8a0v8CLQVjlNpFwNEAUjehTOxq/0g4ie6styORmilT
         /079o7/JOomYpLOunfKaBg4KulltNLyrJF5r8TSHtXVONuvcFLzbjBMMZi2vGW2700FB
         E0qQ==
X-Gm-Message-State: ACrzQf0G9fkSVI87gt1cQxBl2QKYDLSxZVu2EIHUNygdc1/5OjGE0quq
        ZokFQ//XCV+cpnofbNaiRhWXm2S9WwKa4sb9
X-Google-Smtp-Source: AMsMyM7WOjjRQFkgArn2vZnz2saQ3uTi4KK7NgzqqTPbUTg5NYihLLVoEFDFckOztJWr9U7D5cSNzg==
X-Received: by 2002:a17:907:96a4:b0:783:8587:9119 with SMTP id hd36-20020a17090796a400b0078385879119mr15672730ejc.12.1664813666641;
        Mon, 03 Oct 2022 09:14:26 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id cy8-20020a0564021c8800b00459012e5145sm2610635edb.70.2022.10.03.09.14.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 09:14:25 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id b4so10521144wrs.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:14:25 -0700 (PDT)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr13920479wri.138.1664813664658; Mon, 03
 Oct 2022 09:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org> <20220930200529.331223-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930200529.331223-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Oct 2022 09:14:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaSAvppTqqsZzNh7x_VZ5pVPROLP4AinK2NEWMUPnoQw@mail.gmail.com>
Message-ID: <CAD=FV=UaSAvppTqqsZzNh7x_VZ5pVPROLP4AinK2NEWMUPnoQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Sep 30, 2022 at 1:06 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> The sdm854.dtsi file defined several pin configuration nodes which are
> customized by the boards.  Therefore keep a additional "default-pins"
> node inside so the boards can add more of configuration nodes.  Such
> additional configuration nodes always need 'function' property now
> (required by DT schema).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 344 +++++++-----------
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  76 ++--
>  .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 ++-
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  60 ++-
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  88 ++---
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 138 +++----
>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  26 +-
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  30 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 305 +++++++---------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  33 +-
>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  96 ++---
>  13 files changed, 513 insertions(+), 751 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index b5f11fbcc300..3403cdcdd49c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -993,21 +993,21 @@ &wifi {
>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>
>  &qspi_cs0 {
> -       pinconf {
> +       default-pins {
>                 pins = "gpio90";
>                 bias-disable;
>         };
>  };
>
>  &qspi_clk {
> -       pinconf {
> +       default-pins {
>                 pins = "gpio95";
>                 bias-disable;
>         };
>  };
>
>  &qspi_data01 {
> -       pinconf {
> +       default-pins {
>                 pins = "gpio91", "gpio92";

I haven't been fully involved in all the discussion here, but the
above doesn't look like it matches the way that Bjorn wanted to go
[1].  I would sorta expect it to look like this:

  /* QSPI always needs a clock and IO pins */
  qspi_basic: {
    qspi_clk: {
      pins = "gpio95";
      function = "qspi_clk";
    };
    qspi_data01: {
      pins = "gpio95";
      function = "qspi_clk";
    };
  }

  /* QSPI will need one or both chip selects */
  qspi_cs0: qspi-cs0-state {
    pins = "gpio90";
    function = "qspi_cs";
  };

  qspi_cs1: qspi-cs1-state {
    pins = "gpio89";
    function = "qspi_cs";
  };

  /* If using all 4 data lines we need these */
  qspi_data12: qspi-data12-state {
    pins = "gpio93", "gpio94";
    function = "qspi_data";
  };

Basically grouping things together in a two-level node when it makes
sense and then using 1-level nodes for "mixin" pins. Then you'd end up
doing one of these things:

pinctrl-0 = <&qspi_basic &qspi_cs0>;
pinctrl-0 = <&qspi_basic &qspi_cs1>;
pinctrl-0 = <&qspi_basic &qspi_cs0 &qspi_data12>;

Note that the extra tags of "qspi_clk" and "qspi_data01" are important
since it lets the individual boards easily set pulls / drive strengths
without needing to replicate the hierarchy of the SoC. So if a board
wanted to set the pull of the cs0 line, just:

&qspi_cs0 {
  bias-disable;
};

[1] https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/


> @@ -1016,7 +1016,7 @@ pinconf {
>  };
>
>  &qup_i2c3_default {
> -       pinconf {
> +       default-pins {
>                 pins = "gpio41", "gpio42";
>                 drive-strength = <2>;

I don't see any benefit to two-levels above. Why not just get rid of
the "default-pins" and put the stuff directly under qup_i2c3_default?


>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>  &qup_spi2_default {
> -       pinmux {
> +       default-pins {
>                 drive-strength = <16>;
>         };
>  };
>
>  &qup_uart3_default{
> -       pinmux {
> +       default-pins {
>                 pins = "gpio41", "gpio42", "gpio43", "gpio44";
>                 function = "qup3";
>         };
>  };
>
>  &qup_i2c10_default {
> -       pinconf {
> +       default-pins {
>                 pins = "gpio55", "gpio56";
>                 drive-strength = <2>;
>                 bias-disable;
> @@ -1144,37 +1144,37 @@ pinconf {
>  };
>
>  &qup_uart6_default {
> -       pinmux {
> -               pins = "gpio45", "gpio46", "gpio47", "gpio48";
> -               function = "qup6";
> -       };
> -
> -       cts {
> +       cts-pins {
>                 pins = "gpio45";
> +               function = "qup6";
>                 bias-disable;
>         };
>
> -       rts-tx {
> +       rts-tx-pins {
>                 pins = "gpio46", "gpio47";
> +               function = "qup6";
>                 drive-strength = <2>;
>                 bias-disable;
>         };
>
> -       rx {
> +       rx-pins {
>                 pins = "gpio48";
> +               function = "qup6";
>                 bias-pull-up;
>         };
>  };

I didn't check everything about this patch, but skimming through I
believe that the uart6 handling here is wrong. You'll end up with:

  qup_uart6_default: qup-uart6-default-state {
    default-pins {
      pins = "gpio47", "gpio48";
      function = "qup6";
    };

    cts-pins {
      pins = "gpio45";
      function = "qup6";
      bias-disable;
    };

    rts-tx-pins {
      pins = "gpio46", "gpio47";
      function = "qup6";
      drive-strength = <2>;
      bias-disable;
    };

    rx-pins {
      pins = "gpio48";
      function = "qup6";
      bias-pull-up;
    };
  };

So pins 47 and 48 are each referenced in two nodes. That doesn't seem
correct to me. IMO, better would have been:

In Soc.dtsi:

  qup_uart6_txrx: qup-uart6-txrx-state {
    qup_uart6_tx {
      pins = "gpio47";
      function = "qup6";
    };
    qup_uart6_rx {
      pins = "gpio48";
      function = "qup6";
    };
  };
  qup_uart6_cts: qup-uart6-cts-state {
    pins = "gpio45";
    function = "qup6";
  };
  qup_uart6_rts: qup-uart6-rts-state {
    pins = "gpio46";
    function = "qup6";
  };

In board.dts:

  &qup_uart6_cts {
    bias-disable;
  };
  &qup_uart6_rts {
    drive-strength = <2>;
    bias-disable;
  };
  &qup_uart6_rx {
    bias-pull-up;
  };
  &qup_uart6_tx {
    drive-strength = <2>;
    bias-disable;
  };

Also, as per latest agreement with Bjorn, we should be moving the
default drive strength to the SoC.dtsi file, so going further:

In Soc.dtsi:

  qup_uart6_txrx: qup-uart6-txrx-state {
    qup_uart6_tx {
      pins = "gpio47";
      function = "qup6";
      drive-strength = <2>;
    };
    qup_uart6_rx {
      pins = "gpio48";
      function = "qup6";
    };
  };
  qup_uart6_cts: qup-uart6-cts-state {
    pins = "gpio45";
    function = "qup6";
  };
  qup_uart6_rts: qup-uart6-rts-state {
    pins = "gpio46";
    function = "qup6";
    drive-strength = <2>;
  };

In board.dts:

  &qup_uart6_cts {
    bias-disable;
  };
  &qup_uart6_rts {
    bias-disable;
  };
  &qup_uart6_rx {
    bias-pull-up;
  };
  &qup_uart6_tx {
    bias-disable;
  };

In the SoC.dtsi file we could default to just a tx/rx config:

pinctrl-0 = <&qup_uart6_txrx>;

...if a board had the flow control lines hooked up, it could do:

pinctrl-0 = <&qup_uart6_txrx &qup_uart6_cts &qup_uart6_rts>;

-Doug
