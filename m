Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5978266BA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjAPJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjAPJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:36:53 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E2A16AF7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:36:51 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id i188so28434113vsi.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vZDzGp1KKkhfM8yX97JcS1v/sMvjHBKDe46htixtPU=;
        b=m/l2LsfUDSpxG541JjmPyGuB+hbBdh5SdeePEefj2XNWY8UwjrLpF0FUC+XTZ6rLnX
         lCiopmVRAjw5T8M9/7bl8tYM/LTzG/ONzxxCvompCkVfRXqmHTbXIYPehgN/D+x/q9d7
         UamwFurOqRCP2W/8FZaBYfs/PonW4XgWjJeUsMaLDYM9JYzlk48hfZchqkHU4utc6ADv
         iLSX8rgqSPXEj7eBSdqHxw7rRVMU4dYVjWhilH4n6kSs4J9Tor++gVuTHfCmknzyDmFV
         YGvghjLrxqYYBZnt0qs0Zk7IBb7oUfUoAzJXkR4lDJYzKuThe8DbMR0CP15eAbOE4plX
         ALGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vZDzGp1KKkhfM8yX97JcS1v/sMvjHBKDe46htixtPU=;
        b=uRZ3YqJr1cEirPixUQiUre8j5oMumaNm7xlQ3W1A7dfYxZU0HaHJNrUsqzKBmP/fYm
         O3gkc65JaObXUfqZPmSaW56usdOkCI6+9kXA1ahYK+3VrzROZB5GkKmXLYNmgIEYptgK
         mEm7PAUpzaGjeyDUl9gRlp3e6Etki5EzFs5VhPBi0xev4+JljzmZMvayNMFf8jyw+l60
         TV4fPWF70mR6h9E/sKVqjW7d31V0JeyZQ2EnIXDOFDzWA0bp5Gwu14ne50E/nei/x8ss
         1PdaBIT5qFMQDNrA3F6ECL3ayH2mj218/lQzUeCrDNxl6/53dScPrFDYaGSyV/R8VGy8
         9vWA==
X-Gm-Message-State: AFqh2koOeuF6gtzJ22JizL0MXylEbPoltd/r9DWl44BPyXjpkNhaGKYq
        CEfaYyJ3rvioGeGeakiLwWlSCcw5LTpLqH4hSjU9mA==
X-Google-Smtp-Source: AMrXdXukZWpY89TRsDaLxwZvOkdNK4FnXVP8N+shf8gAPwcQb4C8wy3+2HpGuXgCdTiUKMCK1KpMWboqQyGGN7PdzBY=
X-Received: by 2002:a67:df09:0:b0:3ce:88b3:d7da with SMTP id
 s9-20020a67df09000000b003ce88b3d7damr8050923vsk.62.1673861810844; Mon, 16 Jan
 2023 01:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 10:36:40 +0100
Message-ID: <CAMRc=McT3LmBnPb3LVkAQJ6DP5jcbNEiN-QZsiiX1-jsd4oUqg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] gpiolib: get rid of exessive ->of_gpio_ranges_fallback()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The ->of_gpio_ranges_fallback() repeats the idea that lies behind
> ->add_pin_ranges(), while the latter covers more cases that the former
> hook. Drop the former one for good.
>
> Changelog v3:
> - moved check of the property presense to GPIO library
> - split out the refcount fix in a separate patch
> - added cover letter
>
> Andy Shevchenko (4):
>   gpiolib: Check "gpio-ranges" before calling ->add_pin_ranges()
>   pinctrl: bcm2835: Remove of_node_put() in
>     bcm2835_of_gpio_ranges_fallback()
>   pinctrl: bcm2835: Switch to use ->add_pin_ranges()
>   Revert "gpiolib: of: Introduce hook for missing gpio-ranges"
>
>  drivers/gpio/gpiolib-of.c             |  5 -----
>  drivers/gpio/gpiolib.c                |  8 ++++++++
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 10 ++++------
>  include/linux/gpio/driver.h           | 12 ------------
>  4 files changed, 12 insertions(+), 23 deletions(-)
>
> --
> 2.39.0
>

For GPIO part:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
