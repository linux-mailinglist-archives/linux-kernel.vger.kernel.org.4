Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9A45E6EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiIVVn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIVVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504F36405
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663883024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSNEFy5b6cxFiax24pzuCPv8XiqsovfHI3ee7mzmuwA=;
        b=eK/lQdQVtSEX6/VcwNIVU1W7S6foCuKrNcsYJtP925RClE2g8GsNbrtQh8ZG1imKGepLT+
        Pm2/qfZaXGHo7tE8Zyp/eM6U4EJ1U6XJossA9zDDy8k7CWOrIEExEecPMBwBwZDA2GOu75
        9ruoDaNI4Hx/C8x0/NsfkkHwD9scrDs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-jSTf65OiPnqhHnoJULZfiw-1; Thu, 22 Sep 2022 17:43:41 -0400
X-MC-Unique: jSTf65OiPnqhHnoJULZfiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E334D294EDF5;
        Thu, 22 Sep 2022 21:43:40 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8547347505E;
        Thu, 22 Sep 2022 21:43:40 +0000 (UTC)
Date:   Thu, 22 Sep 2022 17:43:38 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <YyzXCtX5tadKnOhq@lorien.usersys.redhat.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
 <YyzIhDDEiemWjLgI@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyzIhDDEiemWjLgI@yury-laptop>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:41:40PM -0700 Yury Norov wrote:
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
> 
> > 
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
> 
> 
> 
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
> 
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
> > -- 
> > 2.35.1
> 
> I'm OK to take this in replace for Phil's version, but the commit that
> introduces CPULIST_FILE_MAX_BYTES is already in mainline: 7ee951acd31a8
> ("drivers/base: fix userspace break from using bin_attributes for cpumap
> and cpulist"). Can you rebase it on top of v6.0-rc6?
> 
> Greg, since Andy's version is more precise, I'd like to send a pull
> request with it in -rc7. Can you drop Phil's patch so I'll go with
> this one?
>

This changes the other of the 2 macros and looks like it is already on
top of the fix to CPUMAP_FILE_MAX_BYTES.

It should be able to go right on top of a tree with that one in it, I think.

With the comment fixed up as you note above I'll git Reviewed-by:
and Tested-by: shortly.

This one is a refinement of 7ee951acd31a8 though and is not a critical as
the one Greg was talking about and Petr hit. 


Cheers,
Phil


> Thanks,
> Yury
> 

-- 

