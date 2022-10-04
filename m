Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B98E5F45FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJDOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJDOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:55:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5AA27CD3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:55:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a2so9328663ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sllxcjZJDpLnHPCaf6ObC6W/uORodwFVD/CnsDhixck=;
        b=B7/qQ3K6Weu1ofGqjv58LhKlxCJMHYdX2+p57SXeD/zaSe9/nWIDTkXWEbelwTqCp7
         FbpzGKcr35y+5m+PpBFxLTlzi7lvRGnq2gwFjTzPqKRL5GZHfBe5UscqZ+prOX53O29N
         vMn6LP3mta+Dd27oWfPv5Z0KwWm4fHEnRiPSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sllxcjZJDpLnHPCaf6ObC6W/uORodwFVD/CnsDhixck=;
        b=CKnrHPl7bInn0NPmebYAZOlSnr4Oa7Ja9Zpd/DKNz2gbZRy0Nd0MUqnX4IDsECfek6
         9kZXpm4iLyDk4VjU1EmEShW0l4l7u6Q6GVj/kioawII4mPdCpm2BCdsDrYJN/IbLOSpr
         2VqEhwPrFdnCFBHP8CTw6l9XYb5GPhk4za7HUAX5Z3m/W0s3HYBVQJ+4YyY/rc5snVoX
         1d5qi7DhLP9av5V4y6oqLMV431mByVAmMRMHGpVKUvRk87GraWKbduobNVyaTrW6H4lH
         GR5SaQfrTFK1vph1Ev/sMbHukIVRxW7F0lan56JakMMtYq8zug72JYKDD6CcxxSQm+si
         kBlQ==
X-Gm-Message-State: ACrzQf2iXbVquQ7HvZUr1FD8Y3jZ2N16Eaa9d/zO44/V48kzvFDqsGa/
        YxLaR21nWUQ4oGMgC5wexeqIbjhJSxD66ZzF
X-Google-Smtp-Source: AMsMyM4kfb9nhn+uMNY7TMO8Lopw6wbWEm2wNxrhNtGQP8dipCd7LoHbV6e4l99zZjk+RIrL/tR3wg==
X-Received: by 2002:a17:907:6d13:b0:787:eec8:d178 with SMTP id sa19-20020a1709076d1300b00787eec8d178mr17271360ejc.53.1664895326539;
        Tue, 04 Oct 2022 07:55:26 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906314600b007389c5a45f0sm7256839eje.148.2022.10.04.07.55.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:55:25 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bq9so21726959wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:55:24 -0700 (PDT)
X-Received: by 2002:adf:dd0c:0:b0:22e:4bf6:6c08 with SMTP id
 a12-20020adfdd0c000000b0022e4bf66c08mr2793446wrm.617.1664895324390; Tue, 04
 Oct 2022 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-2-krzysztof.kozlowski@linaro.org> <CAD=FV=UaSAvppTqqsZzNh7x_VZ5pVPROLP4AinK2NEWMUPnoQw@mail.gmail.com>
 <985e3982-e9c6-53d0-1aa8-7c8f7726926a@linaro.org> <CAD=FV=WgZLztJUxxs0B-kTnT4cN=kKc24if+P0h7whW54S57aQ@mail.gmail.com>
 <6c20f710-e02e-1702-3985-4e995f8a7e7a@linaro.org>
In-Reply-To: <6c20f710-e02e-1702-3985-4e995f8a7e7a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Oct 2022 07:55:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ushwp0AUrdwKrkKLxvsoCZsbSh-tAtXRQzcTavAEk8uA@mail.gmail.com>
Message-ID: <CAD=FV=Ushwp0AUrdwKrkKLxvsoCZsbSh-tAtXRQzcTavAEk8uA@mail.gmail.com>
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

On Tue, Oct 4, 2022 at 1:40 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/10/2022 00:59, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 3, 2022 at 10:45 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 03/10/2022 18:14, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Fri, Sep 30, 2022 at 1:06 PM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> DT schema expects TLMM pin configuration nodes to be named with
> >>>> '-state' suffix and their optional children with '-pins' suffix.
> >>>>
> >>>> The sdm854.dtsi file defined several pin configuration nodes which are
> >>>> customized by the boards.  Therefore keep a additional "default-pins"
> >>>> node inside so the boards can add more of configuration nodes.  Such
> >>>> additional configuration nodes always need 'function' property now
> >>>> (required by DT schema).
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 344 +++++++-----------
> >>>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  76 ++--
> >>>>  .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 ++-
> >>>>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
> >>>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  60 ++-
> >>>>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  88 ++---
> >>>>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 138 +++----
> >>>>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
> >>>>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  26 +-
> >>>>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  30 +-
> >>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 305 +++++++---------
> >>>>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  33 +-
> >>>>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  96 ++---
> >>>>  13 files changed, 513 insertions(+), 751 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> >>>> index b5f11fbcc300..3403cdcdd49c 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> >>>> @@ -993,21 +993,21 @@ &wifi {
> >>>>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
> >>>>
> >>>>  &qspi_cs0 {
> >>>> -       pinconf {
> >>>> +       default-pins {
> >>>>                 pins = "gpio90";
> >>>>                 bias-disable;
> >>>>         };
> >>>>  };
> >>>>
> >>>>  &qspi_clk {
> >>>> -       pinconf {
> >>>> +       default-pins {
> >>>>                 pins = "gpio95";
> >>>>                 bias-disable;
> >>>>         };
> >>>>  };
> >>>>
> >>>>  &qspi_data01 {
> >>>> -       pinconf {
> >>>> +       default-pins {
> >>>>                 pins = "gpio91", "gpio92";
> >>>
> >>> I haven't been fully involved in all the discussion here, but the
> >>> above doesn't look like it matches the way that Bjorn wanted to go
> >>> [1].  I would sorta expect it to look like this:
> >>>
> >>>   /* QSPI always needs a clock and IO pins */
> >>>   qspi_basic: {
> >>>     qspi_clk: {
> >>>       pins = "gpio95";
> >>>       function = "qspi_clk";
> >>>     };
> >>>     qspi_data01: {
> >>>       pins = "gpio95";
> >>>       function = "qspi_clk";
> >>>     };
> >>>   }
> >>>
> >>>   /* QSPI will need one or both chip selects */
> >>>   qspi_cs0: qspi-cs0-state {
> >>>     pins = "gpio90";
> >>>     function = "qspi_cs";
> >>>   };
> >>>
> >>>   qspi_cs1: qspi-cs1-state {
> >>>     pins = "gpio89";
> >>>     function = "qspi_cs";
> >>>   };
> >>>
> >>>   /* If using all 4 data lines we need these */
> >>>   qspi_data12: qspi-data12-state {
> >>>     pins = "gpio93", "gpio94";
> >>>     function = "qspi_data";
> >>>   };
> >>>
> >>> Basically grouping things together in a two-level node when it makes
> >>> sense and then using 1-level nodes for "mixin" pins. Then you'd end up
> >>> doing one of these things:
> >>>
> >>> pinctrl-0 = <&qspi_basic &qspi_cs0>;
> >>> pinctrl-0 = <&qspi_basic &qspi_cs1>;
> >>> pinctrl-0 = <&qspi_basic &qspi_cs0 &qspi_data12>;
> >>
> >>
> >> I don't get how my patch changes the existing approach? Such pattern was
> >> already there.
> >
> > Before your patch things were split in two nodes, the muxing and the
> > configuration. AKA when you combined the soc.dtsi and the board.dts
> > you'd have:
> >
> > qspi_cs0: qspi-cs0-state {
> >   pinmux {
> >     pins = "...";
> >     ... muxing properties ...
> >   };
> >   pinconf {
> >     pins = "...";
> >     ... config properties ...
> >   };
> > };
>
> Which was also not good pattern. Muxing and configuring is basically the
> same function of pin controller. Splitting them makes no sense at all.

Agreed, it was not a good pattern.


> > Your patch combines the "pinmux" and "pinconf" nodes into one. So when
> > you combine the soc.dtsi and the board.dts after your patch you now
> > have:
> >
> > qspi_cs0: qspi-cs0-state {
> >   default-pins {
> >     pins = "...";
> >     ... muxing properties ...
> >     ... config properties ...
> >   };
> > };
> >
> >
> > That's fine and is functionally correct. ...but IMO it sets a bad
> > example for people to follow (though, of course, it's really up to
> > Bjorn). The "default-pins" subnode serves no purpose. If you're
> > touching all this stuff anyway you might as well not end up with
> > something that's a bad example for people to follow.
>
> I understand, you're right. I wanted to keep minimal amount of changes
> to the DTS layout but since I am touching almost everything, I can
> rework it.
>
>
> >> Again - you end up or you ended up? We discuss here what this patch did.
> >> So are you sure that this patch did something like that (and it wasn't
> >> already there)?
> >>
> >>>
> >>> Note that the extra tags of "qspi_clk" and "qspi_data01" are important
> >>> since it lets the individual boards easily set pulls / drive strengths
> >>> without needing to replicate the hierarchy of the SoC. So if a board
> >>> wanted to set the pull of the cs0 line, just:
> >>>
> >>> &qspi_cs0 {
> >>>   bias-disable;
> >>> };
> >>>
> >>> [1] https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
> >>>
> >>>
> >>>> @@ -1016,7 +1016,7 @@ pinconf {
> >>>>  };
> >>>>
> >>>>  &qup_i2c3_default {
> >>>> -       pinconf {
> >>>> +       default-pins {
> >>>>                 pins = "gpio41", "gpio42";
> >>>>                 drive-strength = <2>;
> >>>
> >>> I don't see any benefit to two-levels above. Why not just get rid of
> >>> the "default-pins" and put the stuff directly under qup_i2c3_default?
> >>
> >> For the same reason I told Konrad?
> >
> > OK. I looked at what you end up with for "qup_uart9" after your
> > patches and it's definitely not my favorite place to end up at. If
> > nothing else you are double-specifying "function" in both
> > "default-pins" and "tx-pins"/"rx-pins". If those disagree then what
> > happens?
>
> The same happens and happened before. My patch does nothing related to
> allowing or disallowing wrong muxing/config nodes. In the past you could
> have conflicting setups. Now it's exactly the same.

Right that you could have had conflicting setups before, too. However,
in the past we always avoided specifying the function for a given pin
in more than one node.

The old way was super verbose and had a lot of repetition for sure,
but it sorta made sense if you thought of it in words. AKA the old way
said this after combining the soc.dtsi and the board.dts

* For pins 45, 46, 47, 48: set the function to "qup6"
* For pin 45: set a pulldown
* For pins 46 and 47: set the drive strength to 2 and disable pulls
* For pin 48: set a pullup

So it repeated the "for pins" part and that was most definitely non
ideal. However, with your new setup you are sometimes doing:

* For pins 47 and 48: set the function to "qup6"
* For pin 45: set the function to "qup6" and set a pulldown
* For pins 46 and 47: set the function to "qup6" and the drive
strength to 2 and disable pulls
* For pin 48: set the function to "qup6" and set a pullup

That repeats the 'set the function to "qup6"' more than I'd like.


> The double-specifying of "function" is not a result of '-state'/'-pins'
> reorganization but aligning with common TLMM schema *which requires
> function* for every node.

I guess now that we've talked through it, I'd say that if we have to
specify a function for every node then we should strive for each pin
to be in exactly one node in any given active configuration. That
makes the schema happy and also avoids double-specifying the function.

I think in all of the examples I've given that this is true.


> > In general also we end up specifying that extra level of
> > "default-pins" in many cases for no purpose. We also end up
> > replicating hierarchy in the board dts files (the dts files are
> > replicating the "default-pins" nodes from the parent).
>
> OK, let's fix this. That will need either:
> 1. /delete-node with copying of most of properties from default-pins
> 2. or move the CTS/TX/RX config pins to the DTSI.

I think in my proposal the CTS/TX/RX stuff moved to the dtsi which solved it.


> >>>>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
> >>>>  &qup_spi2_default {
> >>>> -       pinmux {
> >>>> +       default-pins {
> >>>>                 drive-strength = <16>;
> >>>>         };
> >>>>  };
> >>>>
> >>>>  &qup_uart3_default{
> >>>> -       pinmux {
> >>>> +       default-pins {
> >>>>                 pins = "gpio41", "gpio42", "gpio43", "gpio44";
> >>>>                 function = "qup3";
> >>>>         };
> >>>>  };
> >>>>
> >>>>  &qup_i2c10_default {
> >>>> -       pinconf {
> >>>> +       default-pins {
> >>>>                 pins = "gpio55", "gpio56";
> >>>>                 drive-strength = <2>;
> >>>>                 bias-disable;
> >>>> @@ -1144,37 +1144,37 @@ pinconf {
> >>>>  };
> >>>>
> >>>>  &qup_uart6_default {
> >>>> -       pinmux {
> >>>> -               pins = "gpio45", "gpio46", "gpio47", "gpio48";
> >>>> -               function = "qup6";
> >>>> -       };
> >>>> -
> >>>> -       cts {
> >>>> +       cts-pins {
> >>>>                 pins = "gpio45";
> >>>> +               function = "qup6";
> >>>>                 bias-disable;
> >>>>         };
> >>>>
> >>>> -       rts-tx {
> >>>> +       rts-tx-pins {
> >>>>                 pins = "gpio46", "gpio47";
> >>>> +               function = "qup6";
> >>>>                 drive-strength = <2>;
> >>>>                 bias-disable;
> >>>>         };
> >>>>
> >>>> -       rx {
> >>>> +       rx-pins {
> >>>>                 pins = "gpio48";
> >>>> +               function = "qup6";
> >>>>                 bias-pull-up;
> >>>>         };
> >>>>  };
> >>>
> >>> I didn't check everything about this patch, but skimming through I
> >>> believe that the uart6 handling here is wrong. You'll end up with:>
> >>>   qup_uart6_default: qup-uart6-default-state {
> >>>     default-pins {
> >>>       pins = "gpio47", "gpio48";
> >>>       function = "qup6";
> >>
> >> This piece was removed.
> >
> > It was? How/where? I tried applying your patch and I still see "qup6"
> > under the default-pins node in sdm845.dtsi.
> >
>
> Ah, you're right. The default-pins are coming from DTSI.
>
> So delete-node?

I would prefer the solution I proposed. Re-pasting here:

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


> >>>     };
> >>>
> >>>     cts-pins {
> >>>       pins = "gpio45";
> >>>       function = "qup6";
> >>>       bias-disable;
> >>>     };
> >>>
> >>>     rts-tx-pins {
> >>>       pins = "gpio46", "gpio47";
> >>>       function = "qup6";
> >>>       drive-strength = <2>;
> >>>       bias-disable;
> >>>     };
> >>>
> >>>     rx-pins {
> >>>       pins = "gpio48";
> >>>       function = "qup6";
> >>>       bias-pull-up;
> >>>     };
> >>>   };
> >>>
> >>> So pins 47 and 48 are each referenced in two nodes. That doesn't seem
> >>> correct to me. IMO, better would have been:
> >>
> >> Even though that particular piece was removed, so there is no double
> >> reference, it would still be correct. Or rather - what is there
> >> incorrect? Mentioning pin twice? This is ok, although not necessarily
> >> the most readable.
> >
> > I guess this gets into the corners of pinctrl that I haven't poked at
> > lots. I guess it should be OK unless the SoC.dtsi and the board.dts
> > disagree about the "function". In such a case I guess it would be a
> > problem. So I guess what you end up will be OK but I don't like that
> > "function" is specified for the same pin in two different sub-nodes.
>
> OK.
>
> >
> >
> >>> In Soc.dtsi:
> >>>
> >>>   qup_uart6_txrx: qup-uart6-txrx-state {
> >>>     qup_uart6_tx {
> >>>       pins = "gpio47";
> >>>       function = "qup6";
> >>>     };
> >>>     qup_uart6_rx {
> >>>       pins = "gpio48";
> >>>       function = "qup6";
> >>>     };
> >>>   };
> >>>   qup_uart6_cts: qup-uart6-cts-state {
> >>>     pins = "gpio45";
> >>>     function = "qup6";
> >>>   };
> >>>   qup_uart6_rts: qup-uart6-rts-state {
> >>>     pins = "gpio46";
> >>>     function = "qup6";
> >>>   };
> >>>
> >>> In board.dts:
> >>>
> >>>   &qup_uart6_cts {
> >>>     bias-disable;
> >>>   };
> >>>   &qup_uart6_rts {
> >>>     drive-strength = <2>;
> >>>     bias-disable;
> >>>   };
> >>>   &qup_uart6_rx {
> >>>     bias-pull-up;
> >>>   };
> >>>   &qup_uart6_tx {
> >>>     drive-strength = <2>;
> >>>     bias-disable;
> >>
> >> It's not related to this patchset, but sounds good, please change the
> >> DTS to match it. I can rebase my patch on top of it.
> >
> > I guess it's related in that the patchset is touching everything and
> > one would assume that something touched so recently would represent
> > the current best practices. Maybe that's a weak argument, but if I saw
> > a patch that was about trying to clean up all the pinctrl across all
> > the older SoCs that I would assume that the pinctrl would be clean
> > after that patch and would be a good example to follow as best
> > practice. Thus it's relevant to talk about whether this patch is
> > ending us up at best practice or not.
> >
> >
> >>>   };
> >>>
> >>> Also, as per latest agreement with Bjorn, we should be moving the
> >>> default drive strength to the SoC.dtsi file, so going further:
> >>
> >> How is it related to this patch? Sure, feel free to move drive strength
> >> anywhere. We can discuss it. But it is not part of this patch.
> >
> > Moving the drive strength can certainly be discussed / done in a later patch.
> >
> >
> >>> In Soc.dtsi:
> >>>
> >>>   qup_uart6_txrx: qup-uart6-txrx-state {
> >>>     qup_uart6_tx {
> >>>       pins = "gpio47";
> >>>       function = "qup6";
> >>>       drive-strength = <2>;
> >>>     };
> >>>     qup_uart6_rx {
> >>>       pins = "gpio48";
> >>>       function = "qup6";
> >>>     };
> >>>   };
> >>>   qup_uart6_cts: qup-uart6-cts-state {
> >>>     pins = "gpio45";
> >>>     function = "qup6";
> >>>   };
> >>>   qup_uart6_rts: qup-uart6-rts-state {
> >>>     pins = "gpio46";
> >>>     function = "qup6";
> >>>     drive-strength = <2>;
> >>
> >> These are not part of DTSI. They exist in DTS, not in DTSI. You now
> >> introduce a change entirely different than this patchset is doing. It
> >> makes sense on its own, but it is not related to this patchset.
> >
> > It is relevant to discuss because it would be the correct way to solve
> > the same issue with "uart9" that you used to justify why you needed an
> > extra "uart9-default" subnode.
>
> The goal of this patchset is to solve dtbs_check. It's goal is not
> "generic guidance how Qualcomm pin configuration nodes should be
> written", because whatever you and I agree, it does not much matter. The
> maintainers decision matter.
>
> If there is a consensus/preferred way to organize it, sure, document it
> somewhere, store it in email/lore in concise way, and I can fix up the
> patch to match it. It is just not my goal now, so I am not pushing
> towards any such direction.
>
> Best regards,
> Krzysztof
>
