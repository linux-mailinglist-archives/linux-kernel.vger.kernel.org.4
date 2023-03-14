Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19D6B9567
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjCNNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCNNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A7A56AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678798802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9vVOWJlwuPnKm/f8w0R1Et2c0yKK9tWZ7eUXSHlnvM=;
        b=S3GeJNaWZjuLAhooF9KAqwOXjIoyJEHmw90lgCq8JfnH6NO9ON6vPrhE7roiDgXUVHONwJ
        fYtjBjnQvIpkHSLWmBoei2AIizNZVi/vbzKBbkpDrZu4IySeKF84PdFGmfO/4r0qNV7psI
        BQpMoqX8yu/NeM5G0u0O/bI5xWADNbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-UacGbyQFP3yH2xNDszJuSA-1; Tue, 14 Mar 2023 08:59:56 -0400
X-MC-Unique: UacGbyQFP3yH2xNDszJuSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 473A185D067;
        Tue, 14 Mar 2023 12:59:55 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAFA74042AC8;
        Tue, 14 Mar 2023 12:59:54 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id ED2DE40156300; Tue, 14 Mar 2023 09:59:37 -0300 (-03)
Date:   Tue, 14 Mar 2023 09:59:37 -0300
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
Message-ID: <ZBBvuYkWgtVXCV7J@tpad>
References: <20230313162507.032200398@redhat.com>
 <ZBBn0evSQeuiNna4@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBn0evSQeuiNna4@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:25:53PM +0100, Michal Hocko wrote:
> On Mon 13-03-23 13:25:07, Marcelo Tosatti wrote:
> > This patch series addresses the following two problems:
> > 
> >     1. A customer provided some evidence which indicates that
> >        the idle tick was stopped; albeit, CPU-specific vmstat
> >        counters still remained populated.
> > 
> >        Thus one can only assume quiet_vmstat() was not
> >        invoked on return to the idle loop. If I understand
> >        correctly, I suspect this divergence might erroneously
> >        prevent a reclaim attempt by kswapd. If the number of
> >        zone specific free pages are below their per-cpu drift
> >        value then zone_page_state_snapshot() is used to
> >        compute a more accurate view of the aforementioned
> >        statistic.  Thus any task blocked on the NUMA node
> >        specific pfmemalloc_wait queue will be unable to make
> >        significant progress via direct reclaim unless it is
> >        killed after being woken up by kswapd
> >        (see throttle_direct_reclaim())
> 
> I have hard time to follow the actual problem described above. Are you
> suggesting that a lack of pcp vmstat counters update has led to
> reclaim issues? What is the said "evidence"? Could you share more of the
> story please?


  - The process was trapped in throttle_direct_reclaim().
    The function wait_event_killable() was called to wait condition
    allow_direct_reclaim(pgdat) for current node to be true.
    The allow_direct_reclaim(pgdat) examined the number of free pages
    on the node by zone_page_state() which just returns value in
    zone->vm_stat[NR_FREE_PAGES].

  - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.
    However, the freelist on this node was not empty.

  - This inconsistent of vmstat value was caused by percpu vmstat on
    nohz_full cpus. Every increment/decrement of vmstat is performed
    on percpu vmstat counter at first, then pooled diffs are cumulated
    to the zone's vmstat counter in timely manner. However, on nohz_full
    cpus (in case of this customer's system, 48 of 52 cpus) these pooled
    diffs were not cumulated once the cpu had no event on it so that
    the cpu started sleeping infinitely.
    I checked percpu vmstat and found there were total 69 counts not
    cumulated to the zone's vmstat counter yet.

  - In this situation, kswapd did not help the trapped process.
    In pgdat_balanced(), zone_wakermark_ok_safe() examined the number
    of free pages on the node by zone_page_state_snapshot() which
    checks pending counts on percpu vmstat.
    Therefore kswapd could know there were 69 free pages correctly.
    Since zone->_watermark = {8, 20, 32}, kswapd did not work because
    69 was greater than 32 as high watermark.

  - As the result:
    - The process waited allow_direct_reclaim(pgdat) to be true.
      - allow_direct_reclaim() saw 0 via zone_page_state().
        It woke kswapd since 0 was lower than min watermark.
    - The kswapd did nothing.
      - kswapd saw 69 via zone_page_state_snapshot().
        It woke waiters without performing memory reclaim
        since 69 is greater than high watermark.
    - The process woked by kswapd soon restart waiting for kswapd.
      - Still allow_direct_reclaim() saw 0 via zone_page_state().
        It woke kswapd since 0 was lower than min watermark.

> 
> >     2. With a SCHED_FIFO task that busy loops on a given CPU,
> >        and kworker for that CPU at SCHED_OTHER priority,
> >        queuing work to sync per-vmstats will either cause that
> >        work to never execute, or stalld (i.e. stall daemon)
> >        boosts kworker priority which causes a latency
> >        violation
> 
> Why is that a problem? Out-of-sync stats shouldn't cause major problems.
> Or can they?

Consider SCHED_FIFO task that is polling the network queue (say
testpmd).

	do {
	 	if (net_registers->state & DATA_AVAILABLE) {
			process_data)();
		}
	 } while (!stopped);

Since this task runs at SCHED_FIFO priority, kworker won't 
be scheduled to run (therefore per-CPU vmstats won't be
flushed to global vmstats). 

Or, if testpmd runs at SCHED_OTHER, then the work item to
flush per-CPU vmstats causes

	testpmd -> kworker
	kworker: flush per-CPU vmstats
	kworker -> testpmd

And this might cause undesired latencies to the packets being
processed by the testpmd task.

