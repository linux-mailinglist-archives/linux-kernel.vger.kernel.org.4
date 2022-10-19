Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681806043D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJSLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiJSLtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:49:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA2F88ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178890; x=1697714890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GPiHYhwzKv229GIoI4leHmbp7dD7is3pRFdEJEGcnw=;
  b=LzLnkYXDWu8NgUEd3rnrFtxWv5v6Li4hamcOM0QAU0DOVaZCxsDyyAzG
   Y452/ZtU1oI4/x/CpLdcnKxmJ9DAiE8cy8R68o0PWRF5QYtkPqOWe+0zE
   074k130oawBsvgI8jDO0zk4xOuhMTdVw8XsGjexo9jSVbMHvzS8ENgetD
   m5p56abxbhn+MTsNByxggyTqHMvm3nYBnqOk+Yyn5YAECsU49WBu78QEz
   z46tgDpLtEeE0AuXnp/g0trkbkfQElin4av/1fmPppMvDU0qz/1PG8ejj
   bE+iDfq2BVnW8HscZnSDkFg/tCJXYY0GSvTd0D/QhS2AH3WzeADJxzDQn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392682569"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="392682569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="631621229"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="631621229"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2022 04:22:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol79k-009pPq-29;
        Wed, 19 Oct 2022 14:22:40 +0300
Date:   Wed, 19 Oct 2022 14:22:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] cpumask: limit visibility of FORCE_NR_CPUS
Message-ID: <Y0/eAD+eN7+3R/4Q@smile.fi.intel.com>
References: <20221019052200.1604488-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019052200.1604488-1-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:22:00PM -0700, Yury Norov wrote:
> In current form, FORCE_NR_CPUS is visible to all users building their
> kernels, even not experts. It is also set in allmodconfig or allyesconfig,
> which is not a correct behavior.

Seems you forgot to update the commit message to explain the choise usage.

-- 
With Best Regards,
Andy Shevchenko


