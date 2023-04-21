Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E86A6EA5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjDUIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjDUIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:34:47 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE2476B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:34:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54fb4c97d55so4618197b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066085; x=1684658085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp/ACjcZCf0EcpuagDl4EZfkEmf33hHdlU+uun89GDc=;
        b=qarcqIc6SRTL8HBCIZpm+9e7y4OJJ/CuQgypU8/t22C1pcBLHWvotUZqOa+aSGhKTp
         n6ze3o3VuxjOF5TIDaTzylWNQVmGPzt0sbK6pDbABpmsoDANhcgmz/pRHiJArV9n1xGI
         /FjxsYBvNKRbAwJkthp0goKLdq3LC2EQa18t9hUA45wfKdQzHTArWHfMmzaxYy+54v/y
         I6YQzTdfLUle7YQ1dJ8a0FtArBfd0tZyCbLmgKZWqFxYMXZHMZvfma1dXYnJlHOd+Owr
         8h+NXrNaqK986NCef5jyOYFR2wtk9HTM4J0RBk5OJ62Sn5hebCWh8wj+H/qrqDnNkME5
         7NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066085; x=1684658085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp/ACjcZCf0EcpuagDl4EZfkEmf33hHdlU+uun89GDc=;
        b=S0PBfUOZdng7eAqvBBjcvIgB3bCtu0ZFQ7juCGiOGmThDhYdmn+0WseaFgK9aLvvDQ
         qI472h+Se3j6jrTogqKGiICtSItap+BbC/cjFXdiosetkKET4jBsI9g3a8w7JEwkK0KT
         7nIBEwfXV3Ea1AhiIBWWhZXn9A+iTEUOG9M/owuKsLXv/Y7Yr8YD7rMNzzv65ODkUTcE
         eV1WHZDQRfX8Y0c3gc/ehNIjgY1Us9CNJn1ew8HoLeExt+KcQw24O1KHGYUsV8y1IT8P
         BI/1nW6gHwF8YFTk6goaQWrDiq0DM3A5/K6LtYgGN/Vjlmj7FnexFMdJ0gDBVEGHzxZu
         OIFw==
X-Gm-Message-State: AAQBX9et0kOeVb4Hfx+iR4O57ExIaZDv4W4jDy28vOQ3g9gHzgue215b
        oK/CStu5fWpb4Sb6KU0MKurj1KKC9cSCSCKIIs5YIA==
X-Google-Smtp-Source: AKy350Yb4Fz0U89tXFn8B6ENGKQYsi+pslftagGUV88tFpZd1gHJSxkRiNiY0l3gWO5hnKalWWgxY51ckK9X0bfjAnM=
X-Received: by 2002:a81:5205:0:b0:54f:cc36:e919 with SMTP id
 g5-20020a815205000000b0054fcc36e919mr1218013ywb.4.1682066085190; Fri, 21 Apr
 2023 01:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101217.1342891-1-eblanc@baylibre.com> <20230414101217.1342891-3-eblanc@baylibre.com>
In-Reply-To: <20230414101217.1342891-3-eblanc@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:34:34 +0200
Message-ID: <CACRpkdab_26D9BMGeSygy_oa6SFa62ytXcy+Ydi3yPzQO3tU4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: tps6594: add for TPS6594 PMIC
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, aseketeli@baylibre.com,
        sterzik@ti.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

thanks for your patch!

On Fri, Apr 14, 2023 at 12:12=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com=
> wrote:

> TI TPS6594 PMIC has 11 GPIOs which can be used for different
> functions.
>
> This add a pinctrl and pinmux drivers in order to use those functions.
>
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
(...)
> +config PINCTRL_TPS6594
> +       tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
> +       depends on MFD_TPS6594
> +       default MFD_TPS6594
> +       select PINMUX
> +       select GPIOLIB

select GPIO_REGMAP
?

I think this driver can use the GPIO_REGMAP helper library.

Please look into other drivers using this, such as
drivers/gpio/gpio-sl28cpld.c

Yours,
Linus Walleij
