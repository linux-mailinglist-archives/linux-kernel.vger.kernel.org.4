Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B525B653B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiLVEUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiLVETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07223EB7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c18-20020a25a292000000b0074075692485so692473ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hecVxc/xjfWlg6qdlZfet4PMI8t4pFn0RW9oF1Q4vnw=;
        b=LOF6Y7OkksAIbfYHvpQQDGcKYQUBjmyI/508Hfp6nP+cWB5jNwnfh9oFhUHmMWPuoV
         XS0/DzLTeFeV/DsuryyLc+UoVwX0gyHpW22w5tsVQiWjiwNAVv2r2ZJ5drGAronSs1u+
         WZVkm8H/t7luoSN68OklY2SC+x89QDozr0OocgeZxIs8bWSnfolf2WpekTjupEtNXfwg
         aAjoEv2ugLZnGXLpZZe7xwhE5t61AhHBJI6PR9a2Bbf71sLiNI9YMOIi+UookiF9XdQD
         ImjOhCnEMnDREg68U9RWGXC824OmbHq64Qy13fxpnyCTmiygdijzhmt0+XJofDpR6vRL
         515g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hecVxc/xjfWlg6qdlZfet4PMI8t4pFn0RW9oF1Q4vnw=;
        b=icUmZz53hdwJrGyo407qhFAyEgSM29R0TgRW3P1YebRDZy5lfViKveWaqqjDBsyltS
         0gNH2DOs2X7Izhj+8kwH1L7Gva69F1nO1VJpe7ooey7zGXjyJqG0G6gPu96rCl/9DsnH
         H+CVZ8NxaGRh8zZSmjYtVwMtgMMYgsqBn9bFXx2Lp2nt8+lh+/NmnbKW3MTFPBPXAM/n
         S9UD5HaB0qvbPVTDnQ7fbXhUaGijymNl5dWYE3ESlOEBkaov8xNLN1JoHDxCrTsOsXer
         Bki6Rq1nihWgD4hgq3HSWqK0K2tGY9yJJAeLL7QiRFwEYz6JIbor/0D7h6wuSIQ4JAV/
         Pm7g==
X-Gm-Message-State: AFqh2krVh+fX2wk+Uf6g9tIvKWd9f7x1AcAsdOUi787CQ2ExOtV54lOg
        Jt8vi0vs4jJACNJ+WHxe8Pe0lmuYaco=
X-Google-Smtp-Source: AMrXdXsg2Q4NFzTySWUaKWP/6xYZg2sihP1TSF3s2QYFc2nEU3vh1XKgFJZmLGmcZIg3t3frfbJ9Y9SyVp0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a25:550a:0:b0:708:522d:cd52 with SMTP id
 j10-20020a25550a000000b00708522dcd52mr449573ybb.312.1671682780501; Wed, 21
 Dec 2022 20:19:40 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:18:58 -0700
Message-Id: <20221222041905.2431096-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 0/8] mm: multi-gen LRU: memcg LRU
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
1. Rebased to the latest mm-unstable and resolved the conflict with
   commit 8032bf1233a7 ("treewide: use get_random_u32_below() instead
   of deprecated function").
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
affect the worst-case complexity O(n). Therefore, on average, it has a
sublinear complexity in contrast to the current linear complexity.

The basic structure of an memcg LRU can be understood by an analogy to
the active/inactive LRU (of folios):
1. It has the young and the old (generations), i.e., the counterparts
   to the active and the inactive;
2. The increment of max_seq triggers promotion, i.e., the counterpart
   to activation;
3. Other events trigger similar operations, e.g., offlining an memcg
   triggers demotion, i.e., the counterpart to deactivation.

In terms of global reclaim, it has two distinct features:
1. Sharding, which allows each thread to start at a random memcg (in
   the old generation) and improves parallelism;
2. Eventual fairness, which allows direct reclaim to bail out at will
   and reduces latency without affecting fairness over some time.

The commit message in patch 6 details the workflow:
https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com/

The following is a simple test to quickly verify its effectiveness.

  Test design:
  1. Create multiple memcgs.
  2. Each memcg contains a job (fio).
  3. All jobs access the same amount of memory randomly.
  4. The system does not experience global memory pressure.
  5. Periodically write to the root memory.reclaim.

  Desired outcome:
  1. All memcgs have similar pgsteal counts, i.e., stddev(pgsteal)
     over mean(pgsteal) is close to 0%.
  2. The total pgsteal is close to the total requested through
     memory.reclaim, i.e., sum(pgsteal) over sum(requested) is close
     to 100%.

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
 mm/vmscan.c                       | 769 ++++++++++++++++++++----------
 mm/workingset.c                   |   4 +-
 8 files changed, 693 insertions(+), 271 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

