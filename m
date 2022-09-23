Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7085E79B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiIWLgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiIWLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5333FEBBDF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663932991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOHpTuGN5DOMMNWH0NmUPxzqv5nz6PGhQAZTRWn7VQg=;
        b=Y3msL0SCZ4wGcMR2vjGY64U7tim0kORTxwcX/1F0uymk0RrlnKA7LTEzrWGwxE/9htkGj1
        EUZly2OrYrB3I9lyhaokA1YMpyHfXxvJuiChzFqCNE0gPgPM/x3xwj2o5R+13MOKCFi6tb
        y6LTrHpY+d5IjhiMugXgfma0yiOb6bM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-dkKUK5YMPImOjgC9slVhQg-1; Fri, 23 Sep 2022 07:36:28 -0400
X-MC-Unique: dkKUK5YMPImOjgC9slVhQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E8AC80029D;
        Fri, 23 Sep 2022 11:36:27 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1948D140EBF3;
        Fri, 23 Sep 2022 11:36:27 +0000 (UTC)
Date:   Fri, 23 Sep 2022 07:36:25 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yy2aOddpMQn0M0QB@lorien.usersys.redhat.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
 <Yyz/7gWdP+ftQdIO@lorien.usersys.redhat.com>
 <CAAH8bW9+hGMALooLtJGtYNDWw-tBXEspn8oQ_WLrBArMaD9SZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW9+hGMALooLtJGtYNDWw-tBXEspn8oQ_WLrBArMaD9SZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:45:27PM -0700 Yury Norov wrote:
> On Thu, Sep 22, 2022 at 5:38 PM Phil Auld <pauld@redhat.com> wrote:
> >
> > Hi Andy,
> >
> > On Thu, Sep 22, 2022 at 10:49:54PM +0300 Andy Shevchenko wrote:
> > > Currently the approximation is used which wastes the more memory
> > > the more CPUs are present on the system. Proposed change calculates
> > > the exact maximum needed in the worst case:
> > >
> > >   NR_CPUS     old             new
> > >   -------     ---             ---
> > >   1 .. 1170   4096            4096
> > >   1171 .. 1860        4098 .. 6510    4096
> > >   ...         ...             ...
> > >   2*4096      28672           19925
> > >   4*4096      57344           43597
> > >   8*4096      114688          92749
> > >   16*4096     229376          191053
> > >   32*4096     458752          403197
> > >   64*4096     917504          861949
> > >   128*4096    1835008         1779453
> > >   256*4096    3670016         3670016
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
> > The memory is not really wasted since it's probably temporary in userspace
> > and in the kernel it _is_ temporary and is only the length of the kasprintf
> > string, which is most of the time much less.
> >
> > But that said, it is more accurate than the previous estimate.
> >
> > I was wondering if you were going to try to come up with a suitable
> > compile time macro :)
> >
> > I tested 2, 8192 and 16k since the kernel does not want to build for other
> > reasons with NR_CPUS at 32k.
> >
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Tested-by: Phil Auld <pauld@redhat.com>
> 
> By the way, why don't we use nr_cpu_ids? It's set at boot-time, or even
> at compile-time in some cases and never changed at runtime.
> 
> nr_cpu_ids is set very early, when ACPI tables are parsed. I don't think
> it's possible for a userspace to observe it uninitialized. Am I wrong?
> 

I very much wanted it to be compile time so there was no overhead.

Is there a good place to init these bin_attrs at boottime, anyway?
I didn't dig into it farther, but it looks like the size is set
when declared. I suppose we could adjust it at the first read if
there was a way to do that. It's sort of all abstracted away to
common code though.

The fact that the values are larger than actually needed doesn't really
cause any harm.  In the kernel no extra memory is allocated since it uses
the size of the sprintf of the actual data.  And it's only allocated
while being read.

In userspace it may be a little extra memory while doing a read. But that's
also likely to be just temporary.

And if you have NR_CPUS 10000 you probably have a lot of wasted percpu
space anyway...


Cheers,
Phil

-- 

