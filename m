Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC6729CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjFIOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbjFIOUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:20:50 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AF30F3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:20:48 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4652fcb2ac1so681282e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686320447; x=1688912447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk3Y9EY/4G9t9554iAhtE5UPK2oRaV2wjbMFQgOsj4I=;
        b=VKe7oCjq3SxEv/zxvpmeCPEMsVzpU/uXXB32eR3nP/Q54+eWPv5yW519jwdlM8eCAW
         I9/CNthU03pURfKTkT7dAj+3lzCmw671scd6Bg+6EwVwar2zO5/G5pht0YNjyE2FWJ1r
         PcRZKFGInC3Rw3AS+YUHer6TKXOvhx1ZouNW+PR9lkn3g1O6PqijaO1yMrYoELDpAto3
         L8O5yViC5H+WD9njoPNSIV4m9xoyhQbOhxfWYRnOlN+EukFCEfd9JzFuDMbFgsHphNho
         SXHHhZ7AscKG+5oae0vR/hV7cOUsZrJnzvHFhi+6MkRhEt3LtUZQHGz+HcyvxynYj2AT
         KbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686320447; x=1688912447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk3Y9EY/4G9t9554iAhtE5UPK2oRaV2wjbMFQgOsj4I=;
        b=gp9qN+XLbBXx8qrZSK86BvixVz2TEqby31/LsDqCjLWkBWmHi5hkoOf67YEzKi6Psi
         eRWobh9RFQGerMXzJTFqdzfRCEBVx4V/HXmlGG4AKb9TXZhzgr2JxW1xzg38jwbNqRXy
         gBTXiTvzaMef5SvbbgfTDUdVO+A9sYPhnrHaCj6lplBhJ2MOxk4E8T2YlCY02H3LzDBg
         UeZoZwvU2I42R+pGTJxregtlOCil9QAh9S+sVNgCo1aLNSaLTNXo7yC7qUCWaXaFAloi
         ZcX6jFWnToJxJ0WmZ7H8Quzd+IVZMRg/APnQ+AGp2mxYr2BKTeMQ1vYZ8Ic/QSfzPzNB
         cvaw==
X-Gm-Message-State: AC+VfDwOKReWrsUs3fC93jvycP+NDUy6Xw2XB0dGdWwQFsJsSeH+Y7BW
        tbx6BCOnobIeQB9IYnXmrPgpGvSwtTiW7MJuNbA16A==
X-Google-Smtp-Source: ACHHUZ6jGX+k4hnv6McRoA+4AoD6fg4EicSO/DxfodOR/w9eMQZrCgZHfLQJJwAgIcFLs2P71TEEP8r839ZKblOhrTQ=
X-Received: by 2002:a67:f794:0:b0:436:4da:8d63 with SMTP id
 j20-20020a67f794000000b0043604da8d63mr953067vso.27.1686320447446; Fri, 09 Jun
 2023 07:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230605125248.279921-1-brgl@bgdev.pl> <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
In-Reply-To: <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Jun 2023 16:20:36 +0200
Message-ID: <CAMRc=MfD1Ju-QCZbr87nP987RMSDko=t1R2cXGmSjdJhdPR5hw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 3:47=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wro=
te:
>
> On Mon, Jun 5, 2023 at 6:53=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Drivers should be silent when they work correctly. There's no reason to
> > emit info messages when GPIO lines are hogged. Demote the message to
> > debug.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Suggested-by: Kent Gibson <warthog618@gmail.com>
> > ---
> >  drivers/gpio/gpiolib.c |  2 +-
> >  drivers/of/unittest.c  | 16 ++++++++--------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index a7220e04a93e..e4515bda8915 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char =
*name,
> >         /* Mark GPIO as hogged so it can be identified and removed late=
r */
> >         set_bit(FLAG_IS_HOGGED, &desc->flags);
> >
> > -       gpiod_info(desc, "hogged as %s%s\n",
> > +       gpiod_dbg(desc, "hogged as %s%s\n",
> >                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input"=
,
> >                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
> >                   (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low"=
 : "");
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 2191c0136531..0060334a98a7 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(voi=
d)
> >          * driver is registered
> >          */
> >
> > -       EXPECT_BEGIN(KERN_INFO,
> > +       EXPECT_BEGIN(KERN_DEBUG,
> >                      "gpio-<<int>> (line-B-input): hogged as input\n");
>
> As debug messages are normally off, I think you can just remove these.
>
> Rob

I will send a follow-up.

Bart
