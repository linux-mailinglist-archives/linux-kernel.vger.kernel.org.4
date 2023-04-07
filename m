Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5186DB085
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDGQYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjDGQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:23:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9DBBB5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:23:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id d3so21582307ybu.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680884625; x=1683476625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRsDrLkJSi5dpaXKk+z5BAwMDpasj80dVc8aix8QPCQ=;
        b=Y7M/kTwQ5lNHgNqBfWEIszgGGW5eI54Bvv0/EmjKPCaQYVCbAg8tHbPBO44wIcAdXf
         rntVJuX+edKeAEkjR9SjuJvSLcgDh6TQUKw6ZLR7Zu/WB7zanr9DoUk9/pQxjDr9mxLB
         /Vjzd//WOtV3hgR9j9Tt8s28Zu7IzlD9D1O7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884625; x=1683476625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRsDrLkJSi5dpaXKk+z5BAwMDpasj80dVc8aix8QPCQ=;
        b=ySX7oIX3HED7bB3R+JRk4h6qmpj1vkomakAYJqx2xcoSc3QK6KqKXUWLya7mZclLgd
         +WpzienxcNP9CaAafKGYcQrzbz92bbWyj6w4uLNcXWwF8otPthIETX/MRQlNxcnYCchH
         SuxKXnJGOoikqTl4VtyyXYPilrKzPXqBM7pe6UCCyip4hyvF3A9xE5lshdb67arnOFff
         gtga6ILPud2NoqREbwlW+i7wqGHjaeh3WIQvty+moTDVUnXVJVpsOeHJW9+QMwuwtJT/
         OXmv+ai+u8TDfVlA8Mo7jt51HndRtPWMrmQB1I2LMK0DGqyKGXRUcASvVTL8xK0l7Bzr
         tnUA==
X-Gm-Message-State: AAQBX9d3JHDmu7M1CufE2QX3Xt+v4dGxYtsO4P6PRqZAhzo3F+OZ0jvv
        j1xsi1fs5YFYA9yz51K1J9sutMMCxILQq4KYbqg=
X-Google-Smtp-Source: AKy350ZXCqiNNjbp8/Y+5Mvxenh5H9Eeqk08gaqKcik68MKxsYS4gZ6UCXo0Iesyated/KutrRKqXw==
X-Received: by 2002:a25:b19f:0:b0:b67:40a3:7975 with SMTP id h31-20020a25b19f000000b00b6740a37975mr3433530ybj.35.1680884625059;
        Fri, 07 Apr 2023 09:23:45 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id p14-20020a25420e000000b00b8c073a90cdsm729501yba.14.2023.04.07.09.23.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 09:23:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id d3so21582142ybu.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:23:43 -0700 (PDT)
X-Received: by 2002:a25:6c07:0:b0:b8b:eea7:525b with SMTP id
 h7-20020a256c07000000b00b8beea7525bmr2049650ybc.7.1680884623153; Fri, 07 Apr
 2023 09:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230407151423.59993-1-nikita@trvn.ru> <20230407151423.59993-5-nikita@trvn.ru>
In-Reply-To: <20230407151423.59993-5-nikita@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Apr 2023 09:23:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCJoz1E4wErJawQjpBRiXw0C0-J4TTWO1+uRiDsdzSUg@mail.gmail.com>
Message-ID: <CAD=FV=UCJoz1E4wErJawQjpBRiXw0C0-J4TTWO1+uRiDsdzSUg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: Add Acer Aspire 1
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I didn't do too thorough of a review, but I noticed your comment about
the panel power and took a look...

On Fri, Apr 7, 2023 at 8:14=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> wrot=
e:
>
> +       reg_lcm_3p3: panel-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "lcm_3p3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +
> +               /*
> +                * HACK: Display fails with
> +                *
> +                * *ERROR* Unexpected max rate (0x0); assuming 5.4 GHz
> +                * *ERROR* Link training failed, link is off (-5)
> +                *
> +                * if the power to the panel was ever cut
> +                */
> +               regulator-always-on;

I'm curious if `off-on-delay-us =3D <500000>;` would help you avoid the
hack. The eDP driver should already enforce stuff like this but I
think in some esoteric -EPROBE_DEFER cases it can end up violating
things. Any chance that's what you hit?

Oh, or maybe it's HPD. See below. Even if it's HPD, having an
'off-on-delay-us' specified here isn't a bad idea.

> +&i2c10 {
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +
> +       sn65dsi86_bridge: bridge@2c {
> +               compatible =3D "ti,sn65dsi86";
> +               reg =3D <0x2c>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +               #pwm-cells =3D <1>;
> +
> +               interrupt-parent =3D <&tlmm>;
> +               interrupts =3D <11 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               enable-gpios =3D <&tlmm 51 GPIO_ACTIVE_HIGH>;
> +               suspend-gpios =3D <&tlmm 22 GPIO_ACTIVE_LOW>;
> +
> +               pinctrl-0 =3D <&bridge_en_default>,
> +                           <&edp_bridge_irq_default>,
> +                           <&bridge_suspend_default>;
> +               pinctrl-names =3D "default";
> +
> +               vpll-supply =3D <&reg_brij_1p8>;
> +               vccio-supply =3D <&reg_brij_1p8>;
> +               vcca-supply =3D <&reg_brij_1p2>;
> +               vcc-supply =3D <&reg_brij_1p2>;
> +
> +               clocks =3D <&rpmhcc RPMH_LN_BB_CLK3>;
> +               clock-names =3D "refclk";

You want "no-hpd;" here somewhere. See below.


> +
> +               ports {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       port@0 {
> +                               reg =3D <0>;
> +
> +                               sn65dsi86_in: endpoint {
> +                                       remote-endpoint =3D <&dsi0_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg =3D <1>;
> +
> +                               sn65dsi86_out: endpoint {
> +                                       data-lanes =3D <0 1>;
> +                                       remote-endpoint =3D <&panel_in_ed=
p>;
> +                               };
> +                       };
> +               };
> +
> +               aux-bus {
> +                       panel: panel {
> +                               compatible =3D "edp-panel";
> +                               power-supply =3D <&reg_lcm_3p3>;
> +                               backlight =3D <&backlight>;

I think you want:

no-hpd;
hpd-absent-delay-ms =3D <200>;

...and yes, you end up with "no-hpd" in both the panel node and the
ti-sn65dsi86 node. See sdm845-cheza.

HPD might very well be hooked up on your board, but the current Linux
ti-sn65dsi86 driver does not look at its own HPD line because it's
actually slower than just pretending that HPD isn't there. On trogdor
boards we ended up routing HPD to a GPIO.

I guess your other option would be to implement HPD support in
ti-sn65dsi86. That would probably be an overall slower boot for you,
but is technically more correct. In the past people have posted up
patches to get ti-sn65dsi86 working as a full DP port and they added
HPD support for that, but none of those patch series ever go to the
point of landing...
