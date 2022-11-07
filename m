Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFB62015B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiKGVk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKGVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:40:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A48827FC5;
        Mon,  7 Nov 2022 13:40:57 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i3so11915467pfc.11;
        Mon, 07 Nov 2022 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MIh6FUPd6bRzAAr4QRjkFihYjlOaa459CYPKztD6ZQ=;
        b=YGh02CAOhKVH0McFv4KzSvxTahloGGkcfV1/qliu/hfVciOW4jaFYya7tGMyFbLW2W
         wPUajOOKNfpyEZYJUHD87HLUwEcozLEkRsXYZg0056iAd0VsKBcSwMMdFU7VIdTTmM5+
         i4zImocMVX97kEP98dz25qemc09kX97cXCVQLk3ueCvEp+RoPvJZ7SkBKubaKlOV4lrL
         dOuDPg/T/HNnD1mNZFtnJac/m8JkKhWL2gZCPRjt81M8F7jnJ3fLm11XgdMHRn0pq2hY
         QxQ5mkJctyh4P/AHlgEMUBRh4TdYq74JG+civx9iE2+lBFdAsTk4gfkVYiq2HMedp+4K
         MgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MIh6FUPd6bRzAAr4QRjkFihYjlOaa459CYPKztD6ZQ=;
        b=gc4TacA+cUJD3ml5afx67NHRZeX+7Z45vjmQA+o43yPW1oyV+2mtMq1egx6BIyYdWG
         /4x6PiWy4+r2Hcr5kYKlPgiYfXpUZ19H4h6MROl755ikvFVrxfbtWCydjVUQJwmlI/ap
         F3lNTg1AZlKqEIxLkC9xVbgXwqA0CngQw8arlUysIsdDW11gYc8y69pU+aDuyO+Jebn2
         4QUOc/wQhNQx4zHQbbon/XICP1an3UOHTLn6339KJpARivpSdpUfGg8WPR8XQOPQq2rQ
         WQS06m53/LBiko+UdG0a2F0s1yAMASDWkMQTmv8R21Z6rAifTd6xxg34T7gETTnBxFWE
         X1tQ==
X-Gm-Message-State: ACrzQf2gn53YUHlZy55tGIuN/AOv826hloliOwlOatOZemFiUHzNh0yR
        WBzPsxV5s9u5oPo0wl7sfSg=
X-Google-Smtp-Source: AMsMyM4/jWq5qj2Rf6zWdlQ64H64Row+8w7UrlIqDgvF9mPredfh+BQEfyAK03/hmu0+havnYHED5g==
X-Received: by 2002:a63:da4f:0:b0:43f:6af:74ed with SMTP id l15-20020a63da4f000000b0043f06af74edmr45958206pgj.290.1667857256868;
        Mon, 07 Nov 2022 13:40:56 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb10:b5b0:232e:4afb])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b00186bc66d2cbsm5417969pls.73.2022.11.07.13.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:40:56 -0800 (PST)
Date:   Mon, 7 Nov 2022 13:40:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Integrate
 of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
Message-ID: <Y2l7ZRe7+wb9YkEm@google.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
 <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
 <Y2lMdQ/bE2w4skOO@google.com>
 <Y2lz/4wEDYnaIJF/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2lz/4wEDYnaIJF/@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:09:19PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 07, 2022 at 10:20:37AM -0800, Dmitry Torokhov wrote:
> > On Mon, Nov 07, 2022 at 06:10:27PM +0200, Andy Shevchenko wrote:
> > > +static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
> > > +{
> > > +	int size;
> > > +
> > > +	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
> > 
> > I wonder if a comment why we need even size would not be helpful.
> 
> Was it in the original code?
> Anyway, if Bart thinks so as well, I may add it in v2.
> 
> > > +	if (size > 0 && size % 2 == 0)
> > > +		return size;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
> > >  {
> > > -	if (!(of_gpio_need_valid_mask(gc) || gc->init_valid_mask))
> > > +	if (!(gpiochip_count_reserved_ranges(gc) || gc->init_valid_mask))
> > >  		return 0;
> > >  
> > >  	gc->valid_mask = gpiochip_allocate_mask(gc);
> > > @@ -457,8 +468,47 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
> > >  	return 0;
> > >  }
> > >  
> > > +static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc, unsigned int sz)
> > > +{
> > > +	u32 *ranges;
> > > +	int ret;
> > > +
> > > +	ranges = kmalloc_array(sz, sizeof(*ranges), GFP_KERNEL);
> > > +	if (!ranges)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, sz);
> > > +	if (ret) {
> > > +		kfree(ranges);
> > > +		return ret;
> > > +	}
> > > +
> > > +	while (sz) {
> > > +		u32 count = ranges[--sz];
> > > +		u32 start = ranges[--sz];
> > 
> > I know we checked sz validity, but I wonder if re-checking it in this
> > function would not insulate us from errors creeping in after some other
> > code refactoring.
> 
> I'm not sure I understand what you meant. The fwnode_property_read_u32_array()
> will fail if the given sz is too big for the real data, so while (sz) would
> never even go on the invalid data.

I am more worried about sz being odd and the loop ending up trying to
dereference ranges[-1].

Thanks.

-- 
Dmitry
