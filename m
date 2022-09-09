Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91F5B32AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiIIJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIIJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703B2F656;
        Fri,  9 Sep 2022 02:00:28 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKxBRzTBO39X7z+tw1G9wam3BX1JCh/p5wIpxoQx8Qk=;
        b=xN/uJg6k8wQIYVn+djvv5tVcvQO196igPMYWvJ7HwiWzW1057NTwoZvyYVRvLQg2zE0RWb
        NkDMjS0fvq6eehNSLg4Pfmh/8RktrAlV5TJBBZ9aJdGWD1XWyQ7YT3o34gNPazpVh6LjjG
        L8bGvt8QbTyhw7DFwlu1YkhAHqn3FeHBLuip9r/no64n3pr/pc0sNM4Td87UJ3bzxatJaj
        oTP8bzyM57vHcApUaLGoIq3DYyXk6ig+GrUcQiKmaNwKsRnnuetWFcUPqJDzVjNR7RMjqg
        aXQaACNeYzOsb0lQRb92NRbUzPhFoxo3M6lM6g9EMIb6ZsMnYY/3CjQjNePajA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKxBRzTBO39X7z+tw1G9wam3BX1JCh/p5wIpxoQx8Qk=;
        b=2wR7iXSnCQbpvmqZqqC5evk0pi206J8DqkbGM2b9Zfo5q2xdDZ5WyAgQ4uHymKJD06/F58
        YLKl2iVx9Kp3IsAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Change wait_task_inactive()s match_state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822114648.856734578@infradead.org>
References: <20220822114648.856734578@infradead.org>
MIME-Version: 1.0
Message-ID: <166271402267.401.15571357891937074846.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9204a97f7ae862fc8a3330ec8335917534c3fb63
Gitweb:        https://git.kernel.org/tip/9204a97f7ae862fc8a3330ec8335917534c3fb63
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Aug 2022 13:18:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:48 +02:00

sched: Change wait_task_inactive()s match_state

Make wait_task_inactive()'s @match_state work like ttwu()'s @state.

That is, instead of an equal comparison, use it as a mask. This allows
matching multiple block conditions.

(removes the unlikely; it doesn't make sense how it's only part of the
condition)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220822114648.856734578@infradead.org
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1630181..43d71c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3294,7 +3294,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
+			if (match_state && !(READ_ONCE(p->__state) & match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3309,7 +3309,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || READ_ONCE(p->__state) == match_state)
+		if (!match_state || (READ_ONCE(p->__state) & match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
