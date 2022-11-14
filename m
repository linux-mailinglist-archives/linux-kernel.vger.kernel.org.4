Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA90628799
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiKNR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiKNR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:57:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0B25EBA;
        Mon, 14 Nov 2022 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668448643; x=1699984643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cc3hg2VIM6L+Sab51F6eBaTWDmyo6t4XvJHG+xF3G0U=;
  b=KtdNY1sXkyV/Xc+Avm4b9uu2Czba0SM3YPIdhar0OrgbmTTB0SgSsTj7
   qMEvdIzC8gyL+wP9XlioFMIzlRXsxEkuEGxYOYySNW2sHt/U1GmqwAKTT
   OTPE5uMJYrqD89mak15ydH6W76eucLfJfG6vJ4tYuWQ4AcsEmDOzUtkJ5
   jzK7lgaNyaO7QwFahmemv5Upj0WoFNUOdNfeVh+mG1YkpMxafzxtIVsxm
   J3Jj4jU5AwyiPcfa/VwrRTUXMkINGBHz0iLyb0wP1mzJKKnrcpj92/c1U
   x0e9K9c+XdefShCr66OFa5bCrsJQbNWo9YBmQe8caZktpb6M9mdiBM3GC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310746983"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310746983"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 09:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="671657096"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="671657096"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2022 09:57:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oudhs-00CHlc-2X;
        Mon, 14 Nov 2022 19:57:16 +0200
Date:   Mon, 14 Nov 2022 19:57:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Kevin Cernekee <cernekee@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/4] list: Introduce list_count() to count existing
 nodes
Message-ID: <Y3KBfLLyQZ7Q95bG@smile.fi.intel.com>
References: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
 <202211142350.i0ngTfIl-lkp@intel.com>
 <Y3JmtNExJulq2CEE@smile.fi.intel.com>
 <Y3J/KUBu3adGPiwT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3J/KUBu3adGPiwT@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:47:21PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 14, 2022 at 06:03:00PM +0200, Andy Shevchenko wrote:
> > Oh, nice! I will fix this for v2.
> 
> list_count() is an antipattern.  I don't have any of the patches in
> my inbox, so maybe there's a great reason for doing this, but my
> immediate response is: NAK.

When we are trying to hide iterator variable in many cases, leaving the current
code alive will allow explicit access to it. If it's not a problem, why to
bother with the other list APIs then?

-- 
With Best Regards,
Andy Shevchenko


