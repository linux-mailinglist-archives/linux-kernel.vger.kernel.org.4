Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8376CB6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC1GRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjC1GRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86930FC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso10959061ybj.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984202;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sp9O7DL9obBb0muMtifinlg/m6vcys5sIiJC9lNDWi4=;
        b=NeuDT5i+IX7EsYuGxrlQHGfM/O44K/q8azh0N01/JWHajTpr/8bCoJ2QTmweAtvhfe
         gYoeDE3hEA/7en26XdMklOvz+naw4YK/G+YhpbjekM9lK1gn62mOub1rqZqAuOD3Va4S
         1QIsws0AsakJv6xmZVg2tR6CGN3YqUveLDQmgizdGWo93cuUB1v+gh6AulTa+cAtsQ1E
         KKArWRQY0GrdStBwfUXdbR6yPsdQlbb61EZd9PCwqGtcxA7k1j294s/M/nt3EKFywNtt
         l3OyHVKVYr6ScGHLswWLNtnzcPUbA+BqIwaG4p3phWhy3WEkn1PyyK7m1rhPq1yMmAEF
         q2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984202;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sp9O7DL9obBb0muMtifinlg/m6vcys5sIiJC9lNDWi4=;
        b=BdRNzUkqloI21cYDa+Knrqg8t8QRh0/DA6aO0LbOmyy7SSpdRxq2jbeFG117kunRTM
         NVNV94E40g7gChv12hVl5vAbyAWURn6pDNl3xGkwUrpQus5656a1n38MnZXAneUSXuN7
         gbwoCc8YHF6qeNQjEx6SRzKbCuljJVWpD0uiIasU8/8t5S6LmbC1OEODDp0/hslI6iQT
         qlKM4j6c3ENdPISRE+C9jeb+jZCV8tlrlylwy6/jY+KAsGyH3lBhEXap1tuDHHFpHDbd
         Ueyjn/FKtNPnpGAUWnRFJBzG+17Izmcb4areAplfJRxVhu4kr4vdlWxQIGwzLNG75gJQ
         5qIg==
X-Gm-Message-State: AAQBX9cypvjval9O3jSvrxfv30G9G2K+fWjqafKgM0RvTfJ5O9oiBOVj
        1kNzVlHAl33sJAiBefxVBTwmN0MoYmnvlRfR
X-Google-Smtp-Source: AKy350bZY7FA4NsJ0fqBTDQ1vhS8yI9N8IskrUxgaH2uFCVGGGkuCT76RaKDFHndt2HqiHyVKmyLU1Kd/HHTyvK/
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:2749:0:b0:b4a:e062:3576 with SMTP
 id n70-20020a252749000000b00b4ae0623576mr6830636ybn.13.1679984201935; Mon, 27
 Mar 2023 23:16:41 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-1-yosryahmed@google.com>
Subject: [PATCH v1 0/9] memcg: make rstat flushing irq and sleep friendly
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

Currently, all calls to flush memcg stats use the atomic variant for
rstat flushing, cgroup_rstat_flush_irqsafe(), which keeps interrupts
disabled throughout flushing and does not sleep. Flushing stats is an
expensive operation, and we should avoid doing it atomically where
possible. Otherwise, we may end up doing a lot of work without
rescheduling and with interrupts disabled unnecessarily.

Patches 1 and 2 are cleanups requested during reviews of prior versions
of this series.

Patch 3 makes sure we never try to flush from within an irq context, and
patch 4 adds a WARN_ON_ONCE() to make sure we catch any violations.

Patches 5 to 8 introduce separate variants of mem_cgroup_flush_stats()
for atomic and non-atomic flushing, and make sure we only flush the
stats atomically when necessary.

Patch 9 is a slightly tangential optimization that limits the work done
by rstat flushing in some scenarios.

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
 include/linux/memcontrol.h |  9 +++-
 kernel/cgroup/rstat.c      |  6 ++-
 mm/memcontrol.c            | 86 ++++++++++++++++++++++++++++++++------
 mm/workingset.c            |  4 +-
 5 files changed, 87 insertions(+), 20 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

