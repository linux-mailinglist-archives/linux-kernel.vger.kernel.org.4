Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D6623F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKJKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKJKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:11:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C64244
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:11:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 21so2339896edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyWP8Qo/HxTXDgeigbMvkDgupAW/Dac8rDlqgY2S6sA=;
        b=uz0tqgNXxcOFmcKi0H7GqkIvM5igsNcHhRop1pexF9sMdXZSb9UZ3T90IEsUXwEuhP
         uHPhfqZ0jzF7NR7rm0aQiyFph50ILf5QN4QbC0t5R/43ozHsvu/C35xJjDbsj3jjSl2h
         +f8z+Nhc50EHE2HzcAKgWWv7k+i2S2ZKUexv4tSR7M/B0VgdN//wRsEFEs1j3YF1Cyha
         Gypi/UvyJ5rdqbWg+QyEHlQiihaja7F2QVm/iwapOZb2KTCGp+fom7XnD17EpXa6G3X5
         tdgpUnudzGa6lzmOLpPcSKkp4gocFBMvMv8vLIoKgMxF+UafIHS6gt6sZoAsqLsmYhUT
         rrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyWP8Qo/HxTXDgeigbMvkDgupAW/Dac8rDlqgY2S6sA=;
        b=vjr+LP+5dwZRCb6LFukgSIt7mw29DSRdXNj6BUcETjEm5iJlfLPxqg6suqmFcjRvRb
         mS87D47kV6VPZ1RT17CrCO4kyH6rtCeRJCBwFjifswaFePNWczdTrEN3dn29eeCiPPxL
         DABjRPlOefiZQZNklUiYEpn98/FhhX2sdInXjH2VWaCFkOnQGW8XrKma+qBOBf5Jod5K
         0+/urBBSKLizSZ2PtICzXi55GvjRlMHWwNyb8P4Wjclw7OtjPk0bH0Lu/g22z/lwRh3V
         Iir6huqdbvJ0I11ScQfq56bvvzf1mt8jWAVBB3hTS99a4IYsAU/nckuw2cHBQzFAEDtP
         fVMQ==
X-Gm-Message-State: ACrzQf1tIlml6EqzrelgthyUZct+78uhSZM3kBQL7kFkX7XqxRZm+dLc
        fD35Fyuts2Yw1XCXDaXx4OCszdiCIWwnTYMLfCiJTw==
X-Google-Smtp-Source: AMsMyM4cR/sFfUmCFtlVHKGUpQWO3fuQowhBiha5iyninP74qAJwOuV+RWWUuaHZAfCxW2N/yZ2noqQ1VZLdmI9r+k8=
X-Received: by 2002:aa7:c718:0:b0:462:ff35:95dc with SMTP id
 i24-20020aa7c718000000b00462ff3595dcmr61197309edq.32.1668075109951; Thu, 10
 Nov 2022 02:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Nov 2022 11:11:38 +0100
Message-ID: <CACRpkdadxpsnmZ5uSi0-kuEdPzxvYDR=Z9wGuSnU_CjHEf+Nxw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data() for fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 4:07 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_mm_gpiochip_add_data() for fwnode.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I actually want to get rid of of_mm_gpiochip_add_data() altogether and
just replace all of them with regular gpio_chip, as stated in the GPIO TODO.

Hmmm... who is using this...

$ git grep of_mm_gpiochip_add_data
arch/powerpc/platforms/4xx/gpio.c:              ret =
of_mm_gpiochip_add_data(np, mm_gc, ppc4xx_gc);
arch/powerpc/platforms/8xx/cpm1.c:      return
of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
arch/powerpc/platforms/8xx/cpm1.c:      return
of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
arch/powerpc/sysdev/cpm_common.c:       return
of_mm_gpiochip_add_data(np, mm_gc, cpm2_gc);
drivers/gpio/gpio-altera.c:     ret = of_mm_gpiochip_add_data(node,
&altera_gc->mmchip, altera_gc);
drivers/gpio/gpio-mm-lantiq.c:  return
of_mm_gpiochip_add_data(pdev->dev.of_node, &chip->mmchip, chip);
drivers/gpio/gpio-mpc5200.c:    ret =
of_mm_gpiochip_add_data(ofdev->dev.of_node, &chip->mmchip, chip);
drivers/gpio/gpio-mpc5200.c:    ret =
of_mm_gpiochip_add_data(ofdev->dev.of_node, &chip->mmchip, chip);
drivers/soc/fsl/qe/gpio.c:              ret =
of_mm_gpiochip_add_data(np, mm_gc, qe_gc);

Aha PPC and MIPS, OK so not the most familiar territory for either of us to go
and fix.

I guess it's fine if you refactor this for the time being, but let's make it
go away soon.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
