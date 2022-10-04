Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340085F3E09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJDIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJDIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:16:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54279399DE;
        Tue,  4 Oct 2022 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664871348; x=1696407348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lb4bSlvedpaQjVg5odfIx4IN7U+kZA4eNgmQRJpfroI=;
  b=P23mBDfO+uLz94rCQ0fCu5q7ZzpBPvqmJ26luZJPYx6BfayVrYFVPjcr
   t+cTuRYA6XUj/NpLzc6YcGWNkYyrFBSgxbPpDlmVtSOubzvzVavsZnFmf
   rX7/1qhS+LnO+hadgoc/mFiKSjlgwq5nRkcpHTb49zbT4u+AE+6ETptXc
   smkn9bT0BGl2D/PyhA2yixZFmaYUPA2bgvkMEwzGOP4WtIJSiUOlKqz/A
   1Fl+jT/+WgzC9M7GQV1UX2TpJ1o5/JnloKRYeEmMAsZCLtL+PtigdF3BY
   X/fzmXeALrUtH9bmkjbY1eKBtXl3St6Ra1q8AXufOFXQEzemXwwp9dGjG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="364753558"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="364753558"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="692397954"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="692397954"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2022 01:14:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofd4A-001xvm-2X;
        Tue, 04 Oct 2022 11:14:14 +0300
Date:   Tue, 4 Oct 2022 11:14:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
 <Yzr6r5XtmPXCoQx7@kroah.com>
 <YzsLDUhjDCCVRy2G@kroah.com>
 <YztBWlmdgylsntgM@paasikivi.fi.intel.com>
 <Yzvm6XF0Ar35XZvT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzvm6XF0Ar35XZvT@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 09:55:21AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 03, 2022 at 08:08:58PM +0000, Sakari Ailus wrote:
> > On Mon, Oct 03, 2022 at 06:17:17PM +0200, Greg Kroah-Hartman wrote:

...

> > #define kobj_to_dev(kobj)						\
> > 	(_Generic((kobj),						\
> > 		  const struct kobject *: __kobj_to_dev_const,		\
> > 		  struct kobject *: __kobj_to_dev)(kobj))
> 
> Ah, doh!  I had the (kobj) part in the wrong place, thanks for that
> fix...
> 
> Ok, this looks better, let me see how well the build breaks with some of
> these changes

I believe I can rewrite my patch like this and then it will be much nicer since
we may constify all the rest without calling __dev_fwnode_const() directly.

Are you agree?

-- 
With Best Regards,
Andy Shevchenko


