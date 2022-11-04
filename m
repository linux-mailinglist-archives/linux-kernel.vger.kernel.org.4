Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D5B61A050
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKDSwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKDSwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:52:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B459FE7;
        Fri,  4 Nov 2022 11:52:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso5302985pjc.2;
        Fri, 04 Nov 2022 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucz5LsKRWTnco49tLmp1yAQRn6RZFKpYnyt+vhQDTKY=;
        b=KBd8EDFK9r/2YuJezlbJ2rF1/+gDovqfgsgW5KxfAhfTwd4ywYz7SW4xIcl+V9sFkI
         8oS36qt77hxizFjVgGHx2GtC5f5iuCsB+84devES+QNfZKKgxHPwIXeU8fpuIyIFpiVV
         hTRrtBl2CUxOSeYPjVfP4xKMmPvyMhsoI9FpdVIPGxl3HmR7Yry6GkWpFUvjHh1+vSPU
         AJedSN4r9nY+OlnWw3hTm3y+BQCj9nWKryue1J00RYr3GtkearnHqoJbsT+XMtPZ+IzE
         rliVoY0UweTOMpt4htKJLWDqM0RYK22JKXqcq96YwUjpQp7nYoWMdudgIzBR5GXqEXce
         T9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ucz5LsKRWTnco49tLmp1yAQRn6RZFKpYnyt+vhQDTKY=;
        b=bVp17HbXvb9LyYmAd2UTgbDvIPJVEoRiyK/xsO91o7B4DNWi8Li55n77EiVumC7ahx
         9Hrxcfp4vzGbweSujdmgv6+BQgRBhPZp4bTOOvUa5U7JO2bz/WkMP4nSr8eQmm7Q3CTl
         SZSJ457scgljuenkWaBiLjCd/vh/NuP0BZFXvaoQhyeb7DGSAtJN6MGjMwBSDS7pHLkC
         wK2P7cjdRkYFZu6D6tDj53+xzY/8Msa63ZBbrhDtMM3BZKfGdsoxsXN24jHqn9Er2ABn
         AIPRMsEx4cZocnwOyRhWCSR3RItns177+6KqT7FShk9qHqzJ/VsurtkbqO9uYk11au4h
         kyhg==
X-Gm-Message-State: ACrzQf10518f/TxVmO8VhHYCfGbxkzs3vk83PHJHdQAM/yymjnpyPoxM
        gZrQ3udS28+yu25OUV1zXpk=
X-Google-Smtp-Source: AMsMyM5n3BmX4/4nkJDZfc84c6nVKx0cT+rWFP3ZcPGUx7r+tPuCqq+S0SjlpnCkKz6bM5uM15/VOg==
X-Received: by 2002:a17:902:e84a:b0:186:b8ff:c698 with SMTP id t10-20020a170902e84a00b00186b8ffc698mr36687594plg.143.1667587949628;
        Fri, 04 Nov 2022 11:52:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b0017f5c7d3931sm73646plf.282.2022.11.04.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:52:28 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:52:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2Vfatm3VRGcktNN@google.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-5-a0ab48d229c7@gmail.com>
 <Y2VJJ8CYhGY69c/z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2VJJ8CYhGY69c/z@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Nov 04, 2022 at 07:17:27PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 03, 2022 at 11:10:15PM -0700, Dmitry Torokhov wrote:
> > Ensure that all paths to obtain/look up GPIOD from generic
> > consumer-visible APIs go through the new gpiod_find_and_request()
> > helper, so that we can easily extend it with support for new firmware
> > mechanisms.
> 
> ...
> 
> > +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> > +					      struct device *consumer,
> > +					      const char *con_id,
> > +					      unsigned int idx,
> > +					      enum gpiod_flags *flags,
> > +					      unsigned long *lookupflags)
> >  {
> 
> > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> 
> No need, just return directly.
> 
> > +	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%s'\n",
> > +		con_id, fwnode_get_name(fwnode));
> 
> %pfwP ?

OK. Although, I think I like %pfw (without 'P') better as it gives
results like:

	/soc/i2c@11007000/edp-bridge@8

or

	\_SB.PCI0.I2C1.D010

which should help identifying the exact node.

> 
> > +
> > +	/* Using device tree? */
> >  	if (is_of_node(fwnode)) {
> > +		dev_dbg(consumer, "using device tree for GPIO lookup\n");
> > +		desc = of_find_gpio(to_of_node(fwnode),
> > +				    con_id, idx, lookupflags);
> >  	} else if (is_acpi_node(fwnode)) {
> 
> With direct return, no need for 'else' here.

When we have several branches of equal weight I prefer not to have
early/inline returns, but I can add:

	} else {
		desc = ERR_PTR(-ENOENT);
	}

at the end, what do you think?

> 
> > +		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
> > +		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
> >  	}
> >  
> > +	return desc;
> > +}
> 
> ...
> 
> > +static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
> > +						struct fwnode_handle *fwnode,
> > +						const char *con_id,
> > +						unsigned int idx,
> > +						enum gpiod_flags flags,
> > +						const char *label,
> > +						bool platform_lookup_allowed)
> > +{
> 
> > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> 
> We can get rid of the assignment, see below.
> 
> 
> > +	unsigned long lookupflags;
> > +	int ret;
> 
> > +	if (fwnode)
> 
> Do we need this check?

Yes, I would prefer to have it as it clearly informs the reader that we
are only doing lookup by node if we actually have a node.

gpiod_find_and_request() expects that it gets a valid node and in the
followup change it will be dereferencing fwnode without checking for
NULL-ness.

> 
> Debug message above (when %pfw is used) would be even useful when
> fwnode == NULL.
> 
> > +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> > +					    &flags, &lookupflags);
> 
> > +
> 
> The blank line can be removed after above comments being addressed.
> 
> > +	if (gpiod_not_found(desc) && platform_lookup_allowed) {
> > +		/*
> > +		 * Either we are not using DT or ACPI, or their lookup did not
> > +		 * return a result. In that case, use platform lookup as a
> > +		 * fallback.
> > +		 */
> > +		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
> > +		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
> > +	}
> > +
> > +	if (IS_ERR(desc)) {
> > +		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
> > +		return desc;
> > +	}
> > +
> > +	/*
> > +	 * If a connection label was passed use that, else attempt to use
> > +	 * the device name as label
> > +	 */
> >  	ret = gpiod_request(desc, label);
> > +	if (ret) {
> > +		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
> > +			return ERR_PTR(ret);
> > +
> > +		/*
> > +		 * This happens when there are several consumers for
> > +		 * the same GPIO line: we just return here without
> > +		 * further initialization. It is a bit of a hack.
> > +		 * This is necessary to support fixed regulators.
> > +		 *
> > +		 * FIXME: Make this more sane and safe.
> > +		 */
> 
> > +		dev_info(consumer,
> > +			 "nonexclusive access to GPIO for %s\n", con_id);
> 
> Cam be one line.

I still have not embraced the new 100 columns limit. Linus, Bart, are
you OK with moving to 100 or do you want to stay with 80 for a while?

> 
> > +		return desc;
> > +	}
> >  
> > +	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
> >  	if (ret < 0) {
> > +		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
> >  		gpiod_put(desc);
> >  		return ERR_PTR(ret);
> >  	}
> 
> ...
> 
> >  struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
> > +					 const char *con_id,
> > +					 int index,
> >  					 enum gpiod_flags flags,
> >  					 const char *label)
> >  {
> >  
> 
> Unnecessary blank line?

Indeed, I'll fix it.

> 
> > +	return gpiod_find_and_request(NULL, fwnode, con_id, index, flags, label,
> > +				      false);
> 
> Can be one line.

Yep, depending on 80/100 column answer.

Thanks for the review!


-- 
Dmitry
