Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611266242B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjAIL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjAIL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:26:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EBC167CE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673263569; x=1704799569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3qWXvBiMwic5hXKXKXJ43zm4Wa3xTBKTNHaKUocqVo4=;
  b=gB4Oq549qGczHE/YStje1ezFyv0ATpIk4NVvwJiYZC8KYx8Bf2oKfj12
   LEErneJ6zZAiqzJ1jAMpY87Pt2f6Uv4N/c+5fkJUNFAKS1+YqVZx6D2GV
   zmSdttqyJt/5dDdNiXaz/FyhlxzhMNO7F9USvNGYywCwfkYNnYuJATzXM
   RndNM18kOoQmcjB23RWJ0kXBkUInycTEITUIap0Li+mxuwD1dDHozLFn3
   PNHV0+jOZGOtZ0jhwZupn3393Ps9Ycye0QjHo7PFBhDlekv1zwEpb8vlw
   MTpS2EU4n2uNpjYyUjm3xMA1Gf46d6QTc17C4MgXLd1qYqFoiMktxvi6H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="350063960"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="350063960"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="719907230"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="719907230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2023 03:26:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEqI1-006Mdc-0n;
        Mon, 09 Jan 2023 13:26:05 +0200
Date:   Mon, 9 Jan 2023 13:26:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
Message-ID: <Y7v5zP5FDkeGpv4D@smile.fi.intel.com>
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
 <Y7v5PEcP3LAcfTdk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7v5PEcP3LAcfTdk@smile.fi.intel.com>
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

On Mon, Jan 09, 2023 at 01:23:40PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 06, 2023 at 12:16:31AM +0300, Sergey Shtylyov wrote:

...

> > +	/*
> > +	 * C99 allows @buf to be NULL when @size is 0. We treat such NULL as if
> > +	 * @buf pointed to 0-sized buffer, so we can both avoid a NULL pointer
> > +	 * dereference and still return # of characters that would be written
> > +	 * if @buf pointed to a valid buffer...
> > +	 */
> > +	if (!buf)
> > +		size = 0;
> 
> Do we have test cases for that?

This still stays...

> And what's wrong to print "(null)" ? Have you checked if your patch makes any
> regressions to those cases?

...but this paragraph is not for the case (I mixed it with the arguments to be
NULL).

-- 
With Best Regards,
Andy Shevchenko


