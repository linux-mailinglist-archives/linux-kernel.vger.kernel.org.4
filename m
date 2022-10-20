Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797F606A86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJTVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJTVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F596438;
        Thu, 20 Oct 2022 14:54:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a18so924518qko.0;
        Thu, 20 Oct 2022 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJV3aFcijl0Rz0XlRnZF5dclSHM+OiKYXagTECOXWUs=;
        b=mhSDba1z9+BM+IWhMevt2Zop1ZxgI5vtmX5lEIxyybt5IFnrl63bEj9L06UWGe4Qyj
         Xh/VFcCdOIlTEXPIAuLMElK/9X2NLL8Xzxgxx0JErorvkGNAIpD6am2MMcie+7j5b5vO
         f1MRedrX5cqtmrOkuu8sxdcuN0Hwe6AP38s1kkny9SdIMjdyEfTXrbkZ6bO8KyxtESCx
         Mkt9SAKXBXsE89tXA+vISzKSht45tmKyLvFcnC2QPmatgyY3BBRkC/Fc+BNFns+IuIDL
         f3NjTc8DIXlDssWaLdR05AHBxi1y/lzgM+XYwxZOBTzai43oKzRsI7ysCjgZ6PHgXyRN
         rT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJV3aFcijl0Rz0XlRnZF5dclSHM+OiKYXagTECOXWUs=;
        b=pjCUd8U4AsJ6E2akOt5hGNNNTOQcCQIczpckBC0VrzwKC0rgjqrdQk7zAzIO5PRNqZ
         CJe8X4FHeHqT6LLL5P9UEjmRBFxWhVeAidoIL/hB7DYkGTOzbSNP/ZpyG6S2ss/J1c+a
         PIHGb0oQ8I1AKTqn6QswFNU7/uQYxckVmJGQ2iWju3B1ALlq3fRSGSEHyjKN1cixb6od
         e/Sk/iM16Hg4D3ynBFQZp4zIhcp+wC1zmq1VxYBvjk7zQXaTg3q0iEJEntvmy8U/Twwz
         P+FbEy6Wt4aaccezy1hDbI9AkRCVJucg8b3r+8E3hKhFqCV7jMcH8DQEfHMYfVoo1IGp
         0DfA==
X-Gm-Message-State: ACrzQf3NuhvHoeQH4MMUWGm+7fUKKeehmkf+T48WnMV9XaT41o7wmYOO
        5subbbPsrD3qCOZvkEZyQC8=
X-Google-Smtp-Source: AMsMyM7xID6F9ahsV93JiJpkQl+rEA4HCAjdi0ex+QQUchYb7mrjkbkktbo/sbZ+jGyVQLZZ2jhgBQ==
X-Received: by 2002:a05:620a:2697:b0:6cf:33cd:2bd2 with SMTP id c23-20020a05620a269700b006cf33cd2bd2mr11114790qkp.341.1666302861044;
        Thu, 20 Oct 2022 14:54:21 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:20 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
Date:   Thu, 20 Oct 2022 14:53:09 -0700
Message-Id: <20221020215318.4193269-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOTIVATION:
Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
controllers with each mapped in a different address range within
a Uniform Memory Architecture. Some users of these systems have
expressed the desire to locate ZONE_MOVABLE memory on each
memory controller to allow user space intensive processing to
make better use of the additional memory bandwidth.
Unfortunately, the historical monotonic layout of zones would
mean that if the lowest addressed memory controller contains
ZONE_MOVABLE memory then all of the memory available from
memory controllers at higher addresses must also be in the
ZONE_MOVABLE zone. This would force all kernel memory accesses
onto the lowest addressed memory controller and significantly
reduce the amount of memory available for non-movable
allocations.

The main objective of this patch set is therefore to allow a
block of memory to be designated as part of the ZONE_MOVABLE
zone where it will always only be used by the kernel page
allocator to satisfy requests for movable pages. The term
Designated Movable Block is introduced here to represent such a
block. The favored implementation allows extension of the
'movablecore' kernel parameter to allow specification of a base
address and support for multiple blocks. The existing
'movablecore' mechanisms are retained.

BACKGROUND:
NUMA architectures support distributing movablecore memory
across each node, but it is undesirable to introduce the
overhead and complexities of NUMA on systems that don't have a
Non-Uniform Memory Architecture.

Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror option")
also depends on zone overlap to support sytems with multiple
mirrored ranges.

Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
embraced overlapped zones for memory hotplug.

This commit set follows their lead to allow the ZONE_MOVABLE
zone to overlap other zones. Designated Movable Blocks are made
absent from overlapping zones and present within the
ZONE_MOVABLE zone.

I initially investigated an implementation using a Designated
Movable migrate type in line with comments[1] made by Mel Gorman
regarding a "sticky" MIGRATE_MOVABLE type to avoid using
ZONE_MOVABLE. However, this approach was riskier since it was
much more instrusive on the allocation paths. Ultimately, the
progress made by the memory hotplug folks to expand the
ZONE_MOVABLE functionality convinced me to follow this approach.

Changes in v3:
  - removed OTHER OPPORTUNITIES and NOTES from this cover letter.
  - prevent the creation of empty zones instead of adding extra
    info to zoneinfo.
  - size the ZONE_MOVABLE span to the minimum necessary to cover
    pages within the zone to be more intuitive.
  - removed "real" from variable names that were consolidated.
  - rebased to akpm-mm/master (i.e. Linux 6.1-rc1).

Changes in v2:
  - first three commits upstreamed separately [3], [4], and [5].
  - commits 04-06 submitted separately [6].
  - Corrected errors "Reported-by: kernel test robot <lkp@intel.com>"
  - Deferred commits after 15 to simplify review of the base
    functionality.
  - minor reorganization of commit 13.

v2: https://lore.kernel.org/linux-mm/20220928223301.375229-1-opendmb@gmail.com/ 
v1: https://lore.kernel.org/linux-mm/20220913195508.3511038-1-opendmb@gmail.com/

[1] https://lore.kernel.org/lkml/20160428103927.GM2858@techsingularity.net/
[2] https://lore.kernel.org/lkml/1401260672-28339-1-git-send-email-iamjoonsoo.kim@lge.com
[3] https://lore.kernel.org/linux-mm/20220914023913.1855924-1-zi.yan@sent.com
[4] https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com
[5] https://lore.kernel.org/linux-mm/20220914190917.3517663-1-opendmb@gmail.com
[6] https://lore.kernel.org/linux-mm/20220921223639.1152392-1-opendmb@gmail.com/

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
2.25.1

