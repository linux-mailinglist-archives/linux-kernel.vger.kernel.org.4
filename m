Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A3625A44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiKKMJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiKKMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:08:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00AB7F541;
        Fri, 11 Nov 2022 04:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668168533; x=1699704533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rIbMlpuPRAQ91v7W/uZ0HA2BqN/O8vbgDUDTNRK8CyI=;
  b=E+pktuIJmomBV8BDf9KoZqwSRD7b25gXyQUOi74blq4OBmZaHOVwLInu
   3JrtUQ1sBgDt9/dJh5unrhFRNGppHhSTfDDvebVbx1K0OFdX6itet0Khi
   UyGzjMvy+B9vbdZcBYayuOUMpvXYcL0nVxxPgT94ZTWm//rMhIICNJxDx
   mxbe0wwBNOolER/PYoNGDmQVMx7SopGtxmG4GrsqB4IsZ1JGKCF+cL6EH
   mCePr5H2C3+vfLRIDkfHi3HHnMzQ1LuSSqnezHtQosjf6AjC+jZZ7oQVp
   i5JNojjj/WHg55ZmSrlHekByP8wPDGg2IguXFFJV+r4ai3zlAgfa4EHgt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313373532"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="313373532"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="726769201"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="726769201"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2022 04:08:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otSq0-00Aghb-2p;
        Fri, 11 Nov 2022 14:08:48 +0200
Date:   Fri, 11 Nov 2022 14:08:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in
 struct nvm_data
Message-ID: <Y247UMkAUafPTBYI@smile.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <YwTf22gkWxeyNKlR@smile.fi.intel.com>
 <Y246keIq4a541ooO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y246keIq4a541ooO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:05:37PM +0200, Andy Shevchenko wrote:
> On Tue, Aug 23, 2022 at 05:10:35PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 26, 2022 at 03:05:49PM +0300, Andy Shevchenko wrote:
> > > The struct i2c_client pointer is used only to get driver data,
> > > associated with a struct device or print messages on behalf.
> > > Moreover, the very same pointer to a struct device is already
> > > assigned by a regmap and can be retrieved from there.
> > > No need to keep a duplicative pointer.
> > 
> > Thanks, Bungbu, for the review. Can it be now applied?
> 
> Don't see this being applied or commented why not...
> 
> Mauro? Or who is taking care of this driver nowadays?

Okay, found a private response by Mauro where he tells that Sakari can take
care of this. Sakari, should I resend this to you with all tags applied?
Or you can use `b4` tool that allows to avoid unneeded resend.

-- 
With Best Regards,
Andy Shevchenko


