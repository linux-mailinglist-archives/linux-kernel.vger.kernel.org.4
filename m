Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8895E7DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiIWPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiIWPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:07:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B027E7437
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663945668; x=1695481668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qaVWvEDVD+x5lA6GPpq9Rq8DSk3IuDySoon4s6djK4o=;
  b=gG4Fj0Isb1Ug2ZawvgTbRlGlNuGnJGiGMVXtJszMzA4T0dPtiNjvQzNi
   W7t2XLiZj07jn3erV/CylU1+IDP6ES6n8kLMDQCrt02zpxW3q5hcNbh07
   7Xg/Mbcq138B4NJz8B/VvgFnn0zbcQ6K5HTJd9Dp8Hv/JMW730/7Dd5t3
   9iKVe3mefjDNRxXibi2J+9/0VHxNeZewo+hlqbh6DLwepVJqtBmtsYf07
   7OBHjupeKmRAiErTqPQgF3MdFNG24GyaMQ8lufDmQjBj5toWyt8KIrK2/
   heousp2v1XYzfvLgc74SDp+hSiIhpkkAAGXWrxZuK7O9k2QEyVrW0f7TG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="326941386"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="326941386"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="622546910"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 23 Sep 2022 08:07:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obkHJ-006Vsg-0R;
        Fri, 23 Sep 2022 18:07:45 +0300
Date:   Fri, 23 Sep 2022 18:07:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yy3LwItsnEtQkngk@smile.fi.intel.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
 <36fc5ec8-12a3-fc04-a8da-59d4e08e41b6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fc5ec8-12a3-fc04-a8da-59d4e08e41b6@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 02:19:14PM +0200, Rasmus Villemoes wrote:
> On 22/09/2022 21.49, Andy Shevchenko wrote:
> 
> > + * which allows to count the exact maximum length in the worst case,
> > + * i.e. when each second CPU is being listed.
> 
> I don't think that's actually the worst case. I think that would be
> where 2 out of 3 cpus are listed. I.e., with 16 cpus
> 
> 0-1,3-4,6-7,9-10,12-13,15
> 
> is certainly longer than
> 
> 0,2,4,6,8,10,12,14
> 
> It's trivial to see that no bitmap with four consecutive bits can be a
> worst-case, and any bitmap with some three consecutive bits is as bad as
> the same one with the middle bit cleared (the rep just changes a - to a
> ,), so the worst case is definitely obtained among bitmaps with at most
> two consecutive bits.

Thanks, indeed, your variant seems aligned with the comment in the file.
I have checked on paper what could be the lengths for a few number of CPUs
and this what it comes:

  nCPUs		size

  10		13
  16		25 (13 + 12)
  32		59 (13 + 46)

and it's visible that the amount of numbers of the same order (in each 10th)
is up to 7. Which means that the worst case is like 7 numbers for the same
10th. On top it's up to 3 ranges, means adding 2 characters per each for
the delimiters.

So,
  10	7*1 + 3*2				=  13
  16	7*1 + 3*2 +  4*2 +  2*2			=  25
  32	7*1 + 3*2 + 15*2 +  7*2			=  57
  100	7*1 + 3*2 + 63*2 + 31*2			= 389

Where 4 is from (16-10)*7/10 and 2 is half of it (for the range delimiters).
In similar way the [15, 7] and [63, 31].

Not sure how we should round the numbers (perhaps 15 should be 16, it will
yield 61 in the 3rd line).

Hence we may see that for 100 we need almost 400 bytes to have, and formula
nCPUs * 7 / 2 won't work precisely.

That said, my patch is wrong (based on the wrong assumption of a worst case)
but current approximation seems undersized as well.

-- 
With Best Regards,
Andy Shevchenko


