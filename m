Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4F6D97B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbjDFNOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDFNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:14:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6538A66
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QTHB698dR7uenJPbxs0M/yET0QzXTAgV4F89bC1Z42Y=; b=GykI8TnIDa22xMqXTofCZrBOtU
        Um5fFv0vJeaapQsXxK10FaPiJdzesl9qDnH1c/yealRJ9qZ3QyBSuFQInYLZvE+ft6to2eA6j/hvT
        2kw8GrqZ7wCDj5BmvRJveMAb2uvNB8a4SQ9M9Hge+GXDMcfY5Egv1n7+GoxwQameXcl2cwPN2/NZB
        jBWMwu0UqkH9DDF3u66ctfoLln12Z2tazfuC0r6yGKi/k+ZKNL8T6zUfc7dtgf2U9d9nPoBHeWwP+
        Ah4VVmemSCfUPKM7iYLhIEmDYWqqd6BU6sO02n/QYWoST23wpJgGg5w531r67SQo59/1up9h4BRVJ
        LEnQMyrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkPR2-00HRNK-AO; Thu, 06 Apr 2023 13:13:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA5EF3000DC;
        Thu,  6 Apr 2023 15:13:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C249A212E36AA; Thu,  6 Apr 2023 15:13:51 +0200 (CEST)
Date:   Thu, 6 Apr 2023 15:13:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH 2/2] perf/x86/intel/ds: Use the size from each PEBS record
Message-ID: <20230406131351.GL386572@hirez.programming.kicks-ass.net>
References: <20230328222735.1367829-1-kan.liang@linux.intel.com>
 <20230328222735.1367829-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328222735.1367829-2-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 03:27:35PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The kernel warning for the unexpected PEBS record can also be observed
> during a context switch, when the below commands are running in parallel
> for a while on SPR.
> 
>   while true; do perf record --no-buildid -a --intr-regs=AX -e
>   cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &
> 
>   while true; do perf record -o /tmp/out -W -d -e
>   '{ld_blocks.store_forward:period=1000000,
>   MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
>   -c 1037 ./triad; done
>   *The triad program is just the generation of loads/stores.
> 
> The current PEBS code assumes that all the PEBS records in the DS buffer
> have the same size, aka cpuc->pebs_record_size. It's true for the most
> cases, since the DS buffer is always flushed in every context switch.
> 
> However, there is a corner case that breaks the assumption.
> A system-wide PEBS event with the large PEBS config may be enabled
> during a context switch. Some PEBS records for the system-wide PEBS may
> be generated while the old task is sched out but the new one hasn't been
> sched in yet. When the new task is sched in, the cpuc->pebs_record_size
> may be updated for the per-task PEBS events. So the existing system-wide
> PEBS records have a different size from the later PEBS records.
> 
> Two methods were considered to fix the issue.
> One is to flush the DS buffer for the system-wide PEBS right before the
> new task sched in. It has to be done in the generic code via the
> sched_task() call back. However, the sched_task() is shared among
> different ARCHs. The movement may impact other ARCHs, e.g., AMD BRS
> requires the sched_task() is called after the PMU has started on a
> ctxswin. The method is dropped.
> 
> The other method is implemented here. It doesn't assume that all the
> PEBS records have the same size any more. The size from each PEBS record
> is used to parse the record. For the previous platform (PEBS format < 4),
> which doesn't support adaptive PEBS, there is nothing changed.

Same as with the other; why can't we flush the buffer when we reprogram
the hardware?
