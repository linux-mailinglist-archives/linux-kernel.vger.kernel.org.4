Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BEE62D5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiKQJFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbiKQJFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:05:05 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B635A6E4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:05:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f27so3505229eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5zhSt35S7o2sfRbbzRgd2mNWx5Jr5hPu7WjLb8VLqDs=;
        b=SMYpW52Gep2/BpihE2T9vuFlUgkUOux+5U+YRc1GVgDqJfoxxfGoMiyxKMGoq/weON
         isuKI+IiKh5nNbyJMdVfYOHfXIuM9vTJiLHCJ/R9F3/HaB9J82FdnKsfg0+EIxKSLqLO
         EAyUNsj7P2nZo8cccxdNXx6TntrfAZBWSEhnfbyOqAn2ob7J6GV7iLhdfMIQyx9iaUfN
         nhnUCJOb+ezCgzNO8Paldo1NrGQnwwta6lxkSaTNobtOQoR6uY9pFevnu7VlHfwseJd0
         M2KpxVaXTmFpTwv8+KGvkwk/2oTVVDl2v54TSTIwrEcrkIzddTqU3Hllohy5C93G+DrG
         ORCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zhSt35S7o2sfRbbzRgd2mNWx5Jr5hPu7WjLb8VLqDs=;
        b=oZweOXyuPqzSRlDRNPFwLxBCCTXVKg2qZpcWuyIaoHbR8bnNmjI8JGxRnXag7cpLtR
         TAqBPzSt2yCc+VTMXDhCfhqxOiiO5+fyFBZSzGblvdUSqLuYLBdvIOmY2ZNwzGBzkD+s
         nRTFEfBZXUR3BbxbDzKuKQQKJZJ1tC1IyssDB011hZh4UERb2INrGg7ZxJQPsi1deUyT
         S7Cbvpm/+QWTfKpd2ng3G7LTlWfjDtPTUFxjUK3mJxP2iJ/Po0tV0JuBWd+GKhwfjelx
         Be4krABaCDZYFG5W9mPUhM0zCSHiT/UgjyI83GHZA+vJwqqkCXmAdqopCP+Yd9Ugw3Xk
         cDRA==
X-Gm-Message-State: ANoB5pkqxBaKbTrAEuOW8vtj9wy4ADZJLddJ/868dttoevVsSAFbE0ON
        XgHojIUv8j3HDGfDP0q0noXmsoCERnHRDvqnsitcmg==
X-Google-Smtp-Source: AA0mqf4jESMSJ8qf+MvMF6FWuVGMIIjRR1zpeVeaMq4fFJ1pPW1kwXjQbdlFyriIG7MG9vZJlwJzhJumHCs3jXo6dDA=
X-Received: by 2002:a17:906:7c44:b0:7b2:7096:6c2 with SMTP id
 g4-20020a1709067c4400b007b2709606c2mr1387844ejp.526.1668675902339; Thu, 17
 Nov 2022 01:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 10:04:50 +0100
Message-ID: <CACRpkdbWp=JjQCps1+KOw8G8yKUQ0zp2iU8=_sFNoUO+b8ntmg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: i2c: s5k6a3: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:11 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes one of the last uses of of_get_gpio_flags().
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> -       sensor->gpio_reset = -EINVAL;
> -       sensor->clock = ERR_PTR(-EINVAL);

Looks unrelated but makes sense.

>         sensor->dev = dev;
>
>         sensor->clock = devm_clk_get(sensor->dev, S5K6A3_CLK_NAME);

Given that it is initialized unconditionally two lines down :P

Yours,
Linus Walleij
