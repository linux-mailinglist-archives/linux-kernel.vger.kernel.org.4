Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C71870C9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjEVTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjEVTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D1C1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21DA362AF9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC0FC4339B;
        Mon, 22 May 2023 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684785044;
        bh=DHB3E3whHUuZqeuu1DX7URmHv9V7oPFeShT/zXTe+DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTCRW8mvE+v+Qu9tfP6jNx3wcAib4AscGGz4Yi3vX0P6du6+fNQkfijJ4gOBxUEKV
         ZtPnFk9Dp7WlkzMvR/pj6r+WRzYXOpj6du4PA9p1dNnC21g4h5MhBqQF18eMM/otmD
         a6XRLVpIfXIsOvU3jIU0timMeTB/HBUDeNhW4OxfyQKctWeMgQD52yYGU7L3NGVUgI
         eZOXGbIiXYSC7Bn/CxAkj1A8L7FM754F756W9iiwwRdDOUpC86ogUwrTw/a83Bb0cS
         zpBzW+Ge7GZOtaQTDxMdtUE0NsMQ+M5JCA7WQvAlIzIVqJGiPW7JJdtaCRUkFKyKDW
         9W56i/cl8X8Iw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sched: make task_vruntime_update() prototype visible
Date:   Mon, 22 May 2023 21:50:20 +0200
Message-Id: <20230522195021.3456768-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522195021.3456768-1-arnd@kernel.org>
References: <20230522195021.3456768-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Having the prototype next to the caller but not visible to the callee causes
a W=1 warning:

kernel/sched/fair.c:11985:6: error: no previous prototype for 'task_vruntime_update' [-Werror=missing-prototypes]

Move this to a header, as we do for all other function declarations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/core.c  | 2 --
 kernel/sched/sched.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 044bcdf4181a..aae6ff717c55 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6030,8 +6030,6 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	BUG(); /* The idle class should always have a runnable task. */
 }
 
-extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
-
 static void queue_core_balance(struct rq *rq);
 
 static struct task_struct *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 44b34836bb60..d5ac0af1eede 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1245,6 +1245,7 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			bool fi);
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
-- 
2.39.2

