Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633216BB5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjCOOX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjCOOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A67C3FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678890178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4uzeqqvqacftLULyJ2ReECy8kRZPGYlZ91DDArP/f0=;
        b=gTBGDwc5KGFsWePLe/HvyHbvlmEqDpMpJtUdf1TPF2iBZjRbTUe3KPhNL5MxBdnsE5OZAR
        LDHtYfL3/rHmFZ6UlTCieOnZdD3lMh67oOSDv4rc6oM8LNZTbMGDXA0zlXGx7pLmJGOSgz
        t51xv6vGMzxf/JyWUeYKY4KRDc67O2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-UpS_HBG9NnmL_d0Zprz5rQ-1; Wed, 15 Mar 2023 10:22:55 -0400
X-MC-Unique: UpS_HBG9NnmL_d0Zprz5rQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 505CD101A553;
        Wed, 15 Mar 2023 14:22:54 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA711C15A0B;
        Wed, 15 Mar 2023 14:22:53 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 26AC3400E7196; Tue, 14 Mar 2023 21:29:32 -0300 (-03)
Date:   Tue, 14 Mar 2023 21:29:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <ZBERbKQAkwqi58JG@tpad>
References: <20230313162507.032200398@redhat.com>
 <ZBBn0evSQeuiNna4@dhcp22.suse.cz>
 <ZBBvuYkWgtVXCV7J@tpad>
 <ZBCFOZOQY5Z735Km@dhcp22.suse.cz>
 <ZBDBpUz1CktPKMfR@tpad>
 <ZBDgkr1woRo0OHyY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBDgkr1woRo0OHyY@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:01:06PM +0100, Michal Hocko wrote:
> On Tue 14-03-23 15:49:09, Marcelo Tosatti wrote:
> > On Tue, Mar 14, 2023 at 03:31:21PM +0100, Michal Hocko wrote:
> > > On Tue 14-03-23 09:59:37, Marcelo Tosatti wrote:
> > > > On Tue, Mar 14, 2023 at 01:25:53PM +0100, Michal Hocko wrote:
> > > > > On Mon 13-03-23 13:25:07, Marcelo Tosatti wrote:
> > > > > > This patch series addresses the following two problems:
> > > > > > 
> > > > > >     1. A customer provided some evidence which indicates that
> > > > > >        the idle tick was stopped; albeit, CPU-specific vmstat
> > > > > >        counters still remained populated.
> > > > > > 
> > > > > >        Thus one can only assume quiet_vmstat() was not
> > > > > >        invoked on return to the idle loop. If I understand
> > > > > >        correctly, I suspect this divergence might erroneously
> > > > > >        prevent a reclaim attempt by kswapd. If the number of
> > > > > >        zone specific free pages are below their per-cpu drift
> > > > > >        value then zone_page_state_snapshot() is used to
> > > > > >        compute a more accurate view of the aforementioned
> > > > > >        statistic.  Thus any task blocked on the NUMA node
> > > > > >        specific pfmemalloc_wait queue will be unable to make
> > > > > >        significant progress via direct reclaim unless it is
> > > > > >        killed after being woken up by kswapd
> > > > > >        (see throttle_direct_reclaim())
> > > > > 
> > > > > I have hard time to follow the actual problem described above. Are you
> > > > > suggesting that a lack of pcp vmstat counters update has led to
> > > > > reclaim issues? What is the said "evidence"? Could you share more of the
> > > > > story please?
> > > > 
> > > > 
> > > >   - The process was trapped in throttle_direct_reclaim().
> > > >     The function wait_event_killable() was called to wait condition
> > > >     allow_direct_reclaim(pgdat) for current node to be true.
> > > >     The allow_direct_reclaim(pgdat) examined the number of free pages
> > > >     on the node by zone_page_state() which just returns value in
> > > >     zone->vm_stat[NR_FREE_PAGES].
> > > > 
> > > >   - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.
> > > >     However, the freelist on this node was not empty.
> > > > 
> > > >   - This inconsistent of vmstat value was caused by percpu vmstat on
> > > >     nohz_full cpus. Every increment/decrement of vmstat is performed
> > > >     on percpu vmstat counter at first, then pooled diffs are cumulated
> > > >     to the zone's vmstat counter in timely manner. However, on nohz_full
> > > >     cpus (in case of this customer's system, 48 of 52 cpus) these pooled
> > > >     diffs were not cumulated once the cpu had no event on it so that
> > > >     the cpu started sleeping infinitely.
> > > >     I checked percpu vmstat and found there were total 69 counts not
> > > >     cumulated to the zone's vmstat counter yet.
> > > > 
> > > >   - In this situation, kswapd did not help the trapped process.
> > > >     In pgdat_balanced(), zone_wakermark_ok_safe() examined the number
> > > >     of free pages on the node by zone_page_state_snapshot() which
> > > >     checks pending counts on percpu vmstat.
> > > >     Therefore kswapd could know there were 69 free pages correctly.
> > > >     Since zone->_watermark = {8, 20, 32}, kswapd did not work because
> > > >     69 was greater than 32 as high watermark.
> > > 
> > > If the imprecision of allow_direct_reclaim is the underlying problem why
> > > haven't you used zone_page_state_snapshot instead?
> > 
> > It might have dealt with problem #1 for this particular case. However,
> > looking at the callers of zone_page_state:
> > 
> >    5   2227  mm/compaction.c <<compaction_suitable>>
> >              zone_page_state(zone, NR_FREE_PAGES));
> >    6    124  mm/highmem.c <<__nr_free_highpages>>
> >              pages += zone_page_state(zone, NR_FREE_PAGES);
> >    7    283  mm/page-writeback.c <<node_dirtyable_memory>>
> >              nr_pages += zone_page_state(zone, NR_FREE_PAGES);
> >    8    318  mm/page-writeback.c <<highmem_dirtyable_memory>>
> >              nr_pages = zone_page_state(z, NR_FREE_PAGES);
> >    9    321  mm/page-writeback.c <<highmem_dirtyable_memory>>
> >              nr_pages += zone_page_state(z, NR_ZONE_INACTIVE_FILE);
> >   10    322  mm/page-writeback.c <<highmem_dirtyable_memory>>
> >              nr_pages += zone_page_state(z, NR_ZONE_ACTIVE_FILE);
> >   11   3091  mm/page_alloc.c <<__rmqueue>>
> >              zone_page_state(zone, NR_FREE_CMA_PAGES) >
> >   12   3092  mm/page_alloc.c <<__rmqueue>>
> >              zone_page_state(zone, NR_FREE_PAGES) / 2) {
> > 
> > The suggested patchset fixes the problem of where due to nohz_full,
> > the delayed timer for vmstat_work can be armed but not executed (which means
> > the per-cpu counters can be out of sync for as long as the cpu is in 
> > idle while in nohz_full mode).
> > 
> > You probably do not want to convert all callers of zone_page_state
> > into zone_page_state_snapshot (as a justification for the proposed
> > patchset).
> 
> Yes, I do not really think we want or even need to convert all of them.

OK.

> But it seems that your direct reclaim throttling example really requires
> that. The thing with the remote flushing is that it would suffer from
> a similar imprecations as the flushing could be deferred and under
> certain conditions really starved. 

> So it is definitely worth fixing the
> issue you are seeing without such a complex scheme.

The scheme is necessary for other reasons.

> > > Anyway, this is kind of information that is really helpful to have in
> > > the patch description.
> > 
> > Agree: resending a new version with updated commit.
> 
> I would really recommend trying out the simple fix and see if it changes
> the behavior.
>
> > > [...]
> > > > > >     2. With a SCHED_FIFO task that busy loops on a given CPU,
> > > > > >        and kworker for that CPU at SCHED_OTHER priority,
> > > > > >        queuing work to sync per-vmstats will either cause that
> > > > > >        work to never execute, or stalld (i.e. stall daemon)
> > > > > >        boosts kworker priority which causes a latency
> > > > > >        violation
> > > > > 
> > > > > Why is that a problem? Out-of-sync stats shouldn't cause major problems.
> > > > > Or can they?
> > > > 
> > > > Consider SCHED_FIFO task that is polling the network queue (say
> > > > testpmd).
> > > > 
> > > > 	do {
> > > > 	 	if (net_registers->state & DATA_AVAILABLE) {
> > > > 			process_data)();
> > > > 		}
> > > > 	 } while (!stopped);
> > > > 
> > > > Since this task runs at SCHED_FIFO priority, kworker won't 
> > > > be scheduled to run (therefore per-CPU vmstats won't be
> > > > flushed to global vmstats). 
> > > 
> > > Yes, that is certainly possible. But my main point is that vmstat
> > > imprecision shouldn't cause functional problems. That is why we have
> > > _snapshot readers to get an exact value where it matters for
> > > consistency.
> > 
> > Understood. Perhaps allow_direct_reclaim should use
> > zone_page_state_snapshot, as otherwise it is only precise
> > at sysctl_stat_interval intervals?
> 
> or even much less than that. The flusher uses WQ infrastructure and even
> when a WQ_MEM_RECLAIM one is used this doesn't mean that all workers
> could be jammed.
>  
> > > > Or, if testpmd runs at SCHED_OTHER, then the work item to
> > > > flush per-CPU vmstats causes
> > > > 
> > > > 	testpmd -> kworker
> > > > 	kworker: flush per-CPU vmstats
> > > > 	kworker -> testpmd
> > >
> > > And this might cause undesired latencies to the packets being
> > > processed by the testpmd task.
> > 
> > > Right but can you have any latencies expectation in a situation like
> > > that?
> > 
> > Not sure i understand what you mean. Example:
> > 
> > https://www.gabrieleara.it/assets/documents/papers/conferences/2021-ieee-nfv-sdn.pdf
> > 
> > In general, UDPDK exhibits a much lower
> > latency than the in-kernel UDP stack used through the POSIX
> > API (e.g., a 69 % reduction from 95 µs down to 29 µs), thanks
> > to its ability to bypass the kernel entirely, which in turn
> > outperforms the in-kernel TCP stack as available through the
> > POSIX API, as expected.
> > ...
> > Alternatively, application processes can use UDPDK
> > with the non-blocking API calls (using the O_NONBLOCK flag)
> > and perform some other action while waiting for packets to
> > be ready to be sent/received to/from the UDPDK Process,
> > instead of performing continuous busy-loops on packet queues.
> > However, in this case the cost of a single CPU fully busy due
> > to the UDPDK Process itself is anyway unavoidab
> 
> If the userspace workload avoids the kernel completely then it is quite
> unlikely that there is any pcp work to be flushed for in-kernel
> counters.

This particular workload avoids the kernel. Others (were latency is
still a concern) don't.

> That being said, I am nor saying remote flushing is not useful. 

> I just think that the issue you are reporting here could be fixed by
> a much simpler fix that doesn't change the way how the flushing is
> performed.

OK. Must change flushing anyway, but fixing allow_direct_reclaim to 
use zone_page_state_snapshot won't hurt.

> Such a large rework should be justified by performance numbers.

OK.

> It should be also explained how do we end up doing a lot of work on
> isolated cpus or a pure user space workload.

Again, pure user space workload is one example where latency matters, in
response to the "can you have any latencies expectation in a situation like
that?" question.

Will resend -v8 with allow_direct_reclaim fix.

