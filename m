Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71058652A51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiLUAMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiLUAMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:12:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A51EEF8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so15802657ybj.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=82GCjizgzGPZFVVPgJxtpPnUGDdhN+TgWsbKGRzfn8M=;
        b=mV30EQNXvQzsGbVj76mD5FyucVvmSnapn52DJPiSc2YR/0t6rqMECGo4LQP6x5vPD2
         vbgVZqEUs3x1wwZl1jIes0zuCsoEne/qyY09FSqrgZna2Uk7gkmRs1qOtIFqbTpE8Vn+
         z8IQLdyq0aMmC4hhbN6K6HOFUXoe1zmHW/NgOAP1/uFMm2KJVDDoKgPJICiysfuW1AQv
         4/pkEmFNbilcA9edp6bvGr9W+1pkrUWLL5HnMRv52QwTdDHiubPHbq0xAF2ATJ4f4gb8
         OcknjMsfQShkE/L9kB7w+QhnF1YtQMrixmcZ68SyldIjz5pSqne7zSQVlkAgLD7HrOhD
         MJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82GCjizgzGPZFVVPgJxtpPnUGDdhN+TgWsbKGRzfn8M=;
        b=FjM2KkANe+fS38i76bj5PHrfThueVb8VX4THNyGUquyMdqnms2F/QARbAqVCed+nkS
         sYMiDBJewWd3i7/QICdTWsCtDRyx1Iiu86tfcVmFBxJWQXF1bDwAainocIPa2I7Gaw7b
         qDZc46CMHemeH9XrK+AXhRaLse+aHeqqbnrUxdVs4OAK53ZcJ0pzx1IzyBWGdV3CElxR
         505gX/d+Tt0rtjn81ilEja/jaNXy8RD7h17GDvSNNF7q5BdHvJeYVEDb28HV0WADI6f8
         WILgY5Au+h/uXh+Fhh4w01X8cSqsdlPi2rS4TsNNKdmuRGVmlqIYOqngZe//wqYraYlS
         Jebw==
X-Gm-Message-State: ANoB5pmF5mO2kVC7zaaEC7wMHM+vYxF1gNLnC0eeyvyqyrivsoORwC26
        imgbedjmXKsI//5esnf+UUmH3/E+8Xk=
X-Google-Smtp-Source: AA0mqf6TmFHAnsnDGLb1qnXgVaQH7eoUU56Ey7uX/DzIhOL98ABrVuOpiSxXp4a/O8+lq7MZ+VAs0uR7hYY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a0d:ef83:0:b0:3f6:4500:813d with SMTP id
 y125-20020a0def83000000b003f64500813dmr15428723ywe.509.1671581555214; Tue, 20
 Dec 2022 16:12:35 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:12:00 -0700
Message-Id: <20221221001207.1376119-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 0/8] mm: multi-gen LRU: memcg LRU
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
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

What's new
==========
1. Rebased to the latest mm-unstable.
2. Added two comprehensive benchmarks:
   https://lore.kernel.org/r/20221220214923.1229538-1-yuzhao@google.com/
   https://lore.kernel.org/r/20221221000748.1374772-1-yuzhao@google.com/

Overview
========
An memcg LRU is a per-node LRU of memcgs. It is also an LRU of LRUs,
since each node and memcg combination has an LRU of folios (see
mem_cgroup_lruvec()).

Its goal is to improve the scalability of global reclaim, which is
critical to system-wide memory overcommit in data centers. Note that
memcg reclaim is currently out of scope.

Its memory bloat is a pointer to each lruvec and negligible to each
pglist_data. In terms of traversing memcgs during global reclaim, it
improves the best-case complexity from O(n) to O(1) and does not
affect the worst-case complexity O(n). Therefore, on average, it has
a sublinear complexity in contrast to the current linear complexity.

The basic structure of an memcg LRU can be understood by an analogy
to the active/inactive LRU (of folios):
1. It has the young and the old (generations), the counterparts to
   the active and the inactive;
2. The increment of max_seq triggers promotion, the counterpart to
   activation;
3. Other events, e.g., offlining an memcg, triggers similar
   operations, e.g., demotion, the counterpart to deactivation.

In terms of global reclaim, it has two distinct features:
1. Sharding, which allows each thread to start at a random memcg (in
   the old generation) and improves parallelism;
2. Eventual fairness, which allows direct reclaim to bail out and
   reduces latency without affecting fairness over some time.

The commit message in patch 6 details the workflow:
https://lore.kernel.org/r/20221221001207.1376119-7-yuzhao@google.com/

The following is a simple test to quickly verify its effectiveness.
More benchmarks are coming soon.

  Test design:
  1. Create multiple memcgs.
  2. Each memcg contains a job (fio).
  3. All jobs access the same amount of memory randomly.
  4. The system does not experience global memory pressure.
  5. Periodically write to the root memory.reclaim.

  Desired outcome:
  1. All memcgs have similar pgsteal counts, i.e.,
     stddev(pgsteal)/mean(pgsteal) is close to 0%.
  2. The total pgsteal is close to the total requested through
     memory.reclaim, i.e., sum(pgsteal)/sum(requested) is close to
     100%.

  Actual outcome [1]:
                                     MGLRU off    MGLRU on
  stddev(pgsteal) / mean(pgsteal)    75%          20%
  sum(pgsteal) / sum(requested)      425%         95%
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
 include/linux/mmzone.h            | 131 ++++-
 mm/memcontrol.c                   |  16 +
 mm/page_alloc.c                   |   1 +
 mm/vmscan.c                       | 768 ++++++++++++++++++++----------
 mm/workingset.c                   |   4 +-
 8 files changed, 692 insertions(+), 271 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

