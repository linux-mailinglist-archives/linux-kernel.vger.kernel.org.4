Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28376CB6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjC1GRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjC1GRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3D358A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s4-20020a170902ea0400b001a1f4137086so7101580plg.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs9g98LfB/5B5fgCHg0khEoDDLXk/FbX9zQPYHFGol8=;
        b=IrEj06HWrJaiEe47kle+4mjwycO8VkK4UYyVi89hOr/BT4ba3YoJaIkMxMmDu91Azt
         OCiIdpmqw/gfkGEUiinzv01MOm68VDd/zLRgX2gIU8f7UybpdpXtpixpCNAld7gzowZR
         +gyt1jsqLawCKRD+ojRnZ6c35iauByhdICeE6tA9/AW2kV9h46wsE+qITfJzQSmauG1W
         ySDyn3mwIkhUXYNihBaZeA4rjBJGjlP0HSdTCoy9A7k1vdMTk4m51J+idABUhgX1bKO7
         He48ZTeiLxeRfpruo08A01IDO1BpVxjEsw+pmwGtbL4byIuTDU8yveD/qiON77jThzUh
         Vo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs9g98LfB/5B5fgCHg0khEoDDLXk/FbX9zQPYHFGol8=;
        b=630mZVewJORP2fNKdtiQeFxnWfCc/o8iyhBDsR3Z/f1ZbNN7k6GkrivHt0bsfR48sZ
         ud0+FMY0CERbrdrtdsqV0PQin+84xOeKvKsFNHH0ptwLFENZ2QCX1qKjTQEnFl31kMHC
         oSTlTZ1JFZYn0czx78EGFWbyPN1PmyUXo5irSDi5CSRr+bXU8WQW0R8sEuIiISKpZho1
         KnP3x29679h5AsBHJUImGRbtQSC4cqC4cNqYTr5R0ntqWMSh6LzJE4ZsOOjDCCdVEwo9
         +gymlT6YOXCy2FqjTrqaPbE3vprO6sXbPq0J/9XCMeFflvFAQmkK7l97+ZnmAZn+/84T
         eAZg==
X-Gm-Message-State: AAQBX9c2wgi8/jFbXmF6WG1RKdE9pCns6GPeIZlyZ+0GtDMICPt7pC76
        83yJXGjI1DOgqacC6u0d9zFdDiSCqiBX34lv
X-Google-Smtp-Source: AKy350aYOPbMPoVcZ2xVfirHkGMy5US/bJka4xE6zLbD6emP+rv0j2dGtP2N8z3/3tcuS7Hx271FErAXLO/AbXkX
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:24c4:b0:629:f9a2:64e6 with
 SMTP id d4-20020a056a0024c400b00629f9a264e6mr7565323pfv.4.1679984203700; Mon,
 27 Mar 2023 23:16:43 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:30 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-2-yosryahmed@google.com>
Subject: [PATCH v1 1/9] cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
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

cgroup_rstat_flush_irqsafe() can be a confusing name. It may read as
"irqs are disabled throughout", which is what the current implementation
does (currently under discussion [1]), but is not the intention. The
intention is that this function is safe to call from atomic contexts.
Name it as such.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/cgroup.h | 2 +-
 kernel/cgroup/rstat.c  | 4 ++--
 mm/memcontrol.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3410aecffdb4..885f5395fcd0 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -692,7 +692,7 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
+void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 831f1f472bb8..d3252b0416b6 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -241,12 +241,12 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 }
 
 /**
- * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush()
+ * cgroup_rstat_flush_atomic- atomic version of cgroup_rstat_flush()
  * @cgrp: target cgroup
  *
  * This function can be called from any context.
  */
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
+void cgroup_rstat_flush_atomic(struct cgroup *cgrp)
 {
 	unsigned long flags;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..0205e58ea430 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -642,7 +642,7 @@ static void __mem_cgroup_flush_stats(void)
 		return;
 
 	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
-	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
+	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
 	spin_unlock_irqrestore(&stats_flush_lock, flag);
 }
-- 
2.40.0.348.gf938b09366-goog

