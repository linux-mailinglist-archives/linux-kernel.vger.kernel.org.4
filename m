Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754006058F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJTHrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJTHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:47:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07B17579B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:47:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pq16so19072919pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WEv0DAtYrQBEKc4KQv+MDWqqO4sqebBTQ3kaboRnQNg=;
        b=GTQ3+2aB72+kOTV0y/y2Ncy5TWnk/z4Cj5D2tlFLPIwoT+7QGZOijPWbsL6YlAkTR2
         WH6rXobe+/n1Op2T4Bkpy9k87M8Eihx9tndD/7jNX/1bQbEeceTVqzY0GKTOKj5mSIYn
         yX+uFQLqGCfD2BwOppd9RVzffo/ZpfeFt1SGkK9aFWDcLq0Kh8AtY+WHaxEzRe20mDnG
         MKjRrA2S3k7IDrGfHDygEhy5zVbNDzzFDKhkI2oBWOeH0zGZs9+Wa4SbJPTHgw7hGfW4
         7mgZq9Rt5Gr+HE7ElBc8URsjfh7LITM/q6YvddDawZP1iiwOGdcQnuNR/b5RG5tmqDah
         /G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEv0DAtYrQBEKc4KQv+MDWqqO4sqebBTQ3kaboRnQNg=;
        b=nlO9SuDFDF+FVwgsutrARTOW+04iNDLVItxiq7ebQ8mieduRQdrzD2RydDj/QPAqZ7
         ealQUGdlutwvzsLYO9kkGYJnJPmnH952ix6Y+SP/wOFBahVHG9rQhadfKklTtpBW1Mz6
         7gW+Zjndz6Bn01VslMtkhHwIKHNKUDZAdcLQf33Vv1hPAxWmykcD3JV8POLUSjPDb08k
         BKALSU5CIDZTZnDMS+5oNSI3N5zIi6VTN2C36GBucc89bLgrWI/c6sfabX6ijmdk5VCa
         Dx0fG9LM0JRw8Hh6CokcH4epG0NX5wWDwORd3YYn6Bfe5HoOqEfQwzZK0s0aRKhFyssG
         wyWg==
X-Gm-Message-State: ACrzQf0g05nPqSdhPnRQyy30uEFTsgp+8gKb/RlpRn2G6cWG2nMrROJC
        OumvWEmNKS+rOjK9yu3kxrIFkw==
X-Google-Smtp-Source: AMsMyM7bzxbNxD1oZJNsw+ps7HAQcODla99hUEqrBbvHJA21N6bNPsnKR75kUNkHweOKKaUdu6IEdg==
X-Received: by 2002:a17:903:2286:b0:185:3948:be93 with SMTP id b6-20020a170903228600b001853948be93mr12818567plh.121.1666252067220;
        Thu, 20 Oct 2022 00:47:47 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902eb8800b00176a2d23d1asm11939007plg.56.2022.10.20.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:47:46 -0700 (PDT)
From:   "haifeng.xu" <haifeng.xu@shopee.com>
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "haifeng.xu" <haifeng.xu@shopee.com>
Subject: [PATCH] cgroup: Simplify code in css_set_move_task
Date:   Thu, 20 Oct 2022 07:47:01 +0000
Message-Id: <20221020074701.84326-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the populated state of css_set in css_set_update_populated
and update the populated state of to_cset after from_cset is updated.

Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
---
 kernel/cgroup/cgroup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d922773fa90b..6c474be57f91 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -861,7 +861,8 @@ static void css_set_update_populated(struct css_set *cset, bool populated)
 {
 	struct cgrp_cset_link *link;
 
-	lockdep_assert_held(&css_set_lock);
+	if (!cset || css_set_populated(cset))
+		return;
 
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link)
 		cgroup_update_populated(link->cgrp, populated);
@@ -903,16 +904,12 @@ static void css_set_move_task(struct task_struct *task,
 {
 	lockdep_assert_held(&css_set_lock);
 
-	if (to_cset && !css_set_populated(to_cset))
-		css_set_update_populated(to_cset, true);
-
 	if (from_cset) {
 		WARN_ON_ONCE(list_empty(&task->cg_list));
 
 		css_set_skip_task_iters(from_cset, task);
 		list_del_init(&task->cg_list);
-		if (!css_set_populated(from_cset))
-			css_set_update_populated(from_cset, false);
+		css_set_update_populated(from_cset, false);
 	} else {
 		WARN_ON_ONCE(!list_empty(&task->cg_list));
 	}
@@ -926,6 +923,7 @@ static void css_set_move_task(struct task_struct *task,
 		WARN_ON_ONCE(task->flags & PF_EXITING);
 
 		cgroup_move_task(task, to_cset);
+		css_set_update_populated(to_cset, true);
 		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
 							     &to_cset->tasks);
 	}
-- 
2.25.1

