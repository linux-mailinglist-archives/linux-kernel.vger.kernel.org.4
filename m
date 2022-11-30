Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD863DBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiK3RUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiK3RUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:20:20 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556DC9C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:20:19 -0800 (PST)
Date:   Wed, 30 Nov 2022 09:19:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669828817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8d2qoJJbs/jImeDoRLTIKxjLWSiPwn5R2MjW8APBuqA=;
        b=berm4eT1yBkMFTFF2yGumqkY2Zu85I2EMDxahix7VUsjZxFPeH6ndwzlcwCNi7vmqb8kH0
        sz7Q+YG+JcN0UGmknR9gbYBf6IZ103Mqxm1fp8eGLjDKgPX2BC7ExtqxiJEpExOkSqxB5l
        nWrnSYw1m6yDWWFnmEMppCh9lv5Pnlc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] selftests: cgroup: refactor proactive reclaim
 code to reclaim_until()
Message-ID: <Y4eQupgWwX0/ItIX@P9FQF9L96D.corp.robot.car>
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-3-yosryahmed@google.com>
 <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
 <CAJD7tkZUcbkzG=g1wgkoWgBgZM2eHQLNY0dmHnWghzHRmeDjkQ@mail.gmail.com>
 <CAJD7tkYC9Ba0p2GDnXTMOqqLWyCpKoX0qUgviGcmWa4abNVV-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYC9Ba0p2GDnXTMOqqLWyCpKoX0qUgviGcmWa4abNVV-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:42:31AM -0800, Yosry Ahmed wrote:
> On Wed, Nov 23, 2022 at 7:16 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 5:03 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 09:21:31AM +0000, Yosry Ahmed wrote:
> > > > Refactor the code that drives writing to memory.reclaim (retrying, error
> > > > handling, etc) from test_memcg_reclaim() to a helper called
> > > > reclaim_until(), which proactively reclaims from a memcg until its
> > > > usage reaches a certain value.
> > > >
> > > > This will be used in a following patch in another test.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > ---
> > > >  .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
> > > >  1 file changed, 49 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > index 8833359556f3..d4182e94945e 100644
> > > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > @@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
> > > >       return ret;
> > >
> > >
> > > The code below looks correct, but can be simplified a bit.
> > > And btw thank you for adding a test!
> > >
> > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > (idk if you want invest your time in further simplication of this code,
> > > it was this way before this patch, so up to you).
> >
> > I don't "want" to, but the voices in my head won't shut up until I do so..
> >
> > Here's a patch that simplifies the code, I inlined it here to avoid
> > sending a new version. If it looks good to you, it can be squashed
> > into this patch or merged separately (whatever you and Andrew prefer).
> > I can also send it in a separate thread if preferred.
> 
> Roman, any thoughts on this?
> 
> >
> >
> > From 18c40d61dac05b33cfc9233b17979b54422ed7c5 Mon Sep 17 00:00:00 2001
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Date: Thu, 24 Nov 2022 02:21:12 +0000
> > Subject: [PATCH] selftests: cgroup: simplify memcg reclaim code
> >
> > Simplify the code for the reclaim_until() helper used for memcg reclaim
> > through memory.reclaim.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  .../selftests/cgroup/test_memcontrol.c        | 65 ++++++++++---------
> >  1 file changed, 33 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c
> > b/tools/testing/selftests/cgroup/test_memcontrol.c
> > index bac3b91f1579..2e2bde44a6f7 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -17,6 +17,7 @@
> >  #include <netdb.h>
> >  #include <errno.h>
> >  #include <sys/mman.h>
> > +#include <limits.h>
> >
> >  #include "../kselftest.h"
> >  #include "cgroup_util.h"
> > @@ -656,51 +657,51 @@ static int test_memcg_max(const char *root)
> >         return ret;
> >  }
> >
> > -/* Reclaim from @memcg until usage reaches @goal_usage */
> > +/*
> > + * Reclaim from @memcg until usage reaches @goal_usage by writing to
> > + * memory.reclaim.
> > + *
> > + * This function will return false if the usage is already below the
> > + * goal.
> > + *
> > + * This function assumes that writing to memory.reclaim is the only
> > + * source of change in memory.current (no concurrent allocations or
> > + * reclaim).
> > + *
> > + * This function makes sure memory.reclaim is sane. It will return
> > + * false if memory.reclaim's error codes do not make sense, even if
> > + * the usage goal was satisfied.
> > + */
> >  static bool reclaim_until(const char *memcg, long goal_usage)
> >  {
> >         char buf[64];
> >         int retries = 5;
> > -       int err;
> > +       int err = INT_MAX;
> >         long current, to_reclaim;
> >
> > -       /* Nothing to do here */
> > -       if (cg_read_long(memcg, "memory.current") <= goal_usage)
> > -               return true;
> > -

Hi Yosry!

Thank you for working on this!
I feel like it's still way more complex than it can be.
How about something like this? (completely untested, treat is
as a pseudo-code).


{
	...
	bool ret = false;

	for (retries = 5; retries > 0; retries--) {
		current = cg_read_long(memcg, "memory.current");

		if (current <= goal) // replace with values_close?
			break;

		to_reclaim = current - goal_usage;
		snprintf(buf, sizeof(buf), "%ld", to_reclaim);
		err = cg_write(memcg, "memory.reclaim", buf);
		if (!err)
			ret = true;
		else if (err != -AGAIN)
			break;
	}

	return ret;
}
