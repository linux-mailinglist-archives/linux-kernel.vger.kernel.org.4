Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BD6F367D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjEATGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEATGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:06:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A21708;
        Mon,  1 May 2023 12:06:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-95f4c5cb755so573688666b.0;
        Mon, 01 May 2023 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682967996; x=1685559996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbK7EtQRtZZE7KYEeoJBLaWKVzPK4dKamhRK6nyLgos=;
        b=IOKOgtayzfFZNsyi1stDP8bgZ2e8StGU6AXpOokekL9MEPm8GXe3VVJMt94V5DwdEM
         ATKwwwmalpAfY1y3ljA9x93gRbYm86ihqRakr7DtMI9ZAvHu4/Xs6P92b7aiNugQszBm
         mqqxxLmirHC+gAs0Yx2c5Kru6Ep97A/IaHWdSPh3TuZ1xx8AJlB21C0UZNlroQL3+CbI
         KvqjNd8TDpgSNIJLqROqTJv8HrTCVenOUH8bCNKlW5s9PK8cbQKVXSX9ahZv9ZMy5vAG
         B699V9dmeE2OyfAQ+qFqLCps61OUjvCXCzwMouYAxCdkpDi57VxOLyxpHBGR96pBt4rT
         C3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967996; x=1685559996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbK7EtQRtZZE7KYEeoJBLaWKVzPK4dKamhRK6nyLgos=;
        b=JzXHGY1TZ2duCsLT7yKGD8PjVuoZ6JLeIbdni1jhcCh7goDc5IfqndKzMX6Z0L0AoB
         nO4oSSaU8pYJucMNzKqgKKFKETDtHqDzdo5/mwLZ7lfr3iu5y8Pev/g7iOKmj88r659U
         AiR3MIHALfSG3I3h3nYRt66CFZfl36sgUYLGbPWuYdz6q9NyIS4Sura6LP0hZ+QGmbzo
         sRh9/92PzizgGjpNm74ym4lq2s2iW5NeZr0izdXRCj2c+0waJYZLjgTihS+UGD9Bhp7C
         ngRLlkLX2O2Wvt/FZRygUq8GkfHu+p4+kxy+h5jlwrykMIcfFaKlJZZ8Ppdt5w9ZImV6
         2KEw==
X-Gm-Message-State: AC+VfDzlQ5mrcQPwilumqu+vdEqCK/Ra3M++EGV293aFHjT3gaMCDx1m
        EtTFpxkeBZS158yY9ReaFC276WdJfx4bqEeB4Nk=
X-Google-Smtp-Source: ACHHUZ5qgzS3PhkmnYZSPw1/CWfO5K2yQvVRa39/ZwKaLWKwP2rgTDXwfMm6qXhJyEvt0k+aENNNLDiUmPBDvWB5QjA=
X-Received: by 2002:a17:906:9b86:b0:957:2a7e:ce0a with SMTP id
 dd6-20020a1709069b8600b009572a7ece0amr14352840ejc.44.1682967996043; Mon, 01
 May 2023 12:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru> <20230426095805.15338-7-ddrokosov@sberdevices.ru>
In-Reply-To: <20230426095805.15338-7-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 21:06:24 +0200
Message-ID: <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

overall this looks pretty good.

+Cc Heiner

On Wed, Apr 26, 2023 at 11:58=E2=80=AFAM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
[...]
> +static struct clk_regmap pwm_a_sel =3D {
> +       .data =3D &(struct clk_regmap_mux_data){
> +               .offset =3D PWM_CLK_AB_CTRL,
> +               .mask =3D 0x1,
> +               .shift =3D 9,
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "pwm_a_sel",
> +               .ops =3D &clk_regmap_mux_ops,
> +               .parent_data =3D pwm_abcd_parents,
> +               .num_parents =3D ARRAY_SIZE(pwm_abcd_parents),
> +               /* For more information, please refer to rtc clock */
> +               .flags =3D CLK_SET_RATE_NO_REPARENT,
Heiner is working on a series that adds common clock support to the
PWM driver [0].
I think his plans for a next step are adding support for SoCs where
the PWM clocks are part of the peripheral clock controller (instead of
being part of the PWM controller registers).

Have you considered removing CLK_SET_RATE_PARENT from the &rtc clock
so downstream clocks won't change the rtc clock rate by accident?
Then we could drop the CLK_SET_RATE_NO_REPARENT flag from the PWM
clocks to allow them to pick the best available parent (whether that's
the rtc clock, xtal or sys_pll).
That said, it would require managing the CLKID_RTC_32K_SEL clock (or
it's parents) using assigned-clocks instead of doing so with the PWM
(and other) clocks. Whether this would cause problems: I'm not sure,
so I'm hoping that you can share some insights.


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e3=
23e@gmail.com/
