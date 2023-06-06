Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD472485B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjFFP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFFP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:56:58 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F418E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:56:56 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:56:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686067014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9OZf8j81I9AZgH2DCCUhuThQp0x0TuPvmq+4JGIqS0=;
        b=IpfG83BysHXCa6f1d0xw5bdcAdkTXutwLnsAT+Tv0BHSJZEPTe2OpuJlgrkt2Tx72u4XxA
        qti49tINLUjZrog754JQvlLuSjDvsD3eJT0FVRRS+8/3G1l1yV7N4F/elu4yPRTEStIEGp
        z82nmqfVbJ0KZnjEJvzPYbE9g59Sr9Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZH9XNUGTW3+sEANc@P9FQF9L96D.corp.robot.car>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
 <ZH6K0McWBeCjaf16@dread.disaster.area>
 <ZH6ge3yiGAotYRR9@P9FQF9L96D>
 <ZH7XfD/pBcWzhHcc@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH7XfD/pBcWzhHcc@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:51:40PM +1000, Dave Chinner wrote:
> On Mon, Jun 05, 2023 at 07:56:59PM -0700, Roman Gushchin wrote:
> > On Tue, Jun 06, 2023 at 11:24:32AM +1000, Dave Chinner wrote:
> > > On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> > > > Isn't it possible to hide it from a user and call the second part from a work
> > > > context automatically?
> > > 
> > > Nope, because it has to be done before the struct shrinker is freed.
> > > Those are embedded into other structures rather than being
> > > dynamically allocated objects.
> > 
> > This part we might consider to revisit, if it helps to solve other problems.
> > Having an extra memory allocation (or two) per mount-point doesn't look
> > that expensive. Again, iff it helps with more important problems.
> 
> Ah, I guess if you're concerned about memory allocation overhead
> during register_shrinker() calls then you really aren't familiar
> with what register_shrinker() does on memcg and numa aware
> shrinkers?

What a nice way to agree with an idea :)

> 
> Let's ignore the fact that we could roll the shrinker structure
> allocation into the existing shrinker->nr_deferred array allocation
> (so it's effectively a zero cost modification), and just look at
> what a memcg enabled shrinker must initialise if it expands the
> shrinker info array because the index returned from idr_alloc()
> is larger than the current array:
> 
> 	for each memcg {
> 		for_each_node {
> 			info = kvmalloc_node();
> 			rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
> 		}
> 	}
> 
> Hmmmm?
> 
> So, there really isn't any additional cost, it completely decouples
> the shrinker infrastructure from the subsystem shrinker
> implementations, it enables the shrinker to control infrastructure
> teardown independently of the subsystem that registered the
> shrinker, and it still gives guarantees that the shrinker is never
> run after unregister_shrinker() completes. What's not to like?

Yep, this sounds like a good idea.

Thanks.
