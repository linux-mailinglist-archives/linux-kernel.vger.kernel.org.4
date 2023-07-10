Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A485D74DEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGJUEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGJUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:04 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD66195
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:02 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-634a3682c25so37773746d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019442; x=1691611442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWzC7HgThkzjSiE3ZBufE1vxY1hAeIuuMOLF9sjxPE0=;
        b=kH87JA4b76T58XQQzOBGQw/VLdfwrPJAcwP//ZFKpUfKRD+KN2HqKssKU88xrxXPo5
         HziCc+E1/6P2Sk2oFF8SE1F9P+L+2jpP6ZgkwgpKoisr0O1scKVTehsfvLe2GPdqUBJc
         NHy9A/7Rknth+v70kesTsKX4nhlsDl5K9FL51kU/HZjShH2q99aovGynTDMjrbV4h4UE
         x4y3RyHWUgxjhM5UrvBC6E4GTkSgHRz7hO+Zj2tuf2no/tQ6FzC5srftSMrszphuYL1w
         BQyai0aiuVgP1r48iKQYP/EFqEt4V5duOJx3ER6KhaeG+wWeUZEsKmsxB+cFG11e1zjY
         tPHg==
X-Gm-Message-State: ABy/qLb0MSHj6tyIsRGUxyRDes59pPnv7mTpMa3eMBRRgYMat6KcxoSI
        9lzOtEIhMMfm4JzNlYY/toaJ5EznL6vAGSXH
X-Google-Smtp-Source: APBJJlHOk/YX2kHwXmX6a/c+m31SkUZe7QmVT04a7vWIS8P0Ym3QowOgY8XuxmV53BfgSSjMKl3Wzg==
X-Received: by 2002:a0c:f049:0:b0:630:1954:b30 with SMTP id b9-20020a0cf049000000b0063019540b30mr11942273qvl.9.1689019441553;
        Mon, 10 Jul 2023 13:04:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e012000000b00765a676b75csm204370qkk.21.2023.07.10.13.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:04:01 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 1/7] sched: Expose move_queued_task() from core.c
Date:   Mon, 10 Jul 2023 15:03:36 -0500
Message-Id: <20230710200342.358255-2-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_task_to() function exposed from kernel/sched/core.c migrates
the current task, which is silently assumed to also be its first
argument, to the specified CPU. The function uses stop_one_cpu() to
migrate the task to the target CPU, which won't work if @p is not the
current task as the stop_one_cpu() callback isn't invoked on remote
CPUs.

While this operation is useful for task_numa_migrate() in fair.c, it
would be useful if move_queued_task() in core.c was given external
linkage, as it actually can be used to migrate any task to a CPU.

A follow-on patch will call move_queued_task() from fair.c when
migrating a task in a shared runqueue to a remote CPU.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c7db597e8175..167cd9f11ed0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2493,8 +2493,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
  *
  * Returns (locked) new rq. Old rq's lock is released.
  */
-static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-				   struct task_struct *p, int new_cpu)
+struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int new_cpu)
 {
 	lockdep_assert_rq_held(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 50d4b61aef3a..94846c947d6e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1759,6 +1759,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+
+extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu);
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct balance_callback *head,
-- 
2.40.1

