Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498C63F038
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLAMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLAMMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:12:55 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618727DF8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:12:53 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id j19so722653vke.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 04:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rol9bw83CkoxtGyUtiilh1SIXA2LJM2CJhcjmTXNIc=;
        b=Q4OggyrX/Axw7OOOfmOPW/vOxf6sfnNI5XbAA4CsmLVIKEbfgjRYX1gXeHtJ2Ie+qg
         tlwtbvq1vU78J7LdRSHj516WssI/PwNauH1jWRNmxFE3ZLPNCqsx44QZWbbo+yQ2GzXZ
         k6rt9CEyXl6A0WoNoZ/XgYWKzOwEnKB/OxLCjF5nV/H4FeuaU3VXqRzfZhQ2mpQXwDBJ
         7uV9t88RRlDpvllrcL4Je6Mh/fWSnjMS/GWgFEQRAMS3LOIxcF4/hYClmBPj2vAj6cZn
         eJn2FOk1Tcu+LiKR/h42Ih2f5+X8WnjnsJ7ICJMOGkZG1lBMpklcyRjLNlHPKVC7KiKv
         B7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Rol9bw83CkoxtGyUtiilh1SIXA2LJM2CJhcjmTXNIc=;
        b=ov7hC35HfOg4rIaAmHg1bod26DLzkGnSNzHvACoud3FAE2elCKwaJJt97U5+0t4efS
         AAo0Es+ohK3sNUGkIpqSzpVQlxu9Qk+a+625H20UryhbKdFkPKn8uWWgcRjlOC4BqaHh
         L6fNNF4bEmotBGaTZ9DuOTVjkFPyHiII0B2dVtkpD0/ty2/AHRui5VnSQ5ZLusAlva+n
         DAizEkQgznrNJ73X2CEytHxAs3/zp7zwi55uBGop37L0vUx5RD6rmmguQCngnKynnQIe
         dwqfz75wHh9GG77ZqdIrSA3sjmkddizWGRiZohf9ltNdEU7BMyEtaDEuDEKvObq9qTO3
         XJfA==
X-Gm-Message-State: ANoB5pnVMiQCscJfohvKh9vav+ticLKhxFTHjt8aXJTv8B9BEBU5m+Ap
        pzAKdmPI3tRBhFss0nL8Sbct3KJjIg6HkEOVeZ43d6pzeVO9tA==
X-Google-Smtp-Source: AA0mqf4aZT6ISsIpwleKcNpxXXjGDZ3wBaomcxNFq0Xzu5mVS5wCQ79yzbKUP//rlifMsvqTc/DuU/saIQUN7yMBl1Y=
X-Received: by 2002:ac5:c915:0:b0:3b8:7fbd:9554 with SMTP id
 t21-20020ac5c915000000b003b87fbd9554mr27692649vkl.27.1669896772309; Thu, 01
 Dec 2022 04:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20221201083335.819190-1-brgl@bgdev.pl> <20221201083335.819190-3-brgl@bgdev.pl>
 <Y4iXoC+AE6AH5ze4@smile.fi.intel.com>
In-Reply-To: <Y4iXoC+AE6AH5ze4@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 1 Dec 2022 13:12:41 +0100
Message-ID: <CAMRc=McBPpLx4Gac-uR1S9-kQBE=AVLbFfWSrTWN6RNXwvaTRw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Dec 1, 2022 at 1:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 01, 2022 at 09:33:35AM +0100, Bartosz Golaszewski wrote:
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
> > Reviewed-by: Kent Gibson <warthog618@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 166 +++++++++++++++++++++++++++++++-----
> >  drivers/gpio/gpiolib.c      |   4 +
> >  drivers/gpio/gpiolib.h      |   5 ++
> >  3 files changed, 153 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index 911d91668903..18c5e70ee7de 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -84,6 +84,53 @@ struct linehandle_state {
> >       GPIOHANDLE_REQUEST_OPEN_DRAIN | \
> >       GPIOHANDLE_REQUEST_OPEN_SOURCE)
> >
> > +typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
> > +typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
> > +typedef ssize_t (*read_fn)(struct file *, char __user *,
> > +                        size_t count, loff_t *);
> > +
> > +static __poll_t call_poll_locked(struct file *file,
> > +                              struct poll_table_struct *wait,
> > +                              struct gpio_device *gdev, poll_fn func)
> > +{
> > +     __poll_t ret;
> > +
> > +     if (!down_read_trylock(&gdev->sem))
>
> > +             return 0;
>
> EPOLLHUP?
>

Or even EPOLLERR | EPOLLHUP.

Sorry in advance for the noise but I really want to get those fixes in
this week, so I'll send a new iteration shortly.

Bart
