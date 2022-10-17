Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE960084B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJQIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJQIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:04:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C6C58
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04804B81038
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB2EC433D7;
        Mon, 17 Oct 2022 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665993857;
        bh=4y5mOE1LmYA5D0ClHq3gxN11Y26VKTeBO4fID9TVvII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeswRBIj/ZX8y2L9gUitoYFeGF+oAV3JScH55uF8hX4bUteQxQitJE/A9+FYUsvtj
         g0SafAgPZezbdRVQkD4EnaDZ8qPbvrQa1auSvztPInvptAGO9oIob1YPipCDyTwHK+
         AbUWzrK/mSxhcJiBBF4ojDU1HJL7OqbEc96M2+tM=
Date:   Mon, 17 Oct 2022 10:04:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Message-ID: <Y00Mfgymi+Xv6El3@kroah.com>
References: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
 <Y00KTAobXJ0/Jgv3@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y00KTAobXJ0/Jgv3@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 07:54:52AM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Sun, Oct 16, 2022 at 12:41:26PM +0200, Greg Kroah-Hartman wrote:
> > If a const * to a kobject is passed to kobj_to_dev(), we want to return
> > back a const * to a device as the driver core shouldn't be modifying a
> > constant structure.  But when dealing with container_of() the pointer
> > const attribute is cast away, so we need to manually handle this by
> > determining the type of the pointer passed in to know the type of the
> > pointer to pass out.
> 
> Alternatively container_of() could be fixed, but that will likely produce
> lots of warnings currently.

Yeah, we can not do that because, as you found out, there's just too
many warnings that it would cause.  Let's work on the individual
subsystems to clean them all up first before worrying about the core
container_of() macro as that should fix the majority of the build
warnings.

> > Luckily _Generic can do this type of magic, and as the kernel now
> > supports C11 it is availble to us to handle this type of build-time type
> > detection.
> > 
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2 - use _Generic() to make this type safe as pointed out by Sakari
> > 
> >  include/linux/device.h | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 424b55df0272..023ea50b1916 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -680,11 +680,27 @@ struct device_link {
> >  	bool supplier_preactivated; /* Owned by consumer probe. */
> >  };
> >  
> > -static inline struct device *kobj_to_dev(struct kobject *kobj)
> > +static inline struct device *__kobj_to_dev(struct kobject *kobj)
> >  {
> >  	return container_of(kobj, struct device, kobj);
> >  }
> >  
> > +static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> > +{
> > +	return container_of(kobj, const struct device, kobj);
> > +}
> > +
> > +/*
> > + * container_of() will happily take a const * and spit back a non-const * as it
> > + * is just doing pointer math.  But we want to be a bit more careful in the
> > + * driver code, so manually force any const * of a kobject to also be a const *
> > + * to a device.
> > + */
> 
> container_of() documentation has (probably?) never warned about this.

We never thought of it before :(

> Wouldn't such a comment be more appropriate there? Albeit it wouldn't be
> needed if container_of() were fixed.

Some comment added to container_of() would be great, but that does not
remove the need to keep this one.

thanks,

greg k-h
