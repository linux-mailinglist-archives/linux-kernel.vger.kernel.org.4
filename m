Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52F66904FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBIKfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBIKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:34:54 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0086E96
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:32:41 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5258f66721bso19488237b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ryrOP+Qukz2gWs6turESQfJKOLpwVFYNNLXrnHrVZQY=;
        b=F7sa3S9sK7etrnQQ8t7WF7bIrtlcWNAAcWRnIr5JI9bZsLRFuhdLfkTwaoOO/0PliM
         CcwpfRuQ5mDBPeyejALwtcZQIAJiQGmaoBYmY65PUT4oiRIpVYMVChd1x9xLWKHwDX3m
         HRyVWX5mGPH1d/lbZVf9x3i+45G4d4f6FcaIPcukZUqF8vu5YkdDgOLQp2XZod+qeBX3
         UZNpMg0q+/ehO+jtguEnhIyMQ8Zfusv4mjNAurEnVhx9CbWlKIQPVytiqoP1UOqC/yVl
         GDdkMFiIQz1C5oOEdTDmYY1HLn7xuYhHdSuEcyo/juBWY1lRxaAvRMGR5/liQB8jo2lC
         JK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryrOP+Qukz2gWs6turESQfJKOLpwVFYNNLXrnHrVZQY=;
        b=Bvx79nA+e4nD5S7PJJkh4yxvw9x5VuKUTHr5cj/MP+ye9ZOE6iIDz+ZhtNpq1hUrZp
         8hABCCPtfUS4xLTI3aFsOYLg/oY5xGj/vjXgAkmHWzV+TGoS9NQiRRgufLbnb3OIto5m
         yB/fg00hOhvY2gbm3JZxbspyxbVOAg5l6AANEzgehwuOKmkHLXPYzdP1k71UO62B+fNl
         v+AOV8dMzUlmTuwbD9a07m26JNmLWhLPYhs+z/ir2/hml+hIqvX8L9B8ny7/ytAnIre/
         bpbs8N087+0pAN296GNyX6yjjlf/iplLBCvfPq3uqzPQ0t53MJ/SU0L0LC16pARmBiCK
         pMDQ==
X-Gm-Message-State: AO0yUKVZ1ZfAaTJaLDup7lfwiEVrJhRLDkRlawAWIXrXjtd8WeqIUMsV
        Ewnk8/wnusf/erD844L5seOn9xb287iCuNnQwm9OJg==
X-Google-Smtp-Source: AK7set/O3Y8txaqL7+gEsfHlEj9Y6syky3ttsk99HfGCIdIEAIBlzyTr86ABauCWFAo+5omQD+SiRRaoPeOlfl7dh40=
X-Received: by 2002:a0d:e743:0:b0:50b:429e:a9ef with SMTP id
 q64-20020a0de743000000b0050b429ea9efmr1042797ywe.434.1675938758805; Thu, 09
 Feb 2023 02:32:38 -0800 (PST)
MIME-Version: 1.0
References: <b151531d-c9fc-cafa-4e46-e213a9892247@microchip.com>
In-Reply-To: <b151531d-c9fc-cafa-4e46-e213a9892247@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Feb 2023 11:32:27 +0100
Message-ID: <CACRpkdbK8A9X4nCZEc53-wXU0Vgkc53j_r5rLQiSeoNbmvm8sg@mail.gmail.com>
Subject: Re: I2c GPIO Recovery with pinctrl strict mode
To:     Ryan.Wanner@microchip.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:56 PM <Ryan.Wanner@microchip.com> wrote:

> My main issue is the process of freeing ownership of a pin(s) having
> another driver, in this case gpio, to take ownership then free that
> ownership back to the default state, in this case it would be back to
> i2c.
>
> I have tried calling pinmux_disable_setting() and then claiming the
> gpios then enabling them for recovery then disabling them again. This
> causes lots of warnings and some cases the full ownership is not
> transferred.
>
> It seems that what I am attempting to achieve is not doable currently.
> Is this the case or am I missing some extra things needing to prepare
> for this action?

There are several other i2c bus drivers doing this already, for example
drivers/i2c/busses/i2c-imx.c

The idea is to have some different pinctrl states and move between
them explicitly in the driver to move pins from i2c mode to GPIO
mode and back.

The imx driver depend on the ability of the i.MX pin controller to use
the pins as a certain function and GPIO at the same time.

This is due to the imx pin controller not setting the .strict attribute
on the struct pinmux_ops so that pins can be used in parallel for
i2c and GPIO and gpiod_get() will not fail. But the Atmel driver does
not set this so you should be fine I think.

Yours,
Linus Walleij
