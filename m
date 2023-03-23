Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57396C6E18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCWQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCWQti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:49:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05F11154;
        Thu, 23 Mar 2023 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wZrc8t7iqb/rNBBPsg0Yvex8uxmUf4O6Gadpn9n/nXM=; b=ZIeplrIw75d9OpSwloMbnQbSec
        UfU7c2yAuzyX9V57slKcIJI/dCKy1OxSC9Et7xcyTH1RSC13be460lonPzrz+ZEsY8cLPxtI/91dh
        HJT2KRoxiP3gsHM0iYVyn9fdOfepGICyD5M17O/Pw9TxobrI3obNLxheot67bJsrL2lWJ2obZ6cg7
        ipA+yzkH+JxaPk3aBaneTpL5u4Ow+bdFOwaHGoZbHKydv1UKz75HtGwfPh47m0E/lMpoR+T+dd5i5
        MhHk5K+GW5loVw+pV2Wl1Rr4i+eoHMefud6az3vVND8ajHl/bfSwXcX9+88IQsYtop7DewKdrWlj+
        T19uv7dw==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfO7d-002Wdo-2m;
        Thu, 23 Mar 2023 16:49:05 +0000
Message-ID: <dcb0c139-e40e-f448-ad99-245020025862@infradead.org>
Date:   Thu, 23 Mar 2023 09:49:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC] Documentation: Add document for false sharing
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
References: <20230323082626.100718-1-feng.tang@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230323082626.100718-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Lots of good/interesting info here.

On 3/23/23 01:26, Feng Tang wrote:
> From: "Tang, Feng" <feng.tang@intel.com>
> 
> When doing performance tuning or debugging performance regressions,
> more and more cases are found to be related to false sharing [1][2],
> and the situation can be worse for newer platforms with hundreds of
> CPUs. There are already many commits in current kernel specially
> for mitigating the performance downgradation due to false sharing.

maybe                            degradation

> 
> False sharing could harm the performance silently without being
> noticed, due to reasons like:
> * data members of a big data structure randomly sitting together
>   in one cache line
> * global data of small size are linked compactly together
> 
> So it's better to make a simple document about the normal pattern
> of false sharing, basic ways to mitigate it and call out to
> developers to pay attention during code-writing.
> 
> [ Many thanks to Dave Hansen, Ying Huang, Tim Chen, Julie Du and
>   Yu Chen for their contributions ]
> 
> [1]. https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9020/
> [2]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  .../kernel-hacking/false-sharing.rst          | 199 ++++++++++++++++++
>  Documentation/kernel-hacking/index.rst        |   1 +
>  2 files changed, 200 insertions(+)
>  create mode 100644 Documentation/kernel-hacking/false-sharing.rst
> 
> diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
> new file mode 100644
> index 000000000000..325de2be2c49
> --- /dev/null
> +++ b/Documentation/kernel-hacking/false-sharing.rst
> @@ -0,0 +1,199 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +False Sharing
> +=============
> +
> +What is False Sharing
> +=====================
> +False sharing is related with cache mechanism of maintaining the data
> +coherence of one cache line stored in multiple CPU's caches, the

                                                        caches; then

> +academic definition for it is in [1]_. Consider a struct with a
> +refcount and a string::
> +
> +	struct foo {
> +		refcount_t refcount;
> +		...
> +		char name[16];
> +	} ____cacheline_internodealigned_in_smp;
> +
> +Member 'refcount'(A) and 'name'(B) _share_ one cache line like below::
> +
> +                +-----------+                     +-----------+
> +                |   CPU 0   |                     |   CPU 1   |
> +                +-----------+                     +-----------+
> +               /                                        |
> +              /                                         |
> +             V                                          V
> +         +----------------------+             +----------------------+
> +         | A      B             | Cache 0     | A       B            | Cache 1
> +         +----------------------+             +----------------------+
> +                             |                  |
> +  ---------------------------+------------------+-----------------------------
> +                             |                  |
> +                           +----------------------+
> +                           |                      |
> +                           +----------------------+
> +              Main Memory  | A       B            |
> +                           +----------------------+
> +
> +'refcount' is modified frequently, but 'name' is set once at object
> +creation time and is never modified.  When many CPUs access 'foo' at
> +the same time, and 'refcount' is only bumped by one CPU frequently,
> +while 'name' is read by all other CPUs, which have to reload the whole
> +cache line over and over, even though the 'name' is never changed.

That last "sentence" is not a sentence.

> +
> +There are many real-world cases of performance regressions caused by
> +false sharing, and one is a rw_semaphore 'mmap_lock' inside struct
> +mm_struct, whose cache line layout change triggered a regression
> +and Linus analyzed in [2]_.
> +
> +There are two key factors for a harmful false sharing:
> +
> +* A global data accessed(shared) by many CPUs

              datum accessed (shared)

> +* In the concurrent accesses to the data, there is at least one write
> +  operation: write/write or write/read cases.
> +
> +The sharing could be from totally unrelated kernel components, or
> +different code paths of the same kernel component.
> +
> +
> +False Sharing Pitfalls
> +======================
> +Back in time when one platform has only one or a few CPUs, hot data

                                  had

> +members could be purposely put in the same cache line to make them
> +cache hot and save cacheline/TLB, like a lock and the data protected
> +by it.  But for recent large system with hundreds of CPUs, this may
> +not work when the lock is heavily contended, as the lock owner CPU
> +could write to the data, while other CPUs are busy spinning the lock.
> +
> +Looking at past cases, there are several frequently occurring patterns
> +for false sharing:
> +
> +* lock(spinlock/mutex/semaphore) and data protected by it are

   * lock (spinlock/mutex/semaphore)

> +  purposely put in one cache line.
> +* global data being put together in one cache line. Some kernel
> +  subsystem has many global parameters of small size (4 bytes),

     subsystems have

> +  which can easily be grouped together and put into one cache line.
> +* data members of a big data structure randomly sitting together
> +  without being noticed (cache line is usually 64 bytes or more),
> +  like struct 'mem_cgroup'.
> +
> +Following 'mitigation' section provides real-world examples.
> +
> +False sharing could easily happen unless they are intentionally
> +checked, and it is valuable to run specific tools for performance
> +critical workload to detect false sharing affecting performance case

            workloads

> +and optimize accordingly.
> +
> +
> +How to detect and analysis False Sharing
> +========================================
> +perf record/report/stat are widely used for performance tuning, and
> +once hotspots are detected, tools like 'perf-c2c' and 'pahole' can
> +be further used to detect and pinpoint the possible false sharing
> +data structures.  'addr2line' is also good at decoding instruction
> +pointer when there are multiple layers of inline functions.
> +
> +perf-c2c can capture the cache lines with most false sharing hits,
> +decoded functions (line number of file) accessing that cache line,
> +and in-line offset of the data. Simple commands are::
> +
> +  #perf c2c record -ag sleep 3
> +  #perf c2c report --call-graph none -k vmlinux
> +
> +Run it when testing will-it-scale's tlb_flush1 case, and the report
> +has pieces like::
> +
> +  Total records                     :    1658231
> +  Locked Load/Store Operations      :      89439
> +  Load Operations                   :     623219
> +  Load Local HITM                   :      92117
> +  Load Remote HITM                  :        139
> +
> +  #----------------------------------------------------------------------
> +      4        0     2374        0        0        0  0xff1100088366d880
> +  #----------------------------------------------------------------------
> +    0.00%   42.29%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81373b7b         0       231       129     5312        64  [k] __mod_lruvec_page_state    [kernel.vmlinux]  memcontrol.h:752   1
> +    0.00%   13.10%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81374718         0       226        97     3551        64  [k] folio_lruvec_lock_irqsave  [kernel.vmlinux]  memcontrol.h:752   1
> +    0.00%   11.20%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c29bf         0       170       136      555        64  [k] lru_add_fn                 [kernel.vmlinux]  mm_inline.h:41     1
> +    0.00%    7.62%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c3ec5         0       175       108      632        64  [k] release_pages              [kernel.vmlinux]  mm_inline.h:41     1
> +    0.00%   23.29%    0.00%    0.00%    0.00%   0x10     1       1  0xffffffff81372d0a         0       234       279     1051        64  [k] __mod_memcg_lruvec_state   [kernel.vmlinux]  memcontrol.c:736   1
> +
> +A nice introduction for perf-c2c is [3]_

Add a period at the end above?

> +
> +'pahole' decodes data structure layouts delimited in cache line
> +granularity.  User can match the offset in perf-c2c output with

                 The user
or               A user
or               Users

> +pahole's decoding to locate the exact data members.  For global
> +data, user can search the data address in system.map.

                                             System.map.

> +
> +
> +Possible Mitigations
> +====================
> +False sharing does not always need to be mitigated.  False sharing
> +mitigations need to balance performance gains with complexity and
> +space consumption.  Sometimes, lower performance is OK, and it's
> +unnecessary to hyper-optimize every rarely used data structure or
> +a cold data path.
> +
> +False sharing hurting performance cases are seen more frequently with
> +core count increasing, and there have been many patches merged to
> +solve it, like in networking and memory management subsystems.  Some
> +common mitigations(with examples) are:

          mitigations (with examples) are:

> +
> +* Separate hot global data in its own dedicated cache line, even if it
> +  is just a 'short' type. The downside is more consumption of memory,
> +  cache line and TLB entries.
> +
> +  Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_allocated")
> +
> +* Reorganize the data structure, separate the interfering members to
> +  different cache lines.  One downside is it may introduce new false
> +  sharing of other members.
> +
> +  Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce false sharing")
> +
> +* Replace 'write' with 'read' when possible, especially in loops.
> +  Like for some global variable, use compare(read)-then-write instead
> +  of unconditional write. Like Use:

                             For example, use:

> +
> +	if (!test_bit(XXX))
> +		set_bit(XXX);
> +
> +  instead of directly "set_bit(XXX);", similarly for atomic_t data.
> +
> +  Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
> +  Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> +
> +* Turn hot global data to 'per-cpu data + global data' when possible,
> +  or reasonably increase the threshold for syncing per-cpu data to
> +  global data, to reduce or postpone the 'write' to that global data.
> +
> +  Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
> +  Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
> +
> +Surely, all mitigations should be carefully verified to not cause side
> +effects.  And to avoid false sharing in advance during coding, it's
> +better to:
> +
> +* Be aware of cache line boundaries
> +* Group mostly read-only fields together
> +* Group things that are written at the same time together
> +* Separate known read-mostly and written-mostly fields
> +
> +and better add a comment stating the false sharing consideration.
> +
> +One note is, sometimes even after a severe false sharing is detected
> +and solved, the performance may still has no obvious improvement as
> +the hotspot switches to a new place.
> +
> +
> +Misc
> +=====

  Miscellaneous
  =============

> +One open is kernel has data structure randomization mechanism, which

   One open issue is that the kernel has an optional data structure
   randomization mechanism, which


> +also randomizes the situation of cache line sharing of data members.
> +
> +
> +.. [1] https://en.wikipedia.org/wiki/False_sharing
> +.. [2] https://lore.kernel.org/lkml/CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com/
> +.. [3] https://joemario.github.io/blog/2016/09/01/c2c-blog/
> diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kernel-hacking/index.rst
> index f53027652290..79c03bac99a2 100644
> --- a/Documentation/kernel-hacking/index.rst
> +++ b/Documentation/kernel-hacking/index.rst
> @@ -9,3 +9,4 @@ Kernel Hacking Guides
>  
>     hacking
>     locking
> +   false-sharing

Thanks for the documentation.
-- 
~Randy
