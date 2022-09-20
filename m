Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149E5BEE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiITUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiITUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:35:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB685659C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:35:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sd10so654091ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=J9lbuK48CM0U22ONm8+mMUg5MXgFbTGkJOUHVMVcm0I=;
        b=NPlmyLXKeNiB2lCTVIdM8AD2kNsuCxF8SMksBsO8emZJQi0LGKAuo4iVGv9o2H7+TI
         5hzYkFtQfkiHz0cAbu11sfYaLw8cSeETuy7M+Z3807yRG9FvPdycgxE43wehzxYczh79
         n5QnxD0HHtZdSGraRtcsdsXMl3nCoj4b8BN6E8G2FlKWbG4Ui+qLOBA3tsetmOVmIFQl
         la6nThuQwPkwtjZrvBBUcM4YYNJ5T4UU9v/rqk2QMq0eWA7w42rm7ZHLrYbt+uAbEyDo
         uj3bGm4YKmU5Ncz2MNaIeZeFB0PYzmGUAVlDNBPr1n32Kgf0c/uHpdkdo7P8rh8k6jkK
         8G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J9lbuK48CM0U22ONm8+mMUg5MXgFbTGkJOUHVMVcm0I=;
        b=xHda3phZxiKMNE/HR5JnVyDxa3yApp9TetUw2uWjufsqlDDyYWHJ0DnaURAG/yvLXE
         qPfw76Gv6a07Gx9lK62fbTcP95jvq7uGCjJT89m6RVsadG5W/JtULRcrK1/YNwAmEbGF
         Vs4mDZXN7DEQrhpUmJPDcDNZj8qP0EFr3nXVm9NhLls0NV5OWfYjG3Hm6cxKntNQ6Ty5
         /vMu66BAMjyUha4QPpafB+QDWcQPbXX1IG/dOjwi4PIav/+myfSC4Y7EPr0taKKxapN0
         Wb01aqxSKO8bOLX11R4GOd0hrfVIMY8j6n8r92qrWyzqoujUp1nD8aVl8hT12EbDvmBt
         03vw==
X-Gm-Message-State: ACrzQf3PT+MHw+oxqNh44UGpWpd3uZ24lHQoHDq/DNmO+xPsZgjrg3Ks
        BVQX2KNLb3j/gRf+SA41rlYfmzG0xpePUbTBsgs7cw==
X-Google-Smtp-Source: AMsMyM4LTcXhfqv4YpELfvM7P1zqmzKYwstY0dcMtJSDjOMH2wxw7ephEqC5cMomlnVxJSyIh+Nx6ALwhkP1+NzmLCA=
X-Received: by 2002:a17:907:3da9:b0:77b:9672:3f7f with SMTP id
 he41-20020a1709073da900b0077b96723f7fmr18389020ejc.636.1663706136414; Tue, 20
 Sep 2022 13:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220920135435.15593-1-brgl@bgdev.pl> <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
In-Reply-To: <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 20 Sep 2022 22:35:25 +0200
Message-ID: <CAMRc=McjOhUBa0QQbZYh0f_2rN=ESxAtPROAzXEt+KNDJKqWiQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: add fdinfo output for line request file descriptors
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 7:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 20, 2022 at 03:54:35PM +0200, Bartosz Golaszewski wrote:
> > Add fdinfo output for file descriptors created for user-space line
> > requests in GPIO uAPI v2. The fdinfo file now contains the name of the
> > GPIO device that is the "parent" of the request as well as offsets of
> > the lines requested. This allows user-space to parse the /proc/$PID/fdinfo
> > entries and deduct the PID of the process that requested a specific line.
>
> In principle I'm fine, but see below.
>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index f8041d4898d1..0f7b5562c410 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -1497,6 +1497,21 @@ static int linereq_release(struct inode *inode, struct file *file)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_PROC_FS
> > +static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
> > +{
> > +     struct linereq *lr = file->private_data;
> > +     struct device *dev = &lr->gdev->dev;
> > +     u16 i;
> > +
> > +     seq_printf(out, "gpio-device:\t%s\n", dev_name(dev));
> > +
> > +     for (i = 0; i < lr->num_lines; i++)
> > +             seq_printf(out, "gpio-line:\t%d\n",
> > +                        gpio_chip_hwgpio(lr->lines[i].desc));
>
> Hmm... Not sure which variant is better (as for machine parsing and for human),
> but I was thinking of
>

IMO it's pretty clear that the variant in this patch is easier for
machine parsing - one less tokenization.

>         gpio-lines: 1,4,6, ...
>
> Also don't forget that sizes over PAGE_SIZE in sysfs sometimes problematic and
> racy.(the commit 888be6067b97 ("ACPI: sysfs: Fix a buffer overrun problem with
> description_show()") for the reference).
>

In most systems PAGE_SIZE will be at least 4096 bytes. With this patch
a single "gpio-line:\t65535\n" is at most 17 bytes long x max 64 lines
= 1088 bytes. We're still way below the size where it would be
problematic.

Bart

> > +}
> > +#endif
> > +
> >  static const struct file_operations line_fileops = {
> >       .release = linereq_release,
> >       .read = linereq_read,
> > @@ -1507,6 +1522,9 @@ static const struct file_operations line_fileops = {
> >  #ifdef CONFIG_COMPAT
> >       .compat_ioctl = linereq_ioctl_compat,
> >  #endif
> > +#ifdef CONFIG_PROC_FS
> > +     .show_fdinfo = linereq_show_fdinfo,
> > +#endif
> >  };
> >
> >  static int linereq_create(struct gpio_device *gdev, void __user *ip)
> > --
> > 2.34.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
