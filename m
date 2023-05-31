Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CD717F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjEaMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjEaMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22910E;
        Wed, 31 May 2023 05:04:51 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNwUXukSEl/JgYnsL6fJJ1J4br3SvY99FMxfaCaZ3Cc=;
        b=ak8GNogfuNVQNKbMkypBkrAkC7i2N5ysg6AERNmOG1xL9bMdPZITw8/jD4uSFZc//0XUDu
        +nLSrLsx5FCIuxiIh8vt7aAKT13ep21jAsZreTviMSxXRXpHg75T6VhT260Fe+CaWElPjY
        hrqb8yvJXqgNXpwlNNXl+ZtlUCltNP1Nl1VRYa9+1uuqmAtc8fEBpOuxEhKq9EBFOQR2wD
        6AA7yU7CS9h0X830qGzwe/bvXc9T684+VxaRupbNPxSWbGsy1muJ6k5TCF9nQIVoZ9yj4V
        Us9EQYXCaXTvyzpIhQBQ+yGOLxu21n9i/BTPTEG3HhsgwT8FdKwRepSK/Z3X6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNwUXukSEl/JgYnsL6fJJ1J4br3SvY99FMxfaCaZ3Cc=;
        b=2my4tOoarOyW6hz1DKRhNqMOuWC1U6c1qnlS5U59nXT36rJEqEB+OV/JGQySN0xR6/Ow0C
        K7kkkJpY0m6d2dDQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make task_vruntime_update() prototype visible
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522195021.3456768-5-arnd@kernel.org>
References: <20230522195021.3456768-5-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168553468933.404.13669678273109677886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f7df852ad6dbb84644e75df7402d9a34f39f31bd
Gitweb:        https://git.kernel.org/tip/f7df852ad6dbb84644e75df7402d9a34f39f31bd
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 May 2023 21:50:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:26 +02:00

sched: Make task_vruntime_update() prototype visible

Having the prototype next to the caller but not visible to the callee causes
a W=1 warning:

kernel/sched/fair.c:11985:6: error: no previous prototype for 'task_vruntime_update' [-Werror=missing-prototypes]

Move this to a header, as we do for all other function declarations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230522195021.3456768-5-arnd@kernel.org
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 192e781..ce07782 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1245,6 +1245,7 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			bool fi);
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
