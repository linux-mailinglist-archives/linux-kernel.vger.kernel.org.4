Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A106CD1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjC2GE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2GE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:04:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92671F2;
        Tue, 28 Mar 2023 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aNAy4SkGOGqn/8SCjHiEfeWwyWn89H5Tz+V43gHoZjQ=; b=K/J8IBFH1dwSafahsbzjA5DGva
        /WZmU+2EOfztohNxfTV71mSWZwFUEPQWarWp1I4Y9h1bgQHBzZocxyKsMbTu0Rr15rE4BzusazLNL
        ulo/wxJNdrBjYuA5U1G71HRfHCYTugoMIheTjiMlXaYm4QsXjH0yu0CCsqZJsI3m48M/S/z5Ik7ix
        eCv2yDWywLtzXWLpXXtcBCk71/CkOER1OVgbFISpnKUJ8WG3o1SVTmXUATBKJy8nIVAurxCWVz9hL
        QGVlnAr6SUc/+wxr/hD3pMsXNL73PVuFH4hpF0xVi/69wdsrmLPeUgOJLZB3XXHQvxllAbTqti8+8
        X7llhk1A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOuz-00Glg9-0h;
        Wed, 29 Mar 2023 06:04:21 +0000
Date:   Tue, 28 Mar 2023 23:04:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH 7/7] module: add debug stats to help identify memory
 pressure
Message-ID: <ZCPU5T1PD+BwI9ri@bombadil.infradead.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-8-mcgrof@kernel.org>
 <ZCPQrouSMQbFc8D0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCPQrouSMQbFc8D0@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:46:22AM +0200, Greg KH wrote:
> On Tue, Mar 28, 2023 at 10:31:49PM -0700, Luis Chamberlain wrote:
> > Loading modules with finit_module() can end up using vmalloc(), vmap()
> > and vmalloc() again, for a total of up to 3 separate allocations in the
> > worse case for a single module. We always kernel_read*() the module,
> > that's a vmalloc(). Then vmap() is used for the module decompression,
> > and if so the last read buffer is freed as we use the now decompressed
> > module buffer to stuff data into our copy module. The last one is
> > specific to architectures but pretty much that's generally a series
> > of vmalloc() for different ELF sections...
> > 
> > Evaluation with new stress-ng module support [1] with just 100 ops
> > us proving that you can end up using GiBs of data easily even if
> > we are trying to be very careful not to load modules which are already
> > loaded. 100 ops seems to resemble the sort of pressure a system with
> > about 400 CPUs can create on modules. Although those issues for so
> > many concurrent loads per CPU is silly and are being fixed, we lack
> > proper tooling to help diagnose easily what happened, when it happened
> > and what likely are the culprits -- userspace or kernel module
> > autoloading.
> > 
> > Provide an initial set of stats for debugfs which let us easily scrape
> > post-boot information about failed loads. This sort of information can
> > be used on production worklaods to try to optimize *avoiding* redundant
> > memory pressure using finit_module().
> > 
> > Screen shot:
> > 
> > root@kmod ~ # cat /sys/kernel/debug/modules/stats
> >            Modules loaded       67
> 
> Is this "loaded now", or "ever successfully loaded"?  As in a
> modprobe/rmmod/modprobe would bump this by 2, right?

Ah, the later, so "how modules have I ever loaded". Maybe

Modules ever loaded

?

Will fix the nits, thanks!

> > diff --git a/kernel/module/debug.c b/kernel/module/debug.c
> 
> Why is this a whole separate file?

It's just a style preference, no real hard reason other than
module.c was huge before and now its split up. I find that
easier to review / manage. Certainly overkill for such as
simple thing but if its debug I think I rather see that
then some ifdef eyesore. But that's just preference.

> And as MODULE_DEBUG does not reference debugfs,

That should be fixed thanks.

> > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > index 6ae29bb8836f..a645cb3fafc7 100644
> > --- a/kernel/module/internal.h
> > +++ b/kernel/module/internal.h
> > @@ -143,6 +143,41 @@ static inline bool set_livepatch_module(struct module *mod)
> >  #endif
> >  }
> >  
> > +#ifdef CONFIG_MODULE_STATS
> > +
> > +#define mod_stat_add64(count, var) atomic64_add(count, var)
> > +#define mod_stat_inc(name) atomic_inc(name)
> 
> Ok, but:
> 
> > +#define mod_stat_inc(name) atomic_inc(name)
> 
> Why do you still increment the variable here if the option is not
> enabled?

Whoops, will fix!

> Also, didn't we have some sort of "we want to use an atomic variable as
> statistics" type somewhere in the kernel? 

I didn't get the memo, nor do I recall, so it's not on my radar.

> Or did that never get accepted?

Not sure.

> And do all of these really need to be atomic variables?  Don't you have
> locks for some of this to not need the atomic-ness of them?  I guess it
> doesn't matter much as this isn't that fast of a code-path.

That was actually intentional, as this only *grows* I just care its not 0
so to help divide by the total number of modules to get average module
length and average module .text length. I used atomics and made it only
grow precisely to not have to lock anywhere.

  Luis
