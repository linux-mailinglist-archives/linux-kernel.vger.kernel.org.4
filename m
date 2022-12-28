Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CBE6574F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiL1Jva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiL1Juh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:50:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AF510075;
        Wed, 28 Dec 2022 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672221036; x=1703757036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcHRyTOIWLvjQ22vBtCT8JpVqWGWk/i6Ux7FH4hlVT8=;
  b=I4VJWIhIz73moz63vBg/B00NjrFi9aGo/jdNvDflnIJKLz0BbDXzLXvt
   VElGmlT35eabB9JxqSFrcqKt+SoV/xMjJ8g/9KNEvnEmSaglJS/TZ/dfm
   trH9qogjZ478HnbAh4NHOx2Ouh53urfN+iQeewYY4gFwDqyBqdEosbVQc
   sw4cMKnjoCtD+2Kmh6NczW9PVKThW48pywynWjvvIApsTlvApZKekNksK
   n2bZsYaZgzUySNxdppOGJk0CeAJ4eCMSNziTOvpjGK0PgciRi4edJCB4A
   yf/LL+dpGjElTJvGvY0zmIR0GR8P/LPssYKY9fJ8zV/XkjdW5k4xjYZlO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="385266942"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="385266942"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="655265447"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="655265447"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2022 01:50:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAT4y-000WIj-00;
        Wed, 28 Dec 2022 11:50:32 +0200
Date:   Wed, 28 Dec 2022 11:50:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, rafael@kernel.org
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y6wRZyvqY2AhTLbp@smile.fi.intel.com>
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
 <Y6wOS8NFAZc5+piJ@smile.fi.intel.com>
 <Y6wQZOn+fObx0Mua@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6wQZOn+fObx0Mua@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 10:46:12AM +0100, Greg KH wrote:
> On Wed, Dec 28, 2022 at 11:37:15AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 23, 2022 at 10:25:42AM +0800, Yang Yingliang wrote:
> > > The 'parent' returned by fwnode_graph_get_port_parent()
> > > with refcount incremented when 'prev' is not NULL, it
> > > needs be put when finish using it.
> > > 
> > > Because the parent is const, introduce a new variable to
> > > store the returned fwnode, then put it before returning
> > > from fwnode_graph_get_next_endpoint().
> > 
> > Rafael, Greg, is this went through the cracks?
> 
> Yes, but still in my queue.  I'll look at it when I get back from break.

Have a nice one!

-- 
With Best Regards,
Andy Shevchenko


