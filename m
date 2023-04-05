Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13756D8065
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbjDEPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbjDEPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:05:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E3170B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680707141; x=1712243141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQwUP8oUlq/AHSzZr6up0slAdagyrjv2FoE08wFqvPg=;
  b=NHRgD4ACJ6UY9KFlUe7pzJpjyM32NmbHD1h+aVVE0cdykldlhITPIAFL
   g6c5NE1CfF8dsQO8X6tso1/u0VLVgkjUFxICghljxrbf5PxzmZ8P4EYvg
   IesbQIhoqvEP3BDVuAjaVePca2tAO3PjeQ7CGnhyBuF+n93m9EKLKfU0E
   umbMCjsUxJqQqvKgR2Mepntv1Pg9ZwJhGF4fm8vjxC428xOPunpU/mRrq
   CHPTIu4WnFKpAekxDQ+jeWey0DxlR2MpNEycnHSLoJtSsWVe0KCQSwUSN
   Ar2KInii07/BaPXn9ekF0koqjJoQcBRAnwDjeYRaGX/fA30PCqcxhDCnP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="407561243"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="407561243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="932875451"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="932875451"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 05 Apr 2023 08:05:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk4hV-00Csc6-2w;
        Wed, 05 Apr 2023 18:05:29 +0300
Date:   Wed, 5 Apr 2023 18:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 08/14] extcon: Switch to use kasprintf_strarray()
Message-ID: <ZC2OOWBEUEv7RiiK@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-9-andriy.shevchenko@linux.intel.com>
 <546c0079-6b1c-9a67-a4c6-328eeb8c5ba7@gmail.com>
 <ZC0uZJd5h1wUpZoP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC0uZJd5h1wUpZoP@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:16:36AM +0300, Andy Shevchenko wrote:
> On Mon, Apr 03, 2023 at 11:58:41PM +0900, Chanwoo Choi wrote:
> > On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> > > Since we have a generic helper, switch the module to use it.
> > > No functional change intended.

...

> > > +	edev->cable_names = kasprintf_strarray(GFP_KERNEL, "cable", edev->max_supported);
> > > +	if (!edev->cable_names) {
> > > +		kfree(edev->cables);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > >  	for (index = 0; index < edev->max_supported; index++) {
> > >  		cable = &edev->cables[index];
> > >  
> 
> > > +		str = edev->cable_names[index];
> > > +		strreplace(str, '-', '.');
> > >  
> > >  		cable->edev = edev;
> > >  		cable->cable_index = index;
> 
> ...
> 
> > >  	/* /sys/class/extcon/.../cable.n/... */
> > >  	struct device_type extcon_dev_type;
> > >  	struct extcon_cable *cables;
> > > +	char **cable_names;
> > 
> > The extcon cable information should be included in struct extcon_cable
> > in order to gather information into one point like encapsulation.
> > 
> > I don't prefer to add 'cable_names'.
> 
> I don't get this. The idea is to allocate the cable names in one call,
> we have already API for that. The cable names are kept in the struct
> extcon_cable as before. So, functionally it doesn't change anything,
> it is a simple cleanup.

Okay, I see now your point. I can redo this a bit better I think.

-- 
With Best Regards,
Andy Shevchenko


