Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1936CCD02
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjC1WRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjC1WRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C112D57
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so13394482yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQQVGwjs4PjltBBm07Wln67ACtAz9IV2/pUsgTkN4l8=;
        b=BwpN5IENfDJAO3k0fvlZBkjsW+/4dRHFvKU3Y61vx7dQ2RtgMRwRfqyo0DTmjCAyVc
         CnLkW84f17NTLqbLQGhvt1qFEPE3lJHVmINhnviNxj716C70wOSUz3DOzWHSZ0RhU5XN
         r07qEoT8pGKoQFAOapju4r5aUWkkVs0eQmIgIci7KEjffCx1HyDeGdNPdwdlAJbu1aOk
         7WwXMQu8pO8A54UInZRnQw9kbNQZxf/x1jM4losJCUKwsJkxT/8pf/ZH8ftd03KJhEdg
         XtPwGtxKxPzrVZOjpFL3fFaXSbnVLYOlrmJD9NS/UpXXC6msV74XQ/lannH6QIJ1sQ32
         hXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQQVGwjs4PjltBBm07Wln67ACtAz9IV2/pUsgTkN4l8=;
        b=DwWY2JM7kDBgV56PkudgqRlITQZCCTVlnsNd4UDja4mbKPnL6V6LI+lza5X0IEqX6W
         okMrNt9eoiT0fD4qSsXOoOCgg4mP1PVGI0l3LUqF2fX9gHM0ub1Bb05zwy4xMgtgWxIc
         LcfieuDq+b1hCeEpm54q6nLHxdh+hkE+Uy6YT7PQ6EZdbq9wAslyV3rhaQCc+buhyjqk
         plY3PPvJVR+dTNDEwobW14zO2LM7O62CugKLVLJVe3ce0hNxPfRDhrpR+OjT3Xaskh02
         WEv/MT4eB4flD3MP5x3UMOoBHiKcBP9QEsZ/PgSq7RPQpDQdcgsST209yIlepoOadzb+
         e01w==
X-Gm-Message-State: AAQBX9d1hgkD99HwtRgC4p4a3JSCbx5TasSyqBoGk11Jl4fUuvOvjowQ
        zoL8SMogZBB1I8qwj5ZRxJHmYoOqvw9Rodra
X-Google-Smtp-Source: AKy350a+cGo/rQiavcF9zU9F0niI9qIhWFxPTrQKaAQYONdIyzIaIiEtY9m/Hx7sNG18TtPt6miuAFUHkt3sB0SU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with
 SMTP id w3-20020a056902100300b00b1d506198e3mr11533410ybt.6.1680041818092;
 Tue, 28 Mar 2023 15:16:58 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:39 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-5-yosryahmed@google.com>
Subject: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing outside
 task context
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

rstat flushing is too expensive to perform in irq context.
The previous patch removed the only context that may invoke an rstat
flush from irq context, add a WARN_ON_ONCE() to detect future
violations, or those that we are not aware of.

Ideally, we wouldn't flush with irqs disabled either, but we have one
context today that does so in mem_cgroup_usage(). Forbid callers from
irq context for now, and hopefully we can also forbid callers with irqs
disabled in the future when we can get rid of this callsite.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/rstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d3252b0416b6..c2571939139f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 {
 	int cpu;
 
+	/* rstat flushing is too expensive for irq context */
+	WARN_ON_ONCE(!in_task());
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-- 
2.40.0.348.gf938b09366-goog

