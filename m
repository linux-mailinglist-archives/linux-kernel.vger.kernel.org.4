Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0215C5E77D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIWKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiIWKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:01:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5089132FE6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663927296; x=1695463296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jJHTuksiCE5wLud/S3EfchWgkWzJ7V+e/fA5SCGQhtI=;
  b=IdAL3Al/LOXa2llhdQmmgQPlGCiBKJfekrr50Ve6Od3tHLLzftrqUK3j
   frY98yYfJ8N5vQzA4A88FJppNfUYMd0IQwhsTHofCZrUMq1vhcLQ3t+S7
   zqASq/S5EfUZ+gPndpPYZ6nJuRPuV9fBvNPJnD6QgiaYZyblvrs3HmPUV
   pFufNgaH2puLC6oCbs+fng6iMTzz1jH5aO9N/vs1iF1PMLf9z3sgHUFDl
   /NIG3QH8gdy7sX4rgMPPN3fZ1OBQkkoD0lzVxyCGW3XyGCs21tvKy4W8G
   1xJU2MLowClMIBBO9Zj7Vf8qyb6Zgh9LPn6BPFSNYhqxEfr8J7rTVe57p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326889087"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326889087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865241645"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2022 03:01:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obfUu-006Pam-31;
        Fri, 23 Sep 2022 13:01:28 +0300
Date:   Fri, 23 Sep 2022 13:01:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Phil Auld <pauld@redhat.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yy2D+N2amlMG4hoA@smile.fi.intel.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
 <YyzIhDDEiemWjLgI@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyzIhDDEiemWjLgI@yury-laptop>
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

On Thu, Sep 22, 2022 at 01:41:40PM -0700, Yury Norov wrote:
>  + Petr Štetiar <ynezz@true.cz>,
>  + Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> On Thu, Sep 22, 2022 at 10:49:54PM +0300, Andy Shevchenko wrote:
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
> 1861

No, this is correct for the PAGE_SIZE == 4096.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: described better the advantage for 1171..1860 CPUs cases
> >  include/linux/cpumask.h | 48 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 1b442fb2001f..12cf0905ca74 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -1122,6 +1122,21 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> >   *
> >   * for cpumap NR_CPUS * 9/32 - 1 should be an exact length.
> >   *
> > + * for cpulist the reccurent formula is being used:
> > + *   (5 - 0) * 2 +
> > + *     (50 - 5) * 3 +
> > + *       (500 - 50) * 4 +
> > + *         (5000 - 500) * 5 +
> > + *           ...
> > + *             (X[i] - X[i-1]) * i
> > + *
> > + * which allows to count the exact maximum length in the worst case,
> > + * i.e. when each second CPU is being listed. For backward compatibility
> > + * for more than 1170 and less than 1861 CPUs the page size is preserved.
> > + *
> > + * For less than 1171 and more than 1 million CPUs the old is being used
> > + * as described below:
> > + *
> >   * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up
> >   * to 2 orders of magnitude larger than 8192. And then we divide by 2 to
> >   * cover a worst-case of every other cpu being on one of two nodes for a
> > @@ -1132,6 +1147,39 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> >   */
> >  #define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS * 9)/32 > PAGE_SIZE) \
> >  					? (NR_CPUS * 9)/32 - 1 : PAGE_SIZE)
> > +
> > +#define __CPULIST_FOR_10(x)		(((x + 1) / 2 - 0)     * 2)
> > +#define __CPULIST_FOR_100(x)		(((x + 1) / 2 - 5)     * 3)
> > +#define __CPULIST_FOR_1000(x)		(((x + 1) / 2 - 50)    * 4)
> > +#define __CPULIST_FOR_10000(x)		(((x + 1) / 2 - 500)   * 5)
> > +#define __CPULIST_FOR_100000(x)		(((x + 1) / 2 - 5000)  * 6)
> > +#define __CPULIST_FOR_1000000(x)	(((x + 1) / 2 - 50000) * 7)
> 
> The defs below will be nicer if you make it like this:
> 
>   #define __CPULIST_FOR_10(x)  (((x + 1) / 2 - 0)     * 2)
>   #define __CPULIST_FOR_100(x) __CPULIST_FOR_10(10) + (((x + 1) / 2 - 5) * 3)
>   #define __CPULIST_FOR_1000(x)	__CPULIST_FOR_100(100) + (((x + 1) / 2 - 50) * 4)
>   ...

Not big deal, but I found my way more readable.

> > +#if NR_CPUS < 1861
> > +#define CPULIST_FILE_MAX_BYTES	PAGE_SIZE
> 
> The comment says:
>   for more than 1170 and less than 1861 CPUs the page size is preserved.
> 
> Which doesn't look correct. Looks like it should be:
>   for less than 1861 CPUs the page size is preserved.
> 
> Or I miss something?

Yes, you missed that the current formula gives an overhead already at 1171,
while it's room up to 1860. All these numbers are for PAGE_SIZE == 4096. In any
case, I was thinking more about this and I need to revert to my (locally)
initial approach to count the real size and then do like the old formula does,
i.e. max(PAGE_SIZE, real size) at the end.

> > +#elif NR_CPUS < 10000
> > +#define CPULIST_FILE_MAX_BYTES			\
> > +	 (__CPULIST_FOR_10(10) +		\
> > +	  __CPULIST_FOR_100(100) +		\
> > +	  __CPULIST_FOR_1000(1000) +		\
> > +	  __CPULIST_FOR_10000(NR_CPUS))
> > +#elif NR_CPUS < 100000
> > +#define CPULIST_FILE_MAX_BYTES			\
> > +	 (__CPULIST_FOR_10(10) +		\
> > +	  __CPULIST_FOR_100(100) +		\
> > +	  __CPULIST_FOR_1000(1000) +		\
> > +	  __CPULIST_FOR_10000(10000) +		\
> > +	  __CPULIST_FOR_100000(NR_CPUS))
> > +#elif NR_CPUS < 1000000
> > +#define CPULIST_FILE_MAX_BYTES			\
> > +	 (__CPULIST_FOR_10(10) +		\
> > +	  __CPULIST_FOR_100(100) +		\
> > +	  __CPULIST_FOR_1000(1000) +		\
> > +	  __CPULIST_FOR_10000(10000) +		\
> > +	  __CPULIST_FOR_100000(100000) +	\
> > +	  __CPULIST_FOR_1000000(NR_CPUS))
> > +#else
> >  #define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7)/2 > PAGE_SIZE) ? (NR_CPUS * 7)/2 : PAGE_SIZE)
> > +#endif
> >  
> >  #endif /* __LINUX_CPUMASK_H */

> I'm OK to take this in replace for Phil's version, but the commit that
> introduces CPULIST_FILE_MAX_BYTES is already in mainline: 7ee951acd31a8
> ("drivers/base: fix userspace break from using bin_attributes for cpumap
> and cpulist"). Can you rebase it on top of v6.0-rc6?
> 
> Greg, since Andy's version is more precise, I'd like to send a pull
> request with it in -rc7. Can you drop Phil's patch so I'll go with
> this one?

If it's already in mainline, then there is no way we can drop it. Also note,
everything which is in -next branches are usually not for rebase (and IIRC Greg
never rebases his trees). Hence, my patch is for Linux Next, i.e. v6.1-rc1.

In any case, please wait for v3.
I'll Cc it to the people you mentioned above, if you think it's a right thing
to do. (The Cc list is based on MAINTAINERS + author of the previous patch)

-- 
With Best Regards,
Andy Shevchenko


