Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D86CCCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjC1WRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjC1WRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B02D5A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:53 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gj9-20020a17090b108900b0024038c818a0so3794220pjb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECd9n7cK9XN/T+IJ39MyPXAm65DzgHuyZCFnDGQgZIE=;
        b=hC/hCzGf8kQKLtuU/Lq4g/PH8Bikoaov/kMCU55X6hS3y0cgLvVqN0Ui9SeHKqoI2Y
         MLR9yv7Q6ZpTQchtNNsVDSGumEgnJDRGOrdjWF1vQ04Hu4VkyeJ+agrrQETPfZvxGuwE
         fYcWpRh33+ZEKqsq/V4FxFGt/SOC7Xson0BSVI7SL+S7Djz8oPuCrC/TQcGQu540vmXS
         GyCet5dMYq6C9cPRyqnOFXjOod08thOhwnsgDFjm//XeVxGxDJp0Yqlgz0MeTNLqnkrX
         POTGQvY7O/HgL6iaisQLmX0ut7TKBC/YmOGLurxCyE9UYzyCbGnroCIDWbRRsYz1/a88
         d5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECd9n7cK9XN/T+IJ39MyPXAm65DzgHuyZCFnDGQgZIE=;
        b=SrYQsxF2PLkBGfAVgM0SMj/M9qL/5QyaBbS/ifb2+B7t868mL8B9h395Os30YW6Kr6
         iEnVSMIh5DzskYLmZrAzfnpZUMeQ9rzbfHLfOpbJvohl95P9rh44BH2FtV4heDO5NVnZ
         mB/KcusnwrUkXIDOJmkcBRYTuXvBsJ/ShfPfp6Eio6u/uelE4SZM3qa7WOQ66DlYKdSn
         7kaFhHY/I41mmYMAZZPFCVk9bMVs+SuqDwK+4aja2XOEc2N3/1fc8eH0MN6E6BO32fXa
         wIop2ZjbC2JI2/qf+be1zRdh8X4Jtn9FMTYe9l3gzVlXX+jl/LpuK4vg0dOjwaF00XOH
         NVtQ==
X-Gm-Message-State: AAQBX9dN3dgW79o6wUH3zeBq3WClruSPW89cwUHvDMTKHhytx39n/9k/
        CgeUueajxFm5NI2UtAp157jyroauM9wzA/hn
X-Google-Smtp-Source: AKy350bt7vkQiq6OhtHhv/j8fBGrKxEfoXOdpNRwyGSGJDzpsapd3WOuPFqtBqzF+StnrMen5GR5vLj6Xa5jtVdE
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:6943:b0:236:a1f9:9a9d with SMTP
 id j3-20020a17090a694300b00236a1f99a9dmr64331pjm.2.1680041812843; Tue, 28 Mar
 2023 15:16:52 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:36 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-2-yosryahmed@google.com>
Subject: [PATCH v2 1/9] cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
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
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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

