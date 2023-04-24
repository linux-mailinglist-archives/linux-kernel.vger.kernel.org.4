Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90556D546B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjDCWDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjDCWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:03:42 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D03270F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:03:41 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p9-20020a170902e74900b001a1c7b2e7afso18011386plf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kId3QKjERA5KglVeO1VKvGvv5azlGeISt3c2gJrYgyo=;
        b=W/ze/sAlU7O+7GhoVMA+gO+b3zK1GLSBb2wxG7cqOl+9vjmm6QdV40GnYhvFBAr6we
         6QpU1r1iDXHFCTCDI3KvZCA5Fdx66xMvZLtqAf+RggvSzScbqU6Qb+D3U4BXwhb/OMA1
         mj7EUoKa/2hKudyISX9IDUT5QtGjglqN6doUhxmfcL1+w5LR9gcm9RCdAs4iQ3yY+fKw
         8EP2M2Ss5aeWYRlPCW8BW8qsios85nr5jm7RooCKJYkRU/xUY3Tcdg08l4PT4At3QjPp
         8RJrh+/qwzB7v9VlZ60Az/txlakHCjAKDKadt2/B61f8k1qeYBs4X+ujruMC4SFwxMjN
         IvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kId3QKjERA5KglVeO1VKvGvv5azlGeISt3c2gJrYgyo=;
        b=JZm+cP9rP79FBj0yIznPWl6LmmSiTI/fNFMRxHEQdnI1ZHejhfGinWyyzNghPakpDi
         8DZ7zOQ69wN/fsHe/Hou5D1S6LINbjKg9ocF0ylPBoN2o5SADcz2CwsGk7RKvUdoasxI
         7BkHHBbSMVtOuNNanpQQ6/L0M4afFWow8HDodUPSRgL0XW7nM+3y38jW++nnauoXiUoE
         QiCmGMkf4lJ3NQCBJlOi2tbBk5GV3TZjr7iuinFip2zVvjjeejiYXnjY2RbK67Q/PCV/
         uiTEf2i9t7h32Vo/iT2MaEv5CtfaAllyHZ3Ve60wNAwPPQLR3xJIGBrU962M96jA2qhB
         Y/wQ==
X-Gm-Message-State: AAQBX9dZrVdlKUxTzPKNVOGHOKp+zImpTEe/XqjQT1itObWQEGDGK7wb
        U10Iuy/Er8dyvnC/XWYAIgBpOZNOiDIPMU06
X-Google-Smtp-Source: AKy350bROYdy/7K8uGxBM0X/ZxH2AG6/5IpCycN9GV2HdX4MbVmRhF2WLCfVj205eUvkzCs7+3h4yAAbVuROFoGd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:f307:0:b0:50c:bd0:eb8c with SMTP id
 l7-20020a63f307000000b0050c0bd0eb8cmr39435pgh.6.1680559421112; Mon, 03 Apr
 2023 15:03:41 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:33 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-2-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh() call
 outside lock section
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
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

wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
flush, which can be expensive on large systems. Currently,
wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
have to make the rstat flush atomically. On systems with a lot of
cpus/cgroups, this can cause us to disable irqs for a long time,
potentially causing problems.

Move the call to wb_over_bg_thresh() outside the lock section in
preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
The list_empty(&wb->work_list) should be okay outside the lock section
of wb->list_lock as it is protected by a separate lock (wb->work_lock),
and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_*
lists the wb->list_lock is protecting. Also, the loop seems to be
already releasing and reacquring the lock, so this refactoring looks
safe.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 fs/fs-writeback.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 195dc23e0d831..012357bc8daa3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct blk_plug plug;
 
 	blk_start_plug(&plug);
-	spin_lock(&wb->list_lock);
 	for (;;) {
 		/*
 		 * Stop writeback when nr_pages has been consumed
@@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb,
 		if (work->for_background && !wb_over_bg_thresh(wb))
 			break;
 
+
+		spin_lock(&wb->list_lock);
+
 		/*
 		 * Kupdate and background works are special and we want to
 		 * include all inodes that need writing. Livelock avoidance is
@@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress)
+		if (progress) {
+			spin_unlock(&wb->list_lock);
 			continue;
+		}
+
 		/*
 		 * No more inodes for IO, bail
 		 */
-		if (list_empty(&wb->b_more_io))
+		if (list_empty(&wb->b_more_io)) {
+			spin_unlock(&wb->list_lock);
 			break;
+		}
+
 		/*
 		 * Nothing written. Wait for some inode to
 		 * become available for writeback. Otherwise
@@ -2093,9 +2101,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		spin_unlock(&wb->list_lock);
 		/* This function drops i_lock... */
 		inode_sleep_on_writeback(inode);
-		spin_lock(&wb->list_lock);
 	}
-	spin_unlock(&wb->list_lock);
 	blk_finish_plug(&plug);
 
 	return nr_pages - work->nr_pages;
-- 
2.40.0.348.gf938b09366-goog

