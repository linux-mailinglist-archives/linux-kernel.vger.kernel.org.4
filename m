Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C162697B27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjBOLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjBOLvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:51:43 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2C37F12;
        Wed, 15 Feb 2023 03:51:42 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id n9so582635qkh.12;
        Wed, 15 Feb 2023 03:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXaEvrNDBi2xYStoe9dSpvKrnOnpCh86GTJcWGZ1v64=;
        b=D/r+Y9pfSR1bw1mfU58zZPwQ+4n7YSmBx4snTYohpJsVyFZaUHuvsrLriwtbwQUn/q
         yO5L8zRbmIJb5aPV5Mf+M3hm3J1ydmuHqyZpx0cSyUXlTcb8+DI9Q9YtBqjR9y9V3tLo
         FxbZ7fch0VtSC71njI0a0kQH7gXYKQnwn3qj7kN1XCLSJFB1DkwnHRiAVIOegq+q4h+1
         mldpMk0RMSLMRypebwRFuyrxSn3VY/RVuHbmeBXvpTL++A3NziU/pnieTXIDMjuNdeTc
         Ub6NrgJos5e7gWrADk4SLualQOhlhf59pXBqI5TLUjtKhsi4J1+5aXD5AkRBfpjRlwE+
         MDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXaEvrNDBi2xYStoe9dSpvKrnOnpCh86GTJcWGZ1v64=;
        b=ojNUHWAYaou3QP+9kcZEmutbWPtSki3xQio+eRLEQ//T68A9yTEUKAn7CjKAz//ss5
         vx7S5PXpS2NSNqy+ciOGe8Q3AqefQSdTA3ZDYAeoiabkneXm7cF4vuL0EFdVqu52emRT
         MdMp6WjVzGWy9waLVR/KmbQc5D4MI7Y9JmZ18hgh6nM0UChfz2QRC6bhiwr8EMIc7m7U
         cbGL2TZt9tkkba3inUH+WYs9+R2tJJbqHv235Dl0IkSsJMNx2h187RyWN6EeE4fl/p0g
         VEmhBbYaboxAMh7pGlp/SHuAd0DUX3qIRZhR2k3dg4Zo9LWYsTRraHVhu/Q2fxUcCozm
         RyQw==
X-Gm-Message-State: AO0yUKVrYkkdMUpBZFwx8FxjeGTgk6/1WTWd/1J5qq9RXVyQzAEsXX8i
        6X8bvqHlLxTSg2A2EbQp3HAP+i54QBV7KKNWNJdVOcDvM4o=
X-Google-Smtp-Source: AK7set9a2blACOQbvid4QzlPeRThxlMEsngAnHQ1z0PMYJV2UR8daSPiv4hjeew0rfhXaDp15/YxqsyblokFvBFT8FY=
X-Received: by 2002:a37:a89:0:b0:725:ff53:b58e with SMTP id
 131-20020a370a89000000b00725ff53b58emr119421qkk.331.1676461901049; Wed, 15
 Feb 2023 03:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20230214073638.571417-1-alexander.stein@ew.tq-group.com>
 <Y+tn3Y+SraIetn5X@surfacebook> <CACRpkdYHJOgO9K_H9QA1_VWgParbh+Xqh-oCmo3JAFtaMXYByg@mail.gmail.com>
In-Reply-To: <CACRpkdYHJOgO9K_H9QA1_VWgParbh+Xqh-oCmo3JAFtaMXYByg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Feb 2023 13:51:04 +0200
Message-ID: <CAHp75VeCsbSe1knoDwjMjjg-YAK2K_RwV_giRt=H9VG-KwmQGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: vf610: make irq_chip immutable
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:18 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 14, 2023 at 11:52 AM <andy.shevchenko@gmail.com> wrote:
> > Tue, Feb 14, 2023 at 08:36:38AM +0100, Alexander Stein kirjoitti:
> > > Since recently, the kernel is nagging about mutable irq_chips:
> > >
> > >     "not an immutable chip, please consider fixing it!"
> > >
> > > Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> > > helper functions and call the appropriate gpiolib functions.
> >
> > ...
> >
> > > The overall changes are based on commit f1138dacb7ff
> > > ("gpio: sch: make irq_chip immutable")
> >
> > Nice, but you forgot one crucial detail. You need to mark GPIO resuested
> > whenever it's locked as IRQ and otherwise when unlocked.
>
> +static const struct irq_chip vf610_irqchip = {
> (...)
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
>
> That's what this macro does ;)

Maybe I was unclear, but I meant that the above mentioned macro
requires to have the helpers to be called to enable the GPIO line.


-- 
With Best Regards,
Andy Shevchenko
