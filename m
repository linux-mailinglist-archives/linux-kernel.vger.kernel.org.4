Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA16CCCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjC1WRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1WQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:16:59 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4E2D5E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ml17-20020a17090b361100b0023f9e99ab95so6722047pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041811;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cwQWCEo9ePRYrBfd54RTGHI4ReD6zTB2CQA9ky8D7Xo=;
        b=ckuVrFZpRMbKkYaT641zugwGgqS/ki1HcHRGVRwRjkqbpYmJn53n3BJxlm4PtefNMZ
         V7Lx0t0VCx9xJbkbk0054d9U/+6MMsQejk2NSwnt5D35xCm5Hq5pZm5SJK5CIZfjCnht
         V0pY409txNDdSi4+78Xf8fYrfgteKRSatE0Yv5rBDd+5j6WpeDHZJpDO5IiqBfLgwy3G
         9G3wSwe0z1jWNeULV+cFUkJOWs1knwD7pW4WcXwfaanarWpk2Ozk+fACPDNx1NcCWRdH
         tAvDGN/2QSuKylRwD/br3VcJA7SF9Tuz8RLoH1VBIr+l7Bie6Py+vND+8JOUEY43Ncvz
         wX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwQWCEo9ePRYrBfd54RTGHI4ReD6zTB2CQA9ky8D7Xo=;
        b=01NHMjRi+W5LjqGIWq0I5a2vUlscDrDmdG0SWdAXhGBt0w7cT3tq7qajB3tlpSBx/s
         rZKI1LemxK9YEhUV2mEBeggMC/Ku9OdPC+lBAHjGoC547uTqC601qtnadfJt30saxSli
         8hVYXqwheYrVclFwIYF8G1uw68TsAc7pbcdYSdQjsELQudcXBRx+dU9ut5MCsR3uUZky
         nn8r7mNLIkhXzpwTA/KTZpJsPExd0jKMZKV1jkerm7ocY/zEH6dJf6nZzk6GIN061ATc
         Bfw5IU7hJIxkXLC38P3U9RBwaKq+/rQiHD3e1l5z3WcJi/Mh/rWt3ymd92O0Irm7RL5e
         GRwQ==
X-Gm-Message-State: AAQBX9f/Q3li3+qL2ZH/WGb9lfiRv6a4N14pSTqeo6wpjOY8f0E3/o1P
        ZdSqWpAMzETRdOyZ60J1cAlagWrDbRdNE0cw
X-Google-Smtp-Source: AKy350a0LftA8+YBeO7HxI5a3hE9RhuyDxnrWJZbioOsZo1jxLgNNr2gQblYzMvl1vhkIgmDGcTTrBWiLU1iOxlk
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:d34e:0:b0:50f:8c32:79ee with SMTP
 id u14-20020a63d34e000000b0050f8c3279eemr4775173pgi.4.1680041810879; Tue, 28
 Mar 2023 15:16:50 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-1-yosryahmed@google.com>
Subject: [PATCH v2 0/9] memcg: make rstat flushing irq and sleep
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1 and 2 are cleanups requested during reviews of prior versions
of this series.

Patch 3 makes sure we never try to flush from within an irq context, and
patch 4 adds a WARN_ON_ONCE() to make sure we catch any violations.

Patches 5 to 8 introduce separate variants of mem_cgroup_flush_stats()
for atomic and non-atomic flushing, and make sure we only flush the
stats atomically when necessary.

Patch 9 is a slightly tangential optimization that limits the work done
by rstat flushing in some scenarios.

v1 -> v2:
- Added more context in patch 4's commit log.
- Added atomic_read() before atomic_xchg() in patch 5 to avoid
  needlessly locking the cache line (Shakeel).
- Refactored patch 6: added a common helper, do_flush_stats(), for
  mem_cgroup_flush_stats{_atomic}() (Johannes).
- Renamed mem_cgroup_flush_stats_ratelimited() to
  mem_cgroup_flush_stats_atomic_ratelimited() in patch 6. It is restored
  in patch 7, but this maintains consistency (Johannes).
- Added line break to keep the lock section visually separated in patch
  7 (Johannes).

RFC -> v1:
- Dropped patch 1 that attempted to make the global rstat lock a non-irq
  lock, will follow up on that separetly (Shakeel).
- Dropped stats_flush_lock entirely, replaced by an atomic (Johannes).
- Renamed cgroup_rstat_flush_irqsafe() to cgroup_rstat_flush_atomic()
  instead of removing it (Johannes).
- Added a patch to rename mem_cgroup_flush_stats_delayed() to
  mem_cgroup_flush_stats_ratelimited() (Johannes).
- Separate APIs for flushing memcg stats in atomic and non-atomic
  contexts instead of a boolean argument (Johannes).
- Added patches 3 & 4 to make sure we never flush from irq context
  (Shakeel & Johannes).

Yosry Ahmed (9):
  cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
  memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
  memcg: do not flush stats in irq context
  cgroup: rstat: add WARN_ON_ONCE() if flushing outside task context
  memcg: replace stats_flush_lock with an atomic
  memcg: sleep during flushing stats in safe contexts
  workingset: memcg: sleep when flushing stats in workingset_refault()
  vmscan: memcg: sleep when flushing stats during reclaim
  memcg: do not modify rstat tree for zero updates

 include/linux/cgroup.h     |  2 +-
 include/linux/memcontrol.h |  9 ++++-
 kernel/cgroup/rstat.c      |  6 ++-
 mm/memcontrol.c            | 78 ++++++++++++++++++++++++++++++--------
 mm/workingset.c            |  5 ++-
 5 files changed, 78 insertions(+), 22 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

