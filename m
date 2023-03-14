Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FDE6B9804
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCNObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCNObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:31:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C528C583
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:31:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0924D1F895;
        Tue, 14 Mar 2023 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678804282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/tQHVjEyQJuX3FqnGmPl/gpUD/F6uLUvg7AXsJvGx0s=;
        b=j3s3H7VwQWAEQhUxPzKbzmHkO7PPskE2JzkwttoL7JqVF/OZjp84ElusL/6IxWzTGBDVdg
        hH2kXEAFB8VSp49sg+GP3rBjzXRuzirEs2mz/MU7WQ3esr9KHMY0SXpICEnwU8mqc0pdCl
        GL3hBDuFscxfOuggDUrEammlQAr7NnA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED0B913A26;
        Tue, 14 Mar 2023 14:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5MfTOTmFEGSlHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Mar 2023 14:31:21 +0000
Date:   Tue, 14 Mar 2023 15:31:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 00/12] fold per-CPU vmstats remotely
Message-ID: <ZBCFOZOQY5Z735Km@dhcp22.suse.cz>
References: <20230313162507.032200398@redhat.com>
 <ZBBn0evSQeuiNna4@dhcp22.suse.cz>
 <ZBBvuYkWgtVXCV7J@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBvuYkWgtVXCV7J@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-03-23 09:59:37, Marcelo Tosatti wrote:
> On Tue, Mar 14, 2023 at 01:25:53PM +0100, Michal Hocko wrote:
> > On Mon 13-03-23 13:25:07, Marcelo Tosatti wrote:
> > > This patch series addresses the following two problems:
> > > 
> > >     1. A customer provided some evidence which indicates that
> > >        the idle tick was stopped; albeit, CPU-specific vmstat
> > >        counters still remained populated.
> > > 
> > >        Thus one can only assume quiet_vmstat() was not
> > >        invoked on return to the idle loop. If I understand
> > >        correctly, I suspect this divergence might erroneously
> > >        prevent a reclaim attempt by kswapd. If the number of
> > >        zone specific free pages are below their per-cpu drift
> > >        value then zone_page_state_snapshot() is used to
> > >        compute a more accurate view of the aforementioned
> > >        statistic.  Thus any task blocked on the NUMA node
> > >        specific pfmemalloc_wait queue will be unable to make
> > >        significant progress via direct reclaim unless it is
> > >        killed after being woken up by kswapd
> > >        (see throttle_direct_reclaim())
> > 
> > I have hard time to follow the actual problem described above. Are you
> > suggesting that a lack of pcp vmstat counters update has led to
> > reclaim issues? What is the said "evidence"? Could you share more of the
> > story please?
> 
> 
>   - The process was trapped in throttle_direct_reclaim().
>     The function wait_event_killable() was called to wait condition
>     allow_direct_reclaim(pgdat) for current node to be true.
>     The allow_direct_reclaim(pgdat) examined the number of free pages
>     on the node by zone_page_state() which just returns value in
>     zone->vm_stat[NR_FREE_PAGES].
> 
>   - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.
>     However, the freelist on this node was not empty.
> 
>   - This inconsistent of vmstat value was caused by percpu vmstat on
>     nohz_full cpus. Every increment/decrement of vmstat is performed
>     on percpu vmstat counter at first, then pooled diffs are cumulated
>     to the zone's vmstat counter in timely manner. However, on nohz_full
>     cpus (in case of this customer's system, 48 of 52 cpus) these pooled
>     diffs were not cumulated once the cpu had no event on it so that
>     the cpu started sleeping infinitely.
>     I checked percpu vmstat and found there were total 69 counts not
>     cumulated to the zone's vmstat counter yet.
> 
>   - In this situation, kswapd did not help the trapped process.
>     In pgdat_balanced(), zone_wakermark_ok_safe() examined the number
>     of free pages on the node by zone_page_state_snapshot() which
>     checks pending counts on percpu vmstat.
>     Therefore kswapd could know there were 69 free pages correctly.
>     Since zone->_watermark = {8, 20, 32}, kswapd did not work because
>     69 was greater than 32 as high watermark.

If the imprecision of allow_direct_reclaim is the underlying problem why
haven't you used zone_page_state_snapshot instead?

Anyway, this is kind of information that is really helpful to have in
the patch description.

[...]
> > >     2. With a SCHED_FIFO task that busy loops on a given CPU,
> > >        and kworker for that CPU at SCHED_OTHER priority,
> > >        queuing work to sync per-vmstats will either cause that
> > >        work to never execute, or stalld (i.e. stall daemon)
> > >        boosts kworker priority which causes a latency
> > >        violation
> > 
> > Why is that a problem? Out-of-sync stats shouldn't cause major problems.
> > Or can they?
> 
> Consider SCHED_FIFO task that is polling the network queue (say
> testpmd).
> 
> 	do {
> 	 	if (net_registers->state & DATA_AVAILABLE) {
> 			process_data)();
> 		}
> 	 } while (!stopped);
> 
> Since this task runs at SCHED_FIFO priority, kworker won't 
> be scheduled to run (therefore per-CPU vmstats won't be
> flushed to global vmstats). 

Yes, that is certainly possible. But my main point is that vmstat
imprecision shouldn't cause functional problems. That is why we have
_snapshot readers to get an exact value where it matters for
consistency.

> Or, if testpmd runs at SCHED_OTHER, then the work item to
> flush per-CPU vmstats causes
> 
> 	testpmd -> kworker
> 	kworker: flush per-CPU vmstats
> 	kworker -> testpmd
> 
> And this might cause undesired latencies to the packets being
> processed by the testpmd task.

Right but can you have any latencies expectation in a situation like
that?

-- 
Michal Hocko
SUSE Labs
