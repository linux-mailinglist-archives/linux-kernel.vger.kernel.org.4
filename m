Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF0474CE86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGJHeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJHee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:34:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1618C;
        Mon, 10 Jul 2023 00:34:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9928abc11deso532774566b.1;
        Mon, 10 Jul 2023 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974462; x=1691566462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC11jQxTM278CfYH6leVR/8McJ3cZ7vdbLrjkZEbJGw=;
        b=awOhiEIHCeizxYWOYYQkn5nWaygxEoF8MMeEVGo+nO4HNB7xXvw4GZXQLA0TSJ/ZXT
         um+nXETYDLrf2dWTDBhO4+tmmmE05Jb72muqdjzkGlEfK66mS6NbIrmFxFX0MGNZgvHr
         ceTCV9XPlyM1fHyQMOWaJVHH+E5ZQBwffjPncvecTwHJCmuGW+plpTgzcZv1A1XOxP+1
         McTbWeLyD5dkeO1rylNwiG3zUExlsyz/XrQyCbZ1tV+1Huh2TFtKTQn9DDp4faquJpat
         Az1qahfDax4lGmmpaQv8TFCUqqp1Rg15CkDXQOb1q5bkErGl8W/c6sbhPAxaPkbVGb2K
         Ihhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974462; x=1691566462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC11jQxTM278CfYH6leVR/8McJ3cZ7vdbLrjkZEbJGw=;
        b=Uk8w6HMMvDuuujPoMvUMlotr4mWLfTLRZ9R5Cs0ib1h+6yaI1CdAqgkwTVY7qpPjS2
         pQyT7dFXmm1p/HqdE/eOkrU2TpYpb0sJPVPDIv2LxekWMfJwRoLYHJyoKMDLDAZ+eW//
         owuh5XCdLRli3ZhubwGE7qXQwQjXv0IaUcybSHttb4dv5y6N+tdVyzTrO7gbe7mpyrLL
         WISO5vnBBhonUbxtcdfbwc9fgAT6y+jpR4fqFzLQg5yPiZvJIwk6oeBd6m/iUVtrEAJ3
         SXLjkxevihNhBYdzuwq/EhNuedPeqSQVcHK5lg8m1tkCb00MoBs+WIGEWx9wVw/50bVg
         /6QQ==
X-Gm-Message-State: ABy/qLbszo1kDsjhBAkVEG3qugmj5U1RG62Mch/Fu/YXVLBFkdGEPs36
        LHm4UpF9jVzW8MhwOKwSN3UheYJx1TClpkzp1JRKnL70SYo=
X-Google-Smtp-Source: APBJJlFMEGFMzXbrFF1vM1qCi4sFiiyXzl4HYs+MEnDHwXoy1wRZ7X3GWe/OsGZluqogZ42s9SdF3pmBOhCiVZUkiNg=
X-Received: by 2002:a17:906:f55:b0:988:4dc:e3a3 with SMTP id
 h21-20020a1709060f5500b0098804dce3a3mr9917388ejj.31.1688974462575; Mon, 10
 Jul 2023 00:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com> <20230710042812.2007928-3-huqiang.qin@amlogic.com>
In-Reply-To: <20230710042812.2007928-3-huqiang.qin@amlogic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jul 2023 10:33:46 +0300
Message-ID: <CAHp75VevmTiv-OYVTn3bF_8UT9SKNU2oTrzS-AM1zoWefeJ=3w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] pinctrl: Add driver support for Amlogic C3 SoCs
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 10, 2023 at 7:28=E2=80=AFAM Huqiang Qin <huqiang.qin@amlogic.co=
m> wrote:
>
> Add a new pinctrl driver for Amlogic C3 SoCs which share
> the same register layout as the previous Amloigc S4.

...

> +#include <dt-bindings/gpio/amlogic-c3-gpio.h>

Seems some headers are missing. The rule of thumb is to include
headers the code uses directly.
Moreover, using a "proxy" header is not the best idea.

kernel.h // ARRAY_SIZE()
mod_devicetable.h // of_device_id
module.h
platform_device.h

pinctrl/pinctrl.h

> +#include "pinctrl-meson.h"
> +#include "pinctrl-meson-axg-pmx.h"

With the above, it might be that existing inclusions become unused, so
drop them in such a case.

...

> +static struct meson_pmx_func c3_periphs_functions[] =3D {
> +       FUNCTION(gpio_periphs),
> +       FUNCTION(uart_a),
> +       FUNCTION(uart_b),
> +       FUNCTION(uart_c),
> +       FUNCTION(uart_d),
> +       FUNCTION(uart_e),
> +       FUNCTION(i2c0),
> +       FUNCTION(i2c1),
> +       FUNCTION(i2c2),
> +       FUNCTION(i2c3),
> +       FUNCTION(i2c_slave),
> +       FUNCTION(pwm_a),
> +       FUNCTION(pwm_b),
> +       FUNCTION(pwm_c),
> +       FUNCTION(pwm_d),
> +       FUNCTION(pwm_e),
> +       FUNCTION(pwm_f),
> +       FUNCTION(pwm_g),
> +       FUNCTION(pwm_h),
> +       FUNCTION(pwm_i),
> +       FUNCTION(pwm_j),
> +       FUNCTION(pwm_k),
> +       FUNCTION(pwm_l),
> +       FUNCTION(pwm_m),
> +       FUNCTION(pwm_n),
> +       FUNCTION(pwm_c_hiz),
> +       FUNCTION(ir_out),
> +       FUNCTION(ir_in),
> +       FUNCTION(jtag_a),
> +       FUNCTION(jtag_b),
> +       FUNCTION(gen_clk),
> +       FUNCTION(clk12_24),
> +       FUNCTION(clk_32k_in),
> +       FUNCTION(emmc),
> +       FUNCTION(nand),
> +       FUNCTION(spif),
> +       FUNCTION(spi_a),
> +       FUNCTION(spi_b),
> +       FUNCTION(sdcard),
> +       FUNCTION(sdio),
> +       FUNCTION(pdm),
> +       FUNCTION(eth),
> +       FUNCTION(mclk_0),
> +       FUNCTION(mclk_1),
> +       FUNCTION(tdm),
> +       FUNCTION(lcd)

+ trailing comma. The rule of thumb is to add a comma when it's not a
terminator entry.

> +};

--=20
With Best Regards,
Andy Shevchenko
