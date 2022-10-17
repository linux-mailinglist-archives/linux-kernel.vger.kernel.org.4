Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C9600B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJQJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJQJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:39:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC74DFC2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999573; x=1697535573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WwnUpgFu5AN/ooYT/8TmVikfHg1N3FXtMXITc9/UBWE=;
  b=C9tX8OyKnPkM129wnUt+uQzRmJm8Q6Bm1R7UvgNvZAbUmfZgsfbk2rjW
   rbqpq0JH7ZtSrPgM3ocd/UjMCI1/wJ7bx39NZdsQqjXzXtVoi7ozIK9DY
   mmxVebBqUs8mJeT7Hr6pmQu4KqoaQT+GbTXsIWhsB8Kkn1z82UQtmjMzW
   Y3ShrzZycvc6kMnj+cBCy85gAF5HoX5L//4kNlLohgR3d6/WFT3INcR6W
   edW9CKjbPP4GWBl8MfE/l92rQ6GfzJoDiWClL852gK5l/VuLHy/RctWU5
   PR/acN+I9tnlJebdeS/GgALVDO/XQSf0VxGQByorX9YXasUxL8sKcKGRy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="392058153"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="392058153"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:39:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="661426175"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="661426175"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:39:30 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 08A8A20310;
        Mon, 17 Oct 2022 12:39:28 +0300 (EEST)
Date:   Mon, 17 Oct 2022 09:39:27 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Message-ID: <Y00iz8whhW+N8xSc@paasikivi.fi.intel.com>
References: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
 <Y00KTAobXJ0/Jgv3@paasikivi.fi.intel.com>
 <Y00Mfgymi+Xv6El3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y00Mfgymi+Xv6El3@kroah.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 17, 2022 at 10:04:14AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 17, 2022 at 07:54:52AM +0000, Sakari Ailus wrote:
> > Hi Greg,
> > 
> > On Sun, Oct 16, 2022 at 12:41:26PM +0200, Greg Kroah-Hartman wrote:
> > > If a const * to a kobject is passed to kobj_to_dev(), we want to return
> > > back a const * to a device as the driver core shouldn't be modifying a
> > > constant structure.  But when dealing with container_of() the pointer
> > > const attribute is cast away, so we need to manually handle this by
> > > determining the type of the pointer passed in to know the type of the
> > > pointer to pass out.
> > 
> > Alternatively container_of() could be fixed, but that will likely produce
> > lots of warnings currently.
> 
> Yeah, we can not do that because, as you found out, there's just too
> many warnings that it would cause.  Let's work on the individual
> subsystems to clean them all up first before worrying about the core
> container_of() macro as that should fix the majority of the build
> warnings.

Sounds reasonable.

> 
> > > Luckily _Generic can do this type of magic, and as the kernel now
> > > supports C11 it is availble to us to handle this type of build-time type
> > > detection.
> > > 
> > > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > v2 - use _Generic() to make this type safe as pointed out by Sakari
> > > 
> > >  include/linux/device.h | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 424b55df0272..023ea50b1916 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -680,11 +680,27 @@ struct device_link {
> > >  	bool supplier_preactivated; /* Owned by consumer probe. */
> > >  };
> > >  
> > > -static inline struct device *kobj_to_dev(struct kobject *kobj)
> > > +static inline struct device *__kobj_to_dev(struct kobject *kobj)
> > >  {
> > >  	return container_of(kobj, struct device, kobj);
> > >  }
> > >  
> > > +static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> > > +{
> > > +	return container_of(kobj, const struct device, kobj);
> > > +}
> > > +
> > > +/*
> > > + * container_of() will happily take a const * and spit back a non-const * as it
> > > + * is just doing pointer math.  But we want to be a bit more careful in the
> > > + * driver code, so manually force any const * of a kobject to also be a const *
> > > + * to a device.
> > > + */
> > 
> > container_of() documentation has (probably?) never warned about this.
> 
> We never thought of it before :(
> 
> > Wouldn't such a comment be more appropriate there? Albeit it wouldn't be
> > needed if container_of() were fixed.
> 
> Some comment added to container_of() would be great, but that does not
> remove the need to keep this one.

I can send a patch for that.

For this one:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
