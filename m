Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121CB66DE28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjAQMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjAQMxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:53:09 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B7302AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1673959938; bh=eyH74BJ/7IIhmnPK8RsGXK4MMB69Q2QKmBRINALqzMY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UWEiNtKGqkIkX65IVF64nS/tHSIZ8csoAumnpxSMXk+x2SORolGIWPGf4CtdeHGW8
         HTpgLOvKHTMhdicuvoG4bCT5Y6RRUAp4VkpNYTyeMVJMCXXJHsmDcafWPfqryT5Qip
         PG+wi1odCf/m17w1HSEHKrYBlvdj/ipk3XggrRAQJThC6c3reiAcTOQv36S7iT0H4O
         VKR9Lp8jmeOSNi/ZfJvoTkCuHt0puTSfjv/Cj8x13xUiG/UhT+drCzs89lyrb05WkH
         MhL9tYO3w/OLBADl0pB9G+lGwZ/UBc0rn5EcshX9eOKmamU5inxzERgHWzUj47FSln
         leGVVBTwIFYqA==
Received: by gentwo.de (Postfix, from userid 1001)
        id 2B777B0023C; Tue, 17 Jan 2023 13:52:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 286F0B000FF;
        Tue, 17 Jan 2023 13:52:18 +0100 (CET)
Date:   Tue, 17 Jan 2023 13:52:18 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Frederic Weisbecker <frederic@kernel.org>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific
 vmstat discrepancies
In-Reply-To: <Y8V3PEcj2wS/VFD0@tpad>
Message-ID: <74e4afd4-5695-90fb-e66e-25d2bc2e2f53@gentwo.de>
References: <20230105125218.031928326@redhat.com> <20230105125248.813825852@redhat.com> <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de> <Y71XpnJGumySL9ej@lothringen> <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de> <Y73F4tbfxT6Kb9kZ@tpad>
 <60183179-3a28-6bf9-a6ab-8a8976f283d@gentwo.de> <Y77s4x5yC4O1OxTQ@tpad> <24ca2aad-54b2-2c3a-70b5-49a33c9a33@gentwo.de> <Y8V3PEcj2wS/VFD0@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023, Marcelo Tosatti wrote:

> Honestly, to me, there is no dilemma:
>
> * There is a requirement from applications to be uninterrupted
> by operating system activities. Examples include radio access
> network software, software defined PLCs for industrial automation (1).
>
> * There exists vm-statistics counters (which count
> the number of pages on different states, for example, number of
> free pages, locked pages, pages under writeback, pagetable pages,
> file pages, etc).
> To reduce number of accesses to the global counters, each CPU maintains
> its own delta relative to the global VM counters
> (which can be cached in the local processor cache, therefore fast).

The counters only count accurately as a global sum. A counter may be
specific to a zone and at which time it counts uses of that zone of from
all processors.

> Now you are objecting to this patchset because:
>
> It increases the number of cycles to execute the function to modify
> the counters by 6. Can you mention any benchmark where this
> increase is significant?

I am objecting because of a fundamental misunderstanding of how these
counters work and because the patchset is incorrect in the way it handles
these counters. Come up with a correct approach and then we can consider
regressions and/or improvements in performance.

> Alternatives:
> 	1) Disable periodic synchronization for nohz_full CPUs.
> 	2) Processor instructions which can modify more than
> 	   one address in memory.
> 	3) Synchronize the per-CPU stats remotely (which
> 	   increases per-CPU and per-node accesses).

Or remove the assumptions that may exist in current code that a delta on a
specific cpu counter means that something occurred on that cpu?

If there is a delta then that *does not* mean that there is something to
do on that processor. The delta could be folded by another processor into
the global counter if that processor is idle or not entering the Kernel
and stays that way throughout the operation.

So I guess that would be #3. The function cpu_vm_stats_fold() already does
this for offline cpus. Can something similar be made to work for idle cpus
or those continually running in user space?


