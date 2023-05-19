Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52620709F55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjESSsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjESSsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:48:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46014E42;
        Fri, 19 May 2023 11:48:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7576deacbd6so187162785a.3;
        Fri, 19 May 2023 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684522099; x=1687114099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aucr+tRVBv5cqs7JeI2aqwsV9gzMz1bgXQsJAhmbxW4=;
        b=PpSo/arQcQKmS36tSxM9Cnt4Su55bOl6QLqfHFr3cRDLjGfBPmy/4LdOTXO1mTC7TU
         +h6zNYzC7EURr15YYN8goMD7v6RznswhtOgMElup6wYbVfHbxs4a47ok/OnPFpqErvLJ
         zLaA4m79xyLg2ZbRQvacUIUIGdNcGRVsuv4BMr5g5jVqiRGgmPy2C1ltdFKMTyDSPwDr
         TzY5W2eEvjlhaVnkq6OWMLBvMkwaXjsWMRKPTsuv+cS4Lv2TEyumfsxR8ifdFTwUygA2
         TqAVlL/I0+r7yr70jumVbnXlz1D0lm072YHwK8y+0ZpsG6toiGHIHLlnUAD9+x7topeH
         I29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684522099; x=1687114099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aucr+tRVBv5cqs7JeI2aqwsV9gzMz1bgXQsJAhmbxW4=;
        b=WsS3frwl6BrlGZw3hVnRQkfvKKky9sGIBG4exsYHGpLwlBbq0dzSD2XjHz2o7euCsm
         OwRmciKbWrUwhY2qY8dV0G/f2BOk5nRCp2aKbJ78n75WErX/DPUH+t6wqedHMRt3CkjK
         NYxCt32om2WEiAspa/0mbNMPFQpH0BzzppZE33wxg4E5n//5+zEqmUePnTaUGR2bG69F
         1lSHzD+C3BlG0O6sEl4iMHYqBxex1ZftCniBkr3k8BYZBlL3v0rBBQ3CExlwgO7d2dKF
         yZRCMzw8DaPGjxSznB8eRzR6NuM8wAkVWNwPEVYZ4D5IfNrPJUFzw4tCZ+dgygq4/4eO
         Ob8A==
X-Gm-Message-State: AC+VfDwWXZImWMKYUdBkidkgX2neRMP3xku21Xn9+N30KXXCUmpV2fpR
        DrNnctpPgvqar58SQhb9l+rPaZPI9R7JebkUtiA=
X-Google-Smtp-Source: ACHHUZ41R6QrVaDLtFOOxqfjtZx2wKBt6x1A/oKCkV4j8y+ooFPp2RkZgmmem/yzfaRC11jWvnhwBP5fxutURteEogo=
X-Received: by 2002:ad4:5ec8:0:b0:621:48be:bab5 with SMTP id
 jm8-20020ad45ec8000000b0062148bebab5mr6121486qvb.8.1684522099280; Fri, 19 May
 2023 11:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125409.497439-1-quic_srichara@quicinc.com> <20230519125409.497439-5-quic_srichara@quicinc.com>
In-Reply-To: <20230519125409.497439-5-quic_srichara@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 May 2023 21:47:43 +0300
Message-ID: <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com
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

On Fri, May 19, 2023 at 3:55=E2=80=AFPM Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> Add pinctrl definitions for the TLMM of IPQ5018.

A couple of remarks either for the next version of the series or for
the follow ups.

...

> +config PINCTRL_IPQ5018
> +       tristate "Qualcomm Technologies, Inc. IPQ5018 pin controller driv=
er"

> +       depends on GPIOLIB && OF

I'm wondering why OF.
If it's a functional dependency (I do not see compile-time one) the
compile test can be added, no?

  depends on GPIOLIB
  depends on OF || COMPILE_TEST

> +       select PINCTRL_MSM
> +       help
> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for
> +         the Qualcomm Technologies Inc. TLMM block found on the
> +         Qualcomm Technologies Inc. IPQ5018 platform. Select this for
> +         IPQ5018.

...

> +#include <linux/module.h>

> +#include <linux/of.h>

There is a wrong header (the code doesn't use this one).
You meant mod_devicetable.h

> +#include <linux/platform_device.h>

Besides that kernel.h for ARRAY_SIZE() init.h for arch_initcall() and
others might be missing.

--=20
With Best Regards,
Andy Shevchenko
