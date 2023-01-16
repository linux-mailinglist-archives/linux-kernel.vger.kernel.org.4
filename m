Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F415266CEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjAPScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjAPScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD027483
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673893033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rYVIy1kB09an+EtRfzUSHQAOZ0Qm1/8bViAryaPMZc=;
        b=ThlQtWZe0BkN5LbJjRJGKetXaxnUOLsQLjq6EZDIOkXAaqItW1G8vG3DRX3YFdnprCMG6U
        H05MnhwTTLcl4ihaLkOwpVHkUihSbmJZV7SaUonQ83rGnZxncrY3L9yGvwzZY27mHJ2xHx
        36BGED8IVim0448iw/gXM5kEeFkqB3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-kQ123Hv8Mj6P2K1n6Onu3w-1; Mon, 16 Jan 2023 13:17:11 -0500
X-MC-Unique: kQ123Hv8Mj6P2K1n6Onu3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D6B4101A521;
        Mon, 16 Jan 2023 18:17:11 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B701121314;
        Mon, 16 Jan 2023 18:17:10 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 4C4F5404265AA; Mon, 16 Jan 2023 13:11:40 -0300 (-03)
Date:   Mon, 16 Jan 2023 13:11:40 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <Y8V3PEcj2wS/VFD0@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230105125248.813825852@redhat.com>
 <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de>
 <Y71XpnJGumySL9ej@lothringen>
 <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de>
 <Y73F4tbfxT6Kb9kZ@tpad>
 <60183179-3a28-6bf9-a6ab-8a8976f283d@gentwo.de>
 <Y77s4x5yC4O1OxTQ@tpad>
 <24ca2aad-54b2-2c3a-70b5-49a33c9a33@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ca2aad-54b2-2c3a-70b5-49a33c9a33@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:51:40AM +0100, Christoph Lameter wrote:
> On Wed, 11 Jan 2023, Marcelo Tosatti wrote:
> 
> > OK, can replace this_cpu operations with this_cpu_ptr + standard C operators
> > (and in fact can do that for interrupt disabled functions as well, that
> > is CONFIG_HAVE_CMPXCHG_LOCAL not defined).
> >
> > Is that it?
> 
> No that was hyperthetical.
> 
> I do not know how to get out of this dilemma. We surely want to keep fast
> vmstat operations working.

Honestly, to me, there is no dilemma:

* There is a requirement from applications to be uninterrupted
by operating system activities. Examples include radio access
network software, software defined PLCs for industrial automation (1).

* There exists vm-statistics counters (which count
the number of pages on different states, for example, number of 
free pages, locked pages, pages under writeback, pagetable pages,
file pages, etc). 
To reduce number of accesses to the global counters, each CPU maintains
its own delta relative to the global VM counters
(which can be cached in the local processor cache, therefore fast).

The per-CPU deltas are synchronized to global counters:
	1) If the per-CPU counters exceed a given threshold.
	2) Periodically, with a low frequency compared to 
	   CPU events (every number of seconds).
	3) Upon an event that requires accurate counters.

* The periodic synchronization interrupts a given CPU, in case
it contains a counter delta relative to the global counters.

To avoid this interruption, due to [1], the proposed patchset
synchronizes any pending per-CPU deltas to global counters,
for nohz_full= CPUs, when returning to userspace
(which is a very fast path).

Since return to userspace is a very fast path, synchronizing
per-CPU counter deltas by reading their contents is undesired.

Therefore a single bit is introduced to compact the following
information: does this CPU contain any delta relative to the
global counters that should be written back?

This bit is set when a per-CPU delta is increased.
This bit is cleared when the per-CPU deltas are written back to 
the global counters.

Since for the following two operations:

	modify per-CPU delta (for current CPU) of counter X by Y
	set bit (for current CPU) indicating the per-CPU delta exists

"current CPU" can change, it is necessary to disable CPU preemption
when executing the pair of operations.

vmstat operations still perform their main goal which is to 
maintain accesses local to the CPU when incrementing the counters
(for most of counter modifications).
The preempt_disable/enable pair is also a per-CPU variable.

Now you are objecting to this patchset because:

It increases the number of cycles to execute the function to modify 
the counters by 6. Can you mention any benchmark where this 
increase is significant?

By searching for mod_zone_page_state/mode_node_page_state one can see
the following: the codepaths that call them are touching multiple pages
and other data structures, so the preempt_enable/preempt_disable
pair should be a very small contribution (in terms of percentage) to any
meaningful benchmark.


> The fundamental issue that causes the vmstat discrepancies is likely that
> the fast this_cpu ops can increment the counter on any random cpu and that
> this is the reason you get vmstat discrepancies.

Yes. 

> Give up the assumption that an increment of a this_cpu counter on a
> specific cpu means that something occurred on that specific cpu. Maybe
> that will get you on a path to resolve the issues you are seeing.

But it can't. To be able to condense the information "does a delta exist
on this CPU" from a number of cacheline reads to a single cacheline
read, one bit can be used. And the write to that bit and to the counters
is not atomic.

Alternatives:
	1) Disable periodic synchronization for nohz_full CPUs.
	2) Processor instructions which can modify more than
	   one address in memory.
	3) Synchronize the per-CPU stats remotely (which
	   increases per-CPU and per-node accesses).


