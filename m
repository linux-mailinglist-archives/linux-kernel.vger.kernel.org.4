Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283986BBD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjCOTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjCOToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90611656
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h19so1348214qtn.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkEQfoeE/r4WLsh8kNGxAmPOHd334+QHCg51Sh3MFAg=;
        b=NsbVHBk5ucAJrVO0iXKlJhOtGw18iXzyZV1oDL1C6C9ke9qWst/j13WDaObekR3JVD
         Gy9u/S/7VpT3P5tCkuY6pVAwD/NlOuk1Bc2MzuzCcDgDBgAzUFWtF30KYky7wh+DeyGP
         13pEof4SKJJFM4rs5V9fWt8k7WF0aESemcz5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkEQfoeE/r4WLsh8kNGxAmPOHd334+QHCg51Sh3MFAg=;
        b=KGg40vZH6icYwlvgRJonZHR4m1mQulrONYRgRGofTCHuJBwB2kdcO0QOzMqSRTUodi
         SSJVicD5RibAeUZpH0/5ELqoY+DY0fkKgjRZp2ZBydE1qpqXAsqJ3lt1IBV186rdqsKM
         otbGxqznqzBgFWuyEIAPGrB5wFuBBMNkQOueDMCDGpcTGSuz5ho55pD/GRWSxMv+5bhy
         p73AqmImZSWFfDAHQ3EIYQNbOu1s6NBmtarBens31mNYJKlsYsTsf/rMFuUz/6We/fe1
         WnGa74W+8nXknHTKQztdbc6MHK2rXfX1UWgtJyW/3Y8WmPzcLqx83+vEH/CDTnstV/kr
         +QQg==
X-Gm-Message-State: AO0yUKWdDJ6hepmUu0O63i+ue3tEHkS0YchDHUCAndy8tBBpKnD1WL4+
        BQ6TDKgVXmazRWx9rtDrg49TVsfGJ9NOaIwbZrY=
X-Google-Smtp-Source: AK7set87TN90zTjswPmh23ha4S78TEp/JYPKvpz4ikG3zVciZIpLuNLY8UNZ76VIsZa7RedJVwLGiw==
X-Received: by 2002:a05:622a:180d:b0:3bf:e2f8:c6a4 with SMTP id t13-20020a05622a180d00b003bfe2f8c6a4mr1984193qtc.61.1678909471190;
        Wed, 15 Mar 2023 12:44:31 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/9] entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up
Date:   Wed, 15 Mar 2023 19:43:43 +0000
Message-Id: <20230315194349.10798-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

RCU sometimes needs to perform a delayed wake up for specific kthreads
handling offloaded callbacks (RCU_NOCB).  These wakeups are performed
by timers and upon entry to idle (also to guest and to user on nohz_full).

However the delayed wake-up on kernel exit is actually performed after
the thread flags are fetched towards the fast path check for work to
do on exit to user. As a result, and if there is no other pending work
to do upon that kernel exit, the current task will resume to userspace
with TIF_RESCHED set and the pending wake up ignored.

Fix this with fetching the thread flags _after_ the delayed RCU-nocb
kthread wake-up.

Fixes: 47b8ff194c1f ("entry: Explicitly flush pending rcuog wakeup before last rescheduling point")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/entry/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 846add8394c4..a134e26b58c6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -192,13 +192,14 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = read_thread_flags();
+	unsigned long ti_work;
 
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
+	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

