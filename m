Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122116D0E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjC3TSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjC3TSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:18:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F4E1AD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:18:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b1-20020a17090a8c8100b002400db03706so5590978pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203884;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lrEZYZAprkJkjo6nuInD9+WtSSeLrA1vEvWYswR6SSY=;
        b=lNkrtIAGQghUwPzFiHMiZzA3Dj60iiJHRGbQtataV8UD8wLWTyWKOGxG8u3BZQmZqh
         5yBxB5KPXBynvEz4Q8DwJ48f04q5ziCKK5w2421MfdnykM7hZYTD7QE3qTovUgTB10rE
         /OdTkB3vbZ9H6A+1KcS+Dt8UCQ5k6ylxqWC7L4UhAwDP+Zclc2vMHiXrKe42d7O3O4e9
         yMvq13mWuAkYQrH23Ii0S8JTYXEyLwOzzS6RVCfoQRjcbgjsxO6V7FRVf/WhFXr1IBp2
         ogNqPXtjlpJKSx4pNT1Fg/IoYhT5iC8WlEOAjIe+2CAkukUXdOx4ot3VDqnrD4ezj2KP
         WfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203884;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrEZYZAprkJkjo6nuInD9+WtSSeLrA1vEvWYswR6SSY=;
        b=xTx9kYBkhnnBhN0kW6OEOfWCtMshU6ZOtt/o8Y8XENgds51woXXnN9IpybSfdGWTyY
         XC7dTHftIDHoXCr/iQu2WULuAVmH7FJu71feK1NabiqqojClHSaJOFR2rkCBcTLTEdi7
         Br7ahRRJLcqdSZgsB3XxQCq/Tut/eWJLpIp9/XQMazIcIZ23mk1FA22X1lqUMHx8aUrD
         vfN2PfG0B9r0xlOGu0hJnF7a3a5CYzptcrjp959Rh4LL0EbYNgC/246eg5XBpYH5gsff
         ZfJKon7eVZyc5ibsMTTg9LN2Lsqjc+eAJOrlJSu8IhILCMyd0ODv6fvXloyKFd5oVBem
         Uy3A==
X-Gm-Message-State: AAQBX9dlJOdPTmyFWS9AjDp4MNZ9pMXztTv84tnTHlEjB/VQG9dvIfwC
        yUt73HHQ+7J7jb84TnXimFAd3o6bQrmH9ozA
X-Google-Smtp-Source: AKy350YB83aSAlfHtZ1brNy8tK94TomVrO/ck654euHQoNAhGyGIzRBJ8LL3uL8MDTRbXOo6aA3Aj9bt+0RVTLSh
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:aa7:9285:0:b0:626:1710:9b7d with SMTP
 id j5-20020aa79285000000b0062617109b7dmr3161728pfa.0.1680203883841; Thu, 30
 Mar 2023 12:18:03 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:17:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-1-yosryahmed@google.com>
Subject: [PATCH v3 0/8] memcg: avoid flushing stats atomically where possible
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

rstat flushing is an expensive operation that scales with the number of
cpus and the number of cgroups in the system. The purpose of this series
is to minimize the contexts where we flush stats atomically.

Patches 1 and 2 are cleanups requested during reviews of prior versions
of this series.

Patch 3 makes sure we never try to flush from within an irq context.

Patches 4 to 7 introduce separate variants of mem_cgroup_flush_stats()
for atomic and non-atomic flushing, and make sure we only flush the
stats atomically when necessary.

Patch 8 is a slightly tangential optimization that limits the work done
by rstat flushing in some scenarios.

v2 -> v3:
- Collected more Acks (thanks everyone!).
- Dropped controversial patch 4 from v2.
- Improved commit logs and cover letter (Michal).
v2: https://lore.kernel.org/linux-mm/20230328221644.803272-1-yosryahmed@google.com/

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
v1: https://lore.kernel.org/lkml/20230328061638.203420-1-yosryahmed@google.com/

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
RFC: https://lore.kernel.org/lkml/20230323040037.2389095-1-yosryahmed@google.com/

Yosry Ahmed (8):
  cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
  memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
  memcg: do not flush stats in irq context
  memcg: replace stats_flush_lock with an atomic
  memcg: sleep during flushing stats in safe contexts
  workingset: memcg: sleep when flushing stats in workingset_refault()
  vmscan: memcg: sleep when flushing stats during reclaim
  memcg: do not modify rstat tree for zero updates

 include/linux/cgroup.h     |  2 +-
 include/linux/memcontrol.h |  9 ++++-
 kernel/cgroup/rstat.c      |  4 +-
 mm/memcontrol.c            | 78 ++++++++++++++++++++++++++++++--------
 mm/workingset.c            |  5 ++-
 5 files changed, 76 insertions(+), 22 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

