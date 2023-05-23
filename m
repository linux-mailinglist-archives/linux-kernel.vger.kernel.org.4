Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E144670E9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjEWX6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjEWX6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:58:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0440E5;
        Tue, 23 May 2023 16:58:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b33c72686so176069a12.1;
        Tue, 23 May 2023 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684886322; x=1687478322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kGogYwbeBpGrkLOt20ejXjOaJrdpOttOMird93sj9w=;
        b=NdEOGO3k6l7wBWhJ4+HL/Sv/zDh7pgICXiFYQqGANln9esGUDlw4naqTPMyMC3yYT9
         aTvlCOxmhZ6EWVtnrSsRQ0k2fM7faVnHge/PmuTNLpvWI6SXsXUIrFDDv5Uk0DoIR0lX
         pi4GBYqo5lRvKWKrUbBbAEK/VGJl5gRYnrM/8KnjgRLyxvLGmY8HMavDJfP/HpP0N8Tq
         8NdB0hdSFICvUwWu84bjokTr2uG14kUM1OGGLEWj497a13Rf2TIbBzbCqyHP0PjhXT2U
         htSo7OAHIOKdD9DHO3m1nczKYP4iVqwI2vIo1Y0gbAM4WoYLOltanTDbvlvHg7jpnGE4
         oHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684886322; x=1687478322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kGogYwbeBpGrkLOt20ejXjOaJrdpOttOMird93sj9w=;
        b=SqGWriyOeYuyzCB7mMmOoFSjJg2gUG+raEG7gt1yFvobxe3co6kkavdVbcjiO8JIvF
         INmkM/5RZWTqtzK4bPMTOmdqGduQohphvs+cZ+mIk13UdDK44S+sVp1BCRnPo0POn0rj
         +Hc+nm8Xl9ukq9DpJWB48fIl+o46ujT5hVY5ElBEH70zKvZd/Ai+ZPcchJwbbc5dfSQt
         6Zkp1zvnlO/7HF+KoAeKS3RkBjClpDZF5P6nQeSz/aeLJF/mWec6eCOtjFGQCgOExZtq
         O9bOngR+e0rPTtE5YhA/4/SrOVnQCcqxiWMtBBAmy5FsVwOjiRYYsIMc7g9GoY23vAwX
         j6tQ==
X-Gm-Message-State: AC+VfDyWtZmJ3AfAtFz0dE98Wh8rJzXYLTY3WGj7oE4waTDZ/egUgQ5B
        kVMt5G7zxdFv2xr/ewjBnXwMPeicVSk=
X-Google-Smtp-Source: ACHHUZ4HVcUZT28fltGJKpZZxxCYxUoPVXGHh/AwKO2FS0XZ/wJJn7C6vCcTiZcyvZdxelWxGwY04g==
X-Received: by 2002:a17:90b:3146:b0:255:8063:c8dd with SMTP id ip6-20020a17090b314600b002558063c8ddmr5932499pjb.18.1684886322009;
        Tue, 23 May 2023 16:58:42 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a598b00b002532ddc3a00sm118416pji.15.2023.05.23.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:58:41 -0700 (PDT)
Date:   Wed, 24 May 2023 07:58:36 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: fix a crash on line-request release
Message-ID: <ZG1TLBsOy4mZQlW3@sol>
References: <20230523155101.196853-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523155101.196853-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:51:01PM +0200, Bartosz Golaszewski wrote:
> When a GPIO device is forcefully unregistered, we are left with an
> inactive object. If user-space kept an open file descriptor to a line
> request associated with such a structure, upon closing it, we'll see the
> kernel crash due to freeing unexistent GPIO descriptors.
> 

nonexistent

But I'm not sure that works - gpiod_free() is null aware, so strictly
speaking "freeing nonexistent GPIO descriptors" isn't the problem.
You mean orphaned GPIO descriptors?

> Fix it by checking if chip is still alive before calling gpiod_free() in
> release callbacks for both v2 and v1 ABI.
> 
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")

The problem is also in v1, so do we want to consider backporting a fix
for that too?

> Reported-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib-cdev.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0a33971c964c..6830f668a1b0 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -315,13 +315,19 @@ static long linehandle_ioctl_compat(struct file *file, unsigned int cmd,
>  
>  static void linehandle_free(struct linehandle_state *lh)
>  {
> +	struct gpio_device *gdev = lh->gdev;

It isn't clear to me what this is for.
The flow below now calls gpiod_free() less often, so not that.
It is there for the normal case??

>  	int i;
>  
> -	for (i = 0; i < lh->num_descs; i++)
> -		if (lh->descs[i])
> -			gpiod_free(lh->descs[i]);
> +	for (i = 0; i < lh->num_descs; i++) {
> +		if (lh->descs[i]) {
> +			down_write(&gdev->sem);
> +			if (gdev->chip)
> +				gpiod_free(lh->descs[i]);
> +			up_write(&gdev->sem);
> +		}
> +	}
>  	kfree(lh->label);
> -	gpio_device_put(lh->gdev);
> +	gpio_device_put(gdev);
>  	kfree(lh);
>  }
>  

lineevent_free() needs the fix too?

> @@ -1565,17 +1571,21 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
>  
>  static void linereq_free(struct linereq *lr)
>  {
> +	struct gpio_device *gdev = lr->gdev;
>  	unsigned int i;
>  
>  	for (i = 0; i < lr->num_lines; i++) {
>  		if (lr->lines[i].desc) {
>  			edge_detector_stop(&lr->lines[i]);
> -			gpiod_free(lr->lines[i].desc);
> +			down_write(&gdev->sem);
> +			if (gdev->chip)
> +				gpiod_free(lr->lines[i].desc);
> +			up_write(&gdev->sem);
>  		}
>  	}
>  	kfifo_free(&lr->events);
>  	kfree(lr->label);
> -	gpio_device_put(lr->gdev);
> +	gpio_device_put(gdev);
>  	kfree(lr);
>  }
>  

TBH the fact you have to mess with sems here indicates to me the problem
lies in gpiolib itself.  As a gpiolib client, cdev should just be able to
release the desc back to gpiolib and have it cleanup the mess.

Not that I ever got my head around the whole gpiolib object lifecycle here
- for v2 I just followed what v1 did.

Also, gpiolib still reports an error when forceably removing chips that
have open requests:

    dev_crit(&gdev->dev,
			 "REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED\n");

Any other gpiolib clients out there that this might impact?
Else why report that crit error if you expect it is dealt with?

So while this may fix the crash, I can't say I'm happy with it.

Cheers,
Kent.
