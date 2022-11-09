Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37E5622C29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKINLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKINLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:11:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A948BE04;
        Wed,  9 Nov 2022 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667999482; x=1699535482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YRItrPY4VcR4I3VaJ8cZTMt3FIj4ySR8Tj7kXkJH8k=;
  b=iR2rXPeCxyfxtk64fWA7My8WVhOSAw9ytW5YM1wq14NQXDIUmVr7isSh
   Yrn/4Z7RPXGU0ltGDLLI3nRRe4d3x4PgF+DsGhTHe9OOk4ju09XpwqFWF
   UpMLEWwvqSDjNBOCftqfuC9ANrpClcO01nazcgiul3SiyaHoRqSvrccbi
   FprCPS+ru+yXB7eIHeD3vtdI7jJ+MMhz5Dq+Q96sCn0fGmts+ohXdSJWK
   qZMng96lbhDKiA5Pg/AtI3KNv8rTVL3H3ek0pfvr8zhuOXCh1QE9Z0pWa
   Mu0tyDae0P4goBlYxrnPKVPOzloP9GoXeaI3w+ak0gl6l2b8rO+OewUkf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310967580"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="310967580"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 05:11:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669945564"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="669945564"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 09 Nov 2022 05:11:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oskrN-009kUe-2E;
        Wed, 09 Nov 2022 15:11:17 +0200
Date:   Wed, 9 Nov 2022 15:11:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/5] rtc: rtc-cmos: Assorted ACPI-related cleanups and
 fixes
Message-ID: <Y2um9emkYeYP0ZZM@smile.fi.intel.com>
References: <5640233.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5640233.DvuYhMxLoT@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:05:13PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a v2 of the series previously posted as
> 
> https://lore.kernel.org/linux-acpi/2276401.ElGaqSPkdT@kreacher/
> 
> The first three patches in the series have not changed since then (I have
> considered moving the last patch, which is a fix, to the front, but that turns
> out to be a bit cumbersome and not really worth the effort).
> 
> This series of patches does some assorted ACPI-related cleanups to the CMOS RTC
> driver:
> - redundant static variable is dropped,
> - code duplication is reduced,
> - code is relocated so as to drop a few unnecessary forward declarations of
>   functions,
> - functions are renamed to avoid confusion,
> and fixes up an issue in the driver removal path.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


