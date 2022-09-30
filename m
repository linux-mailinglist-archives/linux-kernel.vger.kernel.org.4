Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088E05F0793
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiI3J2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiI3J2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:28:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD63E3183
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:28:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so5936455wrm.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=h6Y+ln/AdUV/+FxfyQmPViV9sXamO/keUdsvmUY59qs=;
        b=CFz8Zd+m5KtzxZ6GIMUSBAWbhOflJDB9Rvw9+BrS7BN0SJdMeihWtvk5Dt2B72cmQ1
         CflnSVU407UPiIBjVmCKVvLc6Nhma9fdRT+tVz7Fp9ycmrg0zGZkybGqbv2cYPSTR36a
         XE8ZUw4njAvnQhpkLYrAbnVD+60qO6toJVq1lWgrNGw8H5mc7mn5V9i2X7x/CgsdGdEg
         V1nZYlLceY+iJLZ+wtBhRx6poeaQtYOcVQSFY7fjpi14BgqdKuJLqMmBmFoLM1Xf/Wby
         jAX1OQsm1ZxtbGf+djJcJmmee9vA+OsKI8uAG4/SVjstfd8HDnY22gedfac6+BTjlOby
         6GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h6Y+ln/AdUV/+FxfyQmPViV9sXamO/keUdsvmUY59qs=;
        b=3BDw9oV+owalsyjhvtgpNKT3Nym2y3+RQQEsOWXfnJT4c9iVkfS4NQ5QiT8ZD9WtGN
         MMduF910gVZ3vH8k+ut7YxHfW/0ACwYag8n2/wtLQUOcg5LpB5mA7cMQRZkfz65vQRxs
         Dv7/4ClwUPEqJbqHij9Q+GWdNCbklk15sbUtqmIG4l+cTLZFHnXru2CMj8Og5sGWlNdV
         2Y4ul1nYvGiNyR+AqYz8RXQZWzyFmp4R7zPVBJioKhXjgjyt0z3ICuUJahYqpftEWRck
         NNOtSK4gVeIkFI8tXMwf5+KnOMO66Z+E5St+NOgllHnrrDEm+URazit+je9ySFwgL6uI
         p2fw==
X-Gm-Message-State: ACrzQf2qQmcgWQuwydPhrM9pweimb/tWds1hvREgFT7K6wroxsa2/15C
        7f+Xct2QOA8GkkBX8FQKtiWVdhUdSCkgygZ00ckC9w==
X-Google-Smtp-Source: AMsMyM4ID74hUk6obFHS5CG+0lfrWS0Qhz0N0x7XapUctxqBBczmx+I4mtCvy/aUxSx9DQVnvphAUH2f2VunyWQq2lc=
X-Received: by 2002:adf:f98e:0:b0:22e:393:8def with SMTP id
 f14-20020adff98e000000b0022e03938defmr723627wrr.570.1664530114671; Fri, 30
 Sep 2022 02:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-13-jay.xu@rock-chips.com>
 <CAMRc=MdjFbzjiLg==ppX_e7cWVw7s1B+Dd=OvrYsnL4ZC_daMg@mail.gmail.com>
In-Reply-To: <CAMRc=MdjFbzjiLg==ppX_e7cWVw7s1B+Dd=OvrYsnL4ZC_daMg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Sep 2022 11:28:23 +0200
Message-ID: <CAMRc=Md5jyvSc7RAHOQ9=d1TWhidTd0JppCmR8enK1ttPr2w3w@mail.gmail.com>
Subject: Re: [PATCH 12/20] gpio/rockchip: add return check for clock rate set
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        andriy.shevchenko@linux.intel.com, robert.moore@intel.com,
        robh@kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:17 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:
> >
> > Check if the clock rate set for the apb clock is successful or not.
> >
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> > ---
> >  drivers/gpio/gpio-rockchip.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> > index e36cdbd4bbef..511e93a6a429 100644
> > --- a/drivers/gpio/gpio-rockchip.c
> > +++ b/drivers/gpio/gpio-rockchip.c
> > @@ -199,6 +199,9 @@ static int rockchip_gpio_set_debounce(struct gpio_chip *gc,
> >         if (bank->gpio_type == GPIO_TYPE_V2 && !IS_ERR(bank->db_clk)) {
> >                 div_debounce_support = true;
> >                 freq = clk_get_rate(bank->db_clk);
> > +               if (!freq)
> > +                       return -EINVAL;
> > +
> >                 max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
> >                 if (debounce > max_debounce)
> >                         return -EINVAL;
> > --
> > 2.25.1
> >
>
> This cannot happen, clk_get_rate() can only return 0 for clk == NULL.
> We're not using an optional clock.
>

Ah, sorry actually the db_clk can be NULL for certain variants. But in
that case shouldn't we just silently ignore it and return 0? Or return
-ENOTSUPP at the very least?

Bart
