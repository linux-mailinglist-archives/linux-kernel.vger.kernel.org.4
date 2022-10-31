Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670E3613409
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJaKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJaKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:54:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A1B1E;
        Mon, 31 Oct 2022 03:54:02 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:54:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667213641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hov2Y61IE84s9ZxCrB09rbK/g7ijp4Z6517H7xL3HbM=;
        b=iQL1H0lSl+AewlbcpUgIKu++1odlbofZJjOAICS7cdO6Mynd7pHN+gVM2bfSlL6/+QZIee
        1ju0rexJqeTtG+RLn1obcqsIOxinqGnB0Z+7ZwwvdlDRBvpxdMdmnzXa10CbOkumggvkG9
        i/WZRG5ubu4TVWIFKl2UPHFLtoHPKJdI+UQUSTQod3cMMafjDvVYnXCYrUojMW6YbxZ4QB
        LeBx9F41+19TCRTEB4qZL+9MjpM8vxv7IPg5bVhC9motuI52xS8Ai5d7PR7CfjGxdZLMwU
        bZZE00W15h/XKTi5TwCP1MUBi3pVqGnRsy25CkcgnIzXPxR7kBKWe1VDQ78N3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667213641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hov2Y61IE84s9ZxCrB09rbK/g7ijp4Z6517H7xL3HbM=;
        b=BfZxjJPD7dyF1Ys8Rg2+EO86EsPbi0jAiGDcdtmgcUR/Ecwr6ItAH45wigF9wzQ6E4xYG+
        fYhdpmo1/qPv1WCA==
From:   "tip-bot2 for Hao Lee" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Fix possible missing or delayed pending event
Cc:     Hao Lee <haolee.swjtu@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220919072356.GA29069@haolee.io>
References: <20220919072356.GA29069@haolee.io>
MIME-Version: 1.0
Message-ID: <166721364005.7716.252588638039192570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e38f89af6a13e895805febd3a329a13ab7e66fa4
Gitweb:        https://git.kernel.org/tip/e38f89af6a13e895805febd3a329a13ab7e66fa4
Author:        Hao Lee <haolee.swjtu@gmail.com>
AuthorDate:    Mon, 19 Sep 2022 07:23:56 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 30 Oct 2022 10:12:13 +01:00

sched/psi: Fix possible missing or delayed pending event

When a pending event exists and growth is less than the threshold, the
current logic is to skip this trigger without generating event. However,
from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
our purpose is to generate event as long as pending event exists and the
rate meets the limit, no matter what growth is.
This patch handles this case properly.

Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/r/20220919072356.GA29069@haolee.io
---
 kernel/sched/psi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee2ecc0..7f40d87 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -539,10 +539,12 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
-			if (growth < t->threshold)
-				continue;
+			if (!t->pending_event) {
+				if (growth < t->threshold)
+					continue;
 
-			t->pending_event = true;
+				t->pending_event = true;
+			}
 		}
 		/* Limit event signaling to once per window */
 		if (now < t->last_event_time + t->win.size)
