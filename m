Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840C65971F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiL3KIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiL3KIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:08:42 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027E6167
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:08:41 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id i32so3279278vkr.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nG1e1EB+LUQPoePLVsT1vw/B+SKuWdrVdgTLpmKtQck=;
        b=rSdqNet6OApI4Iukuk5+KjHsHYiQpYEQ8Z6tFVOzFpSpCR3NhRMmLO+xU6f+vrrEZX
         vcHj7E4uppyBzsfFc4daKrb2d34xNBjQBQTWnXeBjO85CFgU7QMOMUprbjkPuAZZE8EM
         gZw7g+cq5bBLiJrVs0I48WhIKBHuH7aPOXWygZ7a3hFty9cFLNaWcMFoJlkG0j/GfVXR
         eAjmfkGnFMm8nA9HFVR2M5APi8ByIiQE9YeZuWuQn/XLj87wTT1Sf67+jI98ExO7ZmAm
         DgRoTThMfCK/eVOjXcXBhhKBUWZ62d/NITzk2ogT73WCEh0rnVdZZZkHzHH/ZlB6c5Rp
         r4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG1e1EB+LUQPoePLVsT1vw/B+SKuWdrVdgTLpmKtQck=;
        b=dSxqW9+uGu6w+K/fs7iYxh/MlyNHDd1hocQC6Yg5KgEbOf4YGHdiU/6azjvqQZzelS
         434nMgeBZiZf6JJA/RJD3THtAWBPMhrCtk1BhbRilcyg/AfK7AZx49hFfWp3kgHd3GrQ
         9vrX8fx+yyxHP/uYmWXI9L+ViAAFKyGuJW668hISdzCrGbxhu9U9plVbMhvRYcu3Sk0x
         HepyHyFDB8fLyb97V9Ng8SA+CdetA1qGtK2RAcj2XpETNhOElJuaaDDkOvsgb9W2BUHu
         jLpuV8xscpnAmQv1/wK/jHcZqwOfgAiyZnkdbhpnf2MPiPBgT9QgG6iSdaDLxcKLE30z
         hOog==
X-Gm-Message-State: AFqh2ko781Kn4QEVloim8yeU1aMWnwHhvAXO3RyHyIWBUyF1WMBF4pq2
        d//liZUF1IUOo7EPW3937wJdIgAVsWmx18Q8D1jaEw==
X-Google-Smtp-Source: AMrXdXvTRymNFEOxroNyd90FbjoDvofx7povDWugU+kFCNEInZg+Myf0ov7ov540e7rppxIjGc0RNZNuq2crZhetvtA=
X-Received: by 2002:ac5:c382:0:b0:3bd:e0b8:e350 with SMTP id
 s2-20020ac5c382000000b003bde0b8e350mr3451224vkk.25.1672394920937; Fri, 30 Dec
 2022 02:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20221213135227.14398-1-johan+linaro@kernel.org>
In-Reply-To: <20221213135227.14398-1-johan+linaro@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Dec 2022 11:08:30 +0100
Message-ID: <CAMRc=Mfp8HyQiUJdsNPQFHK0bosA1Qy=jvdmxOSVAzNo3AO_2w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: use irq_domain_alloc_irqs()
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 2:52 PM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Use the irq_domain_alloc_irqs() wrapper instead of the full
> __irq_domain_alloc_irqs() interface, which was only intended for some
> legacy (x86) use cases.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5a66d9616d7c..ede9630b197c 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1126,14 +1126,8 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
>                         /* Just pick something */
>                         fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
>                         fwspec.param_count = 2;
> -                       ret = __irq_domain_alloc_irqs(gc->irq.domain,
> -                                                     /* just pick something */
> -                                                     -1,
> -                                                     1,
> -                                                     NUMA_NO_NODE,
> -                                                     &fwspec,
> -                                                     false,
> -                                                     NULL);
> +                       ret = irq_domain_alloc_irqs(gc->irq.domain, 1,
> +                                                   NUMA_NO_NODE, &fwspec);
>                         if (ret < 0) {
>                                 chip_err(gc,
>                                          "can not allocate irq for GPIO line %d parent hwirq %d in hierarchy domain: %d\n",
> --
> 2.37.4
>

Applied, thanks!

Bart
