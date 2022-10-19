Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973DC6043C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiJSLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJSLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:48:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1AC127936
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178850; x=1697714850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eqonge+wHkiqgLHKvqOhPhnyda6qF8W9bzV081g2Vx8=;
  b=NONbrncXcdtX1c3Nf8ilRqtvSeLD5A8i/b2J81YlS4IW0ZyYVlIHhrVw
   QDWVrprEZKeU2SJcuVBQqf1VtHPJs+Nc4oA9qLGzaqT/4Q7sCFJpRyIOE
   hvCAnC9VWJLDhWrnJuh85KYHY0suQ8pemZ5PhRAHrRFCoXkD0g/fSnDZn
   RQ8z5Ycce5l5s8n5mnPIn8qRP4HO5GuI+CQeoaXd8IRD0NIhsm6dvpa/F
   O4Hf5TjfKocGm+XTPUozqTv2thIvnkvVppmDxJeYKvLGl7gjEYatIGqtd
   2nV4DgWMw/8O5/HJix0AQaGb9pyEmMBVTt1xPAxogZzg5mQmFgKjA5KMZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303998848"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="303998848"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804256560"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804256560"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2022 04:25:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol7CR-009pTW-1C;
        Wed, 19 Oct 2022 14:25:27 +0300
Date:   Wed, 19 Oct 2022 14:25:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jane Chu <jane.chu@oracle.com>, Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Message-ID: <Y0/ep9LS5jVTrUWI@smile.fi.intel.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
 <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
 <Y08RVzvniYr8ycKV@smile.fi.intel.com>
 <198982F5-E94C-4F95-8197-FE69EFBA670F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198982F5-E94C-4F95-8197-FE69EFBA670F@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:43:07AM +0000, Haakon Bugge wrote:
> > On 18 Oct 2022, at 22:49, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 18, 2022 at 08:30:01PM +0000, Jane Chu wrote:

...

> > Obviously, to see the crash. And let kernel _to crash_. Isn't it what we need
> > to see a bug as early as possible?
> 
> If you follow that argument, why doesn't the kernel crash when the pointer
> is, e.g., a NULL pointer? According to you, shouldn't it crash a early as
> possible in that case also?

Because it is _special_. It's not just an invalid pointer. There may be
very well good cases where we supply (valid!) NULL pointers to the printf().

-- 
With Best Regards,
Andy Shevchenko


