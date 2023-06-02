Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D007202D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjFBNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjFBNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:13:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3310E9;
        Fri,  2 Jun 2023 06:12:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6260e771419so12441256d6.1;
        Fri, 02 Jun 2023 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711518; x=1688303518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry5f5ak9Sr/bZIbtzTWJKvf8qehHNybuYJDF5N8k3cI=;
        b=QPHM+5/woE/dOdJELOIwis9yJBOUQoJlPPGRdP02SJqMqHI27rC5crLA6aJ+I+IAyk
         g8SE/QLLi9KBFI6QVazJnlN1/A75T72fCkc2WD6qXVb+/iEFm8ghzYBFWz00iZ56auMH
         +Lx304AoJRyE/RsOG8vlL+2XlxxJi8Avc8Gfhbm18Oys/Bbvx+OzVC0gKZo2Is5m1ErA
         Wx2XlDL+Tn9j7p7GXzEg5NFb5U7eeWBs2cXHHnnWfkA7kTL79BUrztBei2k7C3oKS7Ey
         3tCQabzh8T47rC/pmtQ45/Xnylb59gvgVMKGQdMLy2VoobHctDpkirlJTdouqsFKEhz4
         MbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711518; x=1688303518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ry5f5ak9Sr/bZIbtzTWJKvf8qehHNybuYJDF5N8k3cI=;
        b=JEJ4S4m6yVSj4OvZcC0WAjiibqiIGCnqXmt9Kcj2LslpCaZQsn2G3ENnTZ1bJwkuL+
         XDQ7VzoJDeanAQ5P3wO4Oo06waz7m/9sZk7FPJKEDVaoHWLyN1qknbObKGSXUw3jmD6K
         edJwVR+/eP9ZjAAOBJemzWCvUD244BS1lvLlff6q6zIQEdFcQaXL73/PxzACkxCq1K03
         apXGlcw1uPizLPPiRiVx8/QxLTjbjSUeZG3MZuqO5ba8L+Q3vdz0FWaOWEN3zqlR1wot
         DPHeeIoUL2fhQL/Z7ONRhAYZHGl9hMpC7TO48cQaVQ4wV7SDTb8RKQ+atuedrY2oXdP5
         2lcA==
X-Gm-Message-State: AC+VfDym+2Kre7AsobAzAU1qWzefzhXq8fYdLz69XGkxjPFgKju59U2x
        ctqI+Qi9w60dYPUFrW08qNMzE2Eat4sqY4jyCJe7IjqdIHabOg==
X-Google-Smtp-Source: ACHHUZ7kMzvAHTkGGwT6hZfhgTh0gjVaS+Sg8f/2ZLTev7/1qspG/QCMLGRPbwovukpVvSzxyIhabkjHVr9LicCFB2s=
X-Received: by 2002:a05:6214:411b:b0:628:7be8:97b7 with SMTP id
 kc27-20020a056214411b00b006287be897b7mr2694764qvb.23.1685711518207; Fri, 02
 Jun 2023 06:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230602082325.1445261-1-quic_srichara@quicinc.com> <20230602082325.1445261-3-quic_srichara@quicinc.com>
In-Reply-To: <20230602082325.1445261-3-quic_srichara@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jun 2023 16:11:21 +0300
Message-ID: <CAHp75Vcfa2cbACEPROuOptPM7c9SOp_TudK-4Rx45OhWPf=iiw@mail.gmail.com>
Subject: Re: [PATCH V8 2/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com,
        krzysztof.kozlowski@linaro.org
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

On Fri, Jun 2, 2023 at 11:24=E2=80=AFAM Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> Add support for the global clock controller found on IPQ5018
> based devices.

...

>  config IPQ_GCC_5332
>         tristate "IPQ5332 Global Clock Controller"
>         depends on ARM64 || COMPILE_TEST
>         help
>           Support for the global clock controller on ipq5332 devices.
> -         Say Y if you want to use peripheral devices such as UART, SPI,
> -         i2c, USB, SD/eMMC, etc.

Nothing in the commit message about this. Please, elaborate.

...

> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>

Why not keep this ordered?

Missing bits.h and maybe others, but in an unordered list it's harder to ch=
eck.

...

> +                       &gpll4_main.clkr.hw

Can we keep trailing comma here and in similar cases, like

> +                       &ubi32_pll_main.clkr.hw
> +                       &gpll0_main.clkr.hw

(and many others)?

--=20
With Best Regards,
Andy Shevchenko
