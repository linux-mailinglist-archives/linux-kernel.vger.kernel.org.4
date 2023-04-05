Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27306D7D92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbjDENU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjDENU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:20:56 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5926A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:20:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id cf7so42501049ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680700855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m4rtZfAeR6vet4pBc2kbt1ke7sk+dSI8jcqxxSGabg=;
        b=N3lS4Ak6Hm5UiFMyXreG42rMd1R06vtbPLvlXgKK15No6lROSjJ6chA+gMoALkxBVW
         5Ro0fhfTddipMFnBoNBrljl27cWdgVBHU7m5ZrJ1BKXaH5H2wXxhZmojKzJyEbLKgwps
         V438OspT5Qn5OrJK5/cL8db7csqB4u9toLFIHnNyLT+eUOh5Hh2dNZNpTEvMgjwbPJzX
         yqoTVj1u6tILTYMfZUoD0EP3VeZp8ZXWRXz35vsVQjbnwktkdsBM3uV6mSW1JmM44/JN
         7J0BQgZXhgiw6iYCVlwus3YYmX/18r5WoQ2M8aZ/NlLhPaokRZkd1iSaJIuZ8x70WAdU
         fk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m4rtZfAeR6vet4pBc2kbt1ke7sk+dSI8jcqxxSGabg=;
        b=DjlVVy8QpVMJ7/GjrtNo8iKxECcUaR7humZazsjlutEk36h6wbHO4Pb5HOmlywjQNz
         MZO47KOzIPtFXEj6dIcIi4gfNJ79dEF8fhOJ7awjCgMsqqxnkYT7dHbvCyPw3IpAYDZq
         DCWeHmUmJ0oidyjMGlhJseyuo+5/GhjgXVcnAQ01oLqTd8KDimK+61cML/yKaVy4AHwb
         bvLSq1rH0GNmdrPlbU7+sauaIacpJOsuNy0Re3YomZLDEQTogSD2oOMNB0jYMiEcHKJe
         MXTkcJlYAeJdl/bX+yTpO9BcPmbKWQhxK0y+HYjASWzk/HkCcqRPk7/Xj4EUZDoqkGar
         67Ew==
X-Gm-Message-State: AAQBX9cTRUlM65+z8gzOXECV6v/p3QAIwA6YrCq5/6Kql6V3sT5KQTBI
        hUoHcKeqFiUGLkGGLsGr4OGpPVy9rTsP7wbgnOHxYA==
X-Google-Smtp-Source: AKy350YiuEojPpk0LsekJiZpz7ZmKGHu2ckM5yNZBZFhKfctdMEDTQ66kox+btK9EnfDhwRK9NOmh4mXZnKdoVKyU50=
X-Received: by 2002:a25:7316:0:b0:b74:3236:2fac with SMTP id
 o22-20020a257316000000b00b7432362facmr4120216ybc.4.1680700854809; Wed, 05 Apr
 2023 06:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130010.8342-1-okan.sahin@analog.com> <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com> <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
In-Reply-To: <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Apr 2023 15:20:43 +0200
Message-ID: <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 4:36=E2=80=AFPM Sahin, Okan <Okan.Sahin@analog.com> =
wrote:

> >The driver is pretty straight-forward, but I think this can use the gene=
ric
> >GPIO_REGMAP helpers in drivers/gpio/gpio-regmap.c check other drivers se=
lecting
> >this helper library for inspiration.
(..)
> Thank you for your contribution. Should I add select GPIO_REGMAP into Kco=
nfig?

Yes but that is not all, you also need to make use of the library helpers
provided in include/linux/gpio/regmap.h.

Find examples of other drivers doing this by e.g.:
git grep gpio_regmap_register

drivers/gpio/gpio-sl28cpld.c:   return
PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
drivers/gpio/gpio-tn48m.c:      return
PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
drivers/pinctrl/bcm/pinctrl-bcm63xx.c:  return
PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &grc));

^Look what these are doing

Yours,
Linus Walleij
