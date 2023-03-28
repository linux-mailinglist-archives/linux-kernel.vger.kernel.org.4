Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0246CC3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjC1O6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjC1O6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:58:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A015E1A1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:58:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso15358963pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680015480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOMekqn6pAwuBjuJCTIwhDMskHoRMJ6M6licWqxl8ps=;
        b=kVjgs28u6ZNksz2pEQtkpS4P2iL7oyh1qLcvOVf/Afxc4nu07gCLFqhc30KY+nG0Z2
         O46T4piDfw0CifTJue9YTlQLKMkQPF9usnesOs1qpsRQkuyoztQiHfYhgA6YjfrAIoNJ
         A9HH1J5+lxm9cbIJYTjFFl2Zu0LjM1IHn9J5kM2wiBJNaSdbfHTOrrOopcCEw1aPkdDV
         XzHzQ0B5XCYJHHatR9RvMWDSSElzbFCBbmjhNKXBv5KT6O9jaY4AbWq/AoELevMfujBc
         vmMKlzPkWPZ6hH8Pss0I5aZ6ZrrreQwqQqbzyOq7P7bHfUXilV1Oj42VyzOXWTL8mJfC
         c0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOMekqn6pAwuBjuJCTIwhDMskHoRMJ6M6licWqxl8ps=;
        b=A3hI7S0lbSnbV7utwufRmmjL8AZzXW5JXxvb4glBIRHbP2NYJmEe+iVbMzrgEkURId
         C5ZyyP1EuzAOQWGZS6teZodHgXK08UxGZ/e0MIp+1enXAqfLFICUk4VvVDhY5Jskisoh
         0Kl4i9NKobbUMszfcu53slUN7Gggez2sgVWacp06iQ9ZWVi19FEXNqlMzDP6RzV7tbeB
         V92PG/09vPmKT3EaHuoHXNciskT4hc09kofpeOGKa5TC3UbFhO9NZ0kI4o7UPDqF19Ai
         JK9l+T0i29X9+HRBF/Kt7mWxXX6GgUOrvexihkLq0qC+4PC8M+wWqxzHS5LifbmjeLpt
         m+Eg==
X-Gm-Message-State: AAQBX9cW2wbuyIdpMEf+2UDCg/952ySbhP2oGusyaFoIaQG1i4qJ2fA2
        u5BHZhFfezQxkERpJkIj2aX5Qw==
X-Google-Smtp-Source: AKy350ZkoMnc9lFgTx7UZ27yK8n/Nd0HjOMYPn5BatohM629+pWzLZKRUwbsjHb5c4tl/O2Fui1yRQ==
X-Received: by 2002:a17:90b:2247:b0:234:384f:79c with SMTP id hk7-20020a17090b224700b00234384f079cmr17592692pjb.33.1680015479854;
        Tue, 28 Mar 2023 07:57:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6d:5da0:f469:aa9c:494f:b32f])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b0023b3179f0fcsm6382250pjb.6.2023.03.28.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:57:59 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/4] blk-cgroup: delete cpd_bind_fn of blkcg_policy
Date:   Tue, 28 Mar 2023 22:56:59 +0800
Message-Id: <20230328145701.33699-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230328145701.33699-1-zhouchengming@bytedance.com>
References: <20230328145701.33699-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpd_bind_fn is just used for update default weight when block
subsys attached to a hierarchy. No any policy need it anymore.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-cgroup.c | 21 ---------------------
 block/blk-cgroup.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..68b797b3f114 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1355,26 +1355,6 @@ void blkcg_exit_disk(struct gendisk *disk)
 	blk_throtl_exit(disk);
 }
 
-static void blkcg_bind(struct cgroup_subsys_state *root_css)
-{
-	int i;
-
-	mutex_lock(&blkcg_pol_mutex);
-
-	for (i = 0; i < BLKCG_MAX_POLS; i++) {
-		struct blkcg_policy *pol = blkcg_policy[i];
-		struct blkcg *blkcg;
-
-		if (!pol || !pol->cpd_bind_fn)
-			continue;
-
-		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node)
-			if (blkcg->cpd[pol->plid])
-				pol->cpd_bind_fn(blkcg->cpd[pol->plid]);
-	}
-	mutex_unlock(&blkcg_pol_mutex);
-}
-
 static void blkcg_exit(struct task_struct *tsk)
 {
 	if (tsk->throttle_disk)
@@ -1388,7 +1368,6 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.css_offline = blkcg_css_offline,
 	.css_free = blkcg_css_free,
 	.css_rstat_flush = blkcg_rstat_flush,
-	.bind = blkcg_bind,
 	.dfl_cftypes = blkcg_files,
 	.legacy_cftypes = blkcg_legacy_files,
 	.legacy_name = "blkio",
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 9c5078755e5e..26ce62663e27 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -175,7 +175,6 @@ struct blkcg_policy {
 	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
 	blkcg_pol_init_cpd_fn		*cpd_init_fn;
 	blkcg_pol_free_cpd_fn		*cpd_free_fn;
-	blkcg_pol_bind_cpd_fn		*cpd_bind_fn;
 
 	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
 	blkcg_pol_init_pd_fn		*pd_init_fn;
-- 
2.39.2

