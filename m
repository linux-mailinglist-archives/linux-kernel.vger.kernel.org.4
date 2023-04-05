Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680526D769F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjDEIQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbjDEIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:16:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0AFF5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682600; x=1712218600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ii5q0xfgfBC39MZxPJVcwmpK/cTMrNnEkV2FpsNqsXo=;
  b=RGkb1b9GL6k3rqoMYUb6Ut7uEUELbEvAgOGO8rmlhw2hxe3jo7v/5d3+
   NE01UDfA7AajEtERefxk450w3p0tM9m6dp+pL0wDmfd/BbQHTu/ntGezC
   5PttpGKjAbqxY/IXnoOJQ7nlLCcXAyOepnNq5sTC2kQ5iEfb1YbVJWcKw
   cF7hZ/LK5saZSnwgWP9gPL2W/xqZbkp14w8SZSM2J9mlB0K94bExzyLqb
   xFB5s+hHHRVNBhzENW0MgRExDSoEDWuFsfc8N/dula28KXMisTeKQPuBY
   j3e65U8wKJBENjpzGSH5lGks6xGh/xgnCZgXAZsrxZTJX72xgtg6Xq3M2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344111078"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344111078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751190858"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="751190858"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 01:16:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyJo-00CkMF-2N;
        Wed, 05 Apr 2023 11:16:36 +0300
Date:   Wed, 5 Apr 2023 11:16:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 08/14] extcon: Switch to use kasprintf_strarray()
Message-ID: <ZC0uZJd5h1wUpZoP@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-9-andriy.shevchenko@linux.intel.com>
 <546c0079-6b1c-9a67-a4c6-328eeb8c5ba7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546c0079-6b1c-9a67-a4c6-328eeb8c5ba7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:58:41PM +0900, Chanwoo Choi wrote:
> On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> > Since we have a generic helper, switch the module to use it.
> > No functional change intended.

...

> > +	edev->cable_names = kasprintf_strarray(GFP_KERNEL, "cable", edev->max_supported);
> > +	if (!edev->cable_names) {
> > +		kfree(edev->cables);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	for (index = 0; index < edev->max_supported; index++) {
> >  		cable = &edev->cables[index];
> >  

> > +		str = edev->cable_names[index];
> > +		strreplace(str, '-', '.');
> >  
> >  		cable->edev = edev;
> >  		cable->cable_index = index;

...

> >  	/* /sys/class/extcon/.../cable.n/... */
> >  	struct device_type extcon_dev_type;
> >  	struct extcon_cable *cables;
> > +	char **cable_names;
> 
> The extcon cable information should be included in struct extcon_cable
> in order to gather information into one point like encapsulation.
> 
> I don't prefer to add 'cable_names'.

I don't get this. The idea is to allocate the cable names in one call,
we have already API for that. The cable names are kept in the struct
extcon_cable as before. So, functionally it doesn't change anything,
it is a simple cleanup.

-- 
With Best Regards,
Andy Shevchenko


