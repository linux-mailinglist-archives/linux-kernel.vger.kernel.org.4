Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DA7002E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbjELImw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:42:51 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087334682
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:42:48 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QHj2H0Jlwz4xVnD;
        Fri, 12 May 2023 16:42:47 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 34C8gY0K061762;
        Fri, 12 May 2023 16:42:34 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 12 May 2023 16:42:36 +0800 (CST)
Date:   Fri, 12 May 2023 16:42:36 +0800 (CST)
X-Zmail-TransId: 2b09645dfbfcffffffffe41-05941
X-Mailer: Zmail v1.0
Message-ID: <202305121642367753446@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@redhat.com>, <peterz@infradead.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
Cc:     <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1JFU0VORCBQQVRDSCBsaW51eC1uZXh0XSBzY2hlZC9wc2k6IGF2b2lkIHJlc2V0dGluZyB0aGUgbWluIHVwZGF0ZSBwZXJpb2Qgd2hlbiBpdCBpcyB1bm5lY2Vzc2FyeQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 34C8gY0K061762
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 645DFC07.000/4QHj2H0Jlwz4xVnD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Psi_group's poll_min_period is determined by the minimum window size of
psi_trigger when creating new triggers. While destroying a psi_trigger, there
is no need to reset poll_min_period if the psi_trigger being destroyed did not
have the minimum window size, since in this condition poll_min_period will
remain the same as before.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Acked-by: Suren Baghdasaryan <surenb@google.com>
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
