Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61BD6DA81B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDGDxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjDGDxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:53:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C064C2F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RNHjRAVOmVSuegrqYJy+dt/EyRDw2CigzlLcuxrW8EU=; b=BwpEROdRzotoV2ZDg2xVxWLS+5
        vOPwnteZ4eSQP6Wiblm3TCtCOzTCA1vx1GcafvFzPJv14tuy/aKacRwj6mCeKD4NST0eCf5MofPbg
        JCExdJHvTWEnEcek5M3anciJA3BeodtVJ94d4V6gCtaKPgOM4gGNrDCkA9zAGuVzX27poE4UFt5i/
        cmUvjWws7LxyIfHlv5joASpprutm0ZDT7olHKn33CVPTuYChNlnwuimZrgfQatAHAgKsApd372UCx
        DQYgA2wTenQpOn7WdUAWG3hUHedDQrz1dMIwoYUyzN/CpBJmbewSI96YXP6yVXH+NkqO3OPJk9MSK
        TzHSruMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkdAF-000VM0-W4; Fri, 07 Apr 2023 03:53:28 +0000
Date:   Fri, 7 Apr 2023 04:53:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] signal: Let tasks cache one sigqueue struct.
Message-ID: <ZC+Tt2WqyFmNEm/w@casper.infradead.org>
References: <20230406194004.KP1K6FwO@linutronix.de>
 <20230407000306.940-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407000306.940-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 08:03:06AM +0800, Hillf Danton wrote:
> On Thu, 6 Apr 2023 22:47:21 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > The sigqueue caching originated in the PREEMPT_RT tree. A few of the
> > applications, that were ported to Linux, were ported from OS-9. Sending
> > notifications from one task to another via a signal was a common
> > communication model there and so the applications are heavy signal
> > users. Removing the allocation reduces the critical path, avoids locks
> > and so lowers the maximal latency of the task while sending a signal.

It might lower the _average_ latency, but it certainly doesn't lower
the _maximum_ latency, because you have to assume worst case scenario
for maximum latency.  Which is that there's no sigqueue cached, so you
have to go into the slab allocator.  And again, worst case scenario is
that you have to go into the page allocator from there, and further that
you have to run reclaim, and ...

What I find odd about the numbers that you quote:

> The numbers of system boot followed by an allmod kernel build:
> Out of 333216 allocations, 194876 (~58%) were served from the cache.
> From all free invocations, 4212 were in a path were caching is not done
> and 329002 sigqueue were cached.

... is that there's no absolute numbers.  Does it save 1% of the cost
of sending a signal?  10%?  What does perf say about the cost saved
by no longer going into slab?  Because the fast path in slab is very
fast.  It might even be quicker than your fast path for multithreaded
applications which have threads running on different NUMA nodes.
