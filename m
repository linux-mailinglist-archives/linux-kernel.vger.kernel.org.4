Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420345FDCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJMPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJMPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:12:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7110F882
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:12:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot12so4657042ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jztp4lg3b2xKFx2QMEAmueYlDHz1ngS/iTxMN5MMQKI=;
        b=BzrrUqdowfxFsgNus7ZHX0WuY+Ai1wcUKWh6xCffhziV8sE3wopDACnnjMhxtCGOoU
         i/3k+OLLlJOHe2bPXTH65OS7DTjfkpnXF0keXt5fBgLbraRCbtjQyIZsxsB4sGiAPyqF
         eSeyN0ArXOiSI2tnEFa/Wvld7vIzKK+SVCtiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jztp4lg3b2xKFx2QMEAmueYlDHz1ngS/iTxMN5MMQKI=;
        b=ZTnkSY31aBmv1u0y+dH5/tP/vayASjGNXOes5Q8Qe82O3k1sgqC3CNvw2cEpiuzHFQ
         AXagbHK5KSCBPyPajkNMLZPlnkzQR9Lif466vOQ+DtGDFRUiaop1RYwmnCfiemL0vHR0
         aCJlNyXw4ed+QQ52uZWe1KM2Q0WUeAvoSmdifBcm4KwHvYXoBMOGk/tYfSyqGNwi7VbD
         D/4P6ENNxYz/Iw16AIGzdiydrfEyulzR+00jztQEgHMWXZXHFCwzv8GzJcVOiTZ+pnyu
         7JAtwHPR0im6QjiEzJQ3P5liRdJ75GCaI6XtT8rKuTPZoqEc4k/nowLjqH94jzu6YuBF
         1Gog==
X-Gm-Message-State: ACrzQf0B2exrsxSqLZ/t+hFJyis4GKXKoZavuyYz/3Fk35CiPx4P559w
        InfhIAYrL/E3o53weKBD93WgG2EPefujvLIh
X-Google-Smtp-Source: AMsMyM74tm84a6GfiqvmXg/fGr5lxjPyIN+IKjgUYQk+SPmAH95sEpLYJnXPFs0gPt0ei151buc23g==
X-Received: by 2002:a17:907:782:b0:740:7120:c6e7 with SMTP id xd2-20020a170907078200b007407120c6e7mr163446ejb.313.1665673926724;
        Thu, 13 Oct 2022 08:12:06 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id h2-20020a50ed82000000b00458dda85495sm24374edr.0.2022.10.13.08.12.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 08:12:05 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id n12so3303997wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:12:04 -0700 (PDT)
X-Received: by 2002:adf:dd0c:0:b0:22e:4bf6:6c08 with SMTP id
 a12-20020adfdd0c000000b0022e4bf66c08mr298544wrm.617.1665673924157; Thu, 13
 Oct 2022 08:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145116.46554-1-krzysztof.kozlowski@linaro.org>
 <CAD=FV=UAcn=yeCZ_jum9kGgqsdKsPpya-FPumYUWO=iyp-kKYw@mail.gmail.com> <4aa8450f-4504-c65e-56f1-0625584fb8cd@linaro.org>
In-Reply-To: <4aa8450f-4504-c65e-56f1-0625584fb8cd@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Oct 2022 08:11:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Va6xUtVEd0jgQF3+5OM6tQ=nW6xZeRatXULY3SUqAKBQ@mail.gmail.com>
Message-ID: <CAD=FV=Va6xUtVEd0jgQF3+5OM6tQ=nW6xZeRatXULY3SUqAKBQ@mail.gmail.com>
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

On Thu, Oct 13, 2022 at 7:59 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> >> index 1bd6c7dcd9e9..c66568a882b3 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> >> @@ -180,30 +180,19 @@ &wifi {
> >>  /* PINCTRL - modifications to sc7180-trogdor.dtsi */
> >>
> >>  &en_pp3300_dx_edp {
> >> -       pinmux {
> >> -               pins = "gpio67";
> >> -       };
> >> -
> >> -       pinconf {
> >> -               pins = "gpio67";
> >> -       };
> >> +       pins = "gpio67";
> >>  };
> >>
> >>  &sec_mi2s_active{
> >> -       pinmux {
> >> -               pins = "gpio49", "gpio50", "gpio51", "gpio52";
> >> -               function = "mi2s_1";
> >> -       };
> >> +       pins = "gpio49", "gpio50", "gpio51", "gpio52";
> >
> > Looks like the point of the homestar override is to add an extra pin
> > (gpio52) but it forgot to update the list in the "pinconf" as well so
> > gpio52 wasn't getting a drive strength and bias set. Your patch
> > has the side effect of fixing this. That looks right to me (match
> > GPIO51) given that the name of GPIO51 is AMP_DIN and GPIO52 AMP_DIN2.
>
> I miss here something... There was no pinconf in
> sc7180.dtsi/sc7180-trogdor-homestar.dtsi/homestar.dts
>
> Where do you see the drive strength and bias set for the gpio49-51?

Let's see. I think you're missing "sc7180-trogdor.dtsi". So looking at
mainline today without applying your patches.

In sc7180.dtsi:

  sec_mi2s_active: sec-mi2s-active {
    pinmux {
      pins = "gpio49", "gpio50", "gpio51";
      function = "mi2s_1";
    };
  };

Then in sc7180-trogdor.dtsi:

  &sec_mi2s_active {
    pinconf {
      pins = "gpio49", "gpio50", "gpio51";
      drive-strength = <2>;
      bias-pull-down;
    };
  };

Then in sc7180-trogdor-homestar.dtsi:

  &sec_mi2s_active{
    pinmux {
      pins = "gpio49", "gpio50", "gpio51", "gpio52";
      function = "mi2s_1";
    };
  };

The end result of those snippets ought to be something where, on
homestar, the pinmux gets set to "mi2s_1" for gpio49 - 52 but the
pinconf only gets set for gpio49 - 51 (missing 52).

Your patch fixes this oversight because it combines the muxing and
configuration into one node.

-Doug
