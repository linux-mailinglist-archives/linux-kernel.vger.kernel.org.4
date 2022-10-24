Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88140609DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJXJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJXJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:23:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA761736
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666603391; x=1698139391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1IDCnTWE2rq8375NnRl516ZEPqpmCW5m5j0ASaRzdig=;
  b=LgOdVDXSiyNmERselKAW1rGPTqKwJRQ3YJWZCADnqD5tGnC1Hf5iRWWc
   TTSkmbjK4wl5ooLKyqSc1Re5Imp/1UTsPCCQ0V0Kq6SuglRRJVZdJhW8M
   u0GjKGnTd4euEjIrtT6sYA0q4b3Rw5m0ckcax23ATZB6kVuauG63BKUG+
   rNfFV8r20eW1tIpoNFIz+dFf2F2/wQh80Lk5dy93kJu/aCgO+DziJwng3
   zwBS1fAQRo3enMcKPd3A3Dmg2gENaIAQhE7XjpbUklZtcwrldX1wK9z+v
   d4NHVFh9YYgNZDdZD9VRy0E2r/laSf7vc4DUXqouT85+IxlJVg8McYI74
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="287094060"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="287094060"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="806249867"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="806249867"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2022 02:22:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omtfd-001MnD-0O;
        Mon, 24 Oct 2022 12:22:57 +0300
Date:   Mon, 24 Oct 2022 12:22:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZZcL/Q7QJ+YYhJ@smile.fi.intel.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:11:53AM +0000, Sakari Ailus wrote:
> On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:

...

> > Wait, no one uses this macro, so why not just remove it entirely?
> 
> Good question. It appears to be a (relatively) common pattern to look up
> something and the return its containing object if the lookup was
> successful. Doing a quick
> 
> 	$ git grep 'container_of.*:' drivers include
> 
> reveals more than 20 instances of the pattern. There are probably more
> those that use if for testing for NULL. I guess people don't know about
> this macro, apart from the developers of the staging driver it was added
> for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).

Maybe we can provide an example to keep this macro in the kernel, meaning
convert one of the drivers / subsystem to actually use it?

-- 
With Best Regards,
Andy Shevchenko


