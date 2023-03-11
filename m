Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506836B56CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCKAjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCKAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:39:46 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00889A7A85;
        Fri, 10 Mar 2023 16:39:44 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id nf5so4769527qvb.5;
        Fri, 10 Mar 2023 16:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjMkQjLCZ3BM2pNDIMhhzn6RH1drrsuj6qqHGDBUAzk=;
        b=jtiDqd+qPHutJBoQQIOHT2/Oyc2PEH/Q6mnOAT3ZjBQ28OVYkAxk+xA5cbwgo9/veZ
         BkadPXFACr4ZN3DsCmjDBO2wHo+og5UALJd+uihDisNpoDgfgNtFXPRZKhHahlSLHYNS
         hBJQXlo0p4QwpvO4PVGzb7h39+QE1iIENJNk4jx2Fve78xIbjiS0zvqPRLjSTMSZF/5T
         /7oqDSVrjEh7Nf6Gi+1476WFojlQA52Et9pjesfmTe5VoRU2bnIOZyLCrXhCTQIxmMQe
         C79LD65c3E84ihUhkt9plWzh5lpbdAPBj8qsc6e2iVygcyk58AToLiuFPB9fHPQo7F2R
         vNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjMkQjLCZ3BM2pNDIMhhzn6RH1drrsuj6qqHGDBUAzk=;
        b=TulhwXCXWz4g4RXe4TrM3VMwyUva2xsqew4dQ7/yZStFcFIKDWbGG6RQUSdifGJt1s
         p0Tq/wirwCPYQV8CR8FxS+O5yQ7+3VazS+erajSks4tqRa8myK5mpMY4kAH9uneErkr6
         CX+qID87eeCxTEqBduPh5x039yTb94VyJn7oMDty8rZJjXef9I2VowVIAMi3kUAoAzPx
         o6mtdYgsXnlIdmYZFR5NR+m+yn9QVdQwEWk2fQybqrdZt1NffpJ9FVxhvQ6+jkc1pOMp
         3PoWYd6f80d7yD5qJpz13RjCIdW5ihPbwBsMpickzBaHzwi7C0g1WmkSDTnkDMHjXYQP
         nNog==
X-Gm-Message-State: AO0yUKUn7roGl8ura6vGlDy8UB+PHQZk0y8sXr3ykXFlPz+E3Urma0DZ
        /woROn/BGXK0bHbFygmVfPQ=
X-Google-Smtp-Source: AK7set+pQM1vnDRcOz+8Pij0IfR3x7JLodqa9NsJXDenx8+mqfQxfsGld8U6lz/gHQf01tVDbQuAxg==
X-Received: by 2002:a05:6214:226b:b0:56e:a5ea:1450 with SMTP id gs11-20020a056214226b00b0056ea5ea1450mr1909709qvb.6.1678495183915;
        Fri, 10 Mar 2023 16:39:43 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:39:43 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 0/9] mm: introduce Designated Movable Blocks
Date:   Fri, 10 Mar 2023 16:38:46 -0800
Message-Id: <20230311003855.645684-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is essentially a resubmission of v3 rebased with a
rewritten cover letter to hopefully clarify the submission based
on feedback and follow-on discussion. The individual patches
have not materially changed.

The Linux Memory Management system (MM) has long supported the
concept of movable memory. It takes advantage of address
abstraction to allow the data held in physical memory to be
moved to a different physical address or other form of storage
without the user of the abstracted (i.e. virtual) address
needing to be aware. This is generally the foundation of user
space memory and the basic service the kernel provides to
applications.

On the other hand, the kernel itself is generally not tolerant
of the movement of data that it accesses so most of its usage is
unmovable memory. It may be useful to understand that this
terminology is relative to the kernel's perspective and that
what the kernel considers unmovable memory may in fact be moved
by a hypervisor that hosts the kernel, but an additional address
abstraction must exist to keep the kernel unaware of such
movement.

The MM supports the conversion of free memory between MOVABLE
and UNMOVABLE (and other) migration types to allow better
sharing of memory resources. More recently, the MM introduced
"movablecore" memory that should never be made UNMOVABLE. As an
implementation detail "movablecore" memory introduced the
ZONE_MOVABLE zone to manage this type of memory and significant
progress has been made to ensure the movability of memory in
this zone with the few exceptions now documented in
include/linux/mmzone.h.

"Movablecore" memory can support multiple use cases including
dynamic allocation of hugetlbfs pages, but an imbalance of
"movablecore" memory and kernel memory can lead to serious
consequences for kernel operation which is why the kernel
parameter includes the warning "the administrator must be
careful that the amount of memory usable for all allocations is
not too small."

Designated Movable Blocks represent a generic extension of the
"movablecore" concept to allow specific blocks of memory to be
designated part of the "movablecore" to provide support for
additional use cases. For example, it could have been/could
still be used to support hot unplugging of memory. A very
similar concept was proposed in [1] for that purpose, and
revised in [2], but ultimately a more use case specific
implementation of the movable_node parameter was accepted. That
implementation is dependent on NUMA, ACPI, and SRAT tables which
narrow its usefullness. Designated Movable Blocks allow for the
same type of discontiguous and non-monotonic configuration of
ZONE_MOVABLE for systems whether or not they support NUMA, ACPI,
or SRAT tables. Specifically this feature is desired by users of
the arm64 Android GKI common kernel on Broadcom SoCs where NUMA
is not available. These patches make minimal additions to
existing code to offer a controllable "movablecore" feature to
those systems.

Like all "movablecore" memory there are no Designated Movable
Blocks created by default. They are only created when specified
and the warning on the "movablecore" kernel parameter remains
just as relevant.

The key feature of "movablecore" memory is that any allocations
of the memory by the kernel page allocator must be movable and
this has the follow-on effect that GFP_MOVABLE allocation
requests look to "movablecore" memory first. This prioritizes
the use of "movablecore" memory by user processes though the
kernel can conceivably use the memory as long as movability can
be preserved.

One use case of interest to customers of Broadcom SoCs with
multiple memory controllers is for improved memory bandwidth
utilization for multi-threaded user space dominant workloads.
Designated Movable Blocks can be located on each memory
controller and the page_alloc.shuffle=1 kernel parameter can be
applied to provide a simplistic software-based memory channel
interleaving of accesses from user space across the multiple
memory controllers. Experiments using this approach with a dummy
workload [3] on a BCM7278 dual memory controller system with 1GB
of RAM on each controller (i.e. 2GB total RAM) and using the
kernel parameters "movablecore=300M@0x60000000,300M@0x320000000
page_alloc.shuffle=1" showed a more than 20% performance
improvement over a system without this feature using either
"movablecore=600M" or no "movablecore" kernel parameter.

Another use case of interest is to add broader support for the
"reusable" parameter for reserved-memory device tree nodes. The
Designated Movable Block extension of movablecore would allow
designation of the location as well as ownership of the block.
A device driver that owns a reusable reserved-memory would own
the underlying portion of a Designated Movable Block and could
reclaim memory from the OS for use exclusively by the device on
demand in a manner similar to memory hot unplugging. The
existing alloc/free_contig_range functions could be used to
support this or a different API could be developed. This use
case is mentioned for consideration, but an implementation is
not part of this submission.

There have also been efforts to reduce the amounts of memory
CMA holds in reserve (e.g. [4]). Adding the ability to place a
CMA pool in a Designated Movable Block could offer an option to
improve memory utilization when increased allocation latency can
be tolerated, but again such an implementation is not part of
this submission.

Changes in v4:
  - rewrote the cover letter in an attempt to provide clarity
    and encourage review.
  - rebased to akpm-mm/master (i.e. Linux 6.3-rc1).

Changes in v3:
  - removed OTHER OPPORTUNITIES and NOTES from the cover letter.
  - prevent the creation of empty zones instead of adding extra
    info to zoneinfo.
  - size the ZONE_MOVABLE span to the minimum necessary to cover
    pages within the zone to be more intuitive.
  - removed "real" from variable names that were consolidated.
  - rebased to akpm-mm/master (i.e. Linux 6.1-rc1).

Changes in v2:
  - first three commits upstreamed separately.
  - commits 04-06 submitted separately.
  - Corrected errors "Reported-by: kernel test robot <lkp@intel.com>"
  - Deferred commits after 15 to simplify review of the base
    functionality.
  - minor reorganization of commit 13.

v3: https://lore.kernel.org/lkml/20221020215318.4193269-1-opendmb@gmail.com/
v2: https://lore.kernel.org/linux-mm/20220928223301.375229-1-opendmb@gmail.com/ 
v1: https://lore.kernel.org/linux-mm/20220913195508.3511038-1-opendmb@gmail.com/

[1] https://lwn.net/Articles/543790/
[2] https://lore.kernel.org/all/1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com/
[3] https://lore.kernel.org/lkml/342da4ea-d04a-996c-85c4-3065dd4dc01f@gmail.com/
[4] https://lore.kernel.org/linux-mm/20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com/

Doug Berger (9):
  lib/show_mem.c: display MovableOnly
  mm/page_alloc: calculate node_spanned_pages from pfns
  mm/page_alloc: prevent creation of empty zones
  mm/page_alloc.c: allow oversized movablecore
  mm/page_alloc: introduce init_reserved_pageblock()
  memblock: introduce MEMBLOCK_MOVABLE flag
  mm/dmb: Introduce Designated Movable Blocks
  mm/page_alloc: make alloc_contig_pages DMB aware
  mm/page_alloc: allow base for movablecore

 .../admin-guide/kernel-parameters.txt         |  14 +-
 include/linux/dmb.h                           |  29 +++
 include/linux/gfp.h                           |   5 +-
 include/linux/memblock.h                      |   8 +
 lib/show_mem.c                                |   2 +-
 mm/Kconfig                                    |  12 ++
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |  15 +-
 mm/dmb.c                                      |  91 +++++++++
 mm/memblock.c                                 |  30 ++-
 mm/page_alloc.c                               | 188 +++++++++++++-----
 11 files changed, 338 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/dmb.h
 create mode 100644 mm/dmb.c

-- 
2.34.1

