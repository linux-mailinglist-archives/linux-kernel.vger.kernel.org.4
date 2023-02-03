Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130326897B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjBCL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBCL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:27:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE52DBD3;
        Fri,  3 Feb 2023 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675423642; x=1706959642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hW7xhtnF8gNROlujBQN9ZAct9VYqsVnF0IOe3ubArk=;
  b=HHux/boVtgbiGBiewRqgGRaNgKcJNC1kf9HOGRk5YnMmnkqZyFtJgrrv
   8itFF2/hUi+brktoD3oZwtJ9mG6us3sOtQzNiR9hQMgi+mcOjIn84MjzD
   ijdlhEOcrB+h/tL+Fk7t/Rpd2xNq4ChiNPhSDLwjphc9gOog+C5JPrE5Q
   sCzozs8ETF6cmZw65qtZpDOcLO/8fbSeuT1VEA8xbEvrV2oOIi+ab1l4t
   5DItzqHaHdY11WVvBhe3Q4D+8d1YrfjoDgg64r1Y6FqbKoRGY8Q6Ff96U
   nvXtRrHoDbEZPsVIbf/G6JTaVjdDYh8RHVgmQX4n4ym0u4ngPr4TWGk8y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="330010694"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330010694"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 03:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994493386"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="994493386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2023 03:27:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNuDu-001Z6j-0V;
        Fri, 03 Feb 2023 13:27:18 +0200
Date:   Fri, 3 Feb 2023 13:27:17 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] usb: gadget: configfs: Use memcpy_and_pad()
Message-ID: <Y9zvlZB8iXCOp/RU@smile.fi.intel.com>
References: <20230202151736.64552-1-andriy.shevchenko@linux.intel.com>
 <c97c4048109242228b0af3199a67f0bc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97c4048109242228b0af3199a67f0bc@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:21:09PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 02 February 2023 15:18
> > 
> > Instead of zeroing some memory and then copying data in part or all of it,
> > use memcpy_and_pad().
> > This avoids writing some memory twice and should save a few cycles.
> 
> Maybe, maybe not.
> It rather depends on the lengths involved (the code doesn't seem to be in the
> main tree).
> 
> The cost of the conditionals and the misaligned length/start for the
> memset() could easily overwhelm any apparent saving.
> 
> A memset() of a constant whole number of words is going to be significantly
> faster than the partial one.


Then you can put some (little I suppose) efforts in optimizing memcpy_and_pad()
once for all, no?

-- 
With Best Regards,
Andy Shevchenko


