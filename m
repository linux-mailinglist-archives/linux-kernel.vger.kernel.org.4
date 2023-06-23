Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB573B0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFWGwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFWGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:52:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E71FF2;
        Thu, 22 Jun 2023 23:52:38 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:52:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687503156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXDCmApZYIXhauiHZvO9b8B9cF94NGTvK79mRRcojkM=;
        b=UNVu1Q6Je/RntFqUbMDzihb0H0rxQbrISystMkb+ZcndUfbErA78A0J5qftymTU8t+0FA/
        sPxPoqtR5IcGktjuKDvzr5RthdYwT9W/8KJnNVBtxhW6ltQERmYE4/lgg2BkHOvxyBdODh
        2OnVhcJxHI49uCCCiUTgRD9Vnksg8r9RjfD+jg9TpIugv8WnCNibUwzpMTYvivgLxbjOko
        Cno13VbApcdL1GA6/5LuvZ0S257s+7Y2V00V/MArQf0u/UNjjJX4urXyS4QpAis1b/cIao
        26p/WS9gRF6nPz2BHchhRc0WY2k/scU187ppAoEoH9AceADjISh9ycuP8Dn6OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687503156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXDCmApZYIXhauiHZvO9b8B9cF94NGTvK79mRRcojkM=;
        b=ek25QD0fgBtQBhg0cKoqK4zFNR/Y8XwIGXF/xeSzp8EaHSObOrDgwmSyfFGU5WfjEL/0SE
        M5yFPBZmNvVQZTCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230623065234.ci6_7ob6@linutronix.de>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
 <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
 <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
 <287c33e1-acb7-62db-7267-227cbcc54707@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <287c33e1-acb7-62db-7267-227cbcc54707@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-22 10:33:13 [-0400], Mathieu Desnoyers wrote:
> 
> What was fundamentally wrong with the per-cpu caches before commit
> df323337e50 other than being non-RT friendly ? Was the only purpose of that
> commit to reduce the duration of preempt-off critical sections, or is there
> a bigger picture concern it was taking care of by introducing a global pool
> ?

There were memory allocations within preempt-disabled sections
introduced by get_cpu_ptr(). This didn't fly on PREEMPT_RT. After
looking at this on 2 node, 64 CPUs box I didn't get anywhere near
complete usage of the allocated buffers per-CPU buffers. It looked
wasteful.
Based on my testing back then, it looked sufficient to use a global
buffer. 

> Introducing per-cpu memory pools, dealing with migration by giving entries
> back to the right cpu's pool, taking into account the cpu the entry belongs
> to, and use a per-cpu/lock-free data structure allowing lock-free push to
> give back an entry on a remote cpu should do the trick without locking, and
> without long preempt-off critical sections.
> 
> The only downside I see for per-cpu memory pools is a slightly larger memory
> overhead on large multi-core systems. But is that really a concern ?

Yes, if the memory is left unused and can't be reclaimed if needed.

> What am I missing here ?

I added (tried to add) an people claimed that the SLUB allocated got
better over the years. Also on NUMA systems it might be better to use it
since the memory is NUMA local. The allocation is for 8KiB by default.
Is there a test-case/ benchmark I could try this vs kmalloc()?

> Thanks,
> 
> Mathieu

Sebastian
