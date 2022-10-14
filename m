Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57845FF487
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiJNU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiJNU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:27:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923851ACAA4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:27:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j4so8987224lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnTf6LMv8c90DAffjojAc5gCz/Pz6CdILHxs3Cu4YjY=;
        b=fgwAQD12LmiwDBEU35EJ9StUrPpGo/gCAtfQW51Ah4zfvCFYZcE8iVVyI7V1DAFpOV
         21VQQIBga+kIsNlC+c6sJCpsfeunhfymP7FK6xrRFAzkPxQbTGohXR78wBjKWhLMYroS
         Q529f2GiHi+RnpycZMHrgwElTXHg7yIwsd+cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnTf6LMv8c90DAffjojAc5gCz/Pz6CdILHxs3Cu4YjY=;
        b=PKtrrqBdFaTW3j3c//OeeclR9feo5lM+cFbp7n/Ijg8M/5F/fw/xF+G/XVp6xOywmd
         yJpdeIajJnoWHOtbsk72OBDhI+f7CKxMCBs1GKN4ytES8DLZYo3z/n5bQcuBKGaxP5QY
         79UaTUPynYng1yBz1Z5u1HDPc3+T+dYT78m1MK5m3aeBkeYrM7MI145n4nIpL3eSekw8
         ll1foTpGbywJ2q7TzIwwjvNCRBqSuUXYCaPl1+ClOPNrPI5h2PU6zy83Bw2vOxp2h/Ts
         Stf0HmqUbCbCadlyj8lCpmHBNYwQyYmzVSG12BoK5bD45qZL51otvS+8hG2LTZETb8Iu
         dzZA==
X-Gm-Message-State: ACrzQf1CHOY7hPoOxW2WLI6qal2ec1a7ObwDx0URgCu6aEWxIP2w2Gfo
        43QXERxeWGIChKZdlPiiMcxA7cIHTVxGeHcUjssGHA==
X-Google-Smtp-Source: AMsMyM5ppSzx6lIMkanfmWYEQL2Hbi+//MrjWxIy5a/wUaW7YMOUJeV+4E7j7W1hotWln2SqzRxUUzbV7NxyhTs01KE=
X-Received: by 2002:a05:6512:3d89:b0:4a2:4d71:7d9e with SMTP id
 k9-20020a0565123d8900b004a24d717d9emr2237489lfv.145.1665779226424; Fri, 14
 Oct 2022 13:27:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Oct 2022 13:27:05 -0700
MIME-Version: 1.0
In-Reply-To: <20221014103217.1.I656bb2c976ed626e5d37294eb252c1cf3be769dc@changeid>
References: <20221014103217.1.I656bb2c976ed626e5d37294eb252c1cf3be769dc@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 14 Oct 2022 13:27:05 -0700
Message-ID: <CAE-0n50wZ+b5rVZsjDYpsdKc6jgUBqmZBnAT=sqL-pcG28LQ5Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Avoid glitching lines when we first mux to output
To:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-10-14 10:33:18)
> Back in the description of commit e440e30e26dd ("arm64: dts: qcom:
> sc7180: Avoid glitching SPI CS at bootup on trogdor") we described a
> problem that we were seeing on trogdor devices. I'll re-summarize here
> but you can also re-read the original commit.
>
> On trogdor devices, the BIOS is setting up the SPI chip select as:
> - mux special function (SPI chip select)
> - output enable
> - output low (unused because we've muxed as special function)
>
> In the kernel, however, we've moved away from using the chip select
> line as special function. Since the kernel wants to fully control the
> chip select it's far more efficient to treat the line as a GPIO rather
> than sending packet-like commands to the GENI firmware every time we
> want the line to toggle.
>
> When we transition from how the BIOS had the pin configured to how the
> kernel has the pin configured we end up glitching the line. That's
> because we _first_ change the mux of the line and then later set its
> output. This glitch is bad and can confuse the device on the other end
> of the line.
>
> The old commit e440e30e26dd ("arm64: dts: qcom: sc7180: Avoid
> glitching SPI CS at bootup on trogdor") fixed the glitch, though the
> solution was far from elegant. It essentially did the thing that
> everyone always hates: encoding a sequential program in device tree,
> even if it's a simple one. It also, unfortunately, got broken by
> commit b991f8c3622c ("pinctrl: core: Handling pinmux and pinconf
> separately"). After that commit we did all the muxing _first_ even
> though the config (set the pin to output high) was listed first. :(
>
> I looked at ideas for how to solve this more properly. My first
> thought was to use the "init" pinctrl state. In theory the "init"
> pinctrl state is supposed to be exactly for achieving glitch-free
> transitions. My dream would have been for the "init" pinctrl to do
> nothing at all. That would let us delay the automatic pin muxing until
> the driver could set things up and call pinctrl_init_done(). In other
> words, my dream was:
>
>   /* Request the GPIO; init it 1 (because DT says GPIO_ACTIVE_LOW) */
>   devm_gpiod_get_index(dev, "cs", GPIOD_OUT_LOW);
>   /* Output should be right, so we can remux, yay! */
>   pinctrl_init_done(dev);
>
> Unfortunately, it didn't work out. The primary reason is that the MSM
> GPIO driver implements gpio_request_enable(). As documented in
> pinmux.h, that function automatically remuxes a line as a GPIO. ...and
> it does this remuxing _before_ specifying the output of the pin. You
> can see in gpiod_get_index() that we call gpiod_request() before
> gpiod_configure_flags(). gpiod_request() isn't passed any flags so it
> has no idea what the eventual output will be.
>
> We could have debates about whether or not the automatic remuxing to
> GPIO for the MSM pinctrl was a good idea or not, but at this point I
> think there is a plethora of code that's relying on it and I certainly
> wouldn't suggest changing it.
>
> Alternatively, we could try to come up with a way to pass the initial
> output state to gpio_request_enable() and plumb all that through. That
> seems like it would be doable, but we'd have to plumb it through
> several layers in the stack.
>
> This patch implements yet another alternative. Here, we specifically
> avoid glitching the first time a pin is muxed to GPIO function if the
> direction of the pin is output. The idea is that we can read the state
> of the pin before we set the mux and make sure that the re-mux won't
> change the state.
>
> NOTES:
> - We only do this the first time since later swaps between mux states
>   might want to preserve the old output value. In other words, I
>   wouldn't want to break a driver that did:
>      gpiod_set_value(g, 1);
>      pinctrl_select_state(pinctrl, special_state);
>      pinctrl_select_default_state();
>      /* We should be driving 1 even if "special_state" made the pin 0 */
> - It's safe to do this the first time since the driver _couldn't_ have
>   explicitly set a state. In order to even be able to control the GPIO
>   (at least using gpiod) we have to have requested it which would have
>   counted as the first mux.
> - In theory, instead of keeping track of the first time a pin was set
>   as a GPIO we could enable the glitch-free behavior only when
>   msm_pinmux_request_gpio() is in the callchain. That works an enables
>   my "dream" implementation above where we use an "init" state to
>   solve this. However, it's nice not to have to do this. By handling
>   just the first transition to GPIO we can simply let the normal
>   "default" remuxing happen and we can be assured that there won't be
>   a glitch.
>
> Before this change I could see the glitch reported on the EC console
> when booting. It would say this when booting the kernel:
>   Unexpected state 1 in CSNRE ISR
>
> After this change there is no error reported.
>
> Note that I haven't reproduced the original problem described in
> e440e30e26dd ("arm64: dts: qcom: sc7180: Avoid glitching SPI CS at
> bootup on trogdor") but I could believe it might happen in certain
> timing conditions.
>
> Fixes: b991f8c3622c ("pinctrl: core: Handling pinmux and pinconf separately")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
