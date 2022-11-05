Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2661A796
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKEE5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEE5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:57:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC08A2F64E;
        Fri,  4 Nov 2022 21:57:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 130so6178373pfu.8;
        Fri, 04 Nov 2022 21:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7Ob2pp2Kintql84ksy91OPK6CpqOp8C+QUZOHOIzx4=;
        b=OlfrbKtYzX91oavc1bt49EQ8ADSCYYeoUJFIOps8SgOrGdCItck2EgC0Gu/YFn4S8F
         unE0B7ssT4vqI5ujY3LnSuY9/UHjVn3Hyodunk0DJl7MQerL2DZfOGFEI9FaNOR8PvYb
         n0OYlcsYI76dh6Qe9OZv3+eI3mhQmgakKOFrwX1v14iZP4W204ZwKsGjk02VPrNOhqye
         Gs/eoNlDriy/DiOOVEEc/oZWiy/nYpA3wf2RRhaTvl2jIFEoOvat+NwL1WGv9EwnqLU4
         tE5tmMH/9vPyBIA4+jrAz4iema/JlO3EdaGxKy9rAXOwLg2QGasTgHhTqDKR2C7ogfpb
         V7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Ob2pp2Kintql84ksy91OPK6CpqOp8C+QUZOHOIzx4=;
        b=qRZkfhCWC7snmca1iukGiYIfHBgzNP1gUe0IseL4zDsKR0WN5cKhyG/BU1T2AnIeIh
         Ztz8Rk8XVzJGDanB8jkBvwXYu6KN/3HBytTQIeJGyvIJ/7+CaCzPCuckSOxlo7aPpPb4
         NMwtYs7CxRVrvN3y5BuoGR18Utug5Nd8/KfJlSELAU7CAzhObB4i49Kkxcq3R+X5m0CT
         YvXVWhPsGJUwtEJ3VjPH2jZrsvSen6XufoJl9N2s3a2aI6D+SPqeX+loBIVSg8qlNxT3
         yEMUp3xxLgFD6dx1tAhwqotUr4JYi/O5qx8Gzc9ZSKM8u2/03nGjVPAAQEj7f3onfj7b
         k04A==
X-Gm-Message-State: ACrzQf0c2j/LHe1vUbMU5Mt3+TKtunIt//raBqc+PunpxSAqn49Lke5u
        D+brdovOI0kTRpNDMeCqBWHXEZHmhLo=
X-Google-Smtp-Source: AMsMyM5peciw5iRYCzFFSGTpV5ZKxLEb+vdKvf8i4k6gRZmSvRw3nYVpmzT+v0MGa2hV5IAWItIB6g==
X-Received: by 2002:a63:544e:0:b0:46f:7b0e:e4f with SMTP id e14-20020a63544e000000b0046f7b0e0e4fmr33950543pgm.92.1667624221083;
        Fri, 04 Nov 2022 21:57:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5e7f:d665:c23a:5a4c])
        by smtp.gmail.com with ESMTPSA id b17-20020a621b11000000b0053e4baecc14sm438951pfb.108.2022.11.04.21.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 21:57:00 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:56:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2XtGTAjEB24tqrF@google.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-5-a0ab48d229c7@gmail.com>
 <Y2VJJ8CYhGY69c/z@smile.fi.intel.com>
 <Y2Vfatm3VRGcktNN@google.com>
 <Y2V+8tiwstXbTWoq@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2V+8tiwstXbTWoq@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:06:58PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 04, 2022 at 11:52:26AM -0700, Dmitry Torokhov wrote:
> > On Fri, Nov 04, 2022 at 07:17:27PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 03, 2022 at 11:10:15PM -0700, Dmitry Torokhov wrote:
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
> > > 
> > > > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> > > 
> > > No need, just return directly.
> > > 
> > > > +	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%s'\n",
> > > > +		con_id, fwnode_get_name(fwnode));
> > > 
> > > %pfwP ?
> > 
> > OK. Although, I think I like %pfw (without 'P') better as it gives
> > results like:
> > 
> > 	/soc/i2c@11007000/edp-bridge@8
> > 
> > or
> > 
> > 	\_SB.PCI0.I2C1.D010
> > 
> > which should help identifying the exact node.
> 
> I agree.
> 
> > > > +	/* Using device tree? */
> > > >  	if (is_of_node(fwnode)) {
> > > > +		dev_dbg(consumer, "using device tree for GPIO lookup\n");
> > > > +		desc = of_find_gpio(to_of_node(fwnode),
> > > > +				    con_id, idx, lookupflags);
> > > >  	} else if (is_acpi_node(fwnode)) {
> > > 
> > > With direct return, no need for 'else' here.
> > 
> > When we have several branches of equal weight I prefer not to have
> > early/inline returns, but I can add:
> > 
> > 	} else {
> > 		desc = ERR_PTR(-ENOENT);
> > 	}
> > 
> > at the end, what do you think?
> 
> No strong opinion here.
> 
> > > > +		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
> > > > +		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
> > > >  	}
> > > >  
> > > > +	return desc;
> > > > +}
> 
> ...
> 
> > > > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> > > 
> > > We can get rid of the assignment, see below.
> 
> Still below another thought which affects this.
> 
> > > > +	if (fwnode)
> > > 
> > > Do we need this check?
> > 
> > Yes, I would prefer to have it as it clearly informs the reader that we
> > are only doing lookup by node if we actually have a node.
> > 
> > gpiod_find_and_request() expects that it gets a valid node and in the
> > followup change it will be dereferencing fwnode without checking for
> > NULL-ness.
> 
> But most of the code will check for the NULL anyway. The exceptions are
> dev_dbg() and accessing to the secondary fwnode.

I think it is just a matter of what I want to express through source. I
want to show that the device might not have fwnode, and that we only
descend into gpiod_find_by_fwnode() in cases where we actually have
fwnode.

> 
> > > Debug message above (when %pfw is used) would be even useful when
> > > fwnode == NULL.
> 
> > > > +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> > > > +					    &flags, &lookupflags);
> 
> Looking into drivers/base/property.c makes me realize that you might need to
> test for error pointer as well.
> 
> Perhaps something like
> 
> 	if (IS_ERR_OR_NULL(fwnode))
> 		return ERR_PTR(-ENOENT);
> 
> in the gpiod_find_by_fwnode() needs to be added. Can you check this?

No, only fwnode->secondary pointer can be PTR_ERR()-encoded.

From comment to set_primary_fwnode() in drivers/base/core.c

 * Valid fwnode cases are:
 *  - primary --> secondary --> -ENODEV
 *  - primary --> NULL
 *  - secondary --> -ENODEV
 *  - NULL

I do not believe we should be concerned about someone passing secondary
pointers from fwnodes directly into gpiolib.

Thanks.

-- 
Dmitry
