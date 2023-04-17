Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884036E4246
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjDQIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDQIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:12:45 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CA558A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:12:06 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Q0KXF6Rhtz4xq1X;
        Mon, 17 Apr 2023 16:11:57 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 33H8BqU3072551;
        Mon, 17 Apr 2023 16:11:52 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 17 Apr 2023 16:11:54 +0800 (CST)
Date:   Mon, 17 Apr 2023 16:11:54 +0800 (CST)
X-Zmail-TransId: 2b03643cff4afffffffff01-c5680
X-Mailer: Zmail v1.0
Message-ID: <202304171611545861530@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <hannes@cmpxchg.org>, <surenb@google.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdwqBzY2hlZC9wc2k6IGF2b2lkwqB1bm5lY2Vzc2FyeSByZXNldHRpbmcgbWluIHVwZGF0ZSBwZXJpb2Qgd2hlbsKgZGVzdHJvecKgdHJpZ2dlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 33H8BqU3072551
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 643CFF4D.000/4Q0KXF6Rhtz4xq1X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang19@zte.com.cn>

Psi_group's poll_min_period is determined by the min window size of
psi_trigger when creating new triggers. While destroying a psi_trigger,
there is no need to reset poll_min_period if the destroying psi_trigger
not had the min windows size, since in this condition poll_min_period
will keep the same as before.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/sched/psi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 02e011cabe91..12869585cf89 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1359,11 +1359,16 @@ void psi_trigger_destroy(struct psi_trigger *t)
 		group->nr_triggers[t->state]--;
 		if (!group->nr_triggers[t->state])
 			group->poll_states &= ~(1 << t->state);
-		/* reset min update period for the remaining triggers */
-		list_for_each_entry(tmp, &group->triggers, node)
-			period = min(period, div_u64(tmp->win.size,
-					UPDATES_PER_WINDOW));
-		group->poll_min_period = period;
+		/*
+		 * Reset min update period for the remaining triggers iff the destroying
+		 * trigger had the min window size.
+		 */
+		if (group->poll_min_period == div_u64(t->win.size, UPDATES_PER_WINDOW)) {
+			list_for_each_entry(tmp, &group->triggers, node)
+				period = min(period, div_u64(tmp->win.size,
+						UPDATES_PER_WINDOW));
+			group->poll_min_period = period;
+		}
 		/* Destroy poll_task when the last trigger is destroyed */
 		if (group->poll_states == 0) {
 			group->polling_until = 0;
-- 
2.25.1
