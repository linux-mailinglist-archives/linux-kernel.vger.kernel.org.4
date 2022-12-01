Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7863FAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLAWjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLAWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D7C82E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m62-20020a25d441000000b006f1ccc0feffso3158314ybf.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RPWNRTuoWbXrgp1NH21gGXYAfKzjIgMXeMXTZovdDMA=;
        b=lmtKLlPjebbfKByTuieVcEJBX5tuEPkQ2m1E2LeiVqWO3nelYE4fnv3ZWFRCcfN9g3
         96rUXW/DxohZ7XiYeWd4rzDQ4E2s+OHGB+UxDT1EQBRecfhKlxJVpmeg+DntEarZ/Uv3
         mlcSYBdlbEaiD9lnfjqKydqJuC+2pOLyuBhaGam9/4jtSAC8EU0e7ftldaVPzbsk8Lzz
         rp1zurujhSz22TMG8ldq6QVJJ2RSiYv2A95JD3ggQ2BnfhPMKiTx7emUSmiu6mqS/uhG
         3Y0a2bf+g9RiCpt8c+MTGg1jsehgNeQXgGsCXVInIIeULxgK8TDxxQmO+CrQWmVeN+1n
         P43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPWNRTuoWbXrgp1NH21gGXYAfKzjIgMXeMXTZovdDMA=;
        b=dsbSYa6QrsLGA6a+KJu0vzw94f2Ckykthk1GXqd5MXT7ApqdOSiqxzd4ufMJ9Tx7E1
         YuWDzyg9eHThAReXNkD6wtm3T/pda/nAtfeUkIrFN+VR5fHyrkRFhLow9H+Typgkr5eb
         sr8Ny0wXghesn6EqMUlY+TF8BI/bPAsXbfxKL2lrk6VVnO3REWL84HySor5Arqpzp/gV
         B30SoFo9nUcQp5WZKbsauHtQX2N4TYcy6IZVIaWdKS9kUYl/Vwoe6HE7tKgvInMfwRL9
         fiUmu2aKy/3raxkJOOIzu2Q2vYIGWvaVm+y0u3V5p5XrY2V1QgHiPGGlAq3Xf0zZkpeW
         HRSQ==
X-Gm-Message-State: ANoB5pl5xSzVTppiZjKEuKKdmWLwlQR2xC0urESlVueu9VJmrGxBeNGf
        3zquqS7tj+3NuCmp+TY7EBGvuX7uxEY=
X-Google-Smtp-Source: AA0mqf6hXnZSM59G1ecGPfl3B/OMjB4+qhluE+MVfphFLbsfMy9iYqnPHkcJmDKaYQ1vxuDpH+3GJiDPBFc=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a0d:da82:0:b0:3ac:a266:951f with SMTP id
 c124-20020a0dda82000000b003aca266951fmr44307316ywe.39.1669934379919; Thu, 01
 Dec 2022 14:39:39 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:16 -0700
Message-Id: <20221201223923.873696-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 0/8] mm: multi-gen LRU: memcg LRU
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An memcg LRU is a per-node LRU of memcgs. It is also an LRU of LRUs,
since each node and memcg combination has an LRU of folios (see
mem_cgroup_lruvec()).

Its goal is to improve the scalability of global reclaim, which is
critical to systemwide memory overcommit in data centers. Note that
memcg reclaim is currently out of scope.

Its memory bloat is a pointer to each LRU vector and negligible to
each node. In terms of traversing memcgs during global reclaim, it
improves the best-case complexity from O(n) to O(1) and does not
affect the worst-case complexity O(n). Therefore, on average, it has
a sublinear complexity in contrast to the current linear complexity.

The basic structure of an memcg LRU can be understood by an analogy
to the active/inactive LRU (of folios):
1. It has the young and the old (generations);
2. Its linked lists have the head and the tail;
3. The increment of max_seq triggers promotion;
4. Other events, e.g., offlining an memcg, triggers similar
   operations.

In terms of global reclaim, it has two distinct features:
1. Sharding, which allows each thread to start at a random memcg (in
   the old generation) and improves parallelism;
2. Eventual fairness, which allows direct reclaim to bail out and
   reduces latency without affecting fairness over some time.

The commit message in patch 6 details the workflow:
https://lore.kernel.org/r/20221201223923.873696-7-yuzhao@google.com/

The following is a simple test to quickly verify its effectiveness.
More benchmarks are coming soon.

  Test design:
  1. Create multiple memcgs.
  2. Each memcg contains a job (fio).
  3. All jobs access the same amount of memory randomly.
  4. The system does not experience global memory pressure.
  5. Periodically write to the root memory.reclaim.

  Desired outcome:
  1. All memcgs have similar pgsteal, i.e.,
     stddev(pgsteal)/mean(pgsteal) is close to 0%.
  2. The total pgsteal is close to the total requested through
     memory.reclaim, i.e., sum(pgsteal)/sum(requested) is close to
     100%.

  Actual outcome [1]:
             stddev(pgsteal)/mean(pgsteal) sum(pgsteal)/sum(requested)
  MGLRU off  75%                           425%
  MGLRU on   20%                           95%

  ####################################################################
  MEMCGS=128

  for ((memcg = 0; memcg < $MEMCGS; memcg++)); do
      mkdir /sys/fs/cgroup/memcg$memcg
  done

  start() {
      echo $BASHPID > /sys/fs/cgroup/memcg$memcg/cgroup.procs

      fio -name=memcg$memcg --numjobs=1 --ioengine=mmap \
          --filename=/dev/zero --size=1920M --rw=randrw \
          --rate=64m,64m --random_distribution=random \
          --fadvise_hint=0 --time_based --runtime=10h \
          --group_reporting --minimal
  }

  for ((memcg = 0; memcg < $MEMCGS; memcg++)); do
      start &
  done

  sleep 600

  for ((i = 0; i < 600; i++)); do
      echo 256m >/sys/fs/cgroup/memory.reclaim
      sleep 6
  done

  for ((memcg = 0; memcg < $MEMCGS; memcg++)); do
      grep "pgsteal " /sys/fs/cgroup/memcg$memcg/memory.stat
  done
  ####################################################################

[1]: This was obtained from running the above script (touches less
     than 256GB memory) on an EPYC 7B13 with 512GB DRAM for over an
     hour.

Yu Zhao (8):
  mm: multi-gen LRU: rename lru_gen_struct to lru_gen_folio
  mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folios[]
  mm: multi-gen LRU: remove eviction fairness safeguard
  mm: multi-gen LRU: remove aging fairness safeguard
  mm: multi-gen LRU: shuffle should_run_aging()
  mm: multi-gen LRU: per-node lru_gen_folio lists
  mm: multi-gen LRU: clarify scan_control flags
  mm: multi-gen LRU: simplify arch_has_hw_pte_young() check

 Documentation/mm/multigen_lru.rst |   8 +-
 include/linux/memcontrol.h        |  10 +
 include/linux/mm_inline.h         |  25 +-
 include/linux/mmzone.h            | 127 ++++-
 mm/memcontrol.c                   |  16 +
 mm/page_alloc.c                   |   1 +
 mm/vmscan.c                       | 765 ++++++++++++++++++++----------
 mm/workingset.c                   |   4 +-
 8 files changed, 687 insertions(+), 269 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

