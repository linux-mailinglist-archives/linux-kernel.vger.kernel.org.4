Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B70692FFC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBKKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBKKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:30:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B112006B;
        Sat, 11 Feb 2023 02:30:55 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:30:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxaQ+e28M8FkH0NNi2WoKjdyfNU63nRcy/3GdI0r6gE=;
        b=ckGbY90VZaKmE3wfqcrQhzkyijIoNGa9lT05m05BbJKTc8kkAQ0vk4z4STi1wwJ2dXTkw/
        gPm8s6W6zBSMVFPzSlSU9LQYC199T2Tt/cxG+l5RexN0FGPup7mb8DUFI2R6Oeqij3h3Fs
        3hTeKCb1KmYwr6tADhEfxYTivETkJsEh9MtPKnBuumEDFSrpkrAN4RoSeW23mBjuQRtrAu
        nlxbSdhpeuw8VunuDVECOGOaCItutjwamYHVliIcV5K/3Y3OA5LzCQ9grsXF5XWHutZccK
        nCeNelEA1I9Dp6N1WIBB0uLeCv/1PDXKda+rC/vrAU5cjvmadXAOnFZbq1Uv9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxaQ+e28M8FkH0NNi2WoKjdyfNU63nRcy/3GdI0r6gE=;
        b=zkUB6WUs314h821Etws0nGquw49t5pEFLuMxwZFgD47NHx8x9hZOlyFji19ddl0SIxG3HX
        MN0LSw9373zOV1Aw==
From:   "tip-bot2 for Pietro Borrello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: pick_next_rt_entity(): check list_entry
Cc:     Pietro Borrello <borrello@diag.uniroma1.it>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
References: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
MIME-Version: 1.0
Message-ID: <167611145334.4906.4760858235156037814.tip-bot2@tip-bot2>
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

Commit-ID:     7c4a5b89a0b5a57a64b601775b296abf77a9fe97
Gitweb:        https://git.kernel.org/tip/7c4a5b89a0b5a57a64b601775b296abf77a9fe97
Author:        Pietro Borrello <borrello@diag.uniroma1.it>
AuthorDate:    Mon, 06 Feb 2023 22:33:54 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:10 +01:00

sched/rt: pick_next_rt_entity(): check list_entry

Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
removed any path which could make pick_next_rt_entity() return NULL.
However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
pick_next_rt_entity()) still checks the error condition, which can
never happen, since list_entry() never returns NULL.
Remove the BUG_ON check, and instead emit a warning in the only
possible error condition here: the queue being empty which should
never happen.

Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it
---
 kernel/sched/rt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e..0a11f44 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1777,6 +1777,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
+	if (SCHED_WARN_ON(list_empty(queue)))
+		return NULL;
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
 	return next;
@@ -1789,7 +1791,8 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 
 	do {
 		rt_se = pick_next_rt_entity(rt_rq);
-		BUG_ON(!rt_se);
+		if (unlikely(!rt_se))
+			return NULL;
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 
