Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4676D8AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjDEWi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDEWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:38:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C2198A;
        Wed,  5 Apr 2023 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680734302; x=1712270302;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uF/QBOzF72JehbC5ujq+v9y0TYRet0oqwDu3diogIvI=;
  b=gJ3SJnoyGT4oTYXdwKcr5t18kEcatIIKADhdJEDQe/DQG0V5d6VuxY3o
   QkL3KNfy15jS1HD9EBFCv6t2UG2WfAwvadajwjI0b86GRaHmmq5X2zhvk
   FtoBG66X86nKupVvT4D/e0pX5TMGPHUnIesHJXCDGJqCm7vu7TWo/NBi9
   HKaSk+pdnazwYIptHwLXOawbIZHaM5DUHyVW389HrrXWqKYQAYEah+vCY
   qRWL5g/GmfEJPRI2HkcNGLQjveJI5HZUgCjzo19splB3k9v4MujZtALCV
   eMu3IyUPlJNo0/RWN1+SDvZHmdQEplGIz830YuMdALugDwSStBTo1h2/t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428875708"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="428875708"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 15:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016644486"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="1016644486"
Received: from skansra-mobl.amr.corp.intel.com (HELO [10.209.62.228]) ([10.209.62.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 15:38:21 -0700
Message-ID: <2520c3d060e7b77560ea32a4b132d8e1a5f14ac9.camel@linux.intel.com>
Subject: Re: [PATCH v3] Documentation: Add document for false sharing
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Date:   Wed, 05 Apr 2023 15:38:20 -0700
In-Reply-To: <20230404052228.15788-1-feng.tang@intel.com>
References: <20230404052228.15788-1-feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update. Looks good.  Some minor nits to improve readability.

On Tue, 2023-04-04 at 13:22 +0800, Feng Tang wrote:
>=20
> +
> +False sharing could easily happen unless they are intentionally
> +checked, and it is valuable to run specific tools for performance
> +critical workloads to detect false sharing affecting performance case
> +and optimize accordingly.
> +
> +
> +How to detect and analysis False Sharing

s/analysis/analyse

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +  $ perf c2c record -ag sleep 3
> +  $ perf c2c report --call-graph none -k vmlinux
> +
> +When running above during testing will-it-scale's tlb_flush1 case,
> +perf reports something like::
> +
> +  Total records                     :    1658231
> +  Locked Load/Store Operations      :      89439
> +  Load Operations                   :     623219
> +  Load Local HITM                   :      92117
> +  Load Remote HITM                  :        139
> +
> +  #---------------------------------------------------------------------=
-
> +      4        0     2374        0        0        0  0xff1100088366d880
> +  #---------------------------------------------------------------------=
-
> +    0.00%   42.29%    0.00%    0.00%    0.00%    0x8     1       1  0xff=
ffffff81373b7b         0       231       129     5312        64  [k] __mod_=
lruvec_page_state    [kernel.vmlinux]  memcontrol.h:752   1
> +    0.00%   13.10%    0.00%    0.00%    0.00%    0x8     1       1  0xff=
ffffff81374718         0       226        97     3551        64  [k] folio_=
lruvec_lock_irqsave  [kernel.vmlinux]  memcontrol.h:752   1
> +    0.00%   11.20%    0.00%    0.00%    0.00%    0x8     1       1  0xff=
ffffff812c29bf         0       170       136      555        64  [k] lru_ad=
d_fn                 [kernel.vmlinux]  mm_inline.h:41     1
> +    0.00%    7.62%    0.00%    0.00%    0.00%    0x8     1       1  0xff=
ffffff812c3ec5         0       175       108      632        64  [k] releas=
e_pages              [kernel.vmlinux]  mm_inline.h:41     1
> +    0.00%   23.29%    0.00%    0.00%    0.00%   0x10     1       1  0xff=
ffffff81372d0a         0       234       279     1051        64  [k] __mod_=
memcg_lruvec_state   [kernel.vmlinux]  memcontrol.c:736   1
> +
> +A nice introduction for perf-c2c is [3]_.
> +
> +'pahole' decodes data structure layouts delimited in cache line
> +granularity.  Users can match the offset in perf-c2c output with
> +pahole's decoding to locate the exact data members.  For global
> +data, users can search the data address in System.map.
> +
> +
> +Possible Mitigations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +False sharing does not always need to be mitigated.  False sharing
> +mitigations need to balance performance gains with complexity and

s/need to/should/

> +space consumption.  Sometimes, lower performance is OK, and it's
> +unnecessary to hyper-optimize every rarely used data structure or
> +a cold data path.
> +
> +False sharing hurting performance cases are seen more frequently with
> +core count increasing.  Because of these detrimental effects, many
> +patches have been proposed across variety of subsystems (like
> +networking and memory management) and merged.  Some common mitigations
> +(with examples) are:
> +
> +* Separate hot global data in its own dedicated cache line, even if it
> +  is just a 'short' type. The downside is more consumption of memory,
> +  cache line and TLB entries.
> +
> +  - Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_soc=
kets_allocated")
> +
> +* Reorganize the data structure, separate the interfering members to
> +  different cache lines.  One downside is it may introduce new false
> +  sharing of other members.
> +
> +  - Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduc=
e false sharing")
> +
> +* Replace 'write' with 'read' when possible, especially in loops.
> +  Like for some global variable, use compare(read)-then-write instead
> +  of unconditional write. For example, use::
> +
> +	if (!test_bit(XXX))
> +		set_bit(XXX);
> +
> +  instead of directly "set_bit(XXX);", similarly for atomic_t data::
> +
> +	if (atomic_read(XXX) =3D=3D AAA)
> +		atomic_set(XXX, BBB);
> +
> +  - Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() m=
ultithreaded CPU false sharing")
> +  - Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> +
> +* Turn hot global data to 'per-cpu data + global data' when possible,
> +  or reasonably increase the threshold for syncing per-cpu data to
> +  global data, to reduce or postpone the 'write' to that global data.
> +
> +  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_status ca=
che hits/misses")
> +  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to =
vm overcommit policy")
> +
> +Surely, all mitigations should be carefully verified to not cause side
> +effects.  And to avoid false sharing in advance during coding, it's

Maybe say
To avoid introducing false sharing when coding

> +better to:
> +
> +* Be aware of cache line boundaries
> +* Group mostly read-only fields together
> +* Group things that are written at the same time together
> +* Separate known read-mostly and written-mostly fields

Separate frequently read and frequently written fields on different cache l=
ines

> +
> +and better add a comment stating the false sharing consideration.
> +
> +One note is, sometimes even after a severe false sharing is detected
> +and solved, the performance may still have no obvious improvement as
> +the hotspot switches to a new place.
> +
> +
> +Miscellaneous
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +One open issue is that kernel has an optional data structure
> +randomization mechanism, which also randomizes the situation of cache
> +line sharing of data members.
> +
> +
> +.. [1] https://en.wikipedia.org/wiki/False_sharing
> +.. [2] https://lore.kernel.org/lkml/CAHk-=3DwhoqV=3DcX5VC80mmR9rr+Z+yQ6f=
iQZm36Fb-izsanHg23w@mail.gmail.com/
> +.. [3] https://joemario.github.io/blog/2016/09/01/c2c-blog/
> diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kerne=
l-hacking/index.rst
> index f53027652290..79c03bac99a2 100644
> --- a/Documentation/kernel-hacking/index.rst
> +++ b/Documentation/kernel-hacking/index.rst
> @@ -9,3 +9,4 @@ Kernel Hacking Guides
> =20
>     hacking
>     locking
> +   false-sharing

Thanks.

Tim

