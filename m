Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55525B56C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiILIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiILIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:53:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23962BB3F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:53:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m1so11622062edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LeyEfTs9yyPVXfKQntxuZT0+LwnhmLDjpHhOJB6RFSE=;
        b=7ABE4n2klxVQMxfpU2OTGbHusg/nacl5wpccb2AouhOt6U+q1rLxMxx8XtGRV7gSrX
         P/PaRVBLMdMz9v6pKSwOcMl47ypbfJvWLDBNszfCO/46wKxoyO3J2aGMozLDAukIV0VD
         cP8r/k0NGIzY1RiCloPIDbRnNLZC4Kq+s8c3IWmAq4BumicbMdPSV49tL5B63KeCv3O4
         +KZ0zQF3iajccVlc9CUF06CIf0HIn20sdsKzCgndeHtkzKxH5AfHrayNgejVI6D4ftgJ
         oP5nP5pamEE/AtFO+4LQtLIWo7QjHOyyILcwlIcIoiDOiNLHV1hCw9EOhLIBU1KCzRVd
         qo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LeyEfTs9yyPVXfKQntxuZT0+LwnhmLDjpHhOJB6RFSE=;
        b=d/YiN0riLEwDa5FaJRzx8JMhcV+ywg0Y0dbHpaHsE58yqT5jyEI8zlV6OanWUrYnaL
         bNEVZehavUEOlc7LVmRZCM/dOvvfUSV0SvK5bpjbQbyeC1T13n8Rbf9DI7v+Qi08EqH3
         AE4sE7eFkGEaD1R+mikdVvXy4/m+3SQs+0m+crv1lPNYu7z38f/Ghwsb3kvjhZoEtk1O
         81SSw+ht+FMOGArNuCWLVc9YDqvdNM1lICN8Od2KxWyHXMh+qfoZMf4U1YlB8AzrfvSY
         9xagC8auzv7L4jDwo4aj0hxtWIQJKWhJ+fGT8dReF3jKnvKlaet8oHNz4tJHvk12B7Ea
         FfTQ==
X-Gm-Message-State: ACgBeo36Z+PHWFA0CXfK5WcISVOny4OLA+0SjW+mpR8SECN5eQHcoBav
        EiWLPjrZXCrqpAKKjtXpwrbiTyDeRBBAIwlkVXxvAg==
X-Google-Smtp-Source: AA6agR6KW+YIss8DhEhJlUrdXlg2x5bNs4hyDV6JhFmUYYpe+fNhhR98WnSBPobTN8CEbGH06f60IHTHmhiU8IIFQI4=
X-Received: by 2002:a05:6402:5243:b0:451:6d52:5928 with SMTP id
 t3-20020a056402524300b004516d525928mr6687535edd.328.1662972784211; Mon, 12
 Sep 2022 01:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220909121329.42004-1-brgl@bgdev.pl> <20220909121329.42004-3-brgl@bgdev.pl>
 <YxykorLetCjAls/Z@sol>
In-Reply-To: <YxykorLetCjAls/Z@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 12 Sep 2022 10:52:53 +0200
Message-ID: <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 4:52 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Fri, Sep 09, 2022 at 02:13:29PM +0200, Bartosz Golaszewski wrote:
> > It's useful for user-space to be able to know the PIDs of processes
> > holding GPIO lines in case they have the permissions and need to kill
> > them.
> >
>
> "the PID of the process holding a GPIO line"
>
> As written it could be interpreted to imply that multiple processes can
> hold a line, so go singular to remove that possibility.
>
> > Extend the gpio_v2_line_info structure with the consumer_pid field
> > that's set to the PID of the user-space process or 0 if the user lives
> > in the kernel.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > ---
> >  drivers/gpio/gpiolib-cdev.c |  2 ++
> >  drivers/gpio/gpiolib.c      | 24 +++++++++++++++++++-----
> >  drivers/gpio/gpiolib.h      |  2 ++
> >  include/uapi/linux/gpio.h   |  5 ++++-
> >  4 files changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index f8041d4898d1..9b6d518680dc 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -2120,6 +2120,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
> >       if (desc->label)
> >               strscpy(info->consumer, desc->label, sizeof(info->consumer));
> >
> > +     info->consumer_pid = desc->pid;
> > +
> >       /*
> >        * Userspace only need to know that the kernel is using this GPIO so
> >        * it can't use it.
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 6768734b9e15..0c9d1639b04d 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -96,6 +96,11 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
> >       d->label = label;
> >  }
> >
> > +static inline void desc_set_pid(struct gpio_desc *d, pid_t pid)
> > +{
> > +     d->pid = pid;
> > +}
> > +
> >  /**
> >   * gpio_to_desc - Convert a GPIO number to its descriptor
> >   * @gpio: global GPIO number
> > @@ -1892,7 +1897,8 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
> >   * on each other, and help provide better diagnostics in debugfs.
> >   * They're called even less than the "set direction" calls.
> >   */
> > -static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
> > +static int
> > +gpiod_request_commit(struct gpio_desc *desc, const char *label, pid_t pid)
> >  {
> >       struct gpio_chip        *gc = desc->gdev->chip;
> >       int                     ret;
> > @@ -1913,6 +1919,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
> >
> >       if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
> >               desc_set_label(desc, label ? : "?");
> > +             desc_set_pid(desc, pid);
> >       } else {
> >               ret = -EBUSY;
> >               goto out_free_unlock;
> > @@ -1987,7 +1994,8 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
> >               return; \
> >       } while (0)
> >
> > -int gpiod_request(struct gpio_desc *desc, const char *label)
> > +static int
> > +gpiod_request_with_pid(struct gpio_desc *desc, const char *label, pid_t pid)
> >  {
> >       int ret = -EPROBE_DEFER;
> >       struct gpio_device *gdev;
> > @@ -1996,7 +2004,7 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
> >       gdev = desc->gdev;
> >
> >       if (try_module_get(gdev->owner)) {
> > -             ret = gpiod_request_commit(desc, label);
> > +             ret = gpiod_request_commit(desc, label, pid);
> >               if (ret)
> >                       module_put(gdev->owner);
> >               else
> > @@ -2009,11 +2017,16 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
> >       return ret;
> >  }
> >
> > +int gpiod_request(struct gpio_desc *desc, const char *label)
> > +{
> > +     return gpiod_request_with_pid(desc, label, 0);
> > +}
> > +
> >  int gpiod_request_user(struct gpio_desc *desc, const char *label)
> >  {
> >       int ret;
> >
> > -     ret = gpiod_request(desc, label);
> > +     ret = gpiod_request_with_pid(desc, label, current->pid);
> >       if (ret == -EPROBE_DEFER)
> >               ret = -ENODEV;
> >
> > @@ -2042,6 +2055,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
> >               }
> >               kfree_const(desc->label);
> >               desc_set_label(desc, NULL);
> > +             desc_set_pid(desc, 0);
> >               clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
> >               clear_bit(FLAG_REQUESTED, &desc->flags);
> >               clear_bit(FLAG_OPEN_DRAIN, &desc->flags);
> > @@ -2140,7 +2154,7 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
> >               return desc;
> >       }
> >
> > -     ret = gpiod_request_commit(desc, label);
> > +     ret = gpiod_request_commit(desc, label, 0);
> >       if (ret < 0)
> >               return ERR_PTR(ret);
> >
> > diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> > index b35deb08a7f5..d1535677e162 100644
> > --- a/drivers/gpio/gpiolib.h
> > +++ b/drivers/gpio/gpiolib.h
> > @@ -165,6 +165,8 @@ struct gpio_desc {
> >
> >       /* Connection label */
> >       const char              *label;
> > +     /* Consumer's PID (if consumer is in user-space, otherwise 0) */
> > +     pid_t                   pid;
> >       /* Name of the GPIO */
> >       const char              *name;
> >  #ifdef CONFIG_OF_DYNAMIC
> > diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
> > index cb9966d49a16..37f10021d1aa 100644
> > --- a/include/uapi/linux/gpio.h
> > +++ b/include/uapi/linux/gpio.h
> > @@ -219,6 +219,8 @@ struct gpio_v2_line_request {
> >   * gpio_v2_line_flag, such as %GPIO_V2_LINE_FLAG_ACTIVE_LOW,
> >   * %GPIO_V2_LINE_FLAG_OUTPUT etc, added together.
> >   * @attrs: the configuration attributes associated with the line
> > + * @consumer_pid: process ID of the user-space consumer or 0 if the consumer
> > + * lives in kernel space
> >   * @padding: reserved for future use
> >   */
> >  struct gpio_v2_line_info {
> > @@ -228,8 +230,9 @@ struct gpio_v2_line_info {
> >       __u32 num_attrs;
> >       __aligned_u64 flags;
> >       struct gpio_v2_line_attribute attrs[GPIO_V2_LINE_NUM_ATTRS_MAX];
> > +     __s32 consumer_pid;
>
> My knee-jerk reaction here was to make the pid unsigned, as we never
> pass a negative PID.
> Keeping in mind that the existing kernel will return 0 for this field
> (the existing padding), so 0 needs to be excluded from valid PIDs
> anyway.
>
> Andy suggests returning -1 for kernel held lines.
> In that case 0 would mean "old kernel", while -1 would mean "kernel
> held".
>
> As libgpiod will have to convert the 0 to -1 when returning the PID to
> user-space as a pid_t, I'm good with the uAPI using 0 to mean
> "no PID available" for all cases. I'm still open to passing -1 for
> kernel held is there is a use case for it, but I don't see one.
>

Using -1 sounds good but I've just realized there's a different
problem. A process holding a file descriptor may fork and both the
parent and the child will keep the same file descriptors open. Now
we'll have two processes (with different PIDs) holding the same GPIO
lines (specifically holding a file descriptor to the same anonymous
inode).

This already poses a problem for this patch as we'd need to return an
array of PIDs which we don't have the space for but also is a
situation which we haven't discussed previously IIRC - two processes
keeping the same GPIO lines requested.

I don't have any good idea on how to address this yet. One thing off
the top of my head is: close the parent's file descriptor from kernel
space (is it even possible?) on fork() (kind of like the close() on
exec flag).

I need to think about it more.

Bart
