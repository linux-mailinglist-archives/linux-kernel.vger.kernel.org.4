Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A46C5DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCWEA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCWEAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:00:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5E1F5F6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:00:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5446a91c40cso209230347b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544041;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQm6vY6azaIWfVBk9OleqJiypEWxonUrfDuxGdzwvEo=;
        b=Wqjo2gOwLuBNwjRWcqy/e97mtEalxuitp0xY/9ucFAeoVjzZqkLFNj+Kg/bS7+SLso
         0mEqszCZOwticCjD28rnJun5qYG8zLpCe7Lgqr1Zcq77xAINPLQkmlCr1RUZ3ZFrFZLe
         yVSSzSX2DRXw2LGgoiHCS2XSksG6+AorfME/vlcB+xENetBawM2tXFoeFxzlxQ+CDzRr
         rABuT5MXEbil4k21Tw2rj0lLKNuTBpVjCslzrHFHpTW3cYQbR83DpY9L8+R2A0wlBskB
         V7890htQHHBp7dpJzFMQR7ATN69oyvzWl1Z0FZ3aHCz1QscoKhEDDw6wgjhuKwrEdKtk
         wggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQm6vY6azaIWfVBk9OleqJiypEWxonUrfDuxGdzwvEo=;
        b=ZEsV6Pa66Y+M2xK+Cq+uvtY4duDAool9YYqhSD9DFDer7WeIUsUtzjpeWpVIcoxKCH
         e6xvY+y70pjtcJAAF4XYCEAume4ac++xHodJ2bn/TTO+yfwXjs66bOjwkvLOQRJUCHUy
         UAWNNtIrrw7HQE1Z0Tit/cUra0UcZrDZLhlp3D/XcXs/TBEHVNP1clLCsCAs9bLR1Lwm
         gBapVtFkKO3zkJL+EDOIexBtm37um2EicEdFF9SgEsPUm7kdAWXhO9AoQZ8qnDdMCSS5
         R0J6LwXTkZCR53B8j06FwooTGcbqKMt4q4G3+tuLso/MEhan6bV4XSeybgGpyDI0nHyb
         CNcw==
X-Gm-Message-State: AAQBX9efa4N4q5sUFks53+Gc93srez+GsEu+wIYY/0UJeN+yv82Neu/a
        F534l5UY4UBtSEKVAdR1p3Bk0dQbYeVlERw8
X-Google-Smtp-Source: AKy350Z2wOemdLUQ3DTnBtcfhLATRQqZsbL/MHNlEb2SKIexwcp8tfmae32ViTPN5/R0R1QUYdUH7T2cgfJO0+nV
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:840a:0:b0:b26:884:c35e with SMTP id
 u10-20020a25840a000000b00b260884c35emr1126100ybk.4.1679544041493; Wed, 22 Mar
 2023 21:00:41 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-1-yosryahmed@google.com>
Subject: [RFC PATCH 0/7] Make rstat flushing IRQ and sleep friendly
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
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

Currently, if rstat flushing is invoked using the irqsafe variant
cgroup_rstat_flush_irqsafe(), we keep interrupts disabled and do not
sleep for the entire flush operation, which is O(# cpus * # cgroups).
This can be rather dangerous.

Not all contexts that use cgroup_rstat_flush_irqsafe() actually cannot
sleep, and among those that cannot sleep, not all contexts require
interrupts to be disabled. This patch series breaks down the
O(# cpus * # cgroups) duration that we disable interrupts for into a
series of O(# cgroups) durations. Disabling interrupts is deferred to
the caller if needed.

Patch 1 mainly addresses this by not requiring interrupts to be
disabled for the global rstat lock to be acquired. As a side effect of
that, the we disable rstat flushing in interrupt context. See patch 1
for more details.

One thing I am not sure about is whether the only caller of
cgroup_rstat_flush_hold() -- cgroup_base_stat_cputime_show(),
currently has any dependency on that call disabling interrupts.

Patch 2 follows suit for stats_flush_lock in the memcg code, allowing it
to be acquired without disabling interrupts.

Patch 3 removes cgroup_rstat_flush_irqsafe() and updates
cgroup_rstat_flush() to be more explicit about sleeping.

Patch 4 changes memcg code paths that invoke rstat flushing to sleep
where possible. The patch changes code paths where it is naturally saef
to sleep: userspace reads and the background periodic flusher.

Patches 5 & 6 allow sleeping while rstat flushing in reclaim context and
refault context. I am not sure if this is okay, especially the latter,
so I placed them in separate patches for ease of revert/drop.

Patch 7 is a slightly tangential optimization that limits the work done
by rstat flushing in some scenarios.

Yosry Ahmed (7):
  cgroup: rstat: only disable interrupts for the percpu lock
  memcg: do not disable interrupts when holding stats_flush_lock
  cgroup: rstat: remove cgroup_rstat_flush_irqsafe()
  memcg: sleep during flushing stats in safe contexts
  vmscan: memcg: sleep when flushing stats during reclaim
  workingset: memcg: sleep when flushing stats in workingset_refault()
  memcg: do not modify rstat tree for zero updates

 block/blk-cgroup.c         |  2 +-
 include/linux/cgroup.h     |  3 +--
 include/linux/memcontrol.h |  8 +++---
 kernel/cgroup/cgroup.c     |  4 +--
 kernel/cgroup/rstat.c      | 54 ++++++++++++++++++++------------------
 mm/memcontrol.c            | 52 ++++++++++++++++++++++--------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  4 +--
 8 files changed, 73 insertions(+), 56 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

