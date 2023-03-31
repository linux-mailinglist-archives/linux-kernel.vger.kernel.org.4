Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F626D1DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCaKVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCaKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:20:55 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9171F7B0;
        Fri, 31 Mar 2023 03:17:06 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id x3so87541618edb.10;
        Fri, 31 Mar 2023 03:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680257824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArFrGlAU2OpYNIclmKzpTEfPyjrwUtX0FtxsW7QpR38=;
        b=NCbFRh7X8v8NmgGpEHLRz6afZle6CS3jWwf2QYDbDz6t5Z/TanRrMBWEyaCedi+HP0
         FcMl35WJiqIoAiPvhMhHHWS/HX4dlq7GIdTGY4f0i3GK6pbSWoecBdPLT/mQJvQv89bH
         FjQeTYl6rSxllW2LJawMA83Y6Z2veRiuty/jgkGJnTA38BvvsipM7c/vsjWlaC9ifwZF
         7bxz1nc3bW9LQqPJ1v5/o/nk6tqIXiQ+mB1cAYS9guuPmvMDDnXbj/b3W9/98/zQ71DF
         ZpjT+0witxjTPOg7vXAb7xlPY8SXj+bJsAIKa+Z04YrFBmpjVLL2jwT5VozbYgJVYPXm
         oQOw==
X-Gm-Message-State: AAQBX9ethkvaSGtMrh7IdNnv8o6DxpeZfgT72JS/HT/q25yHyMjHett8
        cdwI3TU6iEGMoYz7nNreDrL6HmPGVdYYtMJp4+gfvsT22bo=
X-Google-Smtp-Source: AKy350Z77MXttLvxuFLq/k6lWnjVW3HycYoUvROKKTEoRE0M8kp7TLNTpupISW5o+GDXK8SvSQhc9z6NGEUoETqWOz4=
X-Received: by 2002:a17:906:8683:b0:939:a51a:dc30 with SMTP id
 g3-20020a170906868300b00939a51adc30mr4423763ejx.2.1680257824669; Fri, 31 Mar
 2023 03:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 12:16:53 +0200
Message-ID: <CAJZ5v0hvLJi=ssm-vTHy_amarys7MSsc2VPZUigrdL+BSTYuAw@mail.gmail.com>
Subject: Re: [PATCH 2/7] driver core: create class_is_registered()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Some classes (i.e. gpio), want to know if they have been registered or
> not, and poke around in the class's internal structures to try to figure
> this out.  Because this is not really a good idea, provide a function
> for classes to call to try to figure this out.
>
> Note, this is racy as the state of the class could change at any moment
> in time after the call is made, but as usually a class only wants to
> know if it has been registered yet or not, it should be fairly safe to
> use, and is just as safe as the previous "poke at the class internals"
> check was.
>
> Move the gpiolib code to use this function as proof that it works
> properly.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c         | 25 +++++++++++++++++++++++++
>  drivers/gpio/gpiolib-sysfs.c |  4 ++--
>  include/linux/device/class.h |  1 +
>  3 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 68a6f9b56d19..a8a1bf976290 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -634,6 +634,31 @@ void class_compat_remove_link(struct class_compat *cls, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(class_compat_remove_link);
>
> +/**
> + * class_is_registered - determine if at this moment in time, a class is
> + *                      registered in the driver core or not.
> + * @class: the class to check
> + *
> + * Returns a boolean to state if the class is registered in the driver core
> + * or not.  Note that the value could switch right after this call is made,
> + * so only use this in places where you "know" it is safe to do so (usually
> + * to determine if the specific class has been registered yet or not).
> + *
> + * Be careful in using this.
> + */
> +bool class_is_registered(const struct class *class)
> +{
> +       struct subsys_private *sp = class_to_subsys(class);
> +       bool is_initialized = false;
> +
> +       if (sp) {
> +               is_initialized = true;
> +               subsys_put(sp);
> +       }
> +       return is_initialized;
> +}
> +EXPORT_SYMBOL_GPL(class_is_registered);
> +
>  int __init classes_init(void)
>  {
>         class_kset = kset_create_and_add("class", NULL, NULL);
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index a895915affa5..1a9b21731cc9 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -554,7 +554,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
>         int                     offset;
>
>         /* can't export until sysfs is available ... */
> -       if (!gpio_class.p) {
> +       if (!class_is_registered(&gpio_class)) {
>                 pr_debug("%s: called too early!\n", __func__);
>                 return -ENOENT;
>         }
> @@ -728,7 +728,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
>          * register later, in gpiolib_sysfs_init() ... here we just
>          * verify that _some_ field of gpio_class got initialized.
>          */
> -       if (!gpio_class.p)
> +       if (!class_is_registered(&gpio_class))
>                 return 0;
>
>         /*
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index b53728ca56fb..9cb5db0588c8 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -84,6 +84,7 @@ extern struct kobject *sysfs_dev_block_kobj;
>
>  int __must_check class_register(struct class *class);
>  void class_unregister(const struct class *class);
> +bool class_is_registered(const struct class *class);
>
>  struct class_compat;
>  struct class_compat *class_compat_register(const char *name);
> --
> 2.40.0
>
