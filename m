Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84FA621D69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKHUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKHUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:07:37 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764B60EB3;
        Tue,  8 Nov 2022 12:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667938055;
        bh=2YjYNBDqhLy3uADbeMp1P3aHSxfJP3jjX9skYBBOTF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WQ0fUS7O2LZBWNGgFF80xUg98NuQStaICXq4CeaFKXRP37pRB00VE9cBYQRd7SHqZ
         UhFNmn5cBzmXXMdDQ7rNSs17pzVHJlamaHmqsSvYLew9vVDfgGaYxotc47IfcL/ytU
         wva/GxcNATQqmcA55gpxsJAinnhnnnmlVBdUdox9xx3rJP85WIr/EpHtZ36X3lDmgE
         JlakrdHEW2+gTAOmpTTeA3eUl5R3eb1q+jRP4n4XJ50XdZg3OMsBAKKboOnvoPHwp+
         esbrPxSsG8/U7yTCxPc6vYf3lSPnqr7wRgBmSYTxjeYZNIbrNtvTiYBCGKEAeZGe1k
         9w4Lnf20tUpOw==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N6Jzq2RB4zgTw;
        Tue,  8 Nov 2022 15:07:35 -0500 (EST)
Message-ID: <580eec2b-f204-2eb1-806d-8282b8b60bf2@efficios.com>
Date:   Tue, 8 Nov 2022 15:07:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <Y2pT7ij/TcI4EmH6@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y2pT7ij/TcI4EmH6@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-08 08:04, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:
> 
>> The credit goes to Paul Turner (Google) for the vcpu_id idea. This
>> feature is implemented based on the discussions with Paul Turner and
>> Peter Oskolkov (Google), but I took the liberty to implement scheduler
>> fast-path optimizations and my own NUMA-awareness scheme. The rumor has
>> it that Google have been running a rseq vcpu_id extension internally at
>> Google in production for a year. The tcmalloc source code indeed has
>> comments hinting at a vcpu_id prototype extension to the rseq system
>> call [1].
> 
> Re NUMA thing -- that means that on a 512 node system a single threaded
> task can still observe 512 separate vcpu-ids, right?

Yes, that's correct.

> 
> Also, said space won't be dense.

Indeed, this can be inefficient if the data structure within the 
single-threaded task is not NUMA-aware *and* that task is free to bounce 
all over the 512 numa nodes.

> 
> The main selling point of the whole vcpu-id scheme was that the id space
> is dense and not larger than min(nr_cpus, nr_threads), which then gives
> useful properties.
> 
> But I'm not at all seeing how the NUMA thing preserves that.

If a userspace per-vcpu data structure is implemented with NUMA-local 
allocations, then it becomes really interesting to guarantee that the 
per-vcpu-id accesses are always numa-local for performance reasons.

If a userspace per-vcpu data structure is not numa-aware, then we have 
two scenarios:

A) The cpuset/sched affinity under which it runs pins it to a set of 
cores belonging to a specific NUMA node. In this case, even with 
numa-aware vcpu id allocation, the ids will stay as close to 0 as if not 
numa-aware.

B) No specific cpuset/sched affinity set, which means the task is free 
to bounce all over. In this case I agree that having the indexing 
numa-aware, but the per-vcpu data structure not numa-aware, is inefficient.

I wonder whether scenarios with 512 nodes systems, with containers using 
few cores, but without using cpusets/sched affinity to pin the workload 
to specific numa nodes is a workload we should optimize for ? It looks 
like the lack of numa locality due to lack of allowed cores restriction 
is a userspace configuration issue.

We also must keep in mind that we can expect a single task to load a mix 
of executable/shared libraries where some pieces may be numa-aware, and 
others may not. This means we should ideally support a numa-aware 
vcpu-id allocation scheme and non-numa-aware vcpu-id allocation scheme 
within the same task.

This could be achieved by exposing two struct rseq fields rather than 
one, e.g.:

vm_vcpu_id -> flat indexing, not numa-aware.
vm_numa_vcpu_id -> numa-aware vcpu id indexing.

This would allow data structures that are inherently numa-aware to 
benefit from numa-locality, without hurting non-numa-aware data structures.

> 
> Also; given the utter mind-bendiness of the NUMA thing; should it go
> into it's own patch; introduce the regular plain old vcpu first, and
> then add things to it -- that also allows pushing those weird cpumask
> ops you've created later into the series.

Good idea. I can do that once we agree on the way forward for flat vs 
numa-aware vcpu-id rseq fields.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

