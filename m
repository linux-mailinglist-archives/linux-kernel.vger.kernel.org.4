Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6360731F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjFORbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFORbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:31:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15611171F;
        Thu, 15 Jun 2023 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686850274; x=1718386274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83wWVQfLz1m9xirpCsvcg65m3Ddj7atESArkTnfXNKI=;
  b=hkCxQoPvIGQZcd5WnmQsXbZHvQ615Q4Uu6Q6exLAbCWvfOh9XrbByB84
   A6C5+PtZ6oa0Q0w6swehVtHRkKSNkf1yuM59jigAG7ihQ8E5xnZA6WSlB
   HYqgaNrxgUD3ivWtC0xgXAlUsr+KL/h5ifxM2ypQYXsMAMsPdL6VSHZ1z
   fh2Td1ByHDtpjQTBvMCDueHj4hU9FSoeO6nbtysqCD8L2q62M0SIbD+F6
   LNzwp5O0ovh50JUafhwZnQHhG3YOIrUYjW7VnEXJeLjkVKzOi8Tz9h3gB
   2rY1aM6+k/kTzvUd0bBXKFV4euIRktYBPN4Nxru3MSumm7/3XhdboYWc1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362402335"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="362402335"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="662864086"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="662864086"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 10:20:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9qeC-003zpu-1p;
        Thu, 15 Jun 2023 20:20:36 +0300
Date:   Thu, 15 Jun 2023 20:20:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] of/platform: Propagate firmware node by calling
 device_set_node()
Message-ID: <ZItIZHfCji4EhfXk@smile.fi.intel.com>
References: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
 <ZIsnaE95qIJ2DVzK@smile.fi.intel.com>
 <ZIsnvXztBQvtYw9b@smile.fi.intel.com>
 <ZIsoWBxb8aGdJ4ja@smile.fi.intel.com>
 <20230615164452.GA1166619-robh@kernel.org>
 <ZItGzw5HO/GFoRAD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZItGzw5HO/GFoRAD@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:13:52PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 15, 2023 at 10:44:52AM -0600, Rob Herring wrote:
> > On Thu, Jun 15, 2023 at 06:03:52PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 15, 2023 at 06:01:17PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jun 15, 2023 at 05:59:52PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Jun 15, 2023 at 05:52:43PM +0300, Andy Shevchenko wrote:

...

> > > > > in the code which seems to me problematic in two ways:
> > > > > 1) (minor) the dev_set_name() may fail, no checks are there;
> > 
> > Is there anything besides a memory alloc failure? What will print a
> > message already. Wouldn't we fail a bit later on when adding the
> > device anyways?
> 
> I don't see how we fail. Any pointers?

Okay, code in question:

        /* subsystems can specify simple device enumeration */
        if (!dev_name(dev) && dev->bus && dev->bus->dev_name)
                dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);

        if (!dev_name(dev)) {
                error = -EINVAL;
                goto name_error;
        }

-- 
With Best Regards,
Andy Shevchenko


