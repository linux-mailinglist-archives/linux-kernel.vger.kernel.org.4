Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5402D5E7E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiIWPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:23:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D196C1449DC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:23:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o7so272871qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=Oknq7EzQ8oYg2QLvmyCc/pICuYONHxV0MpvLAgvdsLA=;
        b=dfDPsBWw9nkSYYaNZRgCZD1xUAD+4+VdoWfvr1KZlH4ClvxpQU6efAynHrMO0U+OXW
         t2XQLTmOENGxMt8JYglm+3Qds0QpMPP+bvSVP8643LYNk5CMNeb1DPA2rFCdWfE2NRcz
         a/gqvXaFShJ6UsKMHcleE3hFSAf11IiBP8TU0aY00BLX0MEf6bVG5PpUlK75ElCHILTf
         0a6Xs/F7cFBRA+iJ6EbGZeGdJFBZ5K5v9OjmPZhiRidQIj6YnZ0+E6IBHPz7MJAXfNFL
         mS/iQJuvxB71rCwZc6eucr0lBx6eulEEh6q/WlJcCCWqb2Jsxgy3RTO1y+3jgByeATNU
         dItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Oknq7EzQ8oYg2QLvmyCc/pICuYONHxV0MpvLAgvdsLA=;
        b=Rav4Ld2q3RCxhI9RHU4tUmCUuMREbPq/gDuiTH+0XXSqwD07ww1u+XGAIRGC4/7KJ3
         YPdGsPRoEXvfkBm7fclf7Fopv429qEjltouku8K98HMWHIiyF34P+eqvyzl+YwoZ6MIy
         ZCH/lu1lgUoqoer1dE9RE52n5wE0K86lkd7DqcBV0IFo5iHltOm8NCgVBd6S66EldAj4
         jK7rsMWZe70atGZNAP4K++KP/tZX4BOB4x2okXAnmJw/xzfhF5RLpRN3uR71wP67/o8T
         2Ey3voReoiTrtL67T0SAW+n1ma43iKVWz5R3YH2FkAql6hdjzXKLqdScayBn8ulN6Hd4
         QE/g==
X-Gm-Message-State: ACrzQf2l6RkXPs1yDCEAI8yr8doWFNjCmR9YdAvNL2IcxB4R9WoRPS/N
        +vmvvTnDbeecUBmLs8iZAZ0=
X-Google-Smtp-Source: AMsMyM4IocZLZm3K9WbgnYl7W5Mlxs6jHAhjGVeIwTRYMHxpiziOT/d+Mi6qp1edBogRnz5vimj2cA==
X-Received: by 2002:a37:897:0:b0:6cd:f5da:f1bc with SMTP id 145-20020a370897000000b006cdf5daf1bcmr5942952qki.491.1663946590040;
        Fri, 23 Sep 2022 08:23:10 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2170:e39b:cf3e:8e0a])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a0f0600b006bc0980db76sm6282450qkl.126.2022.09.23.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:23:09 -0700 (PDT)
Date:   Fri, 23 Sep 2022 08:23:09 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Phil Auld <pauld@redhat.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yy3PXWq/VQ6/Fdmw@yury-laptop>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
 <YyzIhDDEiemWjLgI@yury-laptop>
 <Yy1Slcf6YjsnzjEu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yy1Slcf6YjsnzjEu@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:30:45AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 22, 2022 at 01:41:40PM -0700, Yury Norov wrote:
> >  + Petr Štetiar <ynezz@true.cz>,
> >  + Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > On Thu, Sep 22, 2022 at 10:49:54PM +0300, Andy Shevchenko wrote:
> > > Currently the approximation is used which wastes the more memory
> > > the more CPUs are present on the system. Proposed change calculates
> > > the exact maximum needed in the worst case:
> > > 
> > >   NR_CPUS	old		new
> > >   -------	---		---
> > >   1 .. 1170	4096		4096
> > >   1171 .. 1860	4098 ..	6510	4096
> > >   ...		...		...
> > >   2*4096	28672		19925
> > >   4*4096	57344		43597
> > >   8*4096	114688		92749
> > >   16*4096	229376		191053
> > >   32*4096	458752		403197
> > >   64*4096	917504		861949
> > >   128*4096	1835008		1779453
> > >   256*4096	3670016		3670016
> > > 
> > > Under the hood the reccurent formula is being used:
> > >   (5 - 0) * 2 +
> > >     (50 - 5) * 3 +
> > >       (500 - 50) * 4 +
> > >         (5000 - 500) * 5 +
> > >           ...
> > >             (X[i] - X[i-1]) * i
> > > 
> > > which allows to count the exact maximum length in the worst case,
> > > i.e. when each second CPU is being listed. For backward compatibility
> > > for more than 1170 and less than 1861 CPUs the page size is preserved.
> > > 
> > > For less than 1171 and more than 1 million CPUs the old is being used.
> > 
> > 1861
> > 
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > v2: described better the advantage for 1171..1860 CPUs cases
> > >  include/linux/cpumask.h | 48 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > > 
> > > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > > index 1b442fb2001f..12cf0905ca74 100644
> > > --- a/include/linux/cpumask.h
> > > +++ b/include/linux/cpumask.h
> > > @@ -1122,6 +1122,21 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> > >   *
> > >   * for cpumap NR_CPUS * 9/32 - 1 should be an exact length.
> > >   *
> > > + * for cpulist the reccurent formula is being used:
> > > + *   (5 - 0) * 2 +
> > > + *     (50 - 5) * 3 +
> > > + *       (500 - 50) * 4 +
> > > + *         (5000 - 500) * 5 +
> > > + *           ...
> > > + *             (X[i] - X[i-1]) * i
> > > + *
> > > + * which allows to count the exact maximum length in the worst case,
> > > + * i.e. when each second CPU is being listed. For backward compatibility
> > > + * for more than 1170 and less than 1861 CPUs the page size is preserved.
> > > + *
> > > + * For less than 1171 and more than 1 million CPUs the old is being used
> > > + * as described below:
> > > + *
> > >   * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up
> > >   * to 2 orders of magnitude larger than 8192. And then we divide by 2 to
> > >   * cover a worst-case of every other cpu being on one of two nodes for a
> > > @@ -1132,6 +1147,39 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> > >   */
> > >  #define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS * 9)/32 > PAGE_SIZE) \
> > >  					? (NR_CPUS * 9)/32 - 1 : PAGE_SIZE)
> > > +
> > > +#define __CPULIST_FOR_10(x)		(((x + 1) / 2 - 0)     * 2)
> > > +#define __CPULIST_FOR_100(x)		(((x + 1) / 2 - 5)     * 3)
> > > +#define __CPULIST_FOR_1000(x)		(((x + 1) / 2 - 50)    * 4)
> > > +#define __CPULIST_FOR_10000(x)		(((x + 1) / 2 - 500)   * 5)
> > > +#define __CPULIST_FOR_100000(x)		(((x + 1) / 2 - 5000)  * 6)
> > > +#define __CPULIST_FOR_1000000(x)	(((x + 1) / 2 - 50000) * 7)
> > 
> > The defs below will be nicer if you make it like this:
> > 
> >   #define __CPULIST_FOR_10(x)  (((x + 1) / 2 - 0)     * 2)
> >   #define __CPULIST_FOR_100(x) __CPULIST_FOR_10(10) + (((x + 1) / 2 - 5) * 3)
> >   #define __CPULIST_FOR_1000(x)	__CPULIST_FOR_100(100) + (((x + 1) / 2 - 50) * 4)
> >   ...
> > 
> > 
> > 
> > > +#if NR_CPUS < 1861
> > > +#define CPULIST_FILE_MAX_BYTES	PAGE_SIZE
> > 
> > The comment says:
> >   for more than 1170 and less than 1861 CPUs the page size is preserved.
> > 
> > Which doesn't look correct. Looks like it should be:
> >   for less than 1861 CPUs the page size is preserved.
> > 
> > Or I miss something?
> > 
> > > +#elif NR_CPUS < 10000
> > > +#define CPULIST_FILE_MAX_BYTES			\
> > > +	 (__CPULIST_FOR_10(10) +		\
> > > +	  __CPULIST_FOR_100(100) +		\
> > > +	  __CPULIST_FOR_1000(1000) +		\
> > > +	  __CPULIST_FOR_10000(NR_CPUS))
> > > +#elif NR_CPUS < 100000
> > > +#define CPULIST_FILE_MAX_BYTES			\
> > > +	 (__CPULIST_FOR_10(10) +		\
> > > +	  __CPULIST_FOR_100(100) +		\
> > > +	  __CPULIST_FOR_1000(1000) +		\
> > > +	  __CPULIST_FOR_10000(10000) +		\
> > > +	  __CPULIST_FOR_100000(NR_CPUS))
> > > +#elif NR_CPUS < 1000000
> > > +#define CPULIST_FILE_MAX_BYTES			\
> > > +	 (__CPULIST_FOR_10(10) +		\
> > > +	  __CPULIST_FOR_100(100) +		\
> > > +	  __CPULIST_FOR_1000(1000) +		\
> > > +	  __CPULIST_FOR_10000(10000) +		\
> > > +	  __CPULIST_FOR_100000(100000) +	\
> > > +	  __CPULIST_FOR_1000000(NR_CPUS))
> > > +#else
> > >  #define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7)/2 > PAGE_SIZE) ? (NR_CPUS * 7)/2 : PAGE_SIZE)
> > > +#endif
> > >  
> > >  #endif /* __LINUX_CPUMASK_H */
> > > -- 
> > > 2.35.1
> > 
> > I'm OK to take this in replace for Phil's version, but the commit that
> > introduces CPULIST_FILE_MAX_BYTES is already in mainline: 7ee951acd31a8
> > ("drivers/base: fix userspace break from using bin_attributes for cpumap
> > and cpulist"). Can you rebase it on top of v6.0-rc6?
> > 
> > Greg, since Andy's version is more precise, I'd like to send a pull
> > request with it in -rc7. Can you drop Phil's patch so I'll go with
> > this one?
> 
> Let me get this fix to Linus now for 6.0-final as it is hitting people
> right now.  Making it "cleaner" after that is fine to go through your
> tree as that's less of an issue, right?

OK
