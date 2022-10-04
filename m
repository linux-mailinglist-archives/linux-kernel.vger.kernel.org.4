Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927285F3E39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJDIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJDIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A81C123;
        Tue,  4 Oct 2022 01:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5472D612A4;
        Tue,  4 Oct 2022 08:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAABC433B5;
        Tue,  4 Oct 2022 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664871856;
        bh=L9ErYNdSZRiqO0Gq2HFs31+nFf9F85V1RMYELu0rytM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuBI7BAK9J2P1sMpfLs4RR6S1y9bSzjaCWKtm+eMek/hfzFvNn5ECiEh8/v/soei4
         RxZbawWrBRLOVUb/eSnzf1I0dv5g9K5QV7i4M4KKPp8rT/QUa1smJkENZ9fBUNj818
         P0/khJwxzcaAYpWpgnks52qWw64eb64+2QY94eOw=
Date:   Tue, 4 Oct 2022 10:24:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YzvtrXlv5X0LHAxa@kroah.com>
References: <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
 <Yzr6r5XtmPXCoQx7@kroah.com>
 <YzsLDUhjDCCVRy2G@kroah.com>
 <YztBWlmdgylsntgM@paasikivi.fi.intel.com>
 <Yzvm6XF0Ar35XZvT@kroah.com>
 <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:14:14AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 04, 2022 at 09:55:21AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 03, 2022 at 08:08:58PM +0000, Sakari Ailus wrote:
> > > On Mon, Oct 03, 2022 at 06:17:17PM +0200, Greg Kroah-Hartman wrote:
> 
> ...
> 
> > > #define kobj_to_dev(kobj)						\
> > > 	(_Generic((kobj),						\
> > > 		  const struct kobject *: __kobj_to_dev_const,		\
> > > 		  struct kobject *: __kobj_to_dev)(kobj))
> > 
> > Ah, doh!  I had the (kobj) part in the wrong place, thanks for that
> > fix...
> > 
> > Ok, this looks better, let me see how well the build breaks with some of
> > these changes
> 
> I believe I can rewrite my patch like this and then it will be much nicer since
> we may constify all the rest without calling __dev_fwnode_const() directly.
> 
> Are you agree?

Yes, I think this is a much better option, try it and see.  Below is the
patch I'm running through my build systems at the moment, feel free to
copy the style for your change as well.

thanks,

greg k-h


diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..023ea50b1916 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -680,11 +680,27 @@ struct device_link {
 	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 
-static inline struct device *kobj_to_dev(struct kobject *kobj)
+static inline struct device *__kobj_to_dev(struct kobject *kobj)
 {
 	return container_of(kobj, struct device, kobj);
 }
 
+static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
+{
+	return container_of(kobj, const struct device, kobj);
+}
+
+/*
+ * container_of() will happily take a const * and spit back a non-const * as it
+ * is just doing pointer math.  But we want to be a bit more careful in the
+ * driver code, so manually force any const * of a kobject to also be a const *
+ * to a device.
+ */
+#define kobj_to_dev(kobj)					\
+	_Generic((kobj),					\
+		 const struct kobject *: __kobj_to_dev_const,	\
+		 struct kobject *: __kobj_to_dev)(kobj)
+
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *			 by an IOMMU
