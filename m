Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40EE66C28C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjAPOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAPOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:44:28 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D922DCF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:24:53 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e130so924237yba.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hCyXRjcH8YuwMPEc2ZGG+hIyruOgN3sWMVzTY5twqOU=;
        b=XWpOyCztBtkKx9ZAX92Cij1ET+v3vM5l4VgjTnfVz8etnbVKmQzdzXKiArQff3IlVy
         jvoZUuLVCzvHSWG43wIh5rLJu/thKefKdcqxmWqYiy4/y/UmeyiaA+aZFHIUnv3wlzeD
         dIEt6/mDa9m+meh8Kgli87SMgtlT45zia86KPKlID1ylg2f82LVnbZcw+rW9IPsg+y2Q
         umy8FyEupLgcjA47nK+5cEQGho3FR2tB8m33lVTZ9LVPWc7VVlPaPrF7XwbrDlWP5JaV
         7gcYpsfMwI0HO+/cNhLw1CjUA1zn3NliRhzyI6Fd9yr8LfEoqaReR+ydamnQimvJFlvi
         oz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCyXRjcH8YuwMPEc2ZGG+hIyruOgN3sWMVzTY5twqOU=;
        b=f2DhHijh06wRLvo8rpWSFkZFrhwTLNZSHg+JH6mPinQ02AfM1tm0311mnYu2HAjAiF
         n0wy13TDCbFiEgeNwtQ8RXOWKLPpN+vQog4m2aDMB6UJzu2odcGg5NSV9TmnxQSEJSLE
         QltAiwMEv5v9yRFjS6cvMPDGqyp+VdnlCM6+mBFQ16gBENIHxVyhX/dp8w2G1hw8eKhP
         7xRVL2kg7/0JsBv5ef1988kLJeAgMqQCUvv1CgmnIbSlzFv0uuZEfIBd7IAdNdgZZnAj
         +U/q1y9aTDav7J47P+3DatwGx8bouwWjYObRuWMWeOQhsU/edBStsATPlWu7gOu8whnM
         3COA==
X-Gm-Message-State: AFqh2krxIhefHaNaG4GUIO1Twwslx9Ot6JSeARH5aGAd9OEFOPHqdTNS
        f7QN77Hf7vT0oeaG2YN/gBWdo9cAUq0DlkTdWBVFsw==
X-Google-Smtp-Source: AMrXdXvOIqa4B5X1SKY7nI4ChSAOS1tejaxJocS8domNreZwCS9JtClGZZpNoDocx9NKT25bHmmO8QYUc/fY4qvGdzg=
X-Received: by 2002:a5b:a90:0:b0:70b:87d5:4a73 with SMTP id
 h16-20020a5b0a90000000b0070b87d54a73mr7127242ybq.584.1673879093120; Mon, 16
 Jan 2023 06:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20230113205922.2312951-1-andreas@kemnade.info>
In-Reply-To: <20230113205922.2312951-1-andreas@kemnade.info>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 15:24:42 +0100
Message-ID: <CACRpkdauDEys-XyYvb=jt1U6FcKc-qiie-A3W0WQ08rnm42DwQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: use dynamic allocation of base
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        brgl@bgdev.pl, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 9:59 PM Andreas Kemnade <andreas@kemnade.info> wrote:

> Static allocatin is deprecated and may cause probe mess,
> if probe order is unusual.
>
> like this example
> [    2.553833] twl4030_gpio twl4030-gpio: gpio (irq 145) chaining IRQs 161..178
> [    2.561401] gpiochip_find_base: found new base at 160
> [    2.564392] gpio gpiochip5: (twl4030): added GPIO chardev (254:5)
> [    2.564544] gpio gpiochip5: registered GPIOs 160 to 177 on twl4030
> [...]
> [    2.692169] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> [    2.697357] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> [    2.703643] gpiochip_find_base: found new base at 178
> [    2.704376] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
> [    2.704589] gpio gpiochip6: registered GPIOs 178 to 181 on omap-gpmc
> [...]
> [    2.840393] gpio gpiochip7: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    2.849365] gpio gpiochip7: (gpio-160-191): GPIO integer space overlap, cannot add chip
> [    2.857513] gpiochip_add_data_with_key: GPIOs 160..191 (gpio-160-191) failed to register, -16
> [    2.866149] omap_gpio 48310000.gpio: error -EBUSY: Could not register gpio chip
>
> So probing was done in an unusual order, causing mess
> and chips not getting their gpio in the end.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Dangerous but beautiful change. Let's be brave.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> maybe CC stable? not sure about good fixes tag.

I wouldn't do that from the outset. If there are no problems
for a few kernel releases we can think about doing that.

Yours,
Linus Walleij
