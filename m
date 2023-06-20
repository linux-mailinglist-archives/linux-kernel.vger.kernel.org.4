Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC1736746
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjFTJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjFTJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:12:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77655199E;
        Tue, 20 Jun 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qCVVL3C0DZsRF9OazXGnGiYF9tGXGgUu4l3EImJeYTk=; b=TKRbQjOiPPXkKbjrt/96y46r0Z
        VlNQIZDpZlZkqjS46akOPzFaSs/7O9ACT8D/Vu0FyLT7nTXV+do7Q6tjtyrHmiCAYCzXPU6auiAa2
        aOb4cgUyi8JjmxP/Ef17hhmVY/Mh6oiyZerrNffD9Jro16egeI+0GoaBYCs1pPHwPT4ehw6EE2UkM
        I8+0AY/tggflicXD/z/SZvDvRzk/mPX16pni7U5u2H91pGa9t//1Qa2OW9y3gfks6vrEOmmRPRcaM
        QnscQ36+ZMJPMDzo93mANTl1mlr5BF4D7rICa06GxDYVWMtdllh0ZyKLO6OYmuY4HUlfRs6bDqafg
        Lt9aBKTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBXOm-00G0u8-0a;
        Tue, 20 Jun 2023 09:11:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37FBB300274;
        Tue, 20 Jun 2023 11:11:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B347213E05C9; Tue, 20 Jun 2023 11:11:39 +0200 (CEST)
Date:   Tue, 20 Jun 2023 11:11:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:44:32PM +0530, Swapnil Sapkal wrote:
> Hello Mathieu,
> 
> On 4/22/2023 1:13 PM, tip-bot2 for Mathieu Desnoyers wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     223baf9d17f25e2608dbdff7232c095c1e612268
> > Gitweb:        https://git.kernel.org/tip/223baf9d17f25e2608dbdff7232c095c1e612268
> > Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > AuthorDate:    Thu, 20 Apr 2023 10:55:48 -04:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 21 Apr 2023 13:24:20 +02:00
> > 
> > sched: Fix performance regression introduced by mm_cid
> > 
> > Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> > sysbench regression reported by Aaron Lu.
> > 
> > Keep track of the currently allocated mm_cid for each mm/cpu rather than
> > freeing them immediately on context switch. This eliminates most atomic
> > operations when context switching back and forth between threads
> > belonging to different memory spaces in multi-threaded scenarios (many
> > processes, each with many threads). The per-mm/per-cpu mm_cid values are
> > serialized by their respective runqueue locks.
> > 
> > Thread migration is handled by introducing invocation to
> > sched_mm_cid_migrate_to() (with destination runqueue lock held) in
> > activate_task() for migrating tasks. If the destination cpu's mm_cid is
> > unset, and if the source runqueue is not actively using its mm_cid, then
> > the source cpu's mm_cid is moved to the destination cpu on migration.
> > 
> > Introduce a task-work executed periodically, similarly to NUMA work,
> > which delays reclaim of cid values when they are unused for a period of
> > time.
> > 
> > Keep track of the allocation time for each per-cpu cid, and let the task
> > work clear them when they are observed to be older than
> > SCHED_MM_CID_PERIOD_NS and unused. This task work also clears all
> > mm_cids which are greater or equal to the Hamming weight of the mm
> > cidmask to keep concurrency ids compact.
> > 
> > Because we want to ensure the mm_cid converges towards the smaller
> > values as migrations happen, the prior optimization that was done when
> > context switching between threads belonging to the same mm is removed,
> > because it could delay the lazy release of the destination runqueue
> > mm_cid after it has been replaced by a migration. Removing this prior
> > optimization is not an issue performance-wise because the introduced
> > per-mm/per-cpu mm_cid tracking also covers this more specific case.
> > 
> > Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> > Reported-by: Aaron Lu <aaron.lu@intel.com>
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Aaron Lu <aaron.lu@intel.com>
> > Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
> 
> I run standard benchmarks as a part of kernel performance regression
> testing. When I run these benchmarks against v6.3.0 to v6.4-rc1,
> I have seen performance regression in hackbench running with threads. When I did
> git bisect it pointed to this commit and reverting this commit helps regains
> the performance. This regression is not seen with hackbench processes.

Well, *this* commit was supposed to help fix the horrible contention on
cid_lock that was introduced with af7f588d8f73.

> Following are the results from 1 Socket 4th generation EPYC
> Processor(1 X 96C/192T) configured in NPS1 mode. This regression
> becomes more severe as the number of core count increases.
> 
> The numbers on a 1 Socket Bergamo (1 X 128 cores/256 threads) is significantly worse.
> 
> Threads:
> 
> Test:             With-mmcid-patch        Without-mmcid-patch
>  1-groups:         5.23 (0.00 pct)         4.61 (+11.85 pct)
>  2-groups:         4.99 (0.00 pct)         4.72 (+5.41 pct)
>  4-groups:         5.96 (0.00 pct)         4.87 (+18.28 pct)
>  8-groups:         6.58 (0.00 pct)         5.44 (+17.32 pct)
> 16-groups:        11.48 (0.00 pct)         8.07 (+29.70 pct)

I'm really confused, so you're saying that having a process wide
spinlock is better than what this patch does? Or are you testing against
something without mm-cid entirely?
