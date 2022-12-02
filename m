Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FA64098C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiLBPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLBPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:48:11 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807195800
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:48:10 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id j19so2460414vke.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2WCgdexCSnOP3jsTOfhvVQsi6dij3FdbBYBs2XpV8hk=;
        b=oSJ1gCC0lCI8Cb7UB7pNoUw+vbSqonz1W7vCW7LCHMg/dWFRG5zneyaVXS30ENWd4r
         aFvbWq+eMA8GDsNeiNPZ3PrmI7U9TJ9aK16UjqH5ISSRls6zkCIJOIRn3IO5ajQf6xNF
         kRVv+cF83jVT4xPBnGVeBZBZqwHV2j+xLmRLrIEQiLTOUXlQaKS5dZ74v3w4p69KOhwj
         4fgKkR0h8M/h/sT1BiLZfGXRnucqOQ50WO2iDwYVmiLmmasPPf+vJx13tBL5fFHKNEz7
         x3+yd/e+WnS0FktpBk3SjUfJ67huDGxs26xk4Ti8GTbGqG3moTOqfYIi3RTmlTUoEOPn
         FMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WCgdexCSnOP3jsTOfhvVQsi6dij3FdbBYBs2XpV8hk=;
        b=BGkxghTHVjOxrGUn4uMUpjSFQyhhfAdI6Mp6CC4d2c0ARmXj+YdbT4EvHCTxylV4l5
         G+itubA5c4CME/b2pPwcDzXX0b58L1DYKftBk6J/b7EJs/f9+hmCakfVD78qyXQovQOL
         J0Hmb/15MZP4Hm7szDucqhKek4zwXCZgZvMRZgNWjzQ7k+k4jlGKHcjxqyZ0PVB0jqDA
         lS0/8Ett5xV5PL57YaAeMdziLHm7RYcCJV5t36synt66geer4Tlxp8ClHXid0RsWnwXl
         PwTVAv3GuETGpA6pMEnRG28LRar/OkjNDjdx4T6Y2a02cg+i0zQbhsUO/dDjoB3ijuVR
         MmwQ==
X-Gm-Message-State: ANoB5pmbu4sM7ONDjHJbBKXRN50cy6xUtjPIHglSLCjhTJK88+1D0+7j
        pcm3YdU1OWkYKdy9W0Znaj1t7clfnhAV5N9xek8ygA==
X-Google-Smtp-Source: AA0mqf4BQnLz/2MMkkoDIMheY7cdKHy01NaJcElptwz2Sjt35xMUWOZFvLiwl0dOGlpXfiDbs4WHoQ1lO8a1VOS5oZw=
X-Received: by 2002:ac5:c915:0:b0:3b8:7fbd:9554 with SMTP id
 t21-20020ac5c915000000b003b87fbd9554mr31077536vkl.27.1669996089310; Fri, 02
 Dec 2022 07:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20221202150444.244313-1-brgl@bgdev.pl> <20221202150444.244313-3-brgl@bgdev.pl>
 <Y4odem+9MTsm3VPh@smile.fi.intel.com>
In-Reply-To: <Y4odem+9MTsm3VPh@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 2 Dec 2022 16:47:58 +0100
Message-ID: <CAMRc=MfcVAeEMrd61YeMuwmVYRxsZUoVeEKFvpeVaei+1RrYBQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 4:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 02, 2022 at 04:04:44PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > While any of the GPIO cdev syscalls is in progress, the kernel can call
> > gpiochip_remove() (for instance, when a USB GPIO expander is disconnected)
> > which will set gdev->chip to NULL after which any subsequent access will
> > cause a crash.
> >
> > To avoid that: use an RW-semaphore in which the syscalls take it for
> > reading (so that we don't needlessly prohibit the user-space from calling
> > syscalls simultaneously) while gpiochip_remove() takes it for writing so
> > that it can only happen once all syscalls return.
> >
> > Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> > Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> > Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> > Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> > Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > [Nick: fixed a build failure with CDEV_V1 disabled]
>
> > Co-authored-by: Nick Hainke <vincent@systemli.org>
>
> In Linux kernel there is no such tag. And in case you want to use
> Co-developed-by, you also need to add the respective SoB one.
>

Right, I forgot the tags got standardized. I will fix it when
applying. I'll fix it directly in the for-current branch and let it
cook again overnight. I'll then resend my PR tomorrow.

Bartosz
