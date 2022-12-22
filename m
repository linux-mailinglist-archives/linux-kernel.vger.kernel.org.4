Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0E65453D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiLVQhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:37:40 -0500
Received: from out-166.mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7247286FC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:37:38 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:37:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671727056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZzirgayf1/B1RO+N8rCpFWbwXndi+mKDJ4diDA1PhE=;
        b=F2YNhCv8/5TkxpCmJzZNYkYheiiRVAn2C61HsCd6JtYz5gn/sAWxhTK2Z9kbwHOrvpYKS2
        OlpXSSp8mbBAVpYYfmwTdSEqNKEtzFlbfT/W1vmbPfBMXFQbimHsKfDmN+G6E7z2zLQsUn
        eX9hkshCqudaoH22h0DB5CYomHuujCc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
Message-ID: <Y6SHzFPJLEr09JHF@P9FQF9L96D>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
 <Y6RE5iUHSinUJxDt@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6RE5iUHSinUJxDt@bfoster>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 06:52:06AM -0500, Brian Foster wrote:
> On Tue, Dec 20, 2022 at 10:48:13AM -0800, Roman Gushchin wrote:
> > Sven Luther reported a regression in the posix message queues
> > performance caused by switching to the per-object tracking of
> > slab objects introduced by patch series ending with the
> > commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> > allocations").
> > 
> > To mitigate the regression cache allocated mqueue messages on a small
> > percpu cache instead of releasing and re-allocating them every time.
> > 
> > This change brings the performance measured by a benchmark kindly
> > provided by Sven [1] almost back to the original (or even better)
> > numbers. Measurements results are also provided by Sven.
> > 
> > +------------+---------------------------------+--------------------------------+
> > | kernel     | mqueue_rcv (ns)     variation   | mqueue_send (ns)   variation   |
> > | version    | min avg  max      min      avg  | min avg max       min     avg  |
> > +------------+--------------------------+---------------------------------------+
> > | 4.18.45    | 351 382 17533    base     base  | 383 410 13178     base    base |
> > | 5.8-good   | 380 392  7156   -7,63%  -2,55%  | 376 384  6225    1,86%   6,77% |
> > | 5.8-bad    | 524 530  5310  -33,02% -27,92%  | 512 519  8775  -25,20% -21,00% |
> > | 5.10       | 520 533  4078  -32,20% -28,33%  | 518 534  8108  -26,06% -23,22% |
> > | 5.15       | 431 444  8440  -18,56% -13,96%  | 425 437  6170   -9,88%  -6,18% |
> > | 6.0.3      | 474 614  3881  -25,95% -37,79%  | 482 693   931  -20,54% -40,84% |
> > | 6.1-rc8    | 496 509  8804  -29,23% -24,95%  | 493 512  5748  -22,31% -19,92% |
> > | 6.1-rc8+p  | 392 397  5479  -10,46%  -3,78%  | 364 369 10776    5,22%  11,11% |
> > +------------+---------------------------------+--------------------------------+
> > 
> > The last line reflects the result with this patch ("6.1-rc8+p").
> > 
> > [1]: https://lore.kernel.org/linux-mm/Y46lqCToUa%2FBgt%2Fc@P9FQF9L96D/T/
> > 
> > Reported-by: Sven Luther <Sven.Luther@windriver.com>
> > Tested-by: Sven Luther <Sven.Luther@windriver.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  include/linux/memcontrol.h |  12 +++++
> >  ipc/mqueue.c               |  20 ++++++--
> >  ipc/msg.c                  |  12 ++---
> >  ipc/msgutil.c              | 101 +++++++++++++++++++++++++++++++++----
> >  ipc/util.h                 |   8 ++-
> >  mm/memcontrol.c            |  62 +++++++++++++++++++++++
> >  6 files changed, 194 insertions(+), 21 deletions(-)
> > 
> ...
> > diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> > index d0a0e877cadd..8667708fc00a 100644
> > --- a/ipc/msgutil.c
> > +++ b/ipc/msgutil.c
> ...
> > @@ -39,16 +40,76 @@ struct msg_msgseg {
> ...
> > +static struct msg_msg *alloc_msg(size_t len, struct msg_cache *cache)
> >  {
> >  	struct msg_msg *msg;
> >  	struct msg_msgseg **pseg;
> >  	size_t alen;
> >  
> > +	if (cache) {
> > +		struct pcpu_msg_cache *pc;
> > +
> > +		msg = NULL;
> > +		pc = get_cpu_ptr(cache->pcpu_cache);
> > +		if (pc->msg && pc->len == len) {
> > +			struct obj_cgroup *objcg;
> > +
> > +			rcu_read_lock();
> > +			objcg = obj_cgroup_from_current();
> > +			if (objcg == pc->objcg) {
> > +				msg = pc->msg;
> > +				pc->msg = NULL;
> > +				obj_cgroup_put(pc->objcg);
> > +			}
> > +			rcu_read_unlock();
> > +		}
> > +		put_cpu_ptr(cache->pcpu_cache);
> > +		if (msg)
> > +			return msg;
> > +	}
> > +
> >  	alen = min(len, DATALEN_MSG);
> >  	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
> >  	if (msg == NULL)
> > @@ -77,18 +138,19 @@ static struct msg_msg *alloc_msg(size_t len)
> >  	return msg;
> >  
> >  out_err:
> > -	free_msg(msg);
> > +	free_msg(msg, NULL);
> >  	return NULL;
> >  }
> >  
> > -struct msg_msg *load_msg(const void __user *src, size_t len)
> > +struct msg_msg *load_msg(const void __user *src, size_t len,
> > +			 struct msg_cache *cache)
> >  {
> >  	struct msg_msg *msg;
> >  	struct msg_msgseg *seg;
> >  	int err = -EFAULT;
> >  	size_t alen;
> >  
> > -	msg = alloc_msg(len);
> > +	msg = alloc_msg(len, cache);
> >  	if (msg == NULL)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > @@ -104,14 +166,16 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
> >  			goto out_err;
> >  	}
> >  
> > -	err = security_msg_msg_alloc(msg);
> > -	if (err)
> > -		goto out_err;
> > +	if (!msg->security) {
> > +		err = security_msg_msg_alloc(msg);
> > +		if (err)
> > +			goto out_err;
> > +	}
> >  
> >  	return msg;
> >  
> >  out_err:
> > -	free_msg(msg);
> > +	free_msg(msg, NULL);
> >  	return ERR_PTR(err);
> >  }
> >  #ifdef CONFIG_CHECKPOINT_RESTORE
> > @@ -166,10 +230,29 @@ int store_msg(void __user *dest, struct msg_msg *msg, size_t len)
> >  	return 0;
> >  }
> >  
> > -void free_msg(struct msg_msg *msg)
> > +void free_msg(struct msg_msg *msg, struct msg_cache *cache)
> >  {
> >  	struct msg_msgseg *seg;
> >  
> > +	if (cache) {
> > +		struct pcpu_msg_cache *pc;
> > +		bool cached = false;
> > +
> > +		pc = get_cpu_ptr(cache->pcpu_cache);
> > +		if (!pc->msg) {
> > +			pc->objcg = get_obj_cgroup_from_slab_obj(msg);
> > +			pc->len = msg->m_ts;
> > +			pc->msg = msg;
> > +
> > +			if (pc->objcg)
> > +				cached = true;
> > +		}
> 
> Hi Roman,
> 
> It seems that this is kind of tailored to the ideal conditions
> implemented by the test case: i.e., a single, fixed size message being
> passed back and forth on a single cpu. Does that actually represent the
> production workload?

Hi Brian!

Not really, it was all based on Sven's report and the benchmark he provided.
I assume that the benchmark emulates the production workload he has, but
it's up to him to confirm.

Personally I haven't seen a lot of mqueue usage in the production, especially
for anything performance-sensitive. Also, Sven reported the regression which
was introduced in 5.9, so I take it as an indicator that not so many users
depend on the mqueue performance.

> 
> I'm a little curious if/how this might work for workloads that might
> involve more variable sized messages, deeper queue depths (i.e.  sending
> more than one message before attempting a recv) and more tasks across
> different cpus. For example, it looks like if an "uncommonly" sized
> message ended up cached on a cpu, this would always result in subsequent
> misses because the alloc side requires an exact size match and the free
> side never replaces a cached msg. Hm?

Yes, of course it's very primitive. But I'm not sure we want to implement
something complicated here. If there any specific ideas, I'm totally up for
them. We can cache 2 sizes or 4 sizes or something else, but Idk how much value
it has.

Btw, in parallel I'm working on some generic improvements to the slab
allocation path [1], maybe it will be good enough for Sven.

[1]: https://lore.kernel.org/linux-mm/20221220204451.gm5d3pdbfvd5ki6b@google.com/T/

Thanks!
