Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88841638E90
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKYQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKYQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:49:32 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62D5215D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:48:14 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 6so597746vkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTTfcoRrU0StocsPWITcDvFwfydUNrOq1yx22xUwc4Q=;
        b=1/nali5o+yPtp4fa9mMqVuWhgtggT9rmWJAcyW7yCYDuCAsKGn83MiacJOkMqX9gnR
         jn81xEr5sxQ+84Va4jRJCkqUTAnSK11UqTFOLTDyeVZkakwYLLxwB+EZuPPh1jfX2kSd
         YzGSCtKx0Mu+5rb28AkZJ2SkvsceH+qfd1wDhUa2WNJAM4e/Tn8l1F06Ts7FGYwYzsEv
         CdNeFDYRxZOINrTTENRhTuVE/oBq5iF5jfsJRToNoRmtvYV4Yt6CKlEB93vrMWs8DlkT
         UyqfDE4Cq0fSjIpFn8I1yAOsVTrW8ZLjPgmHJ4u0RopAc/6qBmVmRn8Z4Rn0cXllY8IK
         yP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTTfcoRrU0StocsPWITcDvFwfydUNrOq1yx22xUwc4Q=;
        b=EUhJO8omohwBgpgUl6+iwhfwIx9DV1n1Zgogp6bXW8M1sASRDf9Fc/lOsgGgpE9uLN
         JB9k9lx5raWTMsAu8wEo9u7Fsc5RDhpB7Pu1nMd1rrWhrNr1B+VBhkrzeJbXog0V6Kc7
         7SzqqTNhlS/nebiZQGTDY5FeHRtbqBuOWykOvkMudPkfrBpeXwlad6SDx7Cnwi31zjQ2
         Y8NdWfoCyyhbkHtdKpHdtK+fj1253WTsIjXn6vWiFYPwNC46z5jElMkaA7uO0nAExEVl
         GqhJ1ixuv4mOO7WffgMmiY4a9kpbxVn+Ra0jXfD+1nbecauc/CBZxXVzS1hFD5bKI3gi
         0M7g==
X-Gm-Message-State: ANoB5pl3Kg2gFQIj+KqtMxZEv/i3j01JADObTA1SDDvHNYC9pKIbiG3A
        /svl8Ltcj/1rtuTDtxO4e4NOnCbQLdtS9wUbmbvjrA==
X-Google-Smtp-Source: AA0mqf7wHcHs+jZ+23bnrrfy2o/9bDG2JM2tDK5A631Aa7acT4B45duF7qHXru/VFEJ0uirx+8nZ6eYRaCexumSmXBI=
X-Received: by 2002:ac5:c915:0:b0:3b8:7fbd:9554 with SMTP id
 t21-20020ac5c915000000b003b87fbd9554mr11745712vkl.27.1669394893661; Fri, 25
 Nov 2022 08:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20221125153257.528826-1-brgl@bgdev.pl> <Y4DsTxPH1tv5eEwf@sol>
In-Reply-To: <Y4DsTxPH1tv5eEwf@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 25 Nov 2022 17:48:02 +0100
Message-ID: <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Fri, Nov 25, 2022 at 5:24 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Fri, Nov 25, 2022 at 04:32:57PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There are several places where we can crash the kernel by requesting
> > lines, unbinding the GPIO device, then calling any of the system calls
> > relevant to the GPIO character device's annonymous file descriptors:
> > ioctl(), read(), poll().
> >
> > While I observed it with the GPIO simulator, it will also happen for any
> > of the GPIO devices that can be hot-unplugged - for instance any HID GPIO
> > expander (e.g. CP2112).
> >
> > This affects both v1 and v2 uAPI.
> >
> > Fix this by simply checking if the GPIO chip pointer is not NULL.
> >
>
> Fixes: ??
>
> And split for v1 and v2 as the Fixes for those will differ?
>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index 0cb6b468f364..d5632742942a 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -201,6 +201,9 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
> >       unsigned int i;
> >       int ret;
> >
> > +     if (!lh->gdev->chip)
> > +             return -ENODEV;
> > +
>
> Is there anything to prevent the chip being removed by another thread
> between this check and subsequent usage?
>

Eh... not really, no. The issue we have here seems to be the same as
the one Laurent Pinchart described back in 2015[1] and revisited
during his 2022 linux plumbers presentation[2], except he blamed it on
devres, whereas I think the problem is much deeper and devres has
nothing to do with it.

Ideally we'd need a global fortifying of the driver model against
hot-unplug related device unbinding.

After a quick glance at the relevant code, I think we'd need to add
some flag to struct file for the vfs to check on any fs operation and
return an error early if user-space tries to operate on an fd
associated with a removed device. I'm not sure yet if that's feasible
globally or even the right solution at all - just brainstorming here.

Then at the subsystem level, the GPIO device struct would need a lock
that would be taken by every user-space operation AND the code
unregistering the device so that we don't do what you described (i.e.
if there's a thread doing a read(), then let's wait until it returns
before we drop the device).

This wouldn't fix the case in which the same situation happened in a
kernel driver but crashing the kernel from within is a much lesser
offense than allowing user-space to crash it.

So this patch is just papering over for now I suppose.

Bart

[1] https://lkml.org/lkml/2015/7/14/741
[2] https://www.youtube.com/watch?v=kW8LHWlJPTU
