Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C7E6B0328
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCHJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCHJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:41:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF2B1A58
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CF10B81BC0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22927C433D2;
        Wed,  8 Mar 2023 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268480;
        bh=tV1FkJmvvpLgLM/QVfb5MeuZc5NoN8LYwUl9QsKCPEM=;
        h=From:To:Cc:Subject:Date:From;
        b=QsK0Ah8vYMUaBAVEWBHTAByeMxqN8AED6Vctltmgg4DdiRrGhICj22ZsmQZ28UaqU
         fUoo0Z6AAa0aWV/6X9Hpk8mvJef8U2s4U0dLe31SpYFp3NviCP/qVf0mNeZpldbz8B
         07P/S7uG823gJOI7piHUGfUdpmycRDjOJzOmFDDXFaKO1i3FkyOwW3RunOGCK0fqYr
         5A+H6m6PewKo0LdSi7GtmeDX6Q9pvVy1jxwF4zP8HwsdADo15F1ehwSkk3Q7JZDfEB
         jU7BP52PxzOS4275O8JYC1Ocgml1d7AsRgWaAmMeT7LS5DYiUgbCUYiqd0mKUVxUPq
         Wg4WMMgpeeWWg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 0/5] Prototype for direct map awareness in page allocator
Date:   Wed,  8 Mar 2023 11:41:01 +0200
Message-Id: <20230308094106.227365-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

This is a third attempt to make page allocator aware of the direct map
layout and allow grouping of the pages that must be unmapped from
the direct map.

This a new implementation of __GFP_UNMAPPED, kinda a follow up for this set:

https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org

but instead of using a migrate type to cache the unmapped pages, the
current implementation adds a dedicated cache to serve __GFP_UNMAPPED
allocations.

The last two patches in the series demonstrate how __GFP_UNMAPPED can be
used in two in-tree use cases.

First one is to switch secretmem to use the new mechanism, which is
straight forward optimization.

The second use-case is to enable __GFP_UNMAPPED in x86::module_alloc()
that is essentially used as a method to allocate code pages and thus
requires permission changes for basic pages in the direct map.

This set is x86 specific at the moment because other architectures either
do not support set_memory APIs that split the direct^w linear map (e.g.
PowerPC) or only enable set_memory APIs when the linear map uses basic page
size (like arm64).

The patches are only lightly tested.

== Motivation ==

There are use-cases that need to remove pages from the direct map or at
least map them with 4K granularity. Whenever this is done e.g. with
set_memory/set_direct_map APIs, the PUD and PMD sized mappings in the
direct map are split into smaller pages.

To reduce the performance hit caused by the fragmentation of the direct map
it makes sense to group and/or cache the pages removed from the direct
map so that the split large pages won't be all over the place. 

There were RFCs for grouped page allocations for vmalloc permissions [1]
and for using PKS to protect page tables [2] as well as an attempt to use a
pool of large pages in secretmtm [3], but these suggestions address each
use case separately, while having a common mechanism at the core mm level
could be used by all use cases.

== Implementation overview ==

The pages that need to be removed from the direct map are grouped in a
dedicated cache. When there is a page allocation request with
__GFP_UNMAPPED set, it is redirected from __alloc_pages() to that cache
using a new unmapped_alloc() function.

The cache is implemented as a buddy allocator and it can handle high order
requests.

The cache starts empty and whenever it does not have enough pages to
satisfy an allocation request the cache attempts to allocate PMD_SIZE page
to replenish the cache. If PMD_SIZE page cannot be allocated, the cache is
replenished with a page of the highest order available. That page is
removed from the direct map and added to the local buddy allocator.

There is also a shrinker that releases pages from the unmapped cache when
there us a memory pressure in the system. When shrinker releases a page it
is mapped back into the direct map.

[1] https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com
[2] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com
[3] https://lore.kernel.org/lkml/20210121122723.3446-8-rppt@kernel.org

Mike Rapoport (IBM) (5):
  mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
  mm/unmapped_alloc: add debugfs file similar to /proc/pagetypeinfo
  mm/unmapped_alloc: add shrinker
  EXPERIMENTAL: x86: use __GFP_UNMAPPED for modele_alloc()
  EXPERIMENTAL: mm/secretmem: use __GFP_UNMAPPED

 arch/x86/Kconfig                |   3 +
 arch/x86/kernel/module.c        |   2 +-
 include/linux/gfp_types.h       |  11 +-
 include/linux/page-flags.h      |   6 +
 include/linux/pageblock-flags.h |  28 +++
 include/trace/events/mmflags.h  |  10 +-
 mm/Kconfig                      |   4 +
 mm/Makefile                     |   1 +
 mm/internal.h                   |  24 +++
 mm/page_alloc.c                 |  39 +++-
 mm/secretmem.c                  |  26 +--
 mm/unmapped-alloc.c             | 334 ++++++++++++++++++++++++++++++++
 mm/vmalloc.c                    |   2 +-
 13 files changed, 459 insertions(+), 31 deletions(-)
 create mode 100644 mm/unmapped-alloc.c


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.35.1

