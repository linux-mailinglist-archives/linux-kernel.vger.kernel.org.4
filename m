Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176A15BE8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiITOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiITOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:23:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A62ADB;
        Tue, 20 Sep 2022 07:22:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f193so2826321pgc.0;
        Tue, 20 Sep 2022 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FvqdyQZlyl7cHZFq9ML00vMVzwBy6IZ/KBUnUaXkVKo=;
        b=VE2WOX2Anllf286n9R8N324fMBEsuhkNF4ZMYLel2rHvQwLVaBBDs8MIRsGZt1Vj40
         IN9WMeivH1IjDk6q2tR98vZQZ87uvKmAWVypJAT0BcjEjoJafANLSDWyPbg08XKwhYhn
         jv7eRjK5zjohwYQBSft/EXA0QJZ/Om16WmLL/SEXtdBQ+sdMIFBUm4MP3LJVCUNJ2XC0
         2OPsyv1PfF9YRtt9xLw+OF/1Tb6to+mVbfoaNqpcCr28Hph1Mun1dHsyJrGJdZPTAYmw
         UOlZgwqrmm1rvoqCkVDF7jC0XHsy3Fd5MBOOYVX27iMDUV4QWbzqRy2KTF3Z/yJALBSq
         9Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FvqdyQZlyl7cHZFq9ML00vMVzwBy6IZ/KBUnUaXkVKo=;
        b=Rq8yt2fj07tFgpICBKCJ74W3PPunsW1JWKY4pDVwhnbFC/UfG624nKs42bytcexZrw
         INTGEVUWmFvq6KBMKI5LAMAOTD48nQf4A7CNsCWmAmzl2rnB+L47jYEkKQL0+CUdYWXj
         3LdIocFUBSjP5TrNZLqWCYl7ZLfRso7PfD/MYKxXcPGsrChWDhgUtCITHpWvlc+hYPft
         /rSEX/EyMCBUxCJpGRNwQwyMQjTca7wfmMrBjHPbDQZp+UvY+/OKF1a7hGV/RRKs+uDU
         LQ4hVea8Dd/rno8oaiOfCSWiZreoowsNlhd+LBV/kWleq1J5IlCQZl+ZEIsXJ33uclWE
         Wl7A==
X-Gm-Message-State: ACrzQf3NQeC+YEF2fxVwZ1IjGAjjifneaLwHhefGhtLegAbrjJGNw0yb
        6LIQAyLwBmemALRvkd47kQw=
X-Google-Smtp-Source: AMsMyM5N6bcO8qcyP7x6YZWItjsMleh7Abbc1+aF0Ly0ijUASQKLIWMx+6PXQpSNBzfp2EXSF01sRQ==
X-Received: by 2002:aa7:838a:0:b0:550:5e4a:ab55 with SMTP id u10-20020aa7838a000000b005505e4aab55mr6756006pfm.10.1663683736021;
        Tue, 20 Sep 2022 07:22:16 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id g33-20020a635661000000b004351358f056sm1644506pgm.85.2022.09.20.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:22:15 -0700 (PDT)
Date:   Tue, 20 Sep 2022 22:22:10 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: add fdinfo output for line request file
 descriptors
Message-ID: <YynMkm3ef3tEMw7M@sol>
References: <20220920135435.15593-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920135435.15593-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:54:35PM +0200, Bartosz Golaszewski wrote:
> Add fdinfo output for file descriptors created for user-space line
> requests in GPIO uAPI v2. The fdinfo file now contains the name of the
> GPIO device that is the "parent" of the request as well as offsets of
> the lines requested. This allows user-space to parse the /proc/$PID/fdinfo
> entries and deduct the PID of the process that requested a specific line.
> 
              deduce

Using deduct in this sense is unusual (not sure I've ever heard it used
that way, and some dictionaries don't even acknowledge it as a valid
option). In common usage deduct = subtract.

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib-cdev.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f8041d4898d1..0f7b5562c410 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1497,6 +1497,21 @@ static int linereq_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
> +{
> +	struct linereq *lr = file->private_data;
> +	struct device *dev = &lr->gdev->dev;
> +	u16 i;
> +
> +	seq_printf(out, "gpio-device:\t%s\n", dev_name(dev));
> +

So "device" rather than "chip"?

I realise it is the device name being reported here, but don't we use chip
for this in user-space?

> +	for (i = 0; i < lr->num_lines; i++)
> +		seq_printf(out, "gpio-line:\t%d\n",
> +			   gpio_chip_hwgpio(lr->lines[i].desc));
> +}

So the exploded form.  That works for me - in case we ever need to add
more line details, and also makes it easier to grep for a particular line.

Other than the comment nit and the device/chip question it looks good to me.

Cheers,
Kent.

> +#endif
> +
>  static const struct file_operations line_fileops = {
>  	.release = linereq_release,
>  	.read = linereq_read,
> @@ -1507,6 +1522,9 @@ static const struct file_operations line_fileops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = linereq_ioctl_compat,
>  #endif
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = linereq_show_fdinfo,
> +#endif
>  };
>  
>  static int linereq_create(struct gpio_device *gdev, void __user *ip)
> -- 
> 2.34.1
> 
