Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A16DB0D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDGQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjDGQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:46:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79437D8C;
        Fri,  7 Apr 2023 09:46:32 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 26A2440142;
        Fri,  7 Apr 2023 21:46:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680885990; bh=tF6gS/dQJ0Xjv2TQv9OttdhQ2rbpd6PNriD3rPHa+g0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vnnQ1wfHgZTHKcxzmnxE8NqlmUweLuVIBgHGH9NOFio7fZ6T53MqOIVA8NWuqEuHF
         jGLVotyg87dfkxEDLWzuFWzsS47ujBgl57A7Fz9nGD05e6Xd2vF6h+SzGQfqK/4XdC
         X7QxNGiMS+r+vT9ccAp17gcyMsJv0AF5rBqlFHJYwMv57F+b1eNDDnCX01D5qyTy1A
         /kyZtH1NN/c0PF1MJF51VVI/M+iNujVTtJ+HpjhcMeD11+xHEKUy5WNpEc92ceThJx
         qxztJpdPL8K8sGdG4uDxcZr0GFwcCLYMFrbdMENrd1Oi5Q8c/4OvQRt+lkCTpJNlQ7
         Lrx6MuDKcjfag==
MIME-Version: 1.0
Date:   Fri, 07 Apr 2023 21:46:28 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Doug Anderson <dianders@chromium.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: Add Acer Aspire 1
In-Reply-To: <CAD=FV=UCJoz1E4wErJawQjpBRiXw0C0-J4TTWO1+uRiDsdzSUg@mail.gmail.com>
References: <20230407151423.59993-1-nikita@trvn.ru>
 <20230407151423.59993-5-nikita@trvn.ru>
 <CAD=FV=UCJoz1E4wErJawQjpBRiXw0C0-J4TTWO1+uRiDsdzSUg@mail.gmail.com>
Message-ID: <499bbd8cb7783b86108f3e6d9cc07a8a@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson писал(а) 07.04.2023 21:23:
> Hi,
> 
> I didn't do too thorough of a review, but I noticed your comment about
> the panel power and took a look...
> 
> On Fri, Apr 7, 2023 at 8:14 AM Nikita Travkin <nikita@trvn.ru> wrote:
>>
>> +       reg_lcm_3p3: panel-regulator {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "lcm_3p3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +
>> +               /*
>> +                * HACK: Display fails with
>> +                *
>> +                * *ERROR* Unexpected max rate (0x0); assuming 5.4 GHz
>> +                * *ERROR* Link training failed, link is off (-5)
>> +                *
>> +                * if the power to the panel was ever cut
>> +                */
>> +               regulator-always-on;
> 
> I'm curious if `off-on-delay-us = <500000>;` would help you avoid the
> hack. The eDP driver should already enforce stuff like this but I
> think in some esoteric -EPROBE_DEFER cases it can end up violating
> things. Any chance that's what you hit?
> 
> Oh, or maybe it's HPD. See below. Even if it's HPD, having an
> 'off-on-delay-us' specified here isn't a bad idea.
> 
>> +&i2c10 {
>> +       clock-frequency = <400000>;
>> +       status = "okay";
>> +
>> +       sn65dsi86_bridge: bridge@2c {
>> +               compatible = "ti,sn65dsi86";
>> +               reg = <0x2c>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +               #pwm-cells = <1>;
>> +
>> +               interrupt-parent = <&tlmm>;
>> +               interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +               enable-gpios = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>> +               suspend-gpios = <&tlmm 22 GPIO_ACTIVE_LOW>;
>> +
>> +               pinctrl-0 = <&bridge_en_default>,
>> +                           <&edp_bridge_irq_default>,
>> +                           <&bridge_suspend_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vpll-supply = <&reg_brij_1p8>;
>> +               vccio-supply = <&reg_brij_1p8>;
>> +               vcca-supply = <&reg_brij_1p2>;
>> +               vcc-supply = <&reg_brij_1p2>;
>> +
>> +               clocks = <&rpmhcc RPMH_LN_BB_CLK3>;
>> +               clock-names = "refclk";
> 
> You want "no-hpd;" here somewhere. See below.
> 
> 
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port@0 {
>> +                               reg = <0>;
>> +
>> +                               sn65dsi86_in: endpoint {
>> +                                       remote-endpoint = <&dsi0_out>;
>> +                               };
>> +                       };
>> +
>> +                       port@1 {
>> +                               reg = <1>;
>> +
>> +                               sn65dsi86_out: endpoint {
>> +                                       data-lanes = <0 1>;
>> +                                       remote-endpoint = <&panel_in_edp>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               aux-bus {
>> +                       panel: panel {
>> +                               compatible = "edp-panel";
>> +                               power-supply = <&reg_lcm_3p3>;
>> +                               backlight = <&backlight>;
> 
> I think you want:
> 
> no-hpd;
> hpd-absent-delay-ms = <200>;
> 
> ...and yes, you end up with "no-hpd" in both the panel node and the
> ti-sn65dsi86 node. See sdm845-cheza.
> 
> HPD might very well be hooked up on your board, but the current Linux
> ti-sn65dsi86 driver does not look at its own HPD line because it's
> actually slower than just pretending that HPD isn't there. On trogdor
> boards we ended up routing HPD to a GPIO.
> 

Oh, this makes so much sense then! The line is hooked up on
the board indeed and I remember being confused why trogdor boards
don't use it.

I will try to add the suggestions (annotating the reason)
and verify that it works, would prefer the panel power to be
gated when possible. I hope this would also fix the initial
EDID reading issues I occasionally have and carry a hack for
as of now...

Thank you a lot for this insight!

Nikita

> I guess your other option would be to implement HPD support in
> ti-sn65dsi86. That would probably be an overall slower boot for you,
> but is technically more correct. In the past people have posted up
> patches to get ti-sn65dsi86 working as a full DP port and they added
> HPD support for that, but none of those patch series ever go to the
> point of landing...
