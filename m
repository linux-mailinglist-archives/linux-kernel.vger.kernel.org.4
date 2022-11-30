Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708763D531
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiK3MFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK3MFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:05:48 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E16F83B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:05:45 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id q128so747351vsa.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hf1qRYN6r+K6awT+A5FQ/i9EB3gFTSjawUsnr7VgYOI=;
        b=N3HcGd5LBbiDI2OXkCxwdVGRRVdwvuq95kRrJzKwcn4dlf6w5tZfi00md8fZJeN7X7
         2nijyDPBoC8tvoKMX/mYKbRvTK+I++sX7qqylCATy9NYI/Fc11lmyLN+sD1NNPNT/tyg
         D961odu1nzXaHwNF6+fuhtycaUbp0z5ppxKcuJ9nPq8UhKMrof4clSltxZtsFRKugrYy
         GnTi2RZi28eFUnNcMGWTt0duKrb9H/onXUjLgGMSrHZBMigOr7Yy8hiX50w6QzQ8xPzR
         5QmMQoi4n6ZzI3/HXOnqWjGBbdYYCJgiegLekEuovMcJZCSpGm1aNsFVmFi4VuDtrovc
         OrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hf1qRYN6r+K6awT+A5FQ/i9EB3gFTSjawUsnr7VgYOI=;
        b=ggmjVupR+8tDMr+09f682igVs7ZwQvCp0imc1I2c/BKAPFVcldNahwsMkOoxDLm+i1
         BpVVPp4epuSnXzoez2rB+qYsm5Kn+XvK+HQcy/y+RXfabchNov+9nuuL55v1rbF1Zr+8
         pHpyaThc/SXe7huknO+L7OL4GBe3i50BHc40PqYqw5K077DQAXh7Nm12J5kPcnQR8NNA
         alMfUTON+gV2QOB5fOAh0fPQDjftqo65hM3XpBARFBHVYbTFYk6FNAS20VeJpRNZ4XUc
         2geVSbbXVMudSx5CxVXohas3zAjkVPdbc5+LX605Gc/tEWkR6EUcSLnxvSpIyjsZbuEC
         8mPA==
X-Gm-Message-State: ANoB5pnPzGw1X9yv7/YCyHsBwt7KnYIbAKpcoQ77HCJyQl03DcJm9C/E
        q8QOwQFYBhBzhxy0SU+inoiE1vubnuiOEEMxLkiVQw==
X-Google-Smtp-Source: AA0mqf6cREJJrfFNlZQOlGFnXEQCxwOpdWe9CL05TwYqxpVSuioAXEU4tKphuBSu0tulOvP4KoAmK3qPfpxzq+CiYRs=
X-Received: by 2002:a67:e8d7:0:b0:3b0:767f:e291 with SMTP id
 y23-20020a67e8d7000000b003b0767fe291mr20265811vsn.47.1669809944163; Wed, 30
 Nov 2022 04:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20221130090556.40280-1-brgl@bgdev.pl> <20221130090556.40280-3-brgl@bgdev.pl>
 <Y4dGNy4vlDEUUFlw@smile.fi.intel.com>
In-Reply-To: <Y4dGNy4vlDEUUFlw@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 30 Nov 2022 13:05:30 +0100
Message-ID: <CAMRc=Meo7_YuNEHPn0zH7FoRaNOXhd5B0Z664jeZcrhzngW=KA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpiolib: protect the GPIO device against being
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

On Wed, Nov 30, 2022 at 1:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 30, 2022 at 10:05:56AM +0100, Bartosz Golaszewski wrote:
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
>
> Bikeshedding below and one question.
> (As per tag I'm fine with this version anyway)
>
> ...
>
> > +typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
> > +typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
>
> > +typedef ssize_t (*read_fn)(struct file *, char __user *,
> > +                        size_t count, loff_t *);
>
> <bikeshedding>
> It's only 84 is on a single line.
>
> Dunno if it's better to have typedef followed by wrapper pairs rather than
> all typedefs and wrappers grouped.
> </bikeshedding>
>
> > +static __poll_t call_poll_locked(struct file *file,
> > +                              struct poll_table_struct *wait,
> > +                              struct gpio_device *gdev, poll_fn func)
> > +{
> > +     __poll_t ret;
>
> > +     down_read(&gdev->sem);
>
> Thinking more about this, wouldn't be better to actually
>
>         ret = down_read_trylock(&gdev->sem);
>         if (ret)
>                 return ret;
>
> ?

You mean as in: try to take the lock, but if we're already removing
the device (as the down_write() can only happen in gpiochip_remove()),
then die right away? Smart! Yeah, I'll do it this way.

For the rest: I like my version better honestly.

Bart
