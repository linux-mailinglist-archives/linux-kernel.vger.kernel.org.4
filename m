Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E363CC03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiK2X54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiK2X5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:57:41 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174A25A;
        Tue, 29 Nov 2022 15:57:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id o1so10722613pfp.12;
        Tue, 29 Nov 2022 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYMDmlsvjozIL5WOmq1zpgn4QhNwIkK2G4uNnYQOjuk=;
        b=hXTSncZ/do9WkQnengsdG54Eb/LOE5zQ80xuJXTxQeKqwEd+eK8zetZRndZwfpNqXY
         NolX03Q9qHqsv+jK7aZ95ph4Cg5J54bYlE+z5x1krEnCxOGbmSY7qBw8pstXBMbX6xCD
         CnhVyMLGMeT9SzXjoiS34wWK0yA+cv7mx/mnsOaZjWPNi7d7w0vif3UzkXuJmorFRL7b
         Ng2rkfTMoxfju98F3/+pIm7mNS4PVUJJGDOUQcTmvNcSkslsn6S2LH5NcjTvrIpX+dkS
         69QeuYgAX7g+LOoAF6F+x3rPYZ2mvCewZ3PxipdaRXkjmNpacfbSzgWcnZ/6o2xAac6k
         jDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYMDmlsvjozIL5WOmq1zpgn4QhNwIkK2G4uNnYQOjuk=;
        b=fzOrYHceSShEuPMyalki4s+guFicsJkc1YstEAL1wH1fMZwrzX+7bEftuVXgskutYx
         DBI3vUyBS2sF8k/G+AMm+yq/gvWSpZjCiVJjN3LskOIFH1q4n/3bnBAj0+JZcEliR5fw
         M0etecyueoFOJTe6smcJRZsWAJAeJxH3gBlJmflwaIiSyzqEk2RmSKc2+fer6owwa22g
         U20eU3zbKRqPse+fP+5UCyytngh6NSTqRHroVsJvnJ+AI+s2QFNdpCcH4U7MFI8tq9Yf
         U+5M1b4ooryM90UdKqKSpmvaSCncctNS9OiTRKl1BPIu0B0D6yWCVqV5vPwZanKn4TH0
         9PKQ==
X-Gm-Message-State: ANoB5plM2A76G/iNjRfY4C+QlyDHNO6odyCQyDoT9rDUnoGQrIoFdEm9
        EHqj66OBPXMvzxT78X4EYZI=
X-Google-Smtp-Source: AA0mqf5vn97HJ2AWPh8OLCPTXpCymTiMwpM6M4PRuB27mCC2bgSz7yiGw1Po5rWFTmtvLnaOQTx2sg==
X-Received: by 2002:a63:5a53:0:b0:477:ae2f:3292 with SMTP id k19-20020a635a53000000b00477ae2f3292mr30795903pgm.267.1669766252976;
        Tue, 29 Nov 2022 15:57:32 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a626d04000000b0056d98e359a5sm35622pfc.165.2022.11.29.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 15:57:32 -0800 (PST)
Date:   Wed, 30 Nov 2022 07:57:26 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4acZkkuUa5Peq+r@sol>
References: <20221129123553.353410-1-brgl@bgdev.pl>
 <20221129123553.353410-3-brgl@bgdev.pl>
 <Y4Y5BjTwVCF5bAn5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Y5BjTwVCF5bAn5@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:53:26PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 29, 2022 at 01:35:53PM +0100, Bartosz Golaszewski wrote:
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
> ...
> 
> I would do
> 
> typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
> 
> and so on and use that one in the respective parameters.
> 
> BUT. Since it's a fix, up to you which one to choose.
> 

FWIW, the typedef looks cleaner to me too.

> > +static __poll_t call_poll_locked(struct file *file,
> > +				 struct poll_table_struct *wait,
> > +				 struct gpio_device *gdev,
> > +				 __poll_t (*func)(struct file *,
> > +						  struct poll_table_struct *))
> > +{
> > +	__poll_t ret;
> > +
> > +	down_read(&gdev->sem);
> > +	ret = func(file, wait);
> > +	up_read(&gdev->sem);
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +	down_write(&gdev->sem);
> 
> + Blank line?
> 

Agreed.

> >  	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
> >  	gpiochip_sysfs_unregister(gdev);
> >  	gpiochip_free_hogs(gc);
> 
> ...
> 
> >  	gcdev_unregister(gdev);
> 
> + Blank line ?
> 

Disagree with this one though.
The comment prior to the gcdev_unregister() appears to apply to the block,
so the following lines should remain grouped.

Other than those nits, the series looks good to me.

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.

> > +	up_write(&gdev->sem);
> >  	put_device(&gdev->dev);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
