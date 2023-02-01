Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2A68629A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBAJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjBAJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:13:04 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093BA5CA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:13:01 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id 187so18904676vsv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bztQ+dA3etUL63fAtj2SeL0ltxToNkp9ApVjMY5n6Ho=;
        b=uol4FPSjS0z5wEJ3dAYJCGx+KI2blEu7HrJ7JymXfUF5T3KAfFRKozXECk2U07SUHf
         /YOoAn01O8Gd+eyUOJrbpBUPJTlLtS639F684O5lIAAhzC7y4rMdxHi7u+v28twGybfn
         g9tW36IoUb8dwCE0eS/O837IM2h7GIVaS6jM2AywKo/vsjJ27ychb0KbZF923ndDGfjw
         /T/eVYW/nuSnA4Da0oTCbQcvd4gzZojdWQ+noCSXAiyOMMPH3aohQpHifOMkqZMmziZ/
         nhKAXw6pBkvqV58a994TpQEPp17qTGF2TyZ4xMI0pm7jukZjC9E0gCH/tozfqIBiUaEg
         mHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bztQ+dA3etUL63fAtj2SeL0ltxToNkp9ApVjMY5n6Ho=;
        b=j1A/hKtWrFgYIeRHk1lRZ1Z46SDaw+zF9QMpOboEiJYskILGXR11O8GVbPqh4ejDwO
         0gPPpEVoXa3HOnAoVJkPBmkTK3ULJQ9FcoPiHCC3jfiEm/23HAPYXNe05j2A37SRTP7h
         zUcAQNO+lTnJVDaGJzNr9YdhUPBxQUM2noQiWQYRyFJDRYJqfXUUecp5bdtYGnvXtcGJ
         iNXVlcGym1cFu1aMw7bKgpdb07RMCaKqEFWatII+PN/yry08nFG/zp1xAlcoFVHc+bVJ
         ljSHZkYkMtCGqEQ0h9aAvGyf1nx7qlv60W0mipzbawSlWKEN49dUatCiUo/2KJqDSxu4
         LvWA==
X-Gm-Message-State: AO0yUKWNEnrbopVaxF3vsoEANP9FJ+lpxX5TTRh7mSNQHEbC7jYqAndt
        FlhRw/P+MsgOIZnXA8kpyvv350tJaRZUB3qFLU/shA==
X-Google-Smtp-Source: AK7set9q7lXkwOKClUBt85mQQHBKfWxwZ4q7kmMN+2Be9KwLjzjjU0cclkFDcdDwU3foYUbEiVe3pLxOZCL7CTYCkpw=
X-Received: by 2002:a67:ebc5:0:b0:3f2:4a59:de3b with SMTP id
 y5-20020a67ebc5000000b003f24a59de3bmr305125vso.73.1675242780611; Wed, 01 Feb
 2023 01:13:00 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MciMOfCo_fS_Um0xaQT2H=QSRgEUA5iTwxmpXqo2k2NJg@mail.gmail.com>
 <20230201091021.7090-1-nikita.shubin@maquefel.me>
In-Reply-To: <20230201091021.7090-1-nikita.shubin@maquefel.me>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Feb 2023 10:12:49 +0100
Message-ID: <CAMRc=MeRzwxDy0_AiwseO1qV8WM9R6E8nRWYwPfxiL3EYBiNjQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ep93xx: split device in multiple
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 10:10 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> This prepares ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
>
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
>
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Bart, i've rebased on the top of gpio/for-next (there were issues
> indeed), but this patch still won't apply. That's becouse it's dependant
> on Linus patch:
> https://lore.kernel.org/linux-arm-kernel/20230111132210.134478-1-linus.walleij@linaro.org/T/
>
> Alexander can we have Linus patch somehow applied to ep93xx ?
> ---

In that case:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

And let's make it go together with its dependency.

Bart
