Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC6C5B3A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiIIOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiIIOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF570E6A;
        Fri,  9 Sep 2022 07:00:19 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFW6rOIw7Qa8iZxgmaZemOWrqa/oseCvV3gamlcb+34=;
        b=dJ4yTLU3njZuKUCFlGF5gNjdn/n+gGbDO9dQ2zSslOF1iuY4pZtRCazvTj0ZzEtuj693ji
        Dcf1pVUF8j/6rrwo1tvQLXGZ3/rhvjspX38KkUAebzTTYeGJdZ1e2Vi7mQFJ/S8oHlB4XF
        08qIyYDyt1DPQ3XyUV2IKoajDAWExIaJj13atEPjDOLS1nR2T4HoGsviJxoDeKDH9q7KMk
        fPnk/3tmcmwf4Qe3g5D+7vGyGRmFSsmPva4v2j19UF6PZT5NhvP3C4GbNYkoUcQDxUYZhe
        6sWgZ77Yz/f3OykNgoHgUSw0vZljDU7FmGG0odF4zIazecm/i0wkJ/P9Uu35Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFW6rOIw7Qa8iZxgmaZemOWrqa/oseCvV3gamlcb+34=;
        b=xx+QlIWPd/lvXEf/wIufFiTX5vaPJWVtGt7CPsZnYkcLbg6qi5rKJykEzW8NqqmPUP0gRG
        dgvhIOVME0GRimCA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Save percpu memory when !psi_cgroups_enabled
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-4-zhouchengming@bytedance.com>
References: <20220825164111.29534-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201708.401.11559207827527564278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     e2ad8ab04c5cdfc8dc2f382c45d248ab01dee991
Gitweb:        https://git.kernel.org/tip/e2ad8ab04c5cdfc8dc2f382c45d248ab01dee991
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 26 Aug 2022 00:41:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:31 +02:00

sched/psi: Save percpu memory when !psi_cgroups_enabled

We won't use cgroup psi_group when !psi_cgroups_enabled, so don't
bother to alloc percpu memory and init for it.

Also don't need to migrate task PSI stats between cgroups in
cgroup_move_task().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220825164111.29534-4-zhouchengming@bytedance.com
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 39463dc..77d53c0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -201,6 +201,7 @@ void __init psi_init(void)
 {
 	if (!psi_enable) {
 		static_branch_enable(&psi_disabled);
+		static_branch_disable(&psi_cgroups_enabled);
 		return;
 	}
 
@@ -950,7 +951,7 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
 	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
@@ -968,7 +969,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 
 void psi_cgroup_free(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi->avgs_work);
@@ -996,7 +997,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (static_branch_likely(&psi_disabled)) {
+	if (!static_branch_likely(&psi_cgroups_enabled)) {
 		/*
 		 * Lame to do this here, but the scheduler cannot be locked
 		 * from the outside, so we move cgroups from inside sched/.
