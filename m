Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002AA5F3976
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJCW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJCW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:59:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE3345F40
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:59:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z97so16550870ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=17zljRZyrHJPZEaO8SoIB3R5UuxYCo2oLIqLhEH5Yqk=;
        b=QBiI5PxZsX4XKrpah5IF0/PnyPRkgSEGFwgpDdhnR2vmlxytOKx1fCHpDBoeJjOMWH
         1QA+ODpKnm6W7bngZIwVmknteIjrgkGSnY3WMEEalrEAMBPumSOzlmLL6TM/VNAZ4YIH
         yPrx7ht7l6GPGbn1KOsVHmErr7VlMBHR+9qcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=17zljRZyrHJPZEaO8SoIB3R5UuxYCo2oLIqLhEH5Yqk=;
        b=Kdp1tbIqdGHR4oGE+wxnc8cr9oKgo/Uo2lxwOqi14MHnkyrfR3iSOY5mbgSx0cQIPU
         VabSOkw6Tcy2s5Rt4Ub3hTc7ZYOKlnjeB48IyoCePgIoJM0fdP9MPZoPuAyAy3Ow8qWZ
         7hqXV8q0xBpQv4+0t4hi+J6Ir2TcaVYeU52HZSQIBDebzyqz4mD68JUWbiYroy5yDlBZ
         0wNowCcjwwLrEiipXie0W7uVZQeDHsGLNQDBdgNcNiuqlY/u9SYAWU5BKVbOOZOEPrK7
         W9s7BmU5eUPhI75rT1sUorIQJFvH41KDc1N+TMFhbGoN5gMZUUCCNU07uFUSTvvjLCoC
         wR7g==
X-Gm-Message-State: ACrzQf39sM2rK6qpFwiZFMGoSBH2j9T7ZjL3XJAbswJ/yr7N3eTUpBgE
        A8a1vSFHCzIEvn9OkwWWsvMLq5JuWtI/nBNi
X-Google-Smtp-Source: AMsMyM513adtpLFKix8bLMzLxzt5dGE3TRuHH6adwG7PmrmYMrIsZRafZ5kYCq9Qit2s6Z/WXU+ewQ==
X-Received: by 2002:a05:6402:548f:b0:457:ed40:5f58 with SMTP id fg15-20020a056402548f00b00457ed405f58mr20579674edb.408.1664837963988;
        Mon, 03 Oct 2022 15:59:23 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id f13-20020a17090660cd00b0077a7c01f263sm6030113ejk.88.2022.10.03.15.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 15:59:23 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id j7so13412524wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:59:22 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr14320673wrr.583.1664837962280; Mon, 03
 Oct 2022 15:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-2-krzysztof.kozlowski@linaro.org> <CAD=FV=UaSAvppTqqsZzNh7x_VZ5pVPROLP4AinK2NEWMUPnoQw@mail.gmail.com>
 <985e3982-e9c6-53d0-1aa8-7c8f7726926a@linaro.org>
In-Reply-To: <985e3982-e9c6-53d0-1aa8-7c8f7726926a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Oct 2022 15:59:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgZLztJUxxs0B-kTnT4cN=kKc24if+P0h7whW54S57aQ@mail.gmail.com>
Message-ID: <CAD=FV=WgZLztJUxxs0B-kTnT4cN=kKc24if+P0h7whW54S57aQ@mail.gmail.com>
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

On Mon, Oct 3, 2022 at 10:45 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/10/2022 18:14, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Sep 30, 2022 at 1:06 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> DT schema expects TLMM pin configuration nodes to be named with
> >> '-state' suffix and their optional children with '-pins' suffix.
> >>
> >> The sdm854.dtsi file defined several pin configuration nodes which are
> >> customized by the boards.  Therefore keep a additional "default-pins"
> >> node inside so the boards can add more of configuration nodes.  Such
> >> additional configuration nodes always need 'function' property now
> >> (required by DT schema).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 344 +++++++-----------
> >>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  76 ++--
> >>  .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 ++-
> >>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
> >>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  60 ++-
> >>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  88 ++---
> >>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 138 +++----
> >>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
> >>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  26 +-
> >>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  30 +-
> >>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 305 +++++++---------
> >>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  33 +-
> >>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  96 ++---
> >>  13 files changed, 513 insertions(+), 751 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> >> index b5f11fbcc300..3403cdcdd49c 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> >> @@ -993,21 +993,21 @@ &wifi {
> >>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
> >>
> >>  &qspi_cs0 {
> >> -       pinconf {
> >> +       default-pins {
> >>                 pins = "gpio90";
> >>                 bias-disable;
> >>         };
> >>  };
> >>
> >>  &qspi_clk {
> >> -       pinconf {
> >> +       default-pins {
> >>                 pins = "gpio95";
> >>                 bias-disable;
> >>         };
> >>  };
> >>
> >>  &qspi_data01 {
> >> -       pinconf {
> >> +       default-pins {
> >>                 pins = "gpio91", "gpio92";
> >
> > I haven't been fully involved in all the discussion here, but the
> > above doesn't look like it matches the way that Bjorn wanted to go
> > [1].  I would sorta expect it to look like this:
> >
> >   /* QSPI always needs a clock and IO pins */
> >   qspi_basic: {
> >     qspi_clk: {
> >       pins = "gpio95";
> >       function = "qspi_clk";
> >     };
> >     qspi_data01: {
> >       pins = "gpio95";
> >       function = "qspi_clk";
> >     };
> >   }
> >
> >   /* QSPI will need one or both chip selects */
> >   qspi_cs0: qspi-cs0-state {
> >     pins = "gpio90";
> >     function = "qspi_cs";
> >   };
> >
> >   qspi_cs1: qspi-cs1-state {
> >     pins = "gpio89";
> >     function = "qspi_cs";
> >   };
> >
> >   /* If using all 4 data lines we need these */
> >   qspi_data12: qspi-data12-state {
> >     pins = "gpio93", "gpio94";
> >     function = "qspi_data";
> >   };
> >
> > Basically grouping things together in a two-level node when it makes
> > sense and then using 1-level nodes for "mixin" pins. Then you'd end up
> > doing one of these things:
> >
> > pinctrl-0 = <&qspi_basic &qspi_cs0>;
> > pinctrl-0 = <&qspi_basic &qspi_cs1>;
> > pinctrl-0 = <&qspi_basic &qspi_cs0 &qspi_data12>;
>
>
> I don't get how my patch changes the existing approach? Such pattern was
> already there.

Before your patch things were split in two nodes, the muxing and the
configuration. AKA when you combined the soc.dtsi and the board.dts
you'd have:

qspi_cs0: qspi-cs0-state {
  pinmux {
    pins = "...";
    ... muxing properties ...
  };
  pinconf {
    pins = "...";
    ... config properties ...
  };
};

Your patch combines the "pinmux" and "pinconf" nodes into one. So when
you combine the soc.dtsi and the board.dts after your patch you now
have:

qspi_cs0: qspi-cs0-state {
  default-pins {
    pins = "...";
    ... muxing properties ...
    ... config properties ...
  };
};


That's fine and is functionally correct. ...but IMO it sets a bad
example for people to follow (though, of course, it's really up to
Bjorn). The "default-pins" subnode serves no purpose. If you're
touching all this stuff anyway you might as well not end up with
something that's a bad example for people to follow.



> Again - you end up or you ended up? We discuss here what this patch did.
> So are you sure that this patch did something like that (and it wasn't
> already there)?
>
> >
> > Note that the extra tags of "qspi_clk" and "qspi_data01" are important
> > since it lets the individual boards easily set pulls / drive strengths
> > without needing to replicate the hierarchy of the SoC. So if a board
> > wanted to set the pull of the cs0 line, just:
> >
> > &qspi_cs0 {
> >   bias-disable;
> > };
> >
> > [1] https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
> >
> >
> >> @@ -1016,7 +1016,7 @@ pinconf {
> >>  };
> >>
> >>  &qup_i2c3_default {
> >> -       pinconf {
> >> +       default-pins {
> >>                 pins = "gpio41", "gpio42";
> >>                 drive-strength = <2>;
> >
> > I don't see any benefit to two-levels above. Why not just get rid of
> > the "default-pins" and put the stuff directly under qup_i2c3_default?
>
> For the same reason I told Konrad?

OK. I looked at what you end up with for "qup_uart9" after your
patches and it's definitely not my favorite place to end up at. If
nothing else you are double-specifying "function" in both
"default-pins" and "tx-pins"/"rx-pins". If those disagree then what
happens?

In general also we end up specifying that extra level of
"default-pins" in many cases for no purpose. We also end up
replicating hierarchy in the board dts files (the dts files are
replicating the "default-pins" nodes from the parent).


> >>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
> >>  &qup_spi2_default {
> >> -       pinmux {
> >> +       default-pins {
> >>                 drive-strength = <16>;
> >>         };
> >>  };
> >>
> >>  &qup_uart3_default{
> >> -       pinmux {
> >> +       default-pins {
> >>                 pins = "gpio41", "gpio42", "gpio43", "gpio44";
> >>                 function = "qup3";
> >>         };
> >>  };
> >>
> >>  &qup_i2c10_default {
> >> -       pinconf {
> >> +       default-pins {
> >>                 pins = "gpio55", "gpio56";
> >>                 drive-strength = <2>;
> >>                 bias-disable;
> >> @@ -1144,37 +1144,37 @@ pinconf {
> >>  };
> >>
> >>  &qup_uart6_default {
> >> -       pinmux {
> >> -               pins = "gpio45", "gpio46", "gpio47", "gpio48";
> >> -               function = "qup6";
> >> -       };
> >> -
> >> -       cts {
> >> +       cts-pins {
> >>                 pins = "gpio45";
> >> +               function = "qup6";
> >>                 bias-disable;
> >>         };
> >>
> >> -       rts-tx {
> >> +       rts-tx-pins {
> >>                 pins = "gpio46", "gpio47";
> >> +               function = "qup6";
> >>                 drive-strength = <2>;
> >>                 bias-disable;
> >>         };
> >>
> >> -       rx {
> >> +       rx-pins {
> >>                 pins = "gpio48";
> >> +               function = "qup6";
> >>                 bias-pull-up;
> >>         };
> >>  };
> >
> > I didn't check everything about this patch, but skimming through I
> > believe that the uart6 handling here is wrong. You'll end up with:>
> >   qup_uart6_default: qup-uart6-default-state {
> >     default-pins {
> >       pins = "gpio47", "gpio48";
> >       function = "qup6";
>
> This piece was removed.

It was? How/where? I tried applying your patch and I still see "qup6"
under the default-pins node in sdm845.dtsi.


> >     };
> >
> >     cts-pins {
> >       pins = "gpio45";
> >       function = "qup6";
> >       bias-disable;
> >     };
> >
> >     rts-tx-pins {
> >       pins = "gpio46", "gpio47";
> >       function = "qup6";
> >       drive-strength = <2>;
> >       bias-disable;
> >     };
> >
> >     rx-pins {
> >       pins = "gpio48";
> >       function = "qup6";
> >       bias-pull-up;
> >     };
> >   };
> >
> > So pins 47 and 48 are each referenced in two nodes. That doesn't seem
> > correct to me. IMO, better would have been:
>
> Even though that particular piece was removed, so there is no double
> reference, it would still be correct. Or rather - what is there
> incorrect? Mentioning pin twice? This is ok, although not necessarily
> the most readable.

I guess this gets into the corners of pinctrl that I haven't poked at
lots. I guess it should be OK unless the SoC.dtsi and the board.dts
disagree about the "function". In such a case I guess it would be a
problem. So I guess what you end up will be OK but I don't like that
"function" is specified for the same pin in two different sub-nodes.


> > In Soc.dtsi:
> >
> >   qup_uart6_txrx: qup-uart6-txrx-state {
> >     qup_uart6_tx {
> >       pins = "gpio47";
> >       function = "qup6";
> >     };
> >     qup_uart6_rx {
> >       pins = "gpio48";
> >       function = "qup6";
> >     };
> >   };
> >   qup_uart6_cts: qup-uart6-cts-state {
> >     pins = "gpio45";
> >     function = "qup6";
> >   };
> >   qup_uart6_rts: qup-uart6-rts-state {
> >     pins = "gpio46";
> >     function = "qup6";
> >   };
> >
> > In board.dts:
> >
> >   &qup_uart6_cts {
> >     bias-disable;
> >   };
> >   &qup_uart6_rts {
> >     drive-strength = <2>;
> >     bias-disable;
> >   };
> >   &qup_uart6_rx {
> >     bias-pull-up;
> >   };
> >   &qup_uart6_tx {
> >     drive-strength = <2>;
> >     bias-disable;
>
> It's not related to this patchset, but sounds good, please change the
> DTS to match it. I can rebase my patch on top of it.

I guess it's related in that the patchset is touching everything and
one would assume that something touched so recently would represent
the current best practices. Maybe that's a weak argument, but if I saw
a patch that was about trying to clean up all the pinctrl across all
the older SoCs that I would assume that the pinctrl would be clean
after that patch and would be a good example to follow as best
practice. Thus it's relevant to talk about whether this patch is
ending us up at best practice or not.


> >   };
> >
> > Also, as per latest agreement with Bjorn, we should be moving the
> > default drive strength to the SoC.dtsi file, so going further:
>
> How is it related to this patch? Sure, feel free to move drive strength
> anywhere. We can discuss it. But it is not part of this patch.

Moving the drive strength can certainly be discussed / done in a later patch.


> > In Soc.dtsi:
> >
> >   qup_uart6_txrx: qup-uart6-txrx-state {
> >     qup_uart6_tx {
> >       pins = "gpio47";
> >       function = "qup6";
> >       drive-strength = <2>;
> >     };
> >     qup_uart6_rx {
> >       pins = "gpio48";
> >       function = "qup6";
> >     };
> >   };
> >   qup_uart6_cts: qup-uart6-cts-state {
> >     pins = "gpio45";
> >     function = "qup6";
> >   };
> >   qup_uart6_rts: qup-uart6-rts-state {
> >     pins = "gpio46";
> >     function = "qup6";
> >     drive-strength = <2>;
>
> These are not part of DTSI. They exist in DTS, not in DTSI. You now
> introduce a change entirely different than this patchset is doing. It
> makes sense on its own, but it is not related to this patchset.

It is relevant to discuss because it would be the correct way to solve
the same issue with "uart9" that you used to justify why you needed an
extra "uart9-default" subnode.


> >   };
> >
> > In board.dts:
> >
> >   &qup_uart6_cts {
> >     bias-disable;
> >   };
> >   &qup_uart6_rts {
> >     bias-disable;
> >   };
> >   &qup_uart6_rx {
> >     bias-pull-up;
> >   };
> >   &qup_uart6_tx {
> >     bias-disable;
> >   };
> >
> > In the SoC.dtsi file we could default to just a tx/rx config:
> >
> > pinctrl-0 = <&qup_uart6_txrx>;
> >
> > ...if a board had the flow control lines hooked up, it could do:
> >
> > pinctrl-0 = <&qup_uart6_txrx &qup_uart6_cts &qup_uart6_rts>;
>
>
> Best regards,
> Krzysztof
>
