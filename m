Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52965E77E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIWKEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIWKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:04:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18F132FDD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663927437; x=1695463437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tyqPzskNPVwT5t1P1vdNGzVL76ul4459fMZhNXWkdXw=;
  b=maFOh9KcQzj+VhHuA2XyevsvERoAqEOyyfEP270vMBphY8r5ocAFM172
   EU0z5KoAK0S2HbA+WNO3mI85VbwJq/hM9oRf78ykric4DRAurIP8R13/T
   ydulwWtIfhcZ8VxVlYJ5BD1WhKdl3jsPNxCScbGYAJW29gmsDunkFFjjJ
   cc20Ax3dfMF9xfoVOKmwINqt+SVnyouYA5EFl/YvXxdMZN0E0oNmbCMcS
   a/AzyOZ5sMHqxcePzYHwb9XxMHDBcFYTQAN420xjRjdLef65hT6JEaxHe
   L1f32iDBnijc661reUjOdo/7wnPlRki1qOKtPVuB/1hUkNjbdqBq1sWku
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386850027"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="386850027"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571327271"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2022 03:03:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obfXG-006PeU-21;
        Fri, 23 Sep 2022 13:03:54 +0300
Date:   Fri, 23 Sep 2022 13:03:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yy2EiqQQR1oWf7Nd@smile.fi.intel.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
 <Yyz/7gWdP+ftQdIO@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyz/7gWdP+ftQdIO@lorien.usersys.redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:38:06PM -0400, Phil Auld wrote:
> On Thu, Sep 22, 2022 at 10:49:54PM +0300 Andy Shevchenko wrote:
> > Currently the approximation is used which wastes the more memory
> > the more CPUs are present on the system. Proposed change calculates
> > the exact maximum needed in the worst case:
> > 
> >   NR_CPUS	old		new
> >   -------	---		---
> >   1 .. 1170	4096		4096
> >   1171 .. 1860	4098 ..	6510	4096
> >   ...		...		...
> >   2*4096	28672		19925
> >   4*4096	57344		43597
> >   8*4096	114688		92749
> >   16*4096	229376		191053
> >   32*4096	458752		403197
> >   64*4096	917504		861949
> >   128*4096	1835008		1779453
> >   256*4096	3670016		3670016
> > 
> > Under the hood the reccurent formula is being used:
> >   (5 - 0) * 2 +
> >     (50 - 5) * 3 +
> >       (500 - 50) * 4 +
> >         (5000 - 500) * 5 +
> >           ...
> >             (X[i] - X[i-1]) * i
> > 
> > which allows to count the exact maximum length in the worst case,
> > i.e. when each second CPU is being listed. For backward compatibility
> > for more than 1170 and less than 1861 CPUs the page size is preserved.
> > 
> > For less than 1171 and more than 1 million CPUs the old is being used.
> 
> The memory is not really wasted since it's probably temporary in userspace
> and in the kernel it _is_ temporary and is only the length of the kasprintf
> string, which is most of the time much less.
> 
> But that said, it is more accurate than the previous estimate.
> 
> I was wondering if you were going to try to come up with a suitable
> compile time macro :)
> 
> I tested 2, 8192 and 16k since the kernel does not want to build for other
> reasons with NR_CPUS at 32k.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Tested-by: Phil Auld <pauld@redhat.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


