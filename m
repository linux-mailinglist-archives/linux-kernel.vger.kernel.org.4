Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA16B2015
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCIJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjCIJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:31:30 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803F70431
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:31:29 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id v24-20020a631518000000b00502e6bfe335so448670pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678354288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6dgxagOpBb1myYnk/1Y2AGrRWWDZLYTueWoLu8qIY4=;
        b=KzU6h4ueyt1nc3fHTw62ynzTN6cM5FPoDfMBmAqJ1Wwes61zVej5BOhlYyPncxm4Zm
         nkjKeBNIQMZU0E9YJO2405czXqReQIP71dpM6JRcIVBwGfbOfnDAO+93r67dHWvV1VcL
         zONddPvKo2/hWkzUIRnhDO3Zqp+7yh7T+acFffATa66sYzOvTr15BMFihxW3t2a2tMq/
         8Ig75rYkpQRqgddwtZBlA3k3y0eMCsf3xzOYsCI2yvjWMp0avrLAbOSW5a+OH2FI5iL+
         ETd/0TFbN+DnBMOE/8xtP1qGx1HOTcBW/q+JbvhFqWJVi18NNllY9Hag5hM4SObpgkS6
         mKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6dgxagOpBb1myYnk/1Y2AGrRWWDZLYTueWoLu8qIY4=;
        b=a4G+Df4K744rGAe2PFoari5Lec3tlmx32STNjBKAfFCQnhmLSJ2ZSlHBRZlz9jzl5s
         uwMXGXegceWszsaZgxZPl+h9CvxObPifIQeh0Odu/jt8cu+u8HlrfQ97ucpnqBHEmArY
         72yIS0tkAj9IPnkB74C6f+dw8OlnsYMFAGbc3vjRwDdW9xPONSVUt8nW4vs+f6WB4qeR
         EDuyCRx02DAeFVt2DP5bhSSCW4IOa79qGPTe0mRtC5PLOr9XtCreKlCkPVI0n1UTTrfP
         6Sgfsl09dBobqDoVYFqGJSGXNA2Gbonbf1yiIsXKNJncP3TWWnwlbbtiOPklwNsYk4cY
         9GFA==
X-Gm-Message-State: AO0yUKXS+P0bQ1ob/JKaWVJfdhz1GTakcBi90e6z/VJpf/ZUv+Nep3md
        8R+le46cfkr18wGwqTfBnDPL0OMXGFErRDF1
X-Google-Smtp-Source: AK7set82CEBSuqo8FpS3nsNPKqDoN9u1SA11kEpTwZaYFka9KSS8D9zMVtgu+8uzsp90VdIxYuFl/oAa7auTdfM+
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:5508:0:b0:502:fd71:d58c with SMTP
 id j8-20020a635508000000b00502fd71d58cmr7728137pgb.9.1678354288447; Thu, 09
 Mar 2023 01:31:28 -0800 (PST)
Date:   Thu,  9 Mar 2023 09:31:07 +0000
In-Reply-To: <20230309093109.3039327-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230309093109.3039327-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230309093109.3039327-2-yosryahmed@google.com>
Subject: [PATCH v2 1/3] mm: vmscan: move set_task_reclaim_state() after cgroup_reclaim()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_task_reclaim_state() is currently defined in mm/vmscan.c above
an #ifdef CONFIG_MEMCG block where cgroup_reclaim() is defined. We are
about to add some more helpers that operate on reclaim_state, and will
need to use cgroup_reclaim(). Move set_task_reclaim_state() after
the #ifdef CONFIG_MEMCG block containing the definition of
cgroup_reclaim() to keep helpers operating on reclaim_state together.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..fef7d1c0f82b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -188,18 +188,6 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
-static void set_task_reclaim_state(struct task_struct *task,
-				   struct reclaim_state *rs)
-{
-	/* Check for an overwrite */
-	WARN_ON_ONCE(rs && task->reclaim_state);
-
-	/* Check for the nulling of an already-nulled member */
-	WARN_ON_ONCE(!rs && !task->reclaim_state);
-
-	task->reclaim_state = rs;
-}
-
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 
@@ -511,6 +499,18 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+static void set_task_reclaim_state(struct task_struct *task,
+				   struct reclaim_state *rs)
+{
+	/* Check for an overwrite */
+	WARN_ON_ONCE(rs && task->reclaim_state);
+
+	/* Check for the nulling of an already-nulled member */
+	WARN_ON_ONCE(!rs && !task->reclaim_state);
+
+	task->reclaim_state = rs;
+}
+
 static long xchg_nr_deferred(struct shrinker *shrinker,
 			     struct shrink_control *sc)
 {
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

