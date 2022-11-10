Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76ED624844
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKJRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKJRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:22:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1DD111;
        Thu, 10 Nov 2022 09:22:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2157783pjd.4;
        Thu, 10 Nov 2022 09:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKPBg3dEE3ONvrgo8OxipNMJGSe6htR6mmChvxzFuVo=;
        b=iyPxjKE6Ywlg4nlJNhwKRzqahfHEJZ9dJ1f0pa3TiTtq8EhIJ2xxb4Q2nguwc0+IWN
         2WDCcl5A50Z6sqens/SEddDDqSZrzbSkPT0Em4bFPBvp4LT/PievyVZXProlPVTIJee6
         byz7YUlDJz2IiSWTUrzkGAvXM3qTjGsMtnrLW5n9vtlfwW3w3sO997qZiNfGyBpJtOeE
         GGQ9scqMe1M+bNLfsZ/NFQ/XD0PkfeNP/M2qAYdLD+pD40/qyO1PgbD6+Jj+acvt3oel
         dK1tqDOQEGJnpJ57tKAxQQ98F5eQMDPE2bkcvxN7RnpvM+cmJj4Z5M6Ddzb8rGK4BMRe
         AePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKPBg3dEE3ONvrgo8OxipNMJGSe6htR6mmChvxzFuVo=;
        b=zQ4is1gF/r2DgE1ZqzBscqzdy0efwNZye0fU1O+daWKrmLE4viF+pZbyL36cn/BQ6x
         afeXFqdde1BwVvku373wkp9M5F9EXbKEiqo+Lh4o9IefO2qN5+KzVx1ePr3a8H/jqHvp
         utBPuakyfP7oTCQBDca8lplGSIlLcy2Sd69DEw3blPFOchZKg+GawVPu3ZOqaaWrcQij
         YWtiVliOBYHOx0FRTqWSSRTpREBf0qiiKi6znwD2qJsdTmSE52yen7P1b/n4OlePXunN
         hFhlxDrcpUfpjmYA9fJHvCK5CmaekeloNoO40pxz1ZmQaHkgoH5UiqYL4pDnJYhnmbMZ
         UbXQ==
X-Gm-Message-State: ACrzQf1rzo+dpwgIN2cc1PkMrpTvBgwq61NkXbzHzIubt56UIAM8Ry8M
        U/o3fM5pE2QuzyPjsTXmea0=
X-Google-Smtp-Source: AMsMyM7T4tr+B+B6tXCg5ywMHodqh8ybBsmcgs6TTyD2x4T7k2qJ45GJl1+pMwnchZx7ke5ev9SbvQ==
X-Received: by 2002:a17:90a:738c:b0:205:e1af:68d1 with SMTP id j12-20020a17090a738c00b00205e1af68d1mr1523564pjg.121.1668100923564;
        Thu, 10 Nov 2022 09:22:03 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001801aec1f6bsm11610434plg.141.2022.11.10.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:22:02 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:21:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y20zN8WpWamUQtWp@google.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
 <Y2uOEhib5dvIcobF@smile.fi.intel.com>
 <Y2v4ze4y8qDThjrv@google.com>
 <Y2z/0IUOQMSonASw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2z/0IUOQMSonASw@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:42:40PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 09, 2022 at 11:00:29AM -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 09, 2022 at 01:25:06PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 08, 2022 at 04:26:50PM -0800, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> > > > +					      struct device *consumer,
> > > > +					      const char *con_id,
> > > > +					      unsigned int idx,
> > > > +					      enum gpiod_flags *flags,
> > > > +					      unsigned long *lookupflags)
> > > >  {
> > > > -	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> > > 
> > > > -	struct gpio_desc *desc = ERR_PTR(-ENODEV);
> > > 
> > > Not sure why this is needed. Now I see that else branch has been changed,
> > > but looking closer to it, we can drop it completely, while leaving this
> > > line untouched, correct?
> > 
> > Yes. I believe removing an initializer and doing a series of if/else
> > if/else was discussed and [soft] agreed-on in the previous review cycle,
> > but I can change it back.
> > 
> > I think we still need to have it return -ENOENT and not -ENODEV/-EINVAL
> > so that we can fall back to GPIO lookup tables when dealing with an
> > unsupported node type.
> 
> Right, okay, let's go with whatever variant you find better.
> 
> ...
> 
> > > > +	if (!IS_ERR_OR_NULL(fwnode))
> > > 
> > > I think this is superfluous check.
> > > 
> > > Now in the form of this series, you have only a single dev_dbg() that tries to
> > > dereference it. Do we really need to have it there, since every branch has its
> > > own dev_dbg() anyway?
> > 
> > As I mentioned, I like to keep this check to show the reader that we
> > should only descend into gpiod_find_by_fwnode() if we have a valid
> > fwnode. It is less about code generation and more about the intent.
> 
> Yes, but if fwnode is not found, we have a next check for that.

No, the check you are talking about is for the GPIO not being located.
It does not have anything to do with fwnode validity. You are relying on
intimate knowledge of gpiod_find_by_fwnode() implementation and the fact
that in the current form it will withstand ERR_PTR-encoded or NULL
fwnode.

I want to have the source code so clear in its intent so that I can be
woken up in the middle of the night with a huge hangover and still be
able to tell how it is supposed to behave.

> I really don't
> think we lose anything by dropping the check and gaining the code generation as
> a side effect.

This is cold path, happening only on startup. I am not saying that we
want to make it slow unnecessarily, but a condition branch that might
even get optimized out is not something we should be concerned here.

Thanks.

-- 
Dmitry
