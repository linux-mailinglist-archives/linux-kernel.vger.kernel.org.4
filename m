Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD08C63B44B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiK1Vg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiK1VgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:36:24 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533312FFCA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:36:21 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id p15so3919210vsr.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiBYnENw+4kIw4ybb7j9UKBvTlAtbXa6xhYQYvm+kJA=;
        b=z0LyDG9SsYTa+eIjxjLDrLfG66aeCVjj5ayzVo44nhG2k4kuk9Q+hLDzseX6Tfs/wk
         /dw0qPCh29LxOI8qtnAvo3DhyPDPOrtFLmVlWEYb++Ikfdmj4Rw5D0cQVO1RoM4h6Zuj
         ZFUy/RTWzfn/ME+ndBTLtm5TZkw1au8gpbsg++rFJ3+WfCs5BsiwQqKpGGWIHSro97O+
         2Yc+/PNk+tyeodRY6NeaXoympd9DE/cEA/i61VDlBqocopUfXVxafQED+NG9N/OjrS09
         dQ1iGBlujgxoTm7EcmoUJMx24gLkm8Fc0QHMmc5uE8YSZHgbvG81OqoPT8kmG/1GBe5y
         gBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiBYnENw+4kIw4ybb7j9UKBvTlAtbXa6xhYQYvm+kJA=;
        b=YoBIXxXdsbVRvOVeFo6oiS66wKogsMGOLg2lLHcUOsp51VPsDqvW6jDEdIuerzLCBz
         +IpD5UC6C70gE4rTWAZKq9qppyLd9lnlEJ+R0vGOYe5wCJs+rhNb1XGcJdngfz9g5qyR
         v3UugqZ57/0Q8lyu2VolmlxQpz4lErafr1ZIbuiHJ6BQObKDHiUKoF5VVB2CYg6MQAhK
         FHsFDK+TEwVLEUsSI3Vdw+O8exbTDDk+zi+v6hBaWEuc8DaU8URxTW1TaZuspD4SpofV
         rV8rWKwF5oUoSco1BbSUU+0O38SmWORm7B8EAtOtwOZlcd+k9WRnlRwhWWuz1vRyFwy6
         SRRA==
X-Gm-Message-State: ANoB5pkuo4R+euPn3dryZPnFnI0RGSxZ5KMwG/UuQADrBiH66Wi0b7tO
        0R3yQ/NuvvcCyvPn298XkEh4D57u8Y4KKvz+aIxRLg==
X-Google-Smtp-Source: AA0mqf6wIAJHNyo+elscewC9lQgg6lxrfGPcLpi6oR0RbBTkhvHTOSsrYeqLa42fH+6NN6xtiUhUq/Owb4qwYbe4hhs=
X-Received: by 2002:a05:6102:829:b0:3b0:6449:baba with SMTP id
 k9-20020a056102082900b003b06449babamr18922436vsb.61.1669671380411; Mon, 28
 Nov 2022 13:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20221128175214.602612-1-brgl@bgdev.pl> <20221128175214.602612-3-brgl@bgdev.pl>
 <Y4UKT2kIHi4T0tu8@smile.fi.intel.com>
In-Reply-To: <Y4UKT2kIHi4T0tu8@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 28 Nov 2022 22:36:09 +0100
Message-ID: <CAMRc=McEi+njG69nx6-+YGa0fxcKh1eY1RqOFYe8q5JVg3Pp5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: protect the GPIO device against being
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

On Mon, Nov 28, 2022 at 8:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 28, 2022 at 06:52:14PM +0100, Bartosz Golaszewski wrote:
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
> Missed also Dependency (the previous change).
>
> > Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> > Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> > Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> > Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> > Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
>
> ...
>
> > +     down_read(&gdev->sem);
> >
> > -     if (!gdev->chip)
> > +     if (!gdev->chip) {
> > +             up_read(&gdev->sem);
> >               return -ENODEV;
> > +     }
>
> Wouldn't be easier to wrap existing functions (with their renaming) into a new
> ones with semaphore?
>

You're probably right, it would be much cleaner. I'll see about it.

Bart
