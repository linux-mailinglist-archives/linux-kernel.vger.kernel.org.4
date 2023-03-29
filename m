Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1996CD36D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjC2HjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjC2Hiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:38:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08ADCF;
        Wed, 29 Mar 2023 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680075525; x=1711611525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Li8d29ySqCLKIqGgxErtvFLhyCGdQ+XDDt5ITItivdI=;
  b=lz8qU5BwyeTEP67Od1vKeb+qFQvTQFCVy3X8zZzkO1AV+5xUBQl1VCWm
   LC01i1uFBEC7iyknhh3oyJNvRYtpjJqksJZNdJAun0f0YC8Ehd8OwZo2A
   BaIBcyVU01wapookYogsbud9jiRgyGA/Sxc1sMbwNv1/O1+URGWbtfIM5
   LbVyVkJ9tzh/80/ZmCKmBFIpFP+r9BUBdRotdJ63LO20luXT3sqTiopiq
   3DykNRWN0vYhzfWTT5iF7NmUyXdozA1UxPIKFPwqiupV7+W7IE7/ZEq49
   SW80OsEvmUgl1WWD5NXQQAdV3uiPrGJbtgtaKCSknBcD4zr4buZA26tVk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324708312"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="324708312"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634381777"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="634381777"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 00:38:39 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] Documentation: Add document for false sharing
Date:   Wed, 29 Mar 2023 15:33:22 +0800
Message-Id: <20230329073322.323177-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing performance tuning or debugging performance regressions,
more and more cases are found to be related to false sharing [1][2],
and the situation can be worse for newer platforms with hundreds of
CPUs. There are already many commits in current kernel specially
for mitigating the performance degradation due to false sharing.

False sharing could harm the performance silently without being
noticed, due to reasons like:
* data members of a big data structure randomly sitting together
  in one cache line
* global data of small size are linked compactly together

So it's better to make a simple document about the normal pattern
of false sharing, basic ways to mitigate it and call out to
developers to pay attention during code-writing.

[ Many thanks to Dave Hansen, Ying Huang, Tim Chen, Julie Du and
  Yu Chen for their contributions ]

[1]. https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9020/
[2]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/

Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
Changelog:

  since v1:
  * Refine the wording and grammer (Bagas Sanjaya)
  * Add Reviewed-by tag from Randy Dunlap
  * Fix a line wrap problem for 'make htmldocs'

  since RFC:
  * Reword paragraphs with grammar issues; fixes many format and
    typo issues (Randy Dunlap)


 .../kernel-hacking/false-sharing.rst          | 202 ++++++++++++++++++
 Documentation/kernel-hacking/index.rst        |   1 +
 2 files changed, 203 insertions(+)
 create mode 100644 Documentation/kernel-hacking/false-sharing.rst

diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
new file mode 100644
index 000000000000..ceeaf20290ea
--- /dev/null
+++ b/Documentation/kernel-hacking/false-sharing.rst
@@ -0,0 +1,202 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+False Sharing
+=============
+
+What is False Sharing
+=====================
+False sharing is related with cache mechanism of maintaining the data
+coherence of one cache line stored in multiple CPU's caches; then
+academic definition for it is in [1]_. Consider a struct with a
+refcount and a string::
+
+	struct foo {
+		refcount_t refcount;
+		...
+		char name[16];
+	} ____cacheline_internodealigned_in_smp;
+
+Member 'refcount'(A) and 'name'(B) _share_ one cache line like below::
+
+                +-----------+                     +-----------+
+                |   CPU 0   |                     |   CPU 1   |
+                +-----------+                     +-----------+
+               /                                        |
+              /                                         |
+             V                                          V
+         +----------------------+             +----------------------+
+         | A      B             | Cache 0     | A       B            | Cache 1
+         +----------------------+             +----------------------+
+                             |                  |
+  ---------------------------+------------------+-----------------------------
+                             |                  |
+                           +----------------------+
+                           |                      |
+                           +----------------------+
+              Main Memory  | A       B            |
+                           +----------------------+
+
+'refcount' is modified frequently, but 'name' is set once at object
+creation time and is never modified.  When many CPUs access 'foo' at
+the same time, with 'refcount' being only bumped by one CPU frequently
+and 'name' being read by other CPUs, all those reading CPUs have to
+reload the whole cache line over and over due to the 'sharing', even
+though 'name' is never changed.
+
+There are many real-world cases of performance regressions caused by
+false sharing.  One of these is a rw_semaphore 'mmap_lock' inside
+mm_struct struct, whose cache line layout change triggered a
+regression and Linus analyzed in [2]_.
+
+There are two key factors for a harmful false sharing:
+
+* A global datum accessed (shared) by many CPUs
+* In the concurrent accesses to the data, there is at least one write
+  operation: write/write or write/read cases.
+
+The sharing could be from totally unrelated kernel components, or
+different code paths of the same kernel component.
+
+
+False Sharing Pitfalls
+======================
+Back in time when one platform had only one or a few CPUs, hot data
+members could be purposely put in the same cache line to make them
+cache hot and save cacheline/TLB, like a lock and the data protected
+by it.  But for recent large system with hundreds of CPUs, this may
+not work when the lock is heavily contended, as the lock owner CPU
+could write to the data, while other CPUs are busy spinning the lock.
+
+Looking at past cases, there are several frequently occurring patterns
+for false sharing:
+
+* lock (spinlock/mutex/semaphore) and data protected by it are
+  purposely put in one cache line.
+* global data being put together in one cache line. Some kernel
+  subsystems have many global parameters of small size (4 bytes),
+  which can easily be grouped together and put into one cache line.
+* data members of a big data structure randomly sitting together
+  without being noticed (cache line is usually 64 bytes or more),
+  like struct 'mem_cgroup'.
+
+Following 'mitigation' section provides real-world examples.
+
+False sharing could easily happen unless they are intentionally
+checked, and it is valuable to run specific tools for performance
+critical workloads to detect false sharing affecting performance case
+and optimize accordingly.
+
+
+How to detect and analysis False Sharing
+========================================
+perf record/report/stat are widely used for performance tuning, and
+once hotspots are detected, tools like 'perf-c2c' and 'pahole' can
+be further used to detect and pinpoint the possible false sharing
+data structures.  'addr2line' is also good at decoding instruction
+pointer when there are multiple layers of inline functions.
+
+perf-c2c can capture the cache lines with most false sharing hits,
+decoded functions (line number of file) accessing that cache line,
+and in-line offset of the data. Simple commands are::
+
+  $ perf c2c record -ag sleep 3
+  $ perf c2c report --call-graph none -k vmlinux
+
+When running above during testing will-it-scale's tlb_flush1 case,
+perf reports something like::
+
+  Total records                     :    1658231
+  Locked Load/Store Operations      :      89439
+  Load Operations                   :     623219
+  Load Local HITM                   :      92117
+  Load Remote HITM                  :        139
+
+  #----------------------------------------------------------------------
+      4        0     2374        0        0        0  0xff1100088366d880
+  #----------------------------------------------------------------------
+    0.00%   42.29%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81373b7b         0       231       129     5312        64  [k] __mod_lruvec_page_state    [kernel.vmlinux]  memcontrol.h:752   1
+    0.00%   13.10%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81374718         0       226        97     3551        64  [k] folio_lruvec_lock_irqsave  [kernel.vmlinux]  memcontrol.h:752   1
+    0.00%   11.20%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c29bf         0       170       136      555        64  [k] lru_add_fn                 [kernel.vmlinux]  mm_inline.h:41     1
+    0.00%    7.62%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c3ec5         0       175       108      632        64  [k] release_pages              [kernel.vmlinux]  mm_inline.h:41     1
+    0.00%   23.29%    0.00%    0.00%    0.00%   0x10     1       1  0xffffffff81372d0a         0       234       279     1051        64  [k] __mod_memcg_lruvec_state   [kernel.vmlinux]  memcontrol.c:736   1
+
+A nice introduction for perf-c2c is [3]_.
+
+'pahole' decodes data structure layouts delimited in cache line
+granularity.  Users can match the offset in perf-c2c output with
+pahole's decoding to locate the exact data members.  For global
+data, users can search the data address in System.map.
+
+
+Possible Mitigations
+====================
+False sharing does not always need to be mitigated.  False sharing
+mitigations need to balance performance gains with complexity and
+space consumption.  Sometimes, lower performance is OK, and it's
+unnecessary to hyper-optimize every rarely used data structure or
+a cold data path.
+
+False sharing hurting performance cases are seen more frequently with
+core count increasing.  Because of these detrimental effects, many
+patches have been proposed across variety of subsystems (like
+networking and memory management) and merged.  Some common mitigations
+(with examples) are:
+
+* Separate hot global data in its own dedicated cache line, even if it
+  is just a 'short' type. The downside is more consumption of memory,
+  cache line and TLB entries.
+
+  - Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_allocated")
+
+* Reorganize the data structure, separate the interfering members to
+  different cache lines.  One downside is it may introduce new false
+  sharing of other members.
+
+  - Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce false sharing")
+
+* Replace 'write' with 'read' when possible, especially in loops.
+  Like for some global variable, use compare(read)-then-write instead
+  of unconditional write. For example, use::
+
+	if (!test_bit(XXX))
+		set_bit(XXX);
+
+  instead of directly "set_bit(XXX);", similarly for atomic_t data.
+
+  - Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
+  - Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
+
+* Turn hot global data to 'per-cpu data + global data' when possible,
+  or reasonably increase the threshold for syncing per-cpu data to
+  global data, to reduce or postpone the 'write' to that global data.
+
+  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
+  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
+
+Surely, all mitigations should be carefully verified to not cause side
+effects.  And to avoid false sharing in advance during coding, it's
+better to:
+
+* Be aware of cache line boundaries
+* Group mostly read-only fields together
+* Group things that are written at the same time together
+* Separate known read-mostly and written-mostly fields
+
+and better add a comment stating the false sharing consideration.
+
+One note is, sometimes even after a severe false sharing is detected
+and solved, the performance may still have no obvious improvement as
+the hotspot switches to a new place.
+
+
+Miscellaneous
+=============
+One open issue is that kernel has an optional data structure
+randomization mechanism, which also randomizes the situation of cache
+line sharing of data members.
+
+
+.. [1] https://en.wikipedia.org/wiki/False_sharing
+.. [2] https://lore.kernel.org/lkml/CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com/
+.. [3] https://joemario.github.io/blog/2016/09/01/c2c-blog/
diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kernel-hacking/index.rst
index f53027652290..79c03bac99a2 100644
--- a/Documentation/kernel-hacking/index.rst
+++ b/Documentation/kernel-hacking/index.rst
@@ -9,3 +9,4 @@ Kernel Hacking Guides
 
    hacking
    locking
+   false-sharing
-- 
2.34.1

